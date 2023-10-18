Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489637CDEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345098AbjJRONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjJROMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3873124;
        Wed, 18 Oct 2023 07:12:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC44C433C8;
        Wed, 18 Oct 2023 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638359;
        bh=6fR1zDnhTjOd8PDzhn3qngZr0tCpD2XBDM5cg16Eex0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1RGw44n2mG2umQOoq3bwiQRJBGUTaf+td0l0qV9s7ME27ub7uJ4SHM7wtNxmgR0w
         r5XMGB5UUTGDQZe3aBa8UPnW3tWE1QW44moJHeqAe6Ecw6kQSUr2mDBXXi71aJBpKx
         qaEqjzlpQ6qQjUlZsBPYEzzs0zmMz7h89CgQCLl+uUriZVDnCLX3Ps1AZZgbRw+hCp
         elyiPv1wiY7KNS1sOneYkq4NVK7f2Ozj+fCtUcAThcxXB4i2ANK66LbS3DE9VCI2XM
         cwjB04X2kAKD82mkrn/KtjcjdLHftBIblZrTfmDdaVPoaEB2LDACzcWzq6iHE2Iefz
         cr1DhXQGSVaIg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 18/31] irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing
Date:   Wed, 18 Oct 2023 10:11:35 -0400
Message-Id: <20231018141151.1334501-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Pieralisi <lpieralisi@kernel.org>

[ Upstream commit 3a0fff0fb6a3861fa05416f21858cf0c75cbf944 ]

The GIC architecture specification defines a set of registers
for redistributors and ITSes that control the sharebility and
cacheability attributes of redistributors/ITSes initiator ports
on the interconnect (GICR_[V]PROPBASER, GICR_[V]PENDBASER,
GITS_BASER<n>).

Architecturally the GIC provides a means to drive shareability
and cacheability attributes signals and related IWB/OWB/ISH barriers
but it is not mandatory for designs to wire up the corresponding
interconnect signals that control the cacheability/shareability
of transactions.

Redistributors and ITSes interconnect ports can be connected to
non-coherent interconnects that are not able to manage the
shareability/cacheability attributes; this implicitly makes
the redistributors and ITSes non-coherent observers.

So far, the GIC driver on probe executes a write to "probe" for
the redistributors and ITSes registers shareability bitfields
by writing a value (ie InnerShareable - the shareability domain the
CPUs are in) and check it back to detect whether the value sticks or
not; this hinges on a GIC programming model behaviour that predates the
current specifications, that just define shareability bits as writeable
but do not guarantee that writing certain shareability values
enable the expected behaviour for the redistributors/ITSes
memory interconnect ports.

To enable non-coherent GIC designs, introduce the "dma-noncoherent"
device tree property to allow firmware to describe redistributors and
ITSes as non-coherent observers on the memory interconnect and use the
property to force the shareability attributes to be programmed into the
redistributors and ITSes registers through the GIC quirks mechanism.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231006125929.48591-3-lpieralisi@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-common.h |  4 ++++
 drivers/irqchip/irq-gic-v3-its.c | 21 +++++++++++++++++----
 drivers/irqchip/irq-gic-v3.c     | 13 +++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 3db4592cda1c0..f407cce9ecaaa 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -29,4 +29,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
 
+#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
+#define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
+#define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
+
 #endif /* _IRQ_GIC_COMMON_H */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5e57b605b7c61..75a2dd550625b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -44,10 +44,6 @@
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
 #define ITS_FLAGS_FORCE_NON_SHAREABLE		(1ULL << 3)
 
-#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
-#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
-#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
-
 #define RD_LOCAL_LPI_ENABLED                    BIT(0)
 #define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
 #define RD_LOCAL_MEMRESERVE_DONE                BIT(2)
@@ -4754,6 +4750,14 @@ static bool __maybe_unused its_enable_rk3588001(void *data)
 	return true;
 }
 
+static bool its_set_non_coherent(void *data)
+{
+	struct its_node *its = data;
+
+	its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4808,6 +4812,11 @@ static const struct gic_quirk its_quirks[] = {
 		.init   = its_enable_rk3588001,
 	},
 #endif
+	{
+		.desc   = "ITS: non-coherent attribute",
+		.property = "dma-noncoherent",
+		.init   = its_set_non_coherent,
+	},
 	{
 	}
 };
@@ -4817,6 +4826,10 @@ static void its_enable_quirks(struct its_node *its)
 	u32 iidr = readl_relaxed(its->base + GITS_IIDR);
 
 	gic_enable_quirks(iidr, its_quirks, its);
+
+	if (is_of_node(its->fwnode_handle))
+		gic_enable_of_quirks(to_of_node(its->fwnode_handle),
+				     its_quirks, its);
 }
 
 static int its_save_disable(void)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index eedfa8e9f0772..f59ac9586b7b1 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1857,6 +1857,14 @@ static bool gic_enable_quirk_arm64_2941627(void *data)
 	return true;
 }
 
+static bool rd_set_non_coherent(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1923,6 +1931,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.mask	= 0xff0f0fff,
 		.init	= gic_enable_quirk_arm64_2941627,
 	},
+	{
+		.desc   = "GICv3: non-coherent attribute",
+		.property = "dma-noncoherent",
+		.init   = rd_set_non_coherent,
+	},
 	{
 	}
 };
-- 
2.40.1

