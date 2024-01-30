Return-Path: <linux-kernel+bounces-45110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B555D842BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728BA289083
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342C115DBDC;
	Tue, 30 Jan 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TG4zboBz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565C215EA86
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639520; cv=none; b=GCL+wUZ9DbIIx3kb6JqEOxm953jB/YyiUrycjAPP5Y6Yq9MA/Q3RmWrX4D09VF71d4kl59vlNiWzFFZzNtcqIwxFjSBslULxm8ViFrgm1pyemxwR8kwgp5izy8PGLTMC35cp+ubCn49nJD8MM5Kq1eRiipQQVaDgg2/zyXiRIaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639520; c=relaxed/simple;
	bh=iRpgRmHarH60GRDB5jVlAFnXl1prqJyytsKoq7Cs4Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8aDVVEQzhcTG/B/8mTqToHcSwZMbCi1jvDM3IUagmB0tJkIDSSicYlJTlOwMrFFTRMMgZ7HhqilwhIxAAYILOBNaqV4Hi4iG98SOfbXJSfu7QACff5/fXZfEGUdBTbIUh0cgJNLCFmRCqL8CmnxJOqk7GQExqVxGBHHvMoJ9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=TG4zboBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D180C43390
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TG4zboBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706639516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tG7DptqGlrQotRRCL+fVetrdXEbeDlcaTep4/MHs0M8=;
	b=TG4zboBzZKgvM2qVC9xqBRHPMsOz/xvuoWaqhoBU/X49AAAZqEdPmaSHEOk6rGb15KweKt
	iLxP3dmIN/CWoIN0mRYjd0PMiy+Khc/CpFUxcgDvEWsHPn8ZI9c2IrTwxNAQDKif3lkKYr
	lyu8qdZXh6HXcUdqEmGiKCFubG1m2as=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7a764878 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 30 Jan 2024 18:31:56 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed179f0faso68012276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:31:55 -0800 (PST)
X-Gm-Message-State: AOJu0YwEEXVvQmVYZmGrMh64+pLTNl2F2jbrPOS96utDVvZByH3t0Yvx
	DkZP7AHj6SFL4gV6f1NMbNy2oFrhqWXY7ViaYiG6DtUehB7+m7jn3Uuo+kOQRtY3GXE8gisTzYH
	A6f1Kbiss5YWLRtqYSBaHm2JZQ84=
X-Google-Smtp-Source: AGHT+IGRHdsBprwo6nL35R9Sk+xZZnX67yX7st+CY86TGoFFpkZ7BZtaClGjk3oFJVouonid2cvJWPfU8amnWFLjXAk=
X-Received: by 2002:a25:c5c8:0:b0:dc3:6b67:9341 with SMTP id
 v191-20020a25c5c8000000b00dc36b679341mr1497437ybe.37.1706639514684; Tue, 30
 Jan 2024 10:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
In-Reply-To: <Zbk6h0ogqeInLa_1@redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 30 Jan 2024 19:31:42 +0100
X-Gmail-Original-Message-ID: <CAHmME9p3AT+MYXD9G0NL0Ge+-eh4cOc7HVQmk4uzi7ZjXH3hww@mail.gmail.com>
Message-ID: <CAHmME9p3AT+MYXD9G0NL0Ge+-eh4cOc7HVQmk4uzi7ZjXH3hww@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"x86@kernel.org" <x86@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:06=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Jan 30, 2024 at 06:49:15PM +0100, Jason A. Donenfeld wrote:
> > On Tue, Jan 30, 2024 at 6:32=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> > >
> > > On 1/30/24 05:45, Reshetova, Elena wrote:
> > > >> You're the Intel employee so you can find out about this with much
> > > >> more assurance than me, but I understand the sentence above to be =
_way
> > > >> more_ true for RDRAND than for RDSEED. If your informed opinion is=
,
> > > >> "RDRAND failing can only be due to totally broken hardware"
> > > > No, this is not the case per Intel SDM. I think we can live under a=
 simple
> > > > assumption that both of these instructions can fail not just due to=
 broken
> > > > HW, but also due to enough pressure put into the whole DRBG constru=
ction
> > > > that supplies random numbers via RDRAND/RDSEED.
> > >
> > > I don't think the SDM is the right thing to look at for guidance here=
.
> > >
> > > Despite the SDM allowing it, we (software) need RDRAND/RDSEED failure=
s
> > > to be exceedingly rare by design.  If they're not, we're going to get
> > > our trusty torches and pitchforks and go after the folks who built th=
e
> > > broken hardware.
> > >
> > > Repeat after me:
> > >
> > >         Regular RDRAND/RDSEED failures only occur on broken hardware
> > >
> > > If it's nice hardware that's gone bad, then we WARN() and try to make
> > > the best of it.  If it turns out that WARN() was because of a broken
> > > hardware _design_ then we go sharpen the pitchforks.
> > >
> > > Anybody disagree?
> >
> > Yes, I disagree. I made a trivial test that shows RDSEED breaks easily
> > in a busy loop. So at the very least, your statement holds true only
> > for RDRAND.
> >
> > But, anyway, if the statement "RDRAND failures only occur on broken
> > hardware" is true, then a WARN() in the failure path there presents no
> > DoS potential of any kind, and so that's a straightforward conclusion
> > to this discussion. However, that really hinges on  "RDRAND failures
> > only occur on broken hardware" being a true statement.
>
> There's a useful comment here from an Intel engineer
>
> https://web.archive.org/web/20190219074642/https://software.intel.com/en-=
us/blogs/2012/11/17/the-difference-between-rdrand-and-rdseed
>
>   "RDRAND is, indeed, faster than RDSEED because it comes
>    from a hardware-based pseudorandom number generator.
>    One seed value (effectively, the output from one RDSEED
>    command) can provide up to 511 128-bit random values
>    before forcing a reseed"
>
> We know we can exhaust RDSEED directly pretty trivially. Making your
> test program run in parallel across 20 cpus, I got a mere 3% success
> rate from RDSEED.
>
> If RDRAND is reseeding every 511 values, RDRAND output would have
> to be consumed significantly faster than RDSEED in order that the
> reseed will happen frequently enough to exhaust the seeds.
>
> This looks pretty hard, but maybe with a large enough CPU count
> this will be possible in extreme load ?

So what this suggests is that the guest-guest DoS caused by looping
forever (or panic-on-warn'ing) is at least possible on large enough
hardware for some non-zero amount of time, depending on whatever hard
to hit environmental factors.

Another approach would be to treat this as a hardware flaw, in that
the RDRAND does not provide a universally reliable interface, and so
something like CoCo doesn't work with the current design, and so Intel
should issue some microcode updates that gives some separated pools
and separated rate limiting on a per-VMX ring 0 basis. Or something
like that. I dunno; maybe it's unrealistic to hope Intel will repair
their interface. But I think we've got to acknowledge that it's sort
of broken/irreliable.

Jason

