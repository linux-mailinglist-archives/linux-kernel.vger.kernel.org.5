Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB55B750FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjGLRgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGLRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:36:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E061BD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689183375; x=1720719375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L2w7h+1zojcVdKco4DovJ69ANkFD1mq7GmkWM2ppddQ=;
  b=eYwnbqnE39MEk5CxU5XFlxl7j7QO5UjH0UZaHzjV7OxxtXKZf2+EcPk8
   gDFunCBjWX/j/YESFA/BAfD7UGwm2Z6ibt55Mw6frAX/FLKYj1DeGHq/a
   CXFddYIrd20tyilcKBd31vH+2eUEtf813iz8i4SZ8wKuTqF5w8qHM/6df
   ZyAg2QxC4hBeCWHFhbsV3Nnd1n7pu57J22gfLUKiZK3V/Sm5APEeBlkZX
   EPKRULvj6ngP580kP3bhU+MBiCaP3fgpg7fnCcmEWCE+GeHmSrxkWN83B
   ieMUs1YB335/IGj5I84Z4FAWhea0vPsme9BUTW8TukShXc1HNRct4PMxx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="451318710"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="451318710"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="845734325"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="845734325"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2023 10:36:05 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] sched/topology: Align group flags when removing degenerate domain
Date:   Thu, 13 Jul 2023 09:31:33 +0800
Message-Id: <20230713013133.2314153-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flags of the child of a given scheduling domain are used to initialize
the flags of its scheduling groups. When the child of a scheduling domain
is degenerated, the flags of its local scheduling group need to be updated
to align with the flags of its new child domain.

The flag SD_SHARE_CPUCAPACITY was aligned in
Commit bf2dc42d6beb ("sched/topology: Propagate SMT flags when removing degenerate domain").
Further generalize this alignment so other flags can be used later, such as
in cluster-based task wakeup. [1]

Link: https://lore.kernel.org/lkml/20230530115527.GC156198@hirez.programming.kicks-ass.net #1
Suggested-by: Ricardo Neri <ricardo.neri@intel.com>
Reported-by: Yicong Yang <yangyicong@huawei.com>
Closes: https://lore.kernel.org/lkml/ce714341-af58-2522-69a8-321f02c82893@huawei.com/
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b2646ec4..ff02d7deec0c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -722,8 +722,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 
 			if (parent->parent) {
 				parent->parent->child = tmp;
-				if (tmp->flags & SD_SHARE_CPUCAPACITY)
-					parent->parent->groups->flags |= SD_SHARE_CPUCAPACITY;
+				parent->parent->groups->flags = tmp->flags;
 			}
 
 			/*
-- 
2.25.1

