Return-Path: <linux-kernel+bounces-36779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC4983A66E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD86285222
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BE18641;
	Wed, 24 Jan 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AWzq2j1V"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426118625;
	Wed, 24 Jan 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091103; cv=none; b=SbJ5p7lZhi8ASAyRw/P+FW4BFkOYPuyMaaQDCw7XQ5ePnZ0pL1cNmEo1yG+tuqHrQOSutYtm1zr0ENLV8WkILx3FqfzOCZAykF6ZZYUq6WdZd/KMIRb+sc7XvFJOp6keOcPm+lH0Jpk/4dwSDT4xq3wQVXF8iWxetURWeCWW+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091103; c=relaxed/simple;
	bh=P4TiMdGnBlXk6B9G4RS0eICWXVqDgIW0/05r+eH+RK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UgHjN/8Aj49svacY16pWBavSzMZXOV17oU83N/sDYhDFRtSpThevv6y4e1BoL0ydwlNXPM2HY7aLvhbgBN0f0kUsXNaU6rGlXutmv8JDcsmt3zZKQ/jJLHh+STRsTfSfInA4B7EmrRnejBlsdbNb87CZ9/uTXnS0t00VNsQvXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AWzq2j1V; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OAAOw1106496;
	Wed, 24 Jan 2024 04:10:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706091024;
	bh=P4TiMdGnBlXk6B9G4RS0eICWXVqDgIW0/05r+eH+RK0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=AWzq2j1VRmrXDZFZ9kI56+kareeSgaNkPD+9Z2Jj4jQqr0VeUkyaiM4trLIMid1iC
	 peb9uYwLlDrvmEAUKBsqQ7m0ViXZL392TzZNcnS0++eieI1z6caYxyZL/xufhdpasf
	 GmA2R/4VC9QuVtpy9iel1XHL6Hu606OTtLXgiH2s=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OAAOlj030118
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 04:10:24 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 04:10:24 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 24 Jan 2024 04:10:24 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown
	<broonie@kernel.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>, "Xu,
 Baojun" <baojun.xu@ti.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com"
	<liam.r.girdwood@intel.com>,
        "soyer@irl.hu" <soyer@irl.hu>, "Huang, Jonathan"
	<jkhuang3@ti.com>,
        "tiwai@suse.de" <tiwai@suse.de>, "Djuandi, Peter"
	<pdjuandi@ti.com>,
        "McPherson, Jeff" <j-mcpherson@ti.com>,
        "Navada Kanyana,
 Mukund" <navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v1 4/4] ASoc: dt-bindings: Create yaml file
 for pcm6240 codec driver
Thread-Topic: [EXTERNAL] Re: [PATCH v1 4/4] ASoc: dt-bindings: Create yaml
 file for pcm6240 codec driver
Thread-Index: AQHaTe1hznwq6igpf0+r29xPdjuRgbDnplkAgAA8lQCAAACsAIAA1srA
Date: Wed, 24 Jan 2024 10:10:24 +0000
Message-ID: <0e49ab19d9104c92a2d3235f6b322504@ti.com>
References: <20240123111411.850-1-shenghao-ding@ti.com>
 <20240123111411.850-4-shenghao-ding@ti.com>
 <92c1a3f3-6b3b-47cb-a4bf-0d20e4af95e5@linaro.org>
 <9ed437f8-e429-4694-bffc-15931d57a48b@sirena.org.uk>
 <17fac295-5043-411e-8f1e-32f78ffe4027@linaro.org>
In-Reply-To: <17fac295-5043-411e-8f1e-32f78ffe4027@linaro.org>
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBK
YW51YXJ5IDIzLCAyMDI0IDExOjA0IFBNDQo+IFRvOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+DQo+IENjOiBEaW5nLCBTaGVuZ2hhbyA8c2hlbmdoYW8tZGluZ0B0aS5jb20+OyBjb25v
citkdEBrZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGFuZHJpeS5zaGV2Y2hlbmtv
QGxpbnV4LmludGVsLmNvbTsgTHUsIEtldmluIDxrZXZpbi0NCj4gbHVAdGkuY29tPjsgWHUsIEJh
b2p1biA8YmFvanVuLnh1QHRpLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBs
Z2lyZHdvb2RAZ21haWwuY29tOyBwZXJleEBwZXJleC5jejsgcGllcnJlLQ0KPiBsb3Vpcy5ib3Nz
YXJ0QGxpbnV4LmludGVsLmNvbTsgMTM5MTYyNzUyMDZAMTM5LmNvbTsgbGludXgtDQo+IHNvdW5k
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGlhbS5y
LmdpcmR3b29kQGludGVsLmNvbTsgc295ZXJAaXJsLmh1OyBIdWFuZywgSm9uYXRoYW4NCj4gPGpr
aHVhbmczQHRpLmNvbT47IHRpd2FpQHN1c2UuZGU7IERqdWFuZGksIFBldGVyIDxwZGp1YW5kaUB0
aS5jb20+Ow0KPiBNY1BoZXJzb24sIEplZmYgPGotbWNwaGVyc29uQHRpLmNvbT47IE5hdmFkYSBL
YW55YW5hLCBNdWt1bmQNCj4gPG5hdmFkYUB0aS5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
UmU6IFtQQVRDSCB2MSA0LzRdIEFTb2M6IGR0LWJpbmRpbmdzOiBDcmVhdGUgeWFtbCBmaWxlDQo+
IGZvciBwY202MjQwIGNvZGVjIGRyaXZlcg0KPiANCj4gT24gMjMvMDEvMjAyNCAxNjrigIowMSwg
TWFyayBCcm93biB3cm90ZTogPiBPbiBUdWUsIEphbiAyMywgMjAyNCBhdA0KPiAxMjrigIoyNTri
gIowNFBNICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOiA+PiBPbiAyMy8wMS8yMDI0
IDEyOuKAijE0LA0KPiBTaGVuZ2hhbyBEaW5nIHdyb3RlOiA+ID4+PiAtLS0gPj4+IENoYW5nZSBp
biB2MTogPj4+IC0gQ3JlYXRlIHlhbWwNCj4gWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0IFRoaXMg
TWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlciBUaGlzDQo+IG1lc3NhZ2UgY2FtZSBm
cm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uDQo+IA0KPiBaalFjbVFSWUZwZnB0QmFubmVy
RW5kDQo+IE9uIDIzLzAxLzIwMjQgMTY6MDEsIE1hcmsgQnJvd24gd3JvdGU6DQo+ID4gT24gVHVl
LCBKYW4gMjMsIDIwMjQgYXQgMTI6MjU6MDRQTSArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3
cm90ZToNCj4gPj4gT24gMjMvMDEvMjAyNCAxMjoxNCwgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4g
Pg0KPiA+Pj4gLS0tDQo+ID4+PiBDaGFuZ2UgaW4gdjE6DQo+ID4+PiAgLSBDcmVhdGUgeWFtbCBm
aWxlIGZvciBwY202MjQwIGNvZGVjIGRyaXZlcg0KPiA+DQo+ID4+IEkgZG9uJ3QgdW5kZXJzdGFu
ZC4gdjEgaXMgdGhlIGZpcnN0IHZlcnNpb24uIEFnYWluc3Qgd2hhdCBpcyB0aGlzIGNoYW5nZT8N
Cj4gPg0KPiA+IFRoaXMgYXBwZWFycyB0byBiZSBhIHBlcmZlY3RseSBjbGVhciBkZXNjcmlwdGlv
biBvZiB0aGUgY29udGVudHMgb2YNCj4gPiB0aGUgZmlyc3QgdmVyc2lvbiwgaXQncyBhIGNoYW5n
ZSBhZ2FpbnN0IHRoZSB0cmVlIGJlZm9yZSB0aGUgcGF0Y2ggaXMNCj4gPiBhcHBsaWVkLiAgSXQn
cyBhIGJpdCB1bnVzdWFsIHRvIGluY2x1ZGUgYSBwZXIgdmVyc2lvbiBjaGFuZ2Vsb2cgb24gdGhl
DQo+ID4gZmlyc3QgdmVyc2lvbiBidXQgbm90IGEgcHJvYmxlbS4NCj4gPg0KPiA+Pj4gKyAgICBl
bnVtOg0KPiA+Pj4gKyAgICAgIC0gdGksYWRjMzEyMA0KPiA+Pj4gKyAgICAgIC0gdGksYWRjNTEy
MA0KPiA+Pj4gKyAgICAgIC0gdGksYWRjNjEyMA0KPiA+Pj4gKyAgICAgIC0gdGksZGl4NDE5Mg0K
PiA+Pj4gKyAgICAgIC0gdGkscGNtMTY5MA0KPiA+Pj4gKyAgICAgIC0gdGkscGNtMzEyMA0KPiA+
Pj4gKyAgICAgIC0gdGkscGNtMzE0MA0KPiA+Pj4gKyAgICAgIC0gdGkscGNtNTEyMA0KPiA+Pj4g
KyAgICAgIC0gdGkscGNtNTE0MA0KPiA+Pj4gKyAgICAgIC0gdGkscGNtNjEyMA0KPiA+Pj4gKyAg
ICAgIC0gdGkscGNtNjE0MA0KPiA+Pj4gKyAgICAgIC0gdGkscGNtNjI0MA0KPiA+Pj4gKyAgICAg
IC0gdGkscGNtNjI2MA0KPiA+Pj4gKyAgICAgIC0gdGkscGNtOTIxMQ0KPiA+Pj4gKyAgICAgIC0g
dGkscGNtZDMxNDANCj4gPj4+ICsgICAgICAtIHRpLHBjbWQzMTgwDQo+ID4+PiArICAgICAgLSB0
aSxwY21kNTEyeA0KPiA+Pj4gKyAgICAgIC0gdGksdGFhNTIxMg0KPiA+Pj4gKyAgICAgIC0gdGks
dGFhNTQxMg0KPiA+Pj4gKyAgICAgIC0gdGksdGFkNTIxMg0KPiA+Pj4gKyAgICAgIC0gdGksdGFk
NTQxMg0KPiA+DQo+ID4+IEFuZCBub25lIG9mIHRoZW0gYXJlIGNvbXBhdGlibGUgd2l0aCBzb21l
dGhpbmc/DQo+ID4NCj4gPiBObyBpZGVhIGFib3V0IHRoZXNlIHNwZWNpZmljIGNoaXBzIGJ1dCB0
aGF0IHdvdWxkIGJlIGVudGlyZWx5IG5vcm1hbA0KPiA+IGZvciBDT0RFQ3MsIGV2ZW4gd2hlcmUg
dGhpbmdzIGFyZSBzdWJzZXRzIHRoZXJlJ3Mgb2Z0ZW4gc29tZSB0d2Vha3MNCj4gPiBuZWVkZWQg
dG8gaW5pdGlhbGlzYXRpb24gb3Igd2hhdGV2ZXIuDQo+IA0KPiBJIHdhbnQgdG8gZG91YmxlIGNo
ZWNrIHdpdGggdGhlIGF1dGhvci4NCj4gDQpBbGwgdGhlc2UgY2hpcHMgaGF2ZSBvbmx5IGEgc21h
bGwgZmVhdHVyZSBvZiBjb2RlYywgc3VjaCBhcyBBREMgb3IgREFDLA0KYnV0IHRoZWlyIGF1ZGlv
IHBlcmZvcm1hbmNlIGlzIGZhciBzdXBlcmlvciB0byB0aGUgY29kZWMncywgYW5kIGNvc3QgaXMg
bG93ZXIgDQp0aGFuIGNvZGVjLCBhbmQgZWFzaWVyIHRvIHByb2dyYW0gdGhhbiBjb2RlYy4NClNp
bXBseSBvbmUgb3IgdHdvIHJlZ2lzdGVyIHNldHRpbmdzIGNhbiBlbmFibGUgdGhlbSB0byB3b3Jr
LiBJbml0IGZvciANCnRoZXNlIGNoaXBzIGFyZSBoYXJkd2FyZSByZXNldCBvciBzb2Z0d2FyZSBy
ZXNldC4NCkFzIHRvIHNvbWUgYXVkaW8gZmlsdGVyIHBhcmFtcyBmb3IgaW50ZXJuYWwgZmlsdGVy
cywgaXQgaXMgdXAgdG8gdGhlIHNwZWNpYWwgDQp1c2VyIGNhc2VzLCB3aGljaCBjYW4gYmUgc2F2
ZWQgaW50byB0aGUgYmluIGZpbGUuICBUaGUgZGVmYXVsdCB2YWx1ZSBhbHNvIA0KY2FuIHdvcmsg
d2VsbC4NCj4gPg0KPiA+Pj4gKyAgICAgdHdvOiBwY21kZXZpY2VANDggew0KPiA+DQo+ID4+IE5v
ZGUgbmFtZXMgc2hvdWxkIGJlIGdlbmVyaWMuIFNlZSBhbHNvIGFuIGV4cGxhbmF0aW9uIGFuZCBs
aXN0IG9mDQo+ID4+IGV4YW1wbGVzIChub3QgZXhoYXVzdGl2ZSkgaW4gRFQgc3BlY2lmaWNhdGlv
bjoNCj4gPj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZGV2aWNldHJlZS1z
cGVjaWZpY2F0aW9uLnJlYWR0aGVkDQo+ID4+IG9jcy5pby9lbi9sYXRlc3QvY2hhcHRlcjItZGV2
aWNldHJlZS1iYXNpY3MuaHRtbCpnZW5lcmljLW5hbWVzLQ0KPiByZWNvbW0NCj4gPj4NCj4gZW5k
YXRpb25fXztJdyEhRzN2SyFVYVI3T2xWaEladWNEMENNeUJlNGlpWXlXQ2w0a19FeFhKNkhIRzNG
ejNxeTQNCj4gT1BXSA0KPiA+PiBlc05Ucy01N2laOE1qQ1VZZmF4VkxxOE9PR091T1l2a05zdGgt
SDZ5MWNPJA0KPiA+DQo+ID4gUGxlYXNlIGJlIG1vcmUgc3BlY2lmaWMgYWJvdXQgd2hhdCB5b3Un
cmUgbG9va2luZyB0byBzZWUgdGhlcmUuDQo+ID4gcGNtZGV2aWNlIGRvZXNuJ3Qgc2VlbSBwYXJ0
aWN1bGFybHkgbW9yZSBzcGVjaWZpYyB0aGFuIHNvbWV0aGluZyBsaWtlDQo+ID4gZHNwLCBpdCBj
ZXJ0YWlubHkgc2VlbXMgd2l0aGluIHdoYXQgdGhlIHRleHQgZGVzY3JpYmVzLg0KPiANCj4gcGNt
LCBjb2RlYywgYXVkaW8tY29kZWMNCj4gImRldmljZSIgc2VlbXMgcmVkdW5kYW50LCBiZWNhdXNl
IGFsbW9zdCBldmVyeXRoaW5nIGlzIHNvbWUgc29ydCBvZiBkZXZpY2UuDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

