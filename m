Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30992793886
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjIFJl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjIFJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:41:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB6D1723;
        Wed,  6 Sep 2023 02:41:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85757C433BA;
        Wed,  6 Sep 2023 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693993312;
        bh=2lSDxtDFIOxeqnM30cINB0ccVbHU+rm0bj9i8eYiRZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uv1Vr+BzUtTZnS49r4iPHyo2i1ijP15WlWyHKmn9Erl9jdrAXiVPAJJ4TDjwiR0JQ
         BQm42CAuHQRH0kxJwcJDYDhhUYmFe/oNDT9YEWMvkN/+fc3f787epyddr58ZZF+YLW
         94YSvKwZRqT/B/ATpP+6HAWZUQIAn0qFjfPkW5gkLx6uHvpbRDTEPADscrvBBbYt7T
         iy3I0A8PhPc5BXZtuo0FgfUG2+ucaRHz0UTm86e5fpIH++PZYNjyyZ451oq6CAjQ8l
         gKrztTudIdCdRz3W+0r8SdXfRIIYjwNTQkP6mtf92AKFypewi5jusnQrcPlWTDME56
         aRTPV9a4bIhmw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: [PATCH v2 2/2] irqchip/gic-v3: Enable non-coherent redistributors/ITSes probing
Date:   Wed,  6 Sep 2023 11:41:39 +0200
Message-Id: <20230906094139.16032-3-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906094139.16032-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20230906094139.16032-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/irqchip/irq-gic-common.h |  4 ++++
 drivers/irqchip/irq-gic-v3-its.c | 21 +++++++++++++++++----
 drivers/irqchip/irq-gic-v3.c     | 13 +++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 3db4592cda1c..c4de216874db 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -29,4 +29,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
 
+#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
+#define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
+#define RDIST_FLAGS_FORCE_NON_SHAREABLE                (1 << 2)
+
 #endif /* _IRQ_GIC_COMMON_H */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e0c2b10d154d..adde347dc890 100644
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
index eedfa8e9f077..f59ac9586b7b 100644
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
2.34.1

