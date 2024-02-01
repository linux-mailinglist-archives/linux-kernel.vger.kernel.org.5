Return-Path: <linux-kernel+bounces-48473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C691845C7B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C651C2C034
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9B626AC;
	Thu,  1 Feb 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUUzmHEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E38626AB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803693; cv=none; b=Keea8EbgUPlOUoJfop3rSkYM4swvzClynyZwiXBWjOZck4OPtPFp6PMsuQp0KTDwtfT0USJSY5ZbrLW8gp26oC1l3jzsPsNalqPnEYpASsOFQ8mXN3zf2rWxqs8KKtcdPOre+mqvnVDIxrfm6hDeESLoJcamM5Yd9kdFoMPnFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803693; c=relaxed/simple;
	bh=IQySAzz9Zu8aTmpkZztHBF6bTqnVGs1D4j6xRTD+u78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OO0vjRZ3jSB6ZQkxwbK96r8LAjTgE954tLJcPz+St38a/8au2nUN4YtYzDyqGI7ERizJ10IZGkH/6fcRqv4rtJjUWoHTZ9duhKae9Yp9pdrLq2JRBQJ96VRNApweIs9mzThbEO/0yuWqedRFBXdTNllLT0YDNOBVYfBgTS9nMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUUzmHEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9C2C43390
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706803692;
	bh=IQySAzz9Zu8aTmpkZztHBF6bTqnVGs1D4j6xRTD+u78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cUUzmHEO/igmXwIC/qHOSTaGa/XGD4ablIU+fzN4OHDEgma6p7JHRgSYAk4+Ya3n2
	 UFyxi6U3C16UEPnSlA+5BFr0BjEXOz5/iqYyRL/jgRJDrjEiNg9jmagTUmeIGAEWRF
	 Eyw9ox/rk8oMtd5CqeN7vAOqfr0BVEQr2noapMR8hhyMOFP1MSaWkM+jWaRU+AtazA
	 rF4lZo2FRJpbpBbe+MRNjcY2aUckFRykLeDMKsr9fbp9Vs0bwnABHdPCEk0YsmDdCd
	 /59/HOaw4muVD+1b1WumiFslSCRt+7tgXW1TuYe++sjdKyHs4eTiLnxA6quYvB44lR
	 u6VyoRx774uFg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d070e2ba0bso12252541fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:08:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yz40bA+pWsNzwiHb1+Hdm/yqRMNFbVF+rk+xVX2N65breK1e/TD
	HSzhn7HkaDWGjftxWfHi1rpmNlQRoqb/7wgkLMZDhQTD3QMnvkuTFKXslxQEZjWChKx8BeQhsjh
	hDkReJhFlKoenRT6rAyFggpuqtbc=
X-Google-Smtp-Source: AGHT+IE3Hk5cExk7Fw6yQzo0QX0tf+LAr5EK/c/iR5/9+KNCkLRMPottyLcZvkC3HNIjYaQ4HPMi76Ysya0jkxhojRs=
X-Received: by 2002:a05:651c:157:b0:2cd:2771:a2fb with SMTP id
 c23-20020a05651c015700b002cd2771a2fbmr2851945ljd.2.1706803690871; Thu, 01 Feb
 2024 08:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131065322.1126831-1-maskray@google.com> <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
 <ZbpEnDK3U/O24ng0@e133380.arm.com> <20240201045551.ajg4iqcajyowl2rh@google.com>
 <CAMj1kXEBjumu3VUySg1cQ+SYm4MugJ5f6pd1f7C0XrLyOWAoOw@mail.gmail.com>
 <20240201091120.pbgr7ng6t2c36fut@google.com> <ZbuFWSRBntgm2ukJ@e133380.arm.com>
In-Reply-To: <ZbuFWSRBntgm2ukJ@e133380.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 1 Feb 2024 17:07:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGu76WHY8=Y-KhCxBq3xeHeCYQ9syqViSr9VRkjgWQ3BQ@mail.gmail.com>
Message-ID: <CAMj1kXGu76WHY8=Y-KhCxBq3xeHeCYQ9syqViSr9VRkjgWQ3BQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
To: Dave Martin <Dave.Martin@arm.com>
Cc: Fangrui Song <maskray@google.com>, Peter Smith <peter.smith@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 12:50, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Thu, Feb 01, 2024 at 01:11:20AM -0800, Fangrui Song wrote:
..
> >
> > Hmm. Clang's constraint "S" implementation doesn't support a constant
> > offset, so
> > `static_key_false(&nf_hooks_needed[pf][hook])` in include/linux/netfilter.h:nf_hook
> > would not compile with Clang <= 18.
> >
> > I have a patch https://github.com/llvm/llvm-project/pull/80255 , but
> > even if it is accepted and cherry-picked into the 18.x release branch,
> > if we still support older Clang, we cannot use "S" unconditionally.
> >
> >
> > So we probably need the following to prepare for -fPIE support in the
> > future:
> >
> > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> > index 48ddc0f45d22..b8af2f8b0c99 100644
> > --- a/arch/arm64/include/asm/jump_label.h
> > +++ b/arch/arm64/include/asm/jump_label.h
> > @@ -15,6 +15,16 @@
> >  #define JUMP_LABEL_NOP_SIZE          AARCH64_INSN_SIZE
> > +/*
> > + * Prefer "S" to support PIC. However, use "i" for Clang 18 and earlier as "S"
> > + * on a symbol with a constant offset is not supported.
> > + */
> > +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 18
>
> Is a GCC version check needed?  Or is the minimum GCC version specified
> for building the kernel new enough?
>
> > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
> > +#else
> > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "S"
> > +#endif
> > +

Can we use "Si" instead?

> >  static __always_inline bool arch_static_branch(struct static_key * const key,
> >                                              const bool branch)
> >  {
> > @@ -23,9 +33,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> >                "      .pushsection    __jump_table, \"aw\"    \n\t"
> >                "      .align          3                       \n\t"
> >                "      .long           1b - ., %l[l_yes] - .   \n\t"
> > -              "      .quad           %c0 - .                 \n\t"
> > +              "      .quad           %0 + %1 - .             \n\t"
> >                "      .popsection                             \n\t"
> > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> > +              :  :  JUMP_LABEL_STATIC_KEY_CONSTRAINT(key), "i"(branch) :  : l_yes);
>
> While this looks reasonable, I'm still not clear now why the asm must do
> the addition.
>
> Can we roll the branch argument into the macro?
>
> "S"(symbol + constant) seems to do the right thing for AArch64, at least
> in GCC.
>

'symbol' is a struct static_key pointer, so adding '1' to it will not
produce the needed result.

..
> > > > >If there's another reason why "S" is advantageous though, I'm happy to
> > > > >be corrected.
> > > >
> > > > I remember that Ard has an RFC
> > > > https://lore.kernel.org/linux-arm-kernel/20220427171241.2426592-1-ardb@kernel.org/
> > > > "[RFC PATCH 0/2] arm64: use PIE code generation for KASLR kernel"
> > > > and see some recent PIE codegen patches.
> > > >
> > > > > Building the KASLR kernel without -fpie but linking it with -pie works
> > > > > in practice, but it is not something that is explicitly supported by the
> > > > > toolchains - it happens to work because the default 'small' code model
> > > > > used by both GCC and Clang relies mostly on ADRP+ADD/LDR to generate
> > > > > symbol references.
>
> Does this mean that doing boot-time relocation on a fully statically
> linked kernel doesn't bring much benefit?

Not sure I follow you here. The boot-time relocation is necessary in
any case, to fix up statically initialized pointer variables all over
the kernel.

> It would tend to be more
> painful to do the relocation work, and mean that the kernel text has to
> be temporarily writeable, but static linking should have the best
> runtime performance.
>

Not sure what you mean by 'static linking' here.

The only thing PIE linking does in the case of the kernel is
a) complain if static relocations are used that cannot be fixed up at
runtime (e.g., movk/movz sequences)
b) emit dynamic relocations that the early startup code can use to fix
up all statically initialized pointers

From a codegen point-of-view, there is no difference because we don't
use -fpic code. The problem with -fpic codegen is that it makes some
assumptions that only hold for shared ELF objects, e.g., avoiding
dynamic relocations in .text, using GOT entries even for variables
defined in the same compilation so that they can be preempted, keeping
all runtime relocatable quantities together so the CoW footprint of
the shared library is minimized.

None of this matters for the kernel, and as it turns out, the non-PIC
small C model produces code that the PIE linker is happy with.

TL;DR our code (including inline and out-of-line asm) is already PIC,
and this property is relied upon by KASLR.

> Maybe it doesn't make as much difference as I thought (certainly ADRP
> based addressing should make a fair amount of the PIC/PIE overhead go
> away).
>

The PIC/PIE overhead is in the indirections via the GOT. However,
recent linkers will actually perform some relaxations too: if a symbol
is defined in the same executable and is not preemptible, a GOT load

ADRP
LDR

can be transparently converted to

ADRP
ADD

referring to the symbol directly. This is also where hidden.h comes
in: making all symbol declarations and definitions 'hidden' will allow
the compiler to assume that a GOT entry is never needed.

So building with -fPIC is currently not need in practice, and creates
some complications, which is why we have been avoiding it. But PIE
linking non-PIC objects is not guaranteed to remain supported going
forward, so it would be better to have a plan B, i.e., being able to
turn on -fpic without massive regressions due to GOT overhead, or
codegen problems with our asm hacks.

