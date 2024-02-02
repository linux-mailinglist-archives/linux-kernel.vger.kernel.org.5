Return-Path: <linux-kernel+bounces-50182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D024484756B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC31283230
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19A1487F1;
	Fri,  2 Feb 2024 16:54:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883A5B66F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892878; cv=none; b=abtfRS7dhn0elm33Tphib0zxpJPTwjHQHHO4nGYTIVRhPWAg1ecGJ0VpeQp+7oy4nRR67r6ShLj6CdrpIZRGpWi6ipnD1txO9UWcRg3G4ycxQidophFCesud+ScGdHmFwHQAiE+EMrF7Y1uDkC/50T67SpTYPoARUOkhSsdcemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892878; c=relaxed/simple;
	bh=spmM1QubFGEZoJZh8hihiLNYHhNUX0gbSoAYY3JQT9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF6DgKosJY0O3TmhDjhDsIPMjmeFfOu32TOjnfZMjVNr3f1UH0Ne7g4VWrL5Gp+E2iNbFmrrGYGgcHwLatplBwzezWQABFuI2dTY0YP/jF2xBNdB+b5nDULFnhl+Exnhshm8o3DhOTG9eF1fMDQ/SxzRUZRs6ntsPphURcGDpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6188DA7;
	Fri,  2 Feb 2024 08:55:16 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CB093F762;
	Fri,  2 Feb 2024 08:54:33 -0800 (PST)
Date: Fri, 2 Feb 2024 16:54:30 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Fangrui Song <maskray@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraints "Si" instead of "i"
Message-ID: <Zb0eRogn3rjkeDAs@e133380.arm.com>
References: <20240201223545.728028-1-maskray@google.com>
 <Zb0Qu5lR0iZUqImb@e133380.arm.com>
 <CAMj1kXGSQ4Xq68Cmq6BH37FPJ+R+N5cOfrdC+aVML4sGaNDopg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGSQ4Xq68Cmq6BH37FPJ+R+N5cOfrdC+aVML4sGaNDopg@mail.gmail.com>

On Fri, Feb 02, 2024 at 05:32:33PM +0100, Ard Biesheuvel wrote:
> On Fri, 2 Feb 2024 at 16:56, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Thu, Feb 01, 2024 at 02:35:45PM -0800, Fangrui Song wrote:
> > > The generic constraint "i" seems to be copied from x86 or arm (and with
> > > a redundant generic operand modifier "c"). It works with -fno-PIE but
> > > not with -fPIE/-fPIC in GCC's aarch64 port.
> > >
> > > The machine constraint "S", which denotes a symbol or label reference
> > > with a constant offset, supports PIC and has been available in GCC since
> > > 2012 and in Clang since 7.0. However, Clang before 19 does not support
> > > "S" on a symbol with a constant offset [1] (e.g.
> > > `static_key_false(&nf_hooks_needed[pf][hook])` in
> > > include/linux/netfilter.h), so we use "i" as a fallback.
> > >
> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> > > Link: https://github.com/llvm/llvm-project/pull/80255 [1]
> > >
> > > ---
> > > Changes from
> > > arm64: jump_label: use constraint "S" instead of "i" (https://lore.kernel.org/all/20240131065322.1126831-1-maskray@google.com/)
> > >
> > > * Use "Si" as Ard suggested to support Clang<19
> > > * Make branch a separate operand
> > > ---
> > >  arch/arm64/include/asm/jump_label.h | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> > > index 48ddc0f45d22..1f7d529be608 100644
> > > --- a/arch/arm64/include/asm/jump_label.h
> > > +++ b/arch/arm64/include/asm/jump_label.h
> > > @@ -15,6 +15,10 @@
> > >
> > >  #define JUMP_LABEL_NOP_SIZE          AARCH64_INSN_SIZE
> > >
> > > +/*
> > > + * Prefer the constraint "S" to support PIC with GCC. Clang before 19 does not
> > > + * support "S" on a symbol with a constant offset, so we use "i" as a fallback.
> > > + */
> > >  static __always_inline bool arch_static_branch(struct static_key * const key,
> > >                                              const bool branch)
> > >  {
> > > @@ -23,9 +27,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> > >                "      .pushsection    __jump_table, \"aw\"    \n\t"
> > >                "      .align          3                       \n\t"
> > >                "      .long           1b - ., %l[l_yes] - .   \n\t"
> > > -              "      .quad           %c0 - .                 \n\t"
> > > +              "      .quad           %0 + %1 - .             \n\t"
> > >                "      .popsection                             \n\t"
> > > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> > > +              :  :  "Si"(key), "i"(branch) :  : l_yes);
> >
> > Is the meaning of multi-alternatives well defined if different arguments
> > specify different numbers of alternatives?  The GCC documentation says:
> >
> > https://gcc.gnu.org/onlinedocs/gcc/Multi-Alternative.html:
> >
> > -8<-
> >
> > [...] All operands for a single instruction must have the same number of
> > alternatives.
> >
> > ->8-
> >
> 
> AIUI that does not apply here. That reasons about multiple arguments
> having more than one constraint, where not all combinations of those
> constraints are supported by the instruction.

Ah, scratch that: I'm confusing multi-alternatives with simple
constraints: all arguments must have the same number of comma-separated
lists of constraint letters, but each list can contain as many or as few
letters as are needed to match the operand.

So "Si"(), "i"() is fine.

> > Also, I still think it may be redundant to move the addition inside the
> > asm, so long as Clang is happy with the symbol having an offset.
> >
> 
> Older Clang is not happy with the symbol having an offset.
> 
> And given that the key pointer and the 'branch' boolean are two
> distinct inputs to this function, I struggle to understand why you
> feel it is better to combine them in the argument. 'branch' is used to
> decide whether or not to set bit 0, independently of the value of key.
> Using array indexing to combine those values together to avoid an
> addition in the asm obfuscates the code.

This was more about not making changes that don't need to be made,
unless it clearly makes the code better.

But if some verions of Clang accept "S" but choke if there's an offset,
then moving the addition into the asm seems the way to go.

(I may have misread the commit message on this point.)

[...]

Cheers
---Dave

