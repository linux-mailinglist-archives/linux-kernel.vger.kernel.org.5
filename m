Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB27784DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHKBYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKBYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34172D47
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C449647F8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9706DC433D9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691717076;
        bh=z/ApM4JIfgoc2kMWRTObiOpWbSaib9krnYCDwP5P8Pw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hbSKdmH/GZ1NOXkibEepTKMSSA5XtrwCgb4s2oLkcgfjndJzbFEXU6Xqcbcr5uBAf
         GcL7mZkQylLlAnajsiqkrDkE5HVZkiP49o8qAeQQuVN2xPMiFOgnfLcIC2JcCjioC0
         pw50bKLzd9HCg5tTGy7VWzXigK6z/GvbbE9OlAN00A7TcEtP3HNQ10ZUn5vYlBCz2f
         NbLsXOVPAmRDGCybMvAEA4Vlphe7X9GjRp89LXeCpsE8ZOq0iJ9SroyUbMRo1Uv3Ae
         //kZstU/Z8tqgvFU/43y/nkTN/KJo9LNgivld+H274lWxe6ahzYohg2lX3XeLz5EkR
         Xq0l5VC4oHO/g==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so2378754e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:24:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw/ljY2Hy5GWUFM19cx+EgVALOWcn5M9v0ZNKGr4tRr/QSAzcJu
        ocBhdceBRzhdsx5BQUvu4Cr3mWjmOo/D7OUuVrM=
X-Google-Smtp-Source: AGHT+IEfhZHOYgE0W2CMhBBFgAATMUaaFFIs8w6yOVaIhf/f9UTse71cUOg2SYyIm4oxYBvlVBL0pti0OqL8Hi3JtDc=
X-Received: by 2002:a19:ae09:0:b0:4fb:893a:d322 with SMTP id
 f9-20020a19ae09000000b004fb893ad322mr182924lfc.68.1691717074517; Thu, 10 Aug
 2023 18:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9> <ad9b8e41-5897-4ad6-8113-2812301c0c93@app.fastmail.com>
In-Reply-To: <ad9b8e41-5897-4ad6-8113-2812301c0c93@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 11 Aug 2023 09:24:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTg9MMj0TXJmQsWKsnoGKD_F84HKC5D9LFEy_5uERpRCw@mail.gmail.com>
Message-ID: <CAJF2gTTg9MMj0TXJmQsWKsnoGKD_F84HKC5D9LFEy_5uERpRCw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables of
 size 1 and 2
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Leonardo Bras <leobras@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 3:13=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Aug 10, 2023, at 18:23, Palmer Dabbelt wrote:
> > On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> >> On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> >>> On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> >>> > xchg for variables of size 1-byte and 2-bytes is not yet available =
for
> >>> > riscv, even though its present in other architectures such as arm64=
 and
> >>> > x86. This could lead to not being able to implement some locking me=
chanisms
> >>> > or requiring some rework to make it work properly.
> >>> >
> >>> > Implement 1-byte and 2-bytes xchg in order to achieve parity with o=
ther
> >>> > architectures.
> >>
> >>> Parity with other architectures by itself is not a reason to do this,
> >>> in particular the other architectures you listed have the instruction=
s
> >>> in hardware while riscv does not.
> >>
> >> Sure, I understand RISC-V don't have native support for xchg on variab=
les of
> >> size < 4B. My argument is that it's nice to have even an emulated vers=
ion for
> >> this in case any future mechanism wants to use it.
> >>
> >> Not having it may mean we won't be able to enable given mechanism in R=
ISC-V.
> >
> > IIUC the ask is to have a user within the kernel for these functions.
> > That's the general thing to do, and last time this came up there was no
> > in-kernel use of it -- the qspinlock stuff would, but we haven't enable=
d
> > it yet because we're worried about the performance/fairness stuff that
> > other ports have seen and nobody's got concrete benchmarks yet (though
> > there's another patch set out that I haven't had time to look through,
> > so that may have changed).
>
> Right. In particular the qspinlock is a good example for something
> where having the emulated 16-bit xchg() may end up less efficient
> than a natively supported instruction.
The xchg() efficiency depends on micro-architecture. and the number of
instructions is not the key, even one instruction would be separated
into several micro-ops. I thought the Power guys won't agree with this
view :)

>
> The xchg() here is a performance optimization for CPUs that can
> do this without touching the other half of the 32-bit word.
It's useless on a non-SMT system because all operations are cacheline
based. (Ps: Because xchg() has a load semantic, CHI's "Dirty Partial"
& "Clean Empty" can't help anymore.)

>
> >>
> >> Didn't get this part:
> >> By "emulating small xchg() through cmpxchg()", did you mean like emula=
ting an
> >> xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> >>
> >> If so, yeah, it's a fair point: in some extreme case we could have mul=
tiple
> >> threads accessing given cacheline and have sc always failing. On the o=
ther hand,
> >> there are 2 arguments on that:
> >>
> >> 1 - Other architectures, (such as powerpc, arm and arm64 without LSE a=
tomics)
> >> also seem to rely in this mechanism for every xchg size. Another archs=
 like csky
> >> and loongarch use asm that look like mine to handle size < 4B xchg.
>
> I think you misread the arm64 code, which should use native instructions
> for all sizes, in both the armv8.0 and LSE atomics.
>
> PowerPC does use the masking for xchg, but I suspect there are no
> actual users, at least it actually has its own qspinlock implementation
> that avoids xchg().
PowerPC still needs similar things, see publish_tail_cpu(), and more
complex cmpxchg semantics.

Paravrit qspinlock and CNA qspinlock still need more:
 - xchg8 (RCsc)
 - cmpxchg8/16_relaxed
 - cmpxchg8/16_release (Rcpc)
 - cmpxchg8_acquire (RCpc)
 - cmpxchg8 (RCsc)

>
> >>>  This is also something that almost no architecture
> >>> specific code relies on (generic qspinlock being a notable exception)=
.
> >>>
> >>
> >> 2 - As you mentioned, there should be very little code that will actua=
lly make
> >> use of xchg for vars < 4B, so it should be safe to assume its fine to =
not
> >> guarantee forward progress for those rare usages (like some of above m=
entioned
> >> archs).
>
> I don't this this is a safe assumption, we've had endless discussions
> about using qspinlock on architectures without a native xchg(), which
> needs either hardware guarantees or special countermeasures in xchg() its=
elf
> to avoid this.
>
> What I'd actually like to do here is to remove the special 8-bit and
> 16-bit cases from the xchg() and cmpxchg() interfaces at all, leaving
It needs to modify qspinlock, paravirt_qspinlock, and CNA_qspinlock
code to prevent using 8-bit/16-bit xchg/cmpxchg, and cleanup all
architectures' cmpxchg.h. What you do is just get them out of the
common atomic.h, but architectures still need to solve them and
connect to the qspinlock series.

> only fixed 32-bit and native wordsize (either 32 or 64) as the option,
> while dealing with the others the same way we treat the fixed
> 64-bit cases that hardcode the 64-bit argument types and are only
> usable on architectures that provide them.
>
>     Arnd



--=20
Best Regards
 Guo Ren
