Return-Path: <linux-kernel+bounces-133299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28AE89A1EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE861C23D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20A0171E45;
	Fri,  5 Apr 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KnqgyD2c"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B51171653
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332357; cv=none; b=KiJFDroURohzrJsyvr4J8UwdRdmRSUp/s0xcl1+2JiKMEqRMrwUJDuDw8DwTRf2AJYUrLcL8Bs212voXK7XX8L150zCySRo5XoFXEMnPIRUe0Hg8EamlpKLuvjslzvauZqvL6mcSoY/Aj3s0NFbAPRFxnFEfvFd7zUwjjRPn+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332357; c=relaxed/simple;
	bh=fcV/lnk1UVa7nCvp3tP9IiiToqsuQWJrAAJgl8OAb1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P8vMxPRvEitju8oOjrZfOkViMug8AzC/QXPaVCVgPdE2lPlXZ/WJ5gknNtnKnofVH8ttbHmQO/zROjYrcBaTCpV7KsKPq4upMQuetIS2iMnSeqpKYpyXk1ici+Yz09S+U+gAFQssbI0wXijBEfC+y8IWWKx/YiYDXBHEVTOUMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KnqgyD2c; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 435FpbI1011641;
	Fri, 5 Apr 2024 10:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712332297;
	bh=fcV/lnk1UVa7nCvp3tP9IiiToqsuQWJrAAJgl8OAb1I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=KnqgyD2cuSCIe+G1XBsR/hm+Dept+4Yhs3oTmQwLorW/r9C5CzyAwgCf1hmn6hLjm
	 /aS9H1xr6UzC3S1Um3DNhUVBNQa9anNO8anO3xeaUHYVGzUykj8t/RdUXqksOhxoom
	 E0c85D+4wPI+tL7EVzu83U9GJmEtzHgLDsJaqz1Y=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 435FpbNI004045
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 10:51:37 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 10:51:36 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.023; Fri, 5 Apr 2024 10:51:36 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Gergo Koteles <soyer@irl.hu>, "tiwai@suse.de" <tiwai@suse.de>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Ding, Shenghao"
	<shenghao-ding@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1 7/8] ALSA: hda/tas2781: Add tas2781
 SPI-based driver
Thread-Topic: [EXTERNAL] Re: [PATCH v1 7/8] ALSA: hda/tas2781: Add tas2781
 SPI-based driver
Thread-Index: AQHafxpR4bcqF619NkOKMcsae5yUWLFLsWeAgA4u1wU=
Date: Fri, 5 Apr 2024 15:51:36 +0000
Message-ID: <a64f246f48f447bc959f9d7591fbc477@ti.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
	 <20240326010905.2147-7-baojun.xu@ti.com>,<a84dd52c7ff74f9c8b84ba2ce2f0a9c2c3f20dae.camel@irl.hu>
In-Reply-To: <a84dd52c7ff74f9c8b84ba2ce2f0a9c2c3f20dae.camel@irl.hu>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
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

SGkgR2VyZ28sDQoNCkFuc3dlciBpbiBsaW5lOg0KDQo+IEZyb206IEdlcmdvIEtvdGVsZXMgPHNv
eWVyQGlybC5odT4NCj4gU2VudDogMjcgTWFyY2ggMjAyNCAxODowMg0KPiBUbzogWHUsIEJhb2p1
bjsgdGl3YWlAc3VzZS5kZQ0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb207IGxnaXJkd29vZEBnbWFpbC5jb207IHBlcmV4QHBlcmV4LmN6
OyBwaWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb207IEx1LCBLZXZpbjsgMTM5MTYy
NzUyMDZAMTM5LmNvbTsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaWFtLnIuZ2lyZHdvb2RAaW50ZWwuY29tOyB5dW5nLWNodWFuLmxp
YW9AbGludXguaW50ZWwuY29tOyBicm9vbmllQGtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVS
TkFMXSBSZTogW1BBVENIIHYxIDcvOF0gQUxTQTogaGRhL3RhczI3ODE6IEFkZCB0YXMyNzgxIFNQ
SS1iYXNlZCBkcml2ZXINCj4gDQo+IEhpIEJhb2p1biwgT24gVHVlLCAyMDI0LTAzLTI2IGF0IDA5
OuKAijA5ICswODAwLCBCYW9qdW4gWHUgd3JvdGU6ID4gRmlybXdhcmUgYmluYXJ5IGxvYWQgbGli
IGNvZGUgZm9yIHRhczI3ODEgc3BpIGRyaXZlci4gPiA+IFNpZ25lZC1vZmYtYnk6IEJhb2p1biBY
dSA8YmFvanVuLuKAinh1QOKAinRpLuKAimNvbT4gPiAtLS0gPiBzb3VuZC9wY2kvaGRhL3RhczI3
ODFfc3BpX2Z3bGliLuKAimMgfCAyMzc0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
IFpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydA0KPiBUaGlzIG1lc3NhZ2Ugd2FzIHNlbnQgZnJvbSBv
dXRzaWRlIG9mIFRleGFzIEluc3RydW1lbnRzLg0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc291cmNlIG9mIHRoaXMgZW1h
aWwgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5u
ZXJFbmQNCj4gDQo+IEhpIEJhb2p1biwNCj4gDQo+IE9uIFR1ZSwgMjAyNC0wMy0yNiBhdCAwOTow
OSArMDgwMCwgQmFvanVuIFh1IHdyb3RlOg0KPiA+IEZpcm13YXJlIGJpbmFyeSBsb2FkIGxpYiBj
b2RlIGZvciB0YXMyNzgxIHNwaSBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYW9q
dW4gWHUgPGJhb2p1bi54dUB0aS5jb20+DQo+ID4gLS0tDQo+ID4gIHNvdW5kL3BjaS9oZGEvdGFz
Mjc4MV9zcGlfZndsaWIuYyB8IDIzNzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIzNzQgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgc291bmQvcGNpL2hkYS90YXMyNzgxX3NwaV9md2xpYi5jDQo+ID4NCj4gDQo+IElzIHRo
aXMgZmlybXdhcmUgbG9hZGluZyBsb2dpYyB0aGUgc2FtZSBhcyB0aGUgYWxyZWFkeSBtZXJnZWQg
dGFzMjc4MS0NCj4gZm13bGliPyBJZiB5ZXMsIHdoeSBkb24ndCB5b3UgdXNlIHRoYXQ/DQpJdCdz
IGFsbW9zdCBzYW1lLCBidXQgb25lIGZpcm13YXJlIHdhcyBsb2FkZWQgaW4gSTJDIG1vZGUgYXMg
b25lIEkyQyBkZXZpY2UNCndhcyBwcm9iZWQsIGFuZCBvcGVyYXRlIHNsYXZlcnMgYnkgYWRkcmVz
cy4gQW5kIHdpdGggU1BJIG1vZGUsIHdlIHByb2JlIHR3bw0KU1BJIGRldmljZXMgaW4gY3VycmVu
dCBjYXNlLCBzbyB3aWxsIGxvYWQgdHdvIGZpcm13YXJlIGJpbmFyeSwgYW5kIHNvbWUNCm9wZXJh
dGlvbiBuZWVkIHRvIGJlIHByb2Nlc3NlZCBhcyBzcGVjaWFsIGNhc2UsIGZvciBleGFtcGxlLCB1
bmRlciBTUEksDQpyZWFkIG5lZWQgb25lIGJ5dGUgc2hpZnRlZCBpZiBwYWdlIG51bWJlciBpcyBs
YXJnZSB0aGFuIDEuDQo+IA0KPiBUaGFua3MsDQo+IEdlcmdvDQo+IA0KPiANCg0K

