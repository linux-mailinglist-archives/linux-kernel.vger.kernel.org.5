Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9FA777108
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjHJHK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjHJHK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:10:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE47FE64;
        Thu, 10 Aug 2023 00:10:55 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:10:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691651453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+t+Hn9BMuqn0HYD61DzGQMc+TnHT3KZlNg5KP22Z74=;
        b=0NAsilt6h+hcyW4zKfAbuXfRUb1UfKqYKi4KCmJUITOlxoRCubzriC2itYeYVYDRajpN/y
        wi8rOhuUY0QawmAosWIriOVfJGI7Xu6sdQp7EmfV3OIPMU2Nv+Muw57Jwy4EFZ++BZJRDj
        BrbUOaNJ2ZvgXzeefwz7p4L8dBS+zt6wHfeJdLSgQZ74J/7J3pA7ujj5LeJ0JADbaPOdpy
        vQkTL3LmCKkjRZ9mgFDmQSIAL2Sqbl22tVzhtCkbEkTOmAQhj27zDrqR2t04/tdq0N+XJ8
        t4YpacHXcXtl0JcAM67hq0wVVlrzk0KD6+fU99xIJzkIoE0nyo3qfnOrIPX5Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691651453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+t+Hn9BMuqn0HYD61DzGQMc+TnHT3KZlNg5KP22Z74=;
        b=y83y/SkAiwx2RemuNdF3ZM7ThgEkw0oT/xTZdmElXidezkoqmtPC5pISVKd+RVLPTEjnaw
        wLqBWORb3WtG5pAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Propagate enqueue flags into place_entity()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531124604.274010996@infradead.org>
References: <20230531124604.274010996@infradead.org>
MIME-Version: 1.0
Message-ID: <169165145291.27769.13852159578081861156.tip-bot2@tip-bot2>
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

Commit-ID:     d07f09a1f99cabbc86bc5c97d962eb8a466106b5
Gitweb:        https://git.kernel.org/tip/d07f09a1f99cabbc86bc5c97d962eb8a466106b5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 13:58:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Jul 2023 09:43:59 +02:00

sched/fair: Propagate enqueue flags into place_entity()

This allows place_entity() to consider ENQUEUE_WAKEUP and
ENQUEUE_MIGRATED.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230531124604.274010996@infradead.org
---
 kernel/sched/fair.c  | 10 +++++-----
 kernel/sched/sched.h |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 61747a2..5c8c9f7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4909,7 +4909,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 #endif /* CONFIG_SMP */
 
 static void
-place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
+place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 vslice = calc_delta_fair(se->slice, se);
 	u64 vruntime = avg_vruntime(cfs_rq);
@@ -4998,7 +4998,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 	 * on average, halfway through their slice, as such start tasks
 	 * off with half a slice to ease into the competition.
 	 */
-	if (sched_feat(PLACE_DEADLINE_INITIAL) && initial)
+	if (sched_feat(PLACE_DEADLINE_INITIAL) && (flags & ENQUEUE_INITIAL))
 		vslice /= 2;
 
 	/*
@@ -5022,7 +5022,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * update_curr().
 	 */
 	if (curr)
-		place_entity(cfs_rq, se, 0);
+		place_entity(cfs_rq, se, flags);
 
 	update_curr(cfs_rq);
 
@@ -5049,7 +5049,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * we can place the entity.
 	 */
 	if (!curr)
-		place_entity(cfs_rq, se, 0);
+		place_entity(cfs_rq, se, flags);
 
 	account_entity_enqueue(cfs_rq, se);
 
@@ -12280,7 +12280,7 @@ static void task_fork_fair(struct task_struct *p)
 	curr = cfs_rq->curr;
 	if (curr)
 		update_curr(cfs_rq);
-	place_entity(cfs_rq, se, 1);
+	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
 	rq_unlock(rq, &rf);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7ff9965..db58537 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2199,6 +2199,7 @@ extern const u32		sched_prio_to_wmult[40];
 #else
 #define ENQUEUE_MIGRATED	0x00
 #endif
+#define ENQUEUE_INITIAL		0x80
 
 #define RETRY_TASK		((void *)-1UL)
 
