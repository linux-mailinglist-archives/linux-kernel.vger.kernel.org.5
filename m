Return-Path: <linux-kernel+bounces-50666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A35847C50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30391F2256A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D372485948;
	Fri,  2 Feb 2024 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kD9cpzr8"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077B8060E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912935; cv=none; b=aGMOy7VYlmqghyB4vP2hT/6Uj/CeQBMmpV6CB9w5iUl/DIgQtZGWJW2aKCPVHdCd/e3ZC2megtCHsXL0yQnoZzKen1cdu88Y5kkcfzJkvPuwspH62wrHMrs96JALo6B2cb/j8TaSj5flfN0zVmvE6/OsO0NfabTbKoufY3fVIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912935; c=relaxed/simple;
	bh=vXGV+JUCW4UDUfsvzgaa+t9jS+Kgu7J2IVAtVmwcpkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqTDAxdqiL0A9qfen8XD3fuLB2rBwMYVv5qyKiCn1PhZRUy6IJy0aex0FYKyY+ErdgBvGv4MLoKoauHr0kWewyIhG1kM3RaJWevK8UWLbk6VJ8g/iFyfwJdAPwWS2cWro5IXgBZXjfqCP5/lsVK8REIHV8ACez41GbwtAulZZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kD9cpzr8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d94691de1eso14005ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706912933; x=1707517733; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=35zdsNwfJgFY/ZMxIZy2EOHYoYPvVEP+5OEq4ReBy2Q=;
        b=kD9cpzr8JjsEqG5L4liwdxvePHCbdiJB6ba+hMGNdfL+YUNqYKGnlktCCXfMo1fA3E
         sCfDlkrkZZa91nEcb/owXtchJ9nd2++K57GPF6gb3bF5AFsEnrUzwgxjb7DFUKKZdkI3
         KlHw0FYFmPnAQM39xQTYzhS3dwbrOIVN6N9mMPSmG2iKMztPCeDVkZYK8jDZEKqlYeS6
         jEFUMGpmNRhVJkBTlVf2kh+dgTvl3jyy+3SWehFw27SoId+ux+byws9vXOPzrkSrGpGc
         g/a9PykS+71mXBU382n5HWjcTPtHIu4508R+cVmYCw2nzhyDqPSTSedgQiSC8Cu2M4u3
         BfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706912933; x=1707517733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35zdsNwfJgFY/ZMxIZy2EOHYoYPvVEP+5OEq4ReBy2Q=;
        b=Ls40elLzaHmclwG0mklV4/CouGnGHFI036JvFFBcU7Dh6+xNP7CS78hhsl7r0Srx1O
         6RH3KylqKB7PUv/jrVF+6RQitIwqMzim1t0+C+CmAiQfeHmtr20AMNPaVE6tuwMhdP+e
         apxt7aJD/6BpWdfgyA0CJ1oO9x88DBjh92C+0hOLV2I9G3e1YKLlcOuvtgTKySIhcLVR
         0vLEmi1kq2RIb8bXOE2U6mFRgAm0V1aoscWbXAOauPKjOf/AllMtRtO9ZnMaw3URQHEE
         X55mwuQ6Lcsg0hiFAs6XTpBNhOIWiGTEBzei3hnnOr/gtZFnsgWs1vVjMvg2RGJNVmjE
         y3ww==
X-Gm-Message-State: AOJu0YyuL9sQH9XyWyPFcsHTD6pIs0BIrZLScegdHXZ79/jN+BUyPOnW
	jsfbVSoIFawvyG+rimxTRETZCB2ra+nj6HGg+s10KlEqhQnNAw0KZhVJljqCJQ==
X-Google-Smtp-Source: AGHT+IEEKe6mr/c7tkb0F2PDDmunMMn8DDDJANYhb9t5JAZ+LyimkW9ASQjQ4+GJug7OZE66cU5Evg==
X-Received: by 2002:a17:902:c442:b0:1d5:ed04:4d0e with SMTP id m2-20020a170902c44200b001d5ed044d0emr35976plm.24.1706912932806;
        Fri, 02 Feb 2024 14:28:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXpAfxZO6sKaZfn1vjW91mjVKbdjwQ4Hi/E5cY5eWp3YJ26i8GdGIyMUH5m2/8+ADS05GlSSBLf4EMtRvr46gZe3x1PvX1uuicSMWcXSlR6Rq+y1kqUOU2sfzRwP70GXD1jb7FEwH1ijg6MgbWaCE+HMA/t2d02YWnovTeSKpr0I7leOhbu5zxpNdkWSGcldIiwtpB4Qlt26WEH2QD+Br1mrBYeBWzmvL0BXlXS3MUVk0yfQKjicN/0wXwB8d/ShUYanQ2G/vR1Pv7gFoYrQ5+upKJJbNM+bI0VQXM=
Received: from google.com ([2620:15c:2d3:205:7de7:721a:241f:7455])
        by smtp.gmail.com with ESMTPSA id f11-20020a056a001acb00b006e025ce0beesm316099pfv.168.2024.02.02.14.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:28:52 -0800 (PST)
Date: Fri, 2 Feb 2024 14:28:48 -0800
From: Fangrui Song <maskray@google.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Peter Smith <peter.smith@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
Message-ID: <20240202222848.udc6tisjwjtb3gso@google.com>
References: <20240201045551.ajg4iqcajyowl2rh@google.com>
 <CAMj1kXEBjumu3VUySg1cQ+SYm4MugJ5f6pd1f7C0XrLyOWAoOw@mail.gmail.com>
 <20240201091120.pbgr7ng6t2c36fut@google.com>
 <ZbuFWSRBntgm2ukJ@e133380.arm.com>
 <CAMj1kXGu76WHY8=Y-KhCxBq3xeHeCYQ9syqViSr9VRkjgWQ3BQ@mail.gmail.com>
 <ZbvVApJ2/+yca0u6@e133380.arm.com>
 <20240201205614.w3gcz6urfxtydr77@google.com>
 <CAMj1kXGAi94DuCYRPWQujGz7YVTS=53h_+FretCsYFbxznJVHw@mail.gmail.com>
 <CAFP8O3JB1miCHoGFh7UY6dCa4WS6+88mnB_qxXnvYp4wHnYgBw@mail.gmail.com>
 <Zb0NfWQAHth9GrpK@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zb0NfWQAHth9GrpK@e133380.arm.com>

On 2024-02-02, Dave Martin wrote:
>On Thu, Feb 01, 2024 at 02:12:06PM -0800, Fangrui Song wrote:
>> On Thu, Feb 1, 2024 at 1:23 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> >
>> > On Thu, 1 Feb 2024 at 21:56, Fangrui Song <maskray@google.com> wrote:
>> > >
>> > > On 2024-02-01, Dave Martin wrote:
>> > > >On Thu, Feb 01, 2024 at 05:07:59PM +0100, Ard Biesheuvel wrote:
>> > > >> On Thu, 1 Feb 2024 at 12:50, Dave Martin <Dave.Martin@arm.com> wrote:
>> > > >> >
>> > > >> > On Thu, Feb 01, 2024 at 01:11:20AM -0800, Fangrui Song wrote:
>
>[...]
>
>> > > >> > Is a GCC version check needed?  Or is the minimum GCC version specified
>> > > >> > for building the kernel new enough?
>> > > >> >
>> > > >> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
>> > > >> > > +#else
>> > > >> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "S"
>> > > >> > > +#endif
>> > > >> > > +
>> > > >>
>> > > >> Can we use "Si" instead?
>> > > >
>> > > >I thought the point was to avoid "S" on compilers that would choke on
>> > > >it?  If so, those compilers would surely choke on "Si" too, no?
>> > >
>> > > "Si" is an invalid constraint. Unfortunately, GCC recognizes "S" as a
>> > > valid constraint and ignores trailing characters (asm_operand_ok). That
>> > > is, GCC would accept "Siiiii" as well...
>> > >
>> > > The GCC support for "S" is great. The initial aarch64 port in 2012 supports "S".
>
>Ah, no problem.
>
>
>> > So it is not possible to combine the S and i constraint, and let the
>> > compiler figure out whether it meets either? We rely on this elsewhere
>> > by combining r and Z into rZ. x86 uses "rm" for inline asm parameters
>> > that could be either register or memory operands.
>>
>> I did not realize that your "Si" suggestion meant this feature
>> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
>>
>>     After the prefix, there must be one or more additional constraints
>> (see Constraints for asm Operands) that describe where the value
>> resides. Common constraints include ‘r’ for register and ‘m’ for
>> memory. When you list more than one possible location (for example,
>> "=rm"), the compiler chooses the most efficient one based on the
>> current context.
>>
>> After some debugging of both GCC and Clang, I think you are right and
>> "Si" will work. Thanks for the suggestion!
>>
>> GCC accepts "Si". Sorry for my incorrectly stating that GCC ignores
>> the trailing constraint. GCC does ignore an unknown constraint, as
>> long as one accepted constraint.
>>
>> Clang accepts "Si" as well. In the absence of
>> https://github.com/llvm/llvm-project/pull/80255 (constant offset
>> support for 'S'), in TargetLowering::ComputeConstraintToUse, 'S' is
>> skipped and 'i' will be picked. This is unrelated to the "rm" weakness
>> in Clang (https://github.com/llvm/llvm-project/issues/20571).
>>
>> I'll post a PATCH v2 removing JUMP_LABEL_STATIC_KEY_CONSTRAINT and
>> using "Si" unconditionally.
>
>If older Clang just ignores the "S" in "Si" as an unsatisfiable
>alternative and falls back on "i", that seems ideal.
>
>> > > >> > >  static __always_inline bool arch_static_branch(struct static_key * const key,
>> > > >> > >                                              const bool branch)
>> > > >> > >  {
>> > > >> > > @@ -23,9 +33,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
>> > > >> > >                "      .pushsection    __jump_table, \"aw\"    \n\t"
>> > > >> > >                "      .align          3                       \n\t"
>> > > >> > >                "      .long           1b - ., %l[l_yes] - .   \n\t"
>> > > >> > > -              "      .quad           %c0 - .                 \n\t"
>> > > >> > > +              "      .quad           %0 + %1 - .             \n\t"
>> > > >> > >                "      .popsection                             \n\t"
>> > > >> > > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
>> > > >> > > +              :  :  JUMP_LABEL_STATIC_KEY_CONSTRAINT(key), "i"(branch) :  : l_yes);
>
>[...]
>
>> > > >"S"(&((char *)key)[branch]) does indeed seem to do the right thing,
>> > > >at least with GCC.
>> > > >
>> > > >I probably didn't help by bikeshedding the way that expression was
>> > > >written, apologies for that.  It's orthogonal to what this patch is
>> > > >doing.
>> > >
>> > > Yes, "S"(&((char *)key)[branch])  would do the right thing.
>> > > I have compared assembly output. It's a matter of "s" vs "s + 0" and "s+1" vs "s + 1".
>
>[...]
>
>> > > >Is there a reason why we don't just build the whole kernel with
>> > > >-fvisibility=hidden today?
>> > >
>> > > This topic, loosely related to this patch, is about switching to PIC
>> > > compiles. I am not familiar with the Linux kernel, so I'll mostly leave
>> > > the discussion to you and Ard :)
>> > >
>> > > That said, I have done a lot of Clang work in visibility/symbol
>> > > preemptibility and linkers, so I am happy to add what I know.
>> > >
>> > > -fvisibility=hidden only applies to definitions, not non-definition
>> > > declarations.
>> > >
>> > > I've mentioned this at
>> > > https://lore.kernel.org/all/20220429070318.iwj3j5lpfkw4t7g2@google.com/
>> > >
>> > >      `#pragma GCC visibility push(hidden)` is very similar to -fvisibility=hidden -fdirect-access-external-data with Clang.
>> > >      ...
>> > >      The kernel uses neither TLS nor -fno-plt, so -fvisibility=hidden
>> > >      -fdirect-access-external-data can replace `#pragma GCC visibility
>> > >      push(hidden)`.
>> > >
>> > > >> So building with -fPIC is currently not need in practice, and creates
>> > > >> some complications, which is why we have been avoiding it. But PIE
>> > > >> linking non-PIC objects is not guaranteed to remain supported going
>> > > >> forward, so it would be better to have a plan B, i.e., being able to
>> > > >> turn on -fpic without massive regressions due to GOT overhead, or
>> > > >> codegen problems with our asm hacks.
>> > > >
>> > > >Summarising all of this is it right that:
>> > > >
>> > > >1) ld -pie is how we get the reloc info into the kernel for KASLR
>> > > >today.
>> > > >
>> > > >2) We use gcc -fno-pic today, but this might break with ld -pie in the
>> > > >future, although it works for now.
>> > > >
>> > > >3) gcc -fno-pic and gcc -fPIC (or -fPIE) generate almost the same code,
>> > > >assuming we tweak symbol visibility and use a memory model that
>> > > >ADR+ADD/LDR can span.  So, moving to -fPIE is likely to be do-able.
>> > > >
>> > > >
>> > > >My point is that an alternative option would be to move to ld -no-pie.
>> >
>> > Why? What would that achieve?
>> >
>> > > >We would need another way to get relocs into the kernel, such as an
>> > > >intermediate step with ld --emit-relocs.  I have definitely seen this
>> > > >done before somewhere, but it would be extra work and not necessarily
>> > > >worth it, based on what you say about code gen.
>> >
>> > Relying on --emit-relocs is a terrible hack. It contains mostly
>> > relocations that we don't need at runtime, so we need to postprocess
>> > them. And linkers may not update these relocations in some cases after
>> > relaxation or other transformations (and sometimes, it is not even
>> > possible to do so, if the post-transformation situation cannot be
>> > described by a relocation).
>>
>> Agreed. I've filed
>> https://sourceware.org/bugzilla/show_bug.cgi?id=30844
>> ("ld riscv: --emit-relocs does not retain the original relocation
>> type") for a RISC-V version.
>>
>> --emit-relocs is under-specified and the linker behaviors are less tested.
>
>(Aside: This sounds like an interesting hole in the toolchain world.
>
>I guess if you want post-link-time relocatability, it sounds like all
>the focus from the compiler folks is on PIC code, and non-PIC linker
>output is not considered relocatable at all (baremetal software being an
>inconvenient truth).
>
>"Relocatable" and "PIC" are not really the same requirement, but the
>importance of the difference is arch-dependent, and I can see how we got
>here.  End aside.)

My background is about toolchains and I know very little about the
kernel.  When I saw CONFIG_RELOCATABLE the first time, I was (and am)
quite confused by term (I was thinking of relocatable linking).  I
believe CONFIG_RELOCATABLE in the kernel context does mean
position-independence.

>> > And with Fangrui's RELR optimization, the PIE relocation data is
>> > extremely dense.
>> >
>> > There is nothing to fix here, really.
>> >
>> > > >
>> > > >This may all have been discussed to death already -- I didn't mean to
>> > > >hijack this patch, so I'll stop digging here, but if I've misunderstood,
>> > > >please shout!
>> >
>> > No worries. Ramana and I spent some time 5+ years ago to document how
>> > PIC codegen for the kernel (or any freestanding executable, really)
>> > deviates from the typical PIC codegen for shared libraries and PIE
>> > executables, with the intention of adding a GCC compiler switch for
>> > it, but that never really materialized, mostly because things just
>> > work fine today.
>> >
>
>Right.  I was concerned that we would pay a significant runtime
>performance penalty when migrating to -fPIC, in which case it would be
>worth considering alernatives.  But from the discussion it sounds like
>this concern is misguided (or at least, you have found robust
>workarounds which mean that the real penalty is negligible).
>
>There's no underlying reason why a toolchain couldn't emit full static
>relocation information in a robust way, but since this info is hard to
>consume and would be used rarely and only for very specific use cases I
>can see why this support is rot-prone or even not considered a goal
>at all by many people...
>
>Cheers
>---Dave

I believe the PIC concept is built around dynamic shared library support
in 1980+, and therefore PIC and dynamic shared library are reall
tangled. Here are some notes from my archaeology
https://maskray.me/blog/2021-09-19-all-about-procedure-linkage-table#appendix

     In 1984 USENIX UniForum Conference Proceedings, Transparent
     Implementation of Shared Libraries described a library stub and link
     table scheme which is similar to .plt plus .got.plt used today.
   
     System V release 3 switched to the COFF format. In 1986 Summer USENIX
     Technical Conference & Exhibition Proceedings, Shared Libraries on
     UNIX System V from AT&T described a shared library design. Its shared
     library must have a fixed virtual address, which is called "static
     shared library" in Linkers and Loaders's term.
   
     In 1988, SunOS 4.0 was released with an extended a.out binary format
     with dynamic shared library support. Unlike previous static shared
     library schemes, the a.out shared libraries are position independent
     and can be loaded at different addresses. The GOT and PLT schemes are
     what we see today. In 1992, SunOS 5.0 (Solaris 2.0) switched to ELF.

Concepts like PLT and GOT have been ingrained in the design.  Therefore,
-fPIC compiles lead to PLT-generating and GOT-generating code by
default. Kernels, for security hardening, just need the "relocatable"
capability, not the dynamic library part, would find such code
inefficient.

The 1990+ introduction of ELF visibilities allows eliminating GOT/PLT,
if you use the hidden visibility. It is just not the toolchain defaults
and kernel folks would find themselves have to jump through hoops.

In addition, visibility-related options, if not used very carefully, can
easily shoot yourself in the foot. So there could be some tension
whether toolchain folks want to add extra options.

