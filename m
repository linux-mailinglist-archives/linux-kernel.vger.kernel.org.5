Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D337D8236
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbjJZMEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJZMEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:04:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD10691;
        Thu, 26 Oct 2023 05:04:07 -0700 (PDT)
Date:   Thu, 26 Oct 2023 12:04:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698321845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75yt6I5S+dx1l2t9baHrD6OIs12o/E6AueS2qpMjNzg=;
        b=LZLFRE0jvmikXtrGCu4+odxHULvtRrbFXHaeP2izgV46D/0Zfv+8CXQ5492QZp6yB+TlaD
        iyjZzxB4vf0JeLSQDABtvPA24vK32VFuE8+/+SirgdPKQmyFplzbDciDm4QcslKIMHPCod
        +hdc+nFOy82/brtviupobKfkp312NfREtAk9Ae9+ML/5wAYoDHCPk2zTdkFGjHkbY2owmk
        udchwBh/UCk21yeZ5MZsDwTuZcfltetn7+a2TczlsXkoqi4Ud7Cd8gqDJFCUJOHDVQrF+C
        svaUuHRS1el0x7h8tZfxl1kmbXcrrh074e9SRhBV66JRCAgnLoLGSKBS9/QLtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698321845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75yt6I5S+dx1l2t9baHrD6OIs12o/E6AueS2qpMjNzg=;
        b=zPTqvZBVZoW3b6MFyqXPk88B4wwSyL5PRgbO1pTIdAmYfTBOh7Q0cQQ16nKfrlaIPS1r60
        FQoKwT0jLzmncHBg==
From:   "tip-bot2 for Koichiro Den" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/msi: Fix misconfigured non-maskable MSI quirk
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Koichiro Den <den@valinux.co.jp>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231026032036.2462428-1-den@valinux.co.jp>
References: <20231026032036.2462428-1-den@valinux.co.jp>
MIME-Version: 1.0
Message-ID: <169832184467.3135.3758341198303844867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b56ebe7c896dc78b5865ec2c4b1dae3c93537517
Gitweb:        https://git.kernel.org/tip/b56ebe7c896dc78b5865ec2c4b1dae3c93537517
Author:        Koichiro Den <den@valinux.co.jp>
AuthorDate:    Thu, 26 Oct 2023 12:20:36 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Oct 2023 13:53:06 +02:00

x86/apic/msi: Fix misconfigured non-maskable MSI quirk

commit ef8dd01538ea ("genirq/msi: Make interrupt allocation less
convoluted"), reworked the code so that the x86 specific quirk for affinity
setting of non-maskable PCI/MSI interrupts is not longer activated if
necessary.

This could be solved by restoring the original logic in the core MSI code,
but after a deeper analysis it turned out that the quirk flag is not
required at all.

The quirk is only required when the PCI/MSI device cannot mask the MSI
interrupts, which in turn also prevents reservation mode from being enabled
for the affected interrupt.

This allows ot remove the NOMASK quirk bit completely as msi_set_affinity()
can instead check whether reservation mode is enabled for the interrupt,
which gives exactly the same answer.

Even in the momentary non-existing case that the reservation mode would be
not set for a maskable MSI interrupt this would not cause any harm as it
just would cause msi_set_affinity() to go needlessly through the
functionaly equivalent slow path, which works perfectly fine with maskable
interrupts as well.

Rework msi_set_affinity() to query the reservation mode and remove all
NOMASK quirk logic from the core code.

[ tglx: Massaged changelog ]

Fixes: ef8dd01538ea ("genirq/msi: Make interrupt allocation less convoluted")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231026032036.2462428-1-den@valinux.co.jp
---
 arch/x86/kernel/apic/msi.c |  8 +++-----
 include/linux/irq.h        | 26 ++++----------------------
 include/linux/msi.h        |  6 ------
 kernel/irq/debugfs.c       |  1 -
 kernel/irq/msi.c           | 12 +-----------
 5 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6b6b711..d9651f1 100644
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
index d8a6fdc..90081af 100644
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
index a50ea79..ddace8c 100644
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
index 5971a66..aae0402 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -121,7 +121,6 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_AFFINITY_ON_ACTIVATE),
 	BIT_MASK_DESCR(IRQD_MANAGED_SHUTDOWN),
 	BIT_MASK_DESCR(IRQD_CAN_RESERVE),
-	BIT_MASK_DESCR(IRQD_MSI_NOMASK_QUIRK),
 
 	BIT_MASK_DESCR(IRQD_FORWARDED_TO_VCPU),
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b4c31a5..79b4a58 100644
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
