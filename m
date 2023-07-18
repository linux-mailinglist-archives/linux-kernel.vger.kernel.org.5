Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E2757DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjGRNlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjGRNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:41:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF8D18E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689687701; x=1721223701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8F3zASvnELjb+rrDSMq0b/VVlZEErX5L3+l5y/KLAD4=;
  b=lg0SDFlI9LP3Sgx4BVgQaQ/SyWDkm9qRXKgATSeCH3Gw7idHqaUnz07l
   ifPJ7284YG2ReUcPkZeBTPboy2dJAkJFQYFz8W+KkgF9BLJ1talROClsV
   1VXk+fzqizLOzEkbbEtjVFdv151F47aRFKrNAAcHiw2ePU/oZtNRGXgPs
   H7vr2uot4/koI1YZRPySTaHNMis/IE3l0ljVNby1usFvUMDlm8bsabzSw
   kziX0H2OCnQu0s2HFlmM+h8+6YFda88aByRhCxV1WzBiWPylrIJ6Ey701
   lz0oJwhjB5CX0e1kknHlgTUKursVF7Ni1LGMetNQqRvxY3kDg1LOieO9n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345800716"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345800716"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847706530"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847706530"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:37 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for cfs_rq's removed load
Date:   Tue, 18 Jul 2023 21:41:19 +0800
Message-ID: <20230718134120.81199-4-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718134120.81199-1-aaron.lu@intel.com>
References: <20230718134120.81199-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a workload involves many wake time task migrations, tg->load_avg
can be heavily contended among CPUs because every migration involves
removing the task's load from its src cfs_rq and attach that load to
its new cfs_rq. Both the remove and attach requires an update to
tg->load_avg as well as propagating the change up the hierarchy.

E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
Sappire Rapids, during a 5s window, the wakeup number is 14millions and
migration number is 11millions. Since the workload can trigger many
wakeups and migrations, the access(both read and write) to tg->load_avg
can be unbound. For the above said workload, the profile shows
update_cfs_group() costs ~13% and update_load_avg() costs ~10%. With
netperf/nr_client=nr_cpu/UDP_RR, the wakeup number is 21millions and
migration number is 14millions; update_cfs_group() costs ~25% and
update_load_avg() costs ~16%.

This patch is an attempt to reduce the cost of accessing tg->load_avg.

Current logic will immediately do a update_tg_load_avg() if cfs_rq has
removed load; this patch changes this behavior: if this cfs_rq has
removed load as discovered by update_cfs_rq_load_avg(), it didn't call
update_tg_load_avg() or propagate the removed load immediately, instead,
the update to tg->load_avg and propagated load can be dealed with by a
following event like task attached to this cfs_rq or in
update_blocked_averages(). This way, the call to update_tg_load_avg()
for this cfs_rq and its ancestors can be reduced by about half.

================================================
postgres_sysbench(transaction, higher is better)
nr_thread=100%/75%/50% were tested on 2 sockets SPR and Icelake and
results that have a measuable difference are:

nr_thread=100% on SPR:
base:   90569.11±1.15%
node:  104152.26±0.34%  +15.0%
delay: 127309.46±4.25%  +40.6%

nr_thread=75% on SPR:
base:  100803.96±0.57%
node:  107333.58±0.44%   +6.5%
delay: 124332.39±0.51%  +23.3%

nr_thread=75% on ICL:
base:  61961.26±0.41%
node:  61585.45±0.50%
delay: 72420.52±0.14%  +16.9%

=======================================================================
hackbench/pipe/threads/fd=20/loop=1000000 (throughput, higher is better)
group=1/4/8/16 were tested on 2 sockets SPR and Cascade lake and the
results that have a measuable difference are:

group=8 on SPR:
base:  437163±2.6%
node:  471203±1.2%   +7.8%
delay: 490780±0.9%  +12.3%

group=16 on SPR:
base:  468279±1.9%
node:  580385±1.7%  +23.9%
delay: 664422±0.2%  +41.9%

================================================
netperf/TCP_STRAM (throughput, higher is better)
nr_thread=1/25%/50%/75%/100% were tested on 2 sockets SPR and Cascade
Lake and results that have a measuable difference are:

nr_thread=50% on CSL:
base:  16258±0.7%
node:  16172±2.9%
delay: 17729±0.7%  +9.0%

nr_thread=75% on CSL:
base:  12923±1.2%
node:  13011±2.2%
delay: 15452±1.6%  +19.6%

nr_thread=75% on SPR:
base:  16232±11.9%
node:  13962±5.1%
delay: 21089±0.8%  +29.9%

nr_thread=100% on SPR:
base:  13220±0.6%
node:  13113±0.0%
delay: 18258±11.3% +38.1%

=============================================
netperf/UDP_RR (throughput, higher is better)
nr_thread=1/25%/50%/75%/100% were tested on 2 sockets SPR and Cascade
Lake and results that have measuable difference are:

nr_thread=1 on CSL:
base:  128521±0.5%
node:  127935±0.6%
delay: 126317±0.4%  -1.7%

nr_thread=75% on CSL:
base:  36701±1.7%
node:  39949±1.4%   +8.8%
delay: 42516±0.3%  +15.8%

nr_thread=75% on SPR:
base:  14249±3.8%
node:  19890±2.0%   +39.6%
delay: 31331±0.5%  +119.9%

nr_thread=100% on CSL:
base:  52275±0.6%
node:  53827±0.4%   +3.0%
delay: 78386±0.7%  +49.9%

nr_thread=100% on SPR:
base:   9560±1.6%
node:  14186±3.9%   +48.4%
delay: 20779±2.8%  +117.4%

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 kernel/sched/fair.c  | 23 ++++++++++++++++++-----
 kernel/sched/sched.h |  1 +
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aceb8f5922cb..564ffe3e59c1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3645,6 +3645,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
 
+	if (cfs_rq->prop_removed_sum)
+		return false;
+
 	return true;
 }
 
@@ -3911,6 +3914,11 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 {
 	cfs_rq->propagate = 1;
 	cfs_rq->prop_runnable_sum += runnable_sum;
+
+	if (cfs_rq->prop_removed_sum) {
+		cfs_rq->prop_runnable_sum += cfs_rq->prop_removed_sum;
+		cfs_rq->prop_removed_sum = 0;
+	}
 }
 
 /* Update task and its cfs_rq load average */
@@ -4133,13 +4141,11 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		 * removed_runnable is the unweighted version of removed_load so we
 		 * can use it to estimate removed_load_sum.
 		 */
-		add_tg_cfs_propagate(cfs_rq,
-			-(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
-
-		decayed = 1;
+		cfs_rq->prop_removed_sum +=
+			-(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT;
 	}
 
-	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
+	decayed = __update_load_avg_cfs_rq(now, cfs_rq);
 	u64_u32_store_copy(sa->last_update_time,
 			   cfs_rq->last_update_time_copy,
 			   sa->last_update_time);
@@ -9001,6 +9007,13 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 
 			if (cfs_rq == &rq->cfs)
 				decayed = true;
+
+			/*
+			 * If the aggregated removed_sum hasn't been taken care of,
+			 * deal with it now before this cfs_rq is removed from the list.
+			 */
+			if (cfs_rq->prop_removed_sum)
+				add_tg_cfs_propagate(cfs_rq, 0);
 		}
 
 		/* Propagate pending load changes to the parent, if any: */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9cece2dbc95b..ab540b21d071 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -619,6 +619,7 @@ struct cfs_rq {
 	unsigned long		tg_load_avg_contrib;
 	long			propagate;
 	long			prop_runnable_sum;
+	long			prop_removed_sum;
 
 	/*
 	 *   h_load = weight * f(tg)
-- 
2.41.0

