Return-Path: <linux-kernel+bounces-148194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2968A7EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650341C2149B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A312AAD9;
	Wed, 17 Apr 2024 08:56:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888128529D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344168; cv=none; b=p/NPdaIh92Fg2FdHfUCL7u1svL5ImIyOD8ovosCht4RbEsFvTHRypzkc9RRQV9MFB5FbQZYA7xVBtis4W76psmhxdZBX1sYYZwGF4yk6zLvKUadVMIqQ8sTOr13kI09NE21cA8A62t7XoGEud6Ji2nb4bcpU9xMDtcLvQ5L+QDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344168; c=relaxed/simple;
	bh=1yGbszGcRRJ9nQZSIzGMay1tYPtA2ul/RpguU0oQzKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jiz3huLLfNc/mBKT+w5oMYyY2J0ojeG+99JOdiw5sPFbSqrAWme1wPEKBqaM/OmxluZR/2YIvFBELHhVa9f09X04M4Hda1aJ4O+hBYbLkmK/6IssKkR2QZeYnX15abdWCaUYS+SX1IGjWx9OkBkucy5e30oCw0l4JGPCiYBBnYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VKF6M3glVzXlTT
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:52:43 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CE891800C3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:56:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 16:56:01 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] genirq: Reuse irq_is_nmi()
Date: Wed, 17 Apr 2024 16:56:16 +0800
Message-ID: <20240417085616.3785647-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)

Move irq_is_nmi() definition from irqdesc.c to internals.h, and reuse it
in manage.c and resend.c to simplify the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/internals.h |  5 +++++
 kernel/irq/irqdesc.c   |  5 -----
 kernel/irq/manage.c    | 16 ++++++++--------
 kernel/irq/resend.c    |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 6c43ef3e7308..35ab6771accd 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -280,6 +280,11 @@ static inline int irq_desc_is_chained(struct irq_desc *desc)
 	return (desc->action && desc->action == &chained_action);
 }
 
+static bool __maybe_unused irq_is_nmi(struct irq_desc *desc)
+{
+	return desc->istate & IRQS_NMI;
+}
+
 #ifdef CONFIG_PM_SLEEP
 bool irq_pm_check_wakeup(struct irq_desc *desc);
 void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 382093196210..5fd4499f649e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -971,11 +971,6 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
-static bool irq_is_nmi(struct irq_desc *desc)
-{
-	return desc->istate & IRQS_NMI;
-}
-
 unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask)
 {
 	unsigned int sum = 0;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index bf9ae8a8686f..f366e4e2af8c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -564,7 +564,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	/* The release function is promised process context */
 	might_sleep();
 
-	if (!desc || desc->istate & IRQS_NMI)
+	if (!desc || irq_is_nmi(desc))
 		return -EINVAL;
 
 	/* Complete initialisation of *notify */
@@ -898,7 +898,7 @@ int irq_set_irq_wake(unsigned int irq, unsigned int on)
 		return -EINVAL;
 
 	/* Don't use NMIs as wake up interrupts please */
-	if (desc->istate & IRQS_NMI) {
+	if (irq_is_nmi(desc)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -1624,7 +1624,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 */
 		unsigned int oldtype;
 
-		if (desc->istate & IRQS_NMI) {
+		if (irq_is_nmi(desc)) {
 			pr_err("Invalid attempt to share NMI for %s (irq %d) on irqchip %s.\n",
 				new->name, irq, desc->irq_data.chip->name);
 			ret = -EINVAL;
@@ -2082,7 +2082,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
 	unsigned long flags;
 	const void *devname;
 
-	if (!desc || WARN_ON(!(desc->istate & IRQS_NMI)))
+	if (!desc || WARN_ON(!irq_is_nmi(desc)))
 		return NULL;
 
 	if (WARN_ON(irq_settings_is_per_cpu_devid(desc)))
@@ -2548,7 +2548,7 @@ void free_percpu_nmi(unsigned int irq, void __percpu *dev_id)
 	if (!desc || !irq_settings_is_per_cpu_devid(desc))
 		return;
 
-	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+	if (WARN_ON(!irq_is_nmi(desc)))
 		return;
 
 	kfree(__free_percpu_irq(irq, dev_id));
@@ -2684,7 +2684,7 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 		return -EINVAL;
 
 	/* The line cannot already be NMI */
-	if (desc->istate & IRQS_NMI)
+	if (irq_is_nmi(desc))
 		return -EINVAL;
 
 	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
@@ -2745,7 +2745,7 @@ int prepare_percpu_nmi(unsigned int irq)
 	if (!desc)
 		return -EINVAL;
 
-	if (WARN(!(desc->istate & IRQS_NMI),
+	if (WARN(!irq_is_nmi(desc),
 		 KERN_ERR "prepare_percpu_nmi called for a non-NMI interrupt: irq %u\n",
 		 irq)) {
 		ret = -EINVAL;
@@ -2787,7 +2787,7 @@ void teardown_percpu_nmi(unsigned int irq)
 	if (!desc)
 		return;
 
-	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+	if (WARN_ON(!irq_is_nmi(desc)))
 		goto out;
 
 	irq_nmi_teardown(desc);
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 5f2c66860ac6..b07a2d732ffb 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -190,7 +190,7 @@ int irq_inject_interrupt(unsigned int irq)
 	 *  - not NMI type
 	 *  - activated
 	 */
-	if ((desc->istate & IRQS_NMI) || !irqd_is_activated(&desc->irq_data))
+	if (irq_is_nmi(desc) || !irqd_is_activated(&desc->irq_data))
 		err = -EINVAL;
 	else
 		err = check_irq_resend(desc, true);
-- 
2.34.1


