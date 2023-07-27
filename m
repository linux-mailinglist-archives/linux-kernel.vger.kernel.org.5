Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05AA76470B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjG0GkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjG0Gj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:39:59 -0400
Received: from mgamail.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C8B2129
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690439991; x=1721975991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2tUSZMdSmW/MZmHWfmtvUAfg03unaamp6z41Ty0I/Fk=;
  b=VE5KPygDoUrmAUBxeFBAT5ujtTGSW5Z/OEjLOMSsJUbawqLLaQlI0GLq
   S7eoIH9sesQ46aAcR0F8qVfS33QLnFXj7paRz6qQ/w71cAkQyD6SBD5+F
   vrawCUyWVkMfZl34kZODn9PBw91WfkbqP1ZcrgUV5bfs7nVAndwe75V8g
   7kVa1FodNeO3o7GRO0FonPSdrJBAaiIzYFP63uG5jBRQRf8WblUSWcF4+
   sCLOUod7+M9yN0QfS+9S3TIgShKjHFcfK4LqEAMyjEAJKw4Ce17grrmRn
   IYyqUEU1sBkRZlLjwRd/DyR6jww8IcBCIaBLXgCndLm0aaB5n0uFOoYCH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="454589658"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="454589658"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 23:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="792191955"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="792191955"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 23:39:47 -0700
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
Subject: [RFC PATCH 7/7] sched/stats: Track the scan number of groups during load balance
Date:   Thu, 27 Jul 2023 22:35:36 +0800
Message-Id: <e0176341d5b5186f36ea024fb0f1ca02dc7082a3.1690273854.git.yu.c.chen@intel.com>
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

This metric could be used to evaluate the load balance cost and
effeciency.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/topology.h | 1 +
 kernel/sched/fair.c            | 2 ++
 kernel/sched/stats.c           | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index af2261308529..fa8fc6a497fd 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -124,6 +124,7 @@ struct sched_domain {
 	unsigned int lb_hot_gained[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_nobusyg[CPU_MAX_IDLE_TYPES];
 	unsigned int lb_nobusyq[CPU_MAX_IDLE_TYPES];
+	unsigned int lb_sg_scan[CPU_MAX_IDLE_TYPES];
 
 	/* Active load balancing */
 	unsigned int alb_count;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9af57b5a24dc..96df7c5706d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10253,6 +10253,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 			goto next_group;
 
 
+		schedstat_inc(env->sd->lb_sg_scan[env->idle]);
+
 		if (update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
 			sds->busiest_stat = *sgs;
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..38608f791363 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -152,7 +152,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 				   cpumask_pr_args(sched_domain_span(sd)));
 			for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
 					itype++) {
-				seq_printf(seq, " %u %u %u %u %u %u %u %u",
+				seq_printf(seq, " %u %u %u %u %u %u %u %u %u",
 				    sd->lb_count[itype],
 				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
@@ -160,7 +160,8 @@ static int show_schedstat(struct seq_file *seq, void *v)
 				    sd->lb_gained[itype],
 				    sd->lb_hot_gained[itype],
 				    sd->lb_nobusyq[itype],
-				    sd->lb_nobusyg[itype]);
+				    sd->lb_nobusyg[itype],
+				    sd->lb_sg_scan[itype]);
 			}
 			seq_printf(seq,
 				   " %u %u %u %u %u %u %u %u %u %u %u %u\n",
-- 
2.25.1

