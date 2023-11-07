Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334F97E3B0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjKGLWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjKGLWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:22:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A4102;
        Tue,  7 Nov 2023 03:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356137; x=1730892137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pMF+9nUTYtcxwogA5ZhYPefFB2v1RKbC8j7RIB/pdhg=;
  b=f5ptr/sy11mrBMmNnw8f9I3to9POOIt7PHhGzAOWYrmHGAxW70duPcze
   1T/kWLj2mDw9TgavTnyZQogmKl05XREejgDoDx+V0wn56GyVopcHCmSNB
   KJsa76hU+w1MDPvkL0l0CSMYiXh2D+8JqSA3erEWsxc3CU1LU1JdkGDWF
   KwCrdugGnfeRpcoEbZFlYxWxOyMP/c2Hwi+Up517dT4HD4yO9FaAJJlM7
   eSiiR0x9PC5PBcOMkZikeYrdjP1jQGRejS3bWuKrWU7D17pKn6MhKxpjh
   pw7b+iwNKwmgRIGUuhlG2tS28ItfBrHZrBGdpwV0D1Jrnj0plMOcyXu38
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475727186"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="475727186"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="828579865"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="828579865"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:15 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
        by linux.intel.com (Postfix) with ESMTP id BE5BC580D42;
        Tue,  7 Nov 2023 03:22:12 -0800 (PST)
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
Subject: [PATCH v2 net 7/7] net/sched: taprio: enable cycle time adjustment for current entry
Date:   Tue,  7 Nov 2023 06:20:23 -0500
Message-Id: <20231107112023.676016-8-faizal.abdul.rahim@linux.intel.com>
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

Handles cycle time adjustments for the current active entry
when new admin base time occurs quickly, either within the
current entry or the next one.

Changes covers:
1. Negative cycle correction or truncation
Occurs when the new admin base time falls before the expiry of the
current running entry.

2. Positive cycle correction or extension
Occurs when the new admin base time falls within the next entry,
and the current entry is the cycle's last entry. In this case, the
changes in taprio_start_sched() extends the schedule, preventing
old oper schedule from resuming and getting truncated in the next
advance_sched() call.

3. A new API, update_gate_close_time(), has been created to update
the gate_close_time of the current entry in the event of cycle
correction.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 72 +++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index c60e9e7ac193..56743754d42e 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1379,41 +1379,75 @@ static void setup_first_end_time(struct taprio_sched *q,
 		rcu_assign_pointer(q->current_entry, NULL);
 }
 
+static void update_gate_close_time(struct sched_entry *current_entry,
+				   ktime_t new_end_time,
+				   int num_tc)
+{
+	int tc;
+
+	for (tc = 0; tc < num_tc; tc++) {
+		if (current_entry->gate_mask & BIT(tc))
+			current_entry->gate_close_time[tc] = new_end_time;
+	}
+}
+
 static void taprio_start_sched(struct Qdisc *sch,
 			       ktime_t new_base_time,
-			       struct sched_gate_list *new)
+			       struct sched_gate_list *admin)
 {
 	struct taprio_sched *q = qdisc_priv(sch);
+	ktime_t expires = hrtimer_get_expires(&q->advance_timer);
+	struct net_device *dev = qdisc_dev(q->root);
+	struct sched_entry *curr_entry = NULL;
 	struct sched_gate_list *oper = NULL;
-	ktime_t expires, start;
 
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
 		return;
 
 	oper = rcu_dereference_protected(q->oper_sched,
 					 lockdep_is_held(&q->current_entry_lock));
+	curr_entry = rcu_dereference_protected(q->current_entry,
+					       lockdep_is_held(&q->current_entry_lock));
 
-	expires = hrtimer_get_expires(&q->advance_timer);
-	if (expires == 0)
-		expires = KTIME_MAX;
+	if (hrtimer_active(&q->advance_timer)) {
+		oper->cycle_time_correction =
+			get_cycle_time_correction(oper, new_base_time,
+						  curr_entry->end_time,
+						  curr_entry);
 
-	/* If the new schedule starts before the next expiration, we
-	 * reprogram it to the earliest one, so we change the admin
-	 * schedule to the operational one at the right time.
-	 */
-	start = min_t(ktime_t, new_base_time, expires);
-
-	if (expires != KTIME_MAX &&
-	    ktime_compare(start, new_base_time) == 0) {
-		/* Since timer was changed to align to the new admin schedule,
-		 * setting the variable below to a non-initialized value will
-		 * indicate to advance_sched() to call switch_schedules() after
-		 * this timer expires.
+		if (cycle_corr_active(oper->cycle_time_correction)) {
+			/* This is the last entry we are running from oper,
+			 * subsequent entry will take from the new admin.
+			 */
+			ktime_t	now = taprio_get_time(q);
+			u64 gate_duration_left = ktime_sub(new_base_time, now);
+			struct qdisc_size_table *stab =
+				rtnl_dereference(q->root->stab);
+			int num_tc = netdev_get_num_tc(dev);
+
+			oper->cycle_end_time = new_base_time;
+			curr_entry->end_time = new_base_time;
+			curr_entry->correction_active = true;
+
+			update_open_gate_duration(curr_entry, oper, num_tc,
+						  gate_duration_left);
+			update_gate_close_time(curr_entry, new_base_time, num_tc);
+			taprio_update_queue_max_sdu(q, oper, stab);
+			taprio_set_budgets(q, oper, curr_entry);
+		}
+	}
+
+	if (!hrtimer_active(&q->advance_timer) ||
+	    cycle_corr_active(oper->cycle_time_correction)) {
+		/* Use new admin base time if :
+		 * 1. there's no active oper
+		 * 2. there's active oper and we will change to the new admin
+		 * schedule after the current entry from oper ends
 		 */
-		oper->cycle_time_correction = 0;
+		expires = new_base_time;
 	}
 
-	hrtimer_start(&q->advance_timer, start, HRTIMER_MODE_ABS);
+	hrtimer_start(&q->advance_timer, expires, HRTIMER_MODE_ABS);
 }
 
 static void taprio_set_picos_per_byte(struct net_device *dev,
-- 
2.25.1

