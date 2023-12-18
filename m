Return-Path: <linux-kernel+bounces-3238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C898169B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85494283995
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5B311720;
	Mon, 18 Dec 2023 09:21:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8CC11701
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-285-PaRQjW_lPcubI0-3L44Cyg-1; Mon, 18 Dec 2023 09:21:09 +0000
X-MC-Unique: PaRQjW_lPcubI0-3L44Cyg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Dec
 2023 09:20:47 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Dec 2023 09:20:47 +0000
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
Thread-Index: AQHaLduBo9lhsHug1EOTPi9OJpSM+LCttqAAgACUUYCAAH5N8A==
Date: Mon, 18 Dec 2023 09:20:47 +0000
Message-ID: <bd9159806a2e4fd188a78515b58ec51e@AcuMS.aculab.com>
References: <20231213154530.1970216-1-ivan.orlov0322@gmail.com>
 <86d3947bce1f49c395224998e7d65dc2@AcuMS.aculab.com>
 <de80b4c7-1ffb-478e-9117-9d5b829470bd@gmail.com>
In-Reply-To: <de80b4c7-1ffb-478e-9117-9d5b829470bd@gmail.com>
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

RnJvbTogSXZhbiBPcmxvdg0KPiBTZW50OiAxOCBEZWNlbWJlciAyMDIzIDAxOjQyDQo+IA0KPiBP
biAxMi8xNy8yMyAxNzowMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEknZCBhbHNvIGd1ZXNz
IHRoYXQgcHJldHR5IG11Y2ggYWxsIHRoZSBjYWxscyBpbi1rZXJuZWwgYXJlIHNob3J0Lg0KPiA+
IFlvdSBtaWdodCB0cnkgY291bnRpbmcgYXM6IGhpc3RvZ3JhbVtpbG9nMihzdHJsZW5fcmVzdWx0
KV0rKw0KPiA+IGFuZCBzZWVpbmcgd2hhdCBpdCBzaG93cyBmb3Igc29tZSB3b3JrbG9hZC4NCj4g
PiBJIGJldCB5b3UgKGEgYmVlciBpZiBJIHNlZSB5b3UhKSB0aGF0IHlvdSB3b24ndCBzZWUgbWFu
eSBvdmVyIDFrLg0KPiANCj4gSGkgRGF2aWQsDQo+IA0KPiBIZXJlIGlzIHRoZSBzdGF0aXN0aWNz
IGZvciBzdHJsZW4gcmVzdWx0Og0KPiANCj4gWyAgMjIzLjE2OTU3NV0gQ2FsbHMgY291bnQgZm9y
IDJeMDogNjE1MA0KPiBbICAyMjMuMTczMjkzXSBDYWxscyBjb3VudCBmb3IgMl4xOiAxODQ4NTIN
Cj4gWyAgMjIzLjE3NzE0Ml0gQ2FsbHMgY291bnQgZm9yIDJeMjogMzEzODk2DQo+IFsgIDIyMy4x
ODA5OTBdIENhbGxzIGNvdW50IGZvciAyXjM6IDE4NTg0NA0KPiBbICAyMjMuMTg0ODgxXSBDYWxs
cyBjb3VudCBmb3IgMl40OiA4Nzg2OA0KPiBbICAyMjMuMTg4NjYwXSBDYWxscyBjb3VudCBmb3Ig
Ml41OiA5OTE2DQo+IFsgIDIyMy4xOTIzNjhdIENhbGxzIGNvdW50IGZvciAyXjY6IDE4NjUNCj4g
WyAgMjIzLjE5NjA2Ml0gQ2FsbHMgY291bnQgZm9yIDJeNzogMA0KPiBbICAyMjMuMTk5NDgzXSBD
YWxscyBjb3VudCBmb3IgMl44OiAwDQo+IFsgIDIyMy4yMDI5NTJdIENhbGxzIGNvdW50IGZvciAy
Xjk6IDANCj4gLi4uDQo+IA0KPiBMb29rcyBsaWtlIEkndmUganVzdCBsb3N0IGEgYmVlciA6KQ0K
PiANCj4gQ29uc2lkZXJpbmcgdGhpcyBzdGF0aXN0aWNzLCBJJ2Qgc2F5IGltcGxlbWVudGluZyB0
aGUgd29yZC1vcmllbnRlZA0KPiBzdHJsZW4gaXMgYW4gb3ZlcmNvbXBsaWNhdGlvbiAtIHdlIHdv
dWxkbid0IGdldCBhbnkgcGVyZm9ybWFuY2UgZ2FpbiBhbmQNCj4gaXQganVzdCBkb2Vzbid0IHdv
cnRoIGl0Lg0KDQpBbmQgdGhlIDMyYml0IHZlcnNpb24gaXMgYWJvdXQgaGFsZiB0aGUgc3BlZWQg
b2YgdGhlIDY0Yml0IG9uZS4NCg0KT2YgY291cnNlLCB0aGUgZmFzdCB3YXkgdG8gZG8gc3RybGVu
IGlzIGFkZCBhIGN1c3RvbSBpbnN0cnVjdGlvbiENCg0KPiBJIHNpbXBsaWZpZWQgeW91ciBjb2Rl
IGEgbGl0dGxlIGJpdCwgaXQgbG9va3MgbGlrZSB0aGUgYWxpZ25tZW50IHRoZXJlDQo+IGlzIHVu
bmVjZXNzYXJ5OiBRRU1VIHRlc3Qgc2hvd3MgdGhlIHNhbWUgcGVyZm9ybWFuY2UgaW5kZXBlbmRl
bnRseSBmcm9tDQo+IGFsaWdubWVudC4gVGVzdHMgb24gdGhlIGJvYXJkIGdhdmUgdGhlIHNhbWUg
cmVzdWx0IChwZXJoYXBzIGJlY2F1c2UgdGhlDQo+IENQVSBvbiB0aGUgYm9hcmQgaGFzIDIgRERS
IGNoYW5uZWxzPykNCg0KVGhlIGFsaWdubWVudCBpcyB0aGVyZSBiZWNhdXNlIGl0IGNhbiBvdmVy
cmVhZCB0aGUgc3RyaW5nIGVuZA0KYnkgb25lIGJ5dGUgLSBhbmQgdGhhdCBtdXN0bid0IGNyb3Nz
IGEgcGFnZSBib3VuZGFyeS4NClNvIHlvdSBlaXRoZXIgaGF2ZSB0byBtYXJrIHRoZSBzZWNvbmQg
bG9hZCBhcyAnbWF5IGZhdWx0IHJldHVybg0KemVybycgb3IganVzdCBub3QgZG8gaXQuDQoNCklm
IHRoZSBkYXRhIGlzbid0IGluIGNhY2hlIHRoZSBjYWNoZSBsb2FkIHdpbGwgZG9taW5hdGUuDQpU
aGUgRERSIGNoYW5uZWxzIG9ubHkgYWZmZWN0IGNhY2hlIGxvYWQgdGltZXMuDQpHZXQgYSBUTEIg
bWlzcyBhbmQgYWRkIGEgZmV3IHRob3VzYW5kIG1vcmUgY2xvY2tzIQ0KDQo+IA0KPiAJbXYgdDAs
IGEwDQo+IDE6DQo+IAlsYnUgdDEsIDAoYTApDQo+IAlsYnUgdDIsIDEoYTApDQo+IAlhZGRpIGEw
LCBhMCwgMg0KPiAJYmVxeiB0MSwgMmYNCj4gCWJuZXogdDIsIDFiDQo+IAlhZGRpIGEwLCBhMCwg
MQ0KPiAyOg0KPiAJYWRkaSBhMCwgYTAsIC0yDQo+IAlzdWIgYTAsIGEwLCB0MA0KPiAJcmV0DQo+
IA0KPiBJZiBpdCBsb29rcyBnb29kIHRvIHlvdSwgd291bGQgeW91IG1pbmQgaWYgSSBzZW5kIHRo
ZSBwYXRjaCB3aXRoIGl0Pw0KPiBDb3VsZCBJIGFkZCB5b3UgdG8gc3VnZ2VzdGVkLWJ5IHRhZz8N
Cg0KWWVwLi4NCg0KCURhdmlkDQoNCj4gDQo+IC0tDQo+IEtpbmQgcmVnYXJkcywNCj4gSXZhbiBP
cmxvdg0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=


