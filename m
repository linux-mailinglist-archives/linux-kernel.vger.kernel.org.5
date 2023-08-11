Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225BE778507
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHKBkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHKBkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240610D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A5A964A7C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B65C433C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691718043;
        bh=NJ6p09CbSTr2E2bfl8mxk76nHLwPDnBOE4E31aqoHXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ukFP0lPswQW0z8jubmdg1L91dnwv+lqMVFrJFlRmabf/tqe2ZBS+pLaf+7B7okCq7
         pLwvSbAmZWAlGO2kO8z8mwmRPq/DSnbc0EAvmbAwSMH51EgN5kb1tfvb2yuqRbZUOG
         /UxbwuUYqTuHa4gbx/hGYih1MsjDrGgLqyHC3eBsfiv7b3b14438RqKaEFwOhdBnq3
         Fdk3dFTPxHINvEoHRV/X12odiNOe0Q63KzqnbcT0C7bhl26agNYwzIDlThBSZbqO2l
         ZJyTsFwfXxKGnGoDm74tr86kho75GePW262Gn1lJgghk8VuB0O6sPLRpjTQeznP4QG
         rjkThKeE/9C8g==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-523225dd110so1954287a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:40:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YzADc+Y6824G+5nXFKmhx8XQr2aZyIZTG3MvDQZF7riB4M5ze+O
        wA16mmwqJlUuwaCrqHmTtNsoYxyot9Y/TgMvadA=
X-Google-Smtp-Source: AGHT+IFuvY7MHaG2fY2pyFFFYnFbZrXUs4GynmjmNXuvGAjsAOK4IFX7ZMngfrFNPSpDlE1S3D5gI7m4vwsCowSTAo4=
X-Received: by 2002:aa7:c30f:0:b0:523:6c47:56f8 with SMTP id
 l15-20020aa7c30f000000b005236c4756f8mr590466edq.18.1691718041693; Thu, 10 Aug
 2023 18:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <98f523e515b2adc2aa7bb8d133353bad74e30897.camel@redhat.com> <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
In-Reply-To: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 11 Aug 2023 09:40:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQgv5xsfSfvV7KePAXFnFQOMq4GXOp40kQgM54L6hVD7w@mail.gmail.com>
Message-ID: <CAJF2gTQgv5xsfSfvV7KePAXFnFQOMq4GXOp40kQgM54L6hVD7w@mail.gmail.com>
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables of
 size 1 and 2
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     leobras@redhat.com, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>, peterz@infradead.org,
        boqun.feng@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, parri.andrea@gmail.com,
        andrzej.hajda@intel.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:23=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.co=
m> wrote:
>
> On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> >> On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> >> > xchg for variables of size 1-byte and 2-bytes is not yet available f=
or
> >> > riscv, even though its present in other architectures such as arm64 =
and
> >> > x86. This could lead to not being able to implement some locking mec=
hanisms
> >> > or requiring some rework to make it work properly.
> >> >
> >> > Implement 1-byte and 2-bytes xchg in order to achieve parity with ot=
her
> >> > architectures.
> >> >
> >> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> >>
> >
> > Hello Arnd Bergmann, thanks for reviewing!
> >
> >> Parity with other architectures by itself is not a reason to do this,
> >> in particular the other architectures you listed have the instructions
> >> in hardware while riscv does not.
> >
> > Sure, I understand RISC-V don't have native support for xchg on variabl=
es of
> > size < 4B. My argument is that it's nice to have even an emulated versi=
on for
> > this in case any future mechanism wants to use it.
> >
> > Not having it may mean we won't be able to enable given mechanism in RI=
SC-V.
>
> IIUC the ask is to have a user within the kernel for these functions.
> That's the general thing to do, and last time this came up there was no
> in-kernel use of it -- the qspinlock stuff would, but we haven't enabled
> it yet because we're worried about the performance/fairness stuff that
> other ports have seen and nobody's got concrete benchmarks yet (though
> there's another patch set out that I haven't had time to look through,
> so that may have changed).
Conor doesn't agree with using an alternative as a detour mechanism
between qspinlock & ticket lock. So I'm preparing V11 with static_key
(jump_label) style. Next version, I would separate paravirt_qspinlock
& CNA_qspinlock from V10. That would make it easy to review the
qspinlock patch series. You can review the next version V11. Now I'm
debugging a static_key init problem when load_modules, which is
triggered by our combo_qspinlock.

The qspinlock is being tested on the riscv platform [1] with 128 cores
with 8 NUMA nodes, next, I would update the comparison results of
qspinlock & ticket lock.

[1]: https://www.sophon.ai/

>
> So if something uses these I'm happy to go look closer.
>
> >> Emulating the small xchg() through cmpxchg() is particularly tricky
> >> since it's easy to run into a case where this does not guarantee
> >> forward progress.
> >>
> >
> > Didn't get this part:
> > By "emulating small xchg() through cmpxchg()", did you mean like emulat=
ing an
> > xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> >
> > If so, yeah, it's a fair point: in some extreme case we could have mult=
iple
> > threads accessing given cacheline and have sc always failing. On the ot=
her hand,
> > there are 2 arguments on that:
> >
> > 1 - Other architectures, (such as powerpc, arm and arm64 without LSE at=
omics)
> > also seem to rely in this mechanism for every xchg size. Another archs =
like csky
> > and loongarch use asm that look like mine to handle size < 4B xchg.
> >
> >
> >>  This is also something that almost no architecture
> >> specific code relies on (generic qspinlock being a notable exception).
> >>
> >
> > 2 - As you mentioned, there should be very little code that will actual=
ly make
> > use of xchg for vars < 4B, so it should be safe to assume its fine to n=
ot
> > guarantee forward progress for those rare usages (like some of above me=
ntioned
> > archs).
> >
> >> I would recommend just dropping this patch from the series, at least
> >> until there is a need for it.
> >
> > While I agree this is a valid point, I believe its more interesting to =
have it
> > implemented if any future mechanism wants to make use of this.
> >
> >
> > Thanks!
> > Leo



--=20
Best Regards
 Guo Ren
