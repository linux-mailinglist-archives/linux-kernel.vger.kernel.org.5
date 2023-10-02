Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B2A7B5912
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjJBRYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjJBRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:24:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EC31AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:24:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CD7CC15;
        Mon,  2 Oct 2023 10:25:01 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8073F59C;
        Mon,  2 Oct 2023 10:24:20 -0700 (PDT)
Date:   Mon, 2 Oct 2023 18:24:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
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
Message-ID: <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com>
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:45:29AM -0700, Douglas Anderson wrote:
> Some mediatek devices have the property
> "mediatek,broken-save-restore-fw" in their GIC. This means that,
> although the hardware supports pseudo-NMI, the firmware has a bug
> that blocks enabling it. When we're in this state,
> system_uses_irq_prio_masking() will return true but we'll fail to
> actually enable the IRQ in the GIC.
> 
> Let's make the code handle this. We'll detect that we failed to
> request an IPI as NMI and fallback to requesting it normally. Though
> we expect that either all of our requests will fail or all will
> succeed, it's just as cheap to keep a per-IPI bitmap and that keeps us
> robust.
> 
> Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> Closes: https://issuetracker.google.com/issues/197061987#comment68
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm64/kernel/smp.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

I'm not too keen on falling back here when we have no idea why the request failed.

I'd prefer if we could check the `supports_pseudo_nmis` static key directly to
account for the case of broken FW, e.g. as below.

Mark.

---->8----
From 72fdec05c64a74f21871b44c7c760bbe07cac044 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 2 Oct 2023 18:00:36 +0100
Subject: [PATCH] arm64: smp: avoid NMI IPIs with broken MediaTek FW

Some MediaTek devices have broken firmware which corrupts some GICR
registers behind the back of the OS, and pseudo-NMIs cannot be used on
these devices. For more details see commit:

  44bd78dd2b8897f5 ("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues")

We did not take this problem into account in commit:

  331a1b3a836c0f38 ("arm64: smp: Add arch support for backtrace using pseudo-NMI")

Since that commit arm64's SMP code will try to setup some IPIs as
pseudo-NMIs, even on systems with broken FW. The GICv3 code will
(rightly) reject attempts to request interrupts as pseudo-NMIs,
resulting in boot-time failures.

Avoid the problem by taking the broken FW into account when deciding to
request IPIs as pseudo-NMIs. The GICv3 driver maintains a static_key
named "supports_pseudo_nmis" which is false on systems with broken FW,
and we can consult this within ipi_should_be_nmi().

Fixes: 331a1b3a836c0f38 ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Closes: https://issuetracker.google.com/issues/197061987#comment68
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/smp.c      | 5 ++++-
 drivers/irqchip/irq-gic-v3.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 814d9aa93b21b..061c69160f90f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -964,7 +964,10 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 
 static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 {
-	if (!system_uses_irq_prio_masking())
+	DECLARE_STATIC_KEY_FALSE(supports_pseudo_nmis);
+
+	if (!system_uses_irq_prio_masking() ||
+	    !static_branch_likely(&supports_pseudo_nmis))
 		return false;
 
 	switch (ipi) {
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 787ccc880b22d..737da1b9aabf2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -106,7 +106,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
  * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
  *   interrupt.
  */
-static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
+DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
 DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
 EXPORT_SYMBOL(gic_nonsecure_priorities);
-- 
2.30.2

 
