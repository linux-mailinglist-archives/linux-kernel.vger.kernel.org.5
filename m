Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206ED7D10B4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377395AbjJTNoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377074AbjJTNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:44:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F44A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VtM4fZvfkrGP76noU6hoHZ7O8+G+x3ssq63G10tuoB0=; b=FbZu5DGm6rwLX9Tb2SzEf9Jqqi
        ypsCIfvuVb7UuqsjmvA3xKHhsrOkP7XJCXM9EAIk93OK0ViQElE27AkiEPWmpZA03soRwDFgpWHEb
        HgvttCTMxpqDJA9S0EZFenzPXi/G3SgmaSF/8O70XRJSZpgcTt0EJoeijiZO9SYgl11f5OkCiZms6
        qx8zRNI+qdzjdqyPayxNvdRA129rhkdI/yXk2t86MRF5Nq4b4dSw/ArFdEOXH4yLcSYTZbTJxWdPZ
        oOIdLqjgHCarypugH3yY+KMwy9Cw2Q8HVmHbbz4i44CHbnPwAdua9UaDoEuUOOmNUEyD1STVw8Lro
        iFjCuLVg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtpms-00DQUw-Fn; Fri, 20 Oct 2023 13:43:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA0AB300392; Fri, 20 Oct 2023 15:43:37 +0200 (CEST)
Date:   Fri, 20 Oct 2023 15:43:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gautham.shenoy@amd.com, mgorman@suse.de, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        kprateek.nayak@amd.com, wuyun.abel@bytedance.com
Subject: [PATCH] sched/fair: Remove SIS_PROP
Message-ID: <20231020134337.GD33965@noisy.programming.kicks-ass.net>
References: <20231019033323.54147-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019033323.54147-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Since this had me looking at all that code, I did the below.

Holler if there's objections etc..

---
Subject: sched/fair: Remove SIS_PROP
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Oct 20 12:35:33 CEST 2023

SIS_UTIL seems to work well, lets remove the old thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/topology.h |    2 -
 kernel/sched/core.c            |    5 ----
 kernel/sched/fair.c            |   48 -----------------------------------------
 kernel/sched/features.h        |    1 
 kernel/sched/sched.h           |    3 --
 5 files changed, 59 deletions(-)

--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -109,8 +109,6 @@ struct sched_domain {
 	u64 max_newidle_lb_cost;
 	unsigned long last_decay_max_lb_cost;
 
-	u64 avg_scan_cost;		/* select_idle_sibling */
-
 #ifdef CONFIG_SCHEDSTATS
 	/* load_balance() stats */
 	unsigned int lb_count[CPU_MAX_IDLE_TYPES];
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3792,9 +3792,6 @@ ttwu_do_activate(struct rq *rq, struct t
 		if (rq->avg_idle > max)
 			rq->avg_idle = max;
 
-		rq->wake_stamp = jiffies;
-		rq->wake_avg_idle = rq->avg_idle / 2;
-
 		rq->idle_stamp = 0;
 	}
 #endif
@@ -9991,8 +9988,6 @@ void __init sched_init(void)
 		rq->online = 0;
 		rq->idle_stamp = 0;
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
-		rq->wake_stamp = jiffies;
-		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7209,45 +7209,9 @@ static int select_idle_cpu(struct task_s
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct sched_domain_shared *sd_share;
-	struct rq *this_rq = this_rq();
-	int this = smp_processor_id();
-	struct sched_domain *this_sd = NULL;
-	u64 time = 0;
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !has_idle_core) {
-		u64 avg_cost, avg_idle, span_avg;
-		unsigned long now = jiffies;
-
-		this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-		if (!this_sd)
-			return -1;
-
-		/*
-		 * If we're busy, the assumption that the last idle period
-		 * predicts the future is flawed; age away the remaining
-		 * predicted idle time.
-		 */
-		if (unlikely(this_rq->wake_stamp < now)) {
-			while (this_rq->wake_stamp < now && this_rq->wake_avg_idle) {
-				this_rq->wake_stamp++;
-				this_rq->wake_avg_idle >>= 1;
-			}
-		}
-
-		avg_idle = this_rq->wake_avg_idle;
-		avg_cost = this_sd->avg_scan_cost + 1;
-
-		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
-			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
-
-		time = cpu_clock(this);
-	}
-
 	if (sched_feat(SIS_UTIL)) {
 		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
 		if (sd_share) {
@@ -7301,18 +7265,6 @@ static int select_idle_cpu(struct task_s
 	if (has_idle_core)
 		set_idle_cores(target, false);
 
-	if (sched_feat(SIS_PROP) && this_sd && !has_idle_core) {
-		time = cpu_clock(this) - time;
-
-		/*
-		 * Account for the scan cost of wakeups against the average
-		 * idle time.
-		 */
-		this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
-
-		update_avg(&this_sd->avg_scan_cost, time);
-	}
-
 	return idle_cpu;
 }
 
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -49,7 +49,6 @@ SCHED_FEAT(TTWU_QUEUE, true)
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
-SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1059,9 +1059,6 @@ struct rq {
 	u64			idle_stamp;
 	u64			avg_idle;
 
-	unsigned long		wake_stamp;
-	u64			wake_avg_idle;
-
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
 
