Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0701575DCD9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 16:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGVOG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 10:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:06:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8132D77
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 07:06:51 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-122-J7OFbQsWNqyfCrR826JB4A-1; Sat, 22 Jul 2023 15:06:48 +0100
X-MC-Unique: J7OFbQsWNqyfCrR826JB4A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 22 Jul
 2023 15:06:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 22 Jul 2023 15:06:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alan Huang' <mmpgouride@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Eric Dumazet" <edumazet@google.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Thread-Topic: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Thread-Index: AQHZvKDlW9UBwZmf30GL9p6MGC4yBq/F0Gvg
Date:   Sat, 22 Jul 2023 14:06:47 +0000
Message-ID: <8e1885b62d124cca9198ff6cdb52c7f5@AcuMS.aculab.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
 <ED9F14A2-533B-471E-9B79-F75CEEE9A216@gmail.com>
 <ED5C700E-0C63-41E5-8A46-F7BC93B2FD42@gmail.com>
 <76552616-5DF1-4A05-BA5A-AE0677F861FC@gmail.com>
In-Reply-To: <76552616-5DF1-4A05-BA5A-AE0677F861FC@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uLg0KPiA+IEZvdW5kIGEgcmVsYXRlZCBkaXNjdXNzaW9uOg0KPiA+DQo+ID4gaHR0cHM6Ly9n
Y2MuZ251Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9MTAyNzE0DQo+ID4NCj4gPiBMb29r
cyBsaWtlIEdDQyAxMCwgMTEgaGF2ZSBiZWVuIGJhY2twb3J0ZWQsIG5vdCBzdXJlIHdoZXRoZXIg
R0NDIDggaGFzIGJlZW4gYmFja3BvcnRlZC4NCj4gPg0KPiA+IFNvLCBJIGhhdmUgdGhlIGZvbGxv
d2luZyBxdWVzdGlvbnM6DQo+ID4NCj4gPiBHaXZlbiB0aGF0IHNvbWUgcGVvcGxlIG1pZ2h0IG5v
dCB1cGRhdGUgdGhlaXIgR0NDLCBkbyB0aGV5IG5lZWQgdG8gYmUgbm90aWZpZWQ/DQo+ID4NCj4g
PiBEbyB3ZSBuZWVkIHRvIENDIExpbnVzPw0KPiANCj4gTm8gbmVlZC4NCj4gDQo+IEkgcHV0IHRo
ZSBmb2xsb3dpbmcgY29kZSBpbnRvIGEga2VybmVsIG1vZHVsZToNCj4gDQo+IHR5cGVkZWYgc3Ry
dWN0IGxpc3RfaGVhZF9zaGl0IHsNCj4gCWludCBuZXh0Ow0KPiAJc3RydWN0IGxpc3RfaGVhZCAq
Zmlyc3Q7DQo+IH0gbGlzdF9oZWFkX3NoaXQ7DQo+IA0KPiBzdGF0aWMgdm9pZCBub2lubGluZSBz
b19zaGl0KHZvaWQpIHsNCj4gCWxpc3RfaGVhZF9zaGl0ICpoZWFkID0gKGxpc3RfaGVhZF9zaGl0
ICopa21hbGxvYyhzaXplb2YobGlzdF9oZWFkX3NoaXQpLCBHRlBfS0VSTkVMKTsNCj4gCWhlYWQt
PmZpcnN0ID0gMDsNCj4gCWhlYWQtPm5leHQgPSAxOw0KPiANCj4gCVJFQURfT05DRShoZWFkLT5m
aXJzdCk7DQo+IAlSRUFEX09OQ0UoaGVhZC0+Zmlyc3QpOw0KPiANCj4gCWtmcmVlKGhlYWQpOw0K
PiB9DQo+IA0KPiB4ODZfNjQtbGludXgtZ251LWdjYy0xMSBnZW5lcmF0ZSB0aGUgZm9sbG93aW5n
IGNvZGU6DQo+IA0KPiAwMDAwMDAwMDAwMDAwMDAwIDxzb19zaGl0PjoNCj4gICAgMDoJNDggOGIg
M2QgMDAgMDAgMDAgMDAgCW1vdiAgICAweDAoJXJpcCksJXJkaSAgICAgICAgIyA3IDxzb19zaGl0
KzB4Nz4NCj4gICAgNzoJYmEgMTAgMDAgMDAgMDAgICAgICAgCQltb3YgICAgJDB4MTAsJWVkeA0K
PiAgICBjOgliZSBjMCAwYyAwMCAwMCAgICAgIAkgCW1vdiAgICAkMHhjYzAsJWVzaQ0KPiAgIDEx
OgllOCAwMCAwMCAwMCAwMCAgICAgIAkgCWNhbGwgICAxNiA8c29fc2hpdCsweDE2Pg0KPiAgIDE2
Ogk0OCBjNyA0MCAwOCAwMCAwMCAwMCAJbW92cSAgICQweDAsMHg4KCVyYXgpDQo+ICAgMWQ6CTAw
DQo+ICAgMWU6CTQ4IDg5IGM3ICAgICAgICAgICAgIAkJbW92ICAgICVyYXgsJXJkaQ0KPiAgIDIx
OgljNyAwMCAwMSAwMCAwMCAwMCAgICAJbW92bCAgICQweDEsKCVyYXgpDQo+ICAgMjc6CTQ4IDhi
IDQ3IDA4ICAgICAgICAgIAkJbW92ICAgIDB4OCglcmRpKSwlcmF4CSAgIyBSRUFEX09OQ0UgaGVy
ZQ0KPiAgIDJiOgk0OCA4YiA0NyAwOCAgICAgICAgICAJCW1vdiAgICAweDgoJXJkaSksJXJheAkg
ICMgUkVBRF9PTkNFIGhlcmUNCj4gICAyZjoJZTkgMDAgMDAgMDAgMDAgICAgICAJIAlqbXAgICAg
MzQgPHNvX3NoaXQrMHgzND4NCj4gICAzNDoJNjYgNjYgMmUgMGYgMWYgODQgMDAgCWRhdGExNiBj
cyBub3B3IDB4MCglcmF4LCVyYXgsMSkNCj4gICAzYjoJMDAgMDAgMDAgMDANCj4gICAzZjoJOTAg
ICAgICAgICAgICAgICAgICAgCQkJbm9wDQo+IA0KPiBUaGUgY29uY2x1c2lvbiBpcyB0aGF0IHdl
IGNhbiByZWx5IG9uIFJFQURfT05DRSB3aGVuIHdyaXRpbmcga2VybmVsIGNvZGUuDQo+IA0KPiBU
aGUga2VybmVs4oCZcyBSRUFEX09OQ0UgaXMgZGlmZmVyZW50IHdpdGggdGhlIG9uZSBKb2VsIHdy
b3RlIHllc3RlcmRheS4gKEpvZWzigJlzIGlzIHRoZSBzYW1lIGFzIHRoZSBvbGQNCj4gQUNDRVNT
X09OQ0UpDQoNCllvdSBkbyBuZWVkIHRvIHJlcHJvZHVjZSB0aGUgZXJyb3Igd2l0aCBjb2RlIHRo
YXQgbG9va3MgbGlrZQ0KdGhlIGxvb3AgaW4gdGhlIChvbGQpIHVkcC5jIGNvZGUuDQoNClRoZW4g
c2VlIGlmIGNoYW5naW5nIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBSRUFEX09OQ0UoKSBmcm9tDQph
IHNpbXBsZSAndm9sYXRpbGUnIGFjY2VzcyB0aGUgbmV3ZXIgdmFyaWFudCBtYWtlcyBhIGRpZmZl
cmVuY2UuDQoNCllvdSBhbHNvIG5lZWQgdG8gY2hlY2sgd2l0aCB0aGUgb2xkZXN0IHZlcnNpb24g
b2YgZ2NjIHRoYXQgaXMNCnN0aWxsIHN1cHBvcnRlZCAtIHRoYXQgaXMgbXVjaCBvbGRlciB0aGFu
IGdjYyAxMS4NCg0KSW4gdGhlIHVkcCBjb2RlIHRoZSB2b2xhdGlsZSBhY2Nlc3Mgd2FzIG9uIGEg
cG9pbnRlciAod2hpY2ggc2hvdWxkDQpxdWFsaWZ5IGFzIGEgc2NhbGVyIHR5cGUpIHNvIGl0IG1h
eSB3ZWxsIGJlIHRoZSBpbmxpbmluZyBidWcgeW91DQptZW50aW9uZWQgZWFybGllciwgbm90IHRo
ZSAndm9sYXRpbGUgb24gbm9uLXNjYWxlcicgZmVhdHVyZSB0aGF0DQpSRUFEX09OQ0UoKSBmaXhl
ZC4NClRoYXQgZml4IGhhc24ndCBiZWVuIGJhY2stcG9ydGVkIHRvIGFsbCB0aGUgdmVyc2lvbnMg
b2YgZ2NjDQp0aGF0IHRoZSBrZXJuZWwgYnVpbGQgc3VwcG9ydHMuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

