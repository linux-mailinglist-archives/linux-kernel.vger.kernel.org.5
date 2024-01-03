Return-Path: <linux-kernel+bounces-15470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B726822C6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF791F2322A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A643219472;
	Wed,  3 Jan 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TT3llQM8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F419469;
	Wed,  3 Jan 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704282983; x=1735818983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+aeq0HJvcCZ+KS3uPOjGfoNyocIUqM1MwjS66a3tiI=;
  b=TT3llQM8un7D5nR5HeDfu3UNlW2Uws8HFmkyW2f2sU5qjo4LyUy/iiBN
   qwf74oYwsVYUHme558vZANeJfxxy48rsFMH9wzVehDwnL6/blTEB+Nkdb
   vaHfEcSITt/uRmSPp+xPQCyX/EcawzUDX0R6P5ySFhVy+MFHCaYR+x3Jg
   0gAnq/XQOw/bQDms97KBwQAAxD354HiBnc/XT8/HNyd8+YJ2Gh02W2b4E
   xTiKb12UPQYYkUkMpijbzfCq96MzkKfilVzF1GH1hFc8MyEPj9ke1u16B
   orF+rCNPBqcyQHP3+NtvOt1oyc4zcAllo62OrcQm50GhDwFZFZ1wiAufh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="428169439"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="428169439"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:56:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111348035"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="1111348035"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jan 2024 03:56:16 -0800
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	pandith.n@intel.com,
	mallikarjunappa.sangannavar@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [RFC PATCH v3 02/11] timekeeping: Add function to convert realtime to base clock
Date: Wed,  3 Jan 2024 17:25:53 +0530
Message-Id: <20240103115602.19044-3-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Introduce an interface ktime_real_to_base_clock(), to convert realtime
to base clock.

Convert base clock to system clock using convert_base_to_cs() in
get_device_system_crosststamp().

Add a helper function to check whether the current clocksource has same
base clock.

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 include/linux/timekeeping.h |   6 ++
 kernel/time/timekeeping.c   | 112 +++++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 0f00f382bb5d..2c3bc2eac974 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -274,12 +274,18 @@ struct system_device_crosststamp {
  *		timekeeping code to verify comparability of two cycle values.
  *		The default ID, CSID_GENERIC, does not identify a specific
  *		clocksource.
+ * @nsecs:	@cycles is in nanoseconds.
  */
 struct system_counterval_t {
 	u64			cycles;
 	enum clocksource_ids	cs_id;
+	bool			nsecs;
 };
 
+extern bool ktime_real_to_base_clock(ktime_t treal,
+				     enum clocksource_ids base_id, u64 *cycles);
+extern bool timekeeping_clocksource_has_base(enum clocksource_ids id);
+
 /*
  * Get cross timestamp between system clock and device clock
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0ff065c5d25b..e68ecd77ee34 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1191,6 +1191,89 @@ static bool cycle_between(u64 before, u64 test, u64 after)
 	return false;
 }
 
+static bool convert_clock(u64 *val, u32 numerator, u32 denominator)
+{
+	u64 rem, res;
+
+	if (numerator == 0 || denominator == 0)
+		return false;
+
+	res = div64_u64_rem(*val, denominator, &rem) * numerator;
+	*val = res + div_u64(rem * numerator, denominator);
+	return true;
+}
+
+static bool convert_base_to_cs(struct system_counterval_t *scv)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base = cs->base;
+
+	/* The timestamp was taken from the time keeper clock source */
+	if (cs->id == scv->cs_id)
+		return true;
+
+	/* Check whether cs_id matches the base clock */
+	if (!base || base->id != scv->cs_id)
+		return false;
+
+	/* Avoid conversion to a less precise clock */
+	if (scv->nsecs && cs->freq_khz != 0 && base->freq_khz < cs->freq_khz) {
+		if (!convert_clock(&scv->cycles, cs->freq_khz, USEC_PER_SEC))
+			return false;
+	} else {
+		if (scv->nsecs) {
+			if (!convert_clock(&scv->cycles, base->freq_khz, USEC_PER_SEC))
+				return false;
+		}
+		if (!convert_clock(&scv->cycles, base->numerator, base->denominator))
+			return false;
+	}
+	scv->cycles += base->offset;
+	return true;
+}
+
+static bool convert_cs_to_base(u64 *cycles, enum clocksource_ids base_id)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base = cs->base;
+
+	/* Check whether base_id matches the base clock */
+	if (!base || base->id != base_id)
+		return false;
+
+	*cycles -= base->offset;
+	if (!convert_clock(cycles, base->denominator, base->numerator))
+		return false;
+	return true;
+}
+
+static u64 convert_ns_to_cs(u64 delta)
+{
+	struct tk_read_base *tkr = &tk_core.timekeeper.tkr_mono;
+
+	return div_u64((delta << tkr->shift) - tkr->xtime_nsec, tkr->mult);
+}
+
+bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	u64 delta;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		delta = (u64)treal - tk->tkr_mono.base_real;
+		if (delta > tk->tkr_mono.clock->max_idle_ns)
+			return false;
+		*cycles = tk->tkr_mono.cycle_last + convert_ns_to_cs(delta);
+		if (!convert_cs_to_base(cycles, base_id))
+			return false;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_real_to_base_clock);
+
 /**
  * get_device_system_crosststamp - Synchronously capture system/device timestamp
  * @get_time_fn:	Callback to get simultaneous device time and
@@ -1236,8 +1319,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 * system counter value is the same as for the currently
 		 * installed timekeeper clocksource
 		 */
-		if (system_counterval.cs_id == CSID_GENERIC ||
-		    tk->tkr_mono.clock->id != system_counterval.cs_id)
+		if (!convert_base_to_cs(&system_counterval))
 			return -ENODEV;
 		cycles = system_counterval.cycles;
 
@@ -1304,6 +1386,32 @@ int get_device_system_crosststamp(int (*get_time_fn)
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
+/**
+ * timekeeping_clocksource_has_base - Check whether the current clocksource
+ *	has a base clock
+ * @id:		The clocksource ID to check for
+ *
+ * Note:	The return value is a snapshot which can become invalid right
+ *	after the function returns.
+ *
+ * Return:	true if the timekeeper clocksource has a base clock with @id,
+ *	false otherwise
+ */
+bool timekeeping_clocksource_has_base(enum clocksource_ids id)
+{
+	unsigned int seq;
+	bool ret;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		ret = tk_core.timekeeper.tkr_mono.clock->base ?
+		tk_core.timekeeper.tkr_mono.clock->base->id == id : false;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_base);
+
 /**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
-- 
2.35.3


