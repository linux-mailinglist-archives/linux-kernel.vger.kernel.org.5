Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615F679E909
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjIMNUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjIMNUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:20:52 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [IPv6:2001:41d0:203:375::e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C78119B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:20:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694611246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dGhSbIt4RVsf+l8/Z6SCikAFiRLpLiL6j7bY+eiV6Nw=;
        b=SZfDph77D9h6faQahZjHb4VP48K4rDDbsGXJ/Jqo7W2cH7w5/fjxBlzXM0mo1cKekinlMU
        RhyMIT/hAp2UTHvbAdsXCgUe0/xWQv5IEShi/j8SX9VBBPqvKF+sgMQFrMzzXiwjhOhRAM
        hGvEzr8pcs11qBSoiKlPv6bfYsJjHBc=
From:   chengming.zhou@linux.dev
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Leo Yu-Chi Liang <ycliang@andestech.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: Fix cfs_rq_is_decayed() on !SMP
Date:   Wed, 13 Sep 2023 13:20:31 +0000
Message-Id: <20230913132031.2242151-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

We don't need to maintain per-queue leaf_cfs_rq_list on !SMP, since
it's used for cfs_rq load tracking & balance on SMP.

But sched debug interface use it to print per-cfs_rq stats, which
maybe better to change to use walk_tg_tree_from() instead.

This patch just fix the !SMP version cfs_rq_is_decayed(), so the
per-queue leaf_cfs_rq_list is also maintained correctly on !SMP,
to fix the warning in assert_list_leaf_cfs_rq().

Fixes: 0a00a354644e ("sched/fair: Delete useless condition in tg_unthrottle_up()")
Reported-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Closes: https://lore.kernel.org/all/ZN87UsqkWcFLDxea@swlinux02/
Tested-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dbff6e7ad4f..845d7729320e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4878,7 +4878,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
-	return true;
+	return !(cfs_rq->nr_running);
 }
 
 #define UPDATE_TG	0x0
-- 
2.40.1

