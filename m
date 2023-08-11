Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D59778D86
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbjHKLWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbjHKLWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916F83C23
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691752864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dJpzB/fb1HFalKHi8N2CUXmdY3xEPIYALd/hrby8FaA=;
        b=F26I2untM5W9uqAJQD6FaBYXcvcnXNlDYZKbvBdSQaFwameaZHI5ZmH/7i+N3JG0Qjn8yo
        ILNWEbV034mHG5U0gDINN3Sj7ES6wV+xU1b1ceTIUDAdRv5VPGLpP2Gh/lx7AY95lhGMxD
        TCm7KEPC7uQkY7MjxQE5Z9AAbBE5cTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-ceDkjaDcMDuNHrHDZH-Esg-1; Fri, 11 Aug 2023 07:21:01 -0400
X-MC-Unique: ceDkjaDcMDuNHrHDZH-Esg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C15A4856DED;
        Fri, 11 Aug 2023 11:21:00 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 256AB40C2063;
        Fri, 11 Aug 2023 11:20:59 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/rt: Make rt_rq->pushable_tasks updates drive rto_mask
Date:   Fri, 11 Aug 2023 12:20:44 +0100
Message-Id: <20230811112044.3302588-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Link: http://lore.kernel.org/r/20230801152648._y603AS_@linutronix.de
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
This is lightly tested, this looks to be working OK but I don't have nor am
I aware of a test case for RT balancing, I suppose we want something that
asserts we always run the N highest prio tasks for N CPUs, with a small
margin for migrations?
---
 kernel/sched/debug.c |  3 --
 kernel/sched/rt.c    | 70 +++++++-------------------------------------
 kernel/sched/sched.h |  2 --
 3 files changed, 10 insertions(+), 65 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4c3d0d9f3db63..b4f6fb592a123 100644
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
index 00e0e50741153..12100f3b6e5f2 100644
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
index 9c5035ca3b06d..bea6a9ec8cde0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -675,8 +675,6 @@ struct rt_rq {
 	} highest_prio;
 #endif
 #ifdef CONFIG_SMP
-	unsigned int		rt_nr_migratory;
-	unsigned int		rt_nr_total;
 	int			overloaded;
 	struct plist_head	pushable_tasks;
 
-- 
2.31.1

