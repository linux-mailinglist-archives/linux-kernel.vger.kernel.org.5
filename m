Return-Path: <linux-kernel+bounces-46891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD858445DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491FD1F2A207
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2B112CDB7;
	Wed, 31 Jan 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PxfWgRyn"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84112C54F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721476; cv=none; b=C33Zzh8UAOTn07oVaJHxr6XiBEeEUF94vVOaIer8TdnSUQf6cBIah0Q6/jV1OPUSBwlU+k2/5p9VGaWo0tHdRFggYbVZGRdw3VY9JXo0M8CRH50Af9sxh58/ZKzH2t/k3bBXtYi5IuPWUYlXeDh5t2UTKCvoCaulLmy05ZiXlt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721476; c=relaxed/simple;
	bh=j8l9XSrCMY/1IIxTqf6hdLRHkve3xMP1HTEkYgXeYNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGJJNcMnC9aSCYUBHl0DQv6XH4tRUuYrm4F+i2QfAk6YlmVP3i/JEo+aqxb53631g/SD4zgODrCHTx7VsUWG690sVjlSBsRGIR6BqOVqoEod+rvrGntZsu8GNPL2Xz4inXNYsw8zUGTrly4imHdytzzgCoVNVZ3LFmJof8+hMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PxfWgRyn; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706721466; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=hPVe22NkRbyXcn0gpdzROaquleTwTL6gBnFaS965ewQ=;
	b=PxfWgRynTDO5RyqzMOUTMxxUj2YwvwocdxWT3N6u7AYp2ffAeTdnVb4X3VygKx5xz0w+hUkb39v1keD3tn1a0sD8XBlv8wzSFkdX44R4NdCeGdg2382rBusk+GH+MJ5n/HXhbvOq4Rn40oQEjz6DMZHQi1HGYMAGOyk9tiI1ykk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.kJfUc_1706721464;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.kJfUc_1706721464)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 01:17:46 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv3 1/2] watchdog/softlockup: low-overhead detection of interrupt storm
Date: Thu,  1 Feb 2024 01:17:37 +0800
Message-Id: <20240131171738.35496-2-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240131171738.35496-1-yaoma@linux.alibaba.com>
References: <20240131171738.35496-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following softlockup is caused by interrupt storm, but it cannot be
identified from the call tree. Because the call tree is just a snapshot
and doesn't fully capture the behavior of the CPU during the soft lockup.
  watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
  ...
  Call trace:
    __do_softirq+0xa0/0x37c
    __irq_exit_rcu+0x108/0x140
    irq_exit+0x14/0x20
    __handle_domain_irq+0x84/0xe0
    gic_handle_irq+0x80/0x108
    el0_irq_naked+0x50/0x58

Therefore，I think it is necessary to report CPU utilization during the
softlockup_thresh period (report once every sample_period, for a total
of 5 reportings), like this:
  watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
  CPU#28 Utilization every 4s during lockup:
    #1: 0% system, 0% softirq, 100% hardirq, 0% idle
    #2: 0% system, 0% softirq, 100% hardirq, 0% idle
    #3: 0% system, 0% softirq, 100% hardirq, 0% idle
    #4: 0% system, 0% softirq, 100% hardirq, 0% idle
    #5: 0% system, 0% softirq, 100% hardirq, 0% idle
  ...

This would be helpful in determining whether an interrupt storm has
occurred or in identifying the cause of the softlockup. The criteria for
determination are as follows:
  a. If the hardirq utilization is high, then interrupt storm should be
  considered and the root cause cannot be determined from the call tree.
  b. If the softirq utilization is high, then we could analyze the call
  tree but it may cannot reflect the root cause.
  c. If the system utilization is high, then we could analyze the root
  cause from the call tree.

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
---
 kernel/watchdog.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 81a8862295d6..046507be4eb5 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -23,6 +23,8 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
 #include <linux/stop_machine.h>
+#include <linux/kernel_stat.h>
+#include <linux/math64.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -441,6 +443,85 @@ static int is_softlockup(unsigned long touch_ts,
 	return 0;
 }
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+#define NUM_STATS_GROUPS	5
+enum stats_per_group {
+	STATS_SYSTEM,
+	STATS_SOFTIRQ,
+	STATS_HARDIRQ,
+	STATS_IDLE,
+	NUM_STATS_PER_GROUP,
+};
+static enum cpu_usage_stat stats[NUM_STATS_PER_GROUP] = {
+	CPUTIME_SYSTEM,
+	CPUTIME_SOFTIRQ,
+	CPUTIME_IRQ,
+	CPUTIME_IDLE,
+};
+static DEFINE_PER_CPU(u16, cpustat_old[NUM_STATS_PER_GROUP]);
+static DEFINE_PER_CPU(u8, cpustat_utilization[NUM_STATS_GROUPS][NUM_STATS_PER_GROUP]);
+static DEFINE_PER_CPU(u8, cpustat_tail);
+
+/*
+ * We don't need nanosecond resolution. A granularity of 16ms is
+ * sufficient for our precision, allowing us to use u16 to store
+ * cpustats, which will roll over roughly every ~1000 seconds.
+ * 2^24 ~= 16 * 10^6
+ */
+static u16 get_16bit_precision(u64 data)
+{
+	return data >> 24LL; /* 2^24ns ~= 16.8ms */
+}
+
+static void update_cpustat(void)
+{
+	u8 i;
+	u16 old;
+	u8 utilization;
+	u8 tail = __this_cpu_read(cpustat_tail);
+	struct kernel_cpustat kcpustat;
+	u64 *cpustat = kcpustat.cpustat;
+	u16 sample_period_ms = get_16bit_precision(sample_period);
+
+	kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
+	for (i = STATS_SYSTEM; i < NUM_STATS_PER_GROUP; i++) {
+		old = __this_cpu_read(cpustat_old[i]);
+		cpustat[stats[i]] = get_16bit_precision(cpustat[stats[i]]);
+		utilization = 100 * (u16)(cpustat[stats[i]] - old) / sample_period_ms;
+		__this_cpu_write(cpustat_utilization[tail][i], utilization);
+		__this_cpu_write(cpustat_old[i], cpustat[stats[i]]);
+	}
+	__this_cpu_write(cpustat_tail, (tail + 1) % NUM_STATS_GROUPS);
+}
+
+static void print_cpustat(void)
+{
+	u8 i, j;
+	u8 tail = __this_cpu_read(cpustat_tail);
+	u64 sample_period_second = sample_period;
+
+	do_div(sample_period_second, NSEC_PER_SEC);
+	/*
+	 * We do not want the "watchdog: " prefix on every line,
+	 * hence we use "printk" instead of "pr_crit".
+	 */
+	printk(KERN_CRIT "CPU#%d Utilization every %llus during lockup:\n",
+		smp_processor_id(), sample_period_second);
+	for (j = STATS_SYSTEM, i = tail; j < NUM_STATS_GROUPS;
+		j++, i = (i + 1) % NUM_STATS_GROUPS) {
+		printk(KERN_CRIT "\t#%d: %3u%% system,\t%3u%% softirq,\t"
+			"%3u%% hardirq,\t%3u%% idle\n", j+1,
+			__this_cpu_read(cpustat_utilization[i][STATS_SYSTEM]),
+			__this_cpu_read(cpustat_utilization[i][STATS_SOFTIRQ]),
+			__this_cpu_read(cpustat_utilization[i][STATS_HARDIRQ]),
+			__this_cpu_read(cpustat_utilization[i][STATS_IDLE]));
+	}
+}
+#else
+static inline void update_cpustat(void) { }
+static inline void print_cpustat(void) { }
+#endif
+
 /* watchdog detector functions */
 static DEFINE_PER_CPU(struct completion, softlockup_completion);
 static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
@@ -504,6 +585,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	 */
 	period_ts = READ_ONCE(*this_cpu_ptr(&watchdog_report_ts));
 
+	update_cpustat();
+
 	/* Reset the interval when touched by known problematic code. */
 	if (period_ts == SOFTLOCKUP_DELAY_REPORT) {
 		if (unlikely(__this_cpu_read(softlockup_touch_sync))) {
@@ -539,6 +622,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
+		print_cpustat();
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
-- 
2.37.1 (Apple Git-137.1)


