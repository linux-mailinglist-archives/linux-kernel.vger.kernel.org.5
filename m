Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7679C783A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjHVGm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjHVGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:42:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEEC412C;
        Mon, 21 Aug 2023 23:42:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756332F4;
        Mon, 21 Aug 2023 23:43:33 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2863F740;
        Mon, 21 Aug 2023 23:42:49 -0700 (PDT)
Date:   Tue, 22 Aug 2023 07:42:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/7] arm64: Add framework for a debug IPI
Message-ID: <ZORY51mF4alI41G1@FVFF77S0Q05N>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.3.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
 <ZNDDgRuNGzovddaO@FVFF77S0Q05N.cambridge.arm.com>
 <CAD=FV=VVJsJSc=uQWad4x0EV2-iROFcueW_=4VbM+0N0+aD96g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VVJsJSc=uQWad4x0EV2-iROFcueW_=4VbM+0N0+aD96g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 03:16:56PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Aug 7, 2023 at 3:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Jun 01, 2023 at 02:31:47PM -0700, Douglas Anderson wrote:
> > > From: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > Introduce a framework for an IPI that will be used for debug
> > > purposes. The primary use case of this IPI will be to generate stack
> > > crawls on other CPUs, but it will also be used to round up CPUs for
> > > kgdb.
> > >
> > > When possible, we try to allocate this debug IPI as an NMI (or a
> > > pseudo NMI). If that fails (due to CONFIG, an incompatible interrupt
> > > controller, a quirk, missing the "irqchip.gicv3_pseudo_nmi=1" kernel
> > > parameter, etc) we fall back to a normal IPI.
> > >
> > > NOTE: hooking this up for CPU backtrace / kgdb will happen in a future
> > > patch, this just adds the framework.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > I think that we shouldn't add a framework in a separate file for this:
> >
> > * This is very similar to our existing IPI management in smp.c, so it feels
> >   like duplication, or at least another thing we'd like to keep in-sync.
> >
> > * We're going to want an NMI backtrace regardless of KGDB
> >
> > * We're going to want the IPI_CPU_STOP and IPI_CRASH_CPU_STOP IPIs to be NMIs
> >   too.
> >
> > I reckon it'd be better to extend the existing IPI logic in smp.c to allow IPIs
> > to be requested as NMIs, e.g.
> >
> > ----
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index edd63894d61e8..48e6aa62c473e 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/kernel_stat.h>
> >  #include <linux/kexec.h>
> >  #include <linux/kvm_host.h>
> > +#include <linux/nmi.h>
> >
> >  #include <asm/alternative.h>
> >  #include <asm/atomic.h>
> > @@ -926,6 +927,21 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> >         __ipi_send_mask(ipi_desc[ipinr], target);
> >  }
> >
> > +static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
> > +{
> > +       if (!system_uses_irq_prio_masking())
> > +               return false;
> > +
> > +       switch (ipi) {
> > +       /*
> > +        * TODO: select NMI IPIs here
> > +        */
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> >  static void ipi_setup(int cpu)
> >  {
> >         int i;
> > @@ -933,8 +949,14 @@ static void ipi_setup(int cpu)
> >         if (WARN_ON_ONCE(!ipi_irq_base))
> >                 return;
> >
> > -       for (i = 0; i < nr_ipi; i++)
> > -               enable_percpu_irq(ipi_irq_base + i, 0);
> > +       for (i = 0; i < nr_ipi; i++) {
> > +               if (ipi_should_be_nmi(i)) {
> > +                       prepare_percpu_nmi(ipi_irq_base + i);
> > +                       enable_percpu_nmi(ipi_irq_base + i, 0);
> > +               } else {
> > +                       enable_percpu_irq(ipi_irq_base + i, 0);
> > +               }
> > +       }
> >  }
> >
> >  #ifdef CONFIG_HOTPLUG_CPU
> > @@ -945,8 +967,14 @@ static void ipi_teardown(int cpu)
> >         if (WARN_ON_ONCE(!ipi_irq_base))
> >                 return;
> >
> > -       for (i = 0; i < nr_ipi; i++)
> > -               disable_percpu_irq(ipi_irq_base + i);
> > +       for (i = 0; i < nr_ipi; i++) {
> > +               if (ipi_should_be_nmi(i)) {
> > +                       disable_percpu_nmi(ipi_irq_base + i);
> > +                       teardown_percpu_nmi(ipi_irq_base + i);
> > +               } else {
> > +                       disable_percpu_irq(ipi_irq_base + i);
> > +               }
> > +       }
> >  }
> >  #endif
> >
> > @@ -958,11 +986,19 @@ void __init set_smp_ipi_range(int ipi_base, int n)
> >         nr_ipi = min(n, NR_IPI);
> >
> >         for (i = 0; i < nr_ipi; i++) {
> > -               int err;
> > -
> > -               err = request_percpu_irq(ipi_base + i, ipi_handler,
> > -                                        "IPI", &cpu_number);
> > -               WARN_ON(err);
> > +               int err = -EINVAL;
> > +
> > +               if (ipi_should_be_nmi(i)) {
> > +                       err = request_percpu_nmi(ipi_base + i, ipi_handler,
> > +                                                "IPI", &cpu_number);
> > +                       WARN(err, "Could not request IPI %d as NMI, err=%d\n",
> > +                            i, err);
> > +               } else {
> > +                       err = request_percpu_irq(ipi_base + i, ipi_handler,
> > +                                                "IPI", &cpu_number);
> > +                       WARN(err, "Could not request IPI %d as IRQ, err=%d\n",
> > +                            i, err);
> > +               }
> >
> >                 ipi_desc[i] = irq_to_desc(ipi_base + i);
> >                 irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
> > ----
> >
> > ... and then if we need an IPI for KGDB, we can add that to the existing list
> > of IPIs, and have it requested/enabled/disabled as usual.
> 
> Sounds good. I'm starting to work on v10 incorporating your feedback.
> A few quick questions:
> 
> 1. If I mostly take your patch above verbatim, do you have any
> suggested tags for Author/Signed-off-by? I'd tend to set you as the
> author but I can't do that because you didn't provide a
> Signed-off-by...

Sorry about that. For the above:

Signed-off-by: Mark Rutland <mark.rutland@arm.com>

If squashed into another patch, then feel free to use:

Co-developed-by: Mark Rutland <mark.rutland@arm.com>

> 2. Would you prefer this patch on its own, or would you rather it be
> squashed with the first user ("backtrace")? On its own, I think I have
> to get rid of the "switch" statement in ipi_should_be_nmi() and just
> return false;

I reckon it makes sense to squash it with the first user.

Thanks,
Mark.
