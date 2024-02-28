Return-Path: <linux-kernel+bounces-84600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146286A8DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F391C22216
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E5B25610;
	Wed, 28 Feb 2024 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UHYmNUS/"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365825114;
	Wed, 28 Feb 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104960; cv=none; b=LbiyT1/65mik7D8Te9IdRwSoSMSl+AZzBbFOb4nZO0AYfs5H626Er3cY1tke+d2w7e1KOH4TqnHnAN8njqz16pmXJqeGMPLPaurxIwOkOKS+LgbCMgOm86ps2EGRuXST/duONLGmXVWM40vaa91QUyq+g/tq2rTg02pgNb4oJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104960; c=relaxed/simple;
	bh=1GTW3FB5egIhp784d5vJ5e2sJZgX2EBVdgdf8uBhCbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNe47nJvXHdbHxGnOKkvF2d0P5djT55ViXBLufXhuNxzU4PpxYJDuVwFwQMa5AvTF0woqBQ7NlEA1e/ChwDrASxnm3P5rAaAG7wLyw1fCFsBokYJ6k6p/vYMoRk8DmiOZEL9X7ndhG1bg/umv/mDOWGl4sAaC+m7WrZRHo/098s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UHYmNUS/; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709104955; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9Vrc4ZqyAkRdothl4QztDqs6565tXq6hqjh9jwKlxdo=;
	b=UHYmNUS/oueSipx0mgHMmMepjK0t3N2XEDrfldxH2l5lWDX49Q6q6TpAAmJrwU1qui/Lasq4SJHkXESU4PGz/ny6XgNtMs0W45NQ6prL9no+cvEXInq1nidwcrUjccgEsfGIMJ3vxFPzqtXyx/2KiVEO3yWL+s0kU7PzDWn4xR8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1P3Z5L_1709104949;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W1P3Z5L_1709104949)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 15:22:32 +0800
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
Subject: [PATCHv11 3/4] genirq: Avoid summation loops for /proc/interrupts
Date: Wed, 28 Feb 2024 15:22:15 +0800
Message-Id: <20240228072216.95130-4-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240228072216.95130-1-yaoma@linux.alibaba.com>
References: <20240228072216.95130-1-yaoma@linux.alibaba.com>
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
index 9cd17080b2d8..65a7f2dcd17b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -960,24 +960,30 @@ static bool irq_is_nmi(struct irq_desc *desc)
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
 void kstat_snapshot_irqs(void)
 {
 	struct irq_desc *desc;
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


