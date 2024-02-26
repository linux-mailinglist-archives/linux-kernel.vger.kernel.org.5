Return-Path: <linux-kernel+bounces-82408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F078B8683CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E26B234AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FC2134756;
	Mon, 26 Feb 2024 22:34:04 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F480134737
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986844; cv=none; b=C/1vBnNqYfvj49WnL23JVXLowKlEgRuY9sRLJc/Qa+q2CAGSBJqWTU/4ELLNIZxIZ/Sol1u3+gJK/lTETUEs/HJiX243K4hgntMDtZTioYpP7BSiEQhB1xc/bU6XxZ+2QdErH69WQfQC/5dF/RRsYnmQ93RgeO5/8MaMjo9kKe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986844; c=relaxed/simple;
	bh=8YwRDCw8u7OiS5I+dqtgAvNb327qcrJIgDvZkaOACo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=kRQuwdi7CJTQDj0fZBVbIoyp4W4D2wTI4SA1NgHKi02iT+XSsFb2nsQ1ExggS81rGdmLvrCCXyCvxZErlClSLTwLabNuWgxaq3tO/ws8MKZM7SRwWZD4KayWK5VPz3RpZk4+RaligZJooI6Btnyz7xAxgPVgMb0i3/xeQoSJW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-23-WxwTNdofNyCIwID63HDNlQ-1; Mon, 26 Feb 2024 22:33:58 +0000
X-MC-Unique: WxwTNdofNyCIwID63HDNlQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 26 Feb
 2024 22:33:56 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 26 Feb 2024 22:33:56 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Russell King' <linux@armlinux.org.uk>, Charlie Jenkins
	<charlie@rivosinc.com>
CC: Guenter Roeck <linux@roeck-us.net>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Palmer Dabbelt <palmer@dabbelt.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, "James
 E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaaOb3nOScRpPJiESuqwXNhBxv4rEdMNJg
Date: Mon, 26 Feb 2024 22:33:56 +0000
Message-ID: <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
In-Reply-To: <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
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
Content-Transfer-Encoding: quoted-printable

..
> I think you misunderstand. "NET_IP_ALIGN offset is what the kernel
> defines to be supported" is a gross misinterpretation. It is not
> "defined to be supported" at all. It is the _preferred_ alignment
> nothing more, nothing less.

I'm sure I've seen code that would realign IP headers to a 4 byte
boundary before processing them - but that might not have been in
Linux.

I'm also sure there are cpu which will fault double length misaligned
memory transfers - which might be used to marginally speed up code.
Assuming more than 4 byte alignment for the IP header is likely
'wishful thinking'.

There is plenty of ethernet hardware that can only write frames
to even boundaries and plenty of cpu that fault misaligned accesses.
There are even cases of both on the same silicon die.

You also pretty much never want a fault handler to fixup misaligned
ethernet frames (or really anything else for that matter).
It is always going to be better to check in the code itself.

x86 has just made people 'sloppy' :-)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


