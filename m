Return-Path: <linux-kernel+bounces-92000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D262D87198F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50BC1C220D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15C552F6B;
	Tue,  5 Mar 2024 09:27:01 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59DF50272
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630821; cv=none; b=qmBWKxf6hai4wB4rZcUtjl8mYvWmIFb9TFhf7ZESjZ1l7/mjEI5hVIQrnMUGtzpcrcxdnODwzJfdyLZIUqV8M0WXp50q03qTdQe+U3gQLDPOsGvgvr4/4+c+H8sqX5foQMzrOW3DzXFpQg3r8apXpVU4L7H14lj2HqVXMKqUqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630821; c=relaxed/simple;
	bh=LrRp2oHJmVrObhpCmaCXYk8T8eMjQU7jJNMaJrEo3c0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=SP3xKz6/tqEBjGNzK/SNbV878yp5WgXNJVkRGpH9Llvq3zVwCSOL2YdsQWjEUGt/Vgxr2v22vZPK59W8pT8agL1BIJppVHp8Q7fYRm0J9rCmigUJFmdnjoo6hCOvUsoq69SHmaSXdNC3eSi/dETtHgbsz8BEc56iu0LLA2+OKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-312-sCqIcKGYOf6ZeDr-o4ocrw-1; Tue, 05 Mar 2024 09:26:51 +0000
X-MC-Unique: sCqIcKGYOf6ZeDr-o4ocrw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Mar
 2024 09:27:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 5 Mar 2024 09:27:22 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Guenter Roeck <linux@roeck-us.net>, "Russell
 King" <linux@armlinux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Charlie Jenkins <charlie@rivosinc.com>, "James
 E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller
	<deller@gmx.de>, Palmer Dabbelt <palmer@rivosinc.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, "Parisc
 List" <linux-parisc@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHabjlz2G6zh0QEYUOonhCQoX0NCrEo3thA
Date: Tue, 5 Mar 2024 09:27:22 +0000
Message-ID: <55a6df07d26849e89c839f80ca5996b9@AcuMS.aculab.com>
References: <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
 <62b69aaf-7633-4bd8-aefe-5ba47147dba7@roeck-us.net>
 <f422742a-4c86-4cb0-a4f7-a62f0310eb23@csgroup.eu>
 <6df98c91-26b1-497a-9202-18bf86c0130d@roeck-us.net>
 <4e227412-ccac-4771-8aa6-a716e7c07090@csgroup.eu>
 <a254a52c-340d-47ba-9a69-b5144dc75e4e@app.fastmail.com>
In-Reply-To: <a254a52c-340d-47ba-9a69-b5144dc75e4e@app.fastmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwNCBNYXJjaCAyMDI0IDEzOjQwDQouLi4NCj4g
PiBJZiBub3QsIHRoZW4gdGhlIHRlc3QgaGFzIHRvIGJlIGZpeGVkIHRvIG9ubHkgdXNlIHdvcmQt
YWxpZ25lZCBJUHY2DQo+ID4gYWRkcmVzc2VzLg0KPiANCj4gQmVjYXVzZSBvZiB0aGUgZ2NjIGlz
c3VlIEkgbWVudGlvbmVkLCBuZXQvaXB2Ni9pcDZfY2hlY2tzdW0uYw0KPiBhbmQgYW55dGhpbmcg
ZWxzZSB0aGF0IGFjY2Vzc2VzIG1pc2FsaWduZWQgaXB2NiBoZWFkZXJzIG1heSBuZWVkDQo+IHRv
IGJlIGNoYW5nZWQgYXMgd2VsbC4gTWFya2luZyBpbjZfYWRkciBhcyAnX19wYWNrZWQgX19hbGln
bmVkKDIpJw0KPiBzaG91bGQgYmUgc3VmZmljaWVudCBmb3IgdGhhdC4gVGhpcyB3aWxsIHByZXZl
bnQgZ2NjIGZyb20gaXNzdWluZw0KPiBsZG0gb3IgbGRyZCBvbiBBUk12NisgYXMgd2VsbCBhcyBt
YWtpbmcgb3B0aW1pemF0aW9uIGJhc2VkIG9uDQo+IHRoZSB0d28gbG93ZXIgYml0cyBvZiB0aGUg
YWRkcmVzcyBiZWluZyB6ZXJvIG9uIHg4NiBhbmQgb3RoZXJzLg0KDQpFaD8geDg2IHByZXR0eSBt
dWNoIGRvZXNuJ3QgY2FyZSB1bmxlc3MgeW91IGFyZSB1c2luZyBBVlguDQoNCj4gVGhlIGRvd25z
aWRlIGlzIHRoYXQgaXQgZm9yY2VzIDE2LWJpdCBsb2FkcyBhbmQgc3RvcmVzIHRvIGJlDQo+IHVz
ZWQgb24gYXJjaGl0ZWN0dXJlcyB0aGF0IGRvbid0IGhhdmUgZWZmaWNpZW50IHVuYWxpZ25lZA0K
PiBhY2Nlc3MgKGFybXY1LCBhbHBoYSwgbWlwcywgc3BhcmMgYW5kIHh0ZW5zYSBhbW9uZyBvdGhl
cnMpDQo+IGV2ZW4gd2hlbiB0aGUgSVAgaGVhZGVycyBhcmUgZnVsbHkgYWxpZ25lZC4NCg0KQXJl
bid0IHRoZSBsYXRlciBhY2Nlc3NlcyB0byB0aGUgaGVhZGVyIGFsc28gZ29pbmcgdG8gZmF1bHQ/
DQpJSVJDIHRoZXJlIGlzIGFuIHNrYl9wdWxsKCkgY2FsbCB0byBlbnN1cmUgYWxsIHRoZSBJUCBo
ZWFkZXINCmlzIGluIHRoZSBsaW5lYXIgc2tiIGZyYWdtZW50Pw0KUGVyaGFwcyB0aGVyZSBzaG91
bGQgYmUgYW4gc2tiX3B1bGxfYWxpZ25lZCgpIHRoYXQgd2lsbCBlbnN1cmUNCnRoZSBkYXRhIGlz
IDMyYml0IGFsaWduZWQgb24gc3lzdGVtcyB3aGVyZSB0aGUgbWlzYWxpZ25lZCBhY2Nlc3Nlcw0K
ZmF1bHQ/DQoNClRoZXJlIG1pZ2h0IHN0aWxsIG5lZWQgdG8gYmUgc29tZXRoaW5nIHRvIHN0b3Ag
Z2NjIGdlbmVyYXRpbmcNCmxkbS9sZHJkIHdoaWNoIGNhbiBmYXVsdCBvbiBzeXN0ZW1zIHdoZXJl
IGEgbm9ybWFsIHJlZ2lzdGVyDQpyZWFkIHdvdWxkbid0Lg0KDQpEbyBhbnkgcmVjZW50IGFybSBj
cHUgaGF2ZSB0aGUgc3Ryb25nYXJtICdmZWF0dXJlJyB0aGFuIGxkbQ0KYWx3YXlzIHRvb2sgMTYg
Y2xvY2tzPw0KDQoJRGF2aWQNCiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


