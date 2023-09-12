Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48A79C74A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjILG6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjILG6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:58:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3341DE7C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694501909; x=1726037909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1CVeoZ5eX0aMEMe3Na4QWZn6jXaWrpbe+otIrf8FLTQ=;
  b=LtiPgkPrqkzciNojGtOPOBcz84UGsz5NiOrjuBx+i5NABZitRbav+rLe
   J/Uv0PgPqiXmiF/XqXqdTz5obkTVUV6CHWDBi9C/NKHU4dg3qdcoC5ALf
   XfAqutg3tKBTvMA6O9Kr1upo5e1iDnqw1lGvo+H5rH0sL1itvN3r4ihh2
   O22vz4B3e+dN0BK3r1wlRUXnl7U3ks5EIv0kErYnHBjeKvAC+N+7A305G
   l4f8lmRoKFF0EeWgEDOEyGWjAa9Mj/6Hmp6o3h6cPVBZE6uTrOWWP4UBB
   6Xg8gUfFNqAFVIRDVzhtJEHOttXTnD6gPJgURqzIqK4FSMlxzcI1U2XqE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358571028"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="358571028"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746762655"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="746762655"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:58:25 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] sched/fair: ratelimit update to tg->load_avg
Date:   Tue, 12 Sep 2023 14:58:08 +0800
Message-ID: <20230912065808.2530-2-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912065808.2530-1-aaron.lu@intel.com>
References: <20230912065808.2530-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using sysbench to benchmark Postgres in a single docker instance
with sysbench's nr_threads set to nr_cpu, it is observed there are times
update_cfs_group() and update_load_avg() shows noticeable overhead on
a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):

    13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
    10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg

Annotate shows the cycles are mostly spent on accessing tg->load_avg
with update_load_avg() being the write side and update_cfs_group() being
the read side. tg->load_avg is per task group and when different tasks
of the same taskgroup running on different CPUs frequently access
tg->load_avg, it can be heavily contended.

E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
Sappire Rapids, during a 5s window, the wakeup number is 14millions and
migration number is 11millions and with each migration, the task's load
will transfer from src cfs_rq to target cfs_rq and each change involves
an update to tg->load_avg. Since the workload can trigger as many wakeups
and migrations, the access(both read and write) to tg->load_avg can be
unbound. As a result, the two mentioned functions showed noticeable
overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
during a 5s window, wakeup number is 21millions and migration number is
14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.

Reduce the overhead by limiting updates to tg->load_avg to at most once
per ms. The update frequency is a tradeoff between tracking accuracy and
overhead. 1ms is chosen because PELT window is roughly 1ms and it
delivered good results for the tests that I've done. After this change,
the cost of accessing tg->load_avg is greatly reduced and performance
improved. Detailed test results below.

==============================
postgres_sysbench on SPR:
25%
base:   42382±19.8%
patch:  50174±9.5%  (noise)

50%
base:   67626±1.3%
patch:  67365±3.1%  (noise)

75%
base:   100216±1.2%
patch:  112470±0.1% +12.2%

100%
base:    93671±0.4%
patch:  113563±0.2% +21.2%

==============================
hackbench on ICL:
group=1
base:    114912±5.2%
patch:   117857±2.5%  (noise)

group=4
base:    359902±1.6%
patch:   361685±2.7%  (noise)

group=8
base:    461070±0.8%
patch:   491713±0.3% +6.6%

group=16
base:    309032±5.0%
patch:   378337±1.3% +22.4%

=============================
hackbench on SPR:
group=1
base:    100768±2.9%
patch:   103134±2.9%  (noise)

group=4
base:    413830±12.5%
patch:   378660±16.6% (noise)

group=8
base:    436124±0.6%
patch:   490787±3.2% +12.5%

group=16
base:    457730±3.2%
patch:   680452±1.3% +48.8%

============================
netperf/udp_rr on ICL
25%
base:    114413±0.1%
patch:   115111±0.0% +0.6%

50%
base:    86803±0.5%
patch:   86611±0.0%  (noise)

75%
base:    35959±5.3%
patch:   49801±0.6% +38.5%

100%
base:    61951±6.4%
patch:   70224±0.8% +13.4%

===========================
netperf/udp_rr on SPR
25%
base:   104954±1.3%
patch:  107312±2.8%  (noise)

50%
base:    55394±4.6%
patch:   54940±7.4%  (noise)

75%
base:    13779±3.1%
patch:   36105±1.1% +162%

100%
base:     9703±3.7%
patch:   28011±0.2% +189%

==============================================
netperf/tcp_stream on ICL (all in noise range)
25%
base:    43092±0.1%
patch:   42891±0.5%

50%
base:    19278±14.9%
patch:   22369±7.2%

75%
base:    16822±3.0%
patch:   17086±2.3%

100%
base:    18216±0.6%
patch:   18078±2.9%

===============================================
netperf/tcp_stream on SPR (all in noise range)
25%
base:    34491±0.3%
patch:   34886±0.5%

50%
base:    19278±14.9%
patch:   22369±7.2%

75%
base:    16822±3.0%
patch:   17086±2.3%

100%
base:    18216±0.6%
patch:   18078±2.9%

Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Tested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: David Vernet <void@manifault.com>
Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
---
 kernel/sched/fair.c  | 13 ++++++++++++-
 kernel/sched/sched.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b7445cd5af9..0dd6f44c8e02 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3887,7 +3887,8 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
  */
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
-	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
+	long delta;
+	u64 now;
 
 	/*
 	 * No need to update load_avg for root_task_group as it is not used.
@@ -3895,9 +3896,19 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	if (cfs_rq->tg == &root_task_group)
 		return;
 
+	/*
+	 * For migration heavy workloads, access to tg->load_avg can be
+	 * unbound. Limit the update rate to at most once per ms.
+	 */
+	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
+	if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
+		return;
+
+	delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
 	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
 		atomic_long_add(delta, &cfs_rq->tg->load_avg);
 		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
+		cfs_rq->last_update_tg_load_avg = now;
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3a01b7a2bf66..7df010ef9e5c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -594,6 +594,7 @@ struct cfs_rq {
 	} removed;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+	u64			last_update_tg_load_avg;
 	unsigned long		tg_load_avg_contrib;
 	long			propagate;
 	long			prop_runnable_sum;
-- 
2.41.0

