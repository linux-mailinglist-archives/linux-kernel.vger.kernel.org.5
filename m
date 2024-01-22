Return-Path: <linux-kernel+bounces-33679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6811A836D26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26391C2292A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D65576B;
	Mon, 22 Jan 2024 16:27:54 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BDC3D3BD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940873; cv=none; b=BTf4JaaST4f084MlOGsEvkpp0wL4bQKBdkClpstL8JQFTIXayNGDDLy9sdBe0+59pbrtt2ihbs8ZpPbHeP+kl65Gf2bjiItG+d45cos9ZNvbvElhI4WhN5/CdKd999n4fMiDOQHwufqW4owIJTPAhz9OZdIZ6GEa7dh4Oq7iJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940873; c=relaxed/simple;
	bh=SGx6S/BHwytQoYDW7ZdHlY+dJ2xWWmtc/jLlMLPhOhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MdUFnDR8jggfItkkAPDnSKEdFAvTr1d5d6IVCCIzCS9TusRZbQcEuee5Bfb8dmvHG3YT+PO3fldcYWzLYKUphijTKDkYrSwlgk+DiwsczHIGR8nX1Zf3eD2829BQtnknCYvqPtHUlXCNZoLqqf8iZ+0Nb8zb1JsUxLIDGzvm15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-210-MDhQu3aqNn262JcA0dFe3A-1; Mon, 22 Jan 2024 16:27:40 +0000
X-MC-Unique: MDhQu3aqNn262JcA0dFe3A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 Jan
 2024 16:27:13 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 22 Jan 2024 16:27:13 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Matti Vaittinen' <mazziesaccount@gmail.com>, Subhajit Ghosh
	<subhajit.ghosh@tweaklogic.com>, Jonathan Cameron <jic23@kernel.org>
CC: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
	<lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: gts-helper: Fix division loop
Thread-Topic: [PATCH] iio: gts-helper: Fix division loop
Thread-Index: AQHaTP9Sjp+SE1amN0CPIjdungerhrDmBFew
Date: Mon, 22 Jan 2024 16:27:13 +0000
Message-ID: <2985a200057c4648817094cf747fca35@AcuMS.aculab.com>
References: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20240107162253.66c1f0f1@jic23-huawei>
 <a41ef2c9-bd74-4b0e-afb7-12e198847609@tweaklogic.com>
 <717b7e70-5cf8-4671-8a6b-005eefd0535e@gmail.com>
In-Reply-To: <717b7e70-5cf8-4671-8a6b-005eefd0535e@gmail.com>
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

RnJvbTogTWF0dGkgVmFpdHRpbmVuDQo+IFNlbnQ6IDIyIEphbnVhcnkgMjAyNCAwNjo1MQ0KPiAN
Cj4gT24gMS8xOS8yNCAxMzo1NiwgU3ViaGFqaXQgR2hvc2ggd3JvdGU6DQo+ID4gT24gOC8xLzI0
IDAyOjUyLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+PiBPbiBUaHUsIDQgSmFuIDIwMjQg
MTE6MzQ6MjggKzAyMDANCj4gPj4gTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFp
bC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+Pj4gVGhlIGxvb3AgYmFzZWQgNjRiaXQgZGl2aXNpb24g
bWF5IHJ1biBmb3IgYSBsb25nIHRpbWUgd2hlbiBkaXZpZGVuZCBpcyBhDQo+ID4+PiBsb3QgYmln
Z2VyIHRoYW4gdGhlIGRpdmlkZXIuIFJlcGxhY2UgdGhlIGRpdmlzaW9uIGxvb3AgYnkgdGhlDQo+
ID4+PiBkaXY2NF91NjQoKSB3aGljaCBpbXBsZW1lbnRhdGlvbiBtYXkgYmUgc2lnbmlmaWNhbnRs
eSBmYXN0ZXIuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxt
YXp6aWVzYWNjb3VudEBnbWFpbC5jb20+DQo+ID4+PiBGaXhlczogMzg0MTZjMjhlMTY4ICgiaWlv
OiBsaWdodDogQWRkIGdhaW4tdGltZS1zY2FsZSBoZWxwZXJzIikNCj4gPj4NCj4gPj4gSG1tLiBG
aXggb3Igbm90IHBlcmYgaW1wcm92ZW1lbnQ/wqAgSSdtIGdvaW5nIHRvIHRha2UgdGhlIG1pZGRs
ZSBncm91bmQNCj4gPj4gYW5kIGxlYXZlIHRoZSBmaXhlcyB0YWcsIGJ1dCBub3QgcnVzaCB0aGlz
IGluLg0KPiA+Pg0KPiA+PiBTbyBhcHBsaWVkIHRvIHRoZSB0b2dyZWcgYnJhbmNoIG9mIGlpby5n
aXQgYW5kIGZvciBub3cganVzdCBwdXNoZWQgb3V0DQo+ID4+IGFzIHRlc3RpbmcgZm9yIDAtZGF5
IGV0YyB0byB0YWtlIGEgbG9vayBiZWZvcmUgSSByZWJhc2UgdGhhdCB0cmVlIGFmdGVyDQo+ID4+
IHJjMS4NCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4+IC0tLQ0KPiA+Pj4NCj4gPj4+IEkndmUgaW1w
bGVtZW50ZWQgYWxzbyBhIGZpeHVwIHNlcmllcyBmb3Igc3VwcG9ydGluZyByb3VuZGluZyBvZg0K
PiA+Pj4gZ2FpbnMvc2NhbGVzOg0KPiA+Pj4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8zN2QzYWExOTNlNjk1NzczNTNkMzE0ZTk0NDYzYTA4ZDQ4OGRkZDhkLjE3MDE3ODA5NjQuZ2l0
Lm1henppZXNhY2NvdW50QGdtDQo+IGFpbC5jb20vDQo+ID4+Pg0KPiA+Pj4gVGhhdCBzZXJpZXMg
ZG9lcyBhbHNvIHJlbW92ZSB0aGUgb2ZmZW5kaW5nIGxvb3AuDQo+ID4+Pg0KPiA+Pj4gV2UgZG9u
J3QgY3VycmVudGx5IGhhdmUgYW55IGluLXRyZWUgdXNlcnMgb2YgR1RTIGhlbHBlcnMgd2hpY2gg
d291bGQNCj4gPj4+IG5lZWQgdGhlIHJvdW5kaW5nIHN1cHBvcnQgc28gcHVzaGluZyB0aGUgcm91
bmRpbmcgaXMgbm90IHVyZ2VudCAoYW5kIEkNCj4gPj4+IGhhdmVuJ3QgaGVhcmQgb2YgU3ViamFo
aXQgd2hvc2UgZHJpdmVyIHJlcXVpcmVkIHRoZSByb3VuZGluZykuIEhlbmNlLCB3ZQ0KPiA+Pj4g
bWF5IHdhbnQgdG8gb25seSB0YWtlIHRoaXMgbG9vcCBmaXggaW4gZm9yIG5vdyAoPykgYW5kIHJl
Y29uc2lkZXINCj4gPj4+IHJvdW5kaW5nIHdoZW4gc29tZW9uZSBuZWVkIHRoYXQuDQoNCldoeSBk
aWQgSSBsb29rIGFzIHRoaXMgY3JhcHB5IGNvZGUgOi0pDQpJIHRoaW5rIHRoZSBjaGFuZ2UgYnJl
YWtzIHRoZSByb3VuZGluZy4NCkZvciAnbm9ybWFsJyB2YWx1ZXMgSSB0aGluayB5b3UganVzdCB3
YW50Og0KCXJldHVybiAxICsgKG1heCAtIDEpL3NjYWxlLg0KDQpUaGUgJ2F2b2lkIG92ZXJmbG93
JyB0ZXN0IGlzbid0IG5lZWRlZCBpZiB5b3Ugc3VidHJhY3QgMSBmcm9tIG1heC4NCihSYXRoZXIg
dGhhbiByZXR1cm4gKG1heCArIHNjYWxlIC0gMSkvc2NhbGU7IHdoZXJlIHRoZSBhZGQgY2FuIG92
ZXJmbG93Lg0KQnV0IHlvdSBkbyBuZWVkIHNvbWV0aGluZyB0byByZXR1cm4gMSAob3IgZXJyb3Ip
IGlmIG1heCBpcyB6ZXJvLg0KDQoJRGF2aWQNCg0KPiA+Pj4NCj4gPj4+IEpvbmF0aGFuLCB3aGF0
J3MgeW91ciB0YWtlIG9uIHRoaXM/DQo+ID4+IEFncmVlZCAtIGxldCB1cyB3YWl0IGZvciB0aGUg
cm91bmRpbmcgdG8gaGF2ZSBhIHVzZXIsIGJ1dCBtYWtlcyBzZW5zZQ0KPiA+PiB0byB0aWR5IHRo
aXMgY29ybmVyIHVwIGluIHRoZSBtZWFudGltZS4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+Pg0K
PiA+PiBKb25hdGhhbg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IMKgIGRyaXZlcnMvaWlvL2luZHVzdHJp
YWxpby1ndHMtaGVscGVyLmMgfCA1ICsrLS0tDQo+ID4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tZ3RzLWhlbHBlci5jDQo+ID4+PiBiL2RyaXZlcnMvaWlv
L2luZHVzdHJpYWxpby1ndHMtaGVscGVyLmMNCj4gPj4+IGluZGV4IDc2NTMyNjFkMmRjMi4uYWJj
YWIyZDM4NTg5IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWd0
cy1oZWxwZXIuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWd0cy1oZWxw
ZXIuYw0KPiA+Pj4gQEAgLTM0LDcgKzM0LDcgQEANCj4gPj4+IMKgIHN0YXRpYyBpbnQgaWlvX2d0
c19nZXRfZ2Fpbihjb25zdCB1NjQgbWF4LCBjb25zdCB1NjQgc2NhbGUpDQo+ID4+PiDCoCB7DQo+
ID4+PiDCoMKgwqDCoMKgIHU2NCBmdWxsID0gbWF4Ow0KPiA+Pj4gLcKgwqDCoCBpbnQgdG1wID0g
MTsNCj4gPj4+ICvCoMKgwqAgaW50IHRtcCA9IDA7DQo+ID4+PiDCoMKgwqDCoMKgIGlmIChzY2Fs
ZSA+IGZ1bGwgfHwgIXNjYWxlKQ0KPiA+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlO
VkFMOw0KPiA+Pj4gQEAgLTQ4LDggKzQ4LDcgQEAgc3RhdGljIGludCBpaW9fZ3RzX2dldF9nYWlu
KGNvbnN0IHU2NCBtYXgsIGNvbnN0DQo+ID4+PiB1NjQgc2NhbGUpDQo+ID4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgdG1wKys7DQo+ID4+PiDCoMKgwqDCoMKgIH0NCj4gPj4+IC3CoMKgwqAgd2hpbGUg
KGZ1bGwgPiBzY2FsZSAqICh1NjQpdG1wKQ0KPiA+Pj4gLcKgwqDCoMKgwqDCoMKgIHRtcCsrOw0K
PiA+Pj4gK8KgwqDCoCB0bXAgKz0gZGl2NjRfdTY0KGZ1bGwsIHNjYWxlKTsNCj4gPj4+IMKgwqDC
oMKgwqAgcmV0dXJuIHRtcDsNCj4gPj4+IMKgIH0NCj4gPj4+DQo+ID4+PiBiYXNlLWNvbW1pdDog
MmNjMTRmNTJhZWI3OGNlM2YyOTY3N2MyZGUxZjA2YzBlOTE0NzFhYg0KPiA+Pg0KPiA+Pg0KPiA+
IEhpIE1hdHRpLA0KPiA+DQo+ID4gWW91ciBmaXggd29ya3MgYmVhdXRpZnVsbHkgd2l0aCB0aGUg
bGF0ZXN0IHZlcnNpb24gb2YgYXBkczkzMDYgZHJpdmVyDQo+ID4gd2hpY2ggSSBhbSB3b3JraW5n
IG9uLg0KPiA+IEFsbCBhdmFpbGFibGUgc2NhbGUgdmFsdWVzIGNhbiBiZSBzZXQgd2l0aG91dCBh
bnkgZXJyb3JzLiBUaGFuayB5b3UuDQo+IA0KPiBUaGFua3MgZm9yIHRlc3RpbmcgU3ViaGFqaXQh
IEp1c3QgdG8gZW5zdXJlIHdlIGhhdmUgbm8gbWlzY29tbXVuaWNhdGlvbg0KPiAtIGRpZCB5b3Ug
dGVzdCBqdXN0IHRoaXMgZGl2aXNpb24gZml4LCBvciB0aGUgcm91bmRpbmcgZml4IGhlcmU6DQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMzdkM2FhMTkzZTY5NTc3MzUzZDMxNGU5NDQ2
M2EwOGQ0ODhkZGQ4ZC4xNzAxNzgwOTY0LmdpdC5tYXp6aWVzYWNjb3VudEBnbQ0KPiBhaWwuY29t
Lw0KPiANCj4gPiBNb3ZpbmcgdG8gYSBuZXcgY2l0eSB3aXRoIGEgbmV3IGZ1bGwgdGltZSBqb2Ig
d2l0aCB0aGUgYXNzdW1wdGlvbiBvZg0KPiA+IGdldHRpbmcgbW9yZSB0aW1lDQo+ID4gZm9yIG15
IGxpc3Qgb2Ygb3BlbnNvdXJjZSBwcm9qZWN0cyBhbmQgY29udHJpYnV0aW9ucyBwcm92ZWQgdG8g
YmUNCj4gPiB1dHRlcmx5IHdyb25nIQ0KPiANCj4gV2VsbCwgSSBjYW4ndCBibGFtZSB5b3UgOikg
QmVpbmcgaW4gYSBuZXcgd29yayBhdCBuZXcgY2l0eSBzb3VuZHMgbGlrZQ0KPiB5b3UgaGF2ZSBh
IGxvdCBvbiB5b3VyIHBsYXRlIHJpZ2h0IG5vdy4gR2l2ZSBpdCBoYWxmIGEgeWVhciBhbmQgdGhp
bmdzDQo+IHdpbGwgc3RhYmlsaXplIHRob3VnaCA6KSBPaCwgYW5kIGZhbHNlbHkgYXNzdW1pbmcg
dGhhdCAid2hlbiBYWFgsIEkgd2lsbA0KPiBoYXZlIHRoZSB0aW1lIHRvIGRvIFlZWSIgLSBiZWVu
IHRoZXJlIGRvbmUgdGhhdCA6KQ0KPiANCj4gR29vZCBsdWNrIG9uIHRoZSBuZXcgd29yayBhbmQg
Y2l0eSENCj4gDQo+IFlvdXJzLA0KPiAJLS0gTWF0dGkNCj4gDQo+IC0tDQo+IE1hdHRpIFZhaXR0
aW5lbg0KPiBMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCj4g
T3VsdSBGaW5sYW5kDQo+IA0KPiB+fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5IHdyb25nIHZpbSB1
c2VycyBjYW4gYWx3YXlzIHR5cGUgOmhlbHAhIH5+DQo+IA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


