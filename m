Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60077B2DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjI2IXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjI2IXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:23:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283431A7;
        Fri, 29 Sep 2023 01:23:20 -0700 (PDT)
Date:   Fri, 29 Sep 2023 08:23:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695975796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qe51nWXzQO1uA4LEpD9VWuQ83YMo2vME02AfE+lfYRw=;
        b=dWz4FWyDLISmtoyDyHGbxdgNTO1mK3NbqapC1sCkn4Kq4q2Kjyk5lEbT78bjnBllRH3IbS
        XorNmOhEoI5RDooRS2yqZkYAbyszeByBrgZ+QGdN8PXeb0FsqqoiEdyCmvsSiTcCXXixId
        CQFPBrNpCZDXs46N+iNr7wY4QBBWk7qjH/k2zBeDUEPHCWggJCMiPjWml1iLcObxAKckGF
        FDvMfvZ2erVR7uI77yCG5drXSD2RkjBHD5DwIjHo0XJGSmdw8z5pdg4Eh/2pgb3QsToQ97
        i14CyE5xdPn7+PFzwBjITh1E0EQ6xP27yn04mFstj7OqgCFYtDevt2P6zGdQQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695975796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qe51nWXzQO1uA4LEpD9VWuQ83YMo2vME02AfE+lfYRw=;
        b=Q0rOQo3UA0+GRZ63+2lqN9ht7n7fhpY4/TO0/fDT/6J45U/ztOKsslfxgtBsw6xIw1MYWL
        6clv1eUJoYqQfrDQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Make dl_rq->pushable_dl_tasks
 update drive dl_rq->overloaded
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230928150251.463109-1-vschneid@redhat.com>
References: <20230928150251.463109-1-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <169597579563.27769.9947547101047504573.tip-bot2@tip-bot2>
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

Commit-ID:     5fe7765997b139e2d922b58359dea181efe618f9
Gitweb:        https://git.kernel.org/tip/5fe7765997b139e2d922b58359dea181efe618f9
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Thu, 28 Sep 2023 17:02:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Sep 2023 10:20:21 +02:00

sched/deadline: Make dl_rq->pushable_dl_tasks update drive dl_rq->overloaded

dl_rq->dl_nr_migratory is increased whenever a DL entity is enqueued and it has
nr_cpus_allowed > 1. Unlike the pushable_dl_tasks tree, dl_rq->dl_nr_migratory
includes a dl_rq's current task. This means a dl_rq can have a migratable
current, N non-migratable queued tasks, and be flagged as overloaded and have
its CPU set in the dlo_mask, despite having an empty pushable_tasks tree.

Make an dl_rq's overload logic be driven by {enqueue,dequeue}_pushable_dl_task(),
in other words make DL RQs only be flagged as overloaded if they have at
least one runnable-but-not-current migratable task.

 o push_dl_task() is unaffected, as it is a no-op if there are no pushable
   tasks.

 o pull_dl_task() now no longer scans runqueues whose sole migratable task is
   their current one, which it can't do anything about anyway.
   It may also now pull tasks to a DL RQ with dl_nr_running > 1 if only its
   current task is migratable.

Since dl_rq->dl_nr_migratory becomes unused, remove it.

RT had the exact same mechanism (rt_rq->rt_nr_migratory) which was dropped
in favour of relying on rt_rq->pushable_tasks, see:

  612f769edd06 ("sched/rt: Make rt_rq->pushable_tasks updates drive rto_mask")

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20230928150251.463109-1-vschneid@redhat.com
---
 kernel/sched/deadline.c | 57 +++++++++-------------------------------
 kernel/sched/debug.c    |  1 +-
 kernel/sched/sched.h    |  1 +-
 3 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fb1996a..d98408a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -509,7 +509,6 @@ void init_dl_rq(struct dl_rq *dl_rq)
 	/* zero means no -deadline tasks */
 	dl_rq->earliest_dl.curr = dl_rq->earliest_dl.next = 0;
 
-	dl_rq->dl_nr_migratory = 0;
 	dl_rq->overloaded = 0;
 	dl_rq->pushable_dl_tasks_root = RB_ROOT_CACHED;
 #else
@@ -553,39 +552,6 @@ static inline void dl_clear_overload(struct rq *rq)
 	cpumask_clear_cpu(rq->cpu, rq->rd->dlo_mask);
 }
 
-static void update_dl_migration(struct dl_rq *dl_rq)
-{
-	if (dl_rq->dl_nr_migratory && dl_rq->dl_nr_running > 1) {
-		if (!dl_rq->overloaded) {
-			dl_set_overload(rq_of_dl_rq(dl_rq));
-			dl_rq->overloaded = 1;
-		}
-	} else if (dl_rq->overloaded) {
-		dl_clear_overload(rq_of_dl_rq(dl_rq));
-		dl_rq->overloaded = 0;
-	}
-}
-
-static void inc_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
-{
-	struct task_struct *p = dl_task_of(dl_se);
-
-	if (p->nr_cpus_allowed > 1)
-		dl_rq->dl_nr_migratory++;
-
-	update_dl_migration(dl_rq);
-}
-
-static void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
-{
-	struct task_struct *p = dl_task_of(dl_se);
-
-	if (p->nr_cpus_allowed > 1)
-		dl_rq->dl_nr_migratory--;
-
-	update_dl_migration(dl_rq);
-}
-
 #define __node_2_pdl(node) \
 	rb_entry((node), struct task_struct, pushable_dl_tasks)
 
@@ -594,6 +560,11 @@ static inline bool __pushable_less(struct rb_node *a, const struct rb_node *b)
 	return dl_entity_preempt(&__node_2_pdl(a)->dl, &__node_2_pdl(b)->dl);
 }
 
+static inline int has_pushable_dl_tasks(struct rq *rq)
+{
+	return !RB_EMPTY_ROOT(&rq->dl.pushable_dl_tasks_root.rb_root);
+}
+
 /*
  * The list of pushable -deadline task is not a plist, like in
  * sched_rt.c, it is an rb-tree with tasks ordered by deadline.
@@ -609,6 +580,11 @@ static void enqueue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 				 __pushable_less);
 	if (leftmost)
 		rq->dl.earliest_dl.next = p->dl.deadline;
+
+	if (!rq->dl.overloaded) {
+		dl_set_overload(rq);
+		rq->dl.overloaded = 1;
+	}
 }
 
 static void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *p)
@@ -625,11 +601,11 @@ static void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 		dl_rq->earliest_dl.next = __node_2_pdl(leftmost)->dl.deadline;
 
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
-}
 
-static inline int has_pushable_dl_tasks(struct rq *rq)
-{
-	return !RB_EMPTY_ROOT(&rq->dl.pushable_dl_tasks_root.rb_root);
+	if (!has_pushable_dl_tasks(rq) && rq->dl.overloaded) {
+		dl_clear_overload(rq);
+		rq->dl.overloaded = 0;
+	}
 }
 
 static int push_dl_task(struct rq *rq);
@@ -1504,7 +1480,6 @@ void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 	add_nr_running(rq_of_dl_rq(dl_rq), 1);
 
 	inc_dl_deadline(dl_rq, deadline);
-	inc_dl_migration(dl_se, dl_rq);
 }
 
 static inline
@@ -1518,7 +1493,6 @@ void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 	sub_nr_running(rq_of_dl_rq(dl_rq), 1);
 
 	dec_dl_deadline(dl_rq, dl_se->deadline);
-	dec_dl_migration(dl_se, dl_rq);
 }
 
 static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
@@ -2291,9 +2265,6 @@ static int push_dl_task(struct rq *rq)
 	struct rq *later_rq;
 	int ret = 0;
 
-	if (!rq->dl.overloaded)
-		return 0;
-
 	next_task = pick_next_pushable_dl_task(rq);
 	if (!next_task)
 		return 0;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c4253bd..4580a45 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -745,7 +745,6 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 
 	PU(dl_nr_running);
 #ifdef CONFIG_SMP
-	PU(dl_nr_migratory);
 	dl_bw = &cpu_rq(cpu)->rd->dl_bw;
 #else
 	dl_bw = &dl_rq->dl_bw;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 41d760d..649eb9e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -707,7 +707,6 @@ struct dl_rq {
 		u64		next;
 	} earliest_dl;
 
-	unsigned int		dl_nr_migratory;
 	int			overloaded;
 
 	/*
