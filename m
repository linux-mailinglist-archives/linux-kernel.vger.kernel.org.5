Return-Path: <linux-kernel+bounces-3302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923DF816AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B580283818
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC7F134C3;
	Mon, 18 Dec 2023 10:12:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766E14F9E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-52-2lOzyjfMNFygAJUXwze_iw-1; Mon, 18 Dec 2023 10:12:22 +0000
X-MC-Unique: 2lOzyjfMNFygAJUXwze_iw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Dec
 2023 10:12:00 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Dec 2023 10:12:00 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ivan Orlov' <ivan.orlov0322@gmail.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "samuel@sholland.org"
	<samuel@sholland.org>, "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Subject: RE: [PATCH] riscv: lib: Optimize 'strlen' function
Thread-Topic: [PATCH] riscv: lib: Optimize 'strlen' function
Thread-Index: AQHaLduBo9lhsHug1EOTPi9OJpSM+LCttqAAgACUUYCAAH5N8IAADeeAgAABdOA=
Date: Mon, 18 Dec 2023 10:12:00 +0000
Message-ID: <9b0c5afd66454c39892898dc95e7302c@AcuMS.aculab.com>
References: <20231213154530.1970216-1-ivan.orlov0322@gmail.com>
 <86d3947bce1f49c395224998e7d65dc2@AcuMS.aculab.com>
 <de80b4c7-1ffb-478e-9117-9d5b829470bd@gmail.com>
 <bd9159806a2e4fd188a78515b58ec51e@AcuMS.aculab.com>
 <f12ef9ea-14fe-491a-890b-a645bb4827cb@gmail.com>
In-Reply-To: <f12ef9ea-14fe-491a-890b-a645bb4827cb@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSXZhbiBPcmxvdiANCj4gU2VudDogMTggRGVjZW1iZXIgMjAyMyAxMDowMw0KPiANCj4g
T24gMTIvMTgvMjMgMDk6MjAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBJdmFuIE9y
bG92DQo+ID4+IFNlbnQ6IDE4IERlY2VtYmVyIDIwMjMgMDE6NDINCj4gPj4NCj4gPj4gT24gMTIv
MTcvMjMgMTc6MDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPj4+IEknZCBhbHNvIGd1ZXNzIHRo
YXQgcHJldHR5IG11Y2ggYWxsIHRoZSBjYWxscyBpbi1rZXJuZWwgYXJlIHNob3J0Lg0KPiA+Pj4g
WW91IG1pZ2h0IHRyeSBjb3VudGluZyBhczogaGlzdG9ncmFtW2lsb2cyKHN0cmxlbl9yZXN1bHQp
XSsrDQo+ID4+PiBhbmQgc2VlaW5nIHdoYXQgaXQgc2hvd3MgZm9yIHNvbWUgd29ya2xvYWQuDQo+
ID4+PiBJIGJldCB5b3UgKGEgYmVlciBpZiBJIHNlZSB5b3UhKSB0aGF0IHlvdSB3b24ndCBzZWUg
bWFueSBvdmVyIDFrLg0KPiA+Pg0KPiA+PiBIaSBEYXZpZCwNCj4gPj4NCj4gPj4gSGVyZSBpcyB0
aGUgc3RhdGlzdGljcyBmb3Igc3RybGVuIHJlc3VsdDoNCj4gPj4NCj4gPj4gWyAgMjIzLjE2OTU3
NV0gQ2FsbHMgY291bnQgZm9yIDJeMDogNjE1MA0KPiA+PiBbICAyMjMuMTczMjkzXSBDYWxscyBj
b3VudCBmb3IgMl4xOiAxODQ4NTINCj4gPj4gWyAgMjIzLjE3NzE0Ml0gQ2FsbHMgY291bnQgZm9y
IDJeMjogMzEzODk2DQo+ID4+IFsgIDIyMy4xODA5OTBdIENhbGxzIGNvdW50IGZvciAyXjM6IDE4
NTg0NA0KPiA+PiBbICAyMjMuMTg0ODgxXSBDYWxscyBjb3VudCBmb3IgMl40OiA4Nzg2OA0KPiA+
PiBbICAyMjMuMTg4NjYwXSBDYWxscyBjb3VudCBmb3IgMl41OiA5OTE2DQo+ID4+IFsgIDIyMy4x
OTIzNjhdIENhbGxzIGNvdW50IGZvciAyXjY6IDE4NjUNCj4gPj4gWyAgMjIzLjE5NjA2Ml0gQ2Fs
bHMgY291bnQgZm9yIDJeNzogMA0KPiA+PiBbICAyMjMuMTk5NDgzXSBDYWxscyBjb3VudCBmb3Ig
Ml44OiAwDQo+ID4+IFsgIDIyMy4yMDI5NTJdIENhbGxzIGNvdW50IGZvciAyXjk6IDANCj4gPj4g
Li4uDQo+ID4+DQo+ID4+IExvb2tzIGxpa2UgSSd2ZSBqdXN0IGxvc3QgYSBiZWVyIDopDQo+ID4+
DQo+ID4+IENvbnNpZGVyaW5nIHRoaXMgc3RhdGlzdGljcywgSSdkIHNheSBpbXBsZW1lbnRpbmcg
dGhlIHdvcmQtb3JpZW50ZWQNCj4gPj4gc3RybGVuIGlzIGFuIG92ZXJjb21wbGljYXRpb24gLSB3
ZSB3b3VsZG4ndCBnZXQgYW55IHBlcmZvcm1hbmNlIGdhaW4gYW5kDQo+ID4+IGl0IGp1c3QgZG9l
c24ndCB3b3J0aCBpdC4NCj4gPg0KPiA+IEFuZCB0aGUgMzJiaXQgdmVyc2lvbiBpcyBhYm91dCBo
YWxmIHRoZSBzcGVlZCBvZiB0aGUgNjRiaXQgb25lLg0KPiA+DQo+ID4gT2YgY291cnNlLCB0aGUg
ZmFzdCB3YXkgdG8gZG8gc3RybGVuIGlzIGFkZCBhIGN1c3RvbSBpbnN0cnVjdGlvbiENCj4gPg0K
PiA+PiBJIHNpbXBsaWZpZWQgeW91ciBjb2RlIGEgbGl0dGxlIGJpdCwgaXQgbG9va3MgbGlrZSB0
aGUgYWxpZ25tZW50IHRoZXJlDQo+ID4+IGlzIHVubmVjZXNzYXJ5OiBRRU1VIHRlc3Qgc2hvd3Mg
dGhlIHNhbWUgcGVyZm9ybWFuY2UgaW5kZXBlbmRlbnRseSBmcm9tDQo+ID4+IGFsaWdubWVudC4g
VGVzdHMgb24gdGhlIGJvYXJkIGdhdmUgdGhlIHNhbWUgcmVzdWx0IChwZXJoYXBzIGJlY2F1c2Ug
dGhlDQo+ID4+IENQVSBvbiB0aGUgYm9hcmQgaGFzIDIgRERSIGNoYW5uZWxzPykNCj4gPg0KPiA+
IFRoZSBhbGlnbm1lbnQgaXMgdGhlcmUgYmVjYXVzZSBpdCBjYW4gb3ZlcnJlYWQgdGhlIHN0cmlu
ZyBlbmQNCj4gPiBieSBvbmUgYnl0ZSAtIGFuZCB0aGF0IG11c3RuJ3QgY3Jvc3MgYSBwYWdlIGJv
dW5kYXJ5Lg0KPiA+IFNvIHlvdSBlaXRoZXIgaGF2ZSB0byBtYXJrIHRoZSBzZWNvbmQgbG9hZCBh
cyAnbWF5IGZhdWx0IHJldHVybg0KPiA+IHplcm8nIG9yIGp1c3Qgbm90IGRvIGl0Lg0KPiA+DQo+
ID4gSWYgdGhlIGRhdGEgaXNuJ3QgaW4gY2FjaGUgdGhlIGNhY2hlIGxvYWQgd2lsbCBkb21pbmF0
ZS4NCj4gPiBUaGUgRERSIGNoYW5uZWxzIG9ubHkgYWZmZWN0IGNhY2hlIGxvYWQgdGltZXMuDQo+
ID4gR2V0IGEgVExCIG1pc3MgYW5kIGFkZCBhIGZldyB0aG91c2FuZCBtb3JlIGNsb2NrcyENCj4g
Pg0KPiANCj4gQWgsIHJpZ2h0LCBzb3VuZHMgcmVhc29uYWJsZS4uLg0KPiANCj4gT3ZlcmFsbCwg
SSBiZWxpZXZlIHlvdXIgc29sdXRpb24gaXMgYmV0dGVyIGFuZCBpdCB3b3VsZCBiZSBtb3JlIGZh
aXIgaWYNCj4geW91IHNlbmQgaXQgYXMgYSBwYXRjaCA6KSBIZXJlIGlzIGJlbmNobWFyayByZXN1
bHRzIGZvciB5b3VyIHZlcnNpb24gdnMNCj4gdGhlIG9yaWdpbmFsICh0aGUgb2xkKSBvbmUgb24g
dGhlIFN0YXJmaXZlIFZpc2lvbkZpdmUyIFJJU0MtViBib2FyZDoNCg0KWW91IG1pZ2h0IHdhbnQg
dG8gdHJ5IHJlYWRpbmcgNCBieXRlcyBiZWZvcmUgY2hlY2tpbmcgYW55Lg0KSXQgbWlnaHQgYmUg
cXVpY2tlciBvbiB5b3VyIGNwdS4NCkl0IGlzIGhhcmQgZ3Vlc3Npbmcgd2hhdCBpcyBiZXN0IGFj
cm9zcyBtdWx0aXBsZSBpbXBsZW1lbnRhdGlvbi4NCihGb3IgdGVzdGluZyBJJ2Qgbm90IHdvcnJ5
IGFib3V0IGZhbGxpbmcgb2ZmIHRoZSBwYWdlLikNCg0KSSdsbCBsZXQgeW91IGRvIHRoZSBwYXRj
aCwgSSBkb24ndCBldmVuIGhhdmUgYSB0b29sY2hhaW4sIG5ldmVyIG1pbmQNCmFueXRoaW5nIHRv
IHRlc3QgaXQgb24uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


