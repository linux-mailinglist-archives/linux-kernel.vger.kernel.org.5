Return-Path: <linux-kernel+bounces-32583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FFA835D81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B9D1F26786
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81D39852;
	Mon, 22 Jan 2024 09:00:05 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078938FAA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914004; cv=none; b=r0LVBhx8pP9XjMQfQvtwypaYZt28JBIFGUbfBbsrQe+MljEXFX9+6VvKOUZBcbjAEIzkQp7F0qgJMeG4HP52e9eI2XAeEi2sLcs0wSaF6LDp/KCnquXnt/L6HR6B3HmGqSroQrRm3iK2dc5PS0a5BHQ5/omt7KYCs2SdU2IP9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914004; c=relaxed/simple;
	bh=uxENKhOvRgNs7e0CFAgdfeJK75RGIjs6471T66UAAcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjEF53ATo3x7YpAGGYZuzbg4wbcXTw/pLzNIiRkQjIPX3GoCu8rBg7O9FrfoKaYYnLQKil930gMiB+QLF3qUu5lwAXf5OsI/VrhT3xBmsnnqMyl2t6YwymsLUqpkoLeXYTLZSBlh8gcYR6VeUBOjM1Ck2m+7r2u3RGja0scnsqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp78t1705913974t57cu8k8
X-QQ-Originating-IP: s/TlBuwIYZZTyK7aGHMX5P4SXDcbXIo8PDZLExa747k=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jan 2024 16:59:33 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: XBN7tc9DADK7QBXL2kByKL2tvBKd77LE3lWppuxmnlTTAGPJhU5/1Q2qHw60Y
	vIpo+KzaBtErcYPYaqZ5kMN9JoyroipuWSBY9bTq1MnBlHXOc4wj/7GCXFjQcbjnK656Ot+
	GOrqeCsTY8psboq1gwc7tlKlEERzJirpC9jBKJKAlcHAS1doAU9Agq7iimlBkrHbtWogeRP
	1WWUE4N0fKjo3z4MKkAfC23FHZM271cwYzdrLDfB7a2PWtAffqjoQwYkTIJIKG46JF2yvDr
	QAjkU8yYTmCVPxDGhcHe7rV2/JhTzeNWFsLUv7JTlicTn9tDf2mLvINCbdfUcSMucSbuR5E
	cKj5IIixcjoz7fGFWh1TxrE+JWWJaRNErJUhT5zPtCV1ganS8EMW8dZKObTBFL8vDelCtVH
	PqsVCfytt640sX5QmlZfYA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6969862050616083631
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com
Subject: [PATCH v2 5/5] genirq: Introduce generic init_desc()
Date: Mon, 22 Jan 2024 16:57:16 +0800
Message-Id: <20240122085716.2999875-6-dawei.li@shingroup.cn>
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

Those two functions below share much duplicated codes for
initialization for irq_desc:
- alloc_desc() CONFIG_SPARSE_IRQ
- early_irq_init() !CONFIG_SPARSE_IRQ

Implement a dedicated function to fully initialize irq_desc.

Also, make free_masks() global to implement exception handling in
early_irq_init.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 kernel/irq/irqdesc.c | 112 ++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 371eb1711d34..4c6b32318ce3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -92,11 +92,23 @@ static void desc_smp_init(struct irq_desc *desc, int node,
 #endif
 }
 
+static void free_masks(struct irq_desc *desc)
+{
+#ifdef CONFIG_GENERIC_PENDING_IRQ
+	free_cpumask_var(desc->pending_mask);
+#endif
+	free_cpumask_var(desc->irq_common_data.affinity);
+#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	free_cpumask_var(desc->irq_common_data.effective_affinity);
+#endif
+}
+
 #else
 static inline int
 alloc_masks(struct irq_desc *desc, int node) { return 0; }
 static inline void
 desc_smp_init(struct irq_desc *desc, int node, const struct cpumask *affinity) { }
+static inline void free_masks(struct irq_desc *desc) { }
 #endif
 
 static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
@@ -165,6 +177,39 @@ static void delete_irq_desc(unsigned int irq)
 	mas_erase(&mas);
 }
 
+#ifdef CONFIG_SPARSE_IRQ
+static const struct kobj_type irq_kobj_type;
+#endif
+
+static int init_desc(struct irq_desc *desc, int irq, int node,
+		     unsigned int flags,
+		     const struct cpumask *affinity,
+		     struct module *owner)
+{
+	desc->kstat_irqs = alloc_percpu(unsigned int);
+	if (!desc->kstat_irqs)
+		return -ENOMEM;
+
+	if (alloc_masks(desc, node)) {
+		free_percpu(desc->kstat_irqs);
+		return -ENOMEM;
+	}
+
+	raw_spin_lock_init(&desc->lock);
+	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
+	mutex_init(&desc->request_mutex);
+	init_waitqueue_head(&desc->wait_for_threads);
+	desc_set_defaults(irq, desc, node, affinity, owner);
+	irqd_set(&desc->irq_data, flags);
+	irq_resend_init(desc);
+#ifdef CONFIG_SPARSE_IRQ
+	kobject_init(&desc->kobj, &irq_kobj_type);
+	init_rcu_head(&desc->rcu);
+#endif
+
+	return 0;
+}
+
 #ifdef CONFIG_SPARSE_IRQ
 
 static void irq_kobj_release(struct kobject *kobj);
@@ -384,21 +429,6 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 EXPORT_SYMBOL_GPL(irq_to_desc);
 #endif
 
-#ifdef CONFIG_SMP
-static void free_masks(struct irq_desc *desc)
-{
-#ifdef CONFIG_GENERIC_PENDING_IRQ
-	free_cpumask_var(desc->pending_mask);
-#endif
-	free_cpumask_var(desc->irq_common_data.affinity);
-#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
-	free_cpumask_var(desc->irq_common_data.effective_affinity);
-#endif
-}
-#else
-static inline void free_masks(struct irq_desc *desc) { }
-#endif
-
 void irq_lock_sparse(void)
 {
 	mutex_lock(&sparse_irq_lock);
@@ -414,36 +444,19 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 				   struct module *owner)
 {
 	struct irq_desc *desc;
+	int ret;
 
 	desc = kzalloc_node(sizeof(*desc), GFP_KERNEL, node);
 	if (!desc)
 		return NULL;
-	/* allocate based on nr_cpu_ids */
-	desc->kstat_irqs = alloc_percpu(unsigned int);
-	if (!desc->kstat_irqs)
-		goto err_desc;
-
-	if (alloc_masks(desc, node))
-		goto err_kstat;
 
-	raw_spin_lock_init(&desc->lock);
-	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
-	mutex_init(&desc->request_mutex);
-	init_rcu_head(&desc->rcu);
-	init_waitqueue_head(&desc->wait_for_threads);
-
-	desc_set_defaults(irq, desc, node, affinity, owner);
-	irqd_set(&desc->irq_data, flags);
-	kobject_init(&desc->kobj, &irq_kobj_type);
-	irq_resend_init(desc);
+	ret = init_desc(desc, irq, node, flags, affinity, owner);
+	if (unlikely(ret)) {
+		kfree(desc);
+		return NULL;
+	}
 
 	return desc;
-
-err_kstat:
-	free_percpu(desc->kstat_irqs);
-err_desc:
-	kfree(desc);
-	return NULL;
 }
 
 static void irq_kobj_release(struct kobject *kobj)
@@ -583,26 +596,29 @@ struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
 int __init early_irq_init(void)
 {
 	int count, i, node = first_online_node;
-	struct irq_desc *desc;
+	int ret;
 
 	init_irq_default_affinity();
 
 	printk(KERN_INFO "NR_IRQS: %d\n", NR_IRQS);
 
-	desc = irq_desc;
 	count = ARRAY_SIZE(irq_desc);
 
 	for (i = 0; i < count; i++) {
-		desc[i].kstat_irqs = alloc_percpu(unsigned int);
-		alloc_masks(&desc[i], node);
-		raw_spin_lock_init(&desc[i].lock);
-		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
-		mutex_init(&desc[i].request_mutex);
-		init_waitqueue_head(&desc[i].wait_for_threads);
-		desc_set_defaults(i, &desc[i], node, NULL, NULL);
-		irq_resend_init(&desc[i]);
+		ret = init_desc(irq_desc + i, i, node, 0, NULL, NULL);
+		if (unlikely(ret))
+			goto __free_desc_res;
 	}
+
 	return arch_early_irq_init();
+
+__free_desc_res:
+	while (--i >= 0) {
+		free_masks(irq_desc + i);
+		free_percpu(irq_desc[i].kstat_irqs);
+	}
+
+	return ret;
 }
 
 struct irq_desc *irq_to_desc(unsigned int irq)
-- 
2.27.0


