Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846B77714FE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 14:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjHFMVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 08:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjHFMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 08:21:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C31AD;
        Sun,  6 Aug 2023 05:21:47 -0700 (PDT)
Date:   Sun, 06 Aug 2023 12:21:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691324505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfSMYfSgmRjB//hsoVUcI6kCslbgOhe5jp16BElxnK4=;
        b=ERa3eGxSbn7q+gQsWre+IEui1bjGSnDA8rZpYp0t0xxS6BNrfWkxJ8ZDwtIM2IySa8QaBV
        fstMORE6SbGeBX5pRwa0G/FwSNHQ3CpEWS8AjXxS9ZChp2Fne3yRe0nONUGlZN6g3UdZDQ
        fMARt+6Cm+xCGoUu/s4Jd0PX7qEXKazLPsMoyJ2rD46FToLB1CeNvXL3LHAsJjdjp+efmF
        hWqLX3CpX4OffAqLuRpivRrc0sHmBfPSlgJbU/HpfL2/9SH0VVYmS8ZaiG2otARtJX9C71
        OksxKfEsvMLMg1xSOibxCUbgvZwG2M87j6fuYZMo3iYZsASNmuk/KlRKjD4hxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691324505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfSMYfSgmRjB//hsoVUcI6kCslbgOhe5jp16BElxnK4=;
        b=Xfx8FMH8JU64Iq9hO+85h/HFJnIvJtufsp3Zy8l1diRM/EguYRGT2eqHqGe3DyG49RwzIK
        doFCbqtEP4A3KjCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/vector: Rename send_cleanup_vector() to
 vector_schedule_cleanup()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin3.li@intel.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230621171248.6805-2-xin3.li@intel.com>
References: <20230621171248.6805-2-xin3.li@intel.com>
MIME-Version: 1.0
Message-ID: <169132450527.28540.8350377154016039050.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     a539cc86a1cb688df24d9cff17d946a8c0b94b38
Gitweb:        https://git.kernel.org/tip/a539cc86a1cb688df24d9cff17d946a8c0b94b38
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Jun 2023 10:12:46 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 06 Aug 2023 14:15:09 +02:00

x86/vector: Rename send_cleanup_vector() to vector_schedule_cleanup()

Rename send_cleanup_vector() to vector_schedule_cleanup() to prepare for
replacing the vector cleanup IPI with a timer callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20230621171248.6805-2-xin3.li@intel.com

---
 arch/x86/include/asm/hw_irq.h       | 4 ++--
 arch/x86/kernel/apic/vector.c       | 8 ++++----
 arch/x86/platform/uv/uv_irq.c       | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 drivers/iommu/hyperv-iommu.c        | 4 ++--
 drivers/iommu/intel/irq_remapping.c | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index d465ece..5518298 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -97,10 +97,10 @@ extern struct irq_cfg *irqd_cfg(struct irq_data *irq_data);
 extern void lock_vector_lock(void);
 extern void unlock_vector_lock(void);
 #ifdef CONFIG_SMP
-extern void send_cleanup_vector(struct irq_cfg *);
+extern void vector_schedule_cleanup(struct irq_cfg *);
 extern void irq_complete_move(struct irq_cfg *cfg);
 #else
-static inline void send_cleanup_vector(struct irq_cfg *c) { }
+static inline void vector_schedule_cleanup(struct irq_cfg *c) { }
 static inline void irq_complete_move(struct irq_cfg *c) { }
 #endif
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index c1efebd..aa370bd 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -967,7 +967,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
 	raw_spin_unlock(&vector_lock);
 }
 
-static void __send_cleanup_vector(struct apic_chip_data *apicd)
+static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
 {
 	unsigned int cpu;
 
@@ -983,13 +983,13 @@ static void __send_cleanup_vector(struct apic_chip_data *apicd)
 	raw_spin_unlock(&vector_lock);
 }
 
-void send_cleanup_vector(struct irq_cfg *cfg)
+void vector_schedule_cleanup(struct irq_cfg *cfg)
 {
 	struct apic_chip_data *apicd;
 
 	apicd = container_of(cfg, struct apic_chip_data, hw_irq_cfg);
 	if (apicd->move_in_progress)
-		__send_cleanup_vector(apicd);
+		__vector_schedule_cleanup(apicd);
 }
 
 void irq_complete_move(struct irq_cfg *cfg)
@@ -1007,7 +1007,7 @@ void irq_complete_move(struct irq_cfg *cfg)
 	 * on the same CPU.
 	 */
 	if (apicd->cpu == smp_processor_id())
-		__send_cleanup_vector(apicd);
+		__vector_schedule_cleanup(apicd);
 }
 
 /*
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index ee21d6a..4221259 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -58,7 +58,7 @@ uv_set_irq_affinity(struct irq_data *data, const struct cpumask *mask,
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0) {
 		uv_program_mmr(cfg, data->chip_data);
-		send_cleanup_vector(cfg);
+		vector_schedule_cleanup(cfg);
 	}
 
 	return ret;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c3b58a8..7d7d379 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3681,7 +3681,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	 * at the new destination. So, time to cleanup the previous
 	 * vector allocation.
 	 */
-	send_cleanup_vector(cfg);
+	vector_schedule_cleanup(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8302db7..8a5c17b 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -51,7 +51,7 @@ static int hyperv_ir_set_affinity(struct irq_data *data,
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
 
-	send_cleanup_vector(cfg);
+	vector_schedule_cleanup(cfg);
 
 	return 0;
 }
@@ -257,7 +257,7 @@ static int hyperv_root_ir_set_affinity(struct irq_data *data,
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
 
-	send_cleanup_vector(cfg);
+	vector_schedule_cleanup(cfg);
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 08f5632..29b9e55 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1176,7 +1176,7 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 * at the new destination. So, time to cleanup the previous
 	 * vector allocation.
 	 */
-	send_cleanup_vector(cfg);
+	vector_schedule_cleanup(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
