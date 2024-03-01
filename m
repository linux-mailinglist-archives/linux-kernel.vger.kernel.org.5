Return-Path: <linux-kernel+bounces-88125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDE886DDAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AEAB298E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500D6A003;
	Fri,  1 Mar 2024 08:53:10 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D869D2C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283189; cv=none; b=WmXefpDgv2CFSK2+PVmfmSokIOGiYlpa9WT3U19TpQ+G7aXj0BP+ntzX2Rh3h+sDRWnLGHwKe2oKHL89PiSFvvmGCBKM9RKuX1/ItPTISLtcHA3Z2Uxsw0Isiu9YCT3DJKQpIzNsbIZZh8Rz0Mepo8kAHXAIQUdyukKnAU1oarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283189; c=relaxed/simple;
	bh=43QLsBBiCzYOVCHmNXfxTrv0jH3VC2O63gyl2/uo0xo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MUui1I4+jAcD1C+Rv3MmaI20lVTUVsOEDyQEQ/Yc0Bpnv4giRXE1bXhmOHFMVbBzkTWw1fZPyJfsYvP8m3LI+EPehi4HwcjUtYDQFC2q0O6DZtVemN5O0XXnS9quNNpjqac8v19MqaYN3Nj7Tr2y4A3fwbQj5pIaF7OPEcQUS7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-55-2WFfyO3NO_aFW2k655cEVA-1; Fri, 01 Mar 2024 08:53:04 +0000
X-MC-Unique: 2WFfyO3NO_aFW2k655cEVA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Mar
 2024 08:53:03 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Mar 2024 08:53:03 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'H. Peter Anvin'" <hpa@zytor.com>, 'Thorsten Blum'
	<thorsten.blum@toblux.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Wei Liu
	<wei.liu@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/apic: Use div64_ul() instead of do_div()
Thread-Topic: [PATCH] x86/apic: Use div64_ul() instead of do_div()
Thread-Index: AQHaaXLYiXydWB8fRkmBfBNz3Gms8bEh48oggAAxXYCAAH6fUA==
Date: Fri, 1 Mar 2024 08:53:03 +0000
Message-ID: <500833b5660949c8b52b756f1c2acc0e@AcuMS.aculab.com>
References: <20240227114333.1718-2-thorsten.blum@toblux.com>
 <7e46123775e64898bd7c467328125ee0@AcuMS.aculab.com>
 <96394DFF-43D7-4877-AA47-FC847FD26184@zytor.com>
In-Reply-To: <96394DFF-43D7-4877-AA47-FC847FD26184@zytor.com>
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

RnJvbTogSC4gUGV0ZXIgQW52aW4NCj4gU2VudDogMDEgTWFyY2ggMjAyNCAwMTowMg0KPiANCj4g
Pj4NCj4gPj4gQ2hhbmdlIGRlbHRhcG0gdG8gdW5zaWduZWQgbG9uZyBhbmQgcmVwbGFjZSBkb19k
aXYoKSB3aXRoIGRpdjY0X3VsKCkNCj4gPj4gd2hpY2ggZG9lc24ndCBpbXBsaWNpdGx5IGNhc3Qg
dGhlIGRpdmlzb3IgYW5kIGRvZXNuJ3QgdW5uZWNlc3NhcmlseQ0KPiA+PiBjYWxjdWxhdGUgdGhl
IHJlbWFpbmRlci4NCj4gPg0KPiA+RWg/IHRoZXkgYXJlIGVudGlyZWx5IGRpZmZlcmVudCBiZWFz
dHMuDQo+ID4NCj4gPmRvX2RpdigpIGRvZXMgYSA2NCBieSAzMiBkaXZpZGUgdGhhdCBnaXZlcyBh
IDMyYml0IHF1b3RpZW50Lg0KPiA+ZGl2NjRfdWwoKSBkb2VzIGEgbXVjaCBtb3JlIGV4cGVuc2l2
ZSA2NCBieSA2NCBkaXZpZGUgdGhhdA0KPiA+Y2FuIGdlbmVyYXRlIGEgNjRiaXQgcXVvdGllbnQu
DQo+ID4NCj4gPlRoZSByZW1haW5kZXIgaXMgcHJldHR5IG11Y2ggZnJlZSBpbiBib3RoIGNhc2Vz
Lg0KPiA+SWYgYSBjcHUgaGFzIGEgZGl2aWRlIGluc3RydWN0aW9uIGl0IHdpbGwgYWxtb3N0IGNl
cnRhaW5seQ0KPiA+cHV0IHRoZSByZXN1bHQgaW4gb25lIHJlZ2lzdGVyIGFuZCB0aGUgcXVvdGll
bnQgaW4gYW5vdGhlci4NCj4gPg0KPiANCj4gTm90IG9uIGUuZy4gUklTQy1WLg0KDQpJZiB0aGUg
cmVtYWluZGVyIGlzbid0IHVzZWQgdGhlIGNvbXBpbGVyIHNob3VsZCBvcHRpbWlzZQ0KYXdheSBh
bnkgY29kZSB1c2VkIHRvIGdlbmVyYXRlIGl0Lg0KDQpnY2MgaXMgYWxzbyBnZW5lcmF0aW5nIHJh
dGhlciBzdWItb3B0aW1hbCBjb2RlLg0KT24geDg2IGl0IG9ubHkgZG9lcyBvbmUgZGl2aWRlIGZv
ciBjb2RlIHRoYXQgdXNlcyAnYSAvIGInIGFuZA0KJ2EgJSBiJywgYnV0IGZvciByaXNjdiBpdCBk
b2VzIHNlcGFyYXRlIGRpdmlkZSBhbmQgcmVtYWluZGVyDQppbnN0cnVjdGlvbnMuDQpjbGFuZyBk
b2VzIGEgbXVsdGlwbHkgYW5kIHN1YnRyYWN0IGZvciB0aGUgcmVtYWluZGVyLg0KDQpDb21wYXJl
ZCB0byBhbnkgZm9ybSBvZiBkaXZpZGUsIHRoZSBleHRyYSBtdWx0aXBseSBpcyBub2lzZS4NCg0K
Z2NjIGFsc28gcGVzc2ltaXNlcyBhdHRlbXB0cyB0byBjYWxjdWxhdGUgdGhlIHJlbWFpbmRlcjoN
Cmh0dHBzOi8vZ29kYm9sdC5vcmcvei9Ub2poMXFjdnMNCg0KQXJlIHRoZSBpbnN0cnVjdGlvbiB3
ZWlnaHRzIHNldCBjb3JyZWN0bHkgZm9yIGRpdmlkZS9yZW1haW5kZXI/DQpJdCBpcyBhbG1vc3Qg
YXMgdGhvdWdoIGdjYyB0aGlua3MgcmVtYWluZGVyIGlzIGZhc3QuDQoNCkFjdHVhbGx5IEkgc3Vz
cGVjdCBldmVuIHRoZSA2NCBieSAzMiBkaXZpZGUgaXMgYSBzb2Z0d2FyZSBsb29wDQpvbiByaXNj
diAoMzJiaXQpLg0KTm90IGNoZWNrZWQgYnV0IEkgc3VzcGVjdCB0aGUgaW1wbGVtZW50YXRpb25z
IChlc3AgZnBnYSBvbmVzKSB3b24ndA0KYWxsb3cgMyBpbnB1dHMgdG8gdGhlIEFMVS4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==


