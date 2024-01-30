Return-Path: <linux-kernel+bounces-45056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6E842B31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB6B1F25BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1457114E2F0;
	Tue, 30 Jan 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gIN8VhvT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E69814E2C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636975; cv=none; b=G+LBZaL+ByqoaKrsRSyXxWWJftyQv7qgIzCb89qmJXRo4jO48Xx+EUvZILFKnQm4lxHS7t0MtP5PVrXeFZfJvq0XIogo5A5NA0CxXc2uv8F7RxR03qOEPz20hOO3siPdDjggOwCMZqgubKNFJUJAAzB65uKiv8/iGtQSnOcYz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636975; c=relaxed/simple;
	bh=uUolOJPs7PcsSO8pX6bnVtt9RGczJbbnLYDex4l5IPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ9XtYnpILwgeoPFRxYUs+SXkgT5U4W6vBpx/3qys5pb6hU+d0Fu1YpXORhDoja3Ja9r/Syv6LGZib1j5ZU3RulwVJSBhkpNQ8rjUJckd2RCEMoa9PoNP2zN7UxgFLpqHekYcw9qnly5dyZeic9AUvslyfBA6LWqk23iWwlYrSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=gIN8VhvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DF9C43390
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gIN8VhvT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706636970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Knx9g79k0rFxrK4L1nPhOd7Un1aev4/x+NEZ8GHY+I=;
	b=gIN8VhvTTNWxaGLr62xCJM3TfKEkNERfCai3Go1KgURbJVqy5svaPDUaCtk2VY2hvmMzky
	SJL9CP8ySYJJdCGtDGCmUwNZgMwTkbKi7T6kjJ2r/NvXAYzHwT5UXYCcHYJ7UxyK8iOTr8
	hljsZqdvcGxuDO62bgzxRJ1Sq+R9Sts=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 212dcd51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 30 Jan 2024 17:49:28 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-603fd31f5c2so576567b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:49:28 -0800 (PST)
X-Gm-Message-State: AOJu0YxKjFeODiGFLZK7VoPeNR/LZN4lJogfymBI/86wny7oPT7v6gGC
	e3bAMk6hqkMp6F6lxwZknYUZyBvCnxbk8NYfEztjhHtSCTqK3xelwMEtbFe7boK/nNKZCLFu0sg
	W5WWUHbaGzqz0o2eyAaBzPPQsCQA=
X-Google-Smtp-Source: AGHT+IEkQ6Cnv5sCPYflR4LrOtKu6FC4QUWbNjKBLu9x86naZqJGBC0K6T9RRaFbxh0uBfSBOld/mcfsb/7Wot5OKTo=
X-Received: by 2002:a81:b544:0:b0:5ff:9565:6f59 with SMTP id
 c4-20020a81b544000000b005ff95656f59mr1254324ywk.3.1706636967028; Tue, 30 Jan
 2024 09:49:27 -0800 (PST)
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
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
In-Reply-To: <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 30 Jan 2024 18:49:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
Message-ID: <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>, 
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

On Tue, Jan 30, 2024 at 6:32=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 1/30/24 05:45, Reshetova, Elena wrote:
> >> You're the Intel employee so you can find out about this with much
> >> more assurance than me, but I understand the sentence above to be _way
> >> more_ true for RDRAND than for RDSEED. If your informed opinion is,
> >> "RDRAND failing can only be due to totally broken hardware"
> > No, this is not the case per Intel SDM. I think we can live under a sim=
ple
> > assumption that both of these instructions can fail not just due to bro=
ken
> > HW, but also due to enough pressure put into the whole DRBG constructio=
n
> > that supplies random numbers via RDRAND/RDSEED.
>
> I don't think the SDM is the right thing to look at for guidance here.
>
> Despite the SDM allowing it, we (software) need RDRAND/RDSEED failures
> to be exceedingly rare by design.  If they're not, we're going to get
> our trusty torches and pitchforks and go after the folks who built the
> broken hardware.
>
> Repeat after me:
>
>         Regular RDRAND/RDSEED failures only occur on broken hardware
>
> If it's nice hardware that's gone bad, then we WARN() and try to make
> the best of it.  If it turns out that WARN() was because of a broken
> hardware _design_ then we go sharpen the pitchforks.
>
> Anybody disagree?

Yes, I disagree. I made a trivial test that shows RDSEED breaks easily
in a busy loop. So at the very least, your statement holds true only
for RDRAND.

But, anyway, if the statement "RDRAND failures only occur on broken
hardware" is true, then a WARN() in the failure path there presents no
DoS potential of any kind, and so that's a straightforward conclusion
to this discussion. However, that really hinges on  "RDRAND failures
only occur on broken hardware" being a true statement.

Also, I don't know how much heavy lifting the word "regular" was doing
in your original statement. Because my example shows that that
irregular RDSEED usage from malicious users can hinder regular users.
If that also applies to RDRAND, the "regular" makes the statement not
as useful for taking conclusive action here.

