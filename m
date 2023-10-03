Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590FF7B68FB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbjJCM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJCM3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:29:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F8B691
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:29:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E7131FB;
        Tue,  3 Oct 2023 05:30:12 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.93.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FA273F59C;
        Tue,  3 Oct 2023 05:29:31 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:29:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: smp: Fix pseudo NMI issues w/ broken Mediatek
 FW
Message-ID: <ZRwJKBZaYwF1rrur@FVFF77S0Q05N>
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
 <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com>
 <CAD=FV=UeeL9uycVeKpOm+eDm3xHrOnKi2frt6a1qFG1HX9yEUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UeeL9uycVeKpOm+eDm3xHrOnKi2frt6a1qFG1HX9yEUg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 12:16:17PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Oct 2, 2023 at 10:24 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Oct 02, 2023 at 09:45:29AM -0700, Douglas Anderson wrote:
> > > Some mediatek devices have the property
> > > "mediatek,broken-save-restore-fw" in their GIC. This means that,
> > > although the hardware supports pseudo-NMI, the firmware has a bug
> > > that blocks enabling it. When we're in this state,
> > > system_uses_irq_prio_masking() will return true but we'll fail to
> > > actually enable the IRQ in the GIC.
> > >
> > > Let's make the code handle this. We'll detect that we failed to
> > > request an IPI as NMI and fallback to requesting it normally. Though
> > > we expect that either all of our requests will fail or all will
> > > succeed, it's just as cheap to keep a per-IPI bitmap and that keeps us
> > > robust.
> > >
> > > Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
> > > Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> > > Closes: https://issuetracker.google.com/issues/197061987#comment68
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  arch/arm64/kernel/smp.c | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > I'm not too keen on falling back here when we have no idea why the request failed.
> >
> > I'd prefer if we could check the `supports_pseudo_nmis` static key directly to
> > account for the case of broken FW, e.g. as below.
> >
> > Mark.
> >
> > ---->8----
> > From 72fdec05c64a74f21871b44c7c760bbe07cac044 Mon Sep 17 00:00:00 2001
> > From: Mark Rutland <mark.rutland@arm.com>
> > Date: Mon, 2 Oct 2023 18:00:36 +0100
> > Subject: [PATCH] arm64: smp: avoid NMI IPIs with broken MediaTek FW
> >
> > Some MediaTek devices have broken firmware which corrupts some GICR
> > registers behind the back of the OS, and pseudo-NMIs cannot be used on
> > these devices. For more details see commit:
> >
> >   44bd78dd2b8897f5 ("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues")
> >
> > We did not take this problem into account in commit:
> >
> >   331a1b3a836c0f38 ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
> >
> > Since that commit arm64's SMP code will try to setup some IPIs as
> > pseudo-NMIs, even on systems with broken FW. The GICv3 code will
> > (rightly) reject attempts to request interrupts as pseudo-NMIs,
> > resulting in boot-time failures.
> >
> > Avoid the problem by taking the broken FW into account when deciding to
> > request IPIs as pseudo-NMIs. The GICv3 driver maintains a static_key
> > named "supports_pseudo_nmis" which is false on systems with broken FW,
> > and we can consult this within ipi_should_be_nmi().
> >
> > Fixes: 331a1b3a836c0f38 ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
> > Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> > Closes: https://issuetracker.google.com/issues/197061987#comment68
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/kernel/smp.c      | 5 ++++-
> >  drivers/irqchip/irq-gic-v3.c | 2 +-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> Sure, this is OK w/ me as long as folks don't mind accessing the
> global here, it's OK w/ me:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> It seems to work for me, thus:
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>
> 
> 
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 814d9aa93b21b..061c69160f90f 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -964,7 +964,10 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> >
> >  static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
> >  {
> > -       if (!system_uses_irq_prio_masking())
> > +       DECLARE_STATIC_KEY_FALSE(supports_pseudo_nmis);
> > +
> > +       if (!system_uses_irq_prio_masking() ||
> > +           !static_branch_likely(&supports_pseudo_nmis))
> 
> One thought, actually, is whether we should actually change
> system_uses_irq_prio_masking() to return the correct value. What do
> you think?

I don't think we should add this to system_uses_irq_prio_masking(); that's used
by the low-level flags manipulation code that gets inlined all over the place,
and that code will work regarldess of whether we actually use NMI priorities.

If we want to avoid using PMR masking *at all* on these platforms, we'd need to
detect that within can_use_gic_priorities() or early_enable_pseudo_nmi().

Thanks,
Mark.
