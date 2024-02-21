Return-Path: <linux-kernel+bounces-74148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96FB85D074
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D056B24FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB3B3A8E1;
	Wed, 21 Feb 2024 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQqOE/Th"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A63A8D5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496583; cv=none; b=ZIdI0iU1Ql7DunIsHDR12xRrksB6Nql4lb8pnsSY12qy2Wkgi7mcggwF4+sHMNF2B3BpeE65TP15IyhRKn8Ug0XLxood5rwLeEZx5j9DzJDrSu2y7FuXSuFt6DIt7B/JxdRGLNt1CwKBFjEAPrJeoEvnLXXHTbmCQlTAOARUdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496583; c=relaxed/simple;
	bh=9H+0wD64vs6HQOukoCGwNQOHxpC4eaU2vrDqWxBbEdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UuiZ4sjbXw32N7MuLcHqWhxDbBUGjf+MazsXTyTKT6RHuIYNblKUf4K+p/AuC5BAeaXEuZ/bxOjKx0Ai3AlSz/PjopkU/nOM5vdvsUlKEd6YQKEJcVuUQkmgZ1ZUEcZTnhzxKh0DfOk/wFgfXFjU3KCCFggst9aAdxu1M8MQMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQqOE/Th; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708496583; x=1740032583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9H+0wD64vs6HQOukoCGwNQOHxpC4eaU2vrDqWxBbEdw=;
  b=GQqOE/Th8vfVNh5Gora9M1tsxV3nZFjRSpdlLx6UyRSYKGUeEDkjFRnu
   aOFX3CTfUab3fFgMkBKoULqqzsMQZEnvx/Vech0K7F1GzG3sMmx8V+hw6
   ksU2duqw3kVTy+6ZAS/Not7IzOkULpt8qpYJU5+T0HoO6tEiash64ko+7
   35HXiqDxfub6ts/2vqtmRDwR5gOiQP1emHxWMkaNDSVQxiOOeo9S/Tk/O
   A6BCk0UkRpdaVfmtz0ltfWInajHxzhZhfiScPkICCa/miMjpROFWxvZld
   Px5pE87bcd4UVIzJbtISmHF+CI8tssVOJZBmVOY25U6QM4CHeV6Bv5Hq1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20073126"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="20073126"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9681289"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa004.jf.intel.com with ESMTP; 20 Feb 2024 22:22:59 -0800
From: Feng Tang <feng.tang@intel.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	paulmck@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>,
	Jin Wang <jin1.wang@intel.com>
Subject: [PATCH v6] clocksource: Scale the max retry number of watchdog read according to CPU numbers
Date: Wed, 21 Feb 2024 14:08:59 +0800
Message-Id: <20240221060859.1027450-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a bug on one 8-socket server that the TSC is wrongly marked
as 'unstable' and disabled during boot time (reproduce rate is about
every 120 rounds of reboot tests), with log:

    clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
    wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
    tsc: Marking TSC unstable due to clocksource watchdog
    TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
    sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
    clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
    clocksource: Switched to clocksource hpet

The reason is for platform with lots of CPU, there are sporadic big or
huge read latency of read watchog/clocksource during boot or when system
is under stress work load, and the frequency and maximum value of the
latency goes up with the increasing of CPU numbers. Current code already
has logic to detect and filter such high latency case by reading 3 times
of watchdog, and check the 2 deltas. Due to the randomness of the
latency, there is a low possibility situation that the first delta
(latency) is big, but the second delta is small and looks valid, which
can escape from the check, and there is a 'max_cswd_read_retries' for
retrying that check covering this case, whose default value is only 2
and may be not enough for machines with huge number of CPUs.

So scale and enlarge the max retry number according to CPU number to
better filter those latency noise for large systems, which has been
verified fine in 4 days reboot test on the 8-socket machine.

Also as suggested by Thomas, remove parameter 'max_cswd_read_retries'
which was originally introduced to cover this.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Tested-by: Jin Wang <jin1.wang@intel.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
Changelog:

    since v5:
      * Fix some coding format issue (Paul)
      * Add Reviewed-by tag from Paul

    since v4:
      * Add a helper function to be shared by different files (Paul)

    since v3:
      * Remove clocksource's module parameter 'max_cswd_read_retries' (Thomas)
      * Use "ilog4" instead of ilog2 for max retry calculation, and
        may be adjusted later (Paul)

    since v2:
      * Fix the unexported symbol of helper function being used by
        kernel module issue (Waiman)

    since v1:
      * Add santity check for user input value of 'max_cswd_read_retries'
        and a helper function for getting max retry nubmer (Paul)
      * Apply the same logic to watchdog test code (Waiman)

 Documentation/admin-guide/kernel-parameters.txt   |  6 ------
 include/linux/clocksource.h                       | 13 ++++++++++++-
 kernel/time/clocksource-wdtest.c                  | 13 +++++++------
 kernel/time/clocksource.c                         |  9 ++++-----
 tools/testing/selftests/rcutorture/bin/torture.sh |  2 +-
 5 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..763e96dcf8b1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -679,12 +679,6 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clocksource.max_cswd_read_retries= [KNL]
-			Number of clocksource_watchdog() retries due to
-			external delays before the clock will be marked
-			unstable.  Defaults to two retries, that is,
-			three attempts to read the clock under test.
-
 	clocksource.verify_n_cpus= [KNL]
 			Limit the number of CPUs checked for clocksources
 			marked with CLOCK_SOURCE_VERIFY_PERCPU that
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b17327..dbf8cc8aaf6a 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -291,7 +291,18 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
-extern ulong max_cswd_read_retries;
+static inline int clocksource_get_max_watchdog_retry(void)
+{
+	/*
+	 * When system is in boot phase or under heavy workload, there could
+	 * be random big latency during clocksource/watchdog read, so add
+	 * some retry to filter the noise latency. As the latency's frequency
+	 * and maximum value goes up with the CPU numbers relatively, chose
+	 * the max retry number according to CPU numbers.
+	 */
+	return (ilog2(num_online_cpus()) / 2 + 1);
+}
+
 void clocksource_verify_percpu(struct clocksource *cs);
 
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index df922f49d171..97eee2da4c1f 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -105,7 +105,7 @@ static int wdtest_func(void *arg)
 {
 	unsigned long j1, j2;
 	char *s;
-	int i;
+	int i, max_retries;
 
 	schedule_timeout_uninterruptible(holdoff * HZ);
 
@@ -139,18 +139,19 @@ static int wdtest_func(void *arg)
 	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
 
 	/* Verify tsc-like stability with various numbers of errors injected. */
-	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
-		if (i <= 1 && i < max_cswd_read_retries)
+	max_retries = clocksource_get_max_watchdog_retry();
+	for (i = 0; i <= max_retries + 1; i++) {
+		if (i <= 1 && i < max_retries)
 			s = "";
-		else if (i <= max_cswd_read_retries)
+		else if (i <= max_retries)
 			s = ", expect message";
 		else
 			s = ", expect clock skew";
-		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
+		pr_info("--- Watchdog with %dx error injection, %d retries%s.\n", i, max_retries, s);
 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
 		schedule_timeout_uninterruptible(2 * HZ);
 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
-		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
+		WARN_ON_ONCE((i <= max_retries) !=
 			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
 		wdtest_ktime_clocksource_reset();
 	}
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3052b1f1168e..733d04209950 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -210,9 +210,6 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-ulong max_cswd_read_retries = 2;
-module_param(max_cswd_read_retries, ulong, 0644);
-EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
@@ -227,8 +224,10 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 	unsigned int nretries;
 	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
+	int max_retries;
 
-	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
+	max_retries = clocksource_get_max_watchdog_retry();
+	for (nretries = 0; nretries <= max_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
@@ -240,7 +239,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_cswd_read_retries) {
+			if (nretries > 1 || nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index d5a0d8a33c27..bbac5f4b03d0 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -567,7 +567,7 @@ then
 	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-1" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1 tsc=watchdog"
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-2" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
 	# In case our work is already done...
-- 
2.34.1


