Return-Path: <linux-kernel+bounces-116579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F254E88A294
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB017B26667
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00113D51E;
	Mon, 25 Mar 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iusz8THA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AA16132B;
	Mon, 25 Mar 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348966; cv=none; b=gK2JwSk6GyYwVJ9S4Pb92Mox71mS1NyhR9m0kblJ4eDLhIYm6kVYDJWtJdhve7qcvUaqtyuu7ofEXgPVWEuiXXYPbSmJ6mg0q9pSiosuznYe8UPQZo8ij+MPAY4iGsnYtJ3cLScmn9tWEYfbwTEPvpzQUMwMF8XtYmelO7waH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348966; c=relaxed/simple;
	bh=jWLLlF4KdyRZzGfn4U2lSdQ4Wei7Cj+yXLsz+I6EvZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LE9FZcWd3irT9IPTb6zwdxVOrwrBSrf9nEwHBckP7kQimDWD9bVhpT5Ph+vvMDUeZsbOxOSoKU00Bu7Ds0FKlKWK1mhu10nZ16Z1gNfkOaqTreVELOE+ScKRSIrQSOAGwP6ru/hjFEuEqcHY63BV7mHkNBl2EujTjzooME7ZAbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iusz8THA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348965; x=1742884965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jWLLlF4KdyRZzGfn4U2lSdQ4Wei7Cj+yXLsz+I6EvZY=;
  b=Iusz8THA13pqubRw6kvkL5p5vNxVzykvnS/33uQZKIHDT+sb1IA3LO5W
   OqgjDeLnZvl/26QtHvzEliO4MDb+09t6wQm8fEFboF5kAPLoJT0mNBkPA
   Y3drThHz2EovOYR9Dx4xU9d1XlODfXO44aVF+ya3xqPSrh/Pv+3FyjmPN
   PykU0G74QD/wy7uaamV/+vSpJP1sRHWVPke0Oz6Lv7ckGvAzsf3E44uED
   jd1pJwNHD+9Ih+5c2RkTvIiTFcLY+tPyO2ilQCRUHNbzbhc+hFiV5JMcc
   Tpr3x3Jng+qxMTIpEaFugbo5lml35Xbt2Z1bH66mkH40gzU/xps9bBVT8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6191609"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6191609"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629719"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:38 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH V2 19/19] clocksource: Make watchdog and suspend-timing multiplication overflow safe
Date: Mon, 25 Mar 2024 08:40:23 +0200
Message-Id: <20240325064023.2997-20-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325064023.2997-1-adrian.hunter@intel.com>
References: <20240325064023.2997-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Kernel timekeeping is designed to keep the change in cycles (since the last
timer interrupt) below max_cycles, which prevents multiplication overflow
when converting cycles to nanoseconds. However, if timer interrupts stop,
the clocksource_cyc2ns() calculation will eventually overflow.

Add protection against that. Simplify by folding together
clocksource_delta() and clocksource_cyc2ns() into cycles_to_nsec_safe().
Check against max_cycles, falling back to a slower higher precision
calculation.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/clocksource.c | 42 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e5b260aa0e02..4d50d53ac719 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -20,6 +20,16 @@
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
 
+static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
+{
+	u64 delta = clocksource_delta(end, start, cs->mask);
+
+	if (likely(delta < cs->max_cycles))
+		return clocksource_cyc2ns(delta, cs->mult, cs->shift);
+
+	return mul_u64_u32_shr(delta, cs->mult, cs->shift);
+}
+
 /**
  * clocks_calc_mult_shift - calculate mult/shift factors for scaled math of clocks
  * @mult:	pointer to mult variable
@@ -222,8 +232,8 @@ enum wd_read_status {
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
 	unsigned int nretries, max_retries;
-	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
+	u64 wd_end, wd_end2;
 
 	max_retries = clocksource_get_max_watchdog_retry();
 	for (nretries = 0; nretries <= max_retries; nretries++) {
@@ -234,9 +244,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_end2 = watchdog->read(watchdog);
 		local_irq_enable();
 
-		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
-		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
-					      watchdog->shift);
+		wd_delay = cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
 			if (nretries > 1 || nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
@@ -254,8 +262,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		 * report system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
-		wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
-		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+		wd_seq_delay = cycles_to_nsec_safe(watchdog, wd_end, wd_end2);
 		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
 			goto skip_test;
 	}
@@ -366,8 +373,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		delta = (csnow_end - csnow_mid) & cs->mask;
 		if (delta < 0)
 			cpumask_set_cpu(cpu, &cpus_ahead);
-		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		cs_nsec = cycles_to_nsec_safe(cs, csnow_begin, csnow_end);
 		if (cs_nsec > cs_nsec_max)
 			cs_nsec_max = cs_nsec;
 		if (cs_nsec < cs_nsec_min)
@@ -398,8 +404,8 @@ static inline void clocksource_reset_watchdog(void)
 
 static void clocksource_watchdog(struct timer_list *unused)
 {
-	u64 csnow, wdnow, cslast, wdlast, delta;
 	int64_t wd_nsec, cs_nsec, interval;
+	u64 csnow, wdnow, cslast, wdlast;
 	int next_cpu, reset_pending;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
@@ -456,12 +462,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		delta = clocksource_delta(wdnow, cs->wd_last, watchdog->mask);
-		wd_nsec = clocksource_cyc2ns(delta, watchdog->mult,
-					     watchdog->shift);
-
-		delta = clocksource_delta(csnow, cs->cs_last, cs->mask);
-		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		wd_nsec = cycles_to_nsec_safe(watchdog, cs->wd_last, wdnow);
+		cs_nsec = cycles_to_nsec_safe(cs, cs->cs_last, csnow);
 		wdlast = cs->wd_last; /* save these in case we print them */
 		cslast = cs->cs_last;
 		cs->cs_last = csnow;
@@ -832,7 +834,7 @@ void clocksource_start_suspend_timing(struct clocksource *cs, u64 start_cycles)
  */
 u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
 {
-	u64 now, delta, nsec = 0;
+	u64 now, nsec = 0;
 
 	if (!suspend_clocksource)
 		return 0;
@@ -847,12 +849,8 @@ u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
 	else
 		now = suspend_clocksource->read(suspend_clocksource);
 
-	if (now > suspend_start) {
-		delta = clocksource_delta(now, suspend_start,
-					  suspend_clocksource->mask);
-		nsec = mul_u64_u32_shr(delta, suspend_clocksource->mult,
-				       suspend_clocksource->shift);
-	}
+	if (now > suspend_start)
+		nsec = cycles_to_nsec_safe(suspend_clocksource, suspend_start, now);
 
 	/*
 	 * Disable the suspend timer to save power if current clocksource is
-- 
2.34.1


