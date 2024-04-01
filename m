Return-Path: <linux-kernel+bounces-127195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD1F8947E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54D81C22045
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8FD5A7AE;
	Mon,  1 Apr 2024 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zcnTYtE6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800659154
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015103; cv=none; b=ZQ1xv3Ty+a+ldMPeyArIdO4d416AFa75xU7DrTVzuNlcu7h8cBtlYhPHo64w89tRmvPReemXoL3Y7E1FEfxuYQXUFUC28JPbl78DBNZD8RyEyp4r5Bc/MF7nTvuJaXNJEt1jT4ILEAT0riJ3Y13Wj0sao8eaa1ADFYHxbQkSa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015103; c=relaxed/simple;
	bh=UlgV0iwnPFw7IxBIDMnrfvJMQaCGP41ulv2iimr5ifY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jfQhyKe5kD8dBHGYhIZEYd78WFsfR5jqLx2JiKEdT/wcqKz7AgxHxXe6T+RexJadoHqToeydRPT1nFYIPwMarxT5U+NG4r61aeOrC71ihbH1SK3ZX7xNORGscObzSUfXzJ1RbtamLmitsJJrWYg3B7CtcD+CABYnZG40WQdxB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zcnTYtE6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so10222857b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015100; x=1712619900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ieO+YRFZMYvEQA8u4UdE5lIEEp9nBxeDRqnvo1OFcE0=;
        b=zcnTYtE6K7/edPUcmorooKHm+LQMQKZzAEyWOHJQHgHSZ7DqOTaRr5nlsAzIuolJD4
         GoI6+rF1K2ZQtktjFo7jcKi2Hs92MiyOnRR/PyraM0OIYv7e140DY0HlhlvamlPD8I4E
         ry/2mucUtCRaspGtsm8z5f7wlc0ywgGFpp3QJ9QrHVwA4Y/9bvIMHqcJSuc8pV63lJOh
         zVIKWGIaipdiquCYfSoCqrHvaQo1souxhWz3k+MtjdmXHYQUsGJCIhjQXFH8cH9MqV2v
         /1iEe1uFoTzeroWACtfzL8DYZIeirxbCxxcomBOALXhzs45va9sAKLPb2+IRTI9GbM/W
         nmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015100; x=1712619900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieO+YRFZMYvEQA8u4UdE5lIEEp9nBxeDRqnvo1OFcE0=;
        b=agDVgEGG4RSJ1EJkrjb4GPq9rCjrHNAEa5wBWb/0UBWHFivCCmsJ8/dJ2VLqwSS6VB
         DfQsjXBXxOyMNtGOaQtD0NyCURP9MP54nda/e4vPqHd2Y4ST0G3EldRQsnk2SVtGMxhu
         g6jJFM8pRA6w1OsHN8KoBjKiH5bzHcpezSc1VTMMICNyxXMZgkoTCQ7Y6l31wfkAB4+b
         1uQAmcPET8pl/yVTuMJk+aWaEU/fO6KPACmIYAiQhSGviU/ecuk92O41jDBwpg+tCpJV
         8UKjjAL8aTvsuhDeW1hTZW1t1an73A3VeXM9mXRnnWCa+BCQvdAMeGlInnBkYfoBjOlB
         qD6A==
X-Gm-Message-State: AOJu0YyurIlqcj12TTu70/47/kb9IBwz3TcTCbX86x2FnfzjvqAUrUz+
	u7SIRLhC4i6iOTwU4o9SQJ3j8dhk5Z9jSOdk+YmzXSaoKOsHVVbNZDqsL1lb9cZAO9Mu+W3kfx+
	8wNI+lo982Dk+p4V3maboYCoiYoojXHnfCHvik7RmlmNzQ3n1v80uAr73dKuYjzXHMfpZKwOmQh
	fR+wosz1/6xdHQCjB3ZHMjyMR0MK7+GMLoKd7/OVzEsDso
X-Google-Smtp-Source: AGHT+IFavg0aaTt5sTrnLzgiB9nQVzaD5FwMuD/VgjJ9jSM9u/yoh/MDlKD48IR8awDMXz9RHp48FxDeDqkd
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a0d:e202:0:b0:615:1579:8660 with SMTP id
 l2-20020a0de202000000b0061515798660mr283363ywe.7.1712015099638; Mon, 01 Apr
 2024 16:44:59 -0700 (PDT)
Date: Mon,  1 Apr 2024 16:44:29 -0700
In-Reply-To: <20240401234439.834544-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234439.834544-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234439.834544-8-jstultz@google.com>
Subject: [RESEND][PATCH v9 7/7] sched: Split scheduler and execution contexts
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Metin Kaya <Metin.Kaya@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Let's define the scheduling context as all the scheduler state
in task_struct for the task selected to run, and the execution
context as all state required to actually run the task.

Currently both are intertwined in task_struct. We want to
logically split these such that we can use the scheduling
context of the task selected to be scheduled, but use the
execution context of a different task to actually be run.

To this purpose, introduce rq_selected() macro to point to the
task_struct selected from the runqueue by the scheduler, and
will be used for scheduler state, and preserve rq->curr to
indicate the execution context of the task that will actually be
run.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20181009092434.26221-5-juri.lelli@redhat.com
[add additional comments and update more sched_class code to use
 rq::proxy]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Rebased and resolved minor collisions, reworked to use
 accessors, tweaked update_curr_common to use rq_proxy fixing rt
 scheduling issues]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Reworked to use accessors
* Fixed update_curr_common to use proxy instead of curr
v3:
* Tweaked wrapper names
* Swapped proxy for selected for clarity
v4:
* Minor variable name tweaks for readability
* Use a macro instead of a inline function and drop
  other helper functions as suggested by Peter.
* Remove verbose comments/questions to avoid review
  distractions, as suggested by Dietmar
v5:
* Add CONFIG_PROXY_EXEC option to this patch so the
  new logic can be tested with this change
* Minor fix to grab rq_selected when holding the rq lock
v7:
* Minor spelling fix and unused argument fixes suggested by
  Metin Kaya
* Switch to curr_selected for consistency, and minor rewording
  of commit message for clarity
* Rename variables selected instead of curr when we're using
  rq_selected()
* Reduce macros in CONFIG_SCHED_PROXY_EXEC ifdef sections,
  as suggested by Metin Kaya
v8:
* Use rq->curr, not rq_selected with task_tick, as suggested by
  Valentin
* Minor rework to reorder this with CONFIG_SCHED_PROXY_EXEC patch
---
 kernel/sched/core.c     | 46 ++++++++++++++++++++++++++---------------
 kernel/sched/deadline.c | 35 ++++++++++++++++---------------
 kernel/sched/fair.c     | 18 ++++++++--------
 kernel/sched/rt.c       | 40 +++++++++++++++++------------------
 kernel/sched/sched.h    | 25 ++++++++++++++++++++--
 5 files changed, 99 insertions(+), 65 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0eaa0855ef86..3a21f5e903bf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -794,7 +794,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
+	rq_selected(rq)->sched_class->task_tick(rq, rq->curr, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -2236,16 +2236,18 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->sched_class == rq->curr->sched_class)
-		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
-	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
+	struct task_struct *selected = rq_selected(rq);
+
+	if (p->sched_class == selected->sched_class)
+		selected->sched_class->wakeup_preempt(rq, p, flags);
+	else if (sched_class_above(p->sched_class, selected->sched_class))
 		resched_curr(rq);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
+	if (task_on_rq_queued(selected) && test_tsk_need_resched(rq->curr))
 		rq_clock_skip_update(rq);
 }
 
@@ -2772,7 +2774,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 
 	if (queued) {
 		/*
@@ -5596,7 +5598,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * project cycles that may never be accounted to this
 	 * thread, breaking clock_gettime().
 	 */
-	if (task_current(rq, p) && task_on_rq_queued(p)) {
+	if (task_current_selected(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
@@ -5664,7 +5666,8 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
+	/* accounting goes to the selected task */
+	struct task_struct *selected;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
 	u64 resched_latency;
@@ -5675,16 +5678,17 @@ void scheduler_tick(void)
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
+	selected = rq_selected(rq);
 
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
-	curr->sched_class->task_tick(rq, curr, 0);
+	selected->sched_class->task_tick(rq, selected, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, curr);
+	task_tick_mm_cid(rq, selected);
 
 	rq_unlock(rq, &rf);
 
@@ -5693,8 +5697,8 @@ void scheduler_tick(void)
 
 	perf_event_task_tick();
 
-	if (curr->flags & PF_WQ_WORKER)
-		wq_worker_tick(curr);
+	if (selected->flags & PF_WQ_WORKER)
+		wq_worker_tick(selected);
 
 #ifdef CONFIG_SMP
 	rq->idle_balance = idle_cpu(cpu);
@@ -5759,6 +5763,12 @@ static void sched_tick_remote(struct work_struct *work)
 		struct task_struct *curr = rq->curr;
 
 		if (cpu_online(cpu)) {
+			/*
+			 * Since this is a remote tick for full dynticks mode,
+			 * we are always sure that there is no proxy (only a
+			 * single task is running).
+			 */
+			SCHED_WARN_ON(rq->curr != rq_selected(rq));
 			update_rq_clock(rq);
 
 			if (!is_idle_task(curr)) {
@@ -6712,6 +6722,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+	rq_set_selected(rq, next);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -7222,7 +7233,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -7312,7 +7323,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	if (running)
@@ -7891,7 +7902,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
@@ -9318,6 +9329,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->idle = idle;
+	rq_set_selected(rq, idle);
 	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
@@ -9407,7 +9419,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -10512,7 +10524,7 @@ void sched_move_task(struct task_struct *tsk)
 
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_current_selected(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1b9cdb507498..c30b592d6e9d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1218,7 +1218,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 #endif
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
-	if (dl_task(rq->curr))
+	if (dl_task(rq_selected(rq)))
 		wakeup_preempt_dl(rq, p, 0);
 	else
 		resched_curr(rq);
@@ -1442,7 +1442,7 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
  */
 static void update_curr_dl(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 	struct sched_dl_entity *dl_se = &curr->dl;
 	s64 delta_exec;
 
@@ -1899,7 +1899,7 @@ static int find_later_rq(struct task_struct *task);
 static int
 select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *selected;
 	bool select_rq;
 	struct rq *rq;
 
@@ -1910,6 +1910,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	selected = READ_ONCE(rq_selected(rq));
 
 	/*
 	 * If we are dealing with a -deadline task, we must
@@ -1920,9 +1921,9 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	 * other hand, if it has a shorter deadline, we
 	 * try to make it stay here, it might be important.
 	 */
-	select_rq = unlikely(dl_task(curr)) &&
+	select_rq = unlikely(dl_task(selected)) &&
 		    (curr->nr_cpus_allowed < 2 ||
-		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
+		     !dl_entity_preempt(&p->dl, &selected->dl)) &&
 		    p->nr_cpus_allowed > 1;
 
 	/*
@@ -1985,7 +1986,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * let's hope p can move out.
 	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq->curr, NULL))
+	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), NULL))
 		return;
 
 	/*
@@ -2024,7 +2025,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
-	if (dl_entity_preempt(&p->dl, &rq->curr->dl)) {
+	if (dl_entity_preempt(&p->dl, &rq_selected(rq)->dl)) {
 		resched_curr(rq);
 		return;
 	}
@@ -2034,7 +2035,7 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
 	 */
-	if ((p->dl.deadline == rq->curr->dl.deadline) &&
+	if ((p->dl.deadline == rq_selected(rq)->dl.deadline) &&
 	    !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
@@ -2066,7 +2067,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (!first)
 		return;
 
-	if (rq->curr->sched_class != &dl_sched_class)
+	if (rq_selected(rq)->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
@@ -2391,8 +2392,8 @@ static int push_dl_task(struct rq *rq)
 	 * can move away, it makes sense to just reschedule
 	 * without going further in pushing next_task.
 	 */
-	if (dl_task(rq->curr) &&
-	    dl_time_before(next_task->dl.deadline, rq->curr->dl.deadline) &&
+	if (dl_task(rq_selected(rq)) &&
+	    dl_time_before(next_task->dl.deadline, rq_selected(rq)->dl.deadline) &&
 	    rq->curr->nr_cpus_allowed > 1) {
 		resched_curr(rq);
 		return 0;
@@ -2515,7 +2516,7 @@ static void pull_dl_task(struct rq *this_rq)
 			 * deadline than the current task of its runqueue.
 			 */
 			if (dl_time_before(p->dl.deadline,
-					   src_rq->curr->dl.deadline))
+					   rq_selected(src_rq)->dl.deadline))
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2554,9 +2555,9 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 	if (!task_on_cpu(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    p->nr_cpus_allowed > 1 &&
-	    dl_task(rq->curr) &&
+	    dl_task(rq_selected(rq)) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &rq->curr->dl))) {
+	     !dl_entity_preempt(&p->dl, &rq_selected(rq)->dl))) {
 		push_dl_tasks(rq);
 	}
 }
@@ -2731,12 +2732,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (rq->curr != p) {
+	if (rq_selected(rq) != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
 #endif
-		if (dl_task(rq->curr))
+		if (dl_task(rq_selected(rq)))
 			wakeup_preempt_dl(rq, p, 0);
 		else
 			resched_curr(rq);
@@ -2765,7 +2766,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	if (!rq->dl.overloaded)
 		deadline_queue_pull_task(rq);
 
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 		/*
 		 * If we now have a earlier deadline task than p,
 		 * then reschedule, provided p is still on this
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..46f87fd47a33 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1140,7 +1140,7 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
  */
 s64 update_curr_common(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 	s64 delta_exec;
 
 	delta_exec = update_curr_se(rq, &curr->se);
@@ -1177,7 +1177,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq->curr->se));
+	update_curr(cfs_rq_of(&rq_selected(rq)->se));
 }
 
 static inline void
@@ -6633,7 +6633,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (task_current(rq, p))
+			if (task_current_selected(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -6648,7 +6648,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
  */
 static void hrtick_update(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 
 	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
@@ -8279,7 +8279,7 @@ static void set_next_buddy(struct sched_entity *se)
  */
 static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	int cse_is_idle, pse_is_idle;
@@ -8310,7 +8310,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(rq->curr))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
@@ -9292,7 +9292,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq->curr->sched_class;
+	curr_class = rq_selected(rq)->sched_class;
 
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 
@@ -12661,7 +12661,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -12764,7 +12764,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (task_current(rq, p))
+		if (task_current_selected(rq, p))
 			resched_curr(rq);
 		else
 			wakeup_preempt(rq, p, 0);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 638e7c158ae4..48fc7a198f1a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -530,7 +530,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 
 static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 {
-	struct task_struct *curr = rq_of_rt_rq(rt_rq)->curr;
+	struct task_struct *curr = rq_selected(rq_of_rt_rq(rt_rq));
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct sched_rt_entity *rt_se;
 
@@ -1000,7 +1000,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
  */
 static void update_curr_rt(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq_selected(rq);
 	struct sched_rt_entity *rt_se = &curr->rt;
 	s64 delta_exec;
 
@@ -1543,7 +1543,7 @@ static int find_lowest_rq(struct task_struct *task);
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *selected;
 	struct rq *rq;
 	bool test;
 
@@ -1555,6 +1555,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	selected = READ_ONCE(rq_selected(rq));
 
 	/*
 	 * If the current task on @p's runqueue is an RT task, then
@@ -1583,8 +1584,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 * systems like big.LITTLE.
 	 */
 	test = curr &&
-	       unlikely(rt_task(curr)) &&
-	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
+	       unlikely(rt_task(selected)) &&
+	       (curr->nr_cpus_allowed < 2 || selected->prio <= p->prio);
 
 	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
@@ -1614,12 +1615,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 {
-	/*
-	 * Current can't be migrated, useless to reschedule,
-	 * let's hope p can move out.
-	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), NULL))
 		return;
 
 	/*
@@ -1662,7 +1659,9 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
  */
 static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq->curr->prio) {
+	struct task_struct *curr = rq_selected(rq);
+
+	if (p->prio < curr->prio) {
 		resched_curr(rq);
 		return;
 	}
@@ -1680,7 +1679,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == curr->prio && !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -1705,7 +1704,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	 * utilization. We only care of the case where we start to schedule a
 	 * rt task
 	 */
-	if (rq->curr->sched_class != &rt_sched_class)
+	if (rq_selected(rq)->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
@@ -1977,6 +1976,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
 
 	BUG_ON(rq->cpu != task_cpu(p));
 	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current_selected(rq, p));
 	BUG_ON(p->nr_cpus_allowed <= 1);
 
 	BUG_ON(!task_on_rq_queued(p));
@@ -2009,7 +2009,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(next_task->prio < rq_selected(rq)->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2362,7 +2362,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (p->prio < rq_selected(src_rq)->prio)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2404,9 +2404,9 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
-			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
+			    (dl_task(rq_selected(rq)) || rt_task(rq_selected(rq))) &&
 			    (rq->curr->nr_cpus_allowed < 2 ||
-			     rq->curr->prio <= p->prio);
+			     rq_selected(rq)->prio <= p->prio);
 
 	if (need_to_push)
 		push_rt_tasks(rq);
@@ -2490,7 +2490,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (p->prio < rq_selected(rq)->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2505,7 +2505,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
@@ -2531,7 +2531,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (p->prio < rq_selected(rq)->prio)
 			resched_curr(rq);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f25eec405df9..3c64a875f0ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1030,7 +1030,7 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
-	struct task_struct __rcu	*curr;
+	struct task_struct __rcu	*curr;       /* Execution context */
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1225,6 +1225,13 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+/* For now, rq_selected == rq->curr */
+#define rq_selected(rq)		((rq)->curr)
+static inline void rq_set_selected(struct rq *rq, struct task_struct *t)
+{
+	/* Do nothing */
+}
+
 struct sched_group;
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
@@ -2148,11 +2155,25 @@ static inline u64 global_rt_runtime(void)
 	return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;
 }
 
+/*
+ * Is p the current execution context?
+ */
 static inline int task_current(struct rq *rq, struct task_struct *p)
 {
 	return rq->curr == p;
 }
 
+/*
+ * Is p the current scheduling context?
+ *
+ * Note that it might be the current execution context at the same time if
+ * rq->curr == rq_selected() == p.
+ */
+static inline int task_current_selected(struct rq *rq, struct task_struct *p)
+{
+	return rq_selected(rq) == p;
+}
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2322,7 +2343,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq_selected(rq) != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
-- 
2.44.0.478.gd926399ef9-goog


