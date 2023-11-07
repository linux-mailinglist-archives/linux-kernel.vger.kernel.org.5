Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476EC7E3B04
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjKGLWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbjKGLWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:22:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6CD76;
        Tue,  7 Nov 2023 03:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356129; x=1730892129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GYJFMseSRujrlOpQy9nErngkfh/08yp/LL0rLTrMXX8=;
  b=Nw+Auw9gW2dGUUuus6TzEmtVT8l/3GXveBXhiRhoLAtHh+IXAkclLPfz
   +6hRXbTATk3oDndL5/ldf5mMWC2tdSWR0DxXMqufC4LY6+VZBHm7HtIAQ
   C1V8JYB+KRGB3k7n+DE+oi2BpdKB7bfQoHB9qZ66Gqwsd6hE2yMABCe1C
   Q2EDV/2YFUGsuH/SFnMhHBjJ5VDESHDxKvpJjhPpMjqVQVjoyYfK8pbXc
   2lpiJR5g22cjxTQ9SX3t33Dl0Zs5ALdEZGz6oyi1OGt2dTXsc+xkdwN3r
   Ll0qlsn8yBW1577igwQxLba2YQ0Q7Tcuf+MKbd/7sSNK5PssqIa+k3JFk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393382961"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="393382961"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="766285598"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="766285598"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:06 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
        by linux.intel.com (Postfix) with ESMTP id DC3CA580D42;
        Tue,  7 Nov 2023 03:22:03 -0800 (PST)
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
Subject: [PATCH v2 net 4/7] net/sched: taprio: get corrected value of cycle_time and interval
Date:   Tue,  7 Nov 2023 06:20:20 -0500
Message-Id: <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retrieve adjusted cycle_time and interval values through new APIs.
Note that in some cases where the original values are required,
such as in dump_schedule() and setup_first_end_time(), direct calls
to cycle_time and interval are retained without using the new APIs.

Added a new field, correction_active, in the sched_entry struct to
determine the entry's correction state. This field is required due
to specific flow like find_entry_to_transmit() -> get_interval_end_time()
which retrieves the interval for each entry. During positive cycle
time correction, it's known that the last entry interval requires
correction. However, for negative correction, the affected entry
is unknown, which is why this new field is necessary.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 50 ++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 119dec3bbe88..f18a5fe12f0c 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -61,6 +61,7 @@ struct sched_entry {
 	u32 gate_mask;
 	u32 interval;
 	u8 command;
+	bool correction_active;
 };
 
 struct sched_gate_list {
@@ -215,6 +216,31 @@ static void switch_schedules(struct taprio_sched *q,
 	*admin = NULL;
 }
 
+static bool cycle_corr_active(s64 cycle_time_correction)
+{
+	if (cycle_time_correction == INIT_CYCLE_TIME_CORRECTION)
+		return false;
+	else
+		return true;
+}
+
+u32 get_interval(const struct sched_entry *entry,
+		 const struct sched_gate_list *oper)
+{
+	if (entry->correction_active)
+		return entry->interval + oper->cycle_time_correction;
+	else
+		return entry->interval;
+}
+
+s64 get_cycle_time(const struct sched_gate_list *oper)
+{
+	if (cycle_corr_active(oper->cycle_time_correction))
+		return oper->cycle_time + oper->cycle_time_correction;
+	else
+		return oper->cycle_time;
+}
+
 /* Get how much time has been already elapsed in the current cycle. */
 static s32 get_cycle_time_elapsed(struct sched_gate_list *sched, ktime_t time)
 {
@@ -222,7 +248,7 @@ static s32 get_cycle_time_elapsed(struct sched_gate_list *sched, ktime_t time)
 	s32 time_elapsed;
 
 	time_since_sched_start = ktime_sub(time, sched->base_time);
-	div_s64_rem(time_since_sched_start, sched->cycle_time, &time_elapsed);
+	div_s64_rem(time_since_sched_start, get_cycle_time(sched), &time_elapsed);
 
 	return time_elapsed;
 }
@@ -235,8 +261,9 @@ static ktime_t get_interval_end_time(struct sched_gate_list *sched,
 	s32 cycle_elapsed = get_cycle_time_elapsed(sched, intv_start);
 	ktime_t intv_end, cycle_ext_end, cycle_end;
 
-	cycle_end = ktime_add_ns(intv_start, sched->cycle_time - cycle_elapsed);
-	intv_end = ktime_add_ns(intv_start, entry->interval);
+	cycle_end = ktime_add_ns(intv_start,
+				 get_cycle_time(sched) - cycle_elapsed);
+	intv_end = ktime_add_ns(intv_start, get_interval(entry, sched));
 	cycle_ext_end = ktime_add(cycle_end, sched->cycle_time_extension);
 
 	if (ktime_before(intv_end, cycle_end))
@@ -259,14 +286,6 @@ static int duration_to_length(struct taprio_sched *q, u64 duration)
 	return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
 }
 
-static bool cycle_corr_active(s64 cycle_time_correction)
-{
-	if (cycle_time_correction == INIT_CYCLE_TIME_CORRECTION)
-		return false;
-	else
-		return true;
-}
-
 /* Sets sched->max_sdu[] and sched->max_frm_len[] to the minimum between the
  * q->max_sdu[] requested by the user and the max_sdu dynamically determined by
  * the maximum open gate durations at the given link speed.
@@ -351,7 +370,7 @@ static struct sched_entry *find_entry_to_transmit(struct sk_buff *skb,
 	if (!sched)
 		return NULL;
 
-	cycle = sched->cycle_time;
+	cycle = get_cycle_time(sched);
 	cycle_elapsed = get_cycle_time_elapsed(sched, time);
 	curr_intv_end = ktime_sub_ns(time, cycle_elapsed);
 	cycle_end = ktime_add_ns(curr_intv_end, cycle);
@@ -365,7 +384,7 @@ static struct sched_entry *find_entry_to_transmit(struct sk_buff *skb,
 			break;
 
 		if (!(entry->gate_mask & BIT(tc)) ||
-		    packet_transmit_time > entry->interval)
+		    packet_transmit_time > get_interval(entry, sched))
 			continue;
 
 		txtime = entry->next_txtime;
@@ -543,7 +562,8 @@ static long get_packet_txtime(struct sk_buff *skb, struct Qdisc *sch)
 		 * interval starts.
 		 */
 		if (ktime_after(transmit_end_time, interval_end))
-			entry->next_txtime = ktime_add(interval_start, sched->cycle_time);
+			entry->next_txtime =
+				ktime_add(interval_start, get_cycle_time(sched));
 	} while (sched_changed || ktime_after(transmit_end_time, interval_end));
 
 	entry->next_txtime = transmit_end_time;
@@ -1045,6 +1065,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 
 			oper->cycle_end_time = new_base_time;
 			end_time = new_base_time;
+			next->correction_active = true;
 
 			update_open_gate_duration(next, oper, num_tc,
 						  new_gate_duration);
@@ -1146,6 +1167,7 @@ static int fill_sched_entry(struct taprio_sched *q, struct nlattr **tb,
 	}
 
 	entry->interval = interval;
+	entry->correction_active = false;
 
 	return 0;
 }
-- 
2.25.1

