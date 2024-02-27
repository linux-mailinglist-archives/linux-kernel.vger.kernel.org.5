Return-Path: <linux-kernel+bounces-84138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310B86A2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA371B22F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12ED5579A;
	Tue, 27 Feb 2024 22:44:19 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964055783
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073859; cv=none; b=K6Sz02axYBOAjZaAEmAxiBxemVg/3D4QlPoxVcZTzXcRWcHmYFyVLY/j7tIUQtszuZ+oNI64MNZaLvbB27De5FDt6Wv6UG3I+6YEGCkg720dc7Wtd5CNmfp4E2EyDwNe6WDvMuKNri2t/JAE9fK0WfUTyMl/RevvFO/gNCE17a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073859; c=relaxed/simple;
	bh=tvYVheu3NdNJ9V5AqHBd4uzxTOKoy21QidTCryp/Sp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FFBeoBfMVhpLW9sg3phnXNilA8nRx3oCiR+agtPbDNBk02BGjWgha+SorYXWd00l9B6bd1CwuqMVdtfXyvLSSlsbVhbeKyNIzki1G91mgd8NTbCZvYdUXbVsjIHwjf58y3O6YicOTy1PYvd1BiBB41Wi5rvj4+ZLhqwKa78+gzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-2-zVl-JfuiNMixD5JhOa17NQ-1; Tue, 27 Feb 2024 22:44:11 +0000
X-MC-Unique: zVl-JfuiNMixD5JhOa17NQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 27 Feb
 2024 22:44:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 27 Feb 2024 22:44:10 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Charlie Jenkins
	<charlie@rivosinc.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, Palmer Dabbelt
	<palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller
	<deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaaOb3nOScRpPJiESuqwXNhBxv4rEdMNJggAFkZfWAADOHwA==
Date: Tue, 27 Feb 2024 22:44:10 +0000
Message-ID: <c972a30691594072b866ab56017c300c@AcuMS.aculab.com>
References: <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
 <c8ddcc98-acb0-4d2d-828a-8dd12e771b5f@csgroup.eu> <Zd4h6ZhvLSWfWJG/@ghost>
 <4d5ce145-22be-4683-b3a9-4de77da87b76@roeck-us.net>
In-Reply-To: <4d5ce145-22be-4683-b3a9-4de77da87b76@roeck-us.net>
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

Li4NCj4gVGhpcyBpcyB0aGUgImtub3duIiBsaXN0IG9mIGZhaWx1cmVzLiBJIGRvbid0IGN1cnJl
bnRseSBydW4ga3VuaXQgdGVzdHMNCj4gb24gbmlvczIgb3IgcmlzY3YzMiwgZm9yIGV4YW1wbGUs
IG5vciBvbiBhbnkgYXJjaGl0ZWN0dXJlcyB3aXRoIG5vIHFlbXUNCj4gc3VwcG9ydC4NCg0Kbmlv
czIgaXMgZGVmaW5pdGVseSBnb2luZyB0byAnY3Jhc2ggYW5kIGJ1cm4nIGlmIHlvdSBkbyBhIG1p
c2FsaWduZWQgYWNjZXNzLg0KDQpBbHRob3VnaCBJbnRlbCAoYWthIHRoZSBBbHRlcmEgYml0KSBh
cmUgY2xhaW1pbmcgY3VycmVudCB2ZXJzaW9uDQpvZiB0aGVpciBRdWFydHVzIGZwZ2EgYnVpbGQg
c29mdHdhcmUgaXMgdGhlIGxhc3Qgb25lIHRoZSB3aWxsDQpzdXBwb3J0IHRoZSBuaW9zMi4NClRo
ZXkgYXJlIGV4cGVjdGluZyBldmVyeW9uZSB0byBtb3ZlIHRvIGEgcmlzYy12IHNvZnQgY3B1IGlu
c3RlYWQuDQpXZSBhcmVuJ3QgaGFwcHkgYWJvdXQgdGhhdCwgSSBkb3VidCBzb21lIG9mIHRoZSBi
aWcgdGVsY28ncyBhcmUNCmVpdGhlciAtIEkgYmVsaWV2ZSBzb21lIG1vYmlsZSBiYXNlIHN0YXRp
b25zIGhhdmUgZnBnYSB3aXRoIGENCmxvdCBvZiBuaW9zMiBpbiB0aGVtIC0gYWxtb3N0IGNlcnRh
aW5seSBydW5uaW5nIHdpdGggYSBmZXcga0INCm9mIGNvZGUgYW5kIGRhdGEgbWVtb3J5IGFuZCBy
dW5uaW5nIHNtYWxsIGNvbnRyb2wgdGFza3MuDQpJZiB5b3Ugd2FudCB0byBydW4gTGludXgsIGZp
bmQgYW4gZnBnYSB3aXRoIGFuIEFSTSBjb3JlLg0KDQpUaGVyZSBhcmUgc29tZSBzb2x1dGlvbnMg
LSBsaWtlIHdyaXRpbmcgYSBjb21wYXRpYmxlIHNvZnQgY3B1Lg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


