Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A144E79081D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjIBNlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 09:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjIBNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 09:41:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63917E5B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 06:41:28 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RdGDV3FwWzNmt1;
        Sat,  2 Sep 2023 21:37:46 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 2 Sep 2023 21:41:24 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic: Remove the unnecessary sync_access argument
Date:   Sat, 2 Sep 2023 21:41:06 +0800
Message-ID: <20230902134106.1969-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 63f13483f068 ("irqchip/gic-v3: Relax polling of GIC{R,D}_CTLR.RWP")
has removed some instances of RWP polling where it's not required and left
the sync_access argument of gic_configure_irq() and gic_dist_config() no
longer needed.

Remove the now unnecessary argument.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

This is just a cleanup discovered by code inspection and can wait for the
6.7 window.

 drivers/irqchip/irq-gic-common.c | 12 ++----------
 drivers/irqchip/irq-gic-common.h |  6 ++----
 drivers/irqchip/irq-gic-v3.c     |  4 ++--
 drivers/irqchip/irq-gic.c        |  4 ++--
 drivers/irqchip/irq-hip04.c      |  4 ++--
 5 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index afd6a1841715..0843720bab30 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -44,8 +44,7 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 	}
 }
 
-int gic_configure_irq(unsigned int irq, unsigned int type,
-		       void __iomem *base, void (*sync_access)(void))
+int gic_configure_irq(unsigned int irq, unsigned int type, void __iomem *base)
 {
 	u32 confmask = 0x2 << ((irq % 16) * 2);
 	u32 confoff = (irq / 16) * 4;
@@ -84,14 +83,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
-	if (sync_access)
-		sync_access();
-
 	return ret;
 }
 
-void gic_dist_config(void __iomem *base, int gic_irqs,
-		     void (*sync_access)(void))
+void gic_dist_config(void __iomem *base, int gic_irqs)
 {
 	unsigned int i;
 
@@ -118,9 +113,6 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
 		writel_relaxed(GICD_INT_EN_CLR_X32,
 			       base + GIC_DIST_ENABLE_CLEAR + i / 8);
 	}
-
-	if (sync_access)
-		sync_access();
 }
 
 void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 3db4592cda1c..c53222159fef 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -19,10 +19,8 @@ struct gic_quirk {
 	u32 mask;
 };
 
-int gic_configure_irq(unsigned int irq, unsigned int type,
-                       void __iomem *base, void (*sync_access)(void));
-void gic_dist_config(void __iomem *base, int gic_irqs,
-		     void (*sync_access)(void));
+int gic_configure_irq(unsigned int irq, unsigned int type, void __iomem *base);
+void gic_dist_config(void __iomem *base, int gic_irqs);
 void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void));
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index eedfa8e9f077..20847446545b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -670,7 +670,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 	offset = convert_offset_index(d, GICD_ICFGR, &index);
 
-	ret = gic_configure_irq(index, type, base + offset, NULL);
+	ret = gic_configure_irq(index, type, base + offset);
 	if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
@@ -940,7 +940,7 @@ static void __init gic_dist_init(void)
 		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRnE + i);
 
 	/* Now do the common stuff */
-	gic_dist_config(base, GIC_LINE_NR, NULL);
+	gic_dist_config(base, GIC_LINE_NR);
 
 	val = GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1;
 	if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 412196a7dad5..c6c3d47afaaf 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -306,7 +306,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 			    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
+	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG);
 	if (ret && gicirq < 32) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI%d is secure or misconfigured\n", gicirq - 16);
@@ -482,7 +482,7 @@ static void gic_dist_init(struct gic_chip_data *gic)
 	for (i = 32; i < gic_irqs; i += 4)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
 
-	gic_dist_config(base, gic_irqs, NULL);
+	gic_dist_config(base, gic_irqs);
 
 	writel_relaxed(GICD_ENABLE, base + GIC_DIST_CTRL);
 }
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 46161f6ff289..890d10b1acf1 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -130,7 +130,7 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&irq_controller_lock);
 
-	ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG, NULL);
+	ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG);
 	if (ret && irq < 32) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
@@ -260,7 +260,7 @@ static void __init hip04_irq_dist_init(struct hip04_irq_data *intc)
 	for (i = 32; i < nr_irqs; i += 2)
 		writel_relaxed(cpumask, base + GIC_DIST_TARGET + ((i * 2) & ~3));
 
-	gic_dist_config(base, nr_irqs, NULL);
+	gic_dist_config(base, nr_irqs);
 
 	writel_relaxed(1, base + GIC_DIST_CTRL);
 }
-- 
2.33.0

