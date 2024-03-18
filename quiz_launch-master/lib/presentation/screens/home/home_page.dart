import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/colors.dart';
import 'package:quiz_app/gen/assets.gen.dart';
import 'package:quiz_app/gen/fonts.gen.dart';
import 'package:quiz_app/presentation/screens/controller/addcategegory_controller.dart';

import 'package:quiz_app/presentation/screens/controller/recentquiz_controller.dart';
import 'package:quiz_app/presentation/screens/controller/user_controller.dart';
import 'package:quiz_app/presentation/screens/createquiz/add_cateragory.dart';
import 'package:quiz_app/presentation/screens/home/home_constraints.dart';
import 'package:quiz_app/presentation/screens/models/addcategaries_models.dart';
import 'package:quiz_app/presentation/widgets/common_ui_bg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<addcategaryController>(addcategaryController());
    final quizController = Get.put<recentquizController>(recentquizController());
    List<Addcategorymodel> userList = controller.userList;

    @override
    void initState() {
      super.initState();
      quizController.getrecent(); // Fetch recent quiz data
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          HomeConstaints.appBar,
          style: TextStyle(
            fontFamily: FontFamily.rubik,
            fontSize: 18,
            color: Colours.CardColour,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colours.CardColour,
        backgroundColor: Colours.primaryColor,
      ),
      backgroundColor: Colours.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // First card with decreased size
            FractionallySizedBox(
              widthFactor: 0.9,
              // Adjust this value to decrease the width
              child: Card(
                color: Colours.homeCard, // Example color, you can change it
                child: ListTile(
                  title: Text(
                    HomeConstaints.cardtext1,
                    style: TextStyle(
                      fontFamily: FontFamily.rubik,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.headphones_rounded, color: Colours.homeCardtext),
                      SizedBox(width: 8),
                      Obx(() {
                        if (quizController.isLoading.value) {
                          return CircularProgressIndicator(); // Show loading indicator while data is loading
                        } else {
                          // Display recent quiz data if available
                          return Text(
                            quizController.userList.isNotEmpty ? quizController.userList[0].name ?? "" : "",
                            style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                  trailing: Image.asset(Assets.images.percentagecal.path),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Second card with decreased size
            FractionallySizedBox(
              widthFactor: 0.9,
              // heightFactor: 0.2,/// Adjust this value to decrease the width
              child: Card(
                color: Colours.homeCard2, // Example color, you can change it
                child: ListTile(
                  leading: Image.asset(Assets.images.boy.path),
                  title: Text(HomeConstaints.cardtext3, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.rubik, color: Colours.CardColour)),
                  subtitle: Column(
                    children: [
                      Text(HomeConstaints.cardtext4, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: FontFamily.rubik, color: Colours.CardColour)),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: (){},
                        child: Text(
                          HomeConstaints.buttomText,
                          style: TextStyle(
                            color: Colours.primaryColor,
                            fontFamily: FontFamily.rubik,
                            fontSize: 14,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colours.CardColour,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                        )
                      )
                    ],
                  ),
                  trailing: Image.asset(Assets.images.girl.path),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Third card with full width
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 24,right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment to separate the title and button
                            children: [
                              Text(
                                HomeConstaints.title,
                                style: TextStyle(fontSize: 20, fontFamily: FontFamily.rubik, fontWeight: FontWeight.w500),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  HomeConstaints.buttomText2,
                                  style: TextStyle(fontFamily: FontFamily.rubik, fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => quizController.isLoading.value
                              ? CircularProgressIndicator()
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: userList.length,
                                    itemBuilder: (_, index) {
                                      return ListTile(
                                        title: Text('${userList[index].category}'),
                                        subtitle: Row(
                                          children: [
                                            Text('${userList[index].subCategory}'),
                                            SizedBox(width: 20),
                                            Text('${userList[index].noOfQuizzes.toString()}'),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddCategaryPage());
        },
        child: Icon(Icons.add),
        backgroundColor: Colours.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colours.primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colours.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
