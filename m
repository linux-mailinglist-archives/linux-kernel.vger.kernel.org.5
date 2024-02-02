Return-Path: <linux-kernel+bounces-50044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B8E847397
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3647282240
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3E1474B1;
	Fri,  2 Feb 2024 15:43:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2391474AD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888580; cv=none; b=uK84KI7qkaTHd/g/M4QgGS9UDTqQE0S+XiFv9WoDGQQ7BRQtsSnxf71LcvqSt4HYqDaM1svwEU9h4012vutI6Tl7TCNo4ObFzqZwu3USWhvr3X5lsEIdYRdmrjNJyTgE4sGKGSjLpdDxswGDeQ7DPlV08hWnXlb3MdSvoBMo/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888580; c=relaxed/simple;
	bh=79CFL/zGKAFjdFoK3I1M9YjoHLz4SW+2czuA7cDsQ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isj+buXI2xzyQKaci/Lwuqx4k2b3To+S/7R27hMWMVDyDIgJyiCkUhYNrpVTyFagKyWIEbvMh+5uAHjFGKVBwLiiUfSgZA+Ejly8Jlm8JPBAiGUkQ4CrilWmM76BaDsLXL1hsSzRLh8fI2AQUSYJpZ10Mj3e+eHwhcq9KxenNis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D271DA7;
	Fri,  2 Feb 2024 07:43:39 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE9AB3F5A1;
	Fri,  2 Feb 2024 07:42:55 -0800 (PST)
Date: Fri, 2 Feb 2024 15:42:53 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Fangrui Song <maskray@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Peter Smith <peter.smith@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
Message-ID: <Zb0NfWQAHth9GrpK@e133380.arm.com>
References: <ZbpEnDK3U/O24ng0@e133380.arm.com>
 <20240201045551.ajg4iqcajyowl2rh@google.com>
 <CAMj1kXEBjumu3VUySg1cQ+SYm4MugJ5f6pd1f7C0XrLyOWAoOw@mail.gmail.com>
 <20240201091120.pbgr7ng6t2c36fut@google.com>
 <ZbuFWSRBntgm2ukJ@e133380.arm.com>
 <CAMj1kXGu76WHY8=Y-KhCxBq3xeHeCYQ9syqViSr9VRkjgWQ3BQ@mail.gmail.com>
 <ZbvVApJ2/+yca0u6@e133380.arm.com>
 <20240201205614.w3gcz6urfxtydr77@google.com>
 <CAMj1kXGAi94DuCYRPWQujGz7YVTS=53h_+FretCsYFbxznJVHw@mail.gmail.com>
 <CAFP8O3JB1miCHoGFh7UY6dCa4WS6+88mnB_qxXnvYp4wHnYgBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3JB1miCHoGFh7UY6dCa4WS6+88mnB_qxXnvYp4wHnYgBw@mail.gmail.com>

On Thu, Feb 01, 2024 at 02:12:06PM -0800, Fangrui Song wrote:
> On Thu, Feb 1, 2024 at 1:23 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 1 Feb 2024 at 21:56, Fangrui Song <maskray@google.com> wrote:
> > >
> > > On 2024-02-01, Dave Martin wrote:
> > > >On Thu, Feb 01, 2024 at 05:07:59PM +0100, Ard Biesheuvel wrote:
> > > >> On Thu, 1 Feb 2024 at 12:50, Dave Martin <Dave.Martin@arm.com> wrote:
> > > >> >
> > > >> > On Thu, Feb 01, 2024 at 01:11:20AM -0800, Fangrui Song wrote:

[...]

> > > >> > Is a GCC version check needed?  Or is the minimum GCC version specified
> > > >> > for building the kernel new enough?
> > > >> >
> > > >> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
> > > >> > > +#else
> > > >> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "S"
> > > >> > > +#endif
> > > >> > > +
> > > >>
> > > >> Can we use "Si" instead?
> > > >
> > > >I thought the point was to avoid "S" on compilers that would choke on
> > > >it?  If so, those compilers would surely choke on "Si" too, no?
> > >
> > > "Si" is an invalid constraint. Unfortunately, GCC recognizes "S" as a
> > > valid constraint and ignores trailing characters (asm_operand_ok). That
> > > is, GCC would accept "Siiiii" as well...
> > >
> > > The GCC support for "S" is great. The initial aarch64 port in 2012 supports "S".

Ah, no problem.


> > So it is not possible to combine the S and i constraint, and let the
> > compiler figure out whether it meets either? We rely on this elsewhere
> > by combining r and Z into rZ. x86 uses "rm" for inline asm parameters
> > that could be either register or memory operands.
> 
> I did not realize that your "Si" suggestion meant this feature
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
> 
>     After the prefix, there must be one or more additional constraints
> (see Constraints for asm Operands) that describe where the value
> resides. Common constraints include ‘r’ for register and ‘m’ for
> memory. When you list more than one possible location (for example,
> "=rm"), the compiler chooses the most efficient one based on the
> current context.
> 
> After some debugging of both GCC and Clang, I think you are right and
> "Si" will work. Thanks for the suggestion!
> 
> GCC accepts "Si". Sorry for my incorrectly stating that GCC ignores
> the trailing constraint. GCC does ignore an unknown constraint, as
> long as one accepted constraint.
> 
> Clang accepts "Si" as well. In the absence of
> https://github.com/llvm/llvm-project/pull/80255 (constant offset
> support for 'S'), in TargetLowering::ComputeConstraintToUse, 'S' is
> skipped and 'i' will be picked. This is unrelated to the "rm" weakness
> in Clang (https://github.com/llvm/llvm-project/issues/20571).
> 
> I'll post a PATCH v2 removing JUMP_LABEL_STATIC_KEY_CONSTRAINT and
> using "Si" unconditionally.

If older Clang just ignores the "S" in "Si" as an unsatisfiable
alternative and falls back on "i", that seems ideal.

> > > >> > >  static __always_inline bool arch_static_branch(struct static_key * const key,
> > > >> > >                                              const bool branch)
> > > >> > >  {
> > > >> > > @@ -23,9 +33,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> > > >> > >                "      .pushsection    __jump_table, \"aw\"    \n\t"
> > > >> > >                "      .align          3                       \n\t"
> > > >> > >                "      .long           1b - ., %l[l_yes] - .   \n\t"
> > > >> > > -              "      .quad           %c0 - .                 \n\t"
> > > >> > > +              "      .quad           %0 + %1 - .             \n\t"
> > > >> > >                "      .popsection                             \n\t"
> > > >> > > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> > > >> > > +              :  :  JUMP_LABEL_STATIC_KEY_CONSTRAINT(key), "i"(branch) :  : l_yes);

[...]

> > > >"S"(&((char *)key)[branch]) does indeed seem to do the right thing,
> > > >at least with GCC.
> > > >
> > > >I probably didn't help by bikeshedding the way that expression was
> > > >written, apologies for that.  It's orthogonal to what this patch is
> > > >doing.
> > >
> > > Yes, "S"(&((char *)key)[branch])  would do the right thing.
> > > I have compared assembly output. It's a matter of "s" vs "s + 0" and "s+1" vs "s + 1".

[...]

> > > >Is there a reason why we don't just build the whole kernel with
> > > >-fvisibility=hidden today?
> > >
> > > This topic, loosely related to this patch, is about switching to PIC
> > > compiles. I am not familiar with the Linux kernel, so I'll mostly leave
> > > the discussion to you and Ard :)
> > >
> > > That said, I have done a lot of Clang work in visibility/symbol
> > > preemptibility and linkers, so I am happy to add what I know.
> > >
> > > -fvisibility=hidden only applies to definitions, not non-definition
> > > declarations.
> > >
> > > I've mentioned this at
> > > https://lore.kernel.org/all/20220429070318.iwj3j5lpfkw4t7g2@google.com/
> > >
> > >      `#pragma GCC visibility push(hidden)` is very similar to -fvisibility=hidden -fdirect-access-external-data with Clang.
> > >      ...
> > >      The kernel uses neither TLS nor -fno-plt, so -fvisibility=hidden
> > >      -fdirect-access-external-data can replace `#pragma GCC visibility
> > >      push(hidden)`.
> > >
> > > >> So building with -fPIC is currently not need in practice, and creates
> > > >> some complications, which is why we have been avoiding it. But PIE
> > > >> linking non-PIC objects is not guaranteed to remain supported going
> > > >> forward, so it would be better to have a plan B, i.e., being able to
> > > >> turn on -fpic without massive regressions due to GOT overhead, or
> > > >> codegen problems with our asm hacks.
> > > >
> > > >Summarising all of this is it right that:
> > > >
> > > >1) ld -pie is how we get the reloc info into the kernel for KASLR
> > > >today.
> > > >
> > > >2) We use gcc -fno-pic today, but this might break with ld -pie in the
> > > >future, although it works for now.
> > > >
> > > >3) gcc -fno-pic and gcc -fPIC (or -fPIE) generate almost the same code,
> > > >assuming we tweak symbol visibility and use a memory model that
> > > >ADR+ADD/LDR can span.  So, moving to -fPIE is likely to be do-able.
> > > >
> > > >
> > > >My point is that an alternative option would be to move to ld -no-pie.
> >
> > Why? What would that achieve?
> >
> > > >We would need another way to get relocs into the kernel, such as an
> > > >intermediate step with ld --emit-relocs.  I have definitely seen this
> > > >done before somewhere, but it would be extra work and not necessarily
> > > >worth it, based on what you say about code gen.
> >
> > Relying on --emit-relocs is a terrible hack. It contains mostly
> > relocations that we don't need at runtime, so we need to postprocess
> > them. And linkers may not update these relocations in some cases after
> > relaxation or other transformations (and sometimes, it is not even
> > possible to do so, if the post-transformation situation cannot be
> > described by a relocation).
>
> Agreed. I've filed
> https://sourceware.org/bugzilla/show_bug.cgi?id=30844
> ("ld riscv: --emit-relocs does not retain the original relocation
> type") for a RISC-V version.
> 
> --emit-relocs is under-specified and the linker behaviors are less tested.

(Aside: This sounds like an interesting hole in the toolchain world.

I guess if you want post-link-time relocatability, it sounds like all
the focus from the compiler folks is on PIC code, and non-PIC linker
output is not considered relocatable at all (baremetal software being an
inconvenient truth).

"Relocatable" and "PIC" are not really the same requirement, but the
importance of the difference is arch-dependent, and I can see how we got
here.  End aside.)

> > And with Fangrui's RELR optimization, the PIE relocation data is
> > extremely dense.
> >
> > There is nothing to fix here, really.
> >
> > > >
> > > >This may all have been discussed to death already -- I didn't mean to
> > > >hijack this patch, so I'll stop digging here, but if I've misunderstood,
> > > >please shout!
> >
> > No worries. Ramana and I spent some time 5+ years ago to document how
> > PIC codegen for the kernel (or any freestanding executable, really)
> > deviates from the typical PIC codegen for shared libraries and PIE
> > executables, with the intention of adding a GCC compiler switch for
> > it, but that never really materialized, mostly because things just
> > work fine today.
> >

Right.  I was concerned that we would pay a significant runtime
performance penalty when migrating to -fPIC, in which case it would be
worth considering alernatives.  But from the discussion it sounds like
this concern is misguided (or at least, you have found robust
workarounds which mean that the real penalty is negligible).

There's no underlying reason why a toolchain couldn't emit full static
relocation information in a robust way, but since this info is hard to
consume and would be used rarely and only for very specific use cases I
can see why this support is rot-prone or even not considered a goal
at all by many people...

Cheers
---Dave

