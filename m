Return-Path: <linux-kernel+bounces-128599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF50895CED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EDA1F2219F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280FC15B98D;
	Tue,  2 Apr 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2vaJe/9Q"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD615B97B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086968; cv=none; b=JvcuiOCgsVT4Fo00BtAyrbqTBSahbRXsmHq6ViymlvaZiY1HY735PISsPjc4woDFuPQxCbHNxiNUdt8LcsSlpjwK/WicIVTclKRO4ShslB7iKc3aynI+akab0L9MGoPAVh/mNx9wi72l3UMKJwvBULrH/aouUb9VY0RghoOWNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086968; c=relaxed/simple;
	bh=8ojFUSzgLEbHsabLvFNUZf8962PV4dPkItOhPh64158=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nKabQxymTZ6MPLB7L1gxJmNxGfqv5OIY1ZaG3yq46V1/Qc5dftGFE1ntWGXbkv/TPU0WrMtRSxI01Hq2XeFt/y1duDx+V1mWxbjbGJVzKJCjSQH9XDRjpV7A4+nIu+Lu+lrhrnAQsBVTubxqa5g4m2uW0K1rGViaYpXs/9Dll24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=2vaJe/9Q; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id ABF6E2C03B0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:42:36 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712086956;
	bh=8ojFUSzgLEbHsabLvFNUZf8962PV4dPkItOhPh64158=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=2vaJe/9Q9FfFEoITZTdFoSgpcXWc2mcwnAT/xeOMVOYrTicTaJoSO7Na4BXVWb6R5
	 pTwZgIATFqSbWqKAhxZNPNmVeKAAV8qoQIzlZj6uX+HRRENHY7JCx57D7cT+zA6FHs
	 ICG792ZXC8VgpnO1m/HhsbFWb1lPZB8d/rFKVHz3vg6o9EMvZ4U12dK6tOp2mrGMom
	 RXBcMDVUV6Jg/7CU7xPS4nBgFe7T8ZUTnpeYOiVG5nNv7+CLc6ZN0FpGcTbEkaElB7
	 /xeIpi6gFAU24s0s1y6J1CNK3Ux1qAHUouuHbGdBhZfSuGRttjjtZ99oUONSZlyxtg
	 NyATmtyMBr+iQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B660c5fac0001>; Wed, 03 Apr 2024 08:42:36 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.9; Wed, 3 Apr 2024 08:42:36 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 3 Apr 2024 08:42:36 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Wed, 3 Apr 2024 08:42:36 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uio_pdrv_genirq: convert to use device_property APIs
Thread-Topic: [PATCH] uio_pdrv_genirq: convert to use device_property APIs
Thread-Index: AQHaflbc221U+rfzREuYffxemxf6r7FUlTaA
Date: Tue, 2 Apr 2024 19:42:35 +0000
Message-ID: <1a0ffd16-3ace-4c11-a1fd-2efb5f02e93f@alliedtelesis.co.nz>
References: <20240325015045.778718-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240325015045.778718-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <C71FAD81E4FAE34D85257A87BA0DD6DD@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIH5D0Fo c=1 sm=1 tr=0 ts=660c5fac a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=nMnnotQueRib_lDv3RoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyNS8wMy8yNCAxNDo1MCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gQ29udmVydCB0aGUg
dWlvX3BkcnZfZ2VuaXJxIGRyaXZlciB0byB1c2UgdGhlIGRldmljZV9wcm9wZXJ0eV8qIEFQSXMN
Cj4gaW5zdGVhZCBvZiB0aGUgb2ZfcHJvcGVydHlfKiBvbmVzLiBUaGlzIGFsbG93cyBVSU8gaW50
ZXJydXB0cyB0byBiZQ0KPiBkZWZpbmVkIHZpYSBhbiBBQ1BJIG92ZXJsYXkgdXNpbmcgdGhlIERl
dmljZSBUcmVlIG5hbWVzcGFjZSBsaW5rYWdlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQ
YWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvdWlvL3Vpb19wZHJ2X2dlbmlycS5jIHwgMTEgKysrKysrLS0tLS0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91aW8vdWlvX3BkcnZfZ2VuaXJxLmMgYi9kcml2ZXJzL3Vpby91aW9fcGRydl9n
ZW5pcnEuYw0KPiBpbmRleCA2MzI1OGI2YWNjYzQuLjc3MmFiNDJhM2JhMSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy91aW8vdWlvX3BkcnZfZ2VuaXJxLmMNCj4gKysrIGIvZHJpdmVycy91aW8vdWlv
X3BkcnZfZ2VuaXJxLmMNCj4gQEAgLTIzLDggKzIzLDggQEANCj4gICAjaW5jbHVkZSA8bGludXgv
aXJxLmg+DQo+ICAgDQo+ICAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+IC0jaW5jbHVkZSA8bGlu
dXgvb2ZfcGxhdGZvcm0uaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ICsj
aW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcHJv
cGVydHkuaD4NCj4gICANCj4gICAjZGVmaW5lIERSSVZFUl9OQU1FICJ1aW9fcGRydl9nZW5pcnEi
DQo+ICAgDQo+IEBAIC0xMTAsNyArMTEwLDcgQEAgc3RhdGljIHZvaWQgdWlvX3BkcnZfZ2VuaXJx
X2NsZWFudXAodm9pZCAqZGF0YSkNCj4gICBzdGF0aWMgaW50IHVpb19wZHJ2X2dlbmlycV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIHsNCj4gICAJc3RydWN0IHVpb19p
bmZvICp1aW9pbmZvID0gZGV2X2dldF9wbGF0ZGF0YSgmcGRldi0+ZGV2KTsNCj4gLQlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gKwlzdHJ1Y3QgZndub2Rl
X2hhbmRsZSAqbm9kZSA9IGRldl9md25vZGUoJnBkZXYtPmRldik7DQo+ICAgCXN0cnVjdCB1aW9f
cGRydl9nZW5pcnFfcGxhdGRhdGEgKnByaXY7DQo+ICAgCXN0cnVjdCB1aW9fbWVtICp1aW9tZW07
DQo+ICAgCWludCByZXQgPSAtRUlOVkFMOw0KPiBAQCAtMTI3LDExICsxMjcsMTIgQEAgc3RhdGlj
IGludCB1aW9fcGRydl9nZW5pcnFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gICAJCQlyZXR1cm4gLUVOT01FTTsNCj4gICAJCX0NCj4gICANCj4gLQkJaWYgKCFvZl9wcm9w
ZXJ0eV9yZWFkX3N0cmluZyhub2RlLCAibGludXgsdWlvLW5hbWUiLCAmbmFtZSkpDQo+ICsNClNv
bWVvbmUgb2ZmLWxpc3QgcG9pbnRlZCBvdXQgdGhlIGV4dHJhIG5ld2xpbmUgaGVyZS4gSSdsbCBm
aXggdGhhdCB1cCBpbiANCnYyIChJJ2xsIHdhaXQgYSBiaXQgZm9yIGFueSBvdGhlciBjb21tZW50
cyBiZWZvcmUgc2VuZGluZyB0aGF0IG91dCkuDQo+ICsJCWlmICghZGV2aWNlX3Byb3BlcnR5X3Jl
YWRfc3RyaW5nKCZwZGV2LT5kZXYsICJsaW51eCx1aW8tbmFtZSIsICZuYW1lKSkNCj4gICAJCQl1
aW9pbmZvLT5uYW1lID0gZGV2bV9rc3RyZHVwKCZwZGV2LT5kZXYsIG5hbWUsIEdGUF9LRVJORUwp
Ow0KPiAgIAkJZWxzZQ0KPiAgIAkJCXVpb2luZm8tPm5hbWUgPSBkZXZtX2thc3ByaW50ZigmcGRl
di0+ZGV2LCBHRlBfS0VSTkVMLA0KPiAtCQkJCQkJICAgICAgICIlcE9GbiIsIG5vZGUpOw0KPiAr
CQkJCQkJICAgICAgICIlcGZ3UCIsIG5vZGUpOw0KPiAgIA0KPiAgIAkJdWlvaW5mby0+dmVyc2lv
biA9ICJkZXZpY2V0cmVlIjsNCj4gICAJCS8qIE11bHRpcGxlIElSUXMgYXJlIG5vdCBzdXBwb3J0
ZWQgKi8=

