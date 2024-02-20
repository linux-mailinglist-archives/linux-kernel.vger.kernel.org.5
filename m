Return-Path: <linux-kernel+bounces-73280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6F85C06F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBACC1F22E25
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F7762E5;
	Tue, 20 Feb 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GR8WiPMh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E452C6AA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444627; cv=none; b=NeZf8UPu2sCBx2Ugkp+f48ymJwA+VtRXTm3SJb6ufj0X759ILl2OmEUIcys52IkTJJVnDfOXMjQLzVaZbzyl5NR9uL+g29JU0rZRea+hoByCJbazYRrAAJQqBrCsjX/5DjUd/YfyuA47BlLymya1oP7cwfAOg87Pvd7w3DadJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444627; c=relaxed/simple;
	bh=Bwe1QO9l+GtxBba7WsuK9HJ8YAbX9q8YPkmY27vB80Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jP4tnmCW0YFDiCnPC5Do3aJQqai9ivixSZdBoQnz2IEB4jBIk+DbFlqBdXC9CvP45fDxl6TGyhMrZ+Pf4NpzBOWoLIUTZJmCEAWRohKi8HovGYTk2td9kmnv6+FcUoW2DycvglEEQxIV7Bf7UnqHSEw4KaDksDe9p2fAL27/3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GR8WiPMh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708444625; x=1739980625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bwe1QO9l+GtxBba7WsuK9HJ8YAbX9q8YPkmY27vB80Y=;
  b=GR8WiPMhdvXciysfDoSyvQOBWpiA06Wu5Autjl0I6mk+afLzAgkRoyR4
   2J3eVHxSHQfyLIgsLQymqK4PxshvZWekHNnVIbSJaUhmQAXxDFpy/xrW1
   einXgoV/tE7AGK5tbP4uFTalDXjvtmV11y8/jii0olup7yg8FlYmlJZIm
   gLOKz7okF9ylAqu0X6XuKtT3SP1VjL+g2MKsDnHzkR7RrBEfTjz5ZazhH
   yfXjIq3PqLp2uqm/YEWjXAx1PxUcTN/9tyFdWkvV8oW4V66V5/a5en/By
   q/uJdlU4uUEAyLilE1uSIIIf4z5HMlyKp/NCkA0RdB1CMw6GZJcctn149
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2417188"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2417188"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 07:57:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="42307590"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa001.jf.intel.com with ESMTP; 20 Feb 2024 07:57:01 -0800
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
Subject: [PATCH v4] clocksource: Scale the max retry number of watchdog read according to CPU numbers
Date: Tue, 20 Feb 2024 23:43:02 +0800
Message-Id: <20240220154302.848412-1-feng.tang@intel.com>
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
---
 
Hi Paul, Waiman,

I keep your 'Tested-by' and 'Reviewed-by' tag for v3, as I think the
core logic of the patch isn't changed. Please let me know if you
think otherwise. thanks!

Changelog:

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


 Documentation/admin-guide/kernel-parameters.txt  |  6 ------
 include/linux/clocksource.h                      |  1 -
 kernel/time/clocksource-wdtest.c                 | 13 +++++++------
 kernel/time/clocksource.c                        | 16 +++++++++++-----
 .../testing/selftests/rcutorture/bin/torture.sh  |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

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
index 1d42d4b17327..b93f18270b5c 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -291,7 +291,6 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
-extern ulong max_cswd_read_retries;
 void clocksource_verify_percpu(struct clocksource *cs);
 
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index df922f49d171..d1025f956fab 100644
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
+	max_retries = ilog2(num_online_cpus()) / 2 + 1;
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
index 3052b1f1168e..9def0e39f43a 100644
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
 
@@ -227,8 +224,17 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 	unsigned int nretries;
 	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
+	int max_retries;
 
-	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
+	/*
+	 * When system is in boot phase or under heavy workload, there could
+	 * be random big latency during clocksource/watchdog read, so add
+	 * some retry to filter the noise latency. As the latency's frequency
+	 * and maximum value goes up with the CPU numbers relatively, chose
+	 * the max retry number according to CPU numbers.
+	 */
+	max_retries = ilog2(num_online_cpus()) / 2 + 1;
+	for (nretries = 0; nretries <= max_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
@@ -240,7 +246,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
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


