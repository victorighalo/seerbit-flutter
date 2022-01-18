import 'dart:convert';
import 'dart:math';

import 'package:exampletwo/payload.dart';
import 'package:flutter/material.dart';

String initRequest(PayloadModel model, String reportLink, String x) {
  return """
                                  <!DOCTYPE html>
                    <html lang="en">
                            <head>
                                    <meta charset="UTF-8">
                                    <meta http-equiv="X-UA-Compatible" content="ie=edge">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <title>SeerBit</title>
                            </head>
                            <body  onload="paywithSeerbit()" style="background-color:#fff;height:100vh ">
                            <form>
                            <script src="https://checkout.seerbitapi.com/api/v2/seerbit.js"></script>
                             </form>
                             <script>
                             function paywithSeerbit() {
                              SeerbitPay(
                                {
                                  tranref: "${model.transRef}",
                                  currency: "${model.currency}",
                                  description: "${model.description}",
                                  country: "${model.country}",
                                  email:"hulu@netflix.com",
                                  amount: "${model.amount}",
                                  callbackurl: "${model.callbackUrl}",
                                  narrator:"seerbit-react-native",
                                  public_key: "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7"
                                  //"SBPUBK_1ZAL1HXRQQFKHSHXAQ91KGGWEEUXZK4I"
                                  // "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7"
                                  // replace this with your own public key
                                },
                                function callback(response) {
                                  // console.log(response);
                                  console.log(JSON.stringify(response)); /*response of transaction*/
                                   window.flutter_inappwebview
                                    .callHandler('success', JSON.stringify(response));
                                },
                                function close(close) {

                                  console.log(close); /*transaction close*/
                                   window.flutter_inappwebview
                                    .callHandler('failure', JSON.stringify(response));
                                }
                              );
                            }

                            </script>
                            </body>
                    </html>
                                  """;
}

Uri createUri(pAYL) {
  return Uri.dataFromString(initRequest(payload, "==", ''),
      encoding: Encoding.getByName('utf-8'), mimeType: 'text/html');
}

PayloadModel payload = PayloadModel(
    currency: 'NGN',
    email: "hello@gmail.com",
    description: "Sneakers",
    fullName: "General Zod",
    country: "NG",
    amount: "100",
    transRef: Random().nextInt(500000).toString(),
    callbackUrl: "callbackUrl",
    publicKey: "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7",
    pocketRef: "",
    vendorId: "Freedah");

///Creates a simple snackbr
void displaySnack(BuildContext context,
    {String? text,
    Color? color,
    Function()? onPressed,
    Color textColor = Colors.white}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 40,
    content: Text(
      text!,
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 2),
  ));
}
