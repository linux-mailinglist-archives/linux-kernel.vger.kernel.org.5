Return-Path: <linux-kernel+bounces-126067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C08931AA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0300C281DCC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA71448FF;
	Sun, 31 Mar 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MgU90BNE"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6675813;
	Sun, 31 Mar 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711891311; cv=none; b=IuxmJ6iXDDcr2wHZWOtQS+PRLP5pUJauianhLptqQuTyWMxagSViuvPPdhZNbdCObvq5hTWILimiXwwx2r0iUI1ciyC60fhzPoNNQynoyp8KHLxe3VwkyU1cJ9G5o7Hkrzm9qvrI0VKoj/CF3w5kEqbmhpx6RX/mOI0mSuVfFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711891311; c=relaxed/simple;
	bh=JP6BXX6OedKFrU6XpFRibCbkdjCzL/Y2Jmj83p3ihuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GpF2jFZp0xsDZiV1kFPYZm9LTGEn+pDYQ6MiMEM76oBxI7KHU9eP72WXbbIcJb+jIbqpDiNy8Hcbedkf0a9CV800NHHvSnLfvDymdBzFR+XUSuvdUSqtHzhHh6y71mALetBOdHSFtq47BDOtNJMlcWXdHuVlCik7m7paoeCd3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MgU90BNE; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42VDKdtX050242;
	Sun, 31 Mar 2024 08:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711891239;
	bh=JP6BXX6OedKFrU6XpFRibCbkdjCzL/Y2Jmj83p3ihuU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=MgU90BNEIzlW+PqPvgMx3gCqc+oGSMX6w9IRvH16r2tTtVb+fCUMn/G+b3ulb9NEs
	 GbAldXp6uGPPGlHP7/KXIeJDFLgCvgWWfMaw0MniiEvA/zXr4btAIMQ3nwRJu1A8Pi
	 b0MjWz7iDQHb82ZzJ/fkbSXKWZfPA8Ywf/kBQ1pw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42VDKdtG054458
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 31 Mar 2024 08:20:39 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 31
 Mar 2024 08:20:38 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Sun, 31 Mar 2024 08:20:38 -0500
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org"
	<broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "Chawla, Mohit" <mohit.chawla@ti.com>, "soyer@irl.hu"
	<soyer@irl.hu>,
        "Huang, Jonathan" <jkhuang3@ti.com>, "tiwai@suse.de"
	<tiwai@suse.de>,
        "Djuandi, Peter" <pdjuandi@ti.com>,
        "Agrawal, Manisha"
	<manisha.agrawal@ti.com>,
        "Hari, Raj" <s-hari@ti.com>, "Yashar, Avi"
	<aviel@ti.com>,
        "Nagalla, Hari" <hnagalla@ti.com>,
        "Bajjuri, Praneeth"
	<praneeth@ti.com>,
        "Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
        Rob Herring
	<robh@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v7 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Topic: [EXTERNAL] Re: [PATCH v7 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Index: AQHagxHV9XLbizAWqEeASPd4Xd549bFR1MsA////weA=
Date: Sun, 31 Mar 2024 13:20:38 +0000
Message-ID: <41797fe7d5bb41b4bdea4ee7f4957291@ti.com>
References: <20240331021835.1470-1-shenghao-ding@ti.com>
 <20240331021835.1470-5-shenghao-ding@ti.com>
 <cc7a60c3-4a1e-4f32-b6ef-4a41d5c48eaf@linaro.org>
In-Reply-To: <cc7a60c3-4a1e-4f32-b6ef-4a41d5c48eaf@linaro.org>
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

SGkgS3J6eXN6dG9mDQpBbnN3ZXIgaW5saW5lDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJv
Lm9yZz4NCj4gU2VudDogU3VuZGF5LCBNYXJjaCAzMSwgMjAyNCA0OjE1IFBNDQo+IFRvOiBEaW5n
LCBTaGVuZ2hhbyA8c2hlbmdoYW8tZGluZ0B0aS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBsZ2lyZHdvb2RAZ21haWwuY29tOyBicm9vbmllQGtlcm5lbC5vcmc7IHJv
YmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBj
b25vcitkdEBrZXJuZWwub3JnOyBsaW51eC0NCj4gc291bmRAdmdlci5rZXJuZWwub3JnOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgcGVyZXhAcGVyZXguY3o7DQo+IHRpd2FpQHN1c2UuY29t
OyAxMzkxNjI3NTIwNkAxMzkuY29tOyBDaGF3bGEsIE1vaGl0DQo+IDxtb2hpdC5jaGF3bGFAdGku
Y29tPjsgc295ZXJAaXJsLmh1OyBIdWFuZywgSm9uYXRoYW4NCj4gPGpraHVhbmczQHRpLmNvbT47
IHRpd2FpQHN1c2UuZGU7IERqdWFuZGksIFBldGVyIDxwZGp1YW5kaUB0aS5jb20+Ow0KPiBBZ3Jh
d2FsLCBNYW5pc2hhIDxtYW5pc2hhLmFncmF3YWxAdGkuY29tPjsgSGFyaSwgUmFqIDxzLWhhcmlA
dGkuY29tPjsNCj4gWWFzaGFyLCBBdmkgPGF2aWVsQHRpLmNvbT47IE5hZ2FsbGEsIEhhcmkgPGhu
YWdhbGxhQHRpLmNvbT47IEJhamp1cmksDQo+IFByYW5lZXRoIDxwcmFuZWV0aEB0aS5jb20+OyBC
YW9qdW4uWHVAZnB0LmNvbTsgUm9iIEhlcnJpbmcNCj4gPHJvYmhAa2VybmVsLm9yZz4NCj4gU3Vi
amVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIHY3IDQvNF0gQVNvYzogZHQtYmluZGluZ3M6IFBD
TTYyNDA6IEFkZA0KPiBpbml0aWFsIERUIGJpbmRpbmcNCj4gDQouLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLg0KPiA+ICAtIHJlbW92ZSB1bm5lZWRlZCBpdGVtcyBhbmQgaWYgYnJhbmNoZXMu
DQo+ID4gIC0gQWRkIG1pc3NpbmcgY29tcGF0aWJsZSBkZXZpY2VzLCBzdWNoIGFzIGFkYzYxMjAs
IGV0Yy4NCj4gPiAgLSBBZGQgbmVjZXNzYXJ5IHBlb3BsZSBpbnRvIHRoZSBsaXN0IGZvciBEVFMg
cmV2aWV3DQo+ID4gIC0gY29ycmVjdCBtaXNhbGlnbmVkLg0KPiA+ICAtIHNpbXBsaWZ5IHRoZSBj
b21wYXRpYmlsaXR5DQo+ID4gIC0gcmVtb3ZlIHNvdW5kLW5hbWUtcHJlZml4IGFuZCByZXZlcnQg
YmFjaw0KPiA+ICAtIEFkZCByZXZpZXcgaW5mb3JtYXRpb24NCj4gDQo+IEFsbCB0aGVzZSBjaGFu
Z2VzIGluIHY3IGFuZCB5b3Ugc3RpbGwga2VwdCBSb2IncyByZXZpZXc/IEkgdGhpbmsgZWl0aGVy
IHJldmlldw0KPiB3YXMgbm90IGdpdmVuIG9yIHlvdXIgY2hhbmdlbG9nIGlzIGp1c3QgaW5jb3Jy
ZWN0Lg0KU2luY2UgUm9iJ3MgcmV2aWV3LCBub3RoaW5nIGNoYW5nZWQgaW4geWFtbC4gRXZlbiBp
biB0aGlzIHBhdGNoLCBvbmx5IHJlbW92ZWQga2NvbnRyb2wgaW50ZXJmYWNlcw0KaW4gdGhlIGNv
ZGUgYW5kIGFkZGVkIHRoZSBtaXhlci10ZXN0IHJlcG9ydCBpbiBjb3Zlci1sZXR0ZXIgYXMgTWFy
ayBzdWdnZXN0ZWQsIHdoaWNoIGlzIG5vIGVmZmVjdA0Kb24geWFtbCBmaWxlLg0KPiANCj4gDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

