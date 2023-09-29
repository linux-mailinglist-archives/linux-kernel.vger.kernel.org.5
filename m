Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF3E7B2DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjI2Ije (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjI2IjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:39:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA046CDB;
        Fri, 29 Sep 2023 01:39:03 -0700 (PDT)
Date:   Fri, 29 Sep 2023 08:39:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695976742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D4SoccUJ1iRFQ6pLoGlPK0NevgRuIS+B+21NT0IjnfA=;
        b=lBH43LqDFtW9fUiABB8CX7BUow9C189hKV1Xfwa1839Bdv5KVcXbj8NAHfNNj4Bu57Wqby
        1pr0OszTGvDwvyxNqzeWdvmGlZLHBhnsMk7QwkN9PbOPb4M/2JrX9zgtSwwIww6AgZ2JfI
        ZI/7X0ujbMVs6+28+qMONO0Es/lBra0lEmfwQjQ36iK3EMFhru3PuDqTsyP8Gs70br9IJK
        CfXrfusKMFL/4bD5QN7o1eu82R7aJ61c1xT+tP+BPDDLhd3dlmRt8UtaWrDzsR0JYlyvQA
        l3EOsR4VUEOt+6+4OwgL/WDV0pGQ/3P2bGKQu/GI1BJbyMpVz7YmI+SqsL9MTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695976742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D4SoccUJ1iRFQ6pLoGlPK0NevgRuIS+B+21NT0IjnfA=;
        b=+8f6XyEZcRgLZsK1KGPbpLBLTdVsxSpS49svnd2Bu0tEOY3uKfERN5i8vbEClDUmSoCOlS
        nAKcBhzpveoM6FAA==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
Cc:     "Qais Yousef (Google)" <qyousef@layalina.io>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230916232955.2099394-3-qyousef@layalina.io>
References: <20230916232955.2099394-3-qyousef@layalina.io>
MIME-Version: 1.0
Message-ID: <169597674169.27769.13480580087727084162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     23c9519def98ee0fa97ea5871535e9b136f522fc
Gitweb:        https://git.kernel.org/tip/23c9519def98ee0fa97ea5871535e9b136f522fc
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Sun, 17 Sep 2023 00:29:54 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Sep 2023 10:29:14 +02:00

sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0

find_energy_efficient_cpu() bails out early if effective util of the
task is 0 as the delta at this point will be zero and there's nothing
for EAS to do. When uclamp is being used, this could lead to wrong
decisions when uclamp_max is set to 0. In this case the task is capped
to performance point 0, but it is actually running and consuming energy
and we can benefit from EAS energy calculations.

Rework the condition so that it bails out when both util and uclamp_min
are 0.

We can do that without needing to use uclamp_task_util(); remove it.

Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230916232955.2099394-3-qyousef@layalina.io
---
 kernel/sched/fair.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4ce949b..284b0ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4558,22 +4558,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
 	return max(task_util(p), _task_util_est(p));
 }
 
-#ifdef CONFIG_UCLAMP_TASK
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return clamp(task_util_est(p), uclamp_min, uclamp_max);
-}
-#else
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return task_util_est(p);
-}
-#endif
-
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
@@ -7695,7 +7679,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!uclamp_task_util(p, p_util_min, p_util_max))
+	if (!task_util_est(p) && p_util_min == 0)
 		goto unlock;
 
 	eenv_task_busy_time(&eenv, p, prev_cpu);
