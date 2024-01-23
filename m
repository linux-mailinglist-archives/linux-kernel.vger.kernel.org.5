Return-Path: <linux-kernel+bounces-35236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D3838E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281D1286E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3955F54D;
	Tue, 23 Jan 2024 12:12:47 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F55EE86
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011967; cv=none; b=dqEACPZ9TV9NgPE2rc9pSdZG87AmrDBZv8YN4yYKYl/iqdm1OT6j5k/TTw5gAnIQrOevRGLorO8UpcDG1C5GAZUDF2qe3zfWSHpnhJM5XPIJl+IwPu9RYdqm7J/6qHvSD8slUJ5rdSuW+0hOZWxXCieq+hqdk1UdfKU0YsziQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011967; c=relaxed/simple;
	bh=APkNASydfGXYMRnXuI9Rfle0j1POhkAXYjwSdofzsBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVEZ4/83yxiglC9DPS/rEJV54Dk9d5+MzDIi6Yos0jmv1u1WyaRzsQVqfYlzk6vGiENnCtCLHhh2JOcr6JycepIjr/9z3Zb0x7yWjElnnXR2XH5qWKZ1b7eSJlDFL8lyQYVtY35w1JOCe5TGN2Zl52N/AEwO9E1sFjM7i4lEvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.CnxHG_1706011955;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.CnxHG_1706011955)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 20:12:36 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	tglx@linutronix.de,
	maz@kernel.org,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	Bitao Hu <yaoma@linux.alibaba.com>
Subject: [PATCH 3/3] watchdog/softlockup: add parameter to control the reporting of time-consuming hardirq
Date: Tue, 23 Jan 2024 20:12:23 +0800
Message-Id: <20240123121223.22318-4-yaoma@linux.alibaba.com>
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

To obtain a more accurate cause of softlockup, we use tracepoints to
measure the time of each hardirq, which may have some impact on
performance. A parameter could be added to allow users to enable
this feature on demand.

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
---
 kernel/watchdog.c | 51 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f347c5d8c5c1..314dfd301d8c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -303,6 +303,9 @@ unsigned int __read_mostly softlockup_panic =
 static bool softlockup_initialized __read_mostly;
 static u64 __read_mostly sample_period;
 
+static int __read_mostly softlockup_irqtrace;
+static bool softlockup_irqtrace_initialized __read_mostly;
+
 /* Timestamp taken after the last successful reschedule. */
 static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
 /* Timestamp of the last softlockup report. */
@@ -318,6 +321,13 @@ static int __init softlockup_panic_setup(char *str)
 }
 __setup("softlockup_panic=", softlockup_panic_setup);
 
+static int __init softlockup_irqtrace_setup(char *str)
+{
+	get_option(&str, &softlockup_irqtrace);
+	return 1;
+}
+__setup("softlockup_irqtrace=", softlockup_irqtrace_setup);
+
 static int __init nowatchdog_setup(char *str)
 {
 	watchdog_user_enabled = 0;
@@ -635,7 +645,7 @@ static void print_hardirq_time(void)
 	u64 start_time, now, a;
 	u32 period_us, i, b;
 
-	if (test_bit(SOFTLOCKUP_HARDIRQ, this_cpu_ptr(&softlockup_flags))) {
+	if (softlockup_irqtrace && test_bit(SOFTLOCKUP_HARDIRQ, this_cpu_ptr(&softlockup_flags))) {
 		start_time = __this_cpu_read(hardirq_start_time);
 		now = local_clock();
 		period_us = (now - start_time)/1000;
@@ -856,7 +866,10 @@ static void softlockup_stop_all(void)
 	if (!softlockup_initialized)
 		return;
 
-	unhook_hardirq_events();
+	if (softlockup_irqtrace_initialized) {
+		unhook_hardirq_events();
+		softlockup_irqtrace_initialized = false;
+	}
 
 	for_each_cpu(cpu, &watchdog_allowed_mask)
 		smp_call_on_cpu(cpu, softlockup_stop_fn, NULL, false);
@@ -874,7 +887,10 @@ static void softlockup_start_all(void)
 {
 	int cpu;
 
-	hook_hardirq_events();
+	if (softlockup_irqtrace && !softlockup_irqtrace_initialized) {
+		hook_hardirq_events();
+		softlockup_irqtrace_initialized = true;
+	}
 
 	cpumask_copy(&watchdog_allowed_mask, &watchdog_cpumask);
 	for_each_cpu(cpu, &watchdog_allowed_mask)
@@ -1090,6 +1106,26 @@ int proc_watchdog_thresh(struct ctl_table *table, int write,
 	return err;
 }
 
+/*
+ * /proc/sys/kernel/softlockup_irqtrace
+ */
+int proc_softlockup_irqtrace(struct ctl_table *table, int write,
+			 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int err, old;
+
+	mutex_lock(&watchdog_mutex);
+
+	old = READ_ONCE(softlockup_irqtrace);
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (!err && write && old != READ_ONCE(softlockup_irqtrace))
+		proc_watchdog_update();
+
+	mutex_unlock(&watchdog_mutex);
+	return err;
+}
+
 /*
  * The cpumask is the mask of possible cpus that the watchdog can run
  * on, not the mask of cpus it is actually running on.  This allows the
@@ -1158,6 +1194,15 @@ static struct ctl_table watchdog_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "softlockup_irqtrace",
+		.data		= &softlockup_irqtrace,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_softlockup_irqtrace,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #ifdef CONFIG_SMP
 	{
 		.procname	= "softlockup_all_cpu_backtrace",
-- 
2.37.1 (Apple Git-137.1)


