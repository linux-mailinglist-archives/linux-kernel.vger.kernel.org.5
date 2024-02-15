Return-Path: <linux-kernel+bounces-67602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718F0856DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEEF1F22E75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FAF13A254;
	Thu, 15 Feb 2024 19:42:01 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039ED41A81
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026120; cv=none; b=kcVfay4OghbgVKhiK1i0iPhAjhdkYzvuE44BMd1cmDIbHDv0p0/UK0XsP44zNIvT6q/uJ9ExJZMMWS95gHE2h+013k2rd7A8mmp95sO9wWKMvXJuYMvnSIXja5w2qhRGRaabHCY1dvaycp7EGouYlSzsfsP/Th/84Lrs3nLE/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026120; c=relaxed/simple;
	bh=GWsz28RPEeyxDledexnM/DybfA0WQodYu/B3d0s/XzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NceDfBiFJCCzMLbZ2AeimP5BnZ84GBBuq6owRvSQEn/bdmkpN94nToKEntMKnO8FrvjyShz37xHdmTu077BFVETPYFH2jbNpd0OeCyVlODbr1xozF83sLQc9dnb0wjBfcwhcPEQUVf/chSUnTg9LSza4TLS81wotmxrY8FSUaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-183-Xde-CPXnNa6p2PpMK5A5fg-1; Thu, 15 Feb 2024 19:41:56 +0000
X-MC-Unique: Xde-CPXnNa6p2PpMK5A5fg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 15 Feb
 2024 19:41:33 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 15 Feb 2024 19:41:33 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, John David Anglin
	<dave.anglin@bell.net>, Charlie Jenkins <charlie@rivosinc.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Thread-Topic: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Thread-Index: AQHaX5nyOY46VuiMM0eMJXXyrPmf2rELMs6wgACLYRWAAA6AYA==
Date: Thu, 15 Feb 2024 19:41:33 +0000
Message-ID: <ef2785806bb34b4688888063edab0588@AcuMS.aculab.com>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <a7e9691432374000b9566a0201d004e6@AcuMS.aculab.com>
 <c22f28a2-b042-4abe-b9e4-a925b97073bb@roeck-us.net>
 <4723822c-2acf-4c41-899c-1e3d5659d1d8@bell.net>
 <1e302d8f-4e94-4278-b556-b8fc54956efb@roeck-us.net>
 <e73bdc36-5fb1-4ea8-9f96-608eb1a9b6af@bell.net>
 <a7b70196-2387-4532-94ac-81220fd07088@roeck-us.net>
In-Reply-To: <a7b70196-2387-4532-94ac-81220fd07088@roeck-us.net>
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

Li4uDQo+ID4gRGVzY3JpcHRvcnMgbmVlZCA4LWJ5dGUgYWxpZ25tZW50IGZvciBlZmZpY2llbmN5
IG9uIDY0LWJpdCBwYXJpc2MuIFRoZSBwYyBhbmQgZ3AgYXJlIGFjY2Vzc2VkDQo+ID4gdXNpbmcg
bGRkIGluc3RydWN0aW9ucy4NCj4gPg0KPiANCj4gSG93IGFib3V0IHRoZSBwYXRjaCBiZWxvdyA/
DQoNCkkgdGhpbmsgeW91IHN0aWxsIG5lZWQgc29tZXRoaW5nIHRvIGF2b2lkIHRoZSBtaXNhbGln
bm1lbnQgdHJhcA0KaW4gdGhlICdmYWxzZScgY2FzZS4NCg0KSWYgdGhleSBvbmx5IG5lZWQgdG8g
YmUgYWxpZ25lZCAnZm9yIGVmZmljaWVuY3knIHRoZW4gSSdkIGFzc3VtZQ0KdGhlIGNwdSAob3Ig
d2hhdGV2ZXIgbm9ybWFsbHkgcHJvY2Vzc2VzIHRoZW0pIGlzIG9rIHdpdGggNC1ieXRlDQphbGln
bm1lbnQgZXZlbiB0aG91Z2ggJ2xkZCcgKDggYnl0ZSBsb2FkPykgZmF1bHRzLg0KDQpXaGljaCB3
b3VsZCBtZWFuIHlvdSBuZWVkIHRvIHJlYWQgdGhlbSB3aXRoIHR3byA0LWJ5dGUgbG9hZHMuDQoN
CkVzcGVjaWFsbHkgaWYgJ2ZuJyBpc24ndCBqdXN0IG9uZSBvZiBhIGNvdXBsZSBvZiBzcGVjaWZp
YyB2YWx1ZXMNCnRoYXQgY2FuIGJlIGZvcmNlZCB0byBiZSBhbGlnbmVkLg0KDQpCdXQgdGhlIGNv
ZGUgbWlnaHQganVzdCBiZSBjb21wbGV0ZWx5IGJyb2tlbi4NCihhcyBzdWdnZXN0ZWQgZWxzZXdo
ZXJlKS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


