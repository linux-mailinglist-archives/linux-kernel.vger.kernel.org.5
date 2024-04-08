Return-Path: <linux-kernel+bounces-134928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074789B8E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0716B2175C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2823A1A8;
	Mon,  8 Apr 2024 07:42:29 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9838DF1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562149; cv=none; b=k55CnTRNstyA1HuwhsxnVtdQ25ePByEWnudyCL9wcYgdj6myE0HORywxWnqhE/GOVsN2SKzXNPXPHjvePyNCkAwPaHuoPameGzMNNgwQQ/SSMoy+FC6Y0PuK0lpAfxI7b8lXnM48RJE1LbC3nIudhazovvKAJM5SCmPiIeoNktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562149; c=relaxed/simple;
	bh=DPkYREXK+oG3yOff06Zvn06OcLTopHco0B279Mx5pMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=LPUpe4RFHKnOBneRyJ4uWlETk3zLaNu5jkch8C795cMS1mfV+5SlZMmylAUz1Vj3FUv9LyWdWSc1gf72MnAbj5kKNdKTDkhMAywjMuDTgaNsKEN4tBWFtf3s/FBJhWUmoWJ5XVYx+Rx8A9XCBNu3A50cX0eLARWGNUNIRnh8doQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-142-w_BydM-EMUCFUZlYFJq51A-1; Mon, 08 Apr 2024 08:42:18 +0100
X-MC-Unique: w_BydM-EMUCFUZlYFJq51A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 8 Apr
 2024 08:41:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 8 Apr 2024 08:41:44 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Biggers' <ebiggers@kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andy
 Lutomirski" <luto@kernel.org>, "Chang S . Bae" <chang.seok.bae@intel.com>
Subject: RE: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Thread-Topic: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Thread-Index: AQHaf518oZDDPKfpuUWrj9ZpRMjHLrFWPMWwgAET/ICAAHT4IIACRoYAgAQETzA=
Date: Mon, 8 Apr 2024 07:41:44 +0000
Message-ID: <e49a2868626f4f9e9169ce8b8b926a49@AcuMS.aculab.com>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>
 <20240326164755.GB1524@sol.localdomain>
 <6629b8120807458ab76e1968056f5e10@AcuMS.aculab.com>
 <20240404013529.GB24248@quark.localdomain>
 <142077804bee45daac3b0fad8bc4c2fe@AcuMS.aculab.com>
 <20240405191904.GA1205@quark.localdomain>
In-Reply-To: <20240405191904.GA1205@quark.localdomain>
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

From: Eric Biggers
> Sent: 05 April 2024 20:19
..
> I did some tests on Sapphire Rapids using a system call that I customized=
 to do
> nothing except possibly a kernel_fpu_begin / kernel_fpu_end pair.
>=20
> On average the bare syscall took 70 ns.  The syscall with the kernel_fpu_=
begin /
> kernel_fpu_end pair took 160 ns if the userspace program used xmm only, 3=
40 ns
> if it used ymm, or 360 ns if it used zmm...
>=20
> Note that without the kernel_fpu_begin / kernel_fpu_end pair, AES-NI
> instructions cannot be used and the alternative would be xts(ecb(aes-gene=
ric)).
> On the same CPU, encrypting a single 512-byte sector with xts(ecb(aes-gen=
eric))
> takes about 2235ns.  With xts-aes-vaes-avx10_512 it takes 75 ns...

So most of the cost of a single 512-byte sector is the kernel_fpu_begin().
But it is so much slower any other way it is still faster.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


