Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A39764703
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjG0Gjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjG0Gjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:39:40 -0400
Received: from mgamail.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590D82691
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690439978; x=1721975978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzTClbz4y9JgCaxQftHb02vD+LpQaxd1CzkR8WFoPIc=;
  b=Jj+p/CZwq4Xakgbg+72efVluWfNCyi2bbd8OtadglPtPtmaAmIo0wzOx
   4JBdBVAjEN+EbXASbc26zInFmS6mm7yXrTAtZEsc1cuRnGQ8IBSxpYQ+Y
   +1NDyhGsr6NjjiarQXnF1urZ1gl96TvfNVfpS/mhU4h/i2kyWTexpISuj
   u7lyxp2tOPPzh4dKcKzvDLy6ABIwHt/Im+/oTGaY/Eyv/z5jZQInASJt2
   pb3cZdxVKhi0mLW8gTg/eHTJb+D5tWEKmMzat5nqhrafRk4JCZ+midZSO
   gp4yp7W1vukSNcvkguctASKt4uJe201yhWc6YT6SZRJw4V8pC6fPwZOKg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347829789"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="347829789"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 23:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="973430346"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="973430346"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2023 23:39:11 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 4/7] sched/fair: Calculate the scan depth for idle balance based on system utilization
Date:   Thu, 27 Jul 2023 22:35:02 +0800
Message-Id: <61e6fce60ca738215b6e5ad9033fb692c3a8fbb1.1690273854.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690273854.git.yu.c.chen@intel.com>
References: <cover.1690273854.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CPU is about to enter idle, it invokes newidle_balance()
to pull some tasks from other runqueues. Although there is per
domain max_newidle_lb_cost to throttle the newidle_balance(), it
would be good to further limit the scan based on overall system
utilization. The reason is that there is no limitation for
newidle_balance() to launch this balance simultaneously on
multiple CPUs. Since each newidle_balance() has to traverse all
the groups to calculate the statistics one by one, this total
time cost on newidle_balance() could be O(n^2). n is the number
of groups. This issue is more severe if there are many groups
within 1 domain, for example, a system with a large number of
Cores in a LLC domain. This is not good for performance or
power saving.

sqlite has spent quite some time on newidle balance() on Intel
Sapphire Rapids, which has 2 x 56C/112T = 224 CPUs:
6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats

Based on this observation, limit the scan depth of newidle_balance()
by considering the utilization of the sched domain. Let the number of
scanned groups be a linear function of the utilization ratio:

nr_groups_to_scan = nr_groups * (1 - util_ratio)

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 30 ++++++++++++++++++++++++++++++
 kernel/sched/features.h        |  1 +
 3 files changed, 32 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index d6a64a2c92aa..af2261308529 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -84,6 +84,7 @@ struct sched_domain_shared {
 	int		nr_idle_scan;
 	unsigned long	total_load;
 	unsigned long	total_capacity;
+	int		nr_sg_scan;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index edcfee9965cd..6925813db59b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10153,6 +10153,35 @@ static void ilb_save_stats(struct lb_env *env,
 		WRITE_ONCE(sd_share->total_capacity, sds->total_capacity);
 }
 
+static void update_ilb_group_scan(struct lb_env *env,
+				  unsigned long sum_util,
+				  struct sched_domain_shared *sd_share)
+{
+	u64 tmp, nr_scan;
+
+	if (!sched_feat(ILB_UTIL))
+		return;
+
+	if (!sd_share)
+		return;
+
+	if (env->idle == CPU_NEWLY_IDLE)
+		return;
+
+	/*
+	 * Limit the newidle balance scan depth based on overall system
+	 * utilization:
+	 * nr_groups_scan = nr_groups * (1 - util_ratio)
+	 * and util_ratio = sum_util / (sd_weight * SCHED_CAPACITY_SCALE)
+	 */
+	nr_scan = env->sd->nr_groups * sum_util;
+	tmp = env->sd->span_weight * SCHED_CAPACITY_SCALE;
+	do_div(nr_scan, tmp);
+	nr_scan = env->sd->nr_groups - nr_scan;
+	if ((int)nr_scan != sd_share->nr_sg_scan)
+		WRITE_ONCE(sd_share->nr_sg_scan, (int)nr_scan);
+}
+
 /**
  * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10231,6 +10260,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 
 	update_idle_cpu_scan(env, sum_util);
+	update_ilb_group_scan(env, sum_util, sd_share);
 
 	/* save a snapshot of stats during periodic load balance */
 	ilb_save_stats(env, sd_share, sds);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3cb71c8cddc0..30f6d1a2f235 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -103,3 +103,4 @@ SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
 
 SCHED_FEAT(ILB_SNAPSHOT, true)
+SCHED_FEAT(ILB_UTIL, true)
-- 
2.25.1

