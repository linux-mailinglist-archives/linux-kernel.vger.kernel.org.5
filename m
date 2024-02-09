Return-Path: <linux-kernel+bounces-58916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCE284EE90
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06D81C2474E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5571EBF;
	Fri,  9 Feb 2024 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S1jCk+Ai"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A815CB;
	Fri,  9 Feb 2024 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707441584; cv=none; b=JJB68n0hKcRkY2HWDJN14GtKbkwQ5UVCbrurY5L4Bf2lE9b//dIRFmANVIAqygG5pFnusIwjewVmR1efjle54l0VVhn6onFKbbHYkMRXO1Cmc+U+BMXjXzMv5HXLvUk7D9KxRGc/zDCBT9looqyWmWshkgpDOyoTvH6QUh1YI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707441584; c=relaxed/simple;
	bh=0wVFDmI0+jW33EAXeYu8I6pNcVeSL60c5dCEWwO8FJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PfAtmc3rUo2lzFGWPfIpTjmt0kf5EpEfv+ffwO7IL3Ma/lk0Rv0n5pK2eDe6KDLI1xqRfmCf7pU7S7sDE5mSmxbC9SdiYMpzyZtrKgXQTM9548dbvN/GARQNG1FfobayWVoS3YxkKwxc6Zucut7O/8YrQNM6O4PmsK7nNf9vNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S1jCk+Ai; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4191Iea9131003;
	Thu, 8 Feb 2024 19:18:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707441520;
	bh=0wVFDmI0+jW33EAXeYu8I6pNcVeSL60c5dCEWwO8FJI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=S1jCk+AiNjfeqE71S37Fb2Nnu1ddLJZf9LaD+MVPOxQwg7cXEFPv0i6uFYxB5jGPD
	 xCjgvo7ZSKYIosC7ljpzgcWl7pssmKrKup8bItfrXaOGE3BE0qvXAhRbIRTC+yg9Yo
	 +csjjMC28uY4pQMOfuKTCliaig5uk/gjWtbBxWPg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4191IeTD040651
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 19:18:40 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 19:18:40 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Thu, 8 Feb 2024 19:18:40 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
        "P O,
 Vijeth" <v-po@ti.com>, "Navada Kanyana, Mukund" <navada@ti.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "McPherson, Jeff" <j-mcpherson@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "Chawla, Mohit"
	<mohit.chawla@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
        "Huang, Jonathan"
	<jkhuang3@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
        "Djuandi, Peter"
	<pdjuandi@ti.com>,
        "Agrawal, Manisha" <manisha.agrawal@ti.com>,
        "Hari, Raj"
	<s-hari@ti.com>, "Yashar, Avi" <aviel@ti.com>,
        "Nagalla, Hari"
	<hnagalla@ti.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>
Subject: RE: [PATCH v4 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Thread-Topic: [PATCH v4 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Thread-Index: AQHaWnSfDeO74bOuYEul5lAt29DtqLEA6IQAgAA6qQA=
Date: Fri, 9 Feb 2024 01:18:39 +0000
Message-ID: <0ac563b32399400897b8f3adce6195c3@ti.com>
References: <20240208095255.1508-1-shenghao-ding@ti.com>
 <160173b0-098e-493f-93b1-8b831838e0a0@linux.intel.com>
In-Reply-To: <160173b0-098e-493f-93b1-8b831838e0a0@linux.intel.com>
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

SGkgUGllcnJlDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIGFuc3dlcnMgYXJlIGlubGluZQ0K
TG9va2luZyBmb3J3YXJkIHRvIHlvdXIgY29tbWVudHMuDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDxwaWVycmUtbG91aXMuYm9zc2Fy
dEBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA4LCAyMDI0IDEw
OjM4IFBNDQo+IFRvOiBEaW5nLCBTaGVuZ2hhbyA8c2hlbmdoYW8tZGluZ0B0aS5jb20+OyBicm9v
bmllQGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dz
a2lAbGluYXJvLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2Vy
bmVsLm9yZzsNCj4gYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBsaW51eC1zb3Vu
ZEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpYW0uci5naXJkd29vZEBpbnRlbC5jb207IGxnaXJkd29v
ZEBnbWFpbC5jb207IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBMdSwg
S2V2aW4gPGtldmluLWx1QHRpLmNvbT47IFh1LCBCYW9qdW4gPGJhb2p1bi54dUB0aS5jb20+OyBQ
IE8sIFZpamV0aA0KPiA8di1wb0B0aS5jb20+OyBOYXZhZGEgS2FueWFuYSwgTXVrdW5kIDxuYXZh
ZGFAdGkuY29tPjsNCj4gcGVyZXhAcGVyZXguY3o7IE1jUGhlcnNvbiwgSmVmZiA8ai1tY3BoZXJz
b25AdGkuY29tPjsNCj4gMTM5MTYyNzUyMDZAMTM5LmNvbTsgQ2hhd2xhLCBNb2hpdCA8bW9oaXQu
Y2hhd2xhQHRpLmNvbT47DQo+IHNveWVyQGlybC5odTsgSHVhbmcsIEpvbmF0aGFuIDxqa2h1YW5n
M0B0aS5jb20+OyB0aXdhaUBzdXNlLmRlOyBEanVhbmRpLA0KPiBQZXRlciA8cGRqdWFuZGlAdGku
Y29tPjsgQWdyYXdhbCwgTWFuaXNoYSA8bWFuaXNoYS5hZ3Jhd2FsQHRpLmNvbT47DQo+IEhhcmks
IFJhaiA8cy1oYXJpQHRpLmNvbT47IFlhc2hhciwgQXZpIDxhdmllbEB0aS5jb20+OyBOYWdhbGxh
LCBIYXJpDQo+IDxobmFnYWxsYUB0aS5jb20+OyBCYWpqdXJpLCBQcmFuZWV0aCA8cHJhbmVldGhA
dGkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvNF0gQVNvYzogUENNNjI0MDogQ3Jl
YXRlIFBDTTYyNDAgRmFtaWx5IGRyaXZlcg0KPiBjb2RlDQo+IA0KPiANCj4gDQo+IA0KPiA+ICtz
dGF0aWMgY29uc3QgY2hhciAqY29uc3QgcGNtZGV2X2N0cmxfbmFtZVtdID0gew0KPiA+ICsJIiVz
LWkyYy0lZC1kZXYlZC1jaCVkLWFuYS1nYWluIiwNCj4gPiArCSIlcy1pMmMtJWQtZGV2JWQtY2gl
ZC1kaWdpLWdhaW4iLA0KPiA+ICsJIiVzLWkyYy0lZC1kZXYlZC1jaCVkLWZpbmUtZ2FpbiIsDQo+
ID4gK307DQo+IA0KPiBDb250cm9scyBhcmUgZXhwb3NlZCB0byB1c2VyLXNwYWNlLCBhbmQgaXQg
aGVscHMgaWYgaXQncyBlYXN5IHRvIGlkZW50aWZ5IHdoaWNoDQo+IGRldmljZSBpcyB3aGljaC4N
Cj4gDQo+IEJ1dCBiZWxvdyB5b3UgYXJlIHVzaW5nIHRoZSBJMkMgYWRkcmVzcywgaXMgdGhpcyAn
c3RhYmxlJyBlbm91Z2ggc28gdGhhdA0KPiB1c2Vyc3BhY2UgY2FuIHN0aWxsIGlkZW50aWZ5IHRo
ZSBjb250cm9scyBhbmQgc2V0IHRoZW0gYWNjb3JkaW5nbHkgd2l0aCBhbWl4ZXINCj4gb3IgVUNN
Pw0KPiANClNvIGZhciwgSSBoYXZlIG5vIGdvb2Qgd2F5IHRvIGhhbmRsZSB0aGUgZGV2aWNlcyB3
aXRoIG11bHRpcGxlIHBjbWRldmljZXMgc2l0dGluZyBpbiBkaWZmZXJlbnQgaTJjIGJ1c2VzLg0K
QXMgeW91IGtub3csIHRoZSBnYWluIHZhbHVlIGhpZ2hseSBkZXBlbmRzIG9uIGJvdGggdGhlIG1p
Yy1waG9uZSBwb3NpdGlvbiBhbmQgdGhlIG1pYy1waG9uZSdzIG93bg0KIGNoYXJhY3RlcnMuIEFs
bCB0aGVzZSBjb250cm9scyBoYXZlIHRvIGJlIG9wZW4gdG8gdGhlIHByb2R1Y3QgZGV2ZWxvcGVy
IG9yIG1hbnVmYWN0dXJlci4gVGhleSBtaWdodA0KcmVuYW1lIHRoZW0gcGVyIHRoZWlyIHByb2R1
Y3RzIGlmIHRoZXkgd2FudC4NCkFzIHRvIHRoZSBzdGFibGUsIG15IGN1c3RvbWVycyBhbmQgSSBo
YWQgZGV2ZWxvcGVkIG1hbnkgcHJvZHVjdG9ycyBvbiBhcm0tYmFzZWQgcGFsdGZvcm1zLiBBdCBs
ZWFzdCwgDQp0aGUgaTJjIG51bWJlciBpcyBzYW1lIGFzIHRoZSBvbmUgZGVmaW5lZCBpbiBkdHMu
IA0KPiANCj4gPiArCWVyciA9IHBjbWRldl9kZXZfdXBkYXRlX2JpdHMocGNtX2RldiwgZGV2X25v
LCByZWcsIHZhbF9tYXNrLCB2YWwpOw0KPiA+ICsJaWYgKGVycikNCj4gPiArCQlkZXZfZXJyKHBj
bV9kZXYtPmRldiwgIiVzOnVwZGF0ZV9iaXRzLCBFUlJPUiwgRT0lZFxuIiwNCj4gPiArCQkJX19m
dW5jX18sIGVycik7DQo+IA0KPiBnZW5lcmljIGNvbW1lbnQgZm9yIHRoaXMgcGF0Y2g6IHlvdSBt
YXkgd2FudCB0byBmb2xsb3cgdGhlIHNhbWUNCj4gY29udmVudGlvbiBmb3IgZXJyb3IgbG9nLCBz
b21ldGltZXMgaXQncyAlcywgb3IgJXM6IG9yIG5vICVzDQo+IA0KQWNjZXB0DQo+IA0KPiA+ICtz
dGF0aWMgaW50IHBjbWRldmljZV9jb2RlY19wcm9iZShzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQg
KmNvZGVjKSB7DQo+ID4gKwlzdHJ1Y3QgcGNtZGV2aWNlX3ByaXYgKnBjbV9kZXYgPQ0KPiBzbmRf
c29jX2NvbXBvbmVudF9nZXRfZHJ2ZGF0YShjb2RlYyk7DQo+ID4gKwlzdHJ1Y3QgaTJjX2FkYXB0
ZXIgKmFkYXAgPSBwY21fZGV2LT5jbGllbnQtPmFkYXB0ZXI7DQo+ID4gKwlpbnQgcmV0LCBpLCBq
Ow0KPiA+ICsNCj4gPiArCW11dGV4X2xvY2soJnBjbV9kZXYtPmNvZGVjX2xvY2spOw0KPiA+ICsJ
cGNtX2Rldi0+Y29tcG9uZW50ID0gY29kZWM7DQo+ID4gKwlwY21fZGV2LT5md19zdGF0ZSA9IFBD
TURFVklDRV9GV19MT0FEX09LOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBwY21fZGV2
LT5uZGV2OyBpKyspIHsNCj4gPiArCQlmb3IgKGogPSAwOyBqIDwgMjsgaisrKSB7DQo+ID4gKwkJ
CXJldCA9IHBjbWRldl9nYWluX2N0cmxfYWRkKHBjbV9kZXYsIGksIGopOw0KPiA+ICsJCQlpZiAo
cmV0IDwgMCkNCj4gPiArCQkJCWdvdG8gb3V0Ow0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+
ID4gKwkvKiBkZXZpY2UtbmFtZVtkZWZpbmVkIGluIHBjbWRldmljZV9pMmNfaWRdLWkyYy1idXNf
aWRbMCwxLC4uLixOXS0NCj4gPiArCSAqIHN1bVsxLDIsLi4uLDRdZGV2LXJlZy5iaW4gc3RvcmVz
IHRoZSBmaXJtd2FyZSBpbmNsdWRpbmcgcmVnaXN0ZXINCj4gPiArCSAqIHNldHRpbmcgYW5kIHBh
cmFtcyBmb3IgZGlmZmVyZW50IGZpbHRlcnMgaW5zaWRlIGNoaXBzLCBpdCBtdXN0IGJlDQo+ID4g
KwkgKiBjb3BpZWQgaW50byBmaXJtd2FyZSBmb2xkZXIuIFRoZSBzYW1lIHR5cGVzIG9mIHBjbWRl
dmljZXMgc2l0dGluZw0KPiA+ICsJICogb24gdGhlIHNhbWUgaTJjIGJ1cyB3aWxsIGJlIGFnZ3Jl
Z2F0ZWQgYXMgb25lIHNpbmdsZSBjb2RlYywNCj4gPiArCSAqIGFsbCBvZiB0aGVtIHNoYXJlIHRo
ZSBzYW1lIGJpbiBmaWxlLg0KPiA+ICsJICovDQo+ID4gKwlzY25wcmludGYocGNtX2Rldi0+cmVn
YmluX25hbWUsDQo+IFBDTURFVklDRV9SRUdCSU5fRklMRU5BTUVfTEVOLA0KPiA+ICsJCSIlcy1p
MmMtJWQtJXVkZXYtcmVnLmJpbiIsIHBjbV9kZXYtPmRldl9uYW1lLCBhZGFwLT5uciwNCj4gPiAr
CQlwY21fZGV2LT5uZGV2KTsNCj4gPiArDQo+ID4gKwlyZXQgPSByZXF1ZXN0X2Zpcm13YXJlX25v
d2FpdChUSElTX01PRFVMRSwNCj4gRldfQUNUSU9OX1VFVkVOVCwNCj4gPiArCQlwY21fZGV2LT5y
ZWdiaW5fbmFtZSwgcGNtX2Rldi0+ZGV2LCBHRlBfS0VSTkVMLA0KPiBwY21fZGV2LA0KPiA+ICsJ
CXBjbWRldl9yZWdiaW5fcmVhZHkpOw0KPiANCj4gSSBhbHJlYWR5IGhhZCBhIHF1ZXN0aW9uIGVh
cmx5IG9uIHdoZXRoZXIgdGhlc2UgYWRkcmVzc2VzIGFyZSAnc3RhYmxlJywgYnV0DQo+IGhlcmUg
dGhlIGRldmljZSBhZGRyZXNzIGlzIHVzZWQgdG8gZmV0Y2ggZmlybXdhcmUsIGFuZCB0aGVyZSBp
cyBubyBwcmVmaXggb3INCj4gZGlyZWN0b3J5IHRvIGlkZW50aWZ5IHBsYXRmb3JtLXNwZWNpZmlj
IHNldHRpbmdzLg0KPiANCj4gSSBkb24ndCBrbm93IGhvdyB0aGlzIG1pZ2h0IHdvcmsgZm9yIGEg
ZGlzdHJpYnV0aW9uLiBUaGVyZSBuZWVkcyB0byBiZSBhIHdheQ0KPiB0byBkZXRlY3Qgd2hhdCBz
eXN0ZW0gdGhpcyBpcyBhdCBydW4tdGltZSwgYW5kIG1ha2Ugc3VyZSB3ZSBkb24ndCB1c2UNCj4g
c2V0dGluZ3MgZm9yIHBsYXRmb3JtIFhZWiBvbiBwbGF0Zm9ybSBBQkMuDQo+IA0KSW4gUEMsIGh3
aWQsIHN1YnN5c2lkIGFuZCB2ZW5kb3JpZCBjYW4gaGVscCB0byBpZGVudGlmeSB0aGUgcGxhdGZv
cm0uDQogQnV0IGl0IHNlZW1lZCBkaWZmaWN1bHQgdG8gZ2V0IHBsYXRmb3JtIGlkIG9uIG5vbi1Q
QyBzeXN0ZW0uIE1vcmUgb2Z0ZW4sDQpkaWZmZXJlbnQgcHJvZHVjdG9ycyBmcm9tIGRpZmZlcmVu
dCBjdXN0b21lcnMgbWlnaHQgdXNlIHRoZSBzYW1lIHBsYXRmb3JtLg0KSW4gbXkgdmlldywgdGhl
IHByb2R1Y3RzIGRldmVsb3BlciBvciBtYW51ZmFjdHVyZXIgbWlnaHQgcmVuYW1lIHRoZSBmaXJt
d2FyZQ0KIHBlciB0aGVpciBwcm9kdWN0cyBpZiB0aGV5IHdhbnQsIG5vdCBsaW1pdGVkIHRvIHRo
ZSBwbGF0Zm9ybS4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgcGNtZGV2aWNlX3NldF9kYWlfc3lzY2xr
KHN0cnVjdCBzbmRfc29jX2RhaSAqY29kZWNfZGFpLA0KPiA+ICsJaW50IGNsa19pZCwgdW5zaWdu
ZWQgaW50IGZyZXEsIGludCBkaXIpIHsNCj4gPiArCXN0cnVjdCBwY21kZXZpY2VfcHJpdiAqcGNt
X2RldiA9DQo+IHNuZF9zb2NfZGFpX2dldF9kcnZkYXRhKGNvZGVjX2RhaSk7DQo+ID4gKw0KPiA+
ICsJcGNtX2Rldi0+c3lzY2xrID0gZnJlcTsNCj4gDQo+IGNoZWNrIGNsb2NrIHZhbHVlcz8NCj4g
DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCg0K

