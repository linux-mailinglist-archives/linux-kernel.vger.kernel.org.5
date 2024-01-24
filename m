Return-Path: <linux-kernel+bounces-36677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E19A83A4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801C71C215C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4DC17C73;
	Wed, 24 Jan 2024 09:07:53 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62017C6B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087273; cv=none; b=gh9gM1h7sTZ1u0+FRjJ+bCgCNmVPuVGimMlRL1G4mLqw6/sNLiGJ6mNLmiOtHSfvYmnJBpGUgJr5rx+3I1pWvBZwCiQ2U+s4b4iKvGExDHpfRUdbsaqZGuoh9MrXgrzN/BZqB5+LtaYPIr9oaV9bl32YH8/MS6Y/2Fsh7nd3DwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087273; c=relaxed/simple;
	bh=h6J61rqJPR6yrOJp6nbnbQXW9LKyYqM1nKtVVGiwUHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=d2ZYMxFPYY0zRI9Fsj4Rw3rwPll4QwWDd+qfTp1NwaX3pWJ1DBFAjE+OWy0uvfSOJuXDugZv8kxMU/x7/FqVl0HrY7D0s3Q1cmsmbBq3onwX2+4qSy8HwzbB1jZ3pUSY3nnE4Z7L/edovvzFykC1f1jAUJbGGbuhrkzBQUFZo4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-195-pEKiOei1O3SbKHjdW8hZ_w-1; Wed, 24 Jan 2024 09:05:24 +0000
X-MC-Unique: pEKiOei1O3SbKHjdW8hZ_w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jan
 2024 09:04:55 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jan 2024 09:04:55 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Charlie Jenkins' <charlie@rivosinc.com>, Guenter Roeck
	<linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Thread-Topic: [PATCH v3 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Thread-Index: AQHaTl2qLMlMRxxsCEmSh1toHcY3k7Doq2pw
Date: Wed, 24 Jan 2024 09:04:55 +0000
Message-ID: <2235fa55381e481b9252e11463b34720@AcuMS.aculab.com>
References: <20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com>
 <20240123-fix_sparse_errors_checksum_tests-v3-2-efecc7f94297@rivosinc.com>
In-Reply-To: <20240123-fix_sparse_errors_checksum_tests-v3-2-efecc7f94297@rivosinc.com>
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

RnJvbTogQ2hhcmxpZSBKZW5raW5zDQo+IFNlbnQ6IDI0IEphbnVhcnkgMjAyNCAwMDozOQ0KPiAN
Cj4gVGhlIHRlc3QgY2FzZXMgZm9yIGlwX2Zhc3RfY3N1bSBhbmQgY3N1bV9pcHY2X21hZ2ljIHdl
cmUgdXNpbmcgYXJiaXRyYXJ5DQo+IGFsaWdubWVudCBvZiBkYXRhIHRvIGl0ZXJhdGUgdGhyb3Vn
aCByYW5kb20gaW5wdXRzLiBpcF9mYXN0X2NzdW0gc2hvdWxkDQo+IGhhdmUgdGhlIGRhdGEgYWxp
Z25lZCBhbG9uZyAoMTQgKyBORVRfSVBfQUxJR04pIGJ5dGVzIGFuZA0KPiBjc3VtX2lwdjZfbWFn
aWMgc2hvdWxkIGhhdmUgZGF0YSBhbGlnbmVkIGFsb25nIDMyLWJpdCBib3VuZGFyaWVzLg0KPiAN
Ci4uLg0KPiArCTB4OTM1OSwgMHg1NjMwLCAweGQ2NTksIDB4NWI0ZCwgMHg1MTFlLCAweDYyN2Ms
IDB4NGUzMCwgMHg3M2YxLCAweDYzYywNCj4gKwkweGYyZGEsIDB4N2IsCTB4YTk4YiwgMHg0ZmI3
LCAweDg3YTYsIDB4MjUwMCwgMHgzNGU0LCAweGYwY2QsIDB4ZGM2OSwNCj4gKwkweDdiZGUsIDB4
NzNmMCwgMHhkODVkLCAweDcyMmQsIDB4OTc3NiwgMHgzYzgsCTB4N2UwNywgMHhkY2E5LCAweDll
Y2MsDQo+ICsJMHhjNmMwLCAweGJlYzEsIDB4OGRlNSwgMHg2ZjdmLCAweDFhMDksIDB4ZGJlNiwg
MHg3YzRiLCAweDM3ODcsIDB4ZGIzOCwNCj4gKwkweGZhYywJMHhiZWQ5LCAweDMwMzksIDB4NjUw
MSwgMHhhZTFhLCAweGVkODksIDB4ZDk4MiwgMHhjNTMwLCAweGNjZjYsDQo+ICsJMHhkODg4LCAw
eGYzNjksIDB4MmM0ZSwgMHgzOGMwLCAweGNmZjUsIDB4ZGM5ZCwgMHg1OTk4LCAweGUwZDEsIDB4
N2UyMywNCg0KSSdtIHNlZWluZyBzb21lIG9kZCBhbGlnbm1lbnQgaW4gdGhhdCB0YWJsZS4NCkkg
dGhpbmsgdGhlcmUgYXJlICdyYW5kb20nIHRhYnMgZm9sbG93aW5nIHNob3J0IGNvbnN0YW50cy4N
CihOb3QgaGVscGVkIGJ5IG91dHVjayBkZWNpZGluZyB0aGF0IHRhYnMgYXJlIDYgc3BhY2VzISkN
ClByb2JhYmx5IGJldHRlciB0byBhZGQgbGVhZGluZyBzcGFjZXMgKG9yIHplcm9zIGFmdGVyIHRo
ZSAweCkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


