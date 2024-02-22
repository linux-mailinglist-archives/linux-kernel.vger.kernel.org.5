Return-Path: <linux-kernel+bounces-76231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBC785F48A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F7C1C20AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A43F9CE;
	Thu, 22 Feb 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AyJOdF7V"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98A3F9C1;
	Thu, 22 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594490; cv=none; b=KYxE6Sb/ZyXnI1lEF5vJQSMJ4MB1MchqeOex15ICmzj2on6YHvTwPHVQsDEu1wDA/Lk3mnJXgludwyo0dgGVQxFgjhYFSlOOaIF8d0a14ek46DECHBMBETJrr63a+eXrXZYT+xVQrH4S7IYW3jHW+fPK+2nQ9aavjrcSmSK2hHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594490; c=relaxed/simple;
	bh=s3jX/7PDZ7vfVkkUOAkH51SWsGL9X5ZUmkXTV+oBWd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3TS4NDJQICSIVXOyfX4tQCofrKqHdPBmcZev1e57NhmOELyQDkrdV6WjTXyyErbmLIW73GSKhqReJFqCtt0y/9BaKPyMiiutwvQDEkJPMt8napJzmltPmDWufTIOfXxoWtXtJq7DjOrZw7Vl57DTvIVUrcNwwEQqfHfggPZXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AyJOdF7V; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708594478; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7JJ0QXPMFthAl0e6+d34WFhqp+ptYVo8gdYR9MmdKvI=;
	b=AyJOdF7Vdzj4PBjZgjh5orfYjkxfEZ2IO1z0W/sN9SCiyjDyE4HGNy4zaXrDicCGqct27cmfWaO/bTs28Ey0zhAnj/TfxR6dIrFSiEe57WXl17N/16fyrXd2jIDSfYmPZB6k5fywA18Efl3yjD7QzXEwzo8tK7KAJG9KhSmvPvM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W10inzx_1708594474;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W10inzx_1708594474)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 17:34:36 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	liusong@linux.alibaba.com,
	tglx@linutronix.de,
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
Subject: [PATCHv9 3/3] watchdog/softlockup: report the most frequent interrupts
Date: Thu, 22 Feb 2024 17:34:20 +0800
Message-Id: <20240222093420.13956-4-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240222093420.13956-1-yaoma@linux.alibaba.com>
References: <20240222093420.13956-1-yaoma@linux.alibaba.com>
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
---
 kernel/watchdog.c | 115 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 69e72d7e461d..c9d49ae8d045 100644
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
 
@@ -417,13 +420,104 @@ static void print_cpustat(void)
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
+		 * We do not want the "watchdog: " prefix on every line,
+		 * hence we use "printk" instead of "pr_crit".
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
@@ -527,6 +621,18 @@ static int is_softlockup(unsigned long touch_ts,
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
@@ -549,6 +655,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
 static int softlockup_fn(void *data)
 {
 	update_touch_ts();
+	stop_counting_irqs();
 	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;
-- 
2.37.1 (Apple Git-137.1)


