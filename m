Return-Path: <linux-kernel+bounces-97060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9CA8764F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBADD1C210F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC935102A;
	Fri,  8 Mar 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVV262wt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7B4C627;
	Fri,  8 Mar 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903847; cv=none; b=Jyfmjs7AgxV35ADznSUfwQXkacefJQt64DfW8U2ZRBfF0ylojV8nfgGtelatXQGZ+q2pEkGZ0hK6tRt/i16E3DDbjfV9gWFGn09uAlBa2QSoqP4iPhLXfICgP8tkKowLQUS05T1MuxcNeWqwTF+aiyTpK1el63LRYsIQwsGVHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903847; c=relaxed/simple;
	bh=xuu117cG1lowhe30UpLIG5BgAby+hnwaDFUtdrI4YDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBWAYzrQyqGacIb1WzKq4KCV3ehn2rpp6seI17jiGBSRep4qAtFG7Cmhv1YP9NWV3Ea4pbu4BsIqbweGZylByAN6AMlFHa05IW3YKPkX5Dsm0i+i+w9QhQMDZsKcJcsc7dhDXuViYVPFXhqMbYAd6PGeYG795I/6ewl2ichUduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVV262wt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903846; x=1741439846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuu117cG1lowhe30UpLIG5BgAby+hnwaDFUtdrI4YDU=;
  b=kVV262wt53lXrVuccER/6ZhgkEZ5lolyETvnrVOFdl4Tas2CnAzZh6oq
   QIUKPlLh7+qJCrSpJOVbqRh/RjOR9SHcOaWg5kFGP8BcCGnrJxw+rZ5nQ
   mPrnV/CpshfgTLFPUC99B8APdyz0Jg7wkWy6ZyoqPXRynreUi0YVwuG3D
   LTwhsCiSXghJ1VCklqSGTRC+QSQ+S6tJgRbcBIXlUlveW4kn6fT0iXUbB
   V5ClsKWlJYSvdawleTN/CmA85swSRQJBhBHUd59ZO6f8xxC9D/sc1yJZr
   q/7Ush0ZhZUeti5dIQcA1saZo8zuR4AUHXIc3NERCYKI7TAIAONyvZI1W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342906"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342906"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161603"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:17:18 -0800
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
Subject: [PATCH 17/19] timekeeping: Make delta calculation overflow safe
Date: Fri,  8 Mar 2024 15:15:10 +0200
Message-Id: <20240308131512.44324-18-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308131512.44324-1-adrian.hunter@intel.com>
References: <20240308131512.44324-1-adrian.hunter@intel.com>
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


