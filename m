Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037C37529B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjGMRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGMRUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:20:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8950C26A3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:20:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b7430bda8bso15300191fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689268800; x=1691860800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sf1LEXpI5qsWQMcYWNIu1Gn0J/fmr0jIVKvCTRIOitI=;
        b=MJ73vMkcAMR/QYGaIG2JAfhpokaQT8TPhHWU2AsTG4l3iHQOauGnppUjl5nHcNzv81
         rrvGNYjY3tuulMAEPBGZEod4/KF7EYZdA31JS4SKQqkvidyiPqPgYPBAsnREsUQ6pH4u
         eP7su6QoTIM3vec1TGEFlRxWbsYzCCWcBCOAbBgAOhqmoFtvyMy1/7jnCJxXyAACPSVP
         7AcbG9c/ToOu9vuWbGmT/7zZeZHl/5tTeBO/lQgGAo9s25Kh6l2bd9zDnP+41MVl5Lkd
         KbptZISWBLStr+WnBjDhf1KxXEkL0aC3iVIVm11qs4blG39PsufJUf+xtBL6HLubm9KB
         gcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689268800; x=1691860800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sf1LEXpI5qsWQMcYWNIu1Gn0J/fmr0jIVKvCTRIOitI=;
        b=E7U7cNFneti73U1O7EZMmvWl6GKu8NtLUWVyWe81HyjNAFXj+xj7H9izjzMlC2Z84G
         m5vijXeQx1iokV+5NCaGOFAQItA7ccyDiGekszyERp9neDWDj9aPNVM0ghYkwC9Kupav
         ozfU5eGyiRyHXq7QEEUsA95VTtGdc2zI/Q6BKpMy14pK5WVhq0odAkyMAFHP7lyc79ww
         /rrFBgqrTMCWAcf8bFgODfy4UEucFNApVSeARhgXzIE5JfNo38rmLL9aAWExTBODIkeA
         Oi7OSSEJuoZ42EPha5ikqRFF3KhzPJYkb65iPsVipGUfMsc5hGDBve9AP6se1YauVUgE
         cehg==
X-Gm-Message-State: ABy/qLbyN9XhcKYZ6IbKzqaps1/sDOvs3VKR4eSwZXawtLhxBiZ42Ba0
        En2r3cahlE1Q0vid6AapTR+EdDQSCdx7L3rTot4TEQ==
X-Google-Smtp-Source: APBJJlFhA2/oHj1WysqNchsjir2N59f/Lp6MRb5/86dqHuJPkA+JXi1PVdsgM6yLq2wweiWK0xDu1tGkq2EFCu7tij8=
X-Received: by 2002:a2e:908a:0:b0:2b6:e536:a2a3 with SMTP id
 l10-20020a2e908a000000b002b6e536a2a3mr1940731ljg.19.1689268800481; Thu, 13
 Jul 2023 10:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230711153743.1970625-1-heiko@sntech.de> <20230711153743.1970625-2-heiko@sntech.de>
 <6573575.5kvhTvEP53@basile.remlab.net>
In-Reply-To: <6573575.5kvhTvEP53@basile.remlab.net>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Fri, 14 Jul 2023 01:19:47 +0800
Message-ID: <CABgGipXgDKHPEBLT_e0DgHTo0WLwNxf5SD4sTDwmTHVj6Wz5VA@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] riscv: Add support for kernel mode vector
To:     =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Heiko

On Wed, Jul 12, 2023 at 1:15=E2=80=AFAM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>
>         Hi,
>
> Le tiistaina 11. hein=C3=A4kuuta 2023, 18.37.32 EEST Heiko Stuebner a =C3=
=A9crit :
> > From: Greentime Hu <greentime.hu@sifive.com>
> >
> > Add kernel_rvv_begin() and kernel_rvv_end() function declarations
> > and corresponding definitions in kernel_mode_vector.c
> >
> > These are needed to wrap uses of vector in kernel mode.
> >
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > ---
> >  arch/riscv/include/asm/vector.h        |  17 ++++
> >  arch/riscv/kernel/Makefile             |   1 +
> >  arch/riscv/kernel/kernel_mode_vector.c | 132 +++++++++++++++++++++++++
> >  3 files changed, 150 insertions(+)
> >  create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
> >
> > diff --git a/arch/riscv/include/asm/vector.h
> > b/arch/riscv/include/asm/vector.h index 3d78930cab51..ac2c23045eec 1006=
44
> > --- a/arch/riscv/include/asm/vector.h
> > +++ b/arch/riscv/include/asm/vector.h
> > @@ -196,6 +196,23 @@ static inline void __switch_to_vector(struct
> > task_struct *prev, void riscv_v_vstate_ctrl_init(struct task_struct *ts=
k);
> >  bool riscv_v_vstate_ctrl_user_allowed(void);
> >
> > +static inline void riscv_v_flush_cpu_state(void)
> > +{
> > +     asm volatile (
> > +             ".option push\n\t"
> > +             ".option arch, +v\n\t"
> > +             "vsetvli        t0, x0, e8, m8, ta, ma\n\t"
> > +             "vmv.v.i        v0, 0\n\t"
> > +             "vmv.v.i        v8, 0\n\t"
> > +             "vmv.v.i        v16, 0\n\t"
> > +             "vmv.v.i        v24, 0\n\t"
> > +             ".option pop\n\t"
> > +             : : : "t0");
>
> Why bother with zeroing out the vectors before kernel use? That sounds li=
ke it
> will only hide bugs in kernel code - implicitly assuming that everything =
is
> initially zero. Ditto initialising the vector configuration; if you reall=
y want
> to have a fixed initial value rather than "leak" whatever user set, bette=
r use
> an invalid configuration (vill=3D1), IMO.

Yes, I agree that we don't have to zero out (or invalid) v registers
before any kernel uses. And we only have to restore user's v registers
once, before really returning back to the user space. Actually I am
going to send out the series (for kernel-mode vector) having these
improvements in a few days. Does it seem ok to you to drop the first
two patches and rebase on top of mine at the next respin for the
crypto vector? Or is there any good way that you can think of to let
us cooperate on this?

>
> > +}
> > +
> > +void kernel_rvv_begin(void);
> > +void kernel_rvv_end(void);
> > +
> >  #else /* ! CONFIG_RISCV_ISA_V  */
> >
> >  struct pt_regs;
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 506cc4a9a45a..3f4435746af7 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -61,6 +61,7 @@ obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> >  obj-$(CONFIG_RISCV_M_MODE)   +=3D traps_misaligned.o
> >  obj-$(CONFIG_FPU)            +=3D fpu.o
> >  obj-$(CONFIG_RISCV_ISA_V)    +=3D vector.o
> > +obj-$(CONFIG_RISCV_ISA_V)    +=3D kernel_mode_vector.o
> >  obj-$(CONFIG_SMP)            +=3D smpboot.o
> >  obj-$(CONFIG_SMP)            +=3D smp.o
> >  obj-$(CONFIG_SMP)            +=3D cpu_ops.o
> > diff --git a/arch/riscv/kernel/kernel_mode_vector.c
> > b/arch/riscv/kernel/kernel_mode_vector.c new file mode 100644
> > index 000000000000..2d704190c054
> > --- /dev/null
> > +++ b/arch/riscv/kernel/kernel_mode_vector.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2012 ARM Ltd.
> > + * Author: Catalin Marinas <catalin.marinas@arm.com>
> > + * Copyright (C) 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
> > + * Copyright (C) 2021 SiFive
> > + */
> > +#include <linux/compiler.h>
> > +#include <linux/irqflags.h>
> > +#include <linux/percpu.h>
> > +#include <linux/preempt.h>
> > +#include <linux/types.h>
> > +
> > +#include <asm/vector.h>
> > +#include <asm/switch_to.h>
> > +
> > +DECLARE_PER_CPU(bool, vector_context_busy);
> > +DEFINE_PER_CPU(bool, vector_context_busy);
> > +
> > +/*
> > + * may_use_vector - whether it is allowable at this time to issue vect=
or
> > + *                instructions or access the vector register file
> > + *
> > + * Callers must not assume that the result remains true beyond the nex=
t
> > + * preempt_enable() or return from softirq context.
> > + */
> > +static __must_check inline bool may_use_vector(void)
> > +{
> > +     /*
> > +      * vector_context_busy is only set while preemption is disabled,
> > +      * and is clear whenever preemption is enabled. Since
> > +      * this_cpu_read() is atomic w.r.t. preemption, vector_context_bu=
sy
> > +      * cannot change under our feet -- if it's set we cannot be
> > +      * migrated, and if it's clear we cannot be migrated to a CPU
> > +      * where it is set.
> > +      */
> > +     return !in_irq() && !irqs_disabled() && !in_nmi() &&
> > +            !this_cpu_read(vector_context_busy);
> > +}
> > +
> > +/*
> > + * Claim ownership of the CPU vector context for use by the calling
> > context. + *
> > + * The caller may freely manipulate the vector context metadata until
> > + * put_cpu_vector_context() is called.
> > + */
> > +static void get_cpu_vector_context(void)
> > +{
> > +     bool busy;
> > +
> > +     preempt_disable();
> > +     busy =3D __this_cpu_xchg(vector_context_busy, true);
> > +
> > +     WARN_ON(busy);
> > +}
> > +
> > +/*
> > + * Release the CPU vector context.
> > + *
> > + * Must be called from a context in which get_cpu_vector_context() was
> > + * previously called, with no call to put_cpu_vector_context() in the
> > + * meantime.
> > + */
> > +static void put_cpu_vector_context(void)
> > +{
> > +     bool busy =3D __this_cpu_xchg(vector_context_busy, false);
> > +
> > +     WARN_ON(!busy);
> > +     preempt_enable();
> > +}
> > +
> > +/*
> > + * kernel_rvv_begin(): obtain the CPU vector registers for use by the
> > calling + * context
> > + *
> > + * Must not be called unless may_use_vector() returns true.
> > + * Task context in the vector registers is saved back to memory as
> > necessary. + *
> > + * A matching call to kernel_rvv_end() must be made before returning f=
rom
> > the + * calling context.
> > + *
> > + * The caller may freely use the vector registers until kernel_rvv_end=
() is
> > + * called.
> > + */
> > +void kernel_rvv_begin(void)
> > +{
> > +     if (WARN_ON(!has_vector()))
> > +             return;
> > +
> > +     WARN_ON(!may_use_vector());
> > +
> > +     /* Acquire kernel mode vector */
> > +     get_cpu_vector_context();
> > +
> > +     /* Save vector state, if any */
> > +     riscv_v_vstate_save(current, task_pt_regs(current));
> > +
> > +     /* Enable vector */
> > +     riscv_v_enable();
> > +
> > +     /* Invalidate vector regs */
> > +     riscv_v_flush_cpu_state();
> > +}
> > +EXPORT_SYMBOL_GPL(kernel_rvv_begin);
> > +
> > +/*
> > + * kernel_rvv_end(): give the CPU vector registers back to the current=
 task
> > + *
> > + * Must be called from a context in which kernel_rvv_begin() was previ=
ously
> > + * called, with no call to kernel_rvv_end() in the meantime.
> > + *
> > + * The caller must not use the vector registers after this function is
> > called, + * unless kernel_rvv_begin() is called again in the meantime.
> > + */
> > +void kernel_rvv_end(void)
> > +{
> > +     if (WARN_ON(!has_vector()))
> > +             return;
> > +
> > +     /* Invalidate vector regs */
> > +     riscv_v_flush_cpu_state();
> > +
> > +     /* Restore vector state, if any */
> > +     riscv_v_vstate_restore(current, task_pt_regs(current));
>
> I thought that the kernel was already nuking user vectors on every system
> call, since the RVV spec says so.
>
> Are you trying to use vectors from interrupts? Otherwise, isn't this flus=
h &
> restore superfluous?
>
> > +
> > +     /* disable vector */
> > +     riscv_v_disable();
> > +
> > +     /* release kernel mode vector */
> > +     put_cpu_vector_context();
> > +}
> > +EXPORT_SYMBOL_GPL(kernel_rvv_end);
>
>
> --
> =E9=9B=B7=E7=B1=B3=E2=80=A7=E5=BE=B7=E5=B0=BC-=E5=BA=93=E5=B0=94=E8=92=99
> http://www.remlab.net/
>
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks.

Andy
