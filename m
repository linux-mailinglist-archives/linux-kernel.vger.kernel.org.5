Return-Path: <linux-kernel+bounces-140010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA098A0A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4964282F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05321422DC;
	Thu, 11 Apr 2024 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oSNkF+21"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1611422BA;
	Thu, 11 Apr 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821318; cv=none; b=kfYopUupPiDNwZaamBxwqIDFpGXJ+XJNBCDPcgVUwWVC8fD5YJWqyt6SaPwu2u15JYs6J8SQRZNY6BKxTnpgjQ8WjrNDL+P8tik0OXS54blYr3YIGtioGbWhXdDjN80clGEWDj8TOX30flH2Bf/B8Lq7gopIzXQcgplvQtU3rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821318; c=relaxed/simple;
	bh=CeGUh5LtZ033F714wqexXvGK4L2PSTI/EXNqPvNW1fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwFreX20wffLJWibKJ1adc2d0NAy4AgC008mjeY3SvfF+lFTioUkSccXRlzDJo4IQd/W1FMM8E+C6hY898PtwK488nQyQoBeK0VR0sqFSV5oTqKX9kYisHEuOwM1t6hnpOJa+BmDMVVDIU+hCztaqaEy/EmN5bNSQZp3eHT//Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oSNkF+21; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712821314; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mk+s9eBdZfZCpexz66U97EPfuTe77mlB+c6S3kAOnRs=;
	b=oSNkF+21M2gaLMscH1soHAC0n8sVhWmJhWbOE5TclDpHoMRsUpzgQAYCtlSoBQsGJI28eZLSHDfJZuC9do69E0pQuCnjNthb7RVOzTtXiRS1sQHsnjOl1SNuWPLEJo/IS2Az+N0jE4thOemlySMMzvQ59GCYUMQaiIr+CtRymlA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W4KbQC1_1712821310;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W4KbQC1_1712821310)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 15:41:52 +0800
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
Subject: [PATCHv13 5/5] watchdog/softlockup: report the most frequent interrupts
Date: Thu, 11 Apr 2024 15:41:34 +0800
Message-Id: <20240411074134.30922-6-yaoma@linux.alibaba.com>
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

When the watchdog determines that the current soft lockup is due
to an interrupt storm based on CPU utilization, reporting the
most frequent interrupts could be good enough for further
troubleshooting.

Below is an example of interrupt storm. The call tree does not
provide useful information, but we can analyze which interrupt
caused the soft lockup by comparing the counts of interrupts.

[  638.870231] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [swapper/9:0]
[  638.870825] CPU#9 Utilization every 4s during lockup:
[  638.871194]  #1:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.871652]  #2:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.872107]  #3:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.872563]  #4:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.873018]  #5:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.873494] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardIRQs:
[  638.873994]  #1: 330945      irq#7
[  638.874236]  #2: 31          irq#82
[  638.874493]  #3: 10          irq#10
[  638.874744]  #4: 2           irq#89
[  638.874992]  #5: 1           irq#102
..
[  638.875313] Call trace:
[  638.875315]  __do_softirq+0xa8/0x364

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
Reviewed-by: Liu Song <liusong@linux.alibaba.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/watchdog.c | 116 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ef8ebd31fdab..d12ff74889ed 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -12,22 +12,25 @@
 
 #define pr_fmt(fmt) "watchdog: " fmt
 
-#include <linux/mm.h>
 #include <linux/cpu.h>
-#include <linux/nmi.h>
 #include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/kernel_stat.h>
+#include <linux/kvm_para.h>
 #include <linux/math64.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/nmi.h>
+#include <linux/stop_machine.h>
 #include <linux/sysctl.h>
 #include <linux/tick.h>
+
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
-#include <linux/stop_machine.h>
 
 #include <asm/irq_regs.h>
-#include <linux/kvm_para.h>
 
 static DEFINE_MUTEX(watchdog_mutex);
 
@@ -418,13 +421,105 @@ static void print_cpustat(void)
 	}
 }
 
+#define HARDIRQ_PERCENT_THRESH          50
+#define NUM_HARDIRQ_REPORT              5
+struct irq_counts {
+	int irq;
+	u32 counts;
+};
+
+static DEFINE_PER_CPU(bool, snapshot_taken);
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
+	u8 util;
+	int tail = __this_cpu_read(cpustat_tail);
+
+	tail = (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;
+	util = __this_cpu_read(cpustat_util[tail][STATS_HARDIRQ]);
+	return util > HARDIRQ_PERCENT_THRESH;
+}
+
+static void start_counting_irqs(void)
+{
+	if (!__this_cpu_read(snapshot_taken)) {
+		kstat_snapshot_irqs();
+		__this_cpu_write(snapshot_taken, true);
+	}
+}
+
+static void stop_counting_irqs(void)
+{
+	__this_cpu_write(snapshot_taken, false);
+}
+
+static void print_irq_counts(void)
+{
+	unsigned int i, count;
+	struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] = {
+		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0}, {-1, 0}
+	};
+
+	if (__this_cpu_read(snapshot_taken)) {
+		for_each_active_irq(i) {
+			count = kstat_get_irq_since_snapshot(i);
+			tabulate_irq_count(irq_counts_sorted, i, count, NUM_HARDIRQ_REPORT);
+		}
+
+		/*
+		 * Outputting the "watchdog" prefix on every line is redundant and not
+		 * concise, and the original alarm information is sufficient for
+		 * positioning in logs, hence here printk() is used instead of pr_crit().
+		 */
+		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent HardIRQs:\n",
+		       smp_processor_id(), HARDIRQ_PERCENT_THRESH);
+
+		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
+			if (irq_counts_sorted[i].irq == -1)
+				break;
+
+			printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
+			       i + 1, irq_counts_sorted[i].counts,
+			       irq_counts_sorted[i].irq);
+		}
+
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
@@ -528,6 +623,18 @@ static int is_softlockup(unsigned long touch_ts,
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
+		if (time_after_eq(now, period_ts + get_softlockup_thresh() / NUM_SAMPLE_PERIODS) &&
+		    need_counting_irqs())
+			start_counting_irqs();
+
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
@@ -550,6 +657,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
 static int softlockup_fn(void *data)
 {
 	update_touch_ts();
+	stop_counting_irqs();
 	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;
-- 
2.37.1 (Apple Git-137.1)


