Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB81E7BC752
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbjJGMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343903AbjJGMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99315B6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:47 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B929DfrFxnuXVbTZAa61NcNcYwjzxLXsTAaVFGrv97M=;
        b=iSFSvoofRzabCtkIKuoByyYMLyAkiqGrDD2W7u0erKol9tEkBboY9mBJ9XjnJ0m5wxpwHb
        e3UquKoR6x0fGLn7475s66wEcmHW1IvQdHjjTRcHKzGhwKNjdUteJ0mfjhvEI8u0UJ66PI
        qMyXNpm4Zk+bjN8OZ8ha2CPk6q/e7RzmLS/JxnqmDKMeF7+4F/jUvN3mIv+p5mJvn0YKO0
        vh7WWF8DKxmcp03YKUxuA9qjHBg3zyWYKiyoJ1+IWLd1pqbvWpOH5Gu9rDZ71DeljaJ+qq
        AlTAvQC+m28LEZh/x6/zX2ZsK0YT9N8ekaaoaRVECMPg7210JqHRJK9w2RH7rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B929DfrFxnuXVbTZAa61NcNcYwjzxLXsTAaVFGrv97M=;
        b=iV0iue48N6EIHY+L8somcVQur5CoJNQ9d3yaA/Llf0z5e3gvkASR7U14pGjgYnN48KhHTt
        lApahZ0JVG8t2ADg==
From:   "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes DT probing
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20231006125929.48591-3-lpieralisi@kernel.org>
References: <20231006125929.48591-3-lpieralisi@kernel.org>
MIME-Version: 1.0
Message-ID: <169668004467.3135.10540259458367420057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     3a0fff0fb6a3861fa05416f21858cf0c75cbf944
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3a0fff0fb6a3861fa05416f21858cf0c75cbf944
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Fri, 06 Oct 2023 14:59:26 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:47:12 +01:00

irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing

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
---
 drivers/irqchip/irq-gic-common.h |  4 ++++
 drivers/irqchip/irq-gic-v3-its.c | 21 +++++++++++++++++----
 drivers/irqchip/irq-gic-v3.c     | 13 +++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 3db4592..f407cce 100644
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
index 5e57b60..75a2dd5 100644
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
@@ -4809,6 +4813,11 @@ static const struct gic_quirk its_quirks[] = {
 	},
 #endif
 	{
+		.desc   = "ITS: non-coherent attribute",
+		.property = "dma-noncoherent",
+		.init   = its_set_non_coherent,
+	},
+	{
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
index eedfa8e..f59ac95 100644
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
@@ -1924,6 +1932,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.init	= gic_enable_quirk_arm64_2941627,
 	},
 	{
+		.desc   = "GICv3: non-coherent attribute",
+		.property = "dma-noncoherent",
+		.init   = rd_set_non_coherent,
+	},
+	{
 	}
 };
 
