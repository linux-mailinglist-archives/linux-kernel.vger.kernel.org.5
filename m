Return-Path: <linux-kernel+bounces-87625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E386D6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295D31F24467
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D565B74BE4;
	Thu, 29 Feb 2024 22:13:36 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEA6D522
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244816; cv=none; b=D33YYcb5u3vfLwoDWqyVu7hbKXGLq4PxWCyltpxFq46aSCHvEV7NzZT/q6aj3gODwXULo3YgXWo8ldmPC7c8aJCCJVOLrxtVYbv53IokqQH4kn3mrj+WQUJRdjUJANO1kH872xux8RqeJAtf2qh+x2sz1H/OULYLSqLx9I2tnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244816; c=relaxed/simple;
	bh=lZDiyJsUmZId/Z3fYLT2IIVuOrOC5HBxpjKM+fv3XMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YGiU69SlljFbSDeAZdqqOCXGRuAWo9Xesy1d1seRLhfqRc+JS774r58n2oy5xN5MAtbwbXYVzLp4GhdRzJZtLKd1yqG6/85gffbMUaQTfgF+JC1fzPPR9zUOG6ZdUdN6jTMMEPGG5nxLkdU2XnrGfu6PDab2ROvMzXTIeXOM2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-152-bS3OTQjvO0uFxpOp8UZoqA-1; Thu, 29 Feb 2024 22:13:28 +0000
X-MC-Unique: bS3OTQjvO0uFxpOp8UZoqA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Feb
 2024 22:13:26 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Feb 2024 22:13:26 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Thorsten Blum' <thorsten.blum@toblux.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Wei Liu <wei.liu@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/apic: Use div64_ul() instead of do_div()
Thread-Topic: [PATCH] x86/apic: Use div64_ul() instead of do_div()
Thread-Index: AQHaaXLYiXydWB8fRkmBfBNz3Gms8bEh48og
Date: Thu, 29 Feb 2024 22:13:26 +0000
Message-ID: <7e46123775e64898bd7c467328125ee0@AcuMS.aculab.com>
References: <20240227114333.1718-2-thorsten.blum@toblux.com>
In-Reply-To: <20240227114333.1718-2-thorsten.blum@toblux.com>
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

From: Thorsten Blum
> Sent: 27 February 2024 11:44
>=20
> Fixes Coccinelle/coccicheck warnings reported by do_div.cocci.
>=20
> Change deltapm to unsigned long and replace do_div() with div64_ul()
> which doesn't implicitly cast the divisor and doesn't unnecessarily
> calculate the remainder.

Eh? they are entirely different beasts.

do_div() does a 64 by 32 divide that gives a 32bit quotient.
div64_ul() does a much more expensive 64 by 64 divide that
can generate a 64bit quotient.

The remainder is pretty much free in both cases.
If a cpu has a divide instruction it will almost certainly
put the result in one register and the quotient in another.

64 by 64 divides are horribly expensive on 32bit - they typically
have to be done in software even if the cpu has a divide instruction
which will (typically) do a 64 by 32 divide.

Even on Intel 64 bit x86 the 128 by 64 divide (needed to get
the 64 bit quotient) takes twice as long as the 64 by 32 one.
Even when the values are small.

The entire reason that the 'libc' divide function isn't in
the kernel is because it is slow and you really don't want
to be doing it unless the VALUES not the types require it.


=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


