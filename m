Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8297D7B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjJZD3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZD3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:29:43 -0400
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 20:29:40 PDT
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1AAA3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 20:29:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.valinux.co.jp (Postfix) with ESMTP id 9CF04A95D5;
        Thu, 26 Oct 2023 12:20:49 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
        by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BZIOroBdaW5M; Thu, 26 Oct 2023 12:20:49 +0900 (JST)
Received: from z790sl.. (KD111097181081.ppp-bb.dion.ne.jp [111.97.181.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.valinux.co.jp (Postfix) with ESMTPSA id 73102A9165;
        Thu, 26 Oct 2023 12:20:49 +0900 (JST)
From:   Koichiro Den <den@valinux.co.jp>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Koichiro Den <den@valinux.co.jp>
Subject: [PATCH] x86/apic/msi: Fix misconfigured non-maskable MSI quirk
Date:   Thu, 26 Oct 2023 12:20:36 +0900
Message-ID: <20231026032036.2462428-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ef8dd01538ea ("genirq/msi: Make interrupt allocation less
convoluted"), x86 non-maskable MSI quirk has not been activated as
intended. Practically, if the reservation mode cannot be activated,
the quirk needs to be activated (specific to x86), so we can dispense
with IRQD_MSI_NOMASK_QUIRK bit. It not only addresses the issue but
also simplifies the codebase.

Fixes: ef8dd01538ea ("genirq/msi: Make interrupt allocation less convoluted")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 arch/x86/kernel/apic/msi.c |  8 +++-----
 include/linux/irq.h        | 26 ++++----------------------
 include/linux/msi.h        |  6 ------
 kernel/irq/debugfs.c       |  1 -
 kernel/irq/msi.c           | 12 +-----------
 5 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6b6b711678fe..d9651f15ae4f 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -55,14 +55,14 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	 * caused by the non-atomic update of the address/data pair.
 	 *
 	 * Direct update is possible when:
-	 * - The MSI is maskable (remapped MSI does not use this code path)).
-	 *   The quirk bit is not set in this case.
+	 * - The MSI is maskable (remapped MSI does not use this code path).
+	 *   The reservation mode bit is set in this case.
 	 * - The new vector is the same as the old vector
 	 * - The old vector is MANAGED_IRQ_SHUTDOWN_VECTOR (interrupt starts up)
 	 * - The interrupt is not yet started up
 	 * - The new destination CPU is the same as the old destination CPU
 	 */
-	if (!irqd_msi_nomask_quirk(irqd) ||
+	if (!irqd_can_reserve(irqd) ||
 	    cfg->vector == old_cfg.vector ||
 	    old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
 	    !irqd_is_started(irqd) ||
@@ -215,8 +215,6 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
 		info->chip->irq_set_affinity = msi_set_affinity;
-		/* See msi_set_affinity() for the gory details */
-		info->flags |= MSI_FLAG_NOMASK_QUIRK;
 		break;
 	case DOMAIN_BUS_DMAR:
 	case DOMAIN_BUS_AMDVI:
diff --git a/include/linux/irq.h b/include/linux/irq.h
index d8a6fdce9373..90081afa10ce 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -215,8 +215,6 @@ struct irq_data {
  * IRQD_SINGLE_TARGET		- IRQ allows only a single affinity target
  * IRQD_DEFAULT_TRIGGER_SET	- Expected trigger already been set
  * IRQD_CAN_RESERVE		- Can use reservation mode
- * IRQD_MSI_NOMASK_QUIRK	- Non-maskable MSI quirk for affinity change
- *				  required
  * IRQD_HANDLE_ENFORCE_IRQCTX	- Enforce that handle_irq_*() is only invoked
  *				  from actual interrupt context.
  * IRQD_AFFINITY_ON_ACTIVATE	- Affinity is set on activation. Don't call
@@ -247,11 +245,10 @@ enum {
 	IRQD_SINGLE_TARGET		= BIT(24),
 	IRQD_DEFAULT_TRIGGER_SET	= BIT(25),
 	IRQD_CAN_RESERVE		= BIT(26),
-	IRQD_MSI_NOMASK_QUIRK		= BIT(27),
-	IRQD_HANDLE_ENFORCE_IRQCTX	= BIT(28),
-	IRQD_AFFINITY_ON_ACTIVATE	= BIT(29),
-	IRQD_IRQ_ENABLED_ON_SUSPEND	= BIT(30),
-	IRQD_RESEND_WHEN_IN_PROGRESS    = BIT(31),
+	IRQD_HANDLE_ENFORCE_IRQCTX	= BIT(27),
+	IRQD_AFFINITY_ON_ACTIVATE	= BIT(28),
+	IRQD_IRQ_ENABLED_ON_SUSPEND	= BIT(29),
+	IRQD_RESEND_WHEN_IN_PROGRESS    = BIT(30),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -426,21 +423,6 @@ static inline bool irqd_can_reserve(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_CAN_RESERVE;
 }
 
-static inline void irqd_set_msi_nomask_quirk(struct irq_data *d)
-{
-	__irqd_to_state(d) |= IRQD_MSI_NOMASK_QUIRK;
-}
-
-static inline void irqd_clr_msi_nomask_quirk(struct irq_data *d)
-{
-	__irqd_to_state(d) &= ~IRQD_MSI_NOMASK_QUIRK;
-}
-
-static inline bool irqd_msi_nomask_quirk(struct irq_data *d)
-{
-	return __irqd_to_state(d) & IRQD_MSI_NOMASK_QUIRK;
-}
-
 static inline void irqd_set_affinity_on_activate(struct irq_data *d)
 {
 	__irqd_to_state(d) |= IRQD_AFFINITY_ON_ACTIVATE;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a50ea79522f8..ddace8c34dcf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -547,12 +547,6 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 5),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 6),
-	/*
-	 * Quirk to handle MSI implementations which do not provide
-	 * masking. Currently known to affect x86, but has to be partially
-	 * handled in the core MSI code.
-	 */
-	MSI_FLAG_NOMASK_QUIRK		= (1 << 7),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 5971a66be034..aae0402507ed 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -121,7 +121,6 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_AFFINITY_ON_ACTIVATE),
 	BIT_MASK_DESCR(IRQD_MANAGED_SHUTDOWN),
 	BIT_MASK_DESCR(IRQD_CAN_RESERVE),
-	BIT_MASK_DESCR(IRQD_MSI_NOMASK_QUIRK),
 
 	BIT_MASK_DESCR(IRQD_FORWARDED_TO_VCPU),
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b4c31a5c1147..79b4a58ba9c3 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1204,7 +1204,6 @@ static int msi_handle_pci_fail(struct irq_domain *domain, struct msi_desc *desc,
 
 #define VIRQ_CAN_RESERVE	0x01
 #define VIRQ_ACTIVATE		0x02
-#define VIRQ_NOMASK_QUIRK	0x04
 
 static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflags)
 {
@@ -1213,8 +1212,6 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
 
 	if (!(vflags & VIRQ_CAN_RESERVE)) {
 		irqd_clr_can_reserve(irqd);
-		if (vflags & VIRQ_NOMASK_QUIRK)
-			irqd_set_msi_nomask_quirk(irqd);
 
 		/*
 		 * If the interrupt is managed but no CPU is available to
@@ -1275,15 +1272,8 @@ static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain
 	 * Interrupt can use a reserved vector and will not occupy
 	 * a real device vector until the interrupt is requested.
 	 */
-	if (msi_check_reservation_mode(domain, info, dev)) {
+	if (msi_check_reservation_mode(domain, info, dev))
 		vflags |= VIRQ_CAN_RESERVE;
-		/*
-		 * MSI affinity setting requires a special quirk (X86) when
-		 * reservation mode is active.
-		 */
-		if (info->flags & MSI_FLAG_NOMASK_QUIRK)
-			vflags |= VIRQ_NOMASK_QUIRK;
-	}
 
 	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
 		if (!msi_desc_match(desc, MSI_DESC_NOTASSOCIATED))
-- 
2.41.0

