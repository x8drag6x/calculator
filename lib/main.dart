import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'ماشین حساب', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String display = '0';
  String expression = "";
  void addNumber(String number) {
    setState(() {
      if (display == "0") {
        display = number;
      } else {
        display += number;
      }
    });
  }

  double result = 0;
  String currentOperator = "";
  double calculate(double first, double sec, String operator) {
    switch (operator) {
      case "+":
        return first + sec;
      case "-":
        return first - sec;
      case "*":
        return first * sec;
      case "/":
        return first / sec;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Container(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(display, style: TextStyle(fontSize: 36)),
            ),
            Buttoms(
              label1: "AC",
              onTab1: () {
                setState(() {
                  display = "0";
                  expression = "";
                  currentOperator = "";
                });
              },
              label2: "Del",
              onTab2: () {
                setState(() {
                  if (display.length > 1) {
                    display = display.substring(0, display.length - 1);
                    if (display == "-") {
                      display = "0";
                    }
                  } else {
                    display = "0";
                  }
                });
              },
              label3: "%",
              onTab3: () {},
              label4: "/",
              onTab4: () {
                setState(() {
                  expression += display + "/";
                  display = "0";
                  currentOperator = "/";
                });
              },
            ),
            Buttoms(
              label1: "7",
              onTab1: () {
                addNumber("7");
              },
              label2: "8",
              onTab2: () {
                addNumber("8");
              },
              label3: "9",
              onTab3: () {
                addNumber("9");
              },
              label4: "*",
              onTab4: () {
                setState(() {
                  expression += display + "*";
                  display = "0";
                  currentOperator = "*";
                });
              },
            ),
            Buttoms(
              label1: "4",
              onTab1: () {
                addNumber("4");
              },
              label2: "5",
              onTab2: () {
                addNumber("5");
              },
              label3: "6",
              onTab3: () {
                addNumber("6");
              },
              label4: "-",
              onTab4: () {
                setState(() {
                  expression += display + "-";
                  display = "0";
                  currentOperator = "-";
                });
              },
            ),
            Buttoms(
              label1: "1",
              onTab1: () {
                addNumber("1");
              },
              label2: "2",
              onTab2: () {
                addNumber("2");
              },
              label3: "3",
              onTab3: () {
                addNumber("3");
              },
              label4: "+",
              onTab4: () {
                setState(() {
                  expression += display + "+";
                  display = "0";
                  currentOperator = "+";
                });
              },
            ),
            Buttoms(
              label1: "+-",
              onTab1: () {
                setState(() {
                  if (display.startsWith("-")) {
                    display = display.substring(1);
                  } else if (display == "0") {
                    display = "0";
                  } else {
                    display = "-" + display;
                  }
                });
              },
              label2: "0",
              onTab2: () {
                addNumber("0");
              },
              label3: ".",
              onTab3: () {
                setState(() {
                  if (display.contains(".")) {
                } else {
                  if (display.contains(".")){

                  }else if (display == "0"){
                    display = "0.";
                  }else{
                    
                  addNumber(".");
                  }
                }
                });
              },
              label4: "=",
              onTab4: () {
                setState(() {
                  String fullExpression = expression + display;
                  if (currentOperator.isEmpty){
                      display = "ERROR";
                      expression = "";
                      currentOperator = "";
                  }else{
                  int operatorIndex = fullExpression.indexOf(currentOperator);
                  if (operatorIndex == -1) {
                    display = "ERROR";
                    expression = "";
                    currentOperator = "";
                  } else {
                    String firstPart = fullExpression.substring(
                      0,
                      operatorIndex,
                    );
                    String secondPart = fullExpression.substring(
                      operatorIndex + 1,
                    );
                    if (firstPart.isEmpty || secondPart.isEmpty) {
                      display = "ERROR";
                      expression = "";
                      currentOperator = "";
                    } else {
                      double? firstNumber = double.tryParse(firstPart);
                      double? secondNumber = double.tryParse(secondPart);
                      if(firstNumber == null || secondNumber == null){
                      display = "ERROR";
                      expression = "";
                      currentOperator = "";
                      }else{
                      if (secondNumber == 0 && currentOperator == "/") {
                        display = "ERROR";
                        expression = "";
                        currentOperator = "";
                      } else {
                        double answer = calculate(
                          firstNumber,
                          secondNumber,
                          currentOperator,
                        );
                        display = answer.toString();
                        expression = "";
                        currentOperator = "";
                      }
                    }}
                  }
                }});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Buttoms extends StatelessWidget {
  const Buttoms({
    super.key,
    required this.label1,
    required this.onTab1,
    required this.label2,
    required this.onTab2,
    required this.label3,
    required this.onTab3,
    required this.label4,
    required this.onTab4,
  });
  final String label1;
  final VoidCallback onTab1;
  final String label2;
  final VoidCallback onTab2;
  final String label3;
  final VoidCallback onTab3;
  final String label4;
  final VoidCallback onTab4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(onPressed: onTab1, child: Text(label1)),
          ),
          Expanded(
            child: ElevatedButton(onPressed: onTab2, child: Text(label2)),
          ),
          Expanded(
            child: ElevatedButton(onPressed: onTab3, child: Text(label3)),
          ),
          Expanded(
            child: ElevatedButton(onPressed: onTab4, child: Text(label4)),
          ),
        ],
      ),
    );
  }
}
