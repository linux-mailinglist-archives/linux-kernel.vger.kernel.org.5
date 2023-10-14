Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811907C9424
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjJNKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:34:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED6B3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:34:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so4880850a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697279662; x=1697884462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFEZfw7PCCJHkUK5SvZXZL44soySFnk4Afiww2L6bMw=;
        b=E4l0iuGYWst0gBM08Dv3e/hXj36/DxtUnbNNpmx2gWSz1JIl6qmVHoJO9o6/JBPTpF
         NRP0pr7kHU+QDidmrQB9OMX6XnDdZ7ZAM18Ejm76hadpjLoQZdtP+ii+kz4oyB2lZDKy
         vwQQUJmYeHNMbyh93hhq7aIwBTw68a31AhfTf02M8fyPh0e1F50EpUkVF3J89Ff1wh/g
         KNyr3EXQAxtJladQUOqDksuB/zoSdZR/Op1qYUR3qvdhzGBFri16hazBIYhkTl7he3sv
         NU7mTSxAwbS2kS/0H5Qhx0lyGh9K0kieujooHFJmnbkRmxL6gfpSglGA6Nf8NOmuO/+1
         T9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697279662; x=1697884462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFEZfw7PCCJHkUK5SvZXZL44soySFnk4Afiww2L6bMw=;
        b=HSFWzvIczYRBptdanZEK9VpJUM1NhATlI0HYR6O/3oa7pcPnaWd6pqR057yEE2voJ7
         hRRwFxlPGvmJNy/2n0UuYxWMMohOtTGM3b85K5JiIrso7bpDKYOTnpl14ybVfn/e44iX
         9MZcAsrJwjaiL4tRweNwiQshwRh27GUURPkbKvqE/JwFoChza0f2Xl+HgfrWWknYVasM
         2CRqYv9CpxYKT5wwjFphQQ2pusqRVmx7/jjxmWHcwMVmh2m1KxcRtFGAFu7nwkU3sR8h
         bfRGE3Y7HGX6jXwGGjByFlnd3sUzAujguk7QVnZmoHXU2gc1TPpeYINOz6UyVb9Ln1fD
         Fxyg==
X-Gm-Message-State: AOJu0YxIXNaKg5eDunKWdXyHJ77UJZElNVVSGwPRtYQ9B0KwoWphtwao
        4YJcS1UAILUWjKrhX9g4Sh7AaMOhJN1aWdHTMfU=
X-Google-Smtp-Source: AGHT+IEC9nA9NZObni0rlKqgWO2Sr/7vlaDL/fV838uANMiozyQ8B8IvLvtv05xezfE57EJSYqAgyOOKdHiMhGdVmo0=
X-Received: by 2002:a50:d619:0:b0:53d:e91b:7158 with SMTP id
 x25-20020a50d619000000b0053de91b7158mr2204250edi.0.1697279662382; Sat, 14 Oct
 2023 03:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231011204150.51166-1-ubizjak@gmail.com> <ZSpnpfn/mSYrgC9C@gmail.com>
In-Reply-To: <ZSpnpfn/mSYrgC9C@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sat, 14 Oct 2023 12:34:14 +0200
Message-ID: <CAFULd4bt0ZjU7S+FKmSe6FG1OBPEgm1nyh_YG6=O0FazgBVaRw@mail.gmail.com>
Subject: Re: [PATCH tip] x86/percpu: Rewrite arch_raw_cpu_ptr()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 12:04=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Implement arch_raw_cpu_ptr() as a load from this_cpu_off and then
> > add the ptr value to the base. This way, the compiler can propagate
> > addend to the following instruction and simplify address calculation.
> >
> > E.g.: address calcuation in amd_pmu_enable_virt() improves from:
> >
> >     48 c7 c0 00 00 00 00      mov    $0x0,%rax
> >       87b7: R_X86_64_32S      cpu_hw_events
> >
> >     65 48 03 05 00 00 00      add    %gs:0x0(%rip),%rax
> >     00
> >       87bf: R_X86_64_PC32     this_cpu_off-0x4
> >
> >     48 c7 80 28 13 00 00      movq   $0x0,0x1328(%rax)
> >     00 00 00 00
> >
> > to:
> >
> >     65 48 8b 05 00 00 00      mov    %gs:0x0(%rip),%rax
> >     00
> >       8798: R_X86_64_PC32     this_cpu_off-0x4
> >     48 c7 80 00 00 00 00      movq   $0x0,0x0(%rax)
> >     00 00 00 00
> >       87a6: R_X86_64_32S      cpu_hw_events+0x1328
> >
> > The compiler can also eliminate redundant loads from this_cpu_off,
> > reducing the number of percpu offset reads (either from this_cpu_off
> > or with rdgsbase) from 1663 to 1571.
> >
> > Additionaly, the patch introduces 'rdgsbase' alternative for CPUs with
> > X86_FEATURE_FSGSBASE. The rdgsbase instruction *probably* will end up
> > only decoding in the first decoder etc. But we're talking single-cycle
> > kind of effects, and the rdgsbase case should be much better from
> > a cache perspective and might use fewer memory pipeline resources to
> > offset the fact that it uses an unusual front end decoder resource...
>
> So the 'additionally' wording in the changelog should have been a big hin=
t
> already that the introduction of RDGSBASE usage needs to be a separate
> patch. ;-)

Indeed. I think that the first part should be universally beneficial,
as it converts

mov symbol, %rax
add %gs:this_cpu_off, %rax

to:

mov %gs:this_cpu_off, %rax
add symbol, %rax

and allows the compiler to propagate addition into address calculation
(the latter is also similar to the code, generated by _seg_gs
approach).

At this point, the "experimental" part could either

a) introduce RDGSBASE:

As discussed with Sean, this could be problematic, at least with KVM,
and has some other drawbacks (e.g. larger binary size, limited CSE of
asm).

b) move to __seg_gs approach via _raw_cpu_read[1]:

This approach solves the "limited CSE with assembly" compiler issue,
since it exposes load to the compiler, and has greater optimization
potential.

[1] https://lore.kernel.org/lkml/20231010164234.140750-1-ubizjak@gmail.com/

Unfortunately, these two are mutually exclusive, since RDGSBASE is
implemented as asm.

To move things forward, I propose to proceed conservatively with the
original patch [1], but this one should be split into two parts. The
first will introduce the switch to MOV with tcp_ptr__ +=3D (unsigned
long)(ptr), and the second will add __seg_gs part.

At this point, we can experiment with RDGSBASE, and compare it with
both approaches, with and without __seg_gs, by just changing the asm
template to:

+       asm (ALTERNATIVE("mov " __percpu_arg(1) ", %0",        \
+                        "rdgsbase %0",                         \
+                        X86_FEATURE_FSGSBASE)                  \

Uros.
