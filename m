Return-Path: <linux-kernel+bounces-3234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AED81698E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBEC1F23261
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E4D12E44;
	Mon, 18 Dec 2023 09:13:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BD134A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-269-EFmJvLQYPUOJ2E6UmrH6ng-1; Mon, 18 Dec 2023 09:12:58 +0000
X-MC-Unique: EFmJvLQYPUOJ2E6UmrH6ng-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Dec
 2023 09:12:36 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Dec 2023 09:12:36 +0000
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
Thread-Index: AQHaLduBo9lhsHug1EOTPi9OJpSM+LCtyBWAgABcPYCAAKHfoA==
Date: Mon, 18 Dec 2023 09:12:36 +0000
Message-ID: <6aa468db18c04ad39e46612b343b2a60@AcuMS.aculab.com>
References: <20231213154530.1970216-1-ivan.orlov0322@gmail.com>
 <a210197c479e48778672aa13287eef88@AcuMS.aculab.com>
 <45351e30-d197-4b9c-864f-8ff5f9b6ab61@gmail.com>
In-Reply-To: <45351e30-d197-4b9c-864f-8ff5f9b6ab61@gmail.com>
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

RnJvbTogSXZhbiBPcmxvdg0KPiBTZW50OiAxNyBEZWNlbWJlciAyMDIzIDIzOjIzDQo+IA0KPiBP
biAxMi8xNy8yMyAxODoxMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZyb206IEl2YW4gT3Js
b3YNCj4gPj4gU2VudDogMTMgRGVjZW1iZXIgMjAyMyAxNTo0Ng0KPiA+DQo+ID4gTG9va2luZyBh
dCB0aGUgb2xkIGNvZGUuLi4NCj4gPg0KPiA+PiAgIDE6DQo+ID4+IC0JbGJ1CXQwLCAwKHQxKQ0K
PiA+PiAtCWJlcXoJdDAsIDJmDQo+ID4+IC0JYWRkaQl0MSwgdDEsIDENCj4gPj4gLQlqCTFiDQo+
ID4NCj4gPiBJIHN1c3BlY3QgdGhlcmUgaXMgKGF0IGxlYXN0KSBhIHR3byBjbG9jayBzdGFsbCBi
ZXR3ZWVuDQo+ID4gdGhlICdsZHUnIGFuZCAnYmVxeicuDQo+IA0KPiBIbW0sIHRoZSBzdGFsbCBl
eGlzdHMgZHVlIHRvIG1lbW9yeSBhY2Nlc3M/IFdoeSBkb2VzIHR3byBzdWJzZXF1ZW50DQo+IGFj
Y2Vzc2VzIHRvIHRoZSBtZW1vcnkgKGFzIGluIHRoZSBleGFtcGxlIHlvdSBwcm92aWRlZCkgZG8g
dGhlIHRyaWNrPyBJcw0KPiBpdCBiZWNhdXNlIHR3byAibGRiInMgY291bGQgYmUgcGFyYWxsZWxp
emVkPw0KDQpPbiB0aGUgZnBnYSBSSVNDViAoYW5kIHByb2JhYmx5IG90aGVyICdzbWFsbCcgaW1w
bGVtZW50YXRpb25zKQ0KdGhlcmUgaXMgYSB0d28gY2xvY2sgcmVzdWx0IGRlbGF5IGZyb20gbWVt
b3J5IGxvYWRzIHdoaWxlIHRoZQ0KcmVzdWx0IGlzIHdyaXR0ZW4gdG8gdGhlICdyZWdpc3RlciBm
aWxlJy4NCkFMVSByZXN1bHRzIGdldCBzaG9ydC1jaXJjdWl0ZWQgc28gY2FuIGJlIHVzZWQgaW4g
dGhlIG5leHQgaW5zdHJ1Y3Rpb24uDQoNClRoZSBtZW1vcnkgbG9hZHMgdGhlbXNlbHZlcyBhcmUg
cGlwZWxpbmVkIGFuZCBjYW4gYmUgaXNzdWVkDQpldmVyeSBjbG9jay4NCihPbiB0aGUgZnBnYSB2
ZXJzaW9uIGFjdHVhbCBtZW1vcnkgZGVsYXlzIHN0YWxsIHRoZSBwaXBlbGluZS4pIA0KDQouLi4N
Cj4gTWF5YmUgd2UgY291bGQgZW5oYW5jZSBpdCBldmVuIG1vcmUgYnkgbG9hZGluZyA0IGNvbnNl
cXVlbnQgYnl0ZXMgaW50bw0KPiBkaWZmZXJlbnQgcmVnaXN0ZXJzIHNvIHRoZSBtZW1vcnkgbG9h
ZHMgd291bGQgc3RpbGwgYmUgcGFyYWxsZWxpemVkPw0KDQpZb3UgbmVlZCB0aGUgbG9hZHMgdG8g
YmUgcGlwZWxpbmVkLCBub3QgcGFyYWxsZWxpemVkLg0KVGhhdCB3aWxsIGhlbHAgaWYgdGhlcmUg
YXJlIGxvbmdlciBkZWxheXMgYWNjZXNzaW5nIGNhY2hlIG1lbW9yeS4NCg0KSSdkIGV4cGVjdCBh
bnkgY3B1IHdpdGggKHNheSkgYSA0IGNsb2NrIGNhY2hlIHJlYWQgbGF0ZW5jeSB0bw0KcGlwZWxp
bmUgcmVhZHMgc28gdGhhdCBvbmUgY2FuIGJlIGlzc3VlZCBldmVyeSBjbG9jayBwcm92aWRlZA0K
dGhlIHJlc3VsdHMgYXJlbid0IG5lZWRlZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


