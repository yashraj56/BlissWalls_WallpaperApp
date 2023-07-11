import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WallpaperApp());
}

class WallpaperApp extends StatefulWidget {
  @override
  _WallpaperAppState createState() => _WallpaperAppState();
}

class _WallpaperAppState extends State<WallpaperApp> {
  String apiKey = 'iDjbtRbEroRAWa25rYeNpMUZPvCLnzIjUEIWslRzsQG9t3JzMYprs7Hl';
  String apiUrl = 'https://api.pexels.com/v1/search?query=nature&per_page=20';

  List<dynamic> wallpapers = [];

  @override
  void initState() {
    super.initState();
    fetchWallpapers();
  }

  Future<void> fetchWallpapers() async {
    var response =
    await http.get(Uri.parse(apiUrl), headers: {'Authorization': apiKey});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        wallpapers = data['photos'];
      });
    } else {
      print('Failed to fetch wallpapers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.only(top: 100, left: 16),
                    child: const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.only(top: 5, left: 16,bottom: 40),
                    child: const Text(
                      "Artistry for Your Screen",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.only(top: 10, left: 16,bottom: 10),
                    child: const Text(
                      "Trending",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: wallpapers.length < 5 ? wallpapers.length : 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    wallpapers[index]['src']['medium'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 60,
                          alignment: AlignmentDirectional.centerStart,
                          padding: const EdgeInsets.only(top: 30, left: 10),
                          child: const Text(
                            "Explore",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          child: GridView.builder(
                            padding: EdgeInsets.only(top: 8),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: wallpapers.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    wallpapers[index]['src']['medium'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
