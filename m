Return-Path: <linux-kernel+bounces-42835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA27840777
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6E11C24648
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7C657BA;
	Mon, 29 Jan 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvEcwYMO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621A6657A7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536419; cv=none; b=lYueK+ysYC4M3/r8dxcRb7zIAIFhjAq9pX/JSVqNSynUo30+hUkUJOZ2dNBolAMiEr+G0z67kXjFKRqZY0Ahs5xEA1S3JgjyBbX2KiHxyLC54M3ZSHqIVrkPb6sy6F6iId0EFkdlvmgVxcWgfK8ulvx/EBQOd1s3OOJThDBY/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536419; c=relaxed/simple;
	bh=oul+8EboxPRMOmzDiRgdrl50CO3bLgpxsn1+vCbxHUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fTQoIXvPoLD46KnXVA6utVjCc0EPSJCWfxxXdnUKWzCcIeo4hslkfLvvyCVkrvxDu4Wj4QQAFChA/32UNxYLCxvAPIQoYml5ViBuiAzEl7Zw3qfcNirtW9AHdKeh7qt1RA0W8Juci+hpflHj+UVOcJ8MzI1UgWznGIbxCmPYj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvEcwYMO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706536417; x=1738072417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oul+8EboxPRMOmzDiRgdrl50CO3bLgpxsn1+vCbxHUY=;
  b=EvEcwYMOPzSUSeGBF6NdIVMio2W46ZWDfsH1evwMANldGUUswKTFAp8w
   99w7XoN1MRmDNeeZTD2SnT+kAmjNtn/1jB1aVWEmlM//QPyjp93nXmW4b
   CVwfHpV8uJzvSVIuNn8+s2krnJTioNWgSyGt7ria3fJpAkPBlmEIgj+C1
   lcSYSNS1+CxP7btDvtEmkM6eFXFlIK5ronEeWwW1pZZFkVldq/Ijvd88l
   gBffxP14zZGni1oBfNREwMiEb2xP8X/7bP2j5Qpn13fkduyXtbq0ifAdk
   2xIN2ox2OY/X9g2wrHeUfc86g2IYpwNMZMhEYb2Wv1lPnvv7wqROOLgIn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="1887228"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="1887228"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="821855385"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="821855385"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2024 05:53:33 -0800
From: Feng Tang <feng.tang@intel.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	paulmck@kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>,
	Jin Wang <jin1.wang@intel.com>
Subject: [PATCH v3] clocksource: Scale the max retry number of watchdog read according to CPU numbers
Date: Mon, 29 Jan 2024 21:45:05 +0800
Message-Id: <20240129134505.961208-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a bug on one 8-socket server that the TSC is wrongly marked as
'unstable' and disabled during boot time (reproduce rate is about every
120 rounds of reboot tests), with log:

    clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
    wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
    tsc: Marking TSC unstable due to clocksource watchdog
    TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
    sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
    clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
    clocksource: Switched to clocksource hpet

The reason is for platform with lots of CPU, there are sporadic big or huge
read latency of read watchog/clocksource during boot or when system is under
stress work load, and the frequency and maximum value of the latency goes up
with the increasing of CPU numbers. Current code already has logic to detect
and filter such high latency case by reading 3 times of watchdog, and check
the 2 deltas. Due to the randomness of the latency, there is a low possibility
situation that the first delta (latency) is big, but the second delta is small
and looks valid, which can escape from the check, and there is a
'max_cswd_read_retries' for retrying that check covering this case, whose
default value is only 2 and may be not enough for machines with huge number
of CPUs.

So scale and enlarge the max retry number according to CPU number to better
filter those latency noise for large systems, which has been verified fine
in 4 days and 670 rounds of reboot test on the 8-socket machine.

Also add sanity check for user input value for 'max_cswd_read_retries', make
it self-adaptive by default, and provide a general helper for getting this
max retry number as suggested by Paul and Waiman.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Tested-by: Jin Wang <jin1.wang@intel.com>
---
Changelog:

    since v2:
      * Fix the unexported symbol of helper function being used by
        kernel module issue (Waiman)

    since v1:
      * Add santity check for user input value of 'max_cswd_read_retries'
        and a helper function for getting max retry nubmer (Paul)
      * Apply the same logic to watchdog test code (Waiman)

 include/linux/clocksource.h      | 18 +++++++++++++++++-
 kernel/time/clocksource-wdtest.c | 12 +++++++-----
 kernel/time/clocksource.c        | 10 ++++++----
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b17327..0483f7dd66a3 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -291,7 +291,23 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
-extern ulong max_cswd_read_retries;
+extern long max_cswd_read_retries;
+
+static inline long clocksource_max_watchdog_read_retries(void)
+{
+	long max_retries = max_cswd_read_retries;
+
+	if (max_cswd_read_retries <= 0) {
+		/* santity check for user input value */
+		if (max_cswd_read_retries != -1)
+			pr_warn_once("max_cswd_read_retries was set with an invalid number: %ld\n",
+				max_cswd_read_retries);
+
+		max_retries = ilog2(num_online_cpus()) + 1;
+	}
+	return max_retries;
+}
+
 void clocksource_verify_percpu(struct clocksource *cs);
 
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index df922f49d171..c70cea3c44a1 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -106,6 +106,7 @@ static int wdtest_func(void *arg)
 	unsigned long j1, j2;
 	char *s;
 	int i;
+	long max_retries;
 
 	schedule_timeout_uninterruptible(holdoff * HZ);
 
@@ -139,18 +140,19 @@ static int wdtest_func(void *arg)
 	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
 
 	/* Verify tsc-like stability with various numbers of errors injected. */
-	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
-		if (i <= 1 && i < max_cswd_read_retries)
+	max_retries = clocksource_max_watchdog_read_retries();
+	for (i = 0; i <= max_retries + 1; i++) {
+		if (i <= 1 && i < max_retries)
 			s = "";
-		else if (i <= max_cswd_read_retries)
+		else if (i <= max_retries)
 			s = ", expect message";
 		else
 			s = ", expect clock skew";
-		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
+		pr_info("--- Watchdog with %dx error injection, %ld retries%s.\n", i, max_retries, s);
 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
 		schedule_timeout_uninterruptible(2 * HZ);
 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
-		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
+		WARN_ON_ONCE((i <= max_retries) !=
 			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
 		wdtest_ktime_clocksource_reset();
 	}
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..2e5a1d6c6712 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -208,8 +208,8 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-ulong max_cswd_read_retries = 2;
-module_param(max_cswd_read_retries, ulong, 0644);
+long max_cswd_read_retries = -1;
+module_param(max_cswd_read_retries, long, 0644);
 EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
@@ -225,8 +225,10 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 	unsigned int nretries;
 	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
+	long max_retries;
 
-	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
+	max_retries = clocksource_max_watchdog_read_retries();
+	for (nretries = 0; nretries <= max_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
@@ -238,7 +240,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_cswd_read_retries) {
+			if (nretries > 1 || nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
-- 
2.34.1


