Return-Path: <linux-kernel+bounces-4873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C689818331
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA93284EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B9E13FFD;
	Tue, 19 Dec 2023 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqZStwWR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82813AFC;
	Tue, 19 Dec 2023 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702973853; x=1734509853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D7640LkdpJNYX5Nvkm2pD/vUiW6p3SvTqgSx3dehc7U=;
  b=jqZStwWRnJTtH2mG1KMM2N7SiDPlLqBQKLSRuz5HUrIOzHq7U9syVIiF
   4YGhkJ3+auT5Kduj55FExyyZ2CoIJMWQ4sdB3r1UeYr7bmsSBLRDIsRTM
   5axBhSaJCRV97/PcKirZqVoFFfwL+syyh5tndo7yE3hTdgdRBRPTtvcFm
   raELyNASwiYNL1FiiISMH2vLGrZmwFzQO2FLNvf0/qRFRvGhtOja8XUTl
   v4i1y8BnfdkHhsIjfI0pJuLTeHRcs/s8AZu7Hv74KEB/sgAKwm64zoblb
   5bq+EP1MFsrwSas+VKBkI1pU6o25EzxRIiAXd0GZKWRETVxRkomu8oOcV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="375114458"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="375114458"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="779399568"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="779399568"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:32 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id D94FE580C25;
	Tue, 19 Dec 2023 00:17:28 -0800 (PST)
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
Subject: [PATCH v3 net 3/4] net/sched: taprio: fix impacted fields value during cycle time adjustment
Date: Tue, 19 Dec 2023 03:14:52 -0500
Message-Id: <20231219081453.718489-4-faizal.abdul.rahim@linux.intel.com>
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

During the cycle time adjustment period, there's a single entry left
from the oper schedule to be executed. As a result, updates are
needed for the affected fields' logic, which did not previously
consider dynamic scheduling.

Fixes: a306a90c8ffe ("net/sched: taprio: calculate tc gate durations")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 44 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index e70dc69c311f..a3c71be21af2 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -285,7 +285,8 @@ static void taprio_update_queue_max_sdu(struct taprio_sched *q,
 		/* TC gate never closes => keep the queueMaxSDU
 		 * selected by the user
 		 */
-		if (sched->max_open_gate_duration[tc] == sched->cycle_time) {
+		if (sched->max_open_gate_duration[tc] == sched->cycle_time &&
+		    !sched_switch_pending(sched)) {
 			max_sdu_dynamic = U32_MAX;
 		} else {
 			u32 max_frm_len;
@@ -681,7 +682,8 @@ static void taprio_set_budgets(struct taprio_sched *q,
 
 	for (tc = 0; tc < num_tc; tc++) {
 		/* Traffic classes which never close have infinite budget */
-		if (entry->gate_duration[tc] == sched->cycle_time)
+		if (entry->gate_duration[tc] == sched->cycle_time &&
+		    !sched_switch_pending(sched))
 			budget = INT_MAX;
 		else
 			budget = div64_u64((u64)entry->gate_duration[tc] * PSEC_PER_NSEC,
@@ -893,6 +895,29 @@ static bool should_restart_cycle(const struct sched_gate_list *oper,
 	return false;
 }
 
+/* Open gate duration were calculated at the beginning with consideration of
+ * multiple entries. If sched_switch_pending() is active, there's only a single
+ * remaining entry left from oper to run. Update open gate duration based
+ * on this last entry.
+ */
+static void update_open_gate_duration(struct sched_entry *entry,
+				      struct sched_gate_list *oper,
+				      int num_tc,
+				      u64 open_gate_duration)
+{
+	int tc;
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
 static bool should_extend_cycle(const struct sched_gate_list *oper,
 				ktime_t new_base_time,
 				ktime_t next_entry_end_time,
@@ -1002,13 +1027,26 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 			/* The next entry is the last entry we will run from
 			 * oper, subsequent ones will take from the new admin
 			 */
+			u64 new_gate_duration =
+				next->interval + oper->cycle_time_correction;
+			struct qdisc_size_table *stab;
+
 			oper->cycle_end_time = new_base_time;
 			end_time = new_base_time;
+
+			update_open_gate_duration(next, oper, num_tc,
+						  new_gate_duration);
+			rcu_read_lock();
+			stab = rcu_dereference(q->root->stab);
+			taprio_update_queue_max_sdu(q, oper, stab);
+			rcu_read_unlock();
 		}
 	}
 
 	for (tc = 0; tc < num_tc; tc++) {
-		if (next->gate_duration[tc] == oper->cycle_time)
+		if (sched_switch_pending(oper) && (next->gate_mask & BIT(tc)))
+			next->gate_close_time[tc] = end_time;
+		else if (next->gate_duration[tc] == oper->cycle_time)
 			next->gate_close_time[tc] = KTIME_MAX;
 		else
 			next->gate_close_time[tc] = ktime_add_ns(entry->end_time,
-- 
2.25.1


