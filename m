Return-Path: <linux-kernel+bounces-140009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF78A0A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212EFB2ADF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6051411C7;
	Thu, 11 Apr 2024 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UeqnWu2q"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B813FD71;
	Thu, 11 Apr 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821313; cv=none; b=YzxayG19z+zBmSZIN9w4KUp8nxbZ1VI5CN0OjmHlXCipQdYFkF3R3bziUgfYWKAziyIL1NKL030dJ+osKYjMZVMrKcT9xjgca7AYl65Bc7csUd04C2AgTxlWDXOkYGohaClAaUMVHNUlMQDF9tB3jUflx6g7dbCTG2RKFsAsD2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821313; c=relaxed/simple;
	bh=26AX6FbxiCSYyPBzCKKI+HNN6hEkh52RFtYiSfHMdx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbzQP/fhgXt7Nfjbls2paPL+LTbjIp3e5MDEBTeK25R/7ZEHzKiKHfGnq4rRsWRhaSasZl+p/pbRIvn7/dgH2ox8HsmYRpVrQhD7yMcyr5yR+GOz1fxFPHR4+sF+KZU06hMhnz8XFvyZc6qbfON4zua0oEqlYOr2SxZtuS/0NZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UeqnWu2q; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712821309; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tUtCoF0eyO9gScpPeW9H9/9ARpqG/SH0m0PV7EcoO1o=;
	b=UeqnWu2qr0eOPJOK4TYrHlc2VCpibp+vNx4pPoLnuxSuiTQy5ARfk89cbeq/kjFJLM8t7+9R6r3sJcQhWB7FvdD7z3EeAJv3UFYwrNvesYpC8BxtHi/GEYD49jtfCHpu667hwXAj9f+EuTdGYGp6A2s8U9fMvE35WMahvyI4NT8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W4KbQAN_1712821305;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W4KbQAN_1712821305)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 15:41:47 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	tglx@linutronix.de,
	liusong@linux.alibaba.com,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	deller@gmx.de,
	npiggin@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv13 3/5] genirq: Avoid summation loops for /proc/interrupts
Date: Thu, 11 Apr 2024 15:41:32 +0800
Message-Id: <20240411074134.30922-4-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240411074134.30922-1-yaoma@linux.alibaba.com>
References: <20240411074134.30922-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

show_interrupts() unconditionally accumulates the per CPU interrupt
statistics to determine whether an interrupt was ever raised.

This can be avoided for all interrupts which are not strictly per CPU
and not of type NMI because those interrupts provide already an
accumulated counter. The required logic is already implemented in
kstat_irqs().

Split the inner access logic out of kstat_irqs() and use it for
kstat_irqs() and show_interrupts() to avoid the accumulation loop
when possible.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
Reviewed-by: Liu Song <liusong@linux.alibaba.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/irq/internals.h |  2 ++
 kernel/irq/irqdesc.c   | 16 +++++++++++-----
 kernel/irq/proc.c      |  6 ++----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 1d92532c2aae..6c43ef3e7308 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -98,6 +98,8 @@ extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
 
+extern unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask);
+
 #ifdef CONFIG_SPARSE_IRQ
 static inline void irq_mark_irq(unsigned int irq) { }
 #else
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f348faffa7b4..382093196210 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -976,24 +976,30 @@ static bool irq_is_nmi(struct irq_desc *desc)
 	return desc->istate & IRQS_NMI;
 }
 
-static unsigned int kstat_irqs(unsigned int irq)
+unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned int sum = 0;
 	int cpu;
 
-	if (!desc || !desc->kstat_irqs)
-		return 0;
 	if (!irq_settings_is_per_cpu_devid(desc) &&
 	    !irq_settings_is_per_cpu(desc) &&
 	    !irq_is_nmi(desc))
 		return data_race(desc->tot_count);
 
-	for_each_possible_cpu(cpu)
+	for_each_cpu(cpu, cpumask)
 		sum += data_race(per_cpu(desc->kstat_irqs->cnt, cpu));
 	return sum;
 }
 
+static unsigned int kstat_irqs(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (!desc || !desc->kstat_irqs)
+		return 0;
+	return kstat_irqs_desc(desc, cpu_possible_mask);
+}
+
 #ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
 
 void kstat_snapshot_irqs(void)
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 6954e0a02047..5c320c3f10a7 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -488,10 +488,8 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
-	if (desc->kstat_irqs) {
-		for_each_online_cpu(j)
-			any_count |= data_race(per_cpu(desc->kstat_irqs->cnt, j));
-	}
+	if (desc->kstat_irqs)
+		any_count = kstat_irqs_desc(desc, cpu_online_mask);
 
 	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
 		goto outsparse;
-- 
2.37.1 (Apple Git-137.1)


