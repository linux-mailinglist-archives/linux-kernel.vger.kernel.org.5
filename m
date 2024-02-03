Return-Path: <linux-kernel+bounces-51016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C29D848513
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C539228C074
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D7216415;
	Sat,  3 Feb 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0VHn/O7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E705D48A
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706953859; cv=none; b=gmXkp3gQTXJtsLgKeWpwOJmj4xvHNZqlfLRwpp5m1TBKqXqpBU8gz1R1vyccRrfVPzWNuoe64hSpdVtsWNUU15O/0MTVhylC+rIS3N2QwFdDSgIOKD4dK7KhYllJVmsPRbIOlyzOW1mBed8z+q2rQCj+gcxHr6OIrrxsZyCtub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706953859; c=relaxed/simple;
	bh=cJOhXguQPQBr4S4IC6VAvTKVkjqH1fiPyUPQjCwVy0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5uUc1Btj2yRW/xEMJ2nwFn3aNYdkNrm82MJgI+uF1+KT+sxSMChS9TVkunXKCKsEgQ3ZeRDJeJuMA9UdduNtsQxkM7RWrB5wgOyW8zUBU7ATf7m5oUlpC3sr385XhySY+UFMHIJbOLrCbR0b9EBrsuIZIoEdoM6jjdMAynLRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0VHn/O7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112ADC433A6
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706953859;
	bh=cJOhXguQPQBr4S4IC6VAvTKVkjqH1fiPyUPQjCwVy0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y0VHn/O75QWGxal82mHq9oD8iu/JkSp/jJOodDo18MPjCL1qMmy73zQU6wRIQsJ+Y
	 UAbNztpXr/3+HLTWqKpb522lne36lafP/0nNX5nHiESO9I/hFZ0VxjBLIzkoLfqF4L
	 2zW6gbHKzCDj1TZcDGX7VeK0//S8YCGMS28HNf8sRNpNYqsKa89SV8SmKR2QW4dgWP
	 zmtBQQVR8Ivzdb12LQuH+TqHy3v/lPJLid4Nx5mSbcrGFi3s3Ung6fRLX+BUISnOF9
	 o+VOiut+PcRIeq7UMx20Kcq4FY0GXoyZNX2AiR13C4Y3001hl2va6AD7PpbL0vcO65
	 jUlXds0pCmopg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso33942411fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 01:50:58 -0800 (PST)
X-Gm-Message-State: AOJu0YyQ0jBifBfgxqWyc+KCv3LBRf4f29Vdc+EwnrrOUgpP/gH/ODoe
	NKa765tl3fOLL3i0RBL/dyRvUvHc/Aml4NbpXEqZclkvaDMJ1Xqo5KXaXyw36CPtkGXdKi7sHTy
	rtpQfYCSikc7IYTUojuOGsAeZqII=
X-Google-Smtp-Source: AGHT+IGELIIp4B9X8esHC+qMYCIzZNAui/lgl5ooU0YejjT5BL4ohstC4OPvq3oqcEFmHkQTm/CweLTlzZ6+EccDeQI=
X-Received: by 2002:a05:651c:b27:b0:2d0:87a8:bda4 with SMTP id
 b39-20020a05651c0b2700b002d087a8bda4mr3383400ljr.25.1706953857022; Sat, 03
 Feb 2024 01:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201223545.728028-1-maskray@google.com> <Zb0Qu5lR0iZUqImb@e133380.arm.com>
 <CAMj1kXGSQ4Xq68Cmq6BH37FPJ+R+N5cOfrdC+aVML4sGaNDopg@mail.gmail.com>
 <Zb0eRogn3rjkeDAs@e133380.arm.com> <20240202225104.f4dsagfwf6gcnddy@google.com>
In-Reply-To: <20240202225104.f4dsagfwf6gcnddy@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 3 Feb 2024 10:50:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGN-nKSzxJoyM9peBTDevuPkH-+P2UzH746P-F913Dg-g@mail.gmail.com>
Message-ID: <CAMj1kXGN-nKSzxJoyM9peBTDevuPkH-+P2UzH746P-F913Dg-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: jump_label: use constraints "Si" instead of "i"
To: Fangrui Song <maskray@google.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 23:51, Fangrui Song <maskray@google.com> wrote:
>
> On 2024-02-02, Dave Martin wrote:
> >On Fri, Feb 02, 2024 at 05:32:33PM +0100, Ard Biesheuvel wrote:
> >> On Fri, 2 Feb 2024 at 16:56, Dave Martin <Dave.Martin@arm.com> wrote:
> >> >
> >> > On Thu, Feb 01, 2024 at 02:35:45PM -0800, Fangrui Song wrote:
> >> > > The generic constraint "i" seems to be copied from x86 or arm (and with
> >> > > a redundant generic operand modifier "c"). It works with -fno-PIE but
> >> > > not with -fPIE/-fPIC in GCC's aarch64 port.
> >> > >
> >> > > The machine constraint "S", which denotes a symbol or label reference
> >> > > with a constant offset, supports PIC and has been available in GCC since
> >> > > 2012 and in Clang since 7.0. However, Clang before 19 does not support
> >> > > "S" on a symbol with a constant offset [1] (e.g.
> >> > > `static_key_false(&nf_hooks_needed[pf][hook])` in
> >> > > include/linux/netfilter.h), so we use "i" as a fallback.
> >> > >
> >> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> >> > > Signed-off-by: Fangrui Song <maskray@google.com>
> >> > > Link: https://github.com/llvm/llvm-project/pull/80255 [1]
> >> > >
> >> > > ---
> >> > > Changes from
> >> > > arm64: jump_label: use constraint "S" instead of "i" (https://lore.kernel.org/all/20240131065322.1126831-1-maskray@google.com/)
> >> > >
> >> > > * Use "Si" as Ard suggested to support Clang<19
> >> > > * Make branch a separate operand
> >> > > ---
> >> > >  arch/arm64/include/asm/jump_label.h | 12 ++++++++----
> >> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> >> > >
> >> > > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> >> > > index 48ddc0f45d22..1f7d529be608 100644
> >> > > --- a/arch/arm64/include/asm/jump_label.h
> >> > > +++ b/arch/arm64/include/asm/jump_label.h
> >> > > @@ -15,6 +15,10 @@
> >> > >
> >> > >  #define JUMP_LABEL_NOP_SIZE          AARCH64_INSN_SIZE
> >> > >
> >> > > +/*
> >> > > + * Prefer the constraint "S" to support PIC with GCC. Clang before 19 does not
> >> > > + * support "S" on a symbol with a constant offset, so we use "i" as a fallback.
> >> > > + */
> >> > >  static __always_inline bool arch_static_branch(struct static_key * const key,
> >> > >                                              const bool branch)
> >> > >  {
> >> > > @@ -23,9 +27,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> >> > >                "      .pushsection    __jump_table, \"aw\"    \n\t"
> >> > >                "      .align          3                       \n\t"
> >> > >                "      .long           1b - ., %l[l_yes] - .   \n\t"
> >> > > -              "      .quad           %c0 - .                 \n\t"
> >> > > +              "      .quad           %0 + %1 - .             \n\t"
> >> > >                "      .popsection                             \n\t"
> >> > > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> >> > > +              :  :  "Si"(key), "i"(branch) :  : l_yes);
> >> >
> >> > Is the meaning of multi-alternatives well defined if different arguments
> >> > specify different numbers of alternatives?  The GCC documentation says:
> >> >
> >> > https://gcc.gnu.org/onlinedocs/gcc/Multi-Alternative.html:
> >> >
> >> > -8<-
> >> >
> >> > [...] All operands for a single instruction must have the same number of
> >> > alternatives.
> >> >
> >> > ->8-
> >> >
> >>
> >> AIUI that does not apply here. That reasons about multiple arguments
> >> having more than one constraint, where not all combinations of those
> >> constraints are supported by the instruction.
> >
> >Ah, scratch that: I'm confusing multi-alternatives with simple
> >constraints: all arguments must have the same number of comma-separated
> >lists of constraint letters, but each list can contain as many or as few
> >letters as are needed to match the operand.
> >
> >So "Si"(), "i"() is fine.
>
> "Si" is fine for GCC and Clang.
> "i" is fine for Clang but not for GCC PIC.
>
>      https://maskray.me/blog/2024-01-30-raw-symbol-names-in-inline-assembly#aarch64
>
>      In gcc/config/aarch64, LEGITIMATE_PIC_OPERAND_P(X) disallows any symbol
>      reference, which means that "i" and "s" cannot be used for PIC. Instead,
>      the constraint "S" has been supported since the initial port (2012) to
>      reference a symbol or label.
>
> I am also not familiar with
> https://gcc.gnu.org/onlinedocs/gcc/Multi-Alternative.html (comma in a
> constraint string). Thankfully we don't need this powerful construct:)
>
> >> > Also, I still think it may be redundant to move the addition inside the
> >> > asm, so long as Clang is happy with the symbol having an offset.
> >> >
> >>
> >> Older Clang is not happy with the symbol having an offset.
> >>
> >> And given that the key pointer and the 'branch' boolean are two
> >> distinct inputs to this function, I struggle to understand why you
> >> feel it is better to combine them in the argument. 'branch' is used to
> >> decide whether or not to set bit 0, independently of the value of key.
> >> Using array indexing to combine those values together to avoid an
> >> addition in the asm obfuscates the code.
> >
> >This was more about not making changes that don't need to be made,
> >unless it clearly makes the code better.
> >
> >But if some verions of Clang accept "S" but choke if there's an offset,
> >then moving the addition into the asm seems the way to go.
> >
> >(I may have misread the commit message on this point.)
> >
> >[...]
> >
> >Cheers
> >---Dave
>
> I am convinced by Ard' argument that two inputs (key, branch) deserve
> two operands.
> The existing "i"(&((char *)key)[branch]) is kinda ugly and also longer:)

If it helps clarify things, we might do something like

".quad  (%[key]  - .) + %[bit0]"

: : [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);

