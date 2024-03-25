Return-Path: <linux-kernel+bounces-116582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151F88A0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE471C38080
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F921448E7;
	Mon, 25 Mar 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiUweDl0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E316088F;
	Mon, 25 Mar 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348955; cv=none; b=i4wDC2Jx0OO3S2jz4JiK1/Dy0evGhNBLVe+qkfDzFk6+IH8S122GKA5BhmDW/gn1t7gT/mmS4F0y7e881n/9Wq82NxcLAUeKV0v7dcCSukD4Mtw126ljOmD98Md5Q1DUTkwDkAdXQ2QDCTiRjuiGHWJ0H5M3lBSwnmz898jkdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348955; c=relaxed/simple;
	bh=xuu117cG1lowhe30UpLIG5BgAby+hnwaDFUtdrI4YDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DO7efubDDtCmzv8vv0d9QVQsTc1qBFUtSTjP2u673TWfIkf23EFAKLVlAl7eJyhSw1OUMsRPmrCK29THKtE+iVITZHBPQQ2Sjwjy/zbqPJZijuiaxRnCqO0q1SjxNSYHOlLT9CchuZtDukUKnmdSPjt7sUsErz5GdQSC0gOw8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiUweDl0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348954; x=1742884954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuu117cG1lowhe30UpLIG5BgAby+hnwaDFUtdrI4YDU=;
  b=fiUweDl0XiWKu+0t4CCWMTTtgAkXMgZU6DdRsN3cLJsNHyTzagWnBDLF
   AfS4B3AsskVYSr8T0xZcyPmm9ScQuUkX1tGa4KqHFY/82z2dD3cb4UVWS
   vg9ctU+f4x651PySsdVzNe0ZKComNZNg1KnmW/KxquUCjK35VMYRjIcuc
   3CnDV5C0//jww8kU0V0tz06F05QtJennssMva8F9IGWz+uhqRGYEEdl1T
   hx9uggZcnSg0ArEydwc+L1J6k9QT7MkgfStcEm9yv7NS9qxeiNuapn0z1
   35zjIIJDI7dBFNPIObb5JtVUCPez15sGNLIXe8fCnkxhzlekMKteFp/fG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6191576"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6191576"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629707"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:25 -0700
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
Subject: [PATCH V2 17/19] timekeeping: Make delta calculation overflow safe
Date: Mon, 25 Mar 2024 08:40:21 +0200
Message-Id: <20240325064023.2997-18-adrian.hunter@intel.com>
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
the calculation will eventually overflow.

Add protection against that. In timekeeping_cycles_to_ns() calculation,
check against max_cycles, falling back to a slower higher precision
calculation. In timekeeping_forward_now(), process delta in chunks of at
most max_cycles.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 40 ++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d17484082e2c..111dfdbd488f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -364,19 +364,32 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 }
 
 /* Timekeeper helper functions. */
+static noinline u64 delta_to_ns_safe(const struct tk_read_base *tkr, u64 delta)
+{
+	return mul_u64_u32_add_u64_shr(delta, tkr->mult, tkr->xtime_nsec, tkr->shift);
+}
+
 static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
 	/* Calculate the delta since the last update_wall_time() */
 	u64 mask = tkr->mask, delta = (cycles - tkr->cycle_last) & mask;
 
-	if (IS_ENABLED(CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE)) {
-		/*
-		 * Handle clocksource inconsistency between CPUs to prevent
-		 * time from going backwards by checking for the MSB of the
-		 * mask being set in the delta.
-		 */
-		if (unlikely(delta & ~(mask >> 1)))
-			return tkr->xtime_nsec >> tkr->shift;
+	/*
+	 * This detects the case where the delta overflows the multiplication
+	 * with tkr->mult.
+	 */
+	if (unlikely(delta > tkr->clock->max_cycles)) {
+		if (IS_ENABLED(CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE)) {
+			/*
+			 * Handle clocksource inconsistency between CPUs to prevent
+			 * time from going backwards by checking for the MSB of the
+			 * mask being set in the delta.
+			 */
+			if (unlikely(delta & ~(mask >> 1)))
+				return tkr->xtime_nsec >> tkr->shift;
+		}
+
+		return delta_to_ns_safe(tkr, delta);
 	}
 
 	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
@@ -789,10 +802,15 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 	tk->tkr_mono.cycle_last = cycle_now;
 	tk->tkr_raw.cycle_last  = cycle_now;
 
-	tk->tkr_mono.xtime_nsec += delta * tk->tkr_mono.mult;
-	tk->tkr_raw.xtime_nsec += delta * tk->tkr_raw.mult;
+	while (delta > 0) {
+		u64 max = tk->tkr_mono.clock->max_cycles;
+		u64 incr = delta < max ? delta : max;
 
-	tk_normalize_xtime(tk);
+		tk->tkr_mono.xtime_nsec += incr * tk->tkr_mono.mult;
+		tk->tkr_raw.xtime_nsec += incr * tk->tkr_raw.mult;
+		tk_normalize_xtime(tk);
+		delta -= incr;
+	}
 }
 
 /**
-- 
2.34.1


