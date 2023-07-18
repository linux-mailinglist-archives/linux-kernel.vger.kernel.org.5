Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B881757DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGRNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjGRNle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:41:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA928D1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689687693; x=1721223693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vAuW7kn5P49yEV9cQ8npEoDT7TB1IR2RrGZ1EvUpxo=;
  b=S1Rel40Aym6AL47/843YZ3ZQz7zQ9ZY9NmiiDBnnKny0QlKL3Xs1ewpL
   kY9rQB/+qhrtfEEcCTj63vlDuxnXL0X8veFSDVM4sNABl6keCNlpZvXf8
   xRa8MbJa6rp+wsgfR3rTRMhjCEhPphdNJH00EHjTu15vC6/Too3JhGMng
   XEksF/C19tRJH/p+Hio7Yp/2TjPDvE49GzlROQFFkQUAXILVhrl6fK31P
   Ww2epB7YmE8BR4s8pc4EwxgLFk0SRgHyUZvRvol7XtJ15xdCuvxAw8Ia7
   NbuOB/7nNH9wrTJy1mIRzP3tgfuX04a96AOJiYux+q+huHG1iPg9h1BeJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345800670"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345800670"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847706517"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847706517"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:29 -0700
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
Subject: [PATCH 1/4] sched/fair: free allocated memory on error in alloc_fair_sched_group()
Date:   Tue, 18 Jul 2023 21:41:17 +0800
Message-ID: <20230718134120.81199-2-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718134120.81199-1-aaron.lu@intel.com>
References: <20230718134120.81199-1-aaron.lu@intel.com>
MIME-Version: 1.0
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

There is one struct cfs_rq and one struct se on each cpu for a taskgroup
and when allocation for tg->cfs_rq[X] failed, the already allocated
tg->cfs_rq[0]..tg->cfs_rq[X-1] should be freed. The same for tg->se.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 kernel/sched/fair.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..0f913487928d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12443,10 +12443,10 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
 	if (!tg->cfs_rq)
-		goto err;
+		return 0;
 	tg->se = kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
 	if (!tg->se)
-		goto err;
+		goto err_free_rq_pointer;
 
 	tg->shares = NICE_0_LOAD;
 
@@ -12456,12 +12456,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
 				      GFP_KERNEL, cpu_to_node(i));
 		if (!cfs_rq)
-			goto err;
+			goto err_free;
 
 		se = kzalloc_node(sizeof(struct sched_entity_stats),
 				  GFP_KERNEL, cpu_to_node(i));
 		if (!se)
-			goto err_free_rq;
+			goto err_free;
 
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
@@ -12470,9 +12470,18 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	return 1;
 
-err_free_rq:
-	kfree(cfs_rq);
-err:
+err_free:
+	for_each_possible_cpu(i) {
+		kfree(tg->cfs_rq[i]);
+		kfree(tg->se[i]);
+
+		if (!tg->cfs_rq[i] && !tg->se[i])
+			break;
+	}
+	kfree(tg->se);
+err_free_rq_pointer:
+	kfree(tg->cfs_rq);
+
 	return 0;
 }
 
-- 
2.41.0

