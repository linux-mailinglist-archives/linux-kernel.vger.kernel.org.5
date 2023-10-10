Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AA47BF168
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441995AbjJJD0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441902AbjJJD0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:26:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA3A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696908394; x=1728444394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XgAxHxx0m+/LUb93YgECCjq29DfkSIaXjYuumR5Xu5o=;
  b=KZ7jlQC7crD2nFh6HdwhHAMVTKKtZInagrZ9S2Uof98fQHr7/Br0ma0R
   EPsCVM3M7Vw8vQ8fVK8gRyQ0rVR1Bg1Yg40tEJim1yLfMmGXVFRy1XqGY
   vSY1wy6Qk9vQa4S3Zftem7+9wGu3+qEjnyGuruJjeTh09r1dQnp7eVunt
   8617UPHg8zUXBiPFl99IPgtSDpKy/sQSBHpAhbxxvVjbfb0bMiknObOZ6
   qBe1MSXikFdQbgO1Xwm08l1bIibGbv2mLQ4ujWOZX7c+t/6nQuDwYxKAF
   MQLW5GHi5lmjlyANCOSF3ZrVdnAPRmXgqx29L44EItFB3poKtfKUsrLRa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="5857304"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="5857304"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 20:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877060947"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="877060947"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga004.jf.intel.com with ESMTP; 09 Oct 2023 20:26:30 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] sched/fair: Use printk_deferred instead of printk in pick_eevdf()
Date:   Tue, 10 Oct 2023 11:25:41 +0800
Message-Id: <20231010032541.339606-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When no eligible entity is found in pick_eevdf(), it has to pick
the entity with smallest vruntime. This indicates a potential issue
and scheduler will print this error.

However this printk could introduce possible circular locking issue
because when the code path reaches here with the rq lock held, the
printk could trigger further scheduling which loops back to the
scheduler.

Use printk_deferred() to defer the console write from current context
to the irq work in the next tick.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Suggested-by: Phil Auld <pauld@redhat.com>
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 061a30a8925a..70f38e54b6ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -973,7 +973,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (!se) {
 		struct sched_entity *left = __pick_first_entity(cfs_rq);
 		if (left) {
-			pr_err("EEVDF scheduling fail, picking leftmost\n");
+			printk_deferred(KERN_ERR "EEVDF scheduling fail, picking leftmost\n");
 			return left;
 		}
 	}
-- 
2.25.1

