Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62237E8897
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345882AbjKKCut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjKKCu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:50:27 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768F047A4;
        Fri, 10 Nov 2023 18:49:38 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so2121730a12.3;
        Fri, 10 Nov 2023 18:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670977; x=1700275777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/stcVOZInSyqLvaN7cUL7WLcesEIp6ccWqbtVlM0WXk=;
        b=kIAkAVj/O+1Eih6xZJ3v2TRiUe3vU6LoIjiKr24kB1SvzMqgSj6/8xRRQpazhNu80r
         tIDoqvL2GtnoUQVfg2lm6Rz7yLV+gak73+4ReHvc8+CN1hnKCglYtU3Yy62zIiVqzjwH
         3gPHUoDp97Usv2RWtwgnsT/29B+K1LhUsTR2E4c4lRcYEv5QOl+qdQTQSfBMlYbo3iFL
         JK7ZVTW5GWyeGDYa8zw5LYgcY8MIK4L/383X7rzHw8r2RKLYAtMt/Eiu27X2YaJta7oE
         UtzSFw/GRVZI9g1Jl39j9hn8pQ6e5ycc8pnDXOxe0ZhI4gR0WsbeB3dk5whe785bCx7n
         9Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670977; x=1700275777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/stcVOZInSyqLvaN7cUL7WLcesEIp6ccWqbtVlM0WXk=;
        b=N6WYU3st8JhAnENdjXfow0jjLIITgDkdeNiU10wYKQMxIB5SCE80qMuq6M2H2lKvjo
         6CaxN+H/HeA6oS0i3QJWw9oUa8oXQevBoWs7yHtloMaz1JX1BHTBJwmeSDlVyePKZj2j
         cI6mx72Zs9Hh+lwle8J/vuG9J5HiCR8btHXk78A2Mzz6IWO70ai1RXEG/pH/9/gy65Pr
         nuI+9cj42X+oPcf4yQN10gzdvXzKkQJ0RB+txSMRKl33mb6LaHp9EN9m8F1rQFaOGlIP
         KeBDLALay8nhQztmDzbp3RBxksorqtgK1UKqCi4kbfc+aICFrk3rKh0Sd7DJgRqzF70V
         WecQ==
X-Gm-Message-State: AOJu0Yygi2jfOU/tWTgJRlq3Rj58yjD/gaR5IYKOkY1n61ukbjBQk09e
        wkpOvLTC4ulURkmwMqqHKmw=
X-Google-Smtp-Source: AGHT+IH5jBGbQTOkGvCEZgZSbbYHSHU2YilTVL16JYSbVLU5RSR9LfRuZLJEEy28uEAF4iVDz0ecXQ==
X-Received: by 2002:a05:6a21:790a:b0:15c:7223:7bb1 with SMTP id bg10-20020a056a21790a00b0015c72237bb1mr1321345pzc.20.1699670977586;
        Fri, 10 Nov 2023 18:49:37 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090a8e8600b0027df6ff00eesm425514pjo.19.2023.11.10.18.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 22/36] sched_ext: Add task state tracking operations
Date:   Fri, 10 Nov 2023 16:47:48 -1000
Message-ID: <20231111024835.2164816-23-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Being able to track the task runnable and running state transitions are
useful for a variety of purposes including latency tracking and load factor
calculation.

Currently, BPF schedulers don't have a good way of tracking these
transitions. Becoming runnable can be determined from ops.enqueue() but
becoming quiescent can only be inferred from the lack of subsequent enqueue.
Also, as the local dsq can have multiple tasks and some events are handled
in the sched_ext core, it's difficult to determine when a given task starts
and stops executing.

This patch adds sched_ext_ops.runnable(), .running(), .stopping() and
.quiescent() operations to track the task runnable and running state
transitions. They're mostly self explanatory; however, we want to ensure
that running <-> stopping transitions are always contained within runnable
<-> quiescent transitions which is a bit different from how the scheduler
core behaves. This adds a bit of complication. See the comment in
dequeue_task_scx().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h | 65 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/ext.c        | 31 +++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d6ebfa6163a1..6d8bcd1490af 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -192,6 +192,71 @@ struct sched_ext_ops {
 	 */
 	void (*dispatch)(s32 cpu, struct task_struct *prev);
 
+	/**
+	 * runnable - A task is becoming runnable on its associated CPU
+	 * @p: task becoming runnable
+	 * @enq_flags: %SCX_ENQ_*
+	 *
+	 * This and the following three functions can be used to track a task's
+	 * execution state transitions. A task becomes ->runnable() on a CPU,
+	 * and then goes through one or more ->running() and ->stopping() pairs
+	 * as it runs on the CPU, and eventually becomes ->quiescent() when it's
+	 * done running on the CPU.
+	 *
+	 * @p is becoming runnable on the CPU because it's
+	 *
+	 * - waking up (%SCX_ENQ_WAKEUP)
+	 * - being moved from another CPU
+	 * - being restored after temporarily taken off the queue for an
+	 *   attribute change.
+	 *
+	 * This and ->enqueue() are related but not coupled. This operation
+	 * notifies @p's state transition and may not be followed by ->enqueue()
+	 * e.g. when @p is being dispatched to a remote CPU. Likewise, a task
+	 * may be ->enqueue()'d without being preceded by this operation e.g.
+	 * after exhausting its slice.
+	 */
+	void (*runnable)(struct task_struct *p, u64 enq_flags);
+
+	/**
+	 * running - A task is starting to run on its associated CPU
+	 * @p: task starting to run
+	 *
+	 * See ->runnable() for explanation on the task state notifiers.
+	 */
+	void (*running)(struct task_struct *p);
+
+	/**
+	 * stopping - A task is stopping execution
+	 * @p: task stopping to run
+	 * @runnable: is task @p still runnable?
+	 *
+	 * See ->runnable() for explanation on the task state notifiers. If
+	 * !@runnable, ->quiescent() will be invoked after this operation
+	 * returns.
+	 */
+	void (*stopping)(struct task_struct *p, bool runnable);
+
+	/**
+	 * quiescent - A task is becoming not runnable on its associated CPU
+	 * @p: task becoming not runnable
+	 * @deq_flags: %SCX_DEQ_*
+	 *
+	 * See ->runnable() for explanation on the task state notifiers.
+	 *
+	 * @p is becoming quiescent on the CPU because it's
+	 *
+	 * - sleeping (%SCX_DEQ_SLEEP)
+	 * - being moved to another CPU
+	 * - being temporarily taken off the queue for an attribute change
+	 *   (%SCX_DEQ_SAVE)
+	 *
+	 * This and ->dequeue() are related but not coupled. This operation
+	 * notifies @p's state transition and may not be preceded by ->dequeue()
+	 * e.g. when @p is being dispatched to a remote CPU.
+	 */
+	void (*quiescent)(struct task_struct *p, u64 deq_flags);
+
 	/**
 	 * yield - Yield CPU
 	 * @from: yielding task
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d0c60dfac08e..6cf088dd9d09 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -786,6 +786,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
+	if (SCX_HAS_OP(runnable))
+		SCX_CALL_OP(SCX_KF_REST, runnable, p, enq_flags);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
 
@@ -846,6 +849,26 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 
 	ops_dequeue(p, deq_flags);
 
+	/*
+	 * A currently running task which is going off @rq first gets dequeued
+	 * and then stops running. As we want running <-> stopping transitions
+	 * to be contained within runnable <-> quiescent transitions, trigger
+	 * ->stopping() early here instead of in put_prev_task_scx().
+	 *
+	 * @p may go through multiple stopping <-> running transitions between
+	 * here and put_prev_task_scx() if task attribute changes occur while
+	 * balance_scx() leaves @rq unlocked. However, they don't contain any
+	 * information meaningful to the BPF scheduler and can be suppressed by
+	 * skipping the callbacks if the task is !QUEUED.
+	 */
+	if (SCX_HAS_OP(stopping) && task_current(rq, p)) {
+		update_curr_scx(rq);
+		SCX_CALL_OP(SCX_KF_REST, stopping, p, false);
+	}
+
+	if (SCX_HAS_OP(quiescent))
+		SCX_CALL_OP(SCX_KF_REST, quiescent, p, deq_flags);
+
 	if (deq_flags & SCX_DEQ_SLEEP)
 		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
 	else
@@ -1383,6 +1406,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	p->se.exec_start = rq_clock_task(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
+		SCX_CALL_OP(SCX_KF_REST, running, p);
+
 	watchdog_unwatch_task(p, true);
 }
 
@@ -1421,6 +1448,10 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 
 	update_curr_scx(rq);
 
+	/* see dequeue_task_scx() on why we skip when !QUEUED */
+	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
+		SCX_CALL_OP(SCX_KF_REST, stopping, p, true);
+
 	/*
 	 * If we're being called from put_prev_task_balance(), balance_scx() may
 	 * have decided that @p should keep running.
-- 
2.42.0

