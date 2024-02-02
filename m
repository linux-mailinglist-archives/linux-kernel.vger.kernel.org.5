Return-Path: <linux-kernel+bounces-49473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EC5846AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894C928A656
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90470182B3;
	Fri,  2 Feb 2024 08:33:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282D182BE;
	Fri,  2 Feb 2024 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862838; cv=none; b=US64pWeKM0u4Y6LdvYBw+Y1GjjNYtGCQvn7KxA4eT6Ac4sKSpu8aoA10t2xgpPa0q6V0G65nl1laILDmx+pVj6Vhi3olUeqAzCOdqlP30YpSz7O6BwUGadEhFw0s1HCl4dzCoxMMbAlTXGjgnnPXlQVPD1fbp+6mDgNSDdV7juA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862838; c=relaxed/simple;
	bh=72FVsJAWi+qWl0gmnOlAP2lrOTNvG7aAybhPev5uBKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oNC15LZ6sQmz3qbHRaI8gshEoJ4UKxmNiGqOVUT/1uL1Q+9WBF0/APvDMShsqygj6ZeljqFek2N2vbNp1o/A6YVVmwwJHhzaf/K4dAkq0S3CenbNIQi19UB7X2r27JgOvzCJV9Lp001kfxKfuwKcLMP1c1ZQWWhCTjAiPgcRfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17A18DA7;
	Fri,  2 Feb 2024 00:34:32 -0800 (PST)
Received: from e132833.arm.com (unknown [10.57.7.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 443423F5A1;
	Fri,  2 Feb 2024 00:33:46 -0800 (PST)
From: Metin Kaya <metin.kaya@arm.com>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kernel-team@android.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] sched: Add trace events for Proxy Execution (PE)
Date: Fri,  2 Feb 2024 08:33:38 +0000
Message-Id: <20240202083338.1328060-1-metin.kaya@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sched_[start, finish]_task_selection trace events to measure the
latency of PE patches in task selection.

Moreover, introduce trace events for interesting events in PE:
1. sched_pe_enqueue_sleeping_task: a task gets enqueued on wait queue of
   a sleeping task (mutex owner).
2. sched_pe_cross_remote_cpu: dependency chain crosses remote CPU.
3. sched_pe_task_is_migrating: mutex owner task migrates.

New trace events can be tested via this command:
$ perf trace \
  -e sched:sched_start_task_selection \
  -e sched:sched_finish_task_selection \
  -e sched:sched_pe_enqueue_sleeping_task \
  -e sched:sched_pe_cross_remote_cpu \
  -e sched:sched_pe_task_is_migrating

Notes:
1. These trace events are not intended to merge upstream. Instead, they
   are only for making PE tests easier and will be converted to trace
   points once PE patches hit upstream.
2. This patch is based on John's Proxy Execution v7 patch series (see
   the link below) which is also available at
   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v7-6.7-rc6/.

Link: https://lore.kernel.org/linux-kernel/CANDhNCrHd+5twWVNqBAhVLfhMhkiO0KjxXBmwVgaCD4kAyFyWw@mail.gmail.com/

Signed-off-by: Metin Kaya <metin.kaya@arm.com>
CC: John Stultz <jstultz@google.com>
CC: Joel Fernandes <joelaf@google.com>
CC: Qais Yousef <qyousef@google.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Valentin Schneider <vschneid@redhat.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Ben Segall <bsegall@google.com>
CC: Zimuzo Ezeozue <zezeozue@google.com>
CC: Youssef Esmat <youssefesmat@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>
CC: Will Deacon <will@kernel.org>
CC: Waiman Long <longman@redhat.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>
CC: Xuewen Yan <xuewen.yan94@gmail.com>
CC: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: kernel-team@android.com
CC: linux-trace-kernel@vger.kernel.org
---
 include/trace/events/sched.h | 138 +++++++++++++++++++++++++++++++++++
 kernel/sched/core.c          |  11 +++
 2 files changed, 149 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 6188ad0d9e0d..2b08509f3088 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -737,6 +737,144 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 	TP_printk("cpu=%d", __entry->cpu)
 );
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+/**
+ * sched_pe_enqueue_sleeping_task - called when a task is enqueued on wait
+ *				    queue of a sleeping task (mutex owner).
+ * @mutex_owner: pointer to struct task_struct
+ * @blocked:     pointer to struct task_struct
+ */
+TRACE_EVENT(sched_pe_enqueue_sleeping_task,
+
+	TP_PROTO(struct task_struct *mutex_owner, struct task_struct *blocked),
+
+	TP_ARGS(mutex_owner, blocked),
+
+	TP_STRUCT__entry(
+		__array(char,	owner_comm,	TASK_COMM_LEN	)
+		__field(pid_t,	owner_pid			)
+		__field(int,	owner_prio			)
+		__field(int,	owner_cpu			)
+		__array(char,	blocked_comm,	TASK_COMM_LEN	)
+		__field(pid_t,	blocked_pid			)
+		__field(int,	blocked_prio			)
+		__field(int,	blocked_cpu			)
+	),
+
+	TP_fast_assign(
+		strscpy(__entry->owner_comm, mutex_owner->comm, TASK_COMM_LEN);
+		__entry->owner_pid	= mutex_owner->pid;
+		__entry->owner_prio	= mutex_owner->prio; /* XXX SCHED_DEADLINE */
+		__entry->owner_cpu	= task_cpu(mutex_owner);
+
+		strscpy(__entry->blocked_comm, blocked->comm, TASK_COMM_LEN);
+		__entry->blocked_pid	= blocked->pid;
+		__entry->blocked_prio	= blocked->prio; /* XXX SCHED_DEADLINE */
+		__entry->blocked_cpu	= task_cpu(blocked);
+	),
+
+	TP_printk("task=%s pid=%d prio=%d cpu=%d blocked_on owner_task=%s owner_pid=%d owner_prio=%d owner_cpu=%d",
+		  __entry->blocked_comm, __entry->blocked_pid,
+		  __entry->blocked_prio, __entry->blocked_cpu,
+		  __entry->owner_comm, __entry->owner_pid,
+		  __entry->owner_prio, __entry->owner_cpu)
+);
+
+/**
+ * sched_pe_cross_remote_cpu - called when dependency chain crosses remote CPU
+ * @p: pointer to struct task_struct
+ */
+TRACE_EVENT(sched_pe_cross_remote_cpu,
+
+	TP_PROTO(struct task_struct *p),
+
+	TP_ARGS(p),
+
+	TP_STRUCT__entry(
+		__array(char,	comm,	TASK_COMM_LEN	)
+		__field(pid_t,	pid			)
+		__field(int,	prio			)
+		__field(int,	cpu			)
+	),
+
+	TP_fast_assign(
+		strscpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__entry->pid	= p->pid;
+		__entry->prio	= p->prio; /* XXX SCHED_DEADLINE */
+		__entry->cpu	= task_cpu(p);
+	),
+
+	TP_printk("comm=%s pid=%d prio=%d cpu=%d",
+		  __entry->comm, __entry->pid, __entry->prio, __entry->cpu)
+);
+
+/**
+ * sched_pe_task_is_migrating - called when mutex owner is in migrating state
+ * @p: pointer to struct task_struct
+ */
+TRACE_EVENT(sched_pe_task_is_migrating,
+
+	TP_PROTO(struct task_struct *p),
+
+	TP_ARGS(p),
+
+	TP_STRUCT__entry(
+		__array(char,	comm,	TASK_COMM_LEN	)
+		__field(pid_t,	pid			)
+		__field(int,	prio			)
+	),
+
+	TP_fast_assign(
+		strscpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__entry->pid		= p->pid;
+		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
+	),
+
+	TP_printk("comm=%s pid=%d prio=%d",
+		  __entry->comm, __entry->pid, __entry->prio)
+);
+#endif /* CONFIG_SCHED_PROXY_EXEC */
+
+DECLARE_EVENT_CLASS(sched_task_selection_template,
+
+	TP_PROTO(int cpu),
+
+	TP_ARGS(cpu),
+
+	TP_STRUCT__entry(
+		__field(int,	cpu)
+	),
+
+	TP_fast_assign(
+		__entry->cpu	= cpu;
+	),
+
+	TP_printk("cpu=%d",
+		  __entry->cpu)
+);
+
+/**
+ * sched_start_task_selection - called before selecting next task in
+ *				__schedule()
+ * @cpu: The CPU which will run task selection operation.
+ */
+DEFINE_EVENT(sched_task_selection_template, sched_start_task_selection,
+
+	TP_PROTO(int cpu),
+
+	TP_ARGS(cpu));
+
+/**
+ * sched_finish_task_selection - called after selecting next task in
+ *				 __schedule()
+ * @cpu: The CPU which ran task selection operation.
+ */
+DEFINE_EVENT(sched_task_selection_template, sched_finish_task_selection,
+
+	TP_PROTO(int cpu),
+
+	TP_ARGS(cpu));
+
 /*
  * Following tracepoints are not exported in tracefs and provide hooking
  * mechanisms only for testing and debugging purposes.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 30dfb6f14f2b..866809e52971 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7006,6 +7006,9 @@ static void proxy_enqueue_on_owner(struct rq *rq, struct task_struct *owner,
 	 */
 	if (!owner->on_rq) {
 		BUG_ON(!next->on_rq);
+
+		trace_sched_pe_enqueue_sleeping_task(owner, next);
+
 		deactivate_task(rq, next, DEQUEUE_SLEEP);
 		if (task_current_selected(rq, next)) {
 			put_prev_task(rq, next);
@@ -7100,6 +7103,9 @@ find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 
 		if (task_cpu(owner) != cur_cpu) {
 			target_cpu = task_cpu(owner);
+
+			trace_sched_pe_cross_remote_cpu(owner);
+
 			/*
 			 * @owner can disappear, simply migrate to @target_cpu and leave that CPU
 			 * to sort things out.
@@ -7113,6 +7119,8 @@ find_proxy_task(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		}
 
 		if (task_on_rq_migrating(owner)) {
+			trace_sched_pe_task_is_migrating(owner);
+
 			/*
 			 * One of the chain of mutex owners is currently migrating to this
 			 * CPU, but has not yet been enqueued because we are holding the
@@ -7335,6 +7343,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	prev_not_proxied = !prev->blocked_donor;
+
+	trace_sched_start_task_selection(cpu);
 pick_again:
 	next = pick_next_task(rq, rq_selected(rq), &rf);
 	rq_set_selected(rq, next);
@@ -7350,6 +7360,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		if (next == rq->idle && prev == rq->idle)
 			preserve_need_resched = true;
 	}
+	trace_sched_finish_task_selection(cpu);
 
 	if (!preserve_need_resched)
 		clear_tsk_need_resched(prev);
-- 
2.34.1


