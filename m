Return-Path: <linux-kernel+bounces-152016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17828AB773
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820CA1F21A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2FC13D88F;
	Fri, 19 Apr 2024 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jRzCfYod"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9C64D;
	Fri, 19 Apr 2024 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713569273; cv=none; b=KMJ/nAYqM3R5uLkAwq2w0IZw5eOdlyZajKGios0i/HM1/GAXNq/gTRgLwkTNxmoyLW0vaqHnTjjk2Xx30TMbj2R37MrP8pMHwIqJqaWDQPxZscjHlRMf11OJOK5CE2ydddg7kZ3ZgIRD3jef6ly0RKOR2JBggheTiQxSiRMPIbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713569273; c=relaxed/simple;
	bh=+Qx+phbbez3nCafVJWvHw2p/4Osq43K/uQphuHmnUwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDLb4QCC1OCpKhSdW8ZmnRBcHAcCMtbFOnhoSI8wul1PvvMKFtgERjRx6owDsHjmJFUGurahqd0X2HAxBbGctE9dOfLmPTn9/KgJsAPs5CVdNkt/DC8/9f6lraX7aVMwBgRB9nrd/kM8lnannijdhQSuTp55OTTpu2vj20QleO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=jRzCfYod; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713569268;
	bh=0COLxRjPIo77fJ3J44TSQPzwMK0xvmc5G2PIo/aN2Q8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jRzCfYodBkOvSSB3DEIlwaJYIHkgEocozaQ66gtnmx5Gcv6SEyXG11mGfxhHYwSke
	 WWOSHQ4aB+1bBQcWeYCAG4b09buYqx/SU3cEtl4pcEOrjy5qFSbteJsh+mrhevSvxn
	 eX6sDRRAJTTN2fZJ5Uy9PDZF/YUOPbI4SFIogsdFCK/v4MXX8pdHgeJbEMx5Y0LjnH
	 fPP/0ocARMSuF7TM+93Ar+IzQiu/3IzaNgE3E3diUMRA9RxmuUv/7ZvjuE8qz7Bo4T
	 aqvOs5qIPJXQHQXCUrFvX7AAfrZi/wrUZtJbkVKni2l6MslwX2g82hcad7fASbUyd0
	 wQboUqWmZ1ALQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VLrR66xPqz4wjF;
	Sat, 20 Apr 2024 09:27:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Sean Christopherson
 <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell
 <sfr@canb.auug.org.au>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] cpu: Re-enable CPU mitigations by default for !X86
 architectures
In-Reply-To: <20240419160537.namt5yaxhhvwwa3r@treble>
References: <20240417001507.2264512-1-seanjc@google.com>
 <20240417001507.2264512-2-seanjc@google.com>
 <20240419160537.namt5yaxhhvwwa3r@treble>
Date: Sat, 20 Apr 2024 09:27:45 +1000
Message-ID: <87mspp9bm6.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Poimboeuf <jpoimboe@kernel.org> writes:
> On Tue, Apr 16, 2024 at 05:15:06PM -0700, Sean Christopherson wrote:
>> Add a generic Kconfig, CPU_MITIGATIONS, to control whether or not CPU
>> mitigations are enabled by default, and force it on for all architectures
>> except x86.  A recent commit to turn mitigations off by default if
>> SPECULATION_MITIGATIONS=n kinda sorta missed that "cpu_mitigations" is
>> completely generic, where as SPECULATION_MITIGATIONS is x86 specific.
>> 
>> Alternatively, SPECULATION_MITIGATIONS could simply be defined in common
>> code, but that creates weirdness for x86 because SPECULATION_MITIGATIONS
>> ends up being defined twice, and the default behavior would likely depend
>> on the arbitrary include order (if the two definitions diverged).
>> 
>> Ideally, CPU_MITIGATIONS would be unconditionally on by default for all
>> architectures, and manually turned off, but there is no way to unselect a
>> Kconfig.
>> 
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
>> Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>
> It seems confusing to have two config options which have very similar
> names and similar purposes (with subtle differences depending on the
> arch).

I agree.

But can we please get Sean's fix into mainline before rc5.

cheers

