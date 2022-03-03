// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import 'package:http/http.dart' as mahttp;

void main() {
  runApp(app());
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  String hasilR = "Belum Ada Datanya";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "HTTP -  POST",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          TextField(
            controller: nameC,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nama",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: jobC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Job",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              var maresp = await mahttp.post(
                Uri.parse("https://reqres.in/api/users"),
                body: {"name": nameC.text, "job": jobC.text},
              );

              Map<String, dynamic> data = json.decode(maresp.body) as Map<String, dynamic>;

              setState(() {
                hasilR = "${data['name']} - ${data['job']}";
              });

            },
            child: Text("SUBMIT"),
          ),
          SizedBox(
            height: 50,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Text(
            hasilR,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
