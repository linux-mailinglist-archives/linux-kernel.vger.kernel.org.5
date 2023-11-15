Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173E97EBF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjKOJFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjKOJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:04:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8172B11C;
        Wed, 15 Nov 2023 01:04:54 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1oYoR9HMpWTrMNNt5tJiIV35XwNwJfCVnIk+94z5U78=;
        b=L1vp1u3CGnHtFHevFkVvRzfzXWwyzS5b+RRHRiojmYMWnU/j+oZpOufiyvk/4Wz4IQxurX
        rOShvr+V2+OLvDhXrChmf8+W2gpwZXIwpgr/ZvDP6VQiwlbPbu+5ONqoxnIHPciCt/0z6c
        wotNHxYMXmtbWjJ43uHwAl4RpfH9YWjTk/7jnmOBHqOfJO5F6yzY+WN/z2JUsF1kXkTWk+
        5zCO8OhnFMyvozDj7gvXgW5BPHTHJ+5VjiN5rLHR3H7S8atyxGiRod2nGn3OTnhraIZTRA
        Y4BawcnG7fiPdUm0RXEMdds7JULOa7YPQmro91aY0StMwrWZ05DkCgFP4ajMrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1oYoR9HMpWTrMNNt5tJiIV35XwNwJfCVnIk+94z5U78=;
        b=gMSXULWbWGqfN+qfypIUK6gxfg1GPJEUNsVtQxGmxzIKEHiQv1xMmUmvgsGWVSvoWG2Fnc
        M10OCtYeSqhdtdAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove vruntime from trace_sched_stat_runtime()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170003909260.391.5473779409458503289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5fe6ec8f6ab549b6422e41551abb51802bd48bc7
Gitweb:        https://git.kernel.org/tip/5fe6ec8f6ab549b6422e41551abb51802bd48bc7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 06 Nov 2023 13:41:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:49 +01:00

sched: Remove vruntime from trace_sched_stat_runtime()

Tracing the runtime delta makes sense, observer can sum over time.
Tracing the absolute vruntime makes less sense, inconsistent:
absolute-vs-delta, but also vruntime delta can be computed from
runtime delta.

Removing the vruntime thing also makes the two tracepoint sites
identical, allowing to unify the code in a later patch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/trace/events/sched.h | 15 ++++++---------
 kernel/sched/fair.c          |  5 ++---
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 6188ad0..dbb01b4 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -493,33 +493,30 @@ DEFINE_EVENT_SCHEDSTAT(sched_stat_template, sched_stat_blocked,
  */
 DECLARE_EVENT_CLASS(sched_stat_runtime,
 
-	TP_PROTO(struct task_struct *tsk, u64 runtime, u64 vruntime),
+	TP_PROTO(struct task_struct *tsk, u64 runtime),
 
-	TP_ARGS(tsk, __perf_count(runtime), vruntime),
+	TP_ARGS(tsk, __perf_count(runtime)),
 
 	TP_STRUCT__entry(
 		__array( char,	comm,	TASK_COMM_LEN	)
 		__field( pid_t,	pid			)
 		__field( u64,	runtime			)
-		__field( u64,	vruntime			)
 	),
 
 	TP_fast_assign(
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
 		__entry->pid		= tsk->pid;
 		__entry->runtime	= runtime;
-		__entry->vruntime	= vruntime;
 	),
 
-	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu [ns]",
+	TP_printk("comm=%s pid=%d runtime=%Lu [ns]",
 			__entry->comm, __entry->pid,
-			(unsigned long long)__entry->runtime,
-			(unsigned long long)__entry->vruntime)
+			(unsigned long long)__entry->runtime)
 );
 
 DEFINE_EVENT(sched_stat_runtime, sched_stat_runtime,
-	     TP_PROTO(struct task_struct *tsk, u64 runtime, u64 vruntime),
-	     TP_ARGS(tsk, runtime, vruntime));
+	     TP_PROTO(struct task_struct *tsk, u64 runtime),
+	     TP_ARGS(tsk, runtime));
 
 /*
  * Tracepoint for showing priority inheritance modifying a tasks
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11073cf..33db70c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1138,8 +1138,7 @@ s64 update_curr_common(struct rq *rq)
 	if (unlikely(delta_exec <= 0))
 		return delta_exec;
 
-	trace_sched_stat_runtime(curr, delta_exec, 0);
-
+	trace_sched_stat_runtime(curr, delta_exec);
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
 
@@ -1168,7 +1167,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (entity_is_task(curr)) {
 		struct task_struct *curtask = task_of(curr);
 
-		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
+		trace_sched_stat_runtime(curtask, delta_exec);
 		cgroup_account_cputime(curtask, delta_exec);
 		account_group_exec_runtime(curtask, delta_exec);
 	}
