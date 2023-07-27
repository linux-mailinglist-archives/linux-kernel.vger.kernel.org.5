Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E826B76437F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjG0Bo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjG0BoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:44:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D64E8E61;
        Wed, 26 Jul 2023 18:44:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36R1hn833004771, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36R1hn833004771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Jul 2023 09:43:49 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 27 Jul 2023 09:44:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 27 Jul 2023 09:44:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 27 Jul 2023 09:44:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "Lukas F. Hartmann" <lukas@mntre.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
Subject: RE: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Thread-Topic: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX
 path
Thread-Index: AQHZsp+XbJMjQ56edkCHhTIfjugPgq+yJqHggAT+3gCAAUh3EIATdm2AgAELPyA=
Date:   Thu, 27 Jul 2023 01:44:00 +0000
Message-ID: <7738fcc180e6403ba4d0def0ae7ca31a@realtek.com>
References: <20230709195712.603200-1-martin.blumenstingl@googlemail.com>
 <b55cd3172ea7474ba1a67db2d5b39301@realtek.com> <87pm4w3rjp.fsf@mntre.com>
 <208ee32354b44205bb76a55c0d4bc93b@realtek.com>
 <CAFBinCDRWJGr1F0vLj_=k7TYQmGOQRWS=3n1DDQwpxr5AYtt9Q@mail.gmail.com>
In-Reply-To: <CAFBinCDRWJGr1F0vLj_=k7TYQmGOQRWS=3n1DDQwpxr5AYtt9Q@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEJsdW1lbnN0
aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIEp1bHkgMjcsIDIwMjMgMTozOCBBTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVh
bHRlay5jb20+DQo+IENjOiBMdWthcyBGLiBIYXJ0bWFubiA8bHVrYXNAbW50cmUuY29tPjsgbGlu
dXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBqZXJuZWouc2tyYWJlY0BnbWFpbC5jb207IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IGt2
YWxvQGtlcm5lbC5vcmc7IHRvbnkwNjIwZW1tYUBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gd2lmaTogcnR3ODg6IHNkaW86IEhvbm9yIHRoZSBob3N0IG1heF9yZXFfc2l6ZSBpbiB0
aGUgUlggcGF0aA0KPiANCj4gSGVsbG8gUGluZy1LZSwNCj4gDQo+IE9uIEZyaSwgSnVsIDE0LCAy
MDIzIGF0IDI6MzTigK9BTSBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6
DQo+IFsuLi5dDQo+ID4gPiBIZXJlIGFyZSB0aGUgZXJyb3JzIHRoYXQgbGVhZCB1cCB0byB0aGlz
Og0KPiA+ID4gaHR0cDovL2R1bXAubW50bW4uY29tL3J0dzg4LWZhaWx1cmUtMWgtZG1lc2cudHh0
DQo+ID4NCj4gPiBIaSBNYXJ0aW4sDQo+ID4NCj4gPiBUaGUgZG1lc2cgc2hvd3MgdGhhdA0KPiA+
ICJydHdfODgyMmNzIG1tYzI6MDAwMToxOiBGYWlsZWQgdG8gcmVhZCAxNTM2IGJ5dGUocykgZnJv
bSBTRElPIHBvcnQgMHgwMDAwMDBkMSINCj4gPg0KPiA+IFNob3VsZG4ndCB3ZSByZXR1cm4gYW4g
ZXJyb3IgY29kZSAod2l0aCBwcm9wZXIgZXJyb3IgaGFuZGxpbmcpIGluc3RlYWQgb2YNCj4gPiBq
dXN0IGJyZWFrIHRoZSBsb29wPyBCZWNhdXNlICdidWYnIGNvbnRlbnQgaXNuJ3QgdXNhYmxlLg0K
PiBJbiBteSBvcGluaW9uIHdlIGFyZSBwcm9wZXJseSBicmVha2luZyB0aGUgbG9vcDoNCj4gInJl
dCIgd2lsbCBiZSBub24temVybyBzbyB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZCBmcm9tDQo+
IHJ0d19zZGlvX3JlYWRfcG9ydCgpIHRvIHRoZSBjYWxsZXIuDQo+IFRoZSAob25seSkgY2FsbGVy
IGlzIHJ0d19zZGlvX3J4Zmlmb19yZWN2KCkgd2hpY2ggc2VlcyB0aGUgbm9uLXplcm8NCj4gcmV0
dXJuIGNvZGUgYW5kIGFib3J0cyBwcm9jZXNzaW5nLg0KPiBXaGF0IGRvIHlvdSB0aGluaz8NCg0K
WW91IGFyZSBjb3JyZWN0LiANCg0KSSBjaGVjayB0aGUga2VybmVsIGxvZyBhZ2Fpbi4gSXQgbWln
aHQgdHJ5IHRvIHJlYWQgdHdvIHRpbWVzIGZvciBhIGxhcmdlIHBhY2tldC4NCg0KRmlyc3QgcmVh
ZCBpcyAxNTM2IGJ5dGVzLCBidXQgaXQgZmFpbGVkOiANCiAgWyA0MDAyLjA5NjY2NF0gcnR3Xzg4
MjJjcyBtbWMyOjAwMDE6MTogRmFpbGVkIHRvIHJlYWQgMTUzNiBieXRlKHMpIGZyb20gU0RJTyBw
b3J0IDB4MDAwMDAwZDENCg0KU2Vjb25kIHJlYWQgaXMgbGVzcyBieXRlLCBhbmQgaXQgc3VjY2Vl
ZCwgYnV0IHNrYi0+ZGF0YSBjb250ZW50IGlzIGluY29ycmVjdC4gVGhlbiwgDQogIFsgNDAwMi4x
MDAxNDBdIHJ0d184ODIyY3MgbW1jMjowMDAxOjE6IHVudXNlZCBwaHkgc3RhdHVzIHBhZ2UgKDMp
DQogIFsgNDAwMi4xMDUwNjVdIHJ0d184ODIyY3MgbW1jMjowMDAxOjE6IHVudXNlZCBwaHkgc3Rh
dHVzIHBhZ2UgKDIpDQogIFsgNDAwMi4xMTA4NjJdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0t
LS0tLS0tLS0tLQ0KICBbIDQwMDIuMTEwODY4XSBSYXRlIG1hcmtlZCBhcyBhIFZIVCByYXRlIGJ1
dCBkYXRhIGlzIGludmFsaWQ6IE1DUzogMCwgTlNTOiAwDQoNClNvLCBzaG93aW5nIHRvdGFsIHNp
emUgKCdjb3VudCcgYXJndW1lbnQpIG1pZ2h0IGhlbHAgdG8gZmluZCB0aGUgY2F1c2UNCm9yIGEg
d29ya2Fyb3VuZC4gDQoNClBpbmctS2UNCg0K
