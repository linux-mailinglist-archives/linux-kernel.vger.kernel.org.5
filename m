Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6A7E8B68
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 16:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjKKPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 10:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 10:44:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B42C4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 07:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699717465; x=1731253465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N61T92yXfW/0ymwwtf27YmFi1YNwp0sVTZf9lYAfMjs=;
  b=W4nnjKy0HjX7OauSEfM8WL7b1UuhphDf5/Wo1y/Q4V2NwdGxidMSDuRJ
   FsNxhOlfrBRKrUeKbIq3S+OkxeYn9h4xpx2DiDow66VNc3HcWllUymToV
   Txay3P6hlw5qIlbqqwORCZlSDE5DCNu2MPO5Gjo2rxJrZevbkkFFPfHdq
   x7np/wbGJSnhfwzwbAeK3FpqcZixeqXY2sw9NNy2s0tZaJkGyAgkdRdRU
   8o1DQqgBCdAxdWbHO1LMtVj1sMdEOBqfK7ELZj5y2nEcSSFmNcfkYZzBq
   WnXXit5/xfHeqscIZnxWtEcEMc0HSw3Zl2+BwT1IhpRYAJeg0LtYrsKag
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="11833007"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="11833007"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 07:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="1095392438"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="1095392438"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2023 07:44:22 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] sched/fair: Remove unnecessary 'curr' reset for pick_next_entity()
Date:   Sat, 11 Nov 2023 23:43:18 +0800
Message-Id: <20231111154318.87777-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 4c456c9ad334 ("sched/fair: Remove unused 'curr'
argument from pick_next_entity()"), there is no need to
reset 'curr' to NULL because it will not be used by
pick_next_entity().

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2048138ce54b..ddea1be43710 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8198,8 +8198,6 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 		if (curr) {
 			if (curr->on_rq)
 				update_curr(cfs_rq);
-			else
-				curr = NULL;
 
 			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
 				goto again;
@@ -8249,8 +8247,6 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		if (curr) {
 			if (curr->on_rq)
 				update_curr(cfs_rq);
-			else
-				curr = NULL;
 
 			/*
 			 * This call to check_cfs_rq_runtime() will do the
-- 
2.25.1

