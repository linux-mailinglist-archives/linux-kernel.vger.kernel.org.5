Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349E17646FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjG0Gi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjG0Giz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:38:55 -0400
Received: from mgamail.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73B42126
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690439931; x=1721975931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+i30E359f/fjXNg0MSHQoaPJ3cOlGNvB3S19we3sqc=;
  b=k1qb8VbYFgI87j71HDWzhVM/DQVHefJ3Va6C4cyTT4w0Z3NF4ikJgOyc
   5TyFOYRL2hM4ifQOGiz5PlKR0Pfw8SHUttosxaJRVuwf0DQQfbC9ZEFbY
   PGbI1E9GpK9MBqUikK0EzQ0bc0W5vyF7sOk+FRVYMg/VICoTCE+S+9CVt
   a1oZzKlacmDt8FuGXPg0HCzPq0MZCw2B5fAMQkNd/ri9bTgxPp3mHyQW9
   7pKeF1qwTZoSrqIkmOykAAYJg5RbcEytyl5w4RXJKsvMVadLNeWhkCN0O
   xRZaEIsI3qX8i1Twskch5+bOzOxV6QB8yvxedEcpwNfSJWwrv1L95Z9jv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347829661"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="347829661"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 23:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="973430014"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="973430014"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2023 23:38:48 -0700
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
Subject: [RFC PATCH 2/7] sched/topology: Introduce nr_groups in sched_domain to indicate the number of groups
Date:   Thu, 27 Jul 2023 22:34:36 +0800
Message-Id: <d4bb3b7f8911ef38e60138ec7b0a629062ae7c34.1690273854.git.yu.c.chen@intel.com>
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

Record the number of sched groups within each sched domain. Prepare for
newidle_balance() scan depth calculation introduced by ILB_UTIL.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/topology.c        | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 67b573d5bf28..c07f2f00317a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -152,6 +152,7 @@ struct sched_domain {
 	struct sched_domain_shared *shared;
 
 	unsigned int span_weight;
+	unsigned int nr_groups;
 	/*
 	 * Span of all CPUs in this domain.
 	 *
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64212f514765..56dc564fc9a3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1023,7 +1023,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 	struct cpumask *covered = sched_domains_tmpmask;
 	struct sd_data *sdd = sd->private;
 	struct sched_domain *sibling;
-	int i;
+	int i, nr_groups = 0;
 
 	cpumask_clear(covered);
 
@@ -1087,6 +1087,8 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		if (!sg)
 			goto fail;
 
+		nr_groups++;
+
 		sg_span = sched_group_span(sg);
 		cpumask_or(covered, covered, sg_span);
 
@@ -1100,6 +1102,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		last->next = first;
 	}
 	sd->groups = first;
+	sd->nr_groups = nr_groups;
 
 	return 0;
 
@@ -1233,7 +1236,7 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 	struct sd_data *sdd = sd->private;
 	const struct cpumask *span = sched_domain_span(sd);
 	struct cpumask *covered;
-	int i;
+	int i, nr_groups = 0;
 
 	lockdep_assert_held(&sched_domains_mutex);
 	covered = sched_domains_tmpmask;
@@ -1248,6 +1251,8 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 
 		sg = get_group(i, sdd);
 
+		nr_groups++;
+
 		cpumask_or(covered, covered, sched_group_span(sg));
 
 		if (!first)
@@ -1258,6 +1263,7 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 	}
 	last->next = first;
 	sd->groups = first;
+	sd->nr_groups = nr_groups;
 
 	return 0;
 }
-- 
2.25.1

