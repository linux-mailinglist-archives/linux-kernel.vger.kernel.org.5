Return-Path: <linux-kernel+bounces-129325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A3896898
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67679284044
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A865C1292CF;
	Wed,  3 Apr 2024 08:23:04 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFE6F520
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132584; cv=none; b=UmlYI4iFr7lqrITJveJ4GBJ00xbXYSy0Wl57yohpXtj/4aDbVS7yKkMpIsD8fAhLIEMACGztDfhmB3HDoipBtt9YGwHxVQerLOrgXe4L2/OFlodcI7PJlHEKAotzxGAZWeFpc7bvGUUw7XHQefiCbMuklSEel5PJWJBf5pFWuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132584; c=relaxed/simple;
	bh=/xd3hpbu+Zi9SGSjwWRNxiGqByXLHzVBCsLyu3K7PJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sA6x7lsO6WxQPlzo3QpuG2U+0dwU6+QNFhApwCn18BvdcayeQYLKEBVE2NO2IgojcLoLGEqg4mBgRPh0nXf9w5x0Db4iyL97PA75Eot2q6//jBZhF8HyAup49bdbhCET2qB7XJ6A4he61kYxg1J7/1ntXR6EEXySIJ82eJ5VE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-201-xd3CvAPlOiKWi4y9JosihA-1; Wed, 03 Apr 2024 09:12:35 +0100
X-MC-Unique: xd3CvAPlOiKWi4y9JosihA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 3 Apr
 2024 09:12:10 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 3 Apr 2024 09:12:10 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Biggers' <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, "Chang S .
 Bae" <chang.seok.bae@intel.com>
Subject: RE: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Thread-Topic: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Thread-Index: AQHaf518oZDDPKfpuUWrj9ZpRMjHLrFWPMWw
Date: Wed, 3 Apr 2024 08:12:09 +0000
Message-ID: <6629b8120807458ab76e1968056f5e10@AcuMS.aculab.com>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>
 <20240326164755.GB1524@sol.localdomain>
In-Reply-To: <20240326164755.GB1524@sol.localdomain>
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
> Sent: 26 March 2024 16:48
...
> Consider Intel Ice Lake for example, these are the AES-256-XTS encryption=
 speeds
> on 4096-byte messages in MB/s I'm seeing:
>=20
>     xts-aes-aesni                  5136
>     xts-aes-aesni-avx              5366
>     xts-aes-vaes-avx2              9337
>     xts-aes-vaes-avx10_256         9876
>     xts-aes-vaes-avx10_512         10215
>=20
> So yes, on that CPU the biggest boost comes just from VAES, staying on AV=
X2.
> But taking advantage of AVX512 does help a bit more, first from the parts=
 other
> than 512-bit registers, then a bit more from 512-bit registers.

How much does the kernel_fpu_begin() cost on real workloads?
(ie when the registers are live and it forces an extra save/restore)

I've not looked at the code but I often see what looks like
excessive inlining in crypto code.
This will speed up benchmarks but can have a negative effect
on real code both because of the time taken to load the
code and the effect of displacing other code.

It might be that this code is a simple loop....

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


