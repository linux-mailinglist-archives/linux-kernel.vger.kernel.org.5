Return-Path: <linux-kernel+bounces-38192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B78083BC41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D451C2287C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6371B95E;
	Thu, 25 Jan 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lTyuOyAp"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39381B948;
	Thu, 25 Jan 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172452; cv=none; b=BRAhQa8fpJhkXvCWMm+6Bi91E1xF2UkHeRei+p/n0UKTJkDRQ/X8xu50R6KnQKADIEqVbWcXED3E2xZfwUSdroX95LV6riiTnpFI9AswjhOD1zLWDEmiBozg3znQwUsRNxYNpdW75BSdgzz0nxOVHUIqArnu8S2JyPbb8VXe2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172452; c=relaxed/simple;
	bh=zSwWF0claKxQzQoWOkji0OUgq92XNb0vOhOBmzc21Qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NW/4kvyWh/Tjx6lyzZ+Vawr9iD6nyHnFMuhZK8jo6PqxPPgC/MwPWSmT5AHmG9i/ujRzab7Jsa0yiIX5iZGrkGPZvR06Hf2th1gJeq7SDJoU8UAU5hrIdZCfxjLfR892nHwOeFZsejII6qCilE1NjZHyY5N29Bh7ruoX2wrAEPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lTyuOyAp; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40P8kaks054089;
	Thu, 25 Jan 2024 02:46:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706172396;
	bh=zSwWF0claKxQzQoWOkji0OUgq92XNb0vOhOBmzc21Qo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=lTyuOyApebTeO4Hz2PF8+GhoZ9ZACZUi78DQ55nT1sh/nahvtGUQc2ZijGmkqSNWq
	 TxoQBRE8/R+Q+BYjqqOpfi8OxTI3kt1paVUEfztf0qlH/1MaRf/9Rfur6b1cs9oxVN
	 5oHG4GLI/jSw3PwlxrFZcQJ7GlleTedvi/QlFTYw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40P8kZ7J040244
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 02:46:36 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 02:46:35 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Thu, 25 Jan 2024 02:46:35 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org"
	<broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "Lu,
 Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
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
Thread-Index: AQHaTe1hznwq6igpf0+r29xPdjuRgbDnplkAgAKAPWCAAGhXgP//qoQg
Date: Thu, 25 Jan 2024 08:46:35 +0000
Message-ID: <c107a70e42eb4327802748cda89d292f@ti.com>
References: <20240123111411.850-1-shenghao-ding@ti.com>
 <20240123111411.850-4-shenghao-ding@ti.com>
 <92c1a3f3-6b3b-47cb-a4bf-0d20e4af95e5@linaro.org>
 <a6c6cad6efc647ba8f0c828ffdb3a54f@ti.com>
 <d8f00ea9-3bb2-4b17-bbc7-48800516e408@linaro.org>
In-Reply-To: <d8f00ea9-3bb2-4b17-bbc7-48800516e408@linaro.org>
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
SmFudWFyeSAyNSwgMjAyNCAzOjUwIFBNDQo+IFRvOiBEaW5nLCBTaGVuZ2hhbyA8c2hlbmdoYW8t
ZGluZ0B0aS5jb20+OyBicm9vbmllQGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmcN
Cj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwu
Y29tOyBMdSwgS2V2aW4NCj4gPGtldmluLWx1QHRpLmNvbT47IFh1LCBCYW9qdW4gPGJhb2p1bi54
dUB0aS5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGdpcmR3b29kQGdtYWls
LmNvbTsgcGVyZXhAcGVyZXguY3o7DQo+IHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVs
LmNvbTsgMTM5MTYyNzUyMDZAMTM5LmNvbTsgbGludXgtDQo+IHNvdW5kQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGlhbS5yLmdpcmR3b29kQGludGVs
LmNvbTsgc295ZXJAaXJsLmh1OyBIdWFuZywgSm9uYXRoYW4NCj4gPGpraHVhbmczQHRpLmNvbT47
IHRpd2FpQHN1c2UuZGU7IERqdWFuZGksIFBldGVyIDxwZGp1YW5kaUB0aS5jb20+Ow0KPiBNY1Bo
ZXJzb24sIEplZmYgPGotbWNwaGVyc29uQHRpLmNvbT47IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQN
Cj4gPG5hdmFkYUB0aS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0gg
djEgNC80XSBBU29jOiBkdC1iaW5kaW5nczogQ3JlYXRlIHlhbWwNCj4gZmlsZSBmb3IgcGNtNjI0
MCBjb2RlYyBkcml2ZXINCj4gDQo+IE9uIDI1LzAxLzIwMjQgMDg64oCKMzksIERpbmcsIFNoZW5n
aGFvIHdyb3RlOiA+PiA+PiBXaHkgZG8geW91IHJlcGVhdCB0aGUNCj4gcmVnIGNvbnN0cmFpbnRz
PyBUaGlzIGRvZXMgbm90IHNlZW0gbmVlZGVkLiA+PiA+Pj4gKyBpbnRlcnJ1cHRzOiBmYWxzZSA+
Pj4NCj4gKyA+Pj4gKyAtIGlmOiA+Pj4gKyBwcm9wZXJ0aWVzOiA+Pj4gWmpRY21RUllGcGZwdEJh
bm5lclN0YXJ0IFRoaXMgbWVzc2FnZQ0KPiB3YXMgc2VudCBmcm9tIG91dHNpZGUgb2YgVGV4YXMg
SW5zdHJ1bWVudHMuDQo+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UgcmVjb2duaXplIHRoZSBzb3VyY2Ugb2YNCj4gdGhpcyBlbWFpbCBhbmQga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gWmpRY21RUllGcGZwdEJhbm5lckVuZA0KPiBPbiAy
NS8wMS8yMDI0IDA4OjM5LCBEaW5nLCBTaGVuZ2hhbyB3cm90ZToNCj4gPj4NCj4gPj4gV2h5IGRv
IHlvdSByZXBlYXQgdGhlIHJlZyBjb25zdHJhaW50cz8gVGhpcyBkb2VzIG5vdCBzZWVtIG5lZWRl
ZC4NCj4gPj4NCj4gPj4+ICsgICAgICAgIGludGVycnVwdHM6IGZhbHNlDQo+ID4+PiArDQo+ID4+
PiArICAtIGlmOg0KPiA+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4+PiArICAgICAgICBjb21w
YXRpYmxlOg0KPiA+Pj4gKyAgICAgICAgICBjb250YWluczoNCj4gPj4+ICsgICAgICAgICAgICBl
bnVtOg0KPiA+Pj4gKyAgICAgICAgICAgICAgLSB0aSxwY20zMTQwDQo+ID4+PiArICAgICAgICAg
ICAgICAtIHRpLHBjbTUxNDANCj4gPj4+ICsgICAgICAgICAgICAgIC0gdGkscGNtNjE0MA0KPiA+
Pj4gKyAgICAgICAgICAgICAgLSB0aSxwY21kMzE4MA0KPiA+Pj4gKyAgICB0aGVuOg0KPiA+Pj4g
KyAgICAgIHByb3BlcnRpZXM6DQo+ID4+PiArICAgICAgICByZWc6DQo+ID4+PiArICAgICAgICAg
IGRlc2NyaXB0aW9uOg0KPiA+Pj4gKyAgICAgICAgICAgIEkyQyBhZGRyZXNzLCBpbiBtdWx0aXBs
ZSBwY21kZXZpY2VzIGNhc2UsIGFsbCB0aGUgaTJjIGFkZHJlc3MNCj4gPj4+ICsgICAgICAgICAg
ICBhZ2dyZWdhdGUgYXMgb25lIEF1ZGlvIERldmljZSB0byBzdXBwb3J0IG11bHRpcGxlIGF1ZGlv
IHNsb3RzLg0KPiA+Pj4gKyAgICAgICAgICBtYXhJdGVtczogNA0KPiA+Pj4gKyAgICAgICAgICBt
aW5JdGVtczogMQ0KPiA+Pg0KPiANCj4gWW91IGRpZCBub3QgcmVzcG9uZCB0byBhbnkgb2Ygb3Ro
ZXIgY29tbWVudHMsIHRoZXJlZm9yZSBJIGFzc3VtZSB5b3UNCj4gYWdyZWUgd2l0aCB0aGVtIDEw
MCUgYW5kIHlvdSB3aWxsIGltcGxlbWVudCB0aGVtIGZ1bGx5Lg0KPiANCj4gDQo+ID4+IERyb3Ag
ZW50aXJlIGlmDQo+ID4gSG93IHRvIGNvbnZleSB0aSxwY20xNjkwIGRvZXMgbm90IHN1cHBvcnQg
aW50ZXJydXB0LCBhbmQgb3RoZXJzDQo+ID4gc3VwcG9ydCBpZiBJIHJlbW92ZSB0aGlzIGlmDQo+
IA0KPiBIb3c/IFRoZXJlIGlzIG5vIHBjbTE2OTAgaGVyZS4NCkhvdyBjYW4gb3RoZXJzIGtub3cg
dGhhdCBwY20zMTQwLCBwY201MTQwLCBwY202MTQwIGFuZCBwY21kMzE4MA0KU3VwcG9ydCBpMmMg
YWRkcmVzcyBmcm9tIDB4NGMgdG8gMHg0ZiwgaWYgdGhpcyBpZiBicmFuY2ggd2FzIHJlbW92ZWQu
DQo+IA0KPiBCVFcsIGFkZCBtaXNzaW5nIGxpbmUgYnJlYWtzLCBlc3BlY2lhbGx5IGJlZm9yZSBu
ZXh0IGJsb2NrcyBsaWtlDQo+IGFkZGl0aW9uYWxQcm9wZXJ0aWVzLg0KQWNjZXB0ZWQNCj4gDQo+
ID4+DQo+ID4+PiArICAgICAgICAgIGl0ZW1zOg0KPiA+Pj4gKyAgICAgICAgICAgIG1pbmltdW06
IDB4NGMNCj4gPj4+ICsgICAgICAgICAgICBtYXhpbXVtOiAweDRmDQo+ID4+PiArDQo+ID4NCj4g
PiBCUg0KPiA+IFNoZW5naGFvIERpbmcNCj4gPg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg0K

