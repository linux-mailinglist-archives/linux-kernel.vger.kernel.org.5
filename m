Return-Path: <linux-kernel+bounces-45127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87146842BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA37282539
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE678B63;
	Tue, 30 Jan 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HZBrmsoW"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771078B5E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640076; cv=none; b=rAgilNdTOdbIM/92dQJfrKJZlpsZOrz5zn3/xLTnGy63Bt5XqyFD83PrB/aLW0GlnMXn9UNwV20M6IkQExB2kg3cOKoft/CRIkNZeIs1MHYln0qUrOaliwAPcn7c6pJiJrTSk3KF5pdBRRxeQDeBrYM2ejfSTpkA+Xa+Xzx5sR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640076; c=relaxed/simple;
	bh=FguebPSg0HUsNFSJ74ZD5+TiVpglPbVDOkutWtGbuyw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eDZipRVCoKCUzs+EQ9Ac+1JXxNbWqqiH3EV6FHDTMOvj/5m17irEwN48W5GIQUl+UKzuzkvoTa5BFVcQii7hD4+CPwKESXFjrArQIsSah5fdEE9INSlAwqjiGytV7DVObfS6eVub0w/zCZnAGCGjBvp2hv4Sxfs754ow8oBpr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=HZBrmsoW reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.208.49])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40UIeZF42947366
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 30 Jan 2024 10:40:37 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40UIeZF42947366
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706640038;
	bh=LtA6AyWu9wA8RgFBYpf0xObk1vz6dfM341Zg3x5QGq0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HZBrmsoWblW/2FdH+M3Hpxl5mlwYWWb8aLRiQ7kt4LTEN8TGWLCgfdvvqODiXooKR
	 DfsJM6lLCMnzaCv5tSpTo1s+O0HA9sYhO+1Tdiz6JSDGsz2J9ZjQaKL2amxBMx8Ymi
	 aWw9MYCUZ9Dsgjt94Euehn6W4mnDxesGyqvBxYtZ7Jw25uUZX6GQ7FJPfItP1Iw9+B
	 5U6x0dDQ+fI/Q0QmubEIdADXftJ+T0kGOBIlgMjP9T/AmdbE5KUWCkLa4wmyoaWFp1
	 Ou1YsSa2xUROtuLKX65h2JPnR4I0T82ihMvU1XkV83NoW+4/6iSM5gmw8DGrQdbLvL
	 1U+gRPsRNkD6w==
Date: Tue, 30 Jan 2024 10:40:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Dave Hansen <dave.hansen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
User-Agent: K-9 Mail for Android
In-Reply-To: <Zbk6h0ogqeInLa_1@redhat.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com> <20240130083007.1876787-2-kirill.shutemov@linux.intel.com> <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com>
Message-ID: <33EBFB22-0063-4E3C-A43D-63638D308325@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 30, 2024 10:05:59 AM PST, "Daniel P=2E Berrang=C3=A9" <berrange@=
redhat=2Ecom> wrote:
>On Tue, Jan 30, 2024 at 06:49:15PM +0100, Jason A=2E Donenfeld wrote:
>> On Tue, Jan 30, 2024 at 6:32=E2=80=AFPM Dave Hansen <dave=2Ehansen@inte=
l=2Ecom> wrote:
>> >
>> > On 1/30/24 05:45, Reshetova, Elena wrote:
>> > >> You're the Intel employee so you can find out about this with much
>> > >> more assurance than me, but I understand the sentence above to be =
_way
>> > >> more_ true for RDRAND than for RDSEED=2E If your informed opinion =
is,
>> > >> "RDRAND failing can only be due to totally broken hardware"
>> > > No, this is not the case per Intel SDM=2E I think we can live under=
 a simple
>> > > assumption that both of these instructions can fail not just due to=
 broken
>> > > HW, but also due to enough pressure put into the whole DRBG constru=
ction
>> > > that supplies random numbers via RDRAND/RDSEED=2E
>> >
>> > I don't think the SDM is the right thing to look at for guidance here=
=2E
>> >
>> > Despite the SDM allowing it, we (software) need RDRAND/RDSEED failure=
s
>> > to be exceedingly rare by design=2E  If they're not, we're going to g=
et
>> > our trusty torches and pitchforks and go after the folks who built th=
e
>> > broken hardware=2E
>> >
>> > Repeat after me:
>> >
>> >         Regular RDRAND/RDSEED failures only occur on broken hardware
>> >
>> > If it's nice hardware that's gone bad, then we WARN() and try to make
>> > the best of it=2E  If it turns out that WARN() was because of a broke=
n
>> > hardware _design_ then we go sharpen the pitchforks=2E
>> >
>> > Anybody disagree?
>>=20
>> Yes, I disagree=2E I made a trivial test that shows RDSEED breaks easil=
y
>> in a busy loop=2E So at the very least, your statement holds true only
>> for RDRAND=2E
>>=20
>> But, anyway, if the statement "RDRAND failures only occur on broken
>> hardware" is true, then a WARN() in the failure path there presents no
>> DoS potential of any kind, and so that's a straightforward conclusion
>> to this discussion=2E However, that really hinges on  "RDRAND failures
>> only occur on broken hardware" being a true statement=2E
>
>There's a useful comment here from an Intel engineer
>
>https://web=2Earchive=2Eorg/web/20190219074642/https://software=2Eintel=
=2Ecom/en-us/blogs/2012/11/17/the-difference-between-rdrand-and-rdseed
>
>  "RDRAND is, indeed, faster than RDSEED because it comes
>   from a hardware-based pseudorandom number generator=2E
>   One seed value (effectively, the output from one RDSEED
>   command) can provide up to 511 128-bit random values
>   before forcing a reseed"
>
>We know we can exhaust RDSEED directly pretty trivially=2E Making your
>test program run in parallel across 20 cpus, I got a mere 3% success
>rate from RDSEED=2E
>
>If RDRAND is reseeding every 511 values, RDRAND output would have
>to be consumed significantly faster than RDSEED in order that the
>reseed will happen frequently enough to exhaust the seeds=2E
>
>This looks pretty hard, but maybe with a large enough CPU count
>this will be possible in extreme load ?
>
>So I'm not convinced we can blindly wave away RDRAND failures as
>guaranteed to mean broken hardware=2E
>
>With regards,
>Daniel

The general approach has been "don't credit entropy and try again on the n=
ext interrupt=2E" We can, of course, be much more aggressive during boot=2E

We only need 256-512 bits for the kernel random pool to be equivalent to b=
reaking mainstream crypto primitives even if it is a PRNG only from that po=
int on (which is extremely unlikely=2E) The Linux PRNG has a very large sta=
te, which helps buffer entropy variations=2E

Again, applications *should* be using /dev/[u]random as appropriate, and i=
f they opt to use lower level primitives in user space they need to impleme=
nt them correctly =E2=80=93 there is literally nothing the kernel can do at=
 that point=2E

If the probability of success is 3% per your CPU that is still 2 bits of t=
rue entropy per invocation=2E However, the probability of failure after 16 =
loops is over 60%=2E I think this validates the concept of continuing to po=
ll periodically rather than looping in time critical paths=2E


