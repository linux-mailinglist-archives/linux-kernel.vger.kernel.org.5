Return-Path: <linux-kernel+bounces-32580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B116A835D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CC11C23B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BEB39AD1;
	Mon, 22 Jan 2024 08:59:46 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408B39AC0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913985; cv=none; b=teFC5sAMrHdGru6oSjlq1VoDmEowprpnVtb/2PCKhDOMNV7GjnBFdPi68MuoaIduJ6Pju4vgpBTtc7PzkuKoNynVG2lw9x2/kd9uHNd+ifKoCdu2J+UzSMq8rbRBxPmX3wk8vU7fPLRQrqk8BbLtwg0DPiThKkmysFX0f5O0Mfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913985; c=relaxed/simple;
	bh=galQDiNGg+3zpk9YYSgsyR6Rvntnhg/nQ13yDyLGx3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MdYLI/mnXElIdPZ/Y+QrGlE0zrQgwJDD0jzuHWk7C+78bT62jipOioDpnP+SLHxGRPkAL38MOFy9+3lw8xo+YLteMop7/BPIu5NhN3PKLBXki+yKAHkZAmBt34LNS4j2KNBgfqqaNjl3PAMb68ne0hvqXmlEJjJPSLcaq/kuQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp71t1705913955tp7l95fl
X-QQ-Originating-IP: mRqY/56D25rXn1dtjsDHZjwbILtFFtCIuoelvrp9ScE=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jan 2024 16:59:14 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: 7jw2iSiCazrhE3SL65waJ5hi4B26LQXMtfFvfm57A7zCqfqh4nhbiM0mUWsGj
	UF7tZcfaQavPQS7f76Z99gEn6cs+9FuqADs7dymzmeQ1PLWvQSqp3DiR2Y0YyIFj6wrqQue
	WNu85dOH1gsCGCjw2y+sfEy+PTXZnJKyornIm+vjxB6VlqWlc6q/1VdxJNz4yadfudeVMte
	Fu2RZHVPB0w8xJoQsBt1KtcSVNWEOXVcDQOmpKF1wBwaKr3qiQo4gbIPc72Lun9iGQSe9EX
	gjxEzysR8NsUZUFQxQkpPPA3fzioMNGUfn+nBpw/0fGfjwObjaCgY/icDpiEkpa0QIm94zR
	I3FbbKXawUgBPRolg35rp+r1ZwFoNp1LGdzH63D9by77DdPY+TMD5+Sa2f03lbrZZrs+WsX
	rn3QQ1ZE47IYTktYUMs3mw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3206202564206613781
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com
Subject: [PATCH v2 2/5] irqchip/gic(v3): Replace gic_irq() with irqd_to_hwirq()
Date: Mon, 22 Jan 2024 16:57:13 +0800
Message-Id: <20240122085716.2999875-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240122085716.2999875-1-dawei.li@shingroup.cn>
References: <20240122085716.2999875-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

GIC & GIC-v3 share same gic_irq() implementations, both of which serve
exact same purpose of irqd_to_hwirq(). irqd_to_hwirq() is a generic and
top level API of interrupt subsystem, it's independent of any chip
implementation.

As such, replace gic_irq() with irqd_to_hwirq() in gic(v3) code.

Also, convert the type of struct irq_data::hwirq to irq_hw_number_t
explicitly.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/irqchip/irq-gic-v3.c | 19 +++++++------------
 drivers/irqchip/irq-gic.c    | 27 ++++++++++++---------------
 include/linux/irq.h          |  2 +-
 3 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 020a67195b16..b6cc23e393e3 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -181,11 +181,6 @@ static enum gic_intid_range get_intid_range(struct irq_data *d)
 	return __get_intid_range(d->hwirq);
 }
 
-static inline unsigned int gic_irq(struct irq_data *d)
-{
-	return d->hwirq;
-}
-
 static inline bool gic_irq_in_rdist(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
@@ -546,7 +541,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 	 * A secondary irq_chip should be in charge of LPI request,
 	 * it should not be possible to get there
 	 */
-	if (WARN_ON(gic_irq(d) >= 8192))
+	if (WARN_ON(irqd_to_hwirq(d) >= 8192))
 		return -EINVAL;
 
 	/* desc lock should already be held */
@@ -586,7 +581,7 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	 * A secondary irq_chip should be in charge of LPI request,
 	 * it should not be possible to get there
 	 */
-	if (WARN_ON(gic_irq(d) >= 8192))
+	if (WARN_ON(irqd_to_hwirq(d) >= 8192))
 		return;
 
 	/* desc lock should already be held */
@@ -624,7 +619,7 @@ static bool gic_arm64_erratum_2941627_needed(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	write_gicreg(gic_irq(d), ICC_EOIR1_EL1);
+	write_gicreg(irqd_to_hwirq(d), ICC_EOIR1_EL1);
 	isb();
 
 	if (gic_arm64_erratum_2941627_needed(d)) {
@@ -644,19 +639,19 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 	 * No need to deactivate an LPI, or an interrupt that
 	 * is is getting forwarded to a vcpu.
 	 */
-	if (gic_irq(d) >= 8192 || irqd_is_forwarded_to_vcpu(d))
+	if (irqd_to_hwirq(d) >= 8192 || irqd_is_forwarded_to_vcpu(d))
 		return;
 
 	if (!gic_arm64_erratum_2941627_needed(d))
-		gic_write_dir(gic_irq(d));
+		gic_write_dir(irqd_to_hwirq(d));
 	else
 		gic_poke_irq(d, GICD_ICACTIVER);
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
+	irq_hw_number_t irq = irqd_to_hwirq(d);
 	enum gic_intid_range range;
-	unsigned int irq = gic_irq(d);
 	void __iomem *base;
 	u32 offset, index;
 	int ret;
@@ -682,7 +677,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	ret = gic_configure_irq(index, type, base + offset, NULL);
 	if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
-		pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
+		pr_warn("GIC: PPI INTID%ld is secure or misconfigured\n", irq);
 		ret = 0;
 	}
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 412196a7dad5..98aa383e39db 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -162,11 +162,6 @@ static inline void __iomem *gic_cpu_base(struct irq_data *d)
 	return gic_data_cpu_base(gic_data);
 }
 
-static inline unsigned int gic_irq(struct irq_data *d)
-{
-	return d->hwirq;
-}
-
 static inline bool cascading_gic_irq(struct irq_data *d)
 {
 	void *data = irq_data_get_irq_handler_data(d);
@@ -183,14 +178,16 @@ static inline bool cascading_gic_irq(struct irq_data *d)
  */
 static void gic_poke_irq(struct irq_data *d, u32 offset)
 {
-	u32 mask = 1 << (gic_irq(d) % 32);
-	writel_relaxed(mask, gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4);
+	u32 mask = 1 << (irqd_to_hwirq(d) % 32);
+
+	writel_relaxed(mask, gic_dist_base(d) + offset + (irqd_to_hwirq(d) / 32) * 4);
 }
 
 static int gic_peek_irq(struct irq_data *d, u32 offset)
 {
-	u32 mask = 1 << (gic_irq(d) % 32);
-	return !!(readl_relaxed(gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4) & mask);
+	u32 mask = 1 << (irqd_to_hwirq(d) % 32);
+
+	return !!(readl_relaxed(gic_dist_base(d) + offset + (irqd_to_hwirq(d) / 32) * 4) & mask);
 }
 
 static void gic_mask_irq(struct irq_data *d)
@@ -220,7 +217,7 @@ static void gic_unmask_irq(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	u32 hwirq = gic_irq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	if (hwirq < 16)
 		hwirq = this_cpu_read(sgi_intid);
@@ -230,7 +227,7 @@ static void gic_eoi_irq(struct irq_data *d)
 
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
 {
-	u32 hwirq = gic_irq(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	/* Do not deactivate an IRQ forwarded to a vcpu. */
 	if (irqd_is_forwarded_to_vcpu(d))
@@ -293,8 +290,8 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
+	irq_hw_number_t gicirq = irqd_to_hwirq(d);
 	void __iomem *base = gic_dist_base(d);
-	unsigned int gicirq = gic_irq(d);
 	int ret;
 
 	/* Interrupt configuration for SGIs can't be changed */
@@ -309,7 +306,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
 	if (ret && gicirq < 32) {
 		/* Misconfigured PPIs are usually not fatal */
-		pr_warn("GIC: PPI%d is secure or misconfigured\n", gicirq - 16);
+		pr_warn("GIC: PPI%ld is secure or misconfigured\n", gicirq - 16);
 		ret = 0;
 	}
 
@@ -319,7 +316,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 {
 	/* Only interrupts on the primary GIC can be forwarded to a vcpu. */
-	if (cascading_gic_irq(d) || gic_irq(d) < 16)
+	if (cascading_gic_irq(d) || irqd_to_hwirq(d) < 16)
 		return -EINVAL;
 
 	if (vcpu)
@@ -796,7 +793,7 @@ static void rmw_writeb(u8 bval, void __iomem *addr)
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
+	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + irqd_to_hwirq(d);
 	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
 	unsigned int cpu;
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 90081afa10ce..97baa937ab5b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -179,7 +179,7 @@ struct irq_common_data {
 struct irq_data {
 	u32			mask;
 	unsigned int		irq;
-	unsigned long		hwirq;
+	irq_hw_number_t		hwirq;
 	struct irq_common_data	*common;
 	struct irq_chip		*chip;
 	struct irq_domain	*domain;
-- 
2.27.0


