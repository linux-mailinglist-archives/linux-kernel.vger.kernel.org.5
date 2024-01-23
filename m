Return-Path: <linux-kernel+bounces-35237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB99838E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176FDB2239C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D0F5F555;
	Tue, 23 Jan 2024 12:12:47 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFA5EE81
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011967; cv=none; b=lvo36cBkjxxpPEeBornJhiVdFMv57Z3WpPUuQVmrcRHHeCr4c+Rcn8QY0/mtW0EZ+RSHqTiT11fQUH43f3VoJ92yvrGA8d49ADBaNd4EdbpiI6cgJLmM+e8Tg/dBne9vIpT07L3GZixA0hH/lRcBMF7Tw5WXIr2zsjTnuOPG2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011967; c=relaxed/simple;
	bh=Po7CzWHs2z5CKg+fb71m1ieZpQr7TiP52PT4BRY/dnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zb0W17a6prOC37KAophnepasWISRa+4fryizf/kUT4Qh2gsk/z0g4uAn8gB2H2FsUP4FFfQDrwFq+CZ7QM6j9TSiqDMd5qaf4mdMhhMeIEhfuph3lSj7ns8ISYx8QYxvZS2sM5KUWY1TFo0sA5DKb0uRP+9yq4vygYgLwFw+kDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.CnxGb_1706011953;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.CnxGb_1706011953)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 20:12:35 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	tglx@linutronix.de,
	maz@kernel.org,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	Bitao Hu <yaoma@linux.alibaba.com>
Subject: [PATCH 2/3] watchdog/softlockup: report the most time-consuming hardirq
Date: Tue, 23 Jan 2024 20:12:22 +0800
Message-Id: <20240123121223.22318-3-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240123121223.22318-1-yaoma@linux.alibaba.com>
References: <20240123121223.22318-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the watchdog determines that the current soft lockup is due
to an interrupt storm based on CPU utilization, reporting the
top three most time-consuming hardirq can be quite useful for
further troubleshooting.
Below is an example of interrupt storm. The call tree does not
provide useful information, but we can analyze which interrupt
caused the soft lockup by using the time-consuming information
of hardirq.

[   67.714044] watchdog: BUG: soft lockup - CPU#9 stuck for 28s! [swapper/9:0]
[   67.714548] CPU#9 Utilization every 4s during lockup:
[   67.714549]  #1: 0.0% system,        0.0% softirq,   95.0% hardirq,  0.0% idle
[   67.714551]  #2: 0.0% system,        0.0% softirq,   90.0% hardirq,  0.0% idle
[   67.714553]  #3: 0.0% system,        0.0% softirq,   90.0% hardirq,  0.0% idle
[   67.714555]  #4: 0.0% system,        0.0% softirq,   95.0% hardirq,  0.0% idle
[   67.714556]  #5: 0.0% system,        0.0% softirq,   90.0% hardirq,  0.0% idle
[   67.714570] CPU#9 Detect HardIRQ Time exceeds 50% since 45s. Most time-consuming HardIRQs:
[   67.714571]  #1: 99.9% irq#7(IPI)
[   67.714575]  #2: 0.0% irq#10(arch_timer)
[   67.714578]  #3: 0.0% irq#2(IPI)
..
[   67.714654] Call trace:
[   67.714656]  __do_softirq+0xa8/0x364

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
---
 include/linux/irq.h     |   9 ++
 include/linux/irqdesc.h |   2 +
 kernel/irq/irqdesc.c    |   9 +-
 kernel/watchdog.c       | 186 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 90081afa10ce..3a3e8b1e227e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -251,6 +251,15 @@ enum {
 	IRQD_RESEND_WHEN_IN_PROGRESS    = BIT(30),
 };
 
+
+/*
+ * struct per_irqtime - per irq stats for interrupt storm detection
+ */
+struct per_irqtime {
+	u64	start_time;
+	u64	delta;
+};
+
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
 
 static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d9451d456a73..c5407cdcf2d6 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -29,6 +29,7 @@ struct pt_regs;
  * @wake_depth:		enable depth, for multiple irq_set_irq_wake() callers
  * @tot_count:		stats field for non-percpu irqs
  * @irq_count:		stats field to detect stalled irqs
+ * @irq_time:		stats field to detect interrupt storm
  * @last_unhandled:	aging timer for unhandled count
  * @irqs_unhandled:	stats field for spurious unhandled interrupts
  * @threads_handled:	stats field for deferred spurious detection of threaded handlers
@@ -64,6 +65,7 @@ struct irq_desc {
 	unsigned int		wake_depth;	/* nested wake enables */
 	unsigned int		tot_count;
 	unsigned int		irq_count;	/* For detecting broken IRQs */
+	struct per_irqtime __percpu *irq_time;
 	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
 	unsigned int		irqs_unhandled;
 	atomic_t		threads_handled;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 27ca1c866f29..a4d7c324cba2 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -422,9 +422,12 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	desc->kstat_irqs = alloc_percpu(unsigned int);
 	if (!desc->kstat_irqs)
 		goto err_desc;
+	desc->irq_time = alloc_percpu(struct per_irqtime);
+	if (!desc->irq_time)
+		goto err_kstat;
 
 	if (alloc_masks(desc, node))
-		goto err_kstat;
+		goto err_irqtime;
 
 	raw_spin_lock_init(&desc->lock);
 	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
@@ -439,6 +442,8 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 
 	return desc;
 
+err_irqtime:
+	free_percpu(desc->irq_time);
 err_kstat:
 	free_percpu(desc->kstat_irqs);
 err_desc:
@@ -451,6 +456,7 @@ static void irq_kobj_release(struct kobject *kobj)
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
 
 	free_masks(desc);
+	free_percpu(desc->irq_time);
 	free_percpu(desc->kstat_irqs);
 	kfree(desc);
 }
@@ -594,6 +600,7 @@ int __init early_irq_init(void)
 
 	for (i = 0; i < count; i++) {
 		desc[i].kstat_irqs = alloc_percpu(unsigned int);
+		desc[i].irq_time = alloc_percpu(struct per_irqtime);
 		alloc_masks(&desc[i], node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9fad10e0a147..f347c5d8c5c1 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -25,6 +25,12 @@
 #include <linux/stop_machine.h>
 #include <linux/kernel_stat.h>
 #include <linux/math64.h>
+#include <linux/tracepoint.h>
+#include <linux/irq.h>
+#include <linux/bitops.h>
+#include <trace/events/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/timekeeping.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -431,11 +437,15 @@ void touch_softlockup_watchdog_sync(void)
 	__this_cpu_write(watchdog_report_ts, SOFTLOCKUP_DELAY_REPORT);
 }
 
+static void set_potential_softlockup(unsigned long now, unsigned long touch_ts);
+
 static int is_softlockup(unsigned long touch_ts,
 			 unsigned long period_ts,
 			 unsigned long now)
 {
 	if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
+		/* Softlockup may occur in the current period */
+		set_potential_softlockup(now, period_ts);
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
@@ -448,6 +458,8 @@ static DEFINE_PER_CPU(u64, cpustat_old[NR_STATS]);
 static DEFINE_PER_CPU(u64, cpustat_diff[5][NR_STATS]);
 static DEFINE_PER_CPU(int, cpustat_tail);
 
+static void print_hardirq_time(void);
+
 static void update_cpustat(void)
 {
 	u64 *old = this_cpu_ptr(cpustat_old);
@@ -489,10 +501,179 @@ static void print_cpustat(void)
 			a[i][CPUTIME_IRQ], b[i][CPUTIME_IRQ],
 			a[i][CPUTIME_IDLE], b[i][CPUTIME_IDLE]);
 	}
+	print_hardirq_time();
+}
+
+static DEFINE_PER_CPU(u64, hardirq_start_time);
+
+#define SOFTLOCKUP_HARDIRQ	0
+static DEFINE_PER_CPU(long, softlockup_flags);
+
+static void find_irqtime_top3(u64 *irqtime, int *irq, u64 perirq_time, int perirq_id)
+{
+	if (perirq_time > irqtime[0] || (perirq_time == irqtime[0] && perirq_id < irq[0])) {
+		irqtime[2] = irqtime[1];
+		irq[2] = irq[1];
+		irqtime[1] = irqtime[0];
+		irq[1] = irq[0];
+		irqtime[0] = perirq_time;
+		irq[0] = perirq_id;
+	} else if (perirq_time > irqtime[1] || (perirq_time == irqtime[1] && perirq_id < irq[1])) {
+		irqtime[2] = irqtime[1];
+		irq[2] = irq[1];
+		irqtime[1] = perirq_time;
+		irq[1] = perirq_id;
+	} else if (perirq_time > irqtime[1] || (perirq_time == irqtime[2] && perirq_id < irq[2])) {
+		irqtime[2] = perirq_time;
+		irq[2] = perirq_id;
+	}
+}
+
+/*
+ * If the proportion of time spent handling irq exceeds 50% during a sampling period,
+ * then it is necessary to tally the handling time of each irq.
+ */
+static inline bool need_trace_irqtime(int type)
+{
+	int tail = this_cpu_read(cpustat_tail);
+
+	if (--tail == -1)
+		tail = 4;
+	return this_cpu_read(cpustat_diff[tail][type]) > sample_period/2;
+}
+
+static void irq_handler_entry_callback(void *data, int irq, struct irqaction *action)
+{
+	this_cpu_ptr(irq_to_desc(irq)->irq_time)->start_time = local_clock();
+}
+
+static void irq_handler_exit_callback(void *data, int irq, struct irqaction *action, int ret)
+{
+	u64 delta;
+	struct per_irqtime *irq_time;
+
+	if (test_bit(SOFTLOCKUP_HARDIRQ, this_cpu_ptr(&softlockup_flags))) {
+		irq_time = this_cpu_ptr(irq_to_desc(irq)->irq_time);
+		delta = local_clock() - irq_time->start_time;
+		irq_time->delta += delta;
+	}
+}
+/*
+ * Mark softlockup as potentially caused by hardirq
+ */
+static void set_potential_softlockup_hardirq(void)
+{
+	if (!need_trace_irqtime(CPUTIME_IRQ))
+		return;
+
+	if (test_and_set_bit(SOFTLOCKUP_HARDIRQ, this_cpu_ptr(&softlockup_flags)))
+		return;
+
+	__this_cpu_write(hardirq_start_time, local_clock());
+}
+
+static void clear_potential_softlockup_hardirq(void)
+{
+	unsigned int i;
+	unsigned long flags;
+	struct irq_desc *desc;
+
+	local_irq_save(flags);
+	clear_bit(SOFTLOCKUP_HARDIRQ, this_cpu_ptr(&softlockup_flags));
+	for_each_irq_desc(i, desc) {
+		if (!desc)
+			continue;
+		memset(this_cpu_ptr(desc->irq_time), 0, sizeof(struct per_irqtime));
+	}
+	local_irq_restore(flags);
+}
+
+static void hook_hardirq_events(void)
+{
+	int ret;
+
+	ret = register_trace_irq_handler_entry(irq_handler_entry_callback, NULL);
+	if (ret)
+		goto out_err;
+	ret = register_trace_irq_handler_exit(irq_handler_exit_callback, NULL);
+	if (ret)
+		goto out_unreg_entry;
+	return;
+
+out_unreg_entry:
+	unregister_trace_irq_handler_entry(irq_handler_entry_callback, NULL);
+out_err:
+	return;
+}
+
+static void unhook_hardirq_events(void)
+{
+	unregister_trace_irq_handler_entry(irq_handler_entry_callback, NULL);
+	unregister_trace_irq_handler_exit(irq_handler_exit_callback, NULL);
 }
+
+/*
+ * Mark that softlockup may occur
+ */
+static void set_potential_softlockup(unsigned long now, unsigned long period_ts)
+{
+	if (time_after_eq(now, period_ts + get_softlockup_thresh()/5))
+		set_potential_softlockup_hardirq();
+}
+
+static void clear_potential_softlockup(void)
+{
+	clear_potential_softlockup_hardirq();
+}
+
+static void print_hardirq_time(void)
+{
+	struct per_irqtime *irq_time;
+	struct irq_desc *desc;
+	u64 hardirqtime_top3[3] = {0, 0, 0};
+	int hardirq_top3[3] = {-1, -1, -1};
+	u64 start_time, now, a;
+	u32 period_us, i, b;
+
+	if (test_bit(SOFTLOCKUP_HARDIRQ, this_cpu_ptr(&softlockup_flags))) {
+		start_time = __this_cpu_read(hardirq_start_time);
+		now = local_clock();
+		period_us = (now - start_time)/1000;
+		/* Find the top three most time-consuming interrupts */
+		for_each_irq_desc(i, desc) {
+			if (!desc)
+				continue;
+			irq_time = this_cpu_ptr(desc->irq_time);
+			find_irqtime_top3(hardirqtime_top3, hardirq_top3, irq_time->delta, i);
+		}
+		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds 50%% since %llds. Most time-consuming HardIRQs:\n",
+			smp_processor_id(), ns_to_timespec64(start_time - sample_period).tv_sec);
+		for (i = 0; i < 3; i++) {
+			if (hardirq_top3[i] == -1)
+				break;
+			a = 100 * (hardirqtime_top3[i] / 1000);
+			b = 10 * do_div(a, period_us);
+			do_div(b, period_us);
+			desc = irq_to_desc(hardirq_top3[i]);
+			if (desc && desc->action)
+				printk(KERN_CRIT "\t#%u: %llu.%u%% irq#%d(%s)\n",
+					i+1, a, b, hardirq_top3[i], desc->action->name);
+			else
+				printk(KERN_CRIT "\t#%u: %llu.%u%% irq#%d\n",
+				i+1, a, b, hardirq_top3[i]);
+		}
+		if (!need_trace_irqtime(CPUTIME_IRQ))
+			clear_potential_softlockup_hardirq();
+	}
+}
+
 #else
 static inline void update_cpustat(void) { }
 static inline void print_cpustat(void) { }
+static inline void set_potential_softlockup(unsigned long now, unsigned long period_ts) { }
+static inline void clear_potential_softlockup(void) { }
+static inline void hook_hardirq_events(void) { }
+static inline void unhook_hardirq_events(void) { }
 #endif
 
 /* watchdog detector functions */
@@ -510,6 +691,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
 static int softlockup_fn(void *data)
 {
 	update_touch_ts();
+	clear_potential_softlockup();
 	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;
@@ -674,6 +856,8 @@ static void softlockup_stop_all(void)
 	if (!softlockup_initialized)
 		return;
 
+	unhook_hardirq_events();
+
 	for_each_cpu(cpu, &watchdog_allowed_mask)
 		smp_call_on_cpu(cpu, softlockup_stop_fn, NULL, false);
 
@@ -690,6 +874,8 @@ static void softlockup_start_all(void)
 {
 	int cpu;
 
+	hook_hardirq_events();
+
 	cpumask_copy(&watchdog_allowed_mask, &watchdog_cpumask);
 	for_each_cpu(cpu, &watchdog_allowed_mask)
 		smp_call_on_cpu(cpu, softlockup_start_fn, NULL, false);
-- 
2.37.1 (Apple Git-137.1)


