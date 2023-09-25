Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1767AD3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjIYIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjIYIzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:55:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986EFB;
        Mon, 25 Sep 2023 01:55:13 -0700 (PDT)
Date:   Mon, 25 Sep 2023 08:55:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695632111;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q31cEdcsxiFRVVBHu5LL3//ICViWhol4VLKuQGmofH8=;
        b=GlCGcm1iw8uExGjEiYsFzZaUXf2ioEJzvKmXeS4hZfXawEdjF4CLGtTcEo8e9Z4vZhxz6b
        sH0HrO0NQyk5u6R41dYP/57YGbUDmn4nYZ6ft4RW4v89cExoj3mNmcUFoEev9A3JcSYFPn
        K8ENDKO1rOc3WvS9vCuKbFyU84Xo+OQqMLy0MmYAHErPxsEjl3euVTW51A7TAHCxN73fV8
        mZDu431mb33mc3Ix6UOm2MFm5LiBTMan5mPcvj0S8vnlWQY20htFmBmRPHWLuSPmrw9kh/
        KDcRWw9UIa+QPyAiUkJfGuYw646etTfHd4AG9REeaQ2+2SR1+ewskcK9tu2WOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695632111;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q31cEdcsxiFRVVBHu5LL3//ICViWhol4VLKuQGmofH8=;
        b=LwnK6evj+GYUw8aZZ0EJtBUJOgegJvptQ0LTmW4D4ERzbM3QLRHreLENXbttOU54uUCxJ8
        FsxnIMsPDnRhnJBA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Make rt_rq->pushable_tasks updates drive rto_mask
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230811112044.3302588-1-vschneid@redhat.com>
References: <20230811112044.3302588-1-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <169563211069.27769.17070510461354463740.tip-bot2@tip-bot2>
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

Commit-ID:     612f769edd06a6e42f7cd72425488e68ddaeef0a
Gitweb:        https://git.kernel.org/tip/612f769edd06a6e42f7cd72425488e68ddaeef0a
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Fri, 11 Aug 2023 12:20:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Sep 2023 10:25:29 +02:00

sched/rt: Make rt_rq->pushable_tasks updates drive rto_mask

Sebastian noted that the rto_push_work IRQ work can be queued for a CPU
that has an empty pushable_tasks list, which means nothing useful will be
done in the IPI other than queue the work for the next CPU on the rto_mask.

rto_push_irq_work_func() only operates on tasks in the pushable_tasks list,
but the conditions for that irq_work to be queued (and for a CPU to be
added to the rto_mask) rely on rq_rt->nr_migratory instead.

nr_migratory is increased whenever an RT task entity is enqueued and it has
nr_cpus_allowed > 1. Unlike the pushable_tasks list, nr_migratory includes a
rt_rq's current task. This means a rt_rq can have a migratible current, N
non-migratible queued tasks, and be flagged as overloaded / have its CPU
set in the rto_mask, despite having an empty pushable_tasks list.

Make an rt_rq's overload logic be driven by {enqueue,dequeue}_pushable_task().
Since rt_rq->{rt_nr_migratory,rt_nr_total} become unused, remove them.

Note that the case where the current task is pushed away to make way for a
migration-disabled task remains unchanged: the migration-disabled task has
to be in the pushable_tasks list in the first place, which means it has
nr_cpus_allowed > 1.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20230811112044.3302588-1-vschneid@redhat.com
---
 kernel/sched/debug.c |  3 +--
 kernel/sched/rt.c    | 70 ++++++-------------------------------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 10 insertions(+), 65 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 5e34a8c..c4253bd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -724,9 +724,6 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(rt_rq->x))
 
 	PU(rt_nr_running);
-#ifdef CONFIG_SMP
-	PU(rt_nr_migratory);
-#endif
 	P(rt_throttled);
 	PN(rt_time);
 	PN(rt_runtime);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3e442fa..3b627ab 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -143,7 +143,6 @@ void init_rt_rq(struct rt_rq *rt_rq)
 #if defined CONFIG_SMP
 	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
 	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
-	rt_rq->rt_nr_migratory = 0;
 	rt_rq->overloaded = 0;
 	plist_head_init(&rt_rq->pushable_tasks);
 #endif /* CONFIG_SMP */
@@ -358,53 +357,6 @@ static inline void rt_clear_overload(struct rq *rq)
 	cpumask_clear_cpu(rq->cpu, rq->rd->rto_mask);
 }
 
-static void update_rt_migration(struct rt_rq *rt_rq)
-{
-	if (rt_rq->rt_nr_migratory && rt_rq->rt_nr_total > 1) {
-		if (!rt_rq->overloaded) {
-			rt_set_overload(rq_of_rt_rq(rt_rq));
-			rt_rq->overloaded = 1;
-		}
-	} else if (rt_rq->overloaded) {
-		rt_clear_overload(rq_of_rt_rq(rt_rq));
-		rt_rq->overloaded = 0;
-	}
-}
-
-static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
-{
-	struct task_struct *p;
-
-	if (!rt_entity_is_task(rt_se))
-		return;
-
-	p = rt_task_of(rt_se);
-	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
-
-	rt_rq->rt_nr_total++;
-	if (p->nr_cpus_allowed > 1)
-		rt_rq->rt_nr_migratory++;
-
-	update_rt_migration(rt_rq);
-}
-
-static void dec_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
-{
-	struct task_struct *p;
-
-	if (!rt_entity_is_task(rt_se))
-		return;
-
-	p = rt_task_of(rt_se);
-	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
-
-	rt_rq->rt_nr_total--;
-	if (p->nr_cpus_allowed > 1)
-		rt_rq->rt_nr_migratory--;
-
-	update_rt_migration(rt_rq);
-}
-
 static inline int has_pushable_tasks(struct rq *rq)
 {
 	return !plist_head_empty(&rq->rt.pushable_tasks);
@@ -438,6 +390,11 @@ static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
 	/* Update the highest prio pushable task */
 	if (p->prio < rq->rt.highest_prio.next)
 		rq->rt.highest_prio.next = p->prio;
+
+	if (!rq->rt.overloaded) {
+		rt_set_overload(rq);
+		rq->rt.overloaded = 1;
+	}
 }
 
 static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
@@ -451,6 +408,11 @@ static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 		rq->rt.highest_prio.next = p->prio;
 	} else {
 		rq->rt.highest_prio.next = MAX_RT_PRIO-1;
+
+		if (rq->rt.overloaded) {
+			rt_clear_overload(rq);
+			rq->rt.overloaded = 0;
+		}
 	}
 }
 
@@ -464,16 +426,6 @@ static inline void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 {
 }
 
-static inline
-void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
-{
-}
-
-static inline
-void dec_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
-{
-}
-
 static inline void rt_queue_push_tasks(struct rq *rq)
 {
 }
@@ -1281,7 +1233,6 @@ void inc_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	rt_rq->rr_nr_running += rt_se_rr_nr_running(rt_se);
 
 	inc_rt_prio(rt_rq, prio);
-	inc_rt_migration(rt_se, rt_rq);
 	inc_rt_group(rt_se, rt_rq);
 }
 
@@ -1294,7 +1245,6 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	rt_rq->rr_nr_running -= rt_se_rr_nr_running(rt_se);
 
 	dec_rt_prio(rt_rq, rt_se_prio(rt_se));
-	dec_rt_migration(rt_se, rt_rq);
 	dec_rt_group(rt_se, rt_rq);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 96f8ab7..41d760d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -663,8 +663,6 @@ struct rt_rq {
 	} highest_prio;
 #endif
 #ifdef CONFIG_SMP
-	unsigned int		rt_nr_migratory;
-	unsigned int		rt_nr_total;
 	int			overloaded;
 	struct plist_head	pushable_tasks;
 
