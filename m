Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430347646FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjG0GjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjG0GjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:39:05 -0400
Received: from mgamail.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4007B211C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690439944; x=1721975944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gUXqBihJZoZ1Pmai0lJ204qnaiDMkb9JwZjj8InTaZc=;
  b=cm8VOyHLWxH3hb0BSCMV0gGOajMCl02SxzyxctQkizFHtR7MdAXflfwj
   c+S7owqC4aX8TFAZDwOWbfnL+LBHnLeVxiD7bKHoJdj23PR7rl8zblkgh
   krrTlCjUUuId+wW4OJGa+wjuNZcyiGebyvUVLv5KNBlFGEUPYmz9HDFN5
   WKNV4nS2Wjab1lXWVTOCzPa7Uw34A1RkzNssxOM38PkLd24940DGkDABC
   ODn65DxWNBA2H29q38/HArs5+ipfnbMfdyZU6QNEWqLl/OxDNGU7kGhw1
   9/fsWjbH/zQB7OzQ+7SZGPUpTqaooPymNyEC2LFP70sQdXM8FUuzZ6XFl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347829721"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="347829721"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 23:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="973430138"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="973430138"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2023 23:39:00 -0700
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
Subject: [RFC PATCH 3/7] sched/fair: Save a snapshot of sched domain total_load and total_capacity
Date:   Thu, 27 Jul 2023 22:34:50 +0800
Message-Id: <0d71de8648889fe8b202be376e97d581ff3f12ed.1690273854.git.yu.c.chen@intel.com>
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

Save the total_load, total_capacity of the current sched domain in each
periodic load balance. This statistic can be used later by CPU_NEWLY_IDLE
load balance if it quits the scan earlier. Introduce a sched feature
ILB_SNAPSHOT to control this. Code can check if sd_share->total_capacity
is non-zero to verify if the stat is valid.

In theory, if the system has reached a stable status, the total_capacity
and total_load should not change dramatically.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/topology.h |  2 ++
 kernel/sched/fair.c            | 25 +++++++++++++++++++++++++
 kernel/sched/features.h        |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c07f2f00317a..d6a64a2c92aa 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -82,6 +82,8 @@ struct sched_domain_shared {
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
 	int		nr_idle_scan;
+	unsigned long	total_load;
+	unsigned long	total_capacity;
 };
 
 struct sched_domain {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be58e2b..edcfee9965cd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10132,6 +10132,27 @@ static void update_idle_cpu_scan(struct lb_env *env,
 		WRITE_ONCE(sd_share->nr_idle_scan, (int)y);
 }
 
+static void ilb_save_stats(struct lb_env *env,
+			   struct sched_domain_shared *sd_share,
+			   struct sd_lb_stats *sds)
+{
+	if (!sched_feat(ILB_SNAPSHOT))
+		return;
+
+	if (!sd_share)
+		return;
+
+	/* newidle balance is too frequent */
+	if (env->idle == CPU_NEWLY_IDLE)
+		return;
+
+	if (sds->total_load != sd_share->total_load)
+		WRITE_ONCE(sd_share->total_load, sds->total_load);
+
+	if (sds->total_capacity != sd_share->total_capacity)
+		WRITE_ONCE(sd_share->total_capacity, sds->total_capacity);
+}
+
 /**
  * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10140,6 +10161,7 @@ static void update_idle_cpu_scan(struct lb_env *env,
 
 static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
 {
+	struct sched_domain_shared *sd_share = env->sd->shared;
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
@@ -10209,6 +10231,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 
 	update_idle_cpu_scan(env, sum_util);
+
+	/* save a snapshot of stats during periodic load balance */
+	ilb_save_stats(env, sd_share, sds);
 }
 
 /**
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..3cb71c8cddc0 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -101,3 +101,5 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(ILB_SNAPSHOT, true)
-- 
2.25.1

