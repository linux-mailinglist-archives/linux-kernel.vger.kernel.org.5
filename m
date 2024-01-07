Return-Path: <linux-kernel+bounces-18754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD651826296
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769D91F21E6D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743715A6;
	Sun,  7 Jan 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iZSEy6m2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94B137F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 01:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.208.238])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4071HJpr962781
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 6 Jan 2024 17:17:21 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4071HJpr962781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1704590243;
	bh=NC2CrnQRyBY2GhZKHwqRwBQvMsjgYLB7PY/48PwpD80=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=iZSEy6m20clspqHdRl10tIH4WTqAgVZXCZC4ZB3I2Kj8owfPsB7SlQ/eOE7U35W9Q
	 HFHZPq1eQ8aMP6z7M2oSp+vq6mgw8XSv+Cr3dIhJL//zmB+Z5PH9XOCB/G6D7JKTS6
	 r+DZJB3DEGduOsd28mPTOYyUsWxaxHNZPQRq4lJ0zvADus1/M72vOuQfXTndf3JfI3
	 +EVdI4BUeDFFTDce+vkMCrvnI+9CDCfSPhr2VK5DDylmjC0DCyDoLHUYDOYv4y9VDo
	 G3vFPf8oDAw9WIpdq3WbDZlsEFtY576PkK4gPw/Xi9EfyCil5J7bb5KuGONHcZt6X0
	 jKaYMf+2wnItA==
Date: Sat, 06 Jan 2024 17:09:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <David.Laight@ACULAB.COM>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>
CC: Noah Goldstein <goldstein.w.n@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: RE: x86/csum: Remove unnecessary odd handling
User-Agent: K-9 Mail for Android
In-Reply-To: <124b21857fe44e499e29800cbf4f63f8@AcuMS.aculab.com>
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com> <202309231130.ZI5MdlDc-lkp@intel.com> <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com> <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com> <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com> <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com> <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com> <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com> <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com> <5354eeec562345f6a1de84f0b2081b75@AcuMS.aculab.com> <CAHk-=wg8vssPVO68_qH_BHBCj6_DDawKQHBOgZh4gw5YFmpCKA@mail.gmail.com> <124b21857fe44e499e29800cbf4f63f8@AcuMS.aculab.com>
Message-ID: <4313F9BB-DE2E-448F-A366-A68CAEA2BFE0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 6, 2024 2:08:48 PM PST, David Laight <David=2ELaight@ACULAB=2ECO=
M> wrote:
>From: Linus Torvalds
>> Sent: 05 January 2024 18:06
>>=20
>> On Fri, 5 Jan 2024 at 02:41, David Laight <David=2ELaight@aculab=2Ecom>=
 wrote:
>> >
>> > Interesting, I'm pretty sure trying to get two blocks of
>> >  'adc' scheduled in parallel like that doesn't work=2E
>>=20
>> You should check out the benchmark at
>>=20
>>        https://github=2Ecom/fenrus75/csum_partial
>>=20
>> and see if you can improve on it=2E I'm including the patch (on top of
>> that code by Arjan) to implement the actual current kernel version as
>> "New version"=2E
>
>Annoyingly (for me) you are partially right=2E=2E=2E
>
>I found where my ip checksum perf code was hiding and revisited it=2E
>Although I found comments elsewhere that the 'jecxz, adc, adc, lea, jmp'
>did an adc every clock it isn't happening for me now=2E
>
>I'm only measuring the inner loop for multiples of 64 bytes=2E
>The code less than 8 bytes and partial final words is a
>separate problem=2E
>The less unrolled the main loop, the less overhead there'll
>be for 'normal' sizes=2E
>So I've changed your '80 byte' block to 64 bytes for consistency=2E
>
>I'm ignoring pre-sandy bridge cpu (no split flags) and pre-broadwell
>(adc takes two clocks - although adc to alternate regs is one clock
>on sandy bridge)=2E
>My test system is an i7-7700, I think anything from broadwell (gen 4)
>will be at least as good=2E
>I don't have a modern amd cpu=2E
>
>The best loop for 256+ bytes is an adxc/adxo one=2E
>However that requires the run-time patching=2E
>Followed by new kernel version (two blocks of 4 adc)=2E
>The surprising one is:
>		xor	sum, sum
>	1:	adc	(buff), sum
>		adc	8(buff), sum
>		lea	16(buff), buff
>		dec	count
>		jnz	1b
>		adc	$0, sum
>For 256 bytes it is only a couple of clocks slower=2E
>Maybe 10% slower for 512+ bytes=2E
>But it need almost no extra code for 'normal' buffer sizes=2E
>By comparison the adxc/adxo one is 20% faster=2E
>
>The code is doing:
>	old =3D rdpmc
>	mfence
>	csum =3D do_csum(buf, len);
>	mfence
>	clocks =3D rdpmc - old
>(That is directly reading the pmc register=2E)
>With 'no-op' function it takes 160 clocks (I-cache resident)=2E
>Without the mfence 40 - but pretty much everything can execute
>after the 2nd rdpmc=2E
>
>I've attached my (horrid) test program=2E
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
>Registration No: 1397386 (Wales)

Rather than runtime patching perhaps separate paths=2E=2E=2E

