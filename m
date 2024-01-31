Return-Path: <linux-kernel+bounces-46410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F3843F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167C81F2876B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B937869A;
	Wed, 31 Jan 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aEjEsiyB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB107319D;
	Wed, 31 Jan 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703511; cv=none; b=p/bmGFB93dP/KIga110X+pyCUC+TWaPWfhR54RY/UsnvjHzqrdTNXqcB0xqoYabmFGruNJwAmHk+1m0Sp7TYBZx9oRFYTUajs1uxP9QKfPq7OcoAvBX+qSSpBHQO3Xtz9R+o94JOTiRLaBljX2FSCY2MK8NZImrWk+2VvGs90+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703511; c=relaxed/simple;
	bh=kY/nfN3StEs524jZ+xz9fo8BvAXypmxWDqDm3ovUVqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6Ap+Ydzpi1edLp9pgX0d/yg3UHjyf3BUrroiLffGo6sliMr5wmeuHr++Q9U27Bn84m8IODdEJslV86BIYr3KU5PHWmXK0zeemCZJLiT5ICX0gEmHP0VwjIgJ0TWWh/lggqx2BrFH8Hn7Giq+HXQFcoaMxfiHIunadlTE0bu6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aEjEsiyB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VCHOVH100330;
	Wed, 31 Jan 2024 06:17:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706703444;
	bh=kY/nfN3StEs524jZ+xz9fo8BvAXypmxWDqDm3ovUVqs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=aEjEsiyBJvl9pQuDYfuzgOGq33WSNU676/e9e3JTOrwbruuuS8EkZFwIsQWFmSSSh
	 wGbucqPdRgMvon0Xr58LD6lTgYtCaoR2JZk/ZqMoF0raUZFNfyzP6QvxPBtP1oyCgT
	 OE+5pTwSQlyrUv+FapZeg8KGyzvO/Wf4mkhNGc5Q=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VCHOoe018987
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 06:17:24 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 06:17:23 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 31 Jan 2024 06:17:23 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>, "Xu,
 Baojun" <baojun.xu@ti.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "P O, Vijeth" <v-po@ti.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "Chawla, Mohit" <mohit.chawla@ti.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "soyer@irl.hu"
	<soyer@irl.hu>, "Huang, Jonathan" <jkhuang3@ti.com>,
        "tiwai@suse.de"
	<tiwai@suse.de>, "Djuandi, Peter" <pdjuandi@ti.com>,
        "McPherson, Jeff"
	<j-mcpherson@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        Mark Brown
	<broonie@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Topic: [EXTERNAL] Re: [PATCH v2 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Index: AQHaUAwUI8E/PZj0r0in3/wm+owNo7DsJ5KAgABZ9gCAA7KFIIACwEkAgADnt+A=
Date: Wed, 31 Jan 2024 12:17:23 +0000
Message-ID: <d3655fa4a6854ed5a19c8764885295dd@ti.com>
References: <20240126035855.1785-1-shenghao-ding@ti.com>
 <20240126035855.1785-4-shenghao-ding@ti.com>
 <f7a2de19-55c5-4aa9-b0a8-632f22b6c147@linaro.org>
 <f5357751-ed4d-49ad-9d65-199c49f4cbdf@sirena.org.uk>
 <015abf2c43a44c478726c270bfa17fc0@ti.com>
 <dc867ca4-e579-47f5-8490-ebefbc3c2875@linaro.org>
In-Reply-To: <dc867ca4-e579-47f5-8490-ebefbc3c2875@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgMzEsIDIwMjQgMTI6MTggQU0NCj4gVG86IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hh
by1kaW5nQHRpLmNvbT4NCj4gQ2M6IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVs
Lm9yZzsNCj4gYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBMdSwgS2V2aW4gPGtl
dmluLWx1QHRpLmNvbT47IFh1LCBCYW9qdW4NCj4gPGJhb2p1bi54dUB0aS5jb20+OyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgUCBPLCBWaWpldGggPHYtDQo+IHBvQHRpLmNvbT47IGxnaXJk
d29vZEBnbWFpbC5jb207IHBlcmV4QHBlcmV4LmN6OyBwaWVycmUtDQo+IGxvdWlzLmJvc3NhcnRA
bGludXguaW50ZWwuY29tOyAxMzkxNjI3NTIwNkAxMzkuY29tOyBDaGF3bGEsIE1vaGl0DQo+IDxt
b2hpdC5jaGF3bGFAdGkuY29tPjsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlhbS5yLmdpcmR3b29kQGludGVsLmNvbTsgc295
ZXJAaXJsLmh1OyBIdWFuZywNCj4gSm9uYXRoYW4gPGpraHVhbmczQHRpLmNvbT47IHRpd2FpQHN1
c2UuZGU7IERqdWFuZGksIFBldGVyDQo+IDxwZGp1YW5kaUB0aS5jb20+OyBNY1BoZXJzb24sIEpl
ZmYgPGotbWNwaGVyc29uQHRpLmNvbT47IE5hdmFkYQ0KPiBLYW55YW5hLCBNdWt1bmQgPG5hdmFk
YUB0aS5jb20+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJl
OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjIgNC80XSBBU29jOiBkdC1iaW5kaW5nczogUENNNjI0
MDoNCj4gQWRkIGluaXRpYWwgRFQgYmluZGluZw0KPiANCj4gT24gMjkvMDEvMjAyNCAwNTrigIo0
MywgRGluZywgU2hlbmdoYW8gd3JvdGU6ID4+ID4+IE9uIEZyaSwgSmFuIDI2LCAyMDI0IGF0DQo+
IDA5OuKAijI3OuKAijQ3QU0gKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6ID4+PiBP
biAyNi8wMS8yMDI0IDA0OuKAijU4LA0KPiBTaGVuZ2hhbyBEaW5nIHdyb3RlOiA+PiA+Pj4+ICsg
LSBpZjogPj4+PiArIHByb3BlcnRpZXM6DQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydCBUaGlz
IG1lc3NhZ2Ugd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIFRleGFzDQo+IEluc3RydW1lbnRzLg0K
PiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29n
bml6ZSB0aGUgc291cmNlIG9mDQo+IHRoaXMgZW1haWwgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4gT24gMjkvMDEvMjAyNCAwNTo0
MywgRGluZywgU2hlbmdoYW8gd3JvdGU6DQo+ID4+DQo+ID4+IE9uIEZyaSwgSmFuIDI2LCAyMDI0
IGF0IDA5OjI3OjQ3QU0gKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+PiBP
biAyNi8wMS8yMDI0IDA0OjU4LCBTaGVuZ2hhbyBEaW5nIHdyb3RlOg0KPiA+Pg0KPiA+Pj4+ICsg
IC0gaWY6DQo+ID4+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4+Pj4gKyAgICAgICAgY29tcGF0
aWJsZToNCj4gPj4+PiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+Pj4+ICsgICAgICAgICAgICBl
bnVtOg0KPiA+Pj4+ICsgICAgICAgICAgICAgIC0gdGkscGNtMTY5MA0KPiA+Pj4+ICsgICAgdGhl
bjoNCj4gPj4+PiArICAgICAgcHJvcGVydGllczoNCj4gPj4+PiArICAgICAgICByZWc6DQo+ID4+
Pj4gKyAgICAgICAgICBpdGVtczoNCj4gPj4+PiArICAgICAgICAgICAgbWluaW11bTogMHg0Yw0K
PiA+Pj4+ICsgICAgICAgICAgICBtYXhpbXVtOiAweDRmDQo+ID4+DQo+ID4+PiBOb3RoaW5nIGlt
cHJvdmVkLg0KPiA+Pg0KPiA+PiBTaGVuZ2hhbyBleHBsYWluZWQgd2hhdCB3aGF0IHRoaXMgaXMg
ZG9pbmcgLSBJJ20gbm90IHN1cmUgd2hhdCB0aGUNCj4gPj4gYWN0dWFsIHByb2JsZW0gaXMgaGVy
ZT8gIEl0J3MgYW4gYWN0dWFsIHJlc3RyaWN0aW9uIG9uIHRoZSB2YWx1ZXMgdGhhdCBhcmUNCj4g
dmFsaWQuDQo+ID4NCj4gPiBIaSwgS3J6eXN6dG9mLiBNYXkgSSBoYXZlIHRoZSBwcml2aWxlZ2Ug
dG8gcGV0aXRpb24gb24gYmVoYWxmIG9mIG15DQo+ID4gY3VzdG9tZXJzPyBUaGV5IHdhbnQgdG8g
a2VlcCB0aGVzZSBpZiBicmFuY2hlcyBhbmQgdGhlIGkyYyBhZGRyZXNzIGluDQo+ID4geWFtbCBm
aWxlLiBBcyB5b3Uga25vdywgbW9zdCBvZiBteSBjdXN0b21lcnMgdXNlZCB0byBtYWtlIG1pc3Rh
a2VzIGFuZA0KPiA+IGNvbmZ1c2Ugd2l0aCB0aGUgaTJjIGFkZHJlc3MuIExpc3RpbmcgdGhlbSBo
ZXJlIGNhbiBoZWxwIHRoZW0gdG8gZ2V0IHRoZQ0KPiBpbmZvcm1hdGlvbiBlYXNpbHkuDQo+IA0K
PiBUbyB3aGljaCBjYXNlcyB0aGlzIGV4Y2VwdGlvbiB3aWxsIGFwcGx5PyBZb3VyIHBhdGNoZXMs
IGFsbCBUST8NCj4gDQpTb21lIEFJIGN1c3RvbWVycyB1c3VhbGx5IGxpa2UgdG8gdHJ5IHNvbWUg
aW5ub3ZhdGl2ZSBwcm9qZWN0cywgc3VjaCBhcyB0aGVpciBtdWx0aXBsZS1zbG90IFRETSANCmRl
dmljZXMgd2l0aCBzZXJ2YWwgZGlmZmVyZW50IEFEQ3Mgb3IgREFDIG9uIGRpZmZlcmVudCBpMmMg
YnVzZXMuIFRyYWRpdGlvbmFsIGRyaXZlciBjb2RlIHJlYWxseSANCmNhbid0IG1lZXQgdGhlaXIg
cmVxdWlyZW1lbnRzLg0KPiBCaW5kaW5ncyBhcmUgbm90IHN1cHBvc2VkIHRvIGJlIHNvIGRldGFp
bGVkIHRvIGNyZWF0ZSBEVFMgb3V0IGlmIGl0LCBiZWNhdXNlIGl0DQo+IG1ha2VzIHRoZW0gbW9y
ZSBkaWZmaWN1bHQgdG8gbWFpbnRhaW4uIFN1Y2ggYW1vdW50IG9mDQo+IGlmOnRoZW46IG1ha2Vz
IGl0IHRyaWNraWVyLCBmb3Igbm8gcmVhbCBnYWluLg0KPiANCkFjY2VwdA0KDQogQmVzdCByZWdh
cmRzLA0KU2hlbmdoYW8gRGluZw0KDQo=

