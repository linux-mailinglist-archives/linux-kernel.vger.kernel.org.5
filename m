Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89A77A1EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjIOM1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjIOM1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:27:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4E52120;
        Fri, 15 Sep 2023 05:27:01 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:26:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694780819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+vWFyP7OLMXcdpfdgf7/35HLZDxH06nBm9Y+bQWqeo=;
        b=JPvV6yCYVt/1BQ9FikRMMf+EgfMFd9p1Km6+5LTt9XmzDWzMnIoXFDI0gDod9oyAjIXLaA
        pEosRwZovzKHMc++VsmV0M8aYneknncou1GF7eU5+eqxGrGLJYNpHTdlLNYcXHZEknWz0+
        8vqv+ULs7CpL8uAHeTIrLx4m5KPDw3hEm1+KG5bQpJzd2SoUsnt3eEe3jVL9fCUZL0+yIS
        jUtpDTDgiRzPBNOqC+UGwJMGhDUz6qJqrCcVHbcGqZZz8LN5/ehgJpEP5pBmaWWJCy3cil
        rX336XHWsqL7a+G7vweY/r+qb9ppHLvSqPmn9km6s0zKxY8t4KvEU90PnOaS0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694780819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+vWFyP7OLMXcdpfdgf7/35HLZDxH06nBm9Y+bQWqeo=;
        b=5Bt1E/1RGu6XtvHgWS3t3VG3IB3XJIRUCCV8/pgccNdj7D/WTo4vENkOfjgiVb3R78M8TE
        GKe2AaAjkSomomDQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix cfs_rq_is_decayed() on !SMP
Cc:     "Leo Yu-Chi Liang" <ycliang@andestech.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230913132031.2242151-1-chengming.zhou@linux.dev>
References: <20230913132031.2242151-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Message-ID: <169478081914.27769.11548694919151227611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c0490bc9bb62d9376f3dd4ec28e03ca0fef97152
Gitweb:        https://git.kernel.org/tip/c0490bc9bb62d9376f3dd4ec28e03ca0fef97152
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Wed, 13 Sep 2023 13:20:31 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 14:24:00 +02:00

sched/fair: Fix cfs_rq_is_decayed() on !SMP

We don't need to maintain per-queue leaf_cfs_rq_list on !SMP, since
it's used for cfs_rq load tracking & balancing on SMP.

But sched debug interface uses it to print per-cfs_rq stats.

This patch fixes the !SMP version of cfs_rq_is_decayed(), so the
per-queue leaf_cfs_rq_list is also maintained correctly on !SMP,
to fix the warning in assert_list_leaf_cfs_rq().

Fixes: 0a00a354644e ("sched/fair: Delete useless condition in tg_unthrottle_up()")
Reported-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Closes: https://lore.kernel.org/all/ZN87UsqkWcFLDxea@swlinux02/
Link: https://lore.kernel.org/r/20230913132031.2242151-1-chengming.zhou@linux.dev
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41cfd61..c893721 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4866,7 +4866,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
-	return true;
+	return !cfs_rq->nr_running;
 }
 
 #define UPDATE_TG	0x0
