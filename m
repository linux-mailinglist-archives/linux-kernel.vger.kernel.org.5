Return-Path: <linux-kernel+bounces-48928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959B7846349
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5431F25F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3946405DC;
	Thu,  1 Feb 2024 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMJ07Zfy"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3413FB32
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825544; cv=none; b=fGHORMMMAH0LilsgFpCTzFa2cM3yQWp9jlP/jDNO8Hp/ve2+WSH3Ko+WOQO9LQOX+RwjAnUyOhvpmClJYYPTVpWfJSH0Db2GSkntx8dxbrndxaOZz3Lrhac+ecblKVAWu4w+rTDQSiZzKSV8ZTAsCRXS9pMJoWwoEeKpV/GfzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825544; c=relaxed/simple;
	bh=LAkeF+xHALpQzwXg53S7wPQRYzjO79MKhHDU4Omchc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4MYNk8ayUV3OLGpsoZFEHVBKSGr3YYXe0seTTnM9LX6/MeHTfXuTOPmXDxc31r8sgzs5tST3lhIBrGNSlrxbS7aPfk/HWVk/OCc/S6CjW8X2+WHYQmvnL0pivBASAVUVVl5Ao/T/Hj80EsT75Ch0O65S+zoOMAWla3Io3uWLFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMJ07Zfy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f85a2a43fso1570a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706825541; x=1707430341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnPRHByz4SFdZkLFlqjyHkptspP4aisHAYbyUl/8Bw8=;
        b=iMJ07ZfyKlxupGGMKFY2e7JMhdOrV0GkXSqS+oXJSSkJ/+ESnC4qCDgO7YHJMQjwkJ
         MaGyZS2Pj29duUUxfETARaj6Usg35ZIo8Jwksn7MITcMQxGTCT6/Ak3CGlaE7fqLkKKv
         6YMi+fKtw6tedBRMGGM8osQEmuGzhlfSO0hLa+ZSjaGc4pB2EZmyXqbs3UdpvcGsBgzw
         scWvtRynTmKpyHTWdl8PhMej4pZOXc7JTYBOzph7gC+PIwjr4NSOiQTEMiVCD29klDVk
         JKfGqwO43Yvz6TodBni4lKzqYjFTr+easq8ODLHDfEEyQzUzORP4CUwnU9wKERZhsQgE
         ITpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706825541; x=1707430341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnPRHByz4SFdZkLFlqjyHkptspP4aisHAYbyUl/8Bw8=;
        b=dIf3u+RXtG8Z3cXG/mkimMASUoEnT+wX7uiyTNI5tg5DBBB6iqls1ldQiFqxl72H2/
         Vw4PhikYW3ZW8EwIMGg6WVS6Uo2Kw8DhIRx3pQhRZRTpqGO03P/JxvXaVIgBvC34Ir72
         gxB5bvtASf4LNl7/3mACMOrorSR1TkDR131q9/PctqCcQnbFI6T+CILgN70oBuSmv5az
         UNnPAnz6QWcfZpQ4QhX1HyveFpbTmSRSIGBA3AdzSw4oEgLF/vwGvlqKeWypJ3Xiaf6s
         nUShbifquDjovvuw2lp+Cr0XhFGPYs0fe0KSxlbjf8coVfT/9ful2YVOJvgKIPinzgtE
         oHcw==
X-Gm-Message-State: AOJu0Yws2+xj+iib6rPUGRqJzVJ1zj5RnBWTh38uZzkmI6umH8kNr0bp
	jDhawKFBlV/JKr62RhEtdfN23phejgo5oiuPzCtfolNpr3HymPh8ySQVz3lSOPn3ivbRk/qvkfB
	X7cy2t6Jj3NYogtgekkJQwrvk6tSVGScvJ8T7
X-Google-Smtp-Source: AGHT+IF5Xi/sGcww69h/6yAjmDlefXfSx5f4w7DARZI+TLj3JcyGUcaXfRoyYWf59GFVpdorKPaWzFRUWT0zK+f9PrU=
X-Received: by 2002:a50:d559:0:b0:55f:b5a3:e2b4 with SMTP id
 f25-20020a50d559000000b0055fb5a3e2b4mr29273edj.7.1706825540437; Thu, 01 Feb
 2024 14:12:20 -0800 (PST)
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
 <CAMj1kXGu76WHY8=Y-KhCxBq3xeHeCYQ9syqViSr9VRkjgWQ3BQ@mail.gmail.com>
 <ZbvVApJ2/+yca0u6@e133380.arm.com> <20240201205614.w3gcz6urfxtydr77@google.com>
 <CAMj1kXGAi94DuCYRPWQujGz7YVTS=53h_+FretCsYFbxznJVHw@mail.gmail.com>
In-Reply-To: <CAMj1kXGAi94DuCYRPWQujGz7YVTS=53h_+FretCsYFbxznJVHw@mail.gmail.com>
From: Fangrui Song <maskray@google.com>
Date: Thu, 1 Feb 2024 14:12:06 -0800
Message-ID: <CAFP8O3JB1miCHoGFh7UY6dCa4WS6+88mnB_qxXnvYp4wHnYgBw@mail.gmail.com>
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Peter Smith <peter.smith@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:23=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Thu, 1 Feb 2024 at 21:56, Fangrui Song <maskray@google.com> wrote:
> >
> > On 2024-02-01, Dave Martin wrote:
> > >On Thu, Feb 01, 2024 at 05:07:59PM +0100, Ard Biesheuvel wrote:
> > >> On Thu, 1 Feb 2024 at 12:50, Dave Martin <Dave.Martin@arm.com> wrote=
:
> > >> >
> > >> > On Thu, Feb 01, 2024 at 01:11:20AM -0800, Fangrui Song wrote:
> > >> ...
> > >> > >
> > >> > > Hmm. Clang's constraint "S" implementation doesn't support a con=
stant
> > >> > > offset, so
> > >> > > `static_key_false(&nf_hooks_needed[pf][hook])` in include/linux/=
netfilter.h:nf_hook
> > >> > > would not compile with Clang <=3D 18.
> > >> > >
> > >> > > I have a patch https://github.com/llvm/llvm-project/pull/80255 ,=
 but
> > >> > > even if it is accepted and cherry-picked into the 18.x release b=
ranch,
> > >> > > if we still support older Clang, we cannot use "S" unconditional=
ly.
> > >> > >
> > >> > >
> > >> > > So we probably need the following to prepare for -fPIE support i=
n the
> > >> > > future:
> > >> > >
> > >> > > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/in=
clude/asm/jump_label.h
> > >> > > index 48ddc0f45d22..b8af2f8b0c99 100644
> > >> > > --- a/arch/arm64/include/asm/jump_label.h
> > >> > > +++ b/arch/arm64/include/asm/jump_label.h
> > >> > > @@ -15,6 +15,16 @@
> > >> > >  #define JUMP_LABEL_NOP_SIZE          AARCH64_INSN_SIZE
> > >> > > +/*
> > >> > > + * Prefer "S" to support PIC. However, use "i" for Clang 18 and=
 earlier as "S"
> > >> > > + * on a symbol with a constant offset is not supported.
> > >> > > + */
> > >> > > +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <=3D 18
> > >> >
> > >> > Is a GCC version check needed?  Or is the minimum GCC version spec=
ified
> > >> > for building the kernel new enough?
> > >> >
> > >> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
> > >> > > +#else
> > >> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "S"
> > >> > > +#endif
> > >> > > +
> > >>
> > >> Can we use "Si" instead?
> > >
> > >I thought the point was to avoid "S" on compilers that would choke on
> > >it?  If so, those compilers would surely choke on "Si" too, no?
> >
> > "Si" is an invalid constraint. Unfortunately, GCC recognizes "S" as a
> > valid constraint and ignores trailing characters (asm_operand_ok). That
> > is, GCC would accept "Siiiii" as well...
> >
> > The GCC support for "S" is great. The initial aarch64 port in 2012 supp=
orts "S".
> >
>
> So it is not possible to combine the S and i constraint, and let the
> compiler figure out whether it meets either? We rely on this elsewhere
> by combining r and Z into rZ. x86 uses "rm" for inline asm parameters
> that could be either register or memory operands.

I did not realize that your "Si" suggestion meant this feature
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

    After the prefix, there must be one or more additional constraints
(see Constraints for asm Operands) that describe where the value
resides. Common constraints include =E2=80=98r=E2=80=99 for register and =
=E2=80=98m=E2=80=99 for
memory. When you list more than one possible location (for example,
"=3Drm"), the compiler chooses the most efficient one based on the
current context.

After some debugging of both GCC and Clang, I think you are right and
"Si" will work. Thanks for the suggestion!

GCC accepts "Si". Sorry for my incorrectly stating that GCC ignores
the trailing constraint. GCC does ignore an unknown constraint, as
long as one accepted constraint.

Clang accepts "Si" as well. In the absence of
https://github.com/llvm/llvm-project/pull/80255 (constant offset
support for 'S'), in TargetLowering::ComputeConstraintToUse, 'S' is
skipped and 'i' will be picked. This is unrelated to the "rm" weakness
in Clang (https://github.com/llvm/llvm-project/issues/20571).

I'll post a PATCH v2 removing JUMP_LABEL_STATIC_KEY_CONSTRAINT and
using "Si" unconditionally.

>
> > >> > >  static __always_inline bool arch_static_branch(struct static_ke=
y * const key,
> > >> > >                                              const bool branch)
> > >> > >  {
> > >> > > @@ -23,9 +33,9 @@ static __always_inline bool arch_static_branch=
(struct static_key * const key,
> > >> > >                "      .pushsection    __jump_table, \"aw\"    \n=
\t"
> > >> > >                "      .align          3                       \n=
\t"
> > >> > >                "      .long           1b - ., %l[l_yes] - .   \n=
\t"
> > >> > > -              "      .quad           %c0 - .                 \n=
\t"
> > >> > > +              "      .quad           %0 + %1 - .             \n=
\t"
> > >> > >                "      .popsection                             \n=
\t"
> > >> > > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> > >> > > +              :  :  JUMP_LABEL_STATIC_KEY_CONSTRAINT(key), "i"(=
branch) :  : l_yes);
> > >> >
> > >> > While this looks reasonable, I'm still not clear now why the asm m=
ust do
> > >> > the addition.
> > >> >
> > >> > Can we roll the branch argument into the macro?
> > >> >
> > >> > "S"(symbol + constant) seems to do the right thing for AArch64, at=
 least
> > >> > in GCC.
> > >> >
> > >>
> > >> 'symbol' is a struct static_key pointer, so adding '1' to it will no=
t
> > >> produce the needed result.
> > >
> > >I mean loosely things that resolve to something of the form
> > >"symbol + constant" in the compiler output.
> > >
> > >"S"(&((char *)key)[branch]) does indeed seem to do the right thing,
> > >at least with GCC.
> > >
> > >I probably didn't help by bikeshedding the way that expression was
> > >written, apologies for that.  It's orthogonal to what this patch is
> > >doing.
> >
> > Yes, "S"(&((char *)key)[branch])  would do the right thing.
> > I have compared assembly output. It's a matter of "s" vs "s + 0" and "s=
+1" vs "s + 1".
> >
>
> But if S does not work with constant offsets with older Clang, what is
> the harm in splitting it into "S" for the symbol and "i" for the
> branch?
> ...
> > >>
> > >> The only thing PIE linking does in the case of the kernel is
> > >> a) complain if static relocations are used that cannot be fixed up a=
t
> > >> runtime (e.g., movk/movz sequences)
> > >> b) emit dynamic relocations that the early startup code can use to f=
ix
> > >> up all statically initialized pointers
> > >>
> > >> From a codegen point-of-view, there is no difference because we don'=
t
> > >> use -fpic code. The problem with -fpic codegen is that it makes some
> > >> assumptions that only hold for shared ELF objects, e.g., avoiding
> > >> dynamic relocations in .text, using GOT entries even for variables
> > >> defined in the same compilation so that they can be preempted, keepi=
ng
> > >> all runtime relocatable quantities together so the CoW footprint of
> > >> the shared library is minimized.
> > >>
> > >> None of this matters for the kernel, and as it turns out, the non-PI=
C
> > >> small C model produces code that the PIE linker is happy with.
> > >>
> > >> TL;DR our code (including inline and out-of-line asm) is already PIC=
,
> > >> and this property is relied upon by KASLR.
> > >>
> > >> > Maybe it doesn't make as much difference as I thought (certainly A=
DRP
> > >> > based addressing should make a fair amount of the PIC/PIE overhead=
 go
> > >> > away).
> > >> >
> > >>
> > >> The PIC/PIE overhead is in the indirections via the GOT. However,
> > >> recent linkers will actually perform some relaxations too: if a symb=
ol
> > >> is defined in the same executable and is not preemptible, a GOT load
> > >>
> > >> ADRP
> > >> LDR
> > >>
> > >> can be transparently converted to
> > >>
> > >> ADRP
> > >> ADD
> > >>
> > >> referring to the symbol directly. This is also where hidden.h comes
> > >> in: making all symbol declarations and definitions 'hidden' will all=
ow
> > >> the compiler to assume that a GOT entry is never needed.
> > >
> > >Is there a reason why we don't just build the whole kernel with
> > >-fvisibility=3Dhidden today?
> >
> > This topic, loosely related to this patch, is about switching to PIC
> > compiles. I am not familiar with the Linux kernel, so I'll mostly leave
> > the discussion to you and Ard :)
> >
> > That said, I have done a lot of Clang work in visibility/symbol
> > preemptibility and linkers, so I am happy to add what I know.
> >
> > -fvisibility=3Dhidden only applies to definitions, not non-definition
> > declarations.
> >
> > I've mentioned this at
> > https://lore.kernel.org/all/20220429070318.iwj3j5lpfkw4t7g2@google.com/
> >
> >      `#pragma GCC visibility push(hidden)` is very similar to -fvisibil=
ity=3Dhidden -fdirect-access-external-data with Clang.
> >      ...
> >      The kernel uses neither TLS nor -fno-plt, so -fvisibility=3Dhidden
> >      -fdirect-access-external-data can replace `#pragma GCC visibility
> >      push(hidden)`.
> >
> > >> So building with -fPIC is currently not need in practice, and create=
s
> > >> some complications, which is why we have been avoiding it. But PIE
> > >> linking non-PIC objects is not guaranteed to remain supported going
> > >> forward, so it would be better to have a plan B, i.e., being able to
> > >> turn on -fpic without massive regressions due to GOT overhead, or
> > >> codegen problems with our asm hacks.
> > >
> > >Summarising all of this is it right that:
> > >
> > >1) ld -pie is how we get the reloc info into the kernel for KASLR
> > >today.
> > >
> > >2) We use gcc -fno-pic today, but this might break with ld -pie in the
> > >future, although it works for now.
> > >
> > >3) gcc -fno-pic and gcc -fPIC (or -fPIE) generate almost the same code=
,
> > >assuming we tweak symbol visibility and use a memory model that
> > >ADR+ADD/LDR can span.  So, moving to -fPIE is likely to be do-able.
> > >
> > >
> > >My point is that an alternative option would be to move to ld -no-pie.
>
> Why? What would that achieve?
>
> > >We would need another way to get relocs into the kernel, such as an
> > >intermediate step with ld --emit-relocs.  I have definitely seen this
> > >done before somewhere, but it would be extra work and not necessarily
> > >worth it, based on what you say about code gen.
>
> Relying on --emit-relocs is a terrible hack. It contains mostly
> relocations that we don't need at runtime, so we need to postprocess
> them. And linkers may not update these relocations in some cases after
> relaxation or other transformations (and sometimes, it is not even
> possible to do so, if the post-transformation situation cannot be
> described by a relocation).

Agreed. I've filed
https://sourceware.org/bugzilla/show_bug.cgi?id=3D30844
("ld riscv: --emit-relocs does not retain the original relocation
type") for a RISC-V version.

--emit-relocs is under-specified and the linker behaviors are less tested.

> And with Fangrui's RELR optimization, the PIE relocation data is
> extremely dense.
>
> There is nothing to fix here, really.
>
> > >
> > >This may all have been discussed to death already -- I didn't mean to
> > >hijack this patch, so I'll stop digging here, but if I've misunderstoo=
d,
> > >please shout!
>
> No worries. Ramana and I spent some time 5+ years ago to document how
> PIC codegen for the kernel (or any freestanding executable, really)
> deviates from the typical PIC codegen for shared libraries and PIE
> executables, with the intention of adding a GCC compiler switch for
> it, but that never really materialized, mostly because things just
> work fine today.
>

