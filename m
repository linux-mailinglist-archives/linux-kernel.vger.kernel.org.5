Return-Path: <linux-kernel+bounces-44832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B08427F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB76028D9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E7012BF01;
	Tue, 30 Jan 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IZTMGvJa"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55ED12BE9E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628069; cv=none; b=aQmLmiakiN+VkGNuYFLdp2EoH3B+X8Luc1Suyv3KhEau3XAEv0DZsyp6pueLYga9ZcJj/1ZVPopz7eJxGvSsKScxblEXU4vGPaa4D890Vbk5DCg2HzQJi+hzKpu1UczDSe0gSgZHNdSQzHBfjk/m9lPXWMEGTNM7m3kOCci7mSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628069; c=relaxed/simple;
	bh=fnaHevZn3AnWviCVrRshdG83k6cks6roj4RtEKpfX24=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=T7sq1OzPvPbiN/tRcb1A8WIOeq+x1pTG+TNrJy/T9ABUGn122BPXTX8012vy2yAE0iSooCe58y5cPLCgvbHx1FEY+rGSfXPXFm/Fg2uaaLCbX+BeO8zsekhOgqzf/urc6VOG/qTh/CsBDIJSrQk63z3Q3p3utPd6Qy5SAiVUfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IZTMGvJa reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40UFKPTL2866718
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 30 Jan 2024 07:20:25 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40UFKPTL2866718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706628026;
	bh=1ilVVk8Q8DP7NWzjjOV5yV70ZqlWK9unRMrjNDIK6u0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IZTMGvJa3wcmHi53UyzRx5CifOcNPjraHJfs5CMoswcufrmNCCKj0oQZ5iEt/NPo9
	 8Uv8TCEAF6xMJYqBXkt9tkxUqWfkHmeUIMrCFhQgdX4hzYp7Eu6/CiK4e9fmNTiTxf
	 FyQ1qrDdP7N9aVGDlrc5Hy4Sfxze7Dkt2GMrlx5pr6PlJlEUMqTXQDcu/j38hsPIet
	 uOw2BFjESMFE98xBEiKEtLm9FM4jUCx1AoWjlX8L8AtaGJfKP/GXL00PUwskj6854R
	 GP4yNV48PAc49ySYNkL3oK5M+VZe0Gy0SeYatRx+TtTAbW++KxSTNjqH1dhA9Erk/l
	 5blYBbE1adaWQ==
Date: Tue, 30 Jan 2024 07:20:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
User-Agent: K-9 Mail for Android
In-Reply-To: <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com> <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com> <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
Message-ID: <1C8939C0-BC58-4BE9-95B8-4B6F4A36115D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 30, 2024 5:10:20 AM PST, "Reshetova, Elena" <elena=2Ereshetova@i=
ntel=2Ecom> wrote:
>=20
>> Hi Kirill,
>>=20
>> I've been following the other discussion closely thinking about the
>> matter, but I suppose I'll jump in here directly on this patch, if
>> this is the approach the discussion is congealing around=2E
>>=20
>> A comment below:
>>=20
>> On Tue, Jan 30, 2024 at 9:30=E2=80=AFAM Kirill A=2E Shutemov
>> <kirill=2Eshutemov@linux=2Eintel=2Ecom> wrote:
>> >  static inline bool __must_check rdseed_long(unsigned long *v)
>> >  {
>> > +       unsigned int retry =3D RDRAND_RETRY_LOOPS;
>> >         bool ok;
>> > -       asm volatile("rdseed %[out]"
>> > -                    CC_SET(c)
>> > -                    : CC_OUT(c) (ok), [out] "=3Dr" (*v));
>> > -       return ok;
>> > +
>> > +       do {
>> > +               asm volatile("rdseed %[out]"
>> > +                            CC_SET(c)
>> > +                            : CC_OUT(c) (ok), [out] "=3Dr" (*v));
>> > +
>> > +               if (ok)
>> > +                       return true;
>> > +       } while (--retry);
>> > +
>> > +       return false;
>> >  }
>>=20
>> So, my understanding of RDRAND vs RDSEED -- deliberately leaving out
>> any cryptographic discussion here -- is roughly that RDRAND will
>> expand the seed material for longer, while RDSEED will mostly always
>> try to sample more bits from the environment=2E AES is fast, while
>> sampling is slow, so RDRAND gives better performance and is less
>> likely to fail, whereas RDSEED always has to wait on the hardware to
>> collect some bits, so is more likely to fail=2E
>
>The internals of Intel DRBG behind RDRAND/RDSEED has been publicly
>documented, so the structure is no secret=2E Please see [1] for overall
>structure and other aspects=2E So, yes, your overall understanding is cor=
rect
>(there are many more details though)=2E=20
>
>[1] https://www=2Eintel=2Ecom/content/www/us/en/developer/articles/guide/=
intel-digital-random-number-generator-drng-software-implementation-guide=2E=
html
>
>
>>=20
>> For that reason, most of the usage of RDRAND and RDSEED inside of
>> random=2Ec is something to the tune of `if (!rdseed(out)) rdrand(out);`=
,
>> first trying RDSEED but falling back to RDRAND if it's busy=2E That
>> still seems to me like a reasonable approach, which this patch would
>> partly undermine (in concert with the next patch, which I'll comment
>> on in a follow up email there)=2E
>
>I agree that for the purpose of extracting entropy for Linux RNG falling
>back to RDRAND (current behavior) is perfectly ok, so I think you are doi=
ng
>the right thing=2E However, in principle it is not always the case, there=
 are
>situations when a fallback to RDRAND should not be used, but it is also
>true that the user of this interface should know/understand this situatio=
n=2E=20
>
>>=20
>> So maybe this patch #1 (of 2) can be dropped?
>
>Before we start debating this patchset, what is your opinion on the origi=
nal
>problem we raised for CoCo VMs when both RDRAND/RDSEED are made to
>fail deliberately?=20
>
>Best Regards,
>Elena=2E
>
>

I have a real concern with this=2E We already have the option to let the e=
ntropy pool fill before the boot can proceed=2E This would have the risk of=
 massively increasing the interrupt latency for what will be retried anyway=
=2E

