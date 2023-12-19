Return-Path: <linux-kernel+bounces-4871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF381832B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043D21F24F05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D4512B70;
	Tue, 19 Dec 2023 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCIsToeM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4E11CBF;
	Tue, 19 Dec 2023 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702973849; x=1734509849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eprSKxW1IRUgwnlytJGk1l5+3qPhJHvreOABgX1Ah2I=;
  b=WCIsToeM+t1RU4mhoJVnikANqwHnz0Dmw4NN4S8ywz8dU5+mwoXsPo/U
   CrA25euqQyzABy/5f2if6hqVbbmhknOfGUMazLdzW88nrPDLmutDdWCkV
   QuFRUMn8Z5ufIOJhkcQfGFkTsO4cfXN0S0p6yfNbxOIZEY9WpcjIDYavu
   llC7yHKupY4s/IAQr7DvpsltgaP5zSI2saMc+omO0kvAqb0rojc+bSbRB
   G12hvl0P4O+xBYUEvUGNLiiQReX7M7LQWu5tpl5+bzrd9uS2RDjqvSL2O
   vBm3sZ0Q4oFZKTofJzpAdQb9HxNhOAtTrxVx/OUgCVTw3Y3k83lJeJRus
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2717413"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2717413"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="894193921"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="894193921"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:17:25 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 9BE50580C25;
	Tue, 19 Dec 2023 00:17:22 -0800 (PST)
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
Subject: [PATCH v3 net 1/4] net/sched: taprio: fix too early schedules switching
Date: Tue, 19 Dec 2023 03:14:50 -0500
Message-Id: <20231219081453.718489-2-faizal.abdul.rahim@linux.intel.com>
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

Switching the schedule prematurely leads to a situation where the last
entry from oper schedule is still running, during this period, calls
to taprio_skb_exceeds_queue_max_sdu() in the enqueue path, such as
taprio_enqueue_segmented(), will inspect q->oper_sched. At this point,
q->oper_sched refers to the new admin schedule instead of the ongoing
oper schedule.

Fixes: a878fd46fe43 ("net/sched: keep the max_frm_len information inside struct sched_gate_list")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 31a8252bd09c..bbcaf05d40ba 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -41,6 +41,7 @@ static struct static_key_false taprio_have_working_mqprio;
 #define TXTIME_ASSIST_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST)
 #define FULL_OFFLOAD_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
 #define TAPRIO_FLAGS_INVALID U32_MAX
+#define CYCLE_TIME_CORRECTION_UNSPEC S64_MIN
 
 struct sched_entry {
 	/* Durations between this GCL entry and the GCL entry where the
@@ -75,6 +76,7 @@ struct sched_gate_list {
 	ktime_t cycle_end_time;
 	s64 cycle_time;
 	s64 cycle_time_extension;
+	s64 cycle_time_correction;
 	s64 base_time;
 };
 
@@ -213,6 +215,11 @@ static void switch_schedules(struct taprio_sched *q,
 	*admin = NULL;
 }
 
+static bool sched_switch_pending(const struct sched_gate_list *oper)
+{
+	return oper->cycle_time_correction != CYCLE_TIME_CORRECTION_UNSPEC;
+}
+
 /* Get how much time has been already elapsed in the current cycle. */
 static s32 get_cycle_time_elapsed(struct sched_gate_list *sched, ktime_t time)
 {
@@ -940,7 +947,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	admin = rcu_dereference_protected(q->admin_sched,
 					  lockdep_is_held(&q->current_entry_lock));
 
-	if (!oper)
+	if (!oper || sched_switch_pending(oper))
 		switch_schedules(q, &admin, &oper);
 
 	/* This can happen in two cases: 1. this is the very first run
@@ -981,7 +988,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 		 * schedule runs.
 		 */
 		end_time = sched_base_time(admin);
-		switch_schedules(q, &admin, &oper);
+		oper->cycle_time_correction = 0;
 	}
 
 	next->end_time = end_time;
@@ -1174,6 +1181,7 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 	}
 
 	taprio_calculate_gate_durations(q, new);
+	new->cycle_time_correction = CYCLE_TIME_CORRECTION_UNSPEC;
 
 	return 0;
 }
-- 
2.25.1


