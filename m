Return-Path: <linux-kernel+bounces-93920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC08736F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23580B21E88
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADE0130AFE;
	Wed,  6 Mar 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iczatmjV"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5712D1FC;
	Wed,  6 Mar 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729544; cv=none; b=mbvS6wNitj9LmNh49sjuYT5/Ls9lsH83vynB4pL/FksCg6hg2QEiw20gxA3cVg8w4daA4dKloi4ly0Qwmos06sguvW1p2VXmUkHrv5S2uOC3UTmtJCo8ClcoypMG1kSe+w1Kj1xguclr0J9zCJcJTK606FltL8TcM/xG8yoG0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729544; c=relaxed/simple;
	bh=X/avSXOKXFZJWi+FnKyFqR9pNv3dxuc2rI1Ji5Gba9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWHRj1MnKfrN2AHlgNAAxwbyjbNu22wMpWjuQgSO08VBgVQ+EgPmuZsyDkWfeuILdujO2jUsBDhKG8nTzx/Ik4bC/jjXCrzKEyhFBlBtAA3BE3BgETo6duTNGG/fy3kw8x9peaRj3zsBRG5JjSJO73Ctr55oQ+LLDd2asu3hKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iczatmjV; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709729538; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yvk9dddYVzfpGxh2vqdx8saM3Dmm+rcpArOPhAQtmMU=;
	b=iczatmjV6/+P/QP107s2KIhE822c4jPSSannZxYfUfndDvSXP8zN5Ytati00HnekFpfhwq8AXFbcWs0DMx7eZ3TbjQqiCfNdcj8uThX2nx7eJ8LGY2un5byTGw8wUlRB+LbgQ+GQsgQwX0iIDP6TgbIdb1aHEPIJPVvvv/XLz+U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1xhgFm_1709729534;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W1xhgFm_1709729534)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 20:52:16 +0800
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
Subject: [PATCHv12 1/4] genirq: Provide a snapshot mechanism for interrupt statistics
Date: Wed,  6 Mar 2024 20:52:05 +0800
Message-Id: <20240306125208.71803-2-yaoma@linux.alibaba.com>
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

The soft lockup detector lacks a mechanism to identify interrupt storms
as root cause of a lockup. To enable this the detector needs a
mechanism to snapshot the interrupt count statistics on a CPU when the
detector observes a potential lockup scenario and compare that against
the interrupt count when it warns about the lockup later on. The number
of interrupts in that period give a hint whether the lockup might be
caused by an interrupt storm.

Instead of having extra storage in the lockup detector and accessing
the internals of the interrupt descriptor directly, convert the per CPU
irq_desc::kstat_irq member to a data structure which contains the
counter plus a snapshot member and provide interfaces to take a
snapshot of all interrupts on the current CPU and to retrieve the delta
of a specific interrupt later on.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
Reviewed-by: Liu Song <liusong@linux.alibaba.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/mips/dec/setup.c                |  2 +-
 arch/parisc/kernel/smp.c             |  2 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c |  2 +-
 include/linux/irqdesc.h              | 16 ++++++++++--
 include/linux/kernel_stat.h          |  8 ++++++
 kernel/irq/Kconfig                   |  4 +++
 kernel/irq/internals.h               |  2 +-
 kernel/irq/irqdesc.c                 | 38 +++++++++++++++++++++++-----
 kernel/irq/proc.c                    |  5 ++--
 scripts/gdb/linux/interrupts.py      |  6 ++---
 10 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index 6c3704f51d0d..87f0a1436bf9 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -756,7 +756,7 @@ void __init arch_init_irq(void)
 				NULL))
 			pr_err("Failed to register fpu interrupt\n");
 		desc_fpu = irq_to_desc(irq_fpu);
-		fpu_kstat_irq = this_cpu_ptr(desc_fpu->kstat_irqs);
+		fpu_kstat_irq = this_cpu_ptr(&desc_fpu->kstat_irqs->cnt);
 	}
 	if (dec_interrupt[DEC_IRQ_CASCADE] >= 0) {
 		if (request_irq(dec_interrupt[DEC_IRQ_CASCADE], no_action,
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 444154271f23..800eb64e91ad 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -344,7 +344,7 @@ static int smp_boot_one_cpu(int cpuid, struct task_struct *idle)
 		struct irq_desc *desc = irq_to_desc(i);
 
 		if (desc && desc->kstat_irqs)
-			*per_cpu_ptr(desc->kstat_irqs, cpuid) = 0;
+			*per_cpu_ptr(desc->kstat_irqs, cpuid) = (struct irqstat) { };
 	}
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index e42984878503..f2636414d82a 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -837,7 +837,7 @@ static inline void this_cpu_inc_rm(unsigned int __percpu *addr)
  */
 static void kvmppc_rm_handle_irq_desc(struct irq_desc *desc)
 {
-	this_cpu_inc_rm(desc->kstat_irqs);
+	this_cpu_inc_rm(&desc->kstat_irqs->cnt);
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d9451d456a73..fd091c35d572 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -17,6 +17,18 @@ struct irq_desc;
 struct irq_domain;
 struct pt_regs;
 
+/**
+ * struct irqstat - interrupt statistics
+ * @cnt:	real-time interrupt count
+ * @ref:	snapshot of interrupt count
+ */
+struct irqstat {
+	unsigned int	cnt;
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+	unsigned int	ref;
+#endif
+};
+
 /**
  * struct irq_desc - interrupt descriptor
  * @irq_common_data:	per irq and chip data passed down to chip functions
@@ -55,7 +67,7 @@ struct pt_regs;
 struct irq_desc {
 	struct irq_common_data	irq_common_data;
 	struct irq_data		irq_data;
-	unsigned int __percpu	*kstat_irqs;
+	struct irqstat __percpu	*kstat_irqs;
 	irq_flow_handler_t	handle_irq;
 	struct irqaction	*action;	/* IRQ action list */
 	unsigned int		status_use_accessors;
@@ -119,7 +131,7 @@ extern struct irq_desc irq_desc[NR_IRQS];
 static inline unsigned int irq_desc_kstat_cpu(struct irq_desc *desc,
 					      unsigned int cpu)
 {
-	return desc->kstat_irqs ? *per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+	return desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
 static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9935f7ecbfb9..9c042c6384bb 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -79,6 +79,14 @@ static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
 	return sum;
 }
 
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+extern void kstat_snapshot_irqs(void);
+extern unsigned int kstat_get_irq_since_snapshot(unsigned int irq);
+#else
+static inline void kstat_snapshot_irqs(void) { }
+static inline unsigned int kstat_get_irq_since_snapshot(unsigned int irq) { return 0; }
+#endif
+
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 2531f3496ab6..529adb1f5859 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -108,6 +108,10 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
 config GENERIC_IRQ_RESERVATION_MODE
 	bool
 
+# Snapshot for interrupt statistics
+config GENERIC_IRQ_STAT_SNAPSHOT
+	bool
+
 # Support forced irq threading
 config IRQ_FORCED_THREADING
        bool
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bcc7f21db9ee..1d92532c2aae 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -258,7 +258,7 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
 
 static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
-	__this_cpu_inc(*desc->kstat_irqs);
+	__this_cpu_inc(desc->kstat_irqs->cnt);
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 27ca1c866f29..44e187763384 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -122,7 +122,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->name = NULL;
 	desc->owner = owner;
 	for_each_possible_cpu(cpu)
-		*per_cpu_ptr(desc->kstat_irqs, cpu) = 0;
+		*per_cpu_ptr(desc->kstat_irqs, cpu) = (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
 }
 
@@ -418,8 +418,8 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	desc = kzalloc_node(sizeof(*desc), GFP_KERNEL, node);
 	if (!desc)
 		return NULL;
-	/* allocate based on nr_cpu_ids */
-	desc->kstat_irqs = alloc_percpu(unsigned int);
+
+	desc->kstat_irqs = alloc_percpu(struct irqstat);
 	if (!desc->kstat_irqs)
 		goto err_desc;
 
@@ -593,7 +593,7 @@ int __init early_irq_init(void)
 	count = ARRAY_SIZE(irq_desc);
 
 	for (i = 0; i < count; i++) {
-		desc[i].kstat_irqs = alloc_percpu(unsigned int);
+		desc[i].kstat_irqs = alloc_percpu(struct irqstat);
 		alloc_masks(&desc[i], node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
@@ -952,8 +952,7 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	return desc && desc->kstat_irqs ?
-			*per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
 static bool irq_is_nmi(struct irq_desc *desc)
@@ -975,10 +974,35 @@ static unsigned int kstat_irqs(unsigned int irq)
 		return data_race(desc->tot_count);
 
 	for_each_possible_cpu(cpu)
-		sum += data_race(*per_cpu_ptr(desc->kstat_irqs, cpu));
+		sum += data_race(per_cpu(desc->kstat_irqs->cnt, cpu));
 	return sum;
 }
 
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+
+void kstat_snapshot_irqs(void)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	for_each_irq_desc(irq, desc) {
+		if (!desc->kstat_irqs)
+			continue;
+		this_cpu_write(desc->kstat_irqs->ref, this_cpu_read(desc->kstat_irqs->cnt));
+	}
+}
+
+unsigned int kstat_get_irq_since_snapshot(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (!desc || !desc->kstat_irqs)
+		return 0;
+	return this_cpu_read(desc->kstat_irqs->cnt) - this_cpu_read(desc->kstat_irqs->ref);
+}
+
+#endif
+
 /**
  * kstat_irqs_usr - Get the statistics for an interrupt from thread context
  * @irq:	The interrupt number
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b8136e9af..6954e0a02047 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -490,7 +490,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	if (desc->kstat_irqs) {
 		for_each_online_cpu(j)
-			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
+			any_count |= data_race(per_cpu(desc->kstat_irqs->cnt, j));
 	}
 
 	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
@@ -498,8 +498,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	seq_printf(p, "%*d: ", prec, i);
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ?
-					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
+		seq_printf(p, "%10u ", desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0);
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
diff --git a/scripts/gdb/linux/interrupts.py b/scripts/gdb/linux/interrupts.py
index ef478e273791..7e50f3b9dfad 100644
--- a/scripts/gdb/linux/interrupts.py
+++ b/scripts/gdb/linux/interrupts.py
@@ -37,7 +37,7 @@ def show_irq_desc(prec, irq):
     any_count = 0
     if desc['kstat_irqs']:
         for cpu in cpus.each_online_cpu():
-            any_count += cpus.per_cpu(desc['kstat_irqs'], cpu)
+            any_count += cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt']
 
     if (desc['action'] == 0 or irq_desc_is_chained(desc)) and any_count == 0:
         return text;
@@ -45,7 +45,7 @@ def show_irq_desc(prec, irq):
     text += "%*d: " % (prec, irq)
     for cpu in cpus.each_online_cpu():
         if desc['kstat_irqs']:
-            count = cpus.per_cpu(desc['kstat_irqs'], cpu)
+            count = cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt']
         else:
             count = 0
         text += "%10u" % (count)
@@ -177,7 +177,7 @@ def arm_common_show_interrupts(prec):
         if desc == 0:
             continue
         for cpu in cpus.each_online_cpu():
-            text += "%10u" % (cpus.per_cpu(desc['kstat_irqs'], cpu))
+            text += "%10u" % (cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt'])
         text += "      %s" % (ipi_types[ipi].string())
         text += "\n"
     return text
-- 
2.37.1 (Apple Git-137.1)


