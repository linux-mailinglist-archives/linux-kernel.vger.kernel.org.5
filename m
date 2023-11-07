Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3FF7E3AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjKGLWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjKGLWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:22:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87BEA;
        Tue,  7 Nov 2023 03:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356121; x=1730892121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwSdsZVrCeR+EOJgU0o0Z8bvvJ11nUwi8EXqw+a3IMY=;
  b=kN5EZKwLIrCQJ8OWxlFQNk4xWF/ulGdvhd3PrBD2pfW1Ig+4eVEx2yEQ
   1gTXVZyYa+0YVM0Ah5a1IKUVlaZX9teo/fh73zlbXQ8AINLabANGKzj6i
   mi9JYNduw7GmoueeeW/kZXnDQMXToxg8oKWJHd4D2SJDiPFnBIuKAmYw7
   I5bHXL99lded/mYwaxP8R74Ch1blCbGRhM5R1ZakQZVJ24smh+EP0VboE
   +kjjvfMeMi+9muEDPAI3tqm9x6Y9HJb/EmYHldNPvzbF7OaWDqP2U/Kix
   GBP6bjfNvrDCMWfsd+XRsBPQHl6cXZBRfzC+129Xin7ggYMdCFjD8NWzX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475727114"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="475727114"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="828579792"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="828579792"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:00 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
        by linux.intel.com (Postfix) with ESMTP id BE89D580D61;
        Tue,  7 Nov 2023 03:21:57 -0800 (PST)
From:   Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 2/7] net/sched: taprio: fix cycle time adjustment for next entry
Date:   Tue,  7 Nov 2023 06:20:18 -0500
Message-Id: <20231107112023.676016-3-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension:
"the Cycle Time Extension variable allows this extension of the last old
cycle to be done in a defined way. If the last complete old cycle would
normally end less than OperCycleTimeExtension nanoseconds before the new
base time, then the last complete cycle before AdminBaseTime is reached
is extended so that it ends at AdminBaseTime."

The current taprio implementation does not extend the last old cycle in
the defined manner specified in the Qbv Spec. This is part of the fix
covered in this patch.

Here are the changes made:

1. A new API, get_cycle_time_correction(), has been added to return the
correction value. If it returns a non-initialize value, it indicates
changes required for the next entry schedule, and upon the completion
of the next entry's duration, entries will be loaded from the new admin
schedule.

2. Store correction values in cycle_time_correction:
a) Positive correction value/extension
We calculate the correction between the last operational cycle and the
new admin base time. Note that for positive correction to take place,
the next entry should be the last entry from oper and the new admin base
time falls within the next cycle time of old oper.

b) Negative correction value
The new admin base time starts earlier than the next entry's end time.

c) Zero correction value
The new admin base time aligns exactly with the old cycle.

3. When cycle_time_correction is set to a non-initialized value, it is
used to:
a) Indicate that cycle correction is active to trigger adjustments in
affected fields like interval and cycle_time. A new API,
cycle_corr_active(), has been created to help with this purpose.

b) Transition to the new admin schedule at the beginning of
advance_sched(). A new API, should_change_sched(), has been introduced
for this purpose.

4. Remove the previous definition of should_change_scheds() API. A new
should_change_sched() API has been introduced, but it serves a
completely different purpose than the one that was removed.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 105 +++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index dee103647823..ed32654b46f5 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -259,6 +259,14 @@ static int duration_to_length(struct taprio_sched *q, u64 duration)
 	return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
 }
 
+static bool cycle_corr_active(s64 cycle_time_correction)
+{
+	if (cycle_time_correction == INIT_CYCLE_TIME_CORRECTION)
+		return false;
+	else
+		return true;
+}
+
 /* Sets sched->max_sdu[] and sched->max_frm_len[] to the minimum between the
  * q->max_sdu[] requested by the user and the max_sdu dynamically determined by
  * the maximum open gate durations at the given link speed.
@@ -888,38 +896,59 @@ static bool should_restart_cycle(const struct sched_gate_list *oper,
 	return false;
 }
 
-static bool should_change_schedules(const struct sched_gate_list *admin,
-				    const struct sched_gate_list *oper,
-				    ktime_t end_time)
+static bool should_change_sched(struct sched_gate_list *oper)
 {
-	ktime_t next_base_time, extension_time;
+	bool change_to_admin_sched = false;
 
-	if (!admin)
-		return false;
+	if (oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {
+		/* The recent entry ran is the last one from oper */
+		change_to_admin_sched = true;
+		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
+	}
 
-	next_base_time = sched_base_time(admin);
+	return change_to_admin_sched;
+}
 
-	/* This is the simple case, the end_time would fall after
-	 * the next schedule base_time.
-	 */
-	if (ktime_compare(next_base_time, end_time) <= 0)
+static bool should_extend_cycle(const struct sched_gate_list *oper,
+				ktime_t new_base_time,
+				ktime_t entry_end_time,
+				const struct sched_entry *entry)
+{
+	ktime_t next_cycle_end_time = ktime_add_ns(oper->cycle_end_time,
+						   oper->cycle_time);
+	bool extension_supported = oper->cycle_time_extension > 0 ? true : false;
+	s64 extension_limit = oper->cycle_time_extension;
+
+	if (extension_supported &&
+	    list_is_last(&entry->list, &oper->entries) &&
+	    ktime_before(new_base_time, next_cycle_end_time) &&
+	    ktime_sub(new_base_time, entry_end_time) < extension_limit)
 		return true;
+	else
+		return false;
+}
 
-	/* This is the cycle_time_extension case, if the end_time
-	 * plus the amount that can be extended would fall after the
-	 * next schedule base_time, we can extend the current schedule
-	 * for that amount.
-	 */
-	extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
+static s64 get_cycle_time_correction(const struct sched_gate_list *oper,
+				     ktime_t new_base_time,
+				     ktime_t entry_end_time,
+				     const struct sched_entry *entry)
+{
+	s64 correction = INIT_CYCLE_TIME_CORRECTION;
 
-	/* FIXME: the IEEE 802.1Q-2018 Specification isn't clear about
-	 * how precisely the extension should be made. So after
-	 * conformance testing, this logic may change.
-	 */
-	if (ktime_compare(next_base_time, extension_time) <= 0)
-		return true;
+	if (!entry || !oper)
+		return correction;
 
-	return false;
+	if (ktime_compare(new_base_time, entry_end_time) <= 0) {
+		/* negative or zero correction */
+		correction = ktime_sub(new_base_time, entry_end_time);
+	} else if (ktime_after(new_base_time, entry_end_time) &&
+		   should_extend_cycle(oper, new_base_time,
+				       entry_end_time, entry)) {
+		/* positive correction */
+		correction = ktime_sub(new_base_time, entry_end_time);
+	}
+
+	return correction;
 }
 
 static enum hrtimer_restart advance_sched(struct hrtimer *timer)
@@ -942,10 +971,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	admin = rcu_dereference_protected(q->admin_sched,
 					  lockdep_is_held(&q->current_entry_lock));
 
-	if (!oper || oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {
-		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
+	if (!oper || should_change_sched(oper))
 		switch_schedules(q, &admin, &oper);
-	}
 
 	/* This can happen in two cases: 1. this is the very first run
 	 * of this function (i.e. we weren't running any schedule
@@ -972,6 +999,22 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	end_time = ktime_add_ns(entry->end_time, next->interval);
 	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
 
+	if (admin) {
+		ktime_t new_base_time = sched_base_time(admin);
+
+		oper->cycle_time_correction =
+			get_cycle_time_correction(oper, new_base_time,
+						  end_time, next);
+
+		if (cycle_corr_active(oper->cycle_time_correction)) {
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
@@ -980,14 +1023,6 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
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

