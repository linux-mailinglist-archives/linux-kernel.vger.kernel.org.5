Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE08F780B34
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376697AbjHRLhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjHRLhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:37:25 -0400
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0C32112
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:37:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692358641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwuMU31i52eXX7WZ8tamkiAB+NMwfrqul9QTqbLwW1k=;
        b=FREjPnRJBTA4SKfe38+9UDgLA5SDOHkXA2IgSC8WJsiWXWwIn+9Jbic+lMl/qOzi0RZYzp
        wBhr2UJAaOnWjupgojWDIFDQqnDR6hSXwym1LjF9UwSdeydLv9r7bnCiPUlhWcEJXxQdhR
        GjiIIP/4PZVnnyEtYBJq08yAQH536BA=
From:   chengming.zhou@linux.dev
To:     mingo@redhat.com, peterz@infradead.org, ycliang@andestech.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        zhouchengming@bytedance.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix cfs_rq_is_decayed() on !SMP
Date:   Fri, 18 Aug 2023 19:35:37 +0800
Message-ID: <20230818113537.2231129-1-chengming.zhou@linux.dev>
In-Reply-To: <ZN87UsqkWcFLDxea@swlinux02>
References: <ZN87UsqkWcFLDxea@swlinux02>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reported-by: Leo Liang <ycliang@andestech.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..00ef7e86a95b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4654,6 +4654,8 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
+	if (cfs_rq->load.weight)
+		return false;
 	return true;
 }
 
-- 
2.41.0

