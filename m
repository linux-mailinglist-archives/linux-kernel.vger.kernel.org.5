Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C356C78505B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjHWGI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjHWGI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:08:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEDCE5E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692770931; x=1724306931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sdc/4hyc6MH1ZUREceiYTlItE9ovvnlsb2WUgGGeoSs=;
  b=cGbEffjkKBRxKU1tbRr0Fdp5WdwzNXgvSRnvRb2rL5NsywUr+rgx4Sga
   kwLTUtzUWzLC2qgQzZvTMzNtDJqeuI8ZLXlaWYfRotTfTQ8yGkfn0DZFm
   DKznPMw/2OEIUxlQoifjPsDHWNG69h8sZxSXoELIj/QVKJgS8NXl1crJR
   GL7+BmCGU5v/RyQmOETnlUYOwwBm0WBsmq5I0TyKWfYglIKx47t4N/2IF
   Zk1q6ssN97x1nhZLG/CNkw1CFBzhFE8HFRrLE8mGia67FZS0KgyBfUQ8+
   X4+F6vTSVDCbOltsOwVBC6epXn9dLkOlP74RVKQQjrA79VsBRnttoXUjA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="364255272"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364255272"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 23:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="860201898"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="860201898"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 23:08:45 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
Date:   Wed, 23 Aug 2023 14:08:32 +0800
Message-ID: <20230823060832.454842-2-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823060832.454842-1-aaron.lu@intel.com>
References: <20230823060832.454842-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
per ms. After this change, the cost of accessing tg->load_avg is greatly
reduced and performance improved. Detailed test results below.

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
---
 kernel/sched/fair.c  | 13 ++++++++++++-
 kernel/sched/sched.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c28206499a3d..a5462d1fcc48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3664,7 +3664,8 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
  */
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
-	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
+	long delta;
+	u64 now;
 
 	/*
 	 * No need to update load_avg for root_task_group as it is not used.
@@ -3672,9 +3673,19 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	if (cfs_rq->tg == &root_task_group)
 		return;
 
+	/*
+	 * For migration heavy workload, access to tg->load_avg can be
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
index 6a8b7b9ed089..52ee7027def9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -593,6 +593,7 @@ struct cfs_rq {
 	} removed;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+	u64			last_update_tg_load_avg;
 	unsigned long		tg_load_avg_contrib;
 	long			propagate;
 	long			prop_runnable_sum;
-- 
2.41.0

