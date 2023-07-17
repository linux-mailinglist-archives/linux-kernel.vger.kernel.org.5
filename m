Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B57563A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjGQM6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGQM6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:58:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A51A1725
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:57:49 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:57:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vefuixJumtk0yBn2sqoLWA3CCbpwswU21mplj/dOOjU=;
        b=syF+4cmsk7NI5FfDT/5grmxRSR/HydT9Xd6WeDnOxJlCAAlF/ec0UOmt1xoYU+T+1oMfs3
        ECNmpB9fLDjcXiC778GItkpbg18qAQU4bK+ZB21hlS6Pgb3ZgXlTBvMz1h/00H1v3s1H6H
        E+i/XJLAQVjbJsdrQm9VYSLZuFgNFxWI91U8Mb/iGa5+qJ2Oat+0lxCFI8FE8pZhFc/nGC
        O5sVhUkvzmLcBgy8YrkPFHuAMUvl70dKzzkCjDE+QQeehNzkipCJSQRsvKSDcX+j/VVLHU
        ZvPmRn3zrTma3xd3vMafXvQPrCt4nMP2NwI3FvHIUCC5QFl37aO8+C5HybVu9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vefuixJumtk0yBn2sqoLWA3CCbpwswU21mplj/dOOjU=;
        b=baQNiIy771xl46P0IJIUzcpYctr9FN7w4kW+C3IpOrnPrR7kcK6ucnx/fO994vozaggic3
        VzgPf828fAZ1V8BA==
From:   "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3: Workaround for GIC-700
 erratum 2941627
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230704155034.148262-1-lpieralisi@kernel.org>
References: <20230704155034.148262-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Message-ID: <168959865456.28540.15803135888794607892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     6fe5c68ee6a1aae0ef291a56001e7888de547fa2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6fe5c68ee6a1aae0ef291a56001e7888de547fa2
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Tue, 04 Jul 2023 17:50:34 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 11 Jul 2023 09:04:31 +01:00

irqchip/gic-v3: Workaround for GIC-700 erratum 2941627

GIC700 erratum 2941627 may cause GIC-700 missing SPIs wake
requests when SPIs are deactivated while targeting a
sleeping CPU - ie a CPU for which the redistributor:

GICR_WAKER.ProcessorSleep == 1

This runtime situation can happen if an SPI that has been
activated on a core is retargeted to a different core, it
becomes pending and the target core subsequently enters a
power state quiescing the respective redistributor.

When this situation is hit, the de-activation carried out
on the core that activated the SPI (through either ICC_EOIR1_EL1
or ICC_DIR_EL1 register writes) does not trigger a wake
requests for the sleeping GIC redistributor even if the SPI
is pending.

Work around the erratum by de-activating the SPI using the
redistributor GICD_ICACTIVER register if the runtime
conditions require it (ie the IRQ was retargeted between
activation and de-activation).

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230704155034.148262-1-lpieralisi@kernel.org
---
 Documentation/arm64/silicon-errata.rst |  3 +-
 drivers/irqchip/irq-gic-v3.c           | 62 ++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index d6430ad..0d55d58 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -141,6 +141,9 @@ stable kernels.
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
++----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_843419        |
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0c6c1af..eedfa8e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -69,6 +69,8 @@ struct gic_chip_data {
 static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
 static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
 
+static DEFINE_STATIC_KEY_FALSE(gic_arm64_2941627_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -592,10 +594,39 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
 }
 
+static bool gic_arm64_erratum_2941627_needed(struct irq_data *d)
+{
+	enum gic_intid_range range;
+
+	if (!static_branch_unlikely(&gic_arm64_2941627_erratum))
+		return false;
+
+	range = get_intid_range(d);
+
+	/*
+	 * The workaround is needed if the IRQ is an SPI and
+	 * the target cpu is different from the one we are
+	 * executing on.
+	 */
+	return (range == SPI_RANGE || range == ESPI_RANGE) &&
+		!cpumask_test_cpu(raw_smp_processor_id(),
+				  irq_data_get_effective_affinity_mask(d));
+}
+
 static void gic_eoi_irq(struct irq_data *d)
 {
 	write_gicreg(gic_irq(d), ICC_EOIR1_EL1);
 	isb();
+
+	if (gic_arm64_erratum_2941627_needed(d)) {
+		/*
+		 * Make sure the GIC stream deactivate packet
+		 * issued by ICC_EOIR1_EL1 has completed before
+		 * deactivating through GICD_IACTIVER.
+		 */
+		dsb(sy);
+		gic_poke_irq(d, GICD_ICACTIVER);
+	}
 }
 
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
@@ -606,7 +637,11 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 	 */
 	if (gic_irq(d) >= 8192 || irqd_is_forwarded_to_vcpu(d))
 		return;
-	gic_write_dir(gic_irq(d));
+
+	if (!gic_arm64_erratum_2941627_needed(d))
+		gic_write_dir(gic_irq(d));
+	else
+		gic_poke_irq(d, GICD_ICACTIVER);
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -1816,6 +1851,12 @@ static bool gic_enable_quirk_asr8601(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_arm64_2941627(void *data)
+{
+	static_branch_enable(&gic_arm64_2941627_erratum);
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1864,6 +1905,25 @@ static const struct gic_quirk gic_quirks[] = {
 		.init	= gic_enable_quirk_nvidia_t241,
 	},
 	{
+		/*
+		 * GIC-700: 2941627 workaround - IP variant [0,1]
+		 *
+		 */
+		.desc	= "GICv3: ARM64 erratum 2941627",
+		.iidr	= 0x0400043b,
+		.mask	= 0xff0e0fff,
+		.init	= gic_enable_quirk_arm64_2941627,
+	},
+	{
+		/*
+		 * GIC-700: 2941627 workaround - IP variant [2]
+		 */
+		.desc	= "GICv3: ARM64 erratum 2941627",
+		.iidr	= 0x0402043b,
+		.mask	= 0xff0f0fff,
+		.init	= gic_enable_quirk_arm64_2941627,
+	},
+	{
 	}
 };
 
