Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECA07F5C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344609AbjKWKa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWKaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:30:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857BB1A8;
        Thu, 23 Nov 2023 02:30:31 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:30:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700735430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trfyvi6MbJesxcsRP4W62yufX/0CgsLs8XGabx+92Bo=;
        b=L6Qcn/9e7P3K926jTTlxdaenBq994wa3zCvGQmqMS0dJMgfO5s3TSJ7jFQgUv1IUPo0ui/
        L4t1OtelGrFCjqJ60BthSoTF1jelkeMMZQUPYKFMWlH8CRIFTsU5LV6bNvQhkUfm2FnqiS
        Roz0++Tfq9hKTgk+9HSMRTrbzXtFJAygZZcLnmZw24UnhHXSutri1OnuTXwb5KO31BQvgo
        ztEEn5kH3SjTdNP33xSGE35MKo+X5gq4x+gq6zmExQe+JQN7aap1tjC/tMzrasQeacbgkl
        pKCue1kqiSWEg4t3AajF5jQfEjgbk+vAgslxt4PMG96ukaFQYHsUdRARquIveg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700735430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=trfyvi6MbJesxcsRP4W62yufX/0CgsLs8XGabx+92Bo=;
        b=ptONsAgoo7+FVD6kaLTsUHcxSSLMWGbMfVAkzSFF1JY6By0ocu0G3IU4E0E34NQRFf3ly5
        +LSW8Ew7NhZRAgDw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Avoid underestimation of task utilization
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Hongyan Xia <hongyan.xia2@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231122140119.472110-1-vincent.guittot@linaro.org>
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <170073542912.398.8772998793614415245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     50181c0cff31281b9f1071575ffba8a102375ece
Gitweb:        https://git.kernel.org/tip/50181c0cff31281b9f1071575ffba8a102375ece
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 22 Nov 2023 15:01:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Nov 2023 11:24:28 +01:00

sched/pelt: Avoid underestimation of task utilization

Lukasz Luba reported that a thread's util_est can significantly decrease as
a result of sharing the CPU with other threads.

The use case can be easily reproduced with a periodic task TA that runs 1ms
and sleeps 100us. When the task is alone on the CPU, its max utilization and
its util_est is around 888. If another similar task starts to run on the
same CPU, TA will have to share the CPU runtime and its maximum utilization
will decrease around half the CPU capacity (512) then TA's util_est will
follow this new maximum trend which is only the result of sharing the CPU
with others tasks.

Such situation can be detected with runnable_avg wich is close or
equal to util_avg when TA is alone, but increases above util_avg when TA
shares the CPU with other threads and wait on the runqueue.

[ We prefer an util_est that overestimate rather than under estimate
  because in 1st case we will not provide enough performance to the
  task which will remain under-provisioned, whereas in the other case we
  will create some idle time which will enable to reduce contention and
  as a result reduces the util_est so the overestimate will be transient
  whereas the underestimate will remain. ]

[ mingo: Refined the changelog, added comments from the LKML discussion. ]

Reported-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/lkml/CAKfTPtDd-HhF-YiNTtL9i5k0PfJbF819Yxu4YquzfXgwi7voyw@mail.gmail.com/#t
Link: https://lore.kernel.org/r/20231122140119.472110-1-vincent.guittot@linaro.org
Cc: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 07f5558..53dea95 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4774,6 +4774,11 @@ static inline unsigned long task_util(struct task_struct *p)
 	return READ_ONCE(p->se.avg.util_avg);
 }
 
+static inline unsigned long task_runnable(struct task_struct *p)
+{
+	return READ_ONCE(p->se.avg.runnable_avg);
+}
+
 static inline unsigned long _task_util_est(struct task_struct *p)
 {
 	struct util_est ue = READ_ONCE(p->se.avg.util_est);
@@ -4893,6 +4898,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 		return;
 
 	/*
+	 * To avoid underestimate of task utilization, skip updates of EWMA if
+	 * we cannot grant that thread got all CPU time it wanted.
+	 */
+	if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
+		goto done;
+
+
+	/*
 	 * Update Task's estimated utilization
 	 *
 	 * When *p completes an activation we can consolidate another sample
