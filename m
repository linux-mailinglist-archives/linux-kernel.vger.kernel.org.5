Return-Path: <linux-kernel+bounces-93921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA8A8736F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34B31C20BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF579130E49;
	Wed,  6 Mar 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WZJ4BHXX"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1712FF88;
	Wed,  6 Mar 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729546; cv=none; b=cb0Pnt5T4kMBw0+VC0rPQPzF4LrC8FmjHHPf9VTV113FGKEOn8JsVittUJX4NXVXyo/UJKrAliH/cYv4NkdswC0QRk5ec6ewcNS8CHDJM4P2fJiHnS7GtrRx5TdSupgCInbD8MW7Mh2ZEWab10rCafBwRAbum5ObCaxivz0YutY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729546; c=relaxed/simple;
	bh=S0VSqiwmUSRs6IiqzRibQoLbgECPB6+uTGqfvokFpgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=miDuAH4HVoZfZMn802SS4JOEVQphDGQkTRSwF6Q+GO4lYVnK7TS+WjyZEb2VscdqSUa0+xMkJPiSPK5f2dqK8GPqARj+6YgeJHqVjXl4jvx6ZCdVEpVrLderzAHvF6ObqKKSpGLU79/Dte4HO/FNgUCCsMIp0mZKeWEaC4/X3qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WZJ4BHXX; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709729541; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2Ekl+y5dAw/6OpDua2h0TcGTP6uBwHJnkGvttLdykK8=;
	b=WZJ4BHXXCuCMcpzXRqBc3Fg7h9dWIddtUYefS8OQSsVtb2gaf3niC5mgF8aua0RiLPyD1uhVP0pfCXtQZ+vMk52y9yBh594BGFJGGAwuuw3fmSqJHrlICgsZjOtHtVAB7+ZCWxnwQJBLw2K2PVyIBRaE4h9NyHWBKXQWlnmIMs8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1xhgGd_1709729536;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W1xhgGd_1709729536)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 20:52:19 +0800
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
Subject: [PATCHv12 2/4] genirq: Avoid summation loops for /proc/interrupts
Date: Wed,  6 Mar 2024 20:52:06 +0800
Message-Id: <20240306125208.71803-3-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240306125208.71803-1-yaoma@linux.alibaba.com>
References: <20240306125208.71803-1-yaoma@linux.alibaba.com>
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
index 44e187763384..05498788ead5 100644
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


