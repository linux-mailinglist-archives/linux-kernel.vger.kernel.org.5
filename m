Return-Path: <linux-kernel+bounces-131057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA07898287
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A2628A768
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC895D465;
	Thu,  4 Apr 2024 07:54:22 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAE45970
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217261; cv=none; b=AH/xqVuSUpzAQqe7Kvu0jQamM75hRde7Trj3J2WEDAk+9A/+0LT/hFBAhINLuUjt3KhGw8fwSBdYDYrdTFG1OfqgKW6SuutFtSrkPG1MMA0gzDuM9SkddxXigOz0sK5EA/piMo5JdUeWErFnpRDZ3dqVgzcro7qKctB8zwLZtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217261; c=relaxed/simple;
	bh=aR0wVCM5LaAu/ECnGr+i9aZMlzTwjmlOljzCBgud3vU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DQolSJak1isuYsz+Jqw1rxVaTcleR0ymk+TMwkOG6k6EQs5tPKcoXiey8ZPwSpPf9FREFaitWzUBWlpg4oRWyKlw3Cz7mXR7JxsNJRF2T0O1dkM9mFHg7dRa5exuFGPHR7J59wsh/dzWX/xZLGAIBKu78Hwb9BpQFcZaehMVDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-83-v2x10sXbPHaCrBeJxegpgg-1; Thu, 04 Apr 2024 08:54:14 +0100
X-MC-Unique: v2x10sXbPHaCrBeJxegpgg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 4 Apr
 2024 08:53:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 4 Apr 2024 08:53:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Biggers' <ebiggers@kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andy
 Lutomirski" <luto@kernel.org>, "Chang S . Bae" <chang.seok.bae@intel.com>
Subject: RE: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Thread-Topic: [PATCH 0/6] Faster AES-XTS on modern x86_64 CPUs
Thread-Index: AQHaf518oZDDPKfpuUWrj9ZpRMjHLrFWPMWwgAET/ICAAHT4IA==
Date: Thu, 4 Apr 2024 07:53:48 +0000
Message-ID: <142077804bee45daac3b0fad8bc4c2fe@AcuMS.aculab.com>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <CAMj1kXH4fNevFzrbazJptadxh_spEY3W91FZni5eMqD+UKrSUQ@mail.gmail.com>
 <20240326164755.GB1524@sol.localdomain>
 <6629b8120807458ab76e1968056f5e10@AcuMS.aculab.com>
 <20240404013529.GB24248@quark.localdomain>
In-Reply-To: <20240404013529.GB24248@quark.localdomain>
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
> Sent: 04 April 2024 02:35
>=20
> Hi David,
>=20
> On Wed, Apr 03, 2024 at 08:12:09AM +0000, David Laight wrote:
> > From: Eric Biggers
> > > Sent: 26 March 2024 16:48
> > ....
> > > Consider Intel Ice Lake for example, these are the AES-256-XTS encryp=
tion speeds
> > > on 4096-byte messages in MB/s I'm seeing:
> > >
> > >     xts-aes-aesni                  5136
> > >     xts-aes-aesni-avx              5366
> > >     xts-aes-vaes-avx2              9337
> > >     xts-aes-vaes-avx10_256         9876
> > >     xts-aes-vaes-avx10_512         10215
> > >
> > > So yes, on that CPU the biggest boost comes just from VAES, staying o=
n AVX2.
> > > But taking advantage of AVX512 does help a bit more, first from the p=
arts other
> > > than 512-bit registers, then a bit more from 512-bit registers.
> >
> > How much does the kernel_fpu_begin() cost on real workloads?
> > (ie when the registers are live and it forces an extra save/restore)
>=20
> x86 Linux does lazy restore of the FPU state.  The first kernel_fpu_begin=
() can
> have a significant cost, as it issues an XSAVE (or equivalent) instructio=
n and
> causes an XRSTOR (or equivalent) instruction to be issued when returning =
to
> userspace when it otherwise might not be needed.  Additional kernel_fpu_b=
egin()
> / kernel_fpu_end() pairs without returning to userspace have only a small=
 cost,
> as they don't cause any more saves or restores of the FPU state to be don=
e.
>=20
> My new xts(aes) implementations have one kernel_fpu_begin() / kernel_fpu_=
end()
> pair per message (if the message doesn't span any page boundaries, which =
is
> almost always the case).  That's exactly the same as the current xts-aes-=
aesni.

I realised after sending it that the code almost certainly already did
kernel_fpu_begin() - so there probably isn't a difference because all the
fpu state is always saved.
(I'm sure there should be a way of getting access to (say) 2 ymm registers
by providing an on-stack save area to allow wide data copies or special
instructions - but that is a different issue.)

> I think what you may really be asking is how much the overhead of the XSA=
VE /
> XRSTOR pair associated with kernel-mode use of the FPU *increases* if the=
 kernel
> clobbers AVX or AVX512 state, instead of just SSE state as xts-aes-aesni =
does.
> That's much more relevant to this patchset.

It depends on what has to be saved, not on what is used.
Although, since all the x/y/zmm registers are caller-saved I think they cou=
ld
be 'zapped' on syscall entry (and restored as zero later).
Trouble is I suspect there is a single piece of code somewhere that relies
on them being preserved across an inlined system call.

> I think the answer is that there is no additional overhead.  This is beca=
use the
> XSAVE / XRSTOR pair happens regardless of the type of state the kernel cl=
obbers,
> and it operates on the userspace state, not the kernel's.  Some of the ne=
wer
> variants of XSAVE (XSAVEOPT and XSAVES) do have a "modified" optimization=
 where
> they don't save parts of the state that are unmodified since the last XRS=
TOR;
> however, that is unimportant here because the kernel's FPU state is never=
 saved.
>=20
> (This would change if x86 Linux were to support preemption of kernel-mode=
 FPU
> code.  In that case, we may need to take more care to minimize use of AVX=
 and
> AVX512 state.  That being said, AES-XTS tends to be used for bulk data an=
yway.)
>=20
> This is based on theory, though.  I'll do a test to confirm that there's =
indeed
> no additional overhead.  And also, even if there's no additional overhead=
, what
> the existing overhead actually is.

Yes, I was wondering how it is used for 'real applications'.
If a system call that would normally return immediately (or at least withou=
t
a full process switch) hits the aes code it gets the cost of the XSAVE adde=
d.
Whereas the benchmark probably doesn't do anywhere near as many.

OTOH this is probably no different.

>=20
> > I've not looked at the code but I often see what looks like
> > excessive inlining in crypto code.
> > This will speed up benchmarks but can have a negative effect
> > on real code both because of the time taken to load the
> > code and the effect of displacing other code.
> >
> > It might be that this code is a simple loop....
>=20
> This is a different topic.  By "inlining" I assume that you also mean thi=
ngs
> like loop unrolling.  I totally agree that some of the crypto assembly co=
de goes
> way overboard on this, resulting in an unreasonably large machine code si=
ze.
> The AVX implementation of AES-GCM (aesni-intel_avx-x86_64.S), which was w=
ritten
> by Intel, is the worst offender by far, generating 256011 bytes of machin=
e code.
> In OpenSSL, Intel has even taken that to the next level with their VAES
> optimized implementation of AES-GCM generating 696040 bytes of machine co=
de.

That is truly stunning!
I can't believe anything that big is actually 'optimised'.
Just think of all the TLB misses :-)
Unless it is slightly faster if you are encrypting several TB of data.

..
> So, I think my current proposal is at a reasonable place regarding compil=
ed code
> size, especially when it's compared to the monstrosity that is some of th=
e
> existing crypto assembly code.  But let me know if there are any specific
> choices I've made that you may have a different opinion on.

At least you've thought about code size.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


