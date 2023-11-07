Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDA7E3AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjKGLWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbjKGLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:22:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EDD113;
        Tue,  7 Nov 2023 03:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356124; x=1730892124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cjQy5UhxJgB9eTPnA9Pr3M7tSlose1KGFKMwLXqwwPs=;
  b=LxRK7ZcQ9IUBb11HgDocBBtPFui3sx7r3f/iY8LemD3C7ovwtBqxEoYr
   uzftDDs0J740qGD/2HOw4UfpCnNWjKtjRregmR7wy7oVUGncAlhBnTPPZ
   fMdoWXichS4/PJ9x1ivDMxMn2n62yHPGcJTlxMw7dwWgMckPs5aEV3Gbm
   igAtwnoiNTwNAB+uMkYnZmqSVxBOJebRfV+Yr4DPOohpEc+qTV8bf/VCM
   ByTx2j5ubV87WqOEGR7AKfGXf+qcPz8Oa4B74Y/4Iq6OfMpOxFhA//D/l
   pyCNJl7ixe8UvqHofr+nY7FExaCBv9APGTIWI6zxbO3ILYYlIMJDgkwRs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475727127"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="475727127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="828579811"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="828579811"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:03 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
        by linux.intel.com (Postfix) with ESMTP id E9FD4580D99;
        Tue,  7 Nov 2023 03:22:00 -0800 (PST)
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
Subject: [PATCH v2 net 3/7] net/sched: taprio: update impacted fields during cycle time adjustment
Date:   Tue,  7 Nov 2023 06:20:19 -0500
Message-Id: <20231107112023.676016-4-faizal.abdul.rahim@linux.intel.com>
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

Update impacted fields in advance_sched() if cycle_corr_active()
is true, which indicates that the next entry is the last entry
from oper that it will run.

Update impacted fields:

1. gate_duration[tc], max_open_gate_duration[tc]
Created a new API update_open_gate_duration().The API sets the
duration based on the last remaining entry, the original value
was based on consideration of multiple entries.

2. gate_close_time[tc]
Update next entry gate close time according to the new admin
base time

3. max_sdu[tc], budget[tc]
Restrict from setting to max value because there's only a single
entry left to run from oper before changing to the new admin
schedule, so we shouldn't set to max.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 49 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index ed32654b46f5..119dec3bbe88 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -288,7 +288,8 @@ static void taprio_update_queue_max_sdu(struct taprio_sched *q,
 		/* TC gate never closes => keep the queueMaxSDU
 		 * selected by the user
 		 */
-		if (sched->max_open_gate_duration[tc] == sched->cycle_time) {
+		if (sched->max_open_gate_duration[tc] == sched->cycle_time &&
+		    !cycle_corr_active(sched->cycle_time_correction)) {
 			max_sdu_dynamic = U32_MAX;
 		} else {
 			u32 max_frm_len;
@@ -684,7 +685,8 @@ static void taprio_set_budgets(struct taprio_sched *q,
 
 	for (tc = 0; tc < num_tc; tc++) {
 		/* Traffic classes which never close have infinite budget */
-		if (entry->gate_duration[tc] == sched->cycle_time)
+		if (entry->gate_duration[tc] == sched->cycle_time &&
+		    !cycle_corr_active(sched->cycle_time_correction))
 			budget = INT_MAX;
 		else
 			budget = div64_u64((u64)entry->gate_duration[tc] * PSEC_PER_NSEC,
@@ -896,6 +898,32 @@ static bool should_restart_cycle(const struct sched_gate_list *oper,
 	return false;
 }
 
+/* Open gate duration were calculated at the beginning with consideration of
+ * multiple entries. If cycle time correction is active, there's only a single
+ * remaining entry left from oper to run.
+ * Update open gate duration based on this last entry.
+ */
+static void update_open_gate_duration(struct sched_entry *entry,
+				      struct sched_gate_list *oper,
+				      int num_tc,
+				      u64 open_gate_duration)
+{
+	int tc;
+
+	if (!entry || !oper)
+		return;
+
+	for (tc = 0; tc < num_tc; tc++) {
+		if (entry->gate_mask & BIT(tc)) {
+			entry->gate_duration[tc] = open_gate_duration;
+			oper->max_open_gate_duration[tc] = open_gate_duration;
+		} else {
+			entry->gate_duration[tc] = 0;
+			oper->max_open_gate_duration[tc] = 0;
+		}
+	}
+}
+
 static bool should_change_sched(struct sched_gate_list *oper)
 {
 	bool change_to_admin_sched = false;
@@ -1010,13 +1038,28 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 			/* The next entry is the last entry we will run from
 			 * oper, subsequent ones will take from the new admin
 			 */
+			u64 new_gate_duration =
+				next->interval + oper->cycle_time_correction;
+			struct qdisc_size_table *stab =
+				rtnl_dereference(q->root->stab);
+
 			oper->cycle_end_time = new_base_time;
 			end_time = new_base_time;
+
+			update_open_gate_duration(next, oper, num_tc,
+						  new_gate_duration);
+			taprio_update_queue_max_sdu(q, oper, stab);
 		}
 	}
 
 	for (tc = 0; tc < num_tc; tc++) {
-		if (next->gate_duration[tc] == oper->cycle_time)
+		if (cycle_corr_active(oper->cycle_time_correction) &&
+		    (next->gate_mask & BIT(tc)))
+			/* Set to the new base time, ensuring a smooth transition
+			 * to the new schedule when the next entry finishes.
+			 */
+			next->gate_close_time[tc] = end_time;
+		else if (next->gate_duration[tc] == oper->cycle_time)
 			next->gate_close_time[tc] = KTIME_MAX;
 		else
 			next->gate_close_time[tc] = ktime_add_ns(entry->end_time,
-- 
2.25.1

