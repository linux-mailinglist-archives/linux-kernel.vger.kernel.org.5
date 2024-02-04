Return-Path: <linux-kernel+bounces-51734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59EA848EAF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBC82834EE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5422F14;
	Sun,  4 Feb 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WgLKVMIH"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53C225CE
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058334; cv=none; b=V4X53O7FxLmz6X5DFn0mE2E7ANxqstIi/kKXiAhOF6cktKedBhyWn9/4Zrsvl5ZSKGSAq91g/R9J9lNnC30KOPiptHVL9b0pMTT1ZNRUb66yo9Nxcj1qHLAbz4k8tk14m6Jpkd4i9OwkxUm3IK0jHPQPJGeFQX9nJLTbJR3ryJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058334; c=relaxed/simple;
	bh=PpjR3JNFsu94eRPC0I0FRaYDU9qtDRW9Gc3g8HGzlGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfcGDJtKpmB+ULyMk/WO1hBd97yjWKBxldpwtOFl3A06oTaIAcpxXMEpZCX5btXoTlaDhOpSpSaiqGBdWhA0N86MEN5I4d1Vq0myexl2W5cF+XndB9gVtYYDhenm0IytQ6pxjdxA+nJkLLQ3dsDZ7JIbIu3ekdzI+7CDSHMgTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WgLKVMIH; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707058323; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yOA0NzOuc1AUqfK3IPzXejCHHxQBLRURGo2n3AMHuRI=;
	b=WgLKVMIHgY8h6ORMuJertkyHJD1H1B1WJQcS+6zZAeOncFKr9lkUPgfRBNT92rHrah2UB4wzgSthWE+D4yXmCfdnivUqQ8gLlK1AfHZsx3+KKlX0+sshw30TvMk0u0uCUaACmRa631EzZ/w8tP9oPoz4skgCe1phn5S+QRK6fDI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W00xOzy_1707058321;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W00xOzy_1707058321)
          by smtp.aliyun-inc.com;
          Sun, 04 Feb 2024 22:52:03 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv4 2/3] watchdog/softlockup: report the most frequent interrupts
Date: Sun,  4 Feb 2024 22:51:53 +0800
Message-Id: <20240204145154.11069-3-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240204145154.11069-1-yaoma@linux.alibaba.com>
References: <20240204145154.11069-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the watchdog determines that the current soft lockup is due
to an interrupt storm based on CPU utilization, reporting the
most frequent interrupts could be good enough for further
troubleshooting.

Below is an example of interrupt storm. The call tree does not
provide useful information, but we can analyze which interrupt
caused the soft lockup by comparing the counts of interrupts.

[ 2987.488075] watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [kworker/9:1:214]
[ 2987.488607] CPU#9 Utilization every 4s during lockup:
[ 2987.488941]  #1:   0% system,          0% softirq,   100% hardirq,     0% idle
[ 2987.489357]  #2:   0% system,          0% softirq,   100% hardirq,     0% idle
[ 2987.489771]  #3:   0% system,          0% softirq,   100% hardirq,     0% idle
[ 2987.490186]  #4:   0% system,          0% softirq,   100% hardirq,     0% idle
[ 2987.490601]  #5:   0% system,          0% softirq,   100% hardirq,     0% idle
[ 2987.491034] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardIRQs:
[ 2987.491493]  #1: 330985      irq#7(IPI)
[ 2987.491743]  #2: 5000        irq#10(arch_timer)
[ 2987.492039]  #3: 9           irq#91(nvme0q2)
[ 2987.492318]  #4: 3           irq#118(virtio1-output.12)
..
[ 2987.492728] Call trace:
[ 2987.492729]  __do_softirq+0xa8/0x364

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
---
 kernel/watchdog.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7b121e166b81..d31120c3e9d1 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -19,6 +19,9 @@
 #include <linux/kernel_stat.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/bitops.h>
 #include <linux/sysctl.h>
 #include <linux/tick.h>
 #include <linux/sched/clock.h>
@@ -412,13 +415,153 @@ static void print_cpustat(void)
 	}
 }
 
+#define HARDIRQ_PERCENT_THRESH		50
+#define NUM_HARDIRQ_REPORT		5
+static DECLARE_BITMAP(softlockup_hardirq_cpus, CONFIG_NR_CPUS);
+static DEFINE_PER_CPU(u32 *, hardirq_counts);
+static DEFINE_PER_CPU(int, actual_nr_irqs);
+struct irq_counts {
+	int irq;
+	u32 counts;
+};
+
+/* Tabulate the most frequent interrupts. */
+static void tabulate_irq_count(struct irq_counts *irq_counts, int irq, u32 counts, int rank)
+{
+	int i;
+	struct irq_counts new_count = {irq, counts};
+
+	for (i = 0; i < rank; i++) {
+		if (counts > irq_counts[i].counts)
+			swap(new_count, irq_counts[i]);
+	}
+}
+
+/*
+ * If the hardirq time exceeds HARDIRQ_PERCENT_THRESH% of the sample_period,
+ * then the cause of softlockup might be interrupt storm. In this case, it
+ * would be useful to start interrupt counting.
+ */
+static bool need_counting_irqs(void)
+{
+	int tail = __this_cpu_read(cpustat_tail);
+	u8 util;
+
+	tail = (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;
+	util = __this_cpu_read(cpustat_util[tail][STATS_HARDIRQ]);
+	return util > HARDIRQ_PERCENT_THRESH;
+}
+
+static void start_counting_irqs(void)
+{
+	int i;
+	u32 *counts = __this_cpu_read(hardirq_counts);
+	int cpu = smp_processor_id();
+	struct irq_desc *desc;
+
+	if (!test_bit(cpu, softlockup_hardirq_cpus)) {
+		/*
+		 * nr_irqs has the potential to grow at runtime. We should read
+		 * it and store locally to avoid array out-of-bounds access.
+		 */
+		__this_cpu_write(actual_nr_irqs, nr_irqs);
+		counts = kmalloc_array(__this_cpu_read(actual_nr_irqs),
+				       sizeof(u32),
+				       GFP_ATOMIC);
+		if (!counts)
+			return;
+		for (i = 0; i < __this_cpu_read(actual_nr_irqs); i++) {
+			desc = irq_to_desc(i);
+			if (!desc)
+				continue;
+			counts[i] = desc->kstat_irqs ?
+				*this_cpu_ptr(desc->kstat_irqs) : 0;
+		}
+		__this_cpu_write(hardirq_counts, counts);
+		set_bit(cpu, softlockup_hardirq_cpus);
+	}
+}
+
+static void stop_counting_irqs(void)
+{
+	u32 *counts = __this_cpu_read(hardirq_counts);
+	int cpu = smp_processor_id();
+
+	if (test_bit(cpu, softlockup_hardirq_cpus)) {
+		kfree(counts);
+		counts = NULL;
+		__this_cpu_write(hardirq_counts, counts);
+		clear_bit(cpu, softlockup_hardirq_cpus);
+	}
+}
+
+static void print_irq_counts(void)
+{
+	int i;
+	struct irq_desc *desc;
+	u32 counts_diff;
+	u32 *counts = __this_cpu_read(hardirq_counts);
+	int cpu = smp_processor_id();
+	struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] = {
+		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0},
+	};
+
+	if (test_bit(cpu, softlockup_hardirq_cpus)) {
+		for_each_irq_desc(i, desc) {
+			if (!desc)
+				continue;
+			/*
+			 * We need to bounds-check in case someone on a different CPU
+			 * expanded nr_irqs.
+			 */
+			if (i < __this_cpu_read(actual_nr_irqs))
+				counts_diff = desc->kstat_irqs ?
+					*this_cpu_ptr(desc->kstat_irqs) - counts[i] : 0;
+			else
+				counts_diff = desc->kstat_irqs ?
+					*this_cpu_ptr(desc->kstat_irqs) : 0;
+			tabulate_irq_count(irq_counts_sorted, i, counts_diff,
+					NUM_HARDIRQ_REPORT);
+		}
+		/*
+		 * We do not want the "watchdog: " prefix on every line,
+		 * hence we use "printk" instead of "pr_crit".
+		 */
+		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent HardIRQs:\n",
+			smp_processor_id(), HARDIRQ_PERCENT_THRESH);
+		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
+			if (irq_counts_sorted[i].irq == -1)
+				break;
+			desc = irq_to_desc(irq_counts_sorted[i].irq);
+			if (desc && desc->action)
+				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
+					i+1, irq_counts_sorted[i].counts,
+					irq_counts_sorted[i].irq, desc->action->name);
+			else
+				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
+					i+1, irq_counts_sorted[i].counts,
+					irq_counts_sorted[i].irq);
+		}
+		/*
+		 * If the hardirq time is less than HARDIRQ_PERCENT_THRESH% in the last
+		 * sample_period, then we suspect the interrupt storm might be subsiding.
+		 */
+		if (!need_counting_irqs())
+			stop_counting_irqs();
+	}
+}
+
 static void report_cpu_status(void)
 {
 	print_cpustat();
+	print_irq_counts();
 }
 #else
 static inline void update_cpustat(void) { }
 static inline void report_cpu_status(void) { }
+static inline bool need_counting_irqs(void) { return false; }
+static inline void start_counting_irqs(void) { }
+static inline void stop_counting_irqs(void) { }
 #endif
 
 /*
@@ -522,6 +665,18 @@ static int is_softlockup(unsigned long touch_ts,
 			 unsigned long now)
 {
 	if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
+		/*
+		 * If period_ts has not been updated during a sample_period, then
+		 * in the subsequent few sample_periods, period_ts might also not
+		 * be updated, which could indicate a potential softlockup. In
+		 * this case, if we suspect the cause of the potential softlockup
+		 * might be interrupt storm, then we need to count the interrupts
+		 * to find which interrupt is storming.
+		 */
+		if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5) &&
+		    need_counting_irqs())
+			start_counting_irqs();
+
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
@@ -544,6 +699,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
 static int softlockup_fn(void *data)
 {
 	update_touch_ts();
+	stop_counting_irqs();
 	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;
-- 
2.37.1 (Apple Git-137.1)


