Return-Path: <linux-kernel+bounces-34307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDBE8377DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A3D28AF23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B54E1D5;
	Mon, 22 Jan 2024 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zm0EaFva"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411304E1C3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967639; cv=none; b=pRh1/e+hqexVvuPOaG7/ztrQxWcrkqTFEYnohE9lDIoC6PwfSn8KYpuUu1bA6uHM4eHKDFdKYDbOOz3ul/+rwXKZFUUddWWXiRhLkpj94svFtwGmu/YJDIhWIzyU/t7fmpv2y6OyJCTabUynDZLGI58EYofRY/hEmQHI1MDivgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967639; c=relaxed/simple;
	bh=I2JgXNPMeGMxavWS8aMGzJJuatNDoTS3BQMtyG988+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNKd/sGvr/UHygMvQ23nq2f7Q/JN93BTzk2cSC0Sn3nQ2OQEYf0Zs+zVREgw98nn91xtrnWIegLQgAEeQ1GSsw0mt9hsk7CKNv0Xysnd5RBWNeW3BkvyoiNDJmMqsh0hk1p6OIaadswODEA4MmlVnCN4QtfWMWk9opi6PjDiZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zm0EaFva; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705967636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZdMfr1zH4AWolgc1fzOJd73MhYn44qEsLe77G8n65D8=;
	b=Zm0EaFvae/+oUWgojaVOD3ImbB+yGHOONBB9aLfXPMH1n8KT3wSKIiMH70awXVdk3lEJTt
	h2TwDmaLkpvQhjxGlMF6NnA1jyAymQuLw1bIX9+FHfX5FacSdA38iEwMpSISoq/BFwMjUn
	gvoJ7OX6U+PPxyQFjR8QAhVfVjXgQ6w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-CLRM5nPkMdeJn-JfSJ8mkg-1; Mon,
 22 Jan 2024 18:53:54 -0500
X-MC-Unique: CLRM5nPkMdeJn-JfSJ8mkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E1F11C03363;
	Mon, 22 Jan 2024 23:53:54 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 122DA40C106C;
	Mon, 22 Jan 2024 23:53:53 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Brent Roswell <browsell@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] genirq: Wake IRQ threads immediately when changing affinity
Date: Mon, 22 Jan 2024 17:53:53 -0600
Message-ID: <20240122235353.15235-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This avoids a situation where the IRQs are being migrated away from
an isolated cpu, but the migration does not happen until some arbitrary
time in the future, causing an isolation disruption.

Note that this is of the most benefit on systems where the IRQ affinity
itself does not need to be deferred to the IRQ handler, but even where
that's not the case, the total dirsuption will be less.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 kernel/irq/manage.c | 112 +++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 54 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1782f90cd8c6..9a8f2ecd575d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -192,10 +192,14 @@ void irq_set_thread_affinity(struct irq_desc *desc)
 	struct irqaction *action;
 
 	for_each_action_of_desc(desc, action) {
-		if (action->thread)
+		if (action->thread) {
 			set_bit(IRQTF_AFFINITY, &action->thread_flags);
-		if (action->secondary && action->secondary->thread)
+			wake_up_process(action->thread);
+		}
+		if (action->secondary && action->secondary->thread) {
 			set_bit(IRQTF_AFFINITY, &action->secondary->thread_flags);
+			wake_up_process(action->secondary->thread);
+		}
 	}
 }
 
@@ -1049,10 +1053,60 @@ static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int irq_wait_for_interrupt(struct irqaction *action)
+#ifdef CONFIG_SMP
+/*
+ * Check whether we need to change the affinity of the interrupt thread.
+ */
+static void
+irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
+{
+	cpumask_var_t mask;
+	bool valid = true;
+
+	if (!test_and_clear_bit(IRQTF_AFFINITY, &action->thread_flags))
+		return;
+
+	__set_current_state(TASK_RUNNING);
+
+	/*
+	 * In case we are out of memory we set IRQTF_AFFINITY again and
+	 * try again next time
+	 */
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
+		set_bit(IRQTF_AFFINITY, &action->thread_flags);
+		return;
+	}
+
+	raw_spin_lock_irq(&desc->lock);
+	/*
+	 * This code is triggered unconditionally. Check the affinity
+	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
+	 */
+	if (cpumask_available(desc->irq_common_data.affinity)) {
+		const struct cpumask *m;
+
+		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
+		cpumask_copy(mask, m);
+	} else {
+		valid = false;
+	}
+	raw_spin_unlock_irq(&desc->lock);
+
+	if (valid)
+		set_cpus_allowed_ptr(current, mask);
+	free_cpumask_var(mask);
+}
+#else
+static inline void
+irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
+#endif
+
+static int irq_wait_for_interrupt(struct irq_desc *desc,
+				  struct irqaction *action)
 {
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
+		irq_thread_check_affinity(desc, action);
 
 		if (kthread_should_stop()) {
 			/* may need to run one last time */
@@ -1129,52 +1183,6 @@ static void irq_finalize_oneshot(struct irq_desc *desc,
 	chip_bus_sync_unlock(desc);
 }
 
-#ifdef CONFIG_SMP
-/*
- * Check whether we need to change the affinity of the interrupt thread.
- */
-static void
-irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
-{
-	cpumask_var_t mask;
-	bool valid = true;
-
-	if (!test_and_clear_bit(IRQTF_AFFINITY, &action->thread_flags))
-		return;
-
-	/*
-	 * In case we are out of memory we set IRQTF_AFFINITY again and
-	 * try again next time
-	 */
-	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
-		set_bit(IRQTF_AFFINITY, &action->thread_flags);
-		return;
-	}
-
-	raw_spin_lock_irq(&desc->lock);
-	/*
-	 * This code is triggered unconditionally. Check the affinity
-	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
-	 */
-	if (cpumask_available(desc->irq_common_data.affinity)) {
-		const struct cpumask *m;
-
-		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
-		cpumask_copy(mask, m);
-	} else {
-		valid = false;
-	}
-	raw_spin_unlock_irq(&desc->lock);
-
-	if (valid)
-		set_cpus_allowed_ptr(current, mask);
-	free_cpumask_var(mask);
-}
-#else
-static inline void
-irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
-#endif
-
 /*
  * Interrupts which are not explicitly requested as threaded
  * interrupts rely on the implicit bh/preempt disable of the hard irq
@@ -1312,13 +1320,9 @@ static int irq_thread(void *data)
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, TWA_NONE);
 
-	irq_thread_check_affinity(desc, action);
-
-	while (!irq_wait_for_interrupt(action)) {
+	while (!irq_wait_for_interrupt(desc, action)) {
 		irqreturn_t action_ret;
 
-		irq_thread_check_affinity(desc, action);
-
 		action_ret = handler_fn(desc, action);
 		if (action_ret == IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
-- 
2.43.0


