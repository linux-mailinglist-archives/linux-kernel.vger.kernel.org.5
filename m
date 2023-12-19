Return-Path: <linux-kernel+bounces-4872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EFA81832D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4653284562
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79213AC8;
	Tue, 19 Dec 2023 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKUWjP01"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CBB12B78;
	Tue, 19 Dec 2023 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702973850; x=1734509850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jjXTXnJa1L2JtrFjlBmPIIt05pJnwrPqu06KvHw7ies=;
  b=VKUWjP015BK8C9aH5udqgsWy2k7TJ8j877td7XvEuC+SE0fb7AweIxPW
   1q3SJfR4owKuEE2wfnMi+TY80x2IIJa1Lc6qA3Pjssff6ZgSyiZpnjlYf
   p+x7eSNch6nDtcpxxpLYD8Z89zEQ8su3cax3CoV6nvToAn/h2tRU93A/h
   yEVjmcp0F7S3rfVPXNpzqGxt28PMIoay0Ke+cpb05lkBgsvUXlUkdeD8N
   sGmssXRrPeBPDnco6HVT2YpYJuJbDufi1fReDsGR/N2Gg1KREbyYWPcC4
   wp18MCnKMX1OMJcCvgAI5QEW77Kj6Y34/aUGrKk5gFUd2sZPvhCj48enT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="375114449"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="375114449"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="779399545"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="779399545"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:28 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id BBBB0580E21;
	Tue, 19 Dec 2023 00:17:25 -0800 (PST)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net 2/4] net/sched: taprio: fix cycle time adjustment for next entry
Date: Tue, 19 Dec 2023 03:14:51 -0500
Message-Id: <20231219081453.718489-3-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension:
"the Cycle Time Extension variable allows this extension of the last old
cycle to be done in a defined way. If the last complete old cycle would
normally end less than OperCycleTimeExtension nanoseconds before the new
base time, then the last complete cycle before AdminBaseTime is reached
is extended so that it ends at AdminBaseTime."

Fix cyle time modification logic for the next entry that includes the
following cases:
a) positive correction - cycle time extension
b) negative correction - cycle time truncation
c) zero correction - new admin base time aligns exactly with the old
cycle

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 100 +++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index bbcaf05d40ba..e70dc69c311f 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -893,38 +893,54 @@ static bool should_restart_cycle(const struct sched_gate_list *oper,
 	return false;
 }
 
-static bool should_change_schedules(const struct sched_gate_list *admin,
-				    const struct sched_gate_list *oper,
-				    ktime_t end_time)
-{
-	ktime_t next_base_time, extension_time;
-
-	if (!admin)
-		return false;
-
-	next_base_time = sched_base_time(admin);
-
-	/* This is the simple case, the end_time would fall after
-	 * the next schedule base_time.
-	 */
-	if (ktime_compare(next_base_time, end_time) <= 0)
-		return true;
-
-	/* This is the cycle_time_extension case, if the end_time
-	 * plus the amount that can be extended would fall after the
-	 * next schedule base_time, we can extend the current schedule
-	 * for that amount.
-	 */
-	extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
+static bool should_extend_cycle(const struct sched_gate_list *oper,
+				ktime_t new_base_time,
+				ktime_t next_entry_end_time,
+				const struct sched_entry *next_entry)
+{
+	ktime_t next_cycle_end_time = ktime_add_ns(oper->cycle_end_time,
+						   oper->cycle_time);
+	bool extension_supported = oper->cycle_time_extension > 0;
+	s64 extension_limit = oper->cycle_time_extension;
+	s64 extension_duration = ktime_sub(new_base_time, next_entry_end_time);
+
+	return extension_supported &&
+	       list_is_last(&next_entry->list, &oper->entries) &&
+	       ktime_before(new_base_time, next_cycle_end_time) &&
+	       extension_duration < extension_limit;
+}
+
+static s64 get_cycle_time_correction(const struct sched_gate_list *oper,
+				     ktime_t new_base_time,
+				     ktime_t next_entry_end_time,
+				     const struct sched_entry *next_entry)
+{
+	s64 correction = CYCLE_TIME_CORRECTION_UNSPEC;
+
+	if (ktime_compare(new_base_time, next_entry_end_time) <= 0) {
+		/* Negative correction - The new admin base time starts earlier
+		 * than the next entry's end time.
+		 * Zero correction - The new admin base time aligns exactly
+		 * with the old cycle.
+		 */
+		correction = ktime_sub(new_base_time, next_entry_end_time);
 
-	/* FIXME: the IEEE 802.1Q-2018 Specification isn't clear about
-	 * how precisely the extension should be made. So after
-	 * conformance testing, this logic may change.
-	 */
-	if (ktime_compare(next_base_time, extension_time) <= 0)
-		return true;
+		/* Below is to hande potential issue where the negative correction
+		 * exceed the entry's interval. This typically shouldn't happen.
+		 * Setting to 0 enables schedule changes without altering cycle time.
+		 */
+		if (abs(correction) > next_entry->interval)
+			correction = 0;
+	} else if (ktime_after(new_base_time, next_entry_end_time) &&
+		   should_extend_cycle(oper, new_base_time,
+				       next_entry_end_time, next_entry)) {
+		/* Positive correction - The new admin base time starts after the
+		 * last entry end time and within the next cycle time of old oper.
+		 */
+		correction = ktime_sub(new_base_time, next_entry_end_time);
+	}
 
-	return false;
+	return correction;
 }
 
 static enum hrtimer_restart advance_sched(struct hrtimer *timer)
@@ -975,6 +991,22 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	end_time = ktime_add_ns(entry->end_time, next->interval);
 	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
 
+	if (admin) {
+		ktime_t new_base_time = sched_base_time(admin);
+
+		oper->cycle_time_correction =
+			get_cycle_time_correction(oper, new_base_time,
+						  end_time, next);
+
+		if (sched_switch_pending(oper)) {
+			/* The next entry is the last entry we will run from
+			 * oper, subsequent ones will take from the new admin
+			 */
+			oper->cycle_end_time = new_base_time;
+			end_time = new_base_time;
+		}
+	}
+
 	for (tc = 0; tc < num_tc; tc++) {
 		if (next->gate_duration[tc] == oper->cycle_time)
 			next->gate_close_time[tc] = KTIME_MAX;
@@ -983,14 +1015,6 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 								 next->gate_duration[tc]);
 	}
 
-	if (should_change_schedules(admin, oper, end_time)) {
-		/* Set things so the next time this runs, the new
-		 * schedule runs.
-		 */
-		end_time = sched_base_time(admin);
-		oper->cycle_time_correction = 0;
-	}
-
 	next->end_time = end_time;
 	taprio_set_budgets(q, oper, next);
 
-- 
2.25.1


