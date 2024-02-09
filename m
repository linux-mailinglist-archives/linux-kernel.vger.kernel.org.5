Return-Path: <linux-kernel+bounces-59903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB1484FD2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182C6286FFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D545784A53;
	Fri,  9 Feb 2024 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OZrcJOhA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1389584A42
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508202; cv=none; b=kKt3Ex+Z81ayB8vISBCcUvttcRZwFTUmS4gULoEPUnqogtkK26Oc7meN/FnvBcMSa/VnopJjt+E2Fr8ZO6pA+s374kZlLCKlVqqiOUJytYdOsjntXSleN5iWTFnUe3EPHksrERwpbMMgcuioGlBe0LakdwUol/S3bRT69mh5Abs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508202; c=relaxed/simple;
	bh=iTu1VA2xMG+lx8NyzpZCf6Y+0UQu7r2E3itVvpPoWuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQtoE/A0zqZTOskLOiEvGFhRECJMEjXt6/EVRR76ewwiRmtiyTA4REr46F4NG520dhiH5QWGODiSE6s698vWrG8fDT4DnMSIv/dZ34EF3DYAxstvdofLn/M3G4prGCgd7eekWq2vLvkFevE9ghprHPiQN1zz5wASbopZd3YF5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=OZrcJOhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468B9C433C7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OZrcJOhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1707508196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTu1VA2xMG+lx8NyzpZCf6Y+0UQu7r2E3itVvpPoWuk=;
	b=OZrcJOhAhnSTYQ1X/TVOIHpzy8J0VGenQG9Zkh/33gi9IJh7+fc3FEIbIhSko3Jonqf21+
	9772JZos8Q2dwBP9ZlKOGxNDAsvDO8e4bRmSPPUjYbO1lW6clBS128h9JQ+mP1zUu+KrhE
	C75Tir8zeKaA0AiU45HQqb2nM1rMUbI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a63a0d3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Fri, 9 Feb 2024 19:49:56 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso1392586276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 11:49:55 -0800 (PST)
X-Gm-Message-State: AOJu0Yxbe9dGMUNN62De7Md3SMPCY+l3FFslTkLUjeOVR2xTfU1XZYIh
	g4gw3Q412nq+H4ZDNwPTnsIZQqKS2xlCrB30fldxOAgUNQiS9T+feMuAOqJrF1tSpsVvUKVQp+B
	4O/DAGMXK9BxFOLwVnuO7QiukDo4=
X-Google-Smtp-Source: AGHT+IEnmYc5xL/JOVB1tx6sQdZ7M72qNY2SDRwlgVZZzRP3BJ91yZNqzfciMT2T1i9jWXyzaOpvl6tI5WYyO1fvkHI=
X-Received: by 2002:a25:d655:0:b0:dc2:4400:f69a with SMTP id
 n82-20020a25d655000000b00dc24400f69amr151606ybg.24.1707508193534; Fri, 09 Feb
 2024 11:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240206011247.GA29224@wind.enjellic.com> <ZcHoKUElwXGPzrWb@redhat.com>
 <20240206120445.GA1247@wind.enjellic.com> <20240206153529.GHZcJRwTdDkWXuopOQ@fat_crate.local>
 <20240208114444.GA23164@wind.enjellic.com> <20240209173102.GBZcZhVuFJZ8JOKTjG@fat_crate.local>
In-Reply-To: <20240209173102.GBZcZhVuFJZ8JOKTjG@fat_crate.local>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 9 Feb 2024 20:49:40 +0100
X-Gmail-Original-Message-ID: <CAHmME9pEVNM6UVW+pKbTZEhsnrGvq5ERMOSC1ezdrCn96q36kA@mail.gmail.com>
Message-ID: <CAHmME9pEVNM6UVW+pKbTZEhsnrGvq5ERMOSC1ezdrCn96q36kA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
To: Borislav Petkov <bp@alien8.de>
Cc: "Dr. Greg" <greg@enjellic.com>, "Daniel P. Berrang??" <berrange@redhat.com>, 
	"Reshetova, Elena" <elena.reshetova@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Boris,

While you're here, I was wondering if you could comment on one thing relate=
d:

On Fri, Feb 9, 2024 at 6:31=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
> Now, considering that this is a finite resource, you can imagine that
> there can be scenarios where that source can be depleted.

Yea, this makes sense.

[As an aside, I would like to note that a different construction of
RDRAND could keep outputting good random numbers for a reeeeeallly
long time without needing to reseed, or without penalty if RDSEED is
depleted, and so could be made to actually never fail. But given the
design goals of RDRAND, this kind of crypto is highly likely to never
be implemented, so I'm not even moving to suggest that AMD/Intel just
'fix' the crypto design goals of the instruction. It's not gonna
happen for lots of reasons.]

So assuming that RDSEED and hence RDRAND can never be made to never
fail, the options are:

1. Finite resource that refills faster than whatever instruction
issuance latency, so it's never observably empty. (Seems unlikely)
2. More secure sharing of the finite resource.

It's this second option I wanted to ask you about. I wrote down what I
thought "secure sharing" meant here [1]:

> - One VMX (or host) context can't DoS another one.
> - Ring 3 can't DoS ring 0.

It's a bit of a scheduling/queueing thing, where different security
contexts shouldn't be able to starve others out of the finite resource
indefinitely.

What I'm wondering is if that kind of fairness is even possible to
achieve in the hardware or the microcode. I don't really know how that
all works under the covers and what sorts of "policies" and such are
feasible to implement. In suggesting it, I feel like a bit of a
presumptuous kernel developer talking to hardware people, not fully
appreciating their domain and its challenges. For, if this were just a
C program, I know exactly what I'd do, but we're talking about a CPU
here.

Is it actually possible to make RDRAND usage "fair" between different
security contexts? Or am I totally delusional and this is not how the
hardware works or can ever work?

Jason

[1] https://lore.kernel.org/all/CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=3D-UxxGFb=
Ax_RrxSHoA@mail.gmail.com/

