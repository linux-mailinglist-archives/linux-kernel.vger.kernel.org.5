Return-Path: <linux-kernel+bounces-66625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056A855F23
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937C11F2450F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34636994E;
	Thu, 15 Feb 2024 10:27:44 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B467E97
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992864; cv=none; b=NfZ9L+es13hZNlHodgor/CRB3jvDDkhg2LMx7A6Oc3KCyRKvYJZVFDfcdBC7Gd713Ioqp2CxMFM5KQT5Y9o5HGzNVwTGVU3sdK66A3xcoVfg1wMlCrZpwJaqeFhEIWmn5/7jTI7T93NY+BB7cRQ/eVDTntPpcXXWORh36mdTpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992864; c=relaxed/simple;
	bh=prL9PC3udb58w3aZMdSMRH+nhhgDsJZD+TnwkGx7ZDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=f8akiVm7MOojvRdTwQ3sd3pf3IDBtSFFFV9In8C42cZj8j2wL9PH1olMT3eCa8xryQf1SwV50ujHU3hZYuWpk8vrF4oBWucV08c+SFPJ8K71ZUVCKLiucZhqx4UK02umDVbKPwnP92Z9iixMhe5bqJspB3tlaKtLLaayGEr5d8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-255-qB_rGUUHNDSLRHR0AQmz1Q-1; Thu, 15 Feb 2024 10:27:34 +0000
X-MC-Unique: qB_rGUUHNDSLRHR0AQmz1Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 15 Feb
 2024 10:27:13 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 15 Feb 2024 10:27:13 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Charlie Jenkins
	<charlie@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton
	<akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Thread-Topic: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Thread-Index: AQHaX5nyOY46VuiMM0eMJXXyrPmf2rELMs6w
Date: Thu, 15 Feb 2024 10:27:13 +0000
Message-ID: <a7e9691432374000b9566a0201d004e6@AcuMS.aculab.com>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
In-Reply-To: <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
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

Li4uDQo+IEl0IHdvdWxkIGJlIHdvcnRod2hpbGUgdHJhY2tpbmcgdGhpcyBkb3duIHNpbmNlIHRo
ZXJlIGFyZQ0KPiBsb3RzIG9mIHVuYWxpZ25lZCBkYXRhIGFjY2Vzc2VzICg4LWJ5dGUgYWNjZXNz
ZXMgb24gNC1ieXRlIGFsaWduZWQgYWRkcmVzc2VzKQ0KPiB3aGVuIHJ1bm5pbmcgdGhlIGtlcm5l
bCBpbiA2NC1iaXQgbW9kZS4NCg0KSG1tbS4uLi4NCkZvciBwZXJmb3JtYW5jZSByZWFzb25zIHlv
dSByZWFsbHkgZG9uJ3Qgd2FudCBhbnkgb2YgdGhlbS4NClRoZSBtaXNhbGlnbmVkIDY0Yml0IGZp
ZWxkcyBuZWVkIGFuIF9fYXR0cmlidXRlKChhbGlnbmVkKDQpKSBtYXJrZXIuDQoNCklmIHRoZSBj
aGVja3N1bSBjb2RlIGNhbiBkbyB0aGVtIGl0IHJlYWxseSBuZWVkcyB0byBkZXRlY3QNCmFuZCBo
YW5kbGUgdGhlIG1pc2FsaWdubWVudC4NCg0KVGhlIG1pc2FsaWduZWQgdHJhcCBoYW5kbGVyIHBy
b2JhYmx5IG91Z2h0IHRvIGNvbnRhaW4gYQ0Kd2Fybl9vbl9vbmNlKCkgdG8gZHVtcCBzdGFjayBv
biB0aGUgZmlyc3Qgc3VjaCBlcnJvci4NClRoZXkgY2FuIHRoZW4gYmUgZml4ZWQgb25lIGF0IGEg
dGltZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


