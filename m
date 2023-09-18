Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE627A44F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjIRIk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjIRIkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:40:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE2E4;
        Mon, 18 Sep 2023 01:39:54 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38I8dEjO51893931, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38I8dEjO51893931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 16:39:14 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 18 Sep 2023 16:38:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 18 Sep 2023 16:38:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Mon, 18 Sep 2023 16:38:31 +0800
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
Thread-Index: AQHZ6gOv5dotXJafx06AY5ZZ4fOWz7AfsJgAgACIv9A=
Date:   Mon, 18 Sep 2023 08:38:31 +0000
Message-ID: <7235821eb09242adaa651172729f76aa@realtek.com>
References: <20230918074202.2461-426-nic_swsd@realtek.com>
 <20230918074202.2461-427-nic_swsd@realtek.com>
 <CANn89iJmdkyn8_hU4esycRG-XvPa_Djsp6PyaOX5cYP1Obdr4g@mail.gmail.com>
In-Reply-To: <CANn89iJmdkyn8_hU4esycRG-XvPa_Djsp6PyaOX5cYP1Obdr4g@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
bWJlciAxOCwgMjAyMyAzOjU1IFBNDQpbLi4uXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IHVyYi0+YWN0dWFsX2xlbmd0aCA9IDA7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgbGlz
dF9hZGRfdGFpbCgmYWdnLT5saXN0LCBuZXh0KTsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+
ICsNCj4gPiArICAgICAgICAgICAgICAgLyogQnJlYWsgaWYgYnVkZ2V0IGlzIGV4aGF1c3RlZC4g
Ki8NCj4gDQo+IFsxXSBNb3JlIGNvbnZlbnRpb25hbCB3YXkgdG8gdG8gcHV0IHRoaXMgY29uZGl0
aW9uIGF0IHRoZSBiZWdpbm5pbmcgb2YNCj4gdGhlIHdoaWxlICgpIGxvb3AsDQo+IGJlY2F1c2Ug
dGhlIGJ1ZGdldCBjb3VsZCBiZSB6ZXJvLg0KDQpJZiB0aGUgYnVkZ2V0IGlzIHplcm8sIHRoZSBm
dW5jdGlvbiB3b3VsZG4ndCBiZSBjYWxsZWQuDQphN2I4ZDYwYjM3MjMgKCJyODE1MjogY2hlY2sg
YnVkZ2V0IGZvciByODE1Ml9wb2xsIikgYXZvaWRzIGl0Lg0KDQo+ID4gKyAgICAgICAgICAgICAg
IGlmICh3b3JrX2RvbmUgPj0gYnVkZ2V0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICAvKiBTcGxpY2UgdGhlIHJlbWFp
bmVkIGxpc3QgYmFjayB0byByeF9kb25lICovDQo+ID4gICAgICAgICBpZiAoIWxpc3RfZW1wdHko
JnJ4X3F1ZXVlKSkgew0KPiA+ICAgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmdHAt
PnJ4X2xvY2ssIGZsYWdzKTsNCj4gPiAtICAgICAgICAgICAgICAgbGlzdF9zcGxpY2VfdGFpbCgm
cnhfcXVldWUsICZ0cC0+cnhfZG9uZSk7DQo+ID4gKyAgICAgICAgICAgICAgIGxpc3Rfc3BsaWNl
KCZyeF9xdWV1ZSwgJnRwLT5yeF9kb25lKTsNCj4gPiAgICAgICAgICAgICAgICAgc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmdHAtPnJ4X2xvY2ssIGZsYWdzKTsNCj4gPiAgICAgICAgIH0NCj4gPg0K
PiA+ICBvdXQxOg0KPiA+IC0gICAgICAgcmV0dXJuIHdvcmtfZG9uZTsNCj4gPiArICAgICAgIGlm
ICh3b3JrX2RvbmUgPiBidWRnZXQpDQo+IA0KPiBUaGlzICh3b3JrX2RvbmUgPmJ1ZGdldCkgY29u
ZGl0aW9uIHdvdWxkIG5ldmVyIGJlIHRydWUgaWYgcG9pbnQgWzFdIGlzDQo+IGFkZHJlc3NlZC4N
Cg0KQSBidWxrIHRyYW5zZmVyIG1heSBjb250YWluIG1hbnkgcGFja2V0cywgc28gdGhlIHdvcmtf
ZG9uZSBtYXkgYmUgbW9yZSB0aGFuIGJ1ZGdldC4NClRoYXQgaXMgd2h5IEkgcXVldWUgdGhlIHBh
Y2tldHMgaW4gdGhlIGRyaXZlciBiZWZvcmUgdGhpcyBwYXRjaC4NCkZvciBleGFtcGxlLCBpZiBh
IGJ1bGsgdHJhbnNmZXIgY29udGFpbnMgNzAgcGFja2V0IGFuZCBidWRnZXQgaXMgNjQsDQpuYXBp
X2dyb19yZWNlaXZlIHdvdWxkIGJlIGNhbGxlZCBmb3IgdGhlIGZpcnN0IDY0IHBhY2tldHMgYW5k
IDYgcGFja2V0cyB3b3VsZA0KYmUgcXVldWVkIGluIGRyaXZlciBmb3IgbmV4dCBzY2hlZHVsZS4g
QWZ0ZXIgdGhpcyBwYXRjaCwgbmFwaV9ncm9fcmVjZWl2ZSgpIHdvdWxkDQpiZSBjYWxsZWQgZm9y
IHRoZSA3MCBwYWNrZXRzLCBldmVuIHRoZSBidWRnZXQgaXMgNjQuIEFuZCB0aGUgcmVtYWluZWQg
YnVsayB0cmFuc2ZlcnMNCndvdWxkIGJlIGhhbmRsZWQgZm9yIG5leHQgc2NoZWR1bGUuDQoNCj4g
PiArICAgICAgICAgICAgICAgcmV0dXJuIGJ1ZGdldDsNCj4gPiArICAgICAgIGVsc2UNCj4gPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIHdvcmtfZG9uZTsNCj4gPiAgfQ0KDQpCZXN0IFJlZ2FyZHMs
DQpIYXllcw0KDQo=
