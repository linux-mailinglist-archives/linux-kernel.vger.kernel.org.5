Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD0E778D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbjHKLRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjHKLRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B03E62
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A71B566693
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA42C433CC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691752625;
        bh=LiMd4YcWRrHGbaUx/9sIeqLDv2OtXbK5Stff+O4Teqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cm1CsDKUAnxFsaqLjXmvfRH8KGtLmDldbpsJbKdg2Vv6iYTR80H8ckjS1KkDwgMts
         cskpGQkfOOXfUnOXKmwmt77UfAb+VmbKVsTspwC1WjZYRYNO/9dBFUKeWu8PxhzQFx
         JdVJSyrBAM8iDSc5NeoJVL24QUyAwzHOfsMN2eyCQMR433/LcTjFVhncZQr64M5br0
         oC0QBSYB271aI6Y4MWnK2SVXM58MFQ5I1auP7s7+pY42kOh0cXVT+tDjABZSWRDrzN
         NYs3EwV6ugUlEFh3Z7lQ8CvcPrnNRF5Z02MBAW/73R+iaSSv8kzM2eCIUeVW203Uvd
         T5PxQUhMHtP5g==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5230ac6dbc5so2479506a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:17:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YxcjUMpBC5Y4nLnedjyvTHmA2MtXaJeQDpnTAMBeDA4iv2VBGr+
        6V8sXSmlJk1PEV0gceqYr9kV0aXITxO3cvkvWJ4=
X-Google-Smtp-Source: AGHT+IEe2UMHELNEPv1Mvk+a15+cz/CQPdLz0Wcclu6w1jxyN3DyNVgy7YVDggf1f2cyLytuXBg7iLUqdebOOSvZk4c=
X-Received: by 2002:aa7:d9c3:0:b0:522:28fa:3009 with SMTP id
 v3-20020aa7d9c3000000b0052228fa3009mr1580108eds.13.1691752623225; Fri, 11 Aug
 2023 04:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <98f523e515b2adc2aa7bb8d133353bad74e30897.camel@redhat.com>
 <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
 <CAJF2gTQgv5xsfSfvV7KePAXFnFQOMq4GXOp40kQgM54L6hVD7w@mail.gmail.com> <20230811-bd73721199b8699c9d7da564@orel>
In-Reply-To: <20230811-bd73721199b8699c9d7da564@orel>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 11 Aug 2023 19:16:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRSogcPF3D3eAEvcJOh-63wtKzncEiyH=sT-OLuVM0pvw@mail.gmail.com>
Message-ID: <CAJF2gTRSogcPF3D3eAEvcJOh-63wtKzncEiyH=sT-OLuVM0pvw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables of
 size 1 and 2
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, leobras@redhat.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        peterz@infradead.org, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, parri.andrea@gmail.com,
        andrzej.hajda@intel.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 7:10=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Aug 11, 2023 at 09:40:30AM +0800, Guo Ren wrote:
> > On Fri, Aug 11, 2023 at 12:23=E2=80=AFAM Palmer Dabbelt <palmer@rivosin=
c.com> wrote:
> > >
> > > On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > > > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> > > >> On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > > >> > xchg for variables of size 1-byte and 2-bytes is not yet availab=
le for
> > > >> > riscv, even though its present in other architectures such as ar=
m64 and
> > > >> > x86. This could lead to not being able to implement some locking=
 mechanisms
> > > >> > or requiring some rework to make it work properly.
> > > >> >
> > > >> > Implement 1-byte and 2-bytes xchg in order to achieve parity wit=
h other
> > > >> > architectures.
> > > >> >
> > > >> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > >>
> > > >
> > > > Hello Arnd Bergmann, thanks for reviewing!
> > > >
> > > >> Parity with other architectures by itself is not a reason to do th=
is,
> > > >> in particular the other architectures you listed have the instruct=
ions
> > > >> in hardware while riscv does not.
> > > >
> > > > Sure, I understand RISC-V don't have native support for xchg on var=
iables of
> > > > size < 4B. My argument is that it's nice to have even an emulated v=
ersion for
> > > > this in case any future mechanism wants to use it.
> > > >
> > > > Not having it may mean we won't be able to enable given mechanism i=
n RISC-V.
> > >
> > > IIUC the ask is to have a user within the kernel for these functions.
> > > That's the general thing to do, and last time this came up there was =
no
> > > in-kernel use of it -- the qspinlock stuff would, but we haven't enab=
led
> > > it yet because we're worried about the performance/fairness stuff tha=
t
> > > other ports have seen and nobody's got concrete benchmarks yet (thoug=
h
> > > there's another patch set out that I haven't had time to look through=
,
> > > so that may have changed).
> > Conor doesn't agree with using an alternative as a detour mechanism
> > between qspinlock & ticket lock. So I'm preparing V11 with static_key
> > (jump_label) style. Next version, I would separate paravirt_qspinlock
> > & CNA_qspinlock from V10. That would make it easy to review the
> > qspinlock patch series. You can review the next version V11. Now I'm
> > debugging a static_key init problem when load_modules, which is
> > triggered by our combo_qspinlock.
>
> We've seen problems with static keys and module loading in the past. You
> may want to take a look at commit eb6354e11630 ("riscv: Ensure isa-ext
> static keys are writable")
Thank you for the tip. I would take a look.

>
> Thanks,
> drew
>
> >
> > The qspinlock is being tested on the riscv platform [1] with 128 cores
> > with 8 NUMA nodes, next, I would update the comparison results of
> > qspinlock & ticket lock.
> >
> > [1]: https://www.sophon.ai/
> >
> > >
> > > So if something uses these I'm happy to go look closer.
> > >
> > > >> Emulating the small xchg() through cmpxchg() is particularly trick=
y
> > > >> since it's easy to run into a case where this does not guarantee
> > > >> forward progress.
> > > >>
> > > >
> > > > Didn't get this part:
> > > > By "emulating small xchg() through cmpxchg()", did you mean like em=
ulating an
> > > > xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> > > >
> > > > If so, yeah, it's a fair point: in some extreme case we could have =
multiple
> > > > threads accessing given cacheline and have sc always failing. On th=
e other hand,
> > > > there are 2 arguments on that:
> > > >
> > > > 1 - Other architectures, (such as powerpc, arm and arm64 without LS=
E atomics)
> > > > also seem to rely in this mechanism for every xchg size. Another ar=
chs like csky
> > > > and loongarch use asm that look like mine to handle size < 4B xchg.
> > > >
> > > >
> > > >>  This is also something that almost no architecture
> > > >> specific code relies on (generic qspinlock being a notable excepti=
on).
> > > >>
> > > >
> > > > 2 - As you mentioned, there should be very little code that will ac=
tually make
> > > > use of xchg for vars < 4B, so it should be safe to assume its fine =
to not
> > > > guarantee forward progress for those rare usages (like some of abov=
e mentioned
> > > > archs).
> > > >
> > > >> I would recommend just dropping this patch from the series, at lea=
st
> > > >> until there is a need for it.
> > > >
> > > > While I agree this is a valid point, I believe its more interesting=
 to have it
> > > > implemented if any future mechanism wants to make use of this.
> > > >
> > > >
> > > > Thanks!
> > > > Leo
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Best Regards
 Guo Ren
