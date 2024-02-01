Return-Path: <linux-kernel+bounces-48034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D84845685
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE9A1C27D95
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CF15F31A;
	Thu,  1 Feb 2024 11:50:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2AE15D5D3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788202; cv=none; b=Lx4ym7r1qpEEfOULFKEr4kdih76hweQu6UKB2eyCogu1CiBCFWmh2SMzzN1KB6D/z+SMGuWQioJAhXrIl2usX6mWwHzDAQ4e5oICQq1tMtMYaGXO2uhJi9sK6FSlhtFvbdLNvWxMEb5nryn9ovSmlgQUhjUaBjACmRt0wgY2vxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788202; c=relaxed/simple;
	bh=UDcCmXQ+BSKbQaXRsoN8CKZEU7dBrbNoaR8Ll50+DYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry3BCGMvToz/8O1/hcKcHEVhzarXzQtEXucx5ZjfH5git080lTNzxEf8ABfKUiZ+nneXYoLrsVA/LvCBytDu7lPlNrRZtQt8N/6ovRxatWXSd+Se6yrM2dBtqlDIL+SCQt/PPLvBsFTObet3ShtXF6/koHzqo6awSj3wxVKcnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B386DA7;
	Thu,  1 Feb 2024 03:50:41 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 472C63F762;
	Thu,  1 Feb 2024 03:49:57 -0800 (PST)
Date: Thu, 1 Feb 2024 11:49:45 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Fangrui Song <maskray@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Peter Smith <peter.smith@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
Message-ID: <ZbuFWSRBntgm2ukJ@e133380.arm.com>
References: <20240131065322.1126831-1-maskray@google.com>
 <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
 <ZbpEnDK3U/O24ng0@e133380.arm.com>
 <20240201045551.ajg4iqcajyowl2rh@google.com>
 <CAMj1kXEBjumu3VUySg1cQ+SYm4MugJ5f6pd1f7C0XrLyOWAoOw@mail.gmail.com>
 <20240201091120.pbgr7ng6t2c36fut@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201091120.pbgr7ng6t2c36fut@google.com>

On Thu, Feb 01, 2024 at 01:11:20AM -0800, Fangrui Song wrote:
> On 2024-02-01, Ard Biesheuvel wrote:
> > On Thu, 1 Feb 2024 at 05:55, Fangrui Song <maskray@google.com> wrote:
> > > 
> > > On 2024-01-31, Dave Martin wrote:
> > > >On Wed, Jan 31, 2024 at 08:16:04AM +0100, Ard Biesheuvel wrote:
> > > >> Hello Fangrui,
> > > >>
> > > >> On Wed, 31 Jan 2024 at 07:53, Fangrui Song <maskray@google.com> wrote:
> > > >> >
> > > >> > The constraint "i" seems to be copied from x86 (and with a redundant
> > > >> > modifier "c"). It works with -fno-PIE but not with -fPIE/-fPIC in GCC's
> > > >> > aarch64 port.
> > > >
> > > >(I'm not sure of the exact history, but the "c" may be inherited from
> > > >arm, where an output modifier was needed to suppress the "#" that
> > > >prefixes immediates in the traditional asm syntax.  This does not
> > > >actually seem to be required for AArch64: rather while a # is allowed
> > > >and still considered good style in handwritten asm code, the syntax
> > > >doesn't require it, and the compiler doesn't emit it for "i" arguments,
> > > >AFAICT.)
> > > 
> > > The aarch64 one could be inherited from
> > > arch/arm/include/asm/jump_label.h (2012), which could in turn be
> > > inherited from x86 (2010).
> > > Both the constraint "i" and the modifier "c" are generic..
> > > For -fno-pic this combination can be used for every arch.

Fair enough.  It wasn't clear to me that "c" was generic; the output
modifiers have always been a bit of a black art...

> > > 
> > > >> > The constraint "S", which denotes a symbol reference (e.g. function,
> > > >> > global variable) or label reference, is more appropriate, and has been
> > > >> > available in GCC since 2012 and in Clang since 7.0.
> > > >> >
> > > >> > Signed-off-by: Fangrui Song <maskray@google.com>
> > > >> > Link: https://maskray.me/blog/2024-01-30-raw-symbol-names-in-inline-assembly
> > > >> > ---
> > > >> >  arch/arm64/include/asm/jump_label.h | 8 ++++----
> > > >> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >> >
> > > >> > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> > > >> > index 48ddc0f45d22..31862b3bb33d 100644
> > > >> > --- a/arch/arm64/include/asm/jump_label.h
> > > >> > +++ b/arch/arm64/include/asm/jump_label.h
> > > >> > @@ -23,9 +23,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> > > >> >                  "      .pushsection    __jump_table, \"aw\"    \n\t"
> > > >> >                  "      .align          3                       \n\t"
> > > >> >                  "      .long           1b - ., %l[l_yes] - .   \n\t"
> > > >> > -                "      .quad           %c0 - .                 \n\t"
> > > >> > +                "      .quad           %0 - .                  \n\t"
> > > >> >                  "      .popsection                             \n\t"
> > > >> > -                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> > > >> > +                :  :  "S"(&((char *)key)[branch]) :  : l_yes);
> > > >>
> > > >> 'key' is not used as a raw symbol name. We should make this
> > > >>
> > > >> "    .quad   %0 + %1 - ."
> > > >>
> > > >> and
> > > >>
> > > >> ::  "S"(key), "i"(branch) :: l_yes);
> > > >>
> > > >> if we want to really clean this up.
> > > >
> > > >This hides more logic in the asm so it's arguably more cryptic
> > > >(although the code is fairly cryptic to begin with -- I don't really
> > > >see why the argument wasn't written as the equivalent
> > > >(char *)key + branch...)
> > > 
> > > I agree that using "S" and "i" would introduce complexity.
> > > Using just "S" as this patch does should be clear.
> > > 
> > > All of "i" "s" "S" support a symbol or label reference and a constant offset (can be zero),
> > > (in object file, a symbol and an addend; in GCC's term, the sum of a SYMBOL_REF and a CONST_INT).
> > > 
> > 
> > Taken the address of a struct, cast it to char[] and then index it
> > using a boolean is rather disgusting, no?
> 
> I agree with you.
> 
> Hmm. Clang's constraint "S" implementation doesn't support a constant
> offset, so
> `static_key_false(&nf_hooks_needed[pf][hook])` in include/linux/netfilter.h:nf_hook
> would not compile with Clang <= 18.
> 
> I have a patch https://github.com/llvm/llvm-project/pull/80255 , but
> even if it is accepted and cherry-picked into the 18.x release branch,
> if we still support older Clang, we cannot use "S" unconditionally.
> 
> 
> So we probably need the following to prepare for -fPIE support in the
> future:
> 
> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index 48ddc0f45d22..b8af2f8b0c99 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -15,6 +15,16 @@
>  #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
> +/*
> + * Prefer "S" to support PIC. However, use "i" for Clang 18 and earlier as "S"
> + * on a symbol with a constant offset is not supported.
> + */
> +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 18

Is a GCC version check needed?  Or is the minimum GCC version specified
for building the kernel new enough?

> +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
> +#else
> +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "S"
> +#endif
> +
>  static __always_inline bool arch_static_branch(struct static_key * const key,
>  					       const bool branch)
>  {
> @@ -23,9 +33,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
>  		 "	.pushsection	__jump_table, \"aw\"	\n\t"
>  		 "	.align		3			\n\t"
>  		 "	.long		1b - ., %l[l_yes] - .	\n\t"
> -		 "	.quad		%c0 - .			\n\t"
> +		 "	.quad		%0 + %1 - .		\n\t"
>  		 "	.popsection				\n\t"
> -		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +		 :  :  JUMP_LABEL_STATIC_KEY_CONSTRAINT(key), "i"(branch) :  : l_yes);

While this looks reasonable, I'm still not clear now why the asm must do
the addition.

Can we roll the branch argument into the macro?

"S"(symbol + constant) seems to do the right thing for AArch64, at least
in GCC.

>  	return false;
>  l_yes:
> @@ -40,9 +50,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
>  		 "	.pushsection	__jump_table, \"aw\"	\n\t"
>  		 "	.align		3			\n\t"
>  		 "	.long		1b - ., %l[l_yes] - .	\n\t"
> -		 "	.quad		%c0 - .			\n\t"
> +		 "	.quad		%0 + %1 - .		\n\t"
>  		 "	.popsection				\n\t"
> -		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +		 :  :  JUMP_LABEL_STATIC_KEY_CONSTRAINT(key), "i"(branch) :  : l_yes);
>  	return false;
>  l_yes:
> 
> 
> > > >Anyway, I don't think the "i" versys "S" distinction makes any
> > > >difference without -fpic or equivalent, so it is not really relevant
> > > >for the kernel (except that "S" breaks compatibility with older
> > > >compilers...)
> > > >
> > > >
> > > >I think the main advantage of "S" is that it stops you accidentally
> > > >emitting undesirable relocations from asm code that is not written for
> > > >the -fpic case.
> > > >
> > > >But just changing "i" to "S" is not sufficient to port asms to -fpic:
> > > >the asms still need to be reviewed.
> > > >
> > > >
> > > >So unless the asm has been reviewed for position-independence, it may
> > > >anyway be better to stick with "i" so that the compiler actually chokes
> > > >if someone tries to build the code with -fpic.
> > > 
> > 
> > The virtual address of the kernel is randomized by KASLR, which relies
> > on PIE linking, and this puts constraints on the permitted types of
> > relocations.
> > 
> > IOW, we basically already build the kernel as PIC code, but without
> > relying on -fPIC, because that triggers some behaviors that only make
> > sense for shared objects in user space.
> > 
> > > >Since we are not trying to run arbitraily many running kernels in a
> > > >common address space (and not likely to do that), I'm not sure that we
> > > >would ever build the kernel with -fpic except for a few special-case
> > > >bits like the EFI stub and vDSO... unless I've missed something?
> > > >
> > 
> > Yes, KASLR. The number of kernels is not the point, the point is that
> > the virtual load address of the kernel is usually decided at boot, and
> > so the code needs to be generated to accommodate that.
> > 
> > > >If there's another reason why "S" is advantageous though, I'm happy to
> > > >be corrected.
> > > 
> > > I remember that Ard has an RFC
> > > https://lore.kernel.org/linux-arm-kernel/20220427171241.2426592-1-ardb@kernel.org/
> > > "[RFC PATCH 0/2] arm64: use PIE code generation for KASLR kernel"
> > > and see some recent PIE codegen patches.
> > > 
> > > > Building the KASLR kernel without -fpie but linking it with -pie works
> > > > in practice, but it is not something that is explicitly supported by the
> > > > toolchains - it happens to work because the default 'small' code model
> > > > used by both GCC and Clang relies mostly on ADRP+ADD/LDR to generate
> > > > symbol references.

Does this mean that doing boot-time relocation on a fully statically
linked kernel doesn't bring much benefit?  It would tend to be more
painful to do the relocation work, and mean that the kernel text has to
be temporarily writeable, but static linking should have the best
runtime performance.

Maybe it doesn't make as much difference as I thought (certainly ADRP
based addressing should make a fair amount of the PIC/PIE overhead go
away).

> > > 
> > > I agree that current -fno-PIE with -shared -Bsymbolic linking is a hack
> > > that works as a conincidence, not guaranteed by the toolchain.
> > > This jump_label improvement (with no object file difference) fixes an
> > > obstacle.
> > 
> > If we can get the guaranteed behavior of #pragma GCC visibility
> > push(hidden) from a command line option, we should build the core
> > kernel with -fpie instead. (Modules are partially linked objects, so
> > they can be built non-PIC as before)
> > 
> I believe we don't have such a GCC option, but the effect can be
> simulated by -include hidden.h ...

[...]

Cheers
---Dave

