// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'app_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AppBrain appBrain = AppBrain();

void main() {
  runApp(ExamApp());
}

class ExamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 150, 180, 196),
        body: Padding(padding:const EdgeInsets.all(15.0) ,)
        
        ),
  
    );
  }
}

class ExamPage extends StatefulWidget {
  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int rightAnswer = 0;
  void checkAnswer(bool whatUserPiched) {
    bool correctAnswer = appBrain.getQuestionAnswer();
    setState(() {
      if (whatUserPiched == correctAnswer) {
        rightAnswer++;
      }
      if (appBrain.isFinished() == true) {
        Alert(
          context: context,
          title:
              "If you answered false to some of the questions above, and if these symptoms are having a negative impact on your usual routine or other important areas of your life, this could mean you’re facing some challenges.",
          desc: "You got $rightAnswer / 10 ",
          buttons: [
            DialogButton(
              child: Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();

        appBrain.reset();
        rightAnswer = 0;
      } else {
        appBrain.nextQuestion();
      }
    });
  }

  get index => null;
  @override
  Widget build(BuildContext context) {
    var question;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
              ),
              Text(
                appBrain.getQuestionText(),
                style: TextStyle(
                    color: Color.fromARGB(149, 20, 14, 14),
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(149, 20, 14, 14),
                minimumSize: Size(50, 80),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              child: Text(
                'Yes',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Color.fromARGB(255, 254, 255, 254),
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(149, 20, 14, 14),
                minimumSize: Size(50, 80),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              child: Text(
                'No',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Color.fromARGB(255, 254, 255, 254),
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 189.0,
              ),
              Text(
                'Your privacy is important to us. All results are completely anonymous.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(149, 20, 14, 14),
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
