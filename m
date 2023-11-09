Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707397E6E84
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbjKIQVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKIQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:20:58 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868E4173E;
        Thu,  9 Nov 2023 08:20:54 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A9GKUKM01668823, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A9GKUKM01668823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 00:20:30 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Nov 2023 00:20:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Nov 2023 00:20:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 10 Nov 2023 00:20:30 +0800
From:   Hau <hau@realtek.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>
CC:     nic_swsd <nic_swsd@realtek.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v2 1/2] r8169: add handling DASH when DASH is disabled
Thread-Topic: [PATCH net v2 1/2] r8169: add handling DASH when DASH is
 disabled
Thread-Index: AQHaEnRkKWk8jO5fZUKdN+LsLx8Ws7BxWqCAgADQJoA=
Date:   Thu, 9 Nov 2023 16:20:29 +0000
Message-ID: <12b7d629d07949eb9cf5472f860413db@realtek.com>
References: <20231108184849.2925-1-hau@realtek.com>
         <20231108184849.2925-2-hau@realtek.com>
 <5783a6f8819a741f0f299602ff615e6a03368246.camel@redhat.com>
In-Reply-To: <5783a6f8819a741f0f299602ff615e6a03368246.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
x-originating-ip: [172.22.228.56]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZb3Ugc2hvdWxkIGluY2x1ZGUgdGhlIGZpeGVzIHRhZyB5b3UgYWxyZWFkeSBhZGRlZCBpbiB2
MSBhbmQgeW91ciBTb2Igc2hvdWxkDQo+IGNvbWUgYXMgdGhlIGxhc3QgdGFnDQo+IA0KPiBUaGUg
c2FtZSBhcHBsaWVzIHRvIHRoZSBuZXh0IHBhdGNoDQo+IA0KSSBmb3JnZXQgdG8gYWRkIEZpeGVz
IHRhZy4gSSB3aWxsIGFkZCBpdCBiYWNrLg0KDQo+ID4gUmV2aWV3ZWQtYnk6IEhlaW5lciBLYWxs
d2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+IA0KPiBJdCdzIG5vdCBjbGVhciB3aGVyZS93
aGVuIEhlaW5lciBwcm92aWRlZCB0aGUgYWJvdmUgdGFnIGZvciB0aGlzIHBhdGNoLg0KPiBJIGhv
cGUgdGhhdCB3YXMgb2ZmLWxpc3QuDQpJIG1heSBtaXN1bmRlcnN0YW5kaW5nIHdoYXQgaGUgbWVh
bnMuIEkgd2lsbCBub3QgYWRkIHRoaXMgdGFnIGluIG15IG5leHQgcGF0Y2guDQoNCj4gDQo+ID4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMgfCAzNQ0KPiA+ICsrKysrKysrKysrKysrKystLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4
MTY5X21haW4uYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWlu
LmMNCj4gPiBpbmRleCAwYzc2YzE2MmI4YTkuLjEwOGRjNzUwNTBiYSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+ID4gQEAgLTYyNCw2ICs2
MjQsNyBAQCBzdHJ1Y3QgcnRsODE2OV9wcml2YXRlIHsNCj4gPg0KPiA+ICAgICAgIHVuc2lnbmVk
IHN1cHBvcnRzX2dtaWk6MTsNCj4gPiAgICAgICB1bnNpZ25lZCBhc3BtX21hbmFnZWFibGU6MTsN
Cj4gPiArICAgICB1bnNpZ25lZCBkYXNoX2VuYWJsZWQ6MTsNCj4gPiAgICAgICBkbWFfYWRkcl90
IGNvdW50ZXJzX3BoeXNfYWRkcjsNCj4gPiAgICAgICBzdHJ1Y3QgcnRsODE2OV9jb3VudGVycyAq
Y291bnRlcnM7DQo+ID4gICAgICAgc3RydWN0IHJ0bDgxNjlfdGNfb2Zmc2V0cyB0Y19vZmZzZXQ7
IEBAIC0xMjUzLDE0ICsxMjU0LDI2IEBADQo+ID4gc3RhdGljIGJvb2wgcjgxNjhlcF9jaGVja19k
YXNoKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwKQ0KPiA+ICAgICAgIHJldHVybiByODE2OGVw
X29jcF9yZWFkKHRwLCAweDEyOCkgJiBCSVQoMCk7ICB9DQo+ID4NCj4gPiAtc3RhdGljIGVudW0g
cnRsX2Rhc2hfdHlwZSBydGxfY2hlY2tfZGFzaChzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCkN
Cj4gPiArc3RhdGljIGJvb2wgcnRsX2Rhc2hfaXNfZW5hYmxlZChzdHJ1Y3QgcnRsODE2OV9wcml2
YXRlICp0cCkgew0KPiA+ICsgICAgIHN3aXRjaCAodHAtPmRhc2hfdHlwZSkgew0KPiA+ICsgICAg
IGNhc2UgUlRMX0RBU0hfRFA6DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gcjgxNjhkcF9jaGVj
a19kYXNoKHRwKTsNCj4gPiArICAgICBjYXNlIFJUTF9EQVNIX0VQOg0KPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuIHI4MTY4ZXBfY2hlY2tfZGFzaCh0cCk7DQo+ID4gKyAgICAgZGVmYXVsdDoNCj4g
PiArICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgICB9DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyBlbnVtIHJ0bF9kYXNoX3R5cGUgcnRsX2dldF9kYXNoX3R5cGUoc3RydWN0
IHJ0bDgxNjlfcHJpdmF0ZQ0KPiA+ICsqdHApDQo+ID4gIHsNCj4gPiAgICAgICBzd2l0Y2ggKHRw
LT5tYWNfdmVyc2lvbikgew0KPiA+ICAgICAgIGNhc2UgUlRMX0dJR0FfTUFDX1ZFUl8yODoNCj4g
PiAgICAgICBjYXNlIFJUTF9HSUdBX01BQ19WRVJfMzE6DQo+ID4gLSAgICAgICAgICAgICByZXR1
cm4gcjgxNjhkcF9jaGVja19kYXNoKHRwKSA/IFJUTF9EQVNIX0RQIDogUlRMX0RBU0hfTk9ORTsN
Cj4gPiArICAgICAgICAgICAgIHJldHVybiBSVExfREFTSF9EUDsNCj4gPiAgICAgICBjYXNlIFJU
TF9HSUdBX01BQ19WRVJfNTEgLi4uIFJUTF9HSUdBX01BQ19WRVJfNTM6DQo+ID4gLSAgICAgICAg
ICAgICByZXR1cm4gcjgxNjhlcF9jaGVja19kYXNoKHRwKSA/IFJUTF9EQVNIX0VQIDogUlRMX0RB
U0hfTk9ORTsNCj4gPiArICAgICAgICAgICAgIHJldHVybiBSVExfREFTSF9FUDsNCj4gPiAgICAg
ICBkZWZhdWx0Og0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIFJUTF9EQVNIX05PTkU7DQo+ID4g
ICAgICAgfQ0KPiA+IEBAIC0xNDUzLDcgKzE0NjYsNyBAQCBzdGF0aWMgdm9pZCBfX3J0bDgxNjlf
c2V0X3dvbChzdHJ1Y3QNCj4gPiBydGw4MTY5X3ByaXZhdGUgKnRwLCB1MzIgd29sb3B0cykNCj4g
Pg0KPiA+ICAgICAgIGRldmljZV9zZXRfd2FrZXVwX2VuYWJsZSh0cF90b19kZXYodHApLCB3b2xv
cHRzKTsNCj4gPg0KPiA+IC0gICAgIGlmICh0cC0+ZGFzaF90eXBlID09IFJUTF9EQVNIX05PTkUp
IHsNCj4gPiArICAgICBpZiAoIXRwLT5kYXNoX2VuYWJsZWQpIHsNCj4gPiAgICAgICAgICAgICAg
IHJ0bF9zZXRfZDNfcGxsX2Rvd24odHAsICF3b2xvcHRzKTsNCj4gPiAgICAgICAgICAgICAgIHRw
LT5kZXYtPndvbF9lbmFibGVkID0gd29sb3B0cyA/IDEgOiAwOw0KPiA+ICAgICAgIH0NCj4gPiBA
QCAtMjUxMiw3ICsyNTI1LDcgQEAgc3RhdGljIHZvaWQgcnRsX3dvbF9lbmFibGVfcngoc3RydWN0
DQo+ID4gcnRsODE2OV9wcml2YXRlICp0cCkNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBydGxfcHJl
cGFyZV9wb3dlcl9kb3duKHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRwKSAgew0KPiA+IC0gICAg
IGlmICh0cC0+ZGFzaF90eXBlICE9IFJUTF9EQVNIX05PTkUpDQo+ID4gKyAgICAgaWYgKHRwLT5k
YXNoX2VuYWJsZWQpDQo+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+ID4NCj4gPiAgICAgICBp
ZiAodHAtPm1hY192ZXJzaW9uID09IFJUTF9HSUdBX01BQ19WRVJfMzIgfHwgQEAgLTQ4NjksNyAr
NDg4Miw3DQo+ID4gQEAgc3RhdGljIGludCBydGw4MTY5X3J1bnRpbWVfaWRsZShzdHJ1Y3QgZGV2
aWNlICpkZXZpY2UpICB7DQo+ID4gICAgICAgc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAgPSBk
ZXZfZ2V0X2RydmRhdGEoZGV2aWNlKTsNCj4gPg0KPiA+IC0gICAgIGlmICh0cC0+ZGFzaF90eXBl
ICE9IFJUTF9EQVNIX05PTkUpDQo+ID4gKyAgICAgaWYgKHRwLT5kYXNoX2VuYWJsZWQpDQo+ID4g
ICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+DQo+ID4gICAgICAgaWYgKCFuZXRpZl9y
dW5uaW5nKHRwLT5kZXYpIHx8ICFuZXRpZl9jYXJyaWVyX29rKHRwLT5kZXYpKSBAQA0KPiA+IC00
ODk2LDcgKzQ5MDksNyBAQCBzdGF0aWMgdm9pZCBydGxfc2h1dGRvd24oc3RydWN0IHBjaV9kZXYg
KnBkZXYpDQo+ID4gICAgICAgcnRsX3Jhcl9zZXQodHAsIHRwLT5kZXYtPnBlcm1fYWRkcik7DQo+
ID4NCj4gPiAgICAgICBpZiAoc3lzdGVtX3N0YXRlID09IFNZU1RFTV9QT1dFUl9PRkYgJiYNCj4g
PiAtICAgICAgICAgdHAtPmRhc2hfdHlwZSA9PSBSVExfREFTSF9OT05FKSB7DQo+ID4gKyAgICAg
ICAgICAgICAhdHAtPmRhc2hfZW5hYmxlZCkgew0KPiANCj4gU2luY2UgeW91IGhhdmUgdG8gcmVw
b3N0LCBwbGVhc2UgbWFpbnRhaW4gdGhlIGNvcnJlY3QgaW5kZW50YXRpb24NCj4gYWJvdmU6DQo+
IA0KPiAgICAgICAgIGlmIChzeXN0ZW1fc3RhdGUgPT0gU1lTVEVNX1BPV0VSX09GRiAmJg0KPiAg
ICAgICAgICAgICAhdHAtPmRhc2hfZW5hYmxlZCkgew0KPiANCj4gICAgICAgICBeXl5eDQo+IHNw
YWNlcyBoZXJlLg0KSSB3aWxsIGNvcnJlY3QgdGhlIGluZGVudGF0aW9uLiBUaGFua3MuDQo=
