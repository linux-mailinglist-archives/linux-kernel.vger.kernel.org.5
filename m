Return-Path: <linux-kernel+bounces-118777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D6188BF37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8F31F63DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4D26E61B;
	Tue, 26 Mar 2024 10:20:05 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B335C911
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448405; cv=none; b=dom9Fe+aTg6hsaAb9mf6spfbAFFu8vdDsRV6HYx8sinK7D0KPi0zfMPM9qPEqLbnSTYqrViifZ+1nJyw97Ayxrddk4axzz7NfbNjjvXTQ96713tFcbOlaShE2VkBS+CzzZXkAJWFmGiDskASLH3ccnhHJvxqK7JyFVuuK4V7ees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448405; c=relaxed/simple;
	bh=zAcUXFyLr77VpvLvJWQ1mxpnEFBr3QkWxmyNygh+e8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OhyhaYcKhs70nl3jdfB9+YPBWt3iyk4gNo/h4HoUaLKFjKn72IBxfD9+8zaAnzCOzEiTTiveqCOTvhQploMfN5hE3N9H4Z8bNYQZmdRqKAWn6LJG8Mg0gCLNEVE8Y7hCGmQRGVidk5s24Vdz/UmphqG09XbtApGXnlnixwQXc1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-88-FBtS3KNePk6yGweZO_w26Q-1; Tue, 26 Mar 2024 10:19:53 +0000
X-MC-Unique: FBtS3KNePk6yGweZO_w26Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 26 Mar
 2024 10:19:28 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 26 Mar 2024 10:19:28 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>
CC: Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland
	<samuel.holland@sifive.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Albert Ou <aou@eecs.berkeley.edu>, "Andrew
 Morton" <akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>,
	guoren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Kemeng Shi
	<shikemeng@huaweicloud.com>, Matthew Wilcox <willy@infradead.org>, "Mike
 Rapoport" <rppt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Xiao
 W Wang" <xiao.w.wang@intel.com>, Yangyu Chen <cyy@cyyself.name>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Thread-Topic: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Thread-Index: AQHaeh3F9DUQSIkEB0u5Xt52XMTyX7FHT0cAgAGlN9CAAN1lkA==
Date: Tue, 26 Mar 2024 10:19:28 +0000
Message-ID: <882fc86da89f4adb81570cde3a653e6f@AcuMS.aculab.com>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
 <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
 <ZgGosOiW6mTeSnTL@FVFF77S0Q05N>
 <eeccbc9f-7544-42c9-964f-2b4c924c2b2f@app.fastmail.com>
 <ZgHCpgHh1ypSyrtv@FVFF77S0Q05N>
 <95eb125d-dd54-42f1-b080-938faca6a8a1@app.fastmail.com>
In-Reply-To: <95eb125d-dd54-42f1-b080-938faca6a8a1@app.fastmail.com>
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

From: Arnd Bergmann
> Sent: 25 March 2024 20:38
>=20
> On Mon, Mar 25, 2024, at 19:30, Mark Rutland wrote:
> > On Mon, Mar 25, 2024 at 07:02:13PM +0100, Arnd Bergmann wrote:
> >> On Mon, Mar 25, 2024, at 17:39, Mark Rutland wrote:
> >
> >> If an architecture ignores all the top bits of a virtual address,
> >> the largest TASK_SIZE would be higher than the smallest (positive,
> >> unsigned) PAGE_OFFSET, so you need TASK_SIZE_MAX to be dynamic.
> >
> > Agreed, but do we even support such architectures within Linux?
>=20
> Apparently not.
>=20
> On 32-bit architectures, you often have TASK_SIZE=3D=3DPAGE_OFFSET,
> but not on 64-bit -- either the top few bits in PAGE_OFFSET are
> always ones, or the user and kernel page tables are completely
> separate.

ISTR that arm64 uses (something like) bit 56 to select kernel
with the annoying 'feature' that the high bits can be ignored
just to complicate things.

But I also recall the people that want 'address masking' for x86-64
have been persuaded that addresses with the top bit set are invalid.
I has to be said that I'm not sure that aliasing user addresses
like that is a good idea.
If the TLB/PTE verified the masked bits it might be more use.

If bit63 selects kernel addresses (as in x86-64) there is a massive
(non-canonical address) gap before the first valid kernel address
that is larger than the user address space (and hence buffer size).
I think that lets access_ok() check ((address | size) >> 60) !=3D 0.
Although it probably means that you don't need to test 'size' at all
(unless some code probes the last byte of the buffer).

For 32bit the user/kernel boundary is usually 0x80000000 or 0xc0000000
and there may not even be an invalid page between the two.
This does require access_ok() check the length (even for get_user()).

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


