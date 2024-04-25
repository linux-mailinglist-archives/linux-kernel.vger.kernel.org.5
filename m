Return-Path: <linux-kernel+bounces-158157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51918B1C49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7675E1F216F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7C6E61F;
	Thu, 25 Apr 2024 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IbEQ/MkV"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36E6D1B3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031744; cv=none; b=dawx63HoElwztjg33xyEjo3qhzRzGAz9jndat9PsGSwbF8T3x1X5AEHDWwPlY9Qr/KqQhOU5pBMpn3G5BHnsCQiswzE8kOvE8+29CTWGPyUDl5UZOQ7ih7Wrp0PbrwG90HJB15Lxbu5qbmcqQnwVw/0VIPtsx67Cg26+khNhU5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031744; c=relaxed/simple;
	bh=f4v6nriRsTGab93XHaryXtN37sBdVf9QHMiqI5braNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P+jqnu0i0QkyhnoBM79X7rlgCVgDqd/GIO+6ynKxPr1nqmzIEy1bUSgsF9M4SMux7K/RzrSBXLvu3cXbbLeJiIX8WIzVSWNOH26NWb6TslLzSwsVFzJ/USDxncJr0nN6+X8r7K0Wv5X5Dj5lw1u9Gi/LCY6op9sYehmLUfL0oEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IbEQ/MkV; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43P7sg6t080566;
	Thu, 25 Apr 2024 02:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714031682;
	bh=f4v6nriRsTGab93XHaryXtN37sBdVf9QHMiqI5braNY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=IbEQ/MkVMnUGNcEONW5OYhb69SIRfxMra3SEa7Vd2VhjC5lABPSgZv5JZLpjtybdK
	 TAXXcbpNArLye4iaSaIJtlfjARTF5TS1cutpGSlWRdXpubf4ruB7JDpz+r50j1rVgf
	 jtPHhXTDLyF1pyA9+e6Oq7pXkC0EFS9HQz+xWnPg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43P7sgHX093892
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 02:54:42 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 02:54:41 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.023; Thu, 25 Apr 2024 02:54:41 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "tiwai@suse.de" <tiwai@suse.de>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "Ding,
 Shenghao" <shenghao-ding@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "P O, Vijeth" <v-po@ti.com>,
        "Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v3 1/3] ALSA: hda/tas2781: Modification for
 add tas2781 driver for SPI
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/3] ALSA: hda/tas2781: Modification
 for add tas2781 driver for SPI
Thread-Index: AQHakUValxtzw4HJGk6cPNX38MLKCLFuQDOAgApofQE=
Date: Thu, 25 Apr 2024 07:54:41 +0000
Message-ID: <0c7b29075dc347299602668660adb4b6@ti.com>
References: <20240418040240.2337-1-baojun.xu@ti.com>
 <20240418040240.2337-2-baojun.xu@ti.com>,<ZiEKc4OTVlOt8llU@smile.fi.intel.com>
In-Reply-To: <ZiEKc4OTVlOt8llU@smile.fi.intel.com>
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

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KDQo+IEZyb206IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAxOCBB
cHJpbCAyMDI0IDE5OjU2DQo+IFRvOiBYdSwgQmFvanVuDQo+IENjOiB0aXdhaUBzdXNlLmRlOyBy
b2JoK2R0QGtlcm5lbC5vcmc7IGxnaXJkd29vZEBnbWFpbC5jb207IHBlcmV4QHBlcmV4LmN6OyBw
aWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb207IEx1LCBLZXZpbjsgRGluZywgU2hl
bmdoYW87IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQ7IDEzOTE2Mjc1MjA2QDEzOS5jb207IFAgTywg
VmlqZXRoOyBIb2xhbHUgWW9nZW5kcmEsIE5pcmFuamFuOyBhbHNhLWRldmVsQGFsc2EtcHJvamVj
dC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpYW0uci5naXJkd29vZEBpbnRl
bC5jb207IHl1bmctY2h1YW4ubGlhb0BsaW51eC5pbnRlbC5jb207IGJyb29uaWVAa2VybmVsLm9y
Zzsgc295ZXJAaXJsLmh1DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MyAxLzNd
IEFMU0E6IGhkYS90YXMyNzgxOiBNb2RpZmljYXRpb24gZm9yIGFkZCB0YXMyNzgxIGRyaXZlciBm
b3IgU1BJDQo+IA0KPiBPbiBUaHUsIEFwciAxOCwgMjAyNCBhdCAxMjrigIowMjrigIozN1BNICsw
ODAwLCBCYW9qdW4gWHUgd3JvdGU6ID4gSW50ZWdyYXRlIHRhczI3ODEgY29uZmlncyBmb3IgSFAg
TGFwdG9wcy4gRXZlcnkgdGFzMjc4MSBpbiB0aGUgbGFwdG9wID4gd2lsbCB3b3JrIGFzIGEgc2lu
Z2xlIHNwZWFrZXIgb24gU1BJIGJ1cy4gVGhlIGNvZGUgc3VwcG9ydCByZWFsdGVrIGFzIFJlYWx0
ZWsgPiB0aGUgcHJpbWFyeSBjb2RlYy7igIoNCj4gWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0DQo+
IFRoaXMgbWVzc2FnZSB3YXMgc2VudCBmcm9tIG91dHNpZGUgb2YgVGV4YXMgSW5zdHJ1bWVudHMu
DQo+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVj
b2duaXplIHRoZSBzb3VyY2Ugb2YgdGhpcyBlbWFpbCBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLiBJZiB5b3Ugd2lzaCB0byByZXBvcnQgdGhpcyBtZXNzYWdlIHRvIElUIFNlY3VyaXR5LCBw
bGVhc2UgZm9yd2FyZCB0aGUgbWVzc2FnZSBhcyBhbiBhdHRhY2htZW50IHRvIHBoaXNoaW5nQGxp
c3QudGkuY29tDQo+IA0KPiBaalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+IA0KPiBPbiBUaHUsIEFw
ciAxOCwgMjAyNCBhdCAxMjowMjozN1BNICswODAwLCBCYW9qdW4gWHUgd3JvdGU6DQo+ID4gSW50
ZWdyYXRlIHRhczI3ODEgY29uZmlncyBmb3IgSFAgTGFwdG9wcy4gRXZlcnkgdGFzMjc4MSBpbiB0
aGUgbGFwdG9wDQo+ID4gd2lsbCB3b3JrIGFzIGEgc2luZ2xlIHNwZWFrZXIgb24gU1BJIGJ1cy4g
VGhlIGNvZGUgc3VwcG9ydCByZWFsdGVrIGFzDQo+IA0KPiBSZWFsdGVrDQo+IA0KPiA+IHRoZSBw
cmltYXJ5IGNvZGVjLg0KPiANCj4gLi4uDQo+IA0KPiA+ICBzb3VuZC9wY2kvaGRhL0tjb25maWcg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICBzb3Vu
ZC9wY2kvaGRhL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICsrDQo+IA0K
PiBJcyB0aGlzIGNvcnJlY3Q/IFlvdSBhcmUgYWRkaW5nIGEgZGVhZCAiY29kZSIsIGlzbid0IGl0
Pw0KPiANCg0KV2hhdCdzIG1lYW4gImRlYWQgY29kZSI/IEFmdGVyIGFkZCBDT05GSUdfU05EX0hE
QV9TQ09ERUNfVEFTMjc4MV9TUEk9bQ0KaW4gbXkgY29uZmlnIGZpbGUsIHRoZSB3aG9sZSBwYXRj
aCBjb2RlIGhhcyB3b3JrZWQuDQoNCj4gLi4uDQo+IA0KPiBUaGUgcmVzdCBMR1RNLg0KPiANCj4g
LS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCg0KDQpCZXN0
IFJlZ2FyZHMNCkppbQ0KDQo=

