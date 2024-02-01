Return-Path: <linux-kernel+bounces-47759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B084526E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CC51C2304F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28485C7D;
	Thu,  1 Feb 2024 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeJcmdHo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8715A4B0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774916; cv=none; b=S6BituEdn1IP2sgAA7Q6nZnMsvJQY/np7ayPQaPRwaP1lilTAUeRa5toVggsjWHHwxR2gmA6VJH5LxRZdDDk5PGFSZ26Z1zxa5/Im+uDd5Ei7A0Q0qqUwWGfeGXtDaRrDB5ugcFF3jojidX6SJsaqqc6cTnQY5ri3jHdEoo0Qt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774916; c=relaxed/simple;
	bh=80iEY38zsgd9OCT3t544kEkSOZkE0dD85Ix/M+1O2BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dho0+R5HuZh5nyh4TOTX/FWlKIW0aapHPgTeDU3wDUOpfPwliuxGLc8HHt9ydb6r4kwVbBDjRCkcEAptA1XmZbT/FDuqEfzurJSe/idHtx5CH19v4GfLroWXqAr1WHTN6bXswsjVRkshZ6PsK9uforLtJicV/G6L4SYD6iA7Ihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeJcmdHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AB9C433C7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706774916;
	bh=80iEY38zsgd9OCT3t544kEkSOZkE0dD85Ix/M+1O2BU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZeJcmdHo9o6FpHFw4iLCXq4+J1qdCA/SlP97RJcgVHtkrMRGoloeByjo9vJsM445B
	 uFCMtVYgiKI0WZtBQFLgHV/qEd6OrzbfYfjv6att+5yiiCXTOTAFn7OSJsLeshYlxO
	 /mOYEs5LMLMAn9wozoIDIAJalV6rMUdkge+IzZDNDeA0x2TdKunilZ4YTS7OkbDkxh
	 lmL74u1lPTX1esKFUCqxJkHJKELhdNgwZArMIxMTPuLqcEWK0rLQT1ftcPQEcfbf8x
	 uie+q7X9bDJJdVdqp7VhUE4sNVHKE4j7dqekD9xkWjrY9keHUXt++Mxgg+udB7u2ZU
	 UeTJ8UOKQv+XA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51025cafb51so937863e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:08:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yzo3ohO5CIOW/ZZpfG0AiyZf/e25fp2iMbHNJ9hqrK/VUlRlSUT
	SzRMwHuv6aBZ/brBM12GeLNC/Re0tL1Z2+HRbDzutx6a9Fbf1TKGFTZEWkbMQIlJVeN9hKwOe4H
	OqBE2OKgPAA7eo1SFaTZj1Hu0Jrk=
X-Google-Smtp-Source: AGHT+IGhBUKmljKJfZeXj+8Ve9fOqnJzpejDeg1q9FFFeW5EZLsJSwz6ISHgy2V308b0s7VoY/xxGjq3mZIH0xASGJ0=
X-Received: by 2002:ac2:5329:0:b0:511:f4c:8aa3 with SMTP id
 f9-20020ac25329000000b005110f4c8aa3mr1219549lfh.7.1706774914479; Thu, 01 Feb
 2024 00:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131065322.1126831-1-maskray@google.com> <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
 <ZbpEnDK3U/O24ng0@e133380.arm.com> <20240201045551.ajg4iqcajyowl2rh@google.com>
In-Reply-To: <20240201045551.ajg4iqcajyowl2rh@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 1 Feb 2024 09:08:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEBjumu3VUySg1cQ+SYm4MugJ5f6pd1f7C0XrLyOWAoOw@mail.gmail.com>
Message-ID: <CAMj1kXEBjumu3VUySg1cQ+SYm4MugJ5f6pd1f7C0XrLyOWAoOw@mail.gmail.com>
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
To: Fangrui Song <maskray@google.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 05:55, Fangrui Song <maskray@google.com> wrote:
>
> On 2024-01-31, Dave Martin wrote:
> >On Wed, Jan 31, 2024 at 08:16:04AM +0100, Ard Biesheuvel wrote:
> >> Hello Fangrui,
> >>
> >> On Wed, 31 Jan 2024 at 07:53, Fangrui Song <maskray@google.com> wrote:
> >> >
> >> > The constraint "i" seems to be copied from x86 (and with a redundant
> >> > modifier "c"). It works with -fno-PIE but not with -fPIE/-fPIC in GCC's
> >> > aarch64 port.
> >
> >(I'm not sure of the exact history, but the "c" may be inherited from
> >arm, where an output modifier was needed to suppress the "#" that
> >prefixes immediates in the traditional asm syntax.  This does not
> >actually seem to be required for AArch64: rather while a # is allowed
> >and still considered good style in handwritten asm code, the syntax
> >doesn't require it, and the compiler doesn't emit it for "i" arguments,
> >AFAICT.)
>
> The aarch64 one could be inherited from
> arch/arm/include/asm/jump_label.h (2012), which could in turn be
> inherited from x86 (2010).
> Both the constraint "i" and the modifier "c" are generic..
> For -fno-pic this combination can be used for every arch.
>
> >> > The constraint "S", which denotes a symbol reference (e.g. function,
> >> > global variable) or label reference, is more appropriate, and has been
> >> > available in GCC since 2012 and in Clang since 7.0.
> >> >
> >> > Signed-off-by: Fangrui Song <maskray@google.com>
> >> > Link: https://maskray.me/blog/2024-01-30-raw-symbol-names-in-inline-assembly
> >> > ---
> >> >  arch/arm64/include/asm/jump_label.h | 8 ++++----
> >> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> >> > index 48ddc0f45d22..31862b3bb33d 100644
> >> > --- a/arch/arm64/include/asm/jump_label.h
> >> > +++ b/arch/arm64/include/asm/jump_label.h
> >> > @@ -23,9 +23,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> >> >                  "      .pushsection    __jump_table, \"aw\"    \n\t"
> >> >                  "      .align          3                       \n\t"
> >> >                  "      .long           1b - ., %l[l_yes] - .   \n\t"
> >> > -                "      .quad           %c0 - .                 \n\t"
> >> > +                "      .quad           %0 - .                  \n\t"
> >> >                  "      .popsection                             \n\t"
> >> > -                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> >> > +                :  :  "S"(&((char *)key)[branch]) :  : l_yes);
> >>
> >> 'key' is not used as a raw symbol name. We should make this
> >>
> >> "    .quad   %0 + %1 - ."
> >>
> >> and
> >>
> >> ::  "S"(key), "i"(branch) :: l_yes);
> >>
> >> if we want to really clean this up.
> >
> >This hides more logic in the asm so it's arguably more cryptic
> >(although the code is fairly cryptic to begin with -- I don't really
> >see why the argument wasn't written as the equivalent
> >(char *)key + branch...)
>
> I agree that using "S" and "i" would introduce complexity.
> Using just "S" as this patch does should be clear.
>
> All of "i" "s" "S" support a symbol or label reference and a constant offset (can be zero),
> (in object file, a symbol and an addend; in GCC's term, the sum of a SYMBOL_REF and a CONST_INT).
>

Taken the address of a struct, cast it to char[] and then index it
using a boolean is rather disgusting, no?

> >Anyway, I don't think the "i" versys "S" distinction makes any
> >difference without -fpic or equivalent, so it is not really relevant
> >for the kernel (except that "S" breaks compatibility with older
> >compilers...)
> >
> >
> >I think the main advantage of "S" is that it stops you accidentally
> >emitting undesirable relocations from asm code that is not written for
> >the -fpic case.
> >
> >But just changing "i" to "S" is not sufficient to port asms to -fpic:
> >the asms still need to be reviewed.
> >
> >
> >So unless the asm has been reviewed for position-independence, it may
> >anyway be better to stick with "i" so that the compiler actually chokes
> >if someone tries to build the code with -fpic.
>

The virtual address of the kernel is randomized by KASLR, which relies
on PIE linking, and this puts constraints on the permitted types of
relocations.

IOW, we basically already build the kernel as PIC code, but without
relying on -fPIC, because that triggers some behaviors that only make
sense for shared objects in user space.

> >Since we are not trying to run arbitraily many running kernels in a
> >common address space (and not likely to do that), I'm not sure that we
> >would ever build the kernel with -fpic except for a few special-case
> >bits like the EFI stub and vDSO... unless I've missed something?
> >

Yes, KASLR. The number of kernels is not the point, the point is that
the virtual load address of the kernel is usually decided at boot, and
so the code needs to be generated to accommodate that.

> >If there's another reason why "S" is advantageous though, I'm happy to
> >be corrected.
>
> I remember that Ard has an RFC
> https://lore.kernel.org/linux-arm-kernel/20220427171241.2426592-1-ardb@kernel.org/
> "[RFC PATCH 0/2] arm64: use PIE code generation for KASLR kernel"
> and see some recent PIE codegen patches.
>
> > Building the KASLR kernel without -fpie but linking it with -pie works
> > in practice, but it is not something that is explicitly supported by the
> > toolchains - it happens to work because the default 'small' code model
> > used by both GCC and Clang relies mostly on ADRP+ADD/LDR to generate
> > symbol references.
>
> I agree that current -fno-PIE with -shared -Bsymbolic linking is a hack
> that works as a conincidence, not guaranteed by the toolchain.
> This jump_label improvement (with no object file difference) fixes an
> obstacle.

If we can get the guaranteed behavior of #pragma GCC visibility
push(hidden) from a command line option, we should build the core
kernel with -fpie instead. (Modules are partially linked objects, so
they can be built non-PIC as before)

