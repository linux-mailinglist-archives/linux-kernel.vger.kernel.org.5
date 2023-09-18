Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3EA7A45E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjIRJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbjIRJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:28:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A47118;
        Mon, 18 Sep 2023 02:28:49 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38I9S5Nq81942313, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38I9S5Nq81942313
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 17:28:05 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 18 Sep 2023 17:28:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 18 Sep 2023 17:28:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Mon, 18 Sep 2023 17:28:03 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Eric Dumazet <edumazet@google.com>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "bjorn@mork.no" <bjorn@mork.no>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next resend 1/2] r8152: remove queuing rx packets in driver
Thread-Topic: [PATCH net-next resend 1/2] r8152: remove queuing rx packets in
 driver
Thread-Index: AQHZ6gOv5dotXJafx06AY5ZZ4fOWz7AfsJgAgACIv9D//4eLAIAAi13g
Date:   Mon, 18 Sep 2023 09:28:03 +0000
Message-ID: <e3ad16c0e8414af6be25f4bf9ab5e1e3@realtek.com>
References: <20230918074202.2461-426-nic_swsd@realtek.com>
 <20230918074202.2461-427-nic_swsd@realtek.com>
 <CANn89iJmdkyn8_hU4esycRG-XvPa_Djsp6PyaOX5cYP1Obdr4g@mail.gmail.com>
 <7235821eb09242adaa651172729f76aa@realtek.com>
 <CANn89i+Tou=YwteEd5ceaHP54sZpkRotwcV6YWAs4jAUq=ocJg@mail.gmail.com>
In-Reply-To: <CANn89i+Tou=YwteEd5ceaHP54sZpkRotwcV6YWAs4jAUq=ocJg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiBTZW50OiBNb25kYXksIFNlcHRl
bWJlciAxOCwgMjAyMyA0OjUzIFBNDQpbLi4uXQ0KPiA+ID4gWzFdIE1vcmUgY29udmVudGlvbmFs
IHdheSB0byB0byBwdXQgdGhpcyBjb25kaXRpb24gYXQgdGhlIGJlZ2lubmluZyBvZg0KPiA+ID4g
dGhlIHdoaWxlICgpIGxvb3AsDQo+ID4gPiBiZWNhdXNlIHRoZSBidWRnZXQgY291bGQgYmUgemVy
by4NCj4gPg0KPiA+IElmIHRoZSBidWRnZXQgaXMgemVybywgdGhlIGZ1bmN0aW9uIHdvdWxkbid0
IGJlIGNhbGxlZC4NCj4gPiBhN2I4ZDYwYjM3MjMgKCJyODE1MjogY2hlY2sgYnVkZ2V0IGZvciBy
ODE1Ml9wb2xsIikgYXZvaWRzIGl0Lg0KPiANCj4gWWVzLCBhbmQgd2UgY291bGQgcmV2ZXJ0ICB0
aGlzIHBhdGNoIDovDQo+IA0KPiBNb3ZpbmcgdGhlIHRlc3QgYXQgdGhlIGZyb250IG9mIHRoZSBs
b29wIGxpa2UgbW9zdCBvdGhlciBkcml2ZXJzIHdvdWxkDQo+IGhhdmUgYXZvaWRlZCB0aGlzIGlz
c3VlLA0KPiBhbmQgYXZvaWRlZCB0aGlzIGRpc2N1c3Npb24uDQoNCkkgZG9uJ3QgZG8gdGhhdCBi
ZWNhdXNlIEkgd2FudCB0byBhdm9pZCBzb21lIGNoZWNrcyBhbmQgc3BpbiBsb2NrIGJlZm9yZSBh
bmQgYWZ0ZXINCnRoZSBsb29wLiBGb3IgZXhhbXBsZSwNCg0KMS4gc3BpbiBsb2NrDQoyLiBtb3Zl
IHRoZSByZWFkeSBsaXN0cyB0byBsb2NhbA0KMy4gc3BpbiB1bmxvY2sNCjQuIGxvb3AgdGhlIGxp
c3RzDQo1LiBicmVhayB0aGUgbG9vcCBpZiBidWRnZXQgaXMgemVybw0KNi4gc3BpbiBsb2NrDQo3
LiBtb3ZlIHRoZSByZW1haW5lZCBsaXN0IGJhY2sgZm9yIG5leHQgc2NoZWR1bGUNCjguIHNwaW4g
dW5sb2NrDQoNCkkgY291bGQgYXZvaWQgdGhlIHJlZHVuZGFudCBiZWhhdmlvci4NCg0KPiA+ID4g
PiArICAgICAgICAgICAgICAgaWYgKHdvcmtfZG9uZSA+PSBidWRnZXQpDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gPiAgICAgICAgIH0NCj4gPiA+ID4NCj4g
PiA+ID4gKyAgICAgICAvKiBTcGxpY2UgdGhlIHJlbWFpbmVkIGxpc3QgYmFjayB0byByeF9kb25l
ICovDQo+ID4gPiA+ICAgICAgICAgaWYgKCFsaXN0X2VtcHR5KCZyeF9xdWV1ZSkpIHsNCj4gPiA+
ID4gICAgICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZ0cC0+cnhfbG9jaywgZmxhZ3Mp
Ow0KPiA+ID4gPiAtICAgICAgICAgICAgICAgbGlzdF9zcGxpY2VfdGFpbCgmcnhfcXVldWUsICZ0
cC0+cnhfZG9uZSk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBsaXN0X3NwbGljZSgmcnhfcXVl
dWUsICZ0cC0+cnhfZG9uZSk7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZ0cC0+cnhfbG9jaywgZmxhZ3MpOw0KPiA+ID4gPiAgICAgICAgIH0NCj4gPiA+
ID4NCj4gPiA+ID4gIG91dDE6DQo+ID4gPiA+IC0gICAgICAgcmV0dXJuIHdvcmtfZG9uZTsNCj4g
PiA+ID4gKyAgICAgICBpZiAod29ya19kb25lID4gYnVkZ2V0KQ0KPiA+ID4NCj4gPiA+IFRoaXMg
KHdvcmtfZG9uZSA+YnVkZ2V0KSBjb25kaXRpb24gd291bGQgbmV2ZXIgYmUgdHJ1ZSBpZiBwb2lu
dCBbMV0gaXMNCj4gPiA+IGFkZHJlc3NlZC4NCj4gPg0KPiA+IEEgYnVsayB0cmFuc2ZlciBtYXkg
Y29udGFpbiBtYW55IHBhY2tldHMsIHNvIHRoZSB3b3JrX2RvbmUgbWF5IGJlIG1vcmUNCj4gdGhh
biBidWRnZXQuDQo+ID4gVGhhdCBpcyB3aHkgSSBxdWV1ZSB0aGUgcGFja2V0cyBpbiB0aGUgZHJp
dmVyIGJlZm9yZSB0aGlzIHBhdGNoLg0KPiA+IEZvciBleGFtcGxlLCBpZiBhIGJ1bGsgdHJhbnNm
ZXIgY29udGFpbnMgNzAgcGFja2V0IGFuZCBidWRnZXQgaXMgNjQsDQo+ID4gbmFwaV9ncm9fcmVj
ZWl2ZSB3b3VsZCBiZSBjYWxsZWQgZm9yIHRoZSBmaXJzdCA2NCBwYWNrZXRzIGFuZCA2IHBhY2tl
dHMNCj4gd291bGQNCj4gPiBiZSBxdWV1ZWQgaW4gZHJpdmVyIGZvciBuZXh0IHNjaGVkdWxlLiBB
ZnRlciB0aGlzIHBhdGNoLCBuYXBpX2dyb19yZWNlaXZlKCkNCj4gd291bGQNCj4gPiBiZSBjYWxs
ZWQgZm9yIHRoZSA3MCBwYWNrZXRzLCBldmVuIHRoZSBidWRnZXQgaXMgNjQuIEFuZCB0aGUgcmVt
YWluZWQgYnVsaw0KPiB0cmFuc2ZlcnMNCj4gPiB3b3VsZCBiZSBoYW5kbGVkIGZvciBuZXh0IHNj
aGVkdWxlLg0KPiANCj4gQSBjb21tZW50IHdvdWxkIGJlIG5pY2UuIE5BUEkgbG9naWMgc2hvdWxk
IGxvb2sgdGhlIHNhbWUgaW4gYWxsIGRyaXZlcnMuDQo+IA0KPiBJZiBhIGRyaXZlciBoYXMgc29t
ZSBwZWN1bGlhcml0aWVzLCBjb21tZW50cyB3b3VsZCBoZWxwIHRvIG1haW50YWluDQo+IHRoZSBj
b2RlIGluIHRoZSBsb25nIHJ1bi4NCg0KSSB3b3VsZCB1cGRhdGUgaXQuIFRoYW5rcy4NCg0KQmVz
dCBSZWdhcmRzLA0KSGF5ZXMNCg0KDQo=
