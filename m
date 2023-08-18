Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B44F780C77
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377120AbjHRNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377104AbjHRNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:22:21 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7404273C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:22:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692364938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWiC7TwpXHefmJUjt4l0hnA6egWlnTJpUoNrKlCyRb8=;
        b=MnTRUDALMaABj73LWbuwW3NywPIes6lk5lyznl5AxujgC0tu+G1vXzysu4N9HyYvB5L1ST
        CGTAe47i3qF4XMS3FozXPCSpD/Hd/1eUuOSXyGCWS9owNpee+g4702Fol0iQ3m3/7hKzy/
        OjvZNh8iOyd2KNUizRr1dCiQHaN6/zo=
From:   chengming.zhou@linux.dev
To:     mingo@redhat.com, peterz@infradead.org, ycliang@andestech.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        zhouchengming@bytedance.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: Fix cfs_rq_is_decayed() on !SMP
Date:   Fri, 18 Aug 2023 21:21:48 +0800
Message-ID: <20230818132148.2237811-1-chengming.zhou@linux.dev>
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
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..05e004515fde 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4654,7 +4654,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
-	return true;
+	return !(cfs_rq->nr_running);
 }
 
 #define UPDATE_TG	0x0
-- 
2.41.0

