Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080577646FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjG0GjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjG0GjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:39:02 -0400
Received: from mgamail.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE5211C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690439942; x=1721975942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l95sHoi/sZGqMzpe1qc3INiDxsmM2Z+gfXv8zvoNc08=;
  b=KsNuKrgWn4bNZz+B6W/RX9Gd8g4XsNqd7JYZsvSy/tbbnvn/b/xy5YJz
   hjvbV2/B2AKnGlRL+s3cEE8ACdwtCZm2nVdC1tuDZ4VgiU/7jWgnuh0oV
   7XaBdGAhkoeZYhtrRiSL9FUkNisQK8Yqgq/gDdsCzBcmcD/OOYvLizm+C
   Fg+nSj9Qk10zMAxSuAVXTBexFzsLP/MAjvJiVcYi2G5gXlfDGbxpLZRAx
   MSDyFQE92ex5hsKP087/LPTzm0utQc72Ih/gV71Z7aEml0V3HrXa8uSrA
   OAfhjkl9VhCmGgOTu39kFVIR6dEtEpvmXp+T9DqAeTpdosvq9JcYlhOjk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="454589391"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="454589391"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 23:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="792191821"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="792191821"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 23:38:33 -0700
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
Subject: [RFC PATCH 1/7] sched/topology: Assign sd_share for all non NUMA sched domains
Date:   Thu, 27 Jul 2023 22:34:22 +0800
Message-Id: <169500eaa13198382765027eb047e6c7a0e5a13e.1690273854.git.yu.c.chen@intel.com>
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

Currently, only the domain with SD_SHARE_PKG_RESOURCES flag
would share 1 sd_share for every CPU in this domain. Remove this
restriction and extend it for other sched domains under NUMA
domain.

This shared field will be used by a later patch which optimizes
newidle balancing.

Suggested-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b2646ec4..64212f514765 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1641,10 +1641,10 @@ sd_init(struct sched_domain_topology_level *tl,
 	}
 
 	/*
-	 * For all levels sharing cache; connect a sched_domain_shared
+	 * For all levels except for NUMA; connect a sched_domain_shared
 	 * instance.
 	 */
-	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
+	if (!(sd->flags & SD_NUMA)) {
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
-- 
2.25.1

