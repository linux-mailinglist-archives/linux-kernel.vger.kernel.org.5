Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625CD78267F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjHUJtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjHUJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:49:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2E91
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:49:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-688787570ccso1995011b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692611386; x=1693216186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYPVDF7nTV0hlpbCiBcn9X7iHeNyxkTOmrcvwqA7vm4=;
        b=WcZmPabwXF38U31W43fl6qxixnjbvOJFNEsqptRd1z0kI0JCPsapfsB0XShVYbRMIq
         R3c3hmuML8/ajkCpA+AnUEjz/lBKlhfG8epbGstCxu29ss4nK/kPRWZU+SGiIb2id58t
         Jr4XJvPW8wTVFdgWLV0F7A2KOKCwe/Ry1a3X993oU9OQAVMT1t4oDJIm4d4xoNCtjcVa
         0ckvFUyn6L1Ia08nD/AMgG279zYZ/RXwz+mgXu1miF0q6kVWEFfMeX2TnZFI02eXa2Uu
         pMtDxNHpXxGRjwXfWBXOvce9CP/vNGIK7q0aINKatV8aJoL10gGJmPdVmsD4RbcySndj
         kTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692611386; x=1693216186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYPVDF7nTV0hlpbCiBcn9X7iHeNyxkTOmrcvwqA7vm4=;
        b=ciyTLR9JnypWf8hIT1vHiBmVeleWpWN5L7rdFPlimEYqyNFGQIgHPEkZJqpimNSssh
         L45Daiba0MRJsa5c54h4NR81P1s7R90Xxw4AWoa3HpcxTOj75rTgYC5VPUCquRjeWX+r
         q4l034UUcFxCr21YE64heOuI/gYm4ROBC9Pq5siSlVfoBuInJ+prhYMYdJMsTIEMQgpg
         H1TCcpWvYvTMBteLkWGkdu0SWgm00rip9a9JJFHEcI1vma/gfwycbQ7W9JkJXdYYaBfT
         lqBRrZxAxIO/gVIk02cVIbrNvruEKfNoW/Zi4TLZp6/yxPsqhbA9IQpweB22QTrcYXGa
         7Pjw==
X-Gm-Message-State: AOJu0Yw8BkfsfxWxSmM0QyF3IKdZnLv7zZpfmJqS2C7wrm2d/JObU4RT
        aa4zjsv37uzIeUdvTLnvH+GPbQ==
X-Google-Smtp-Source: AGHT+IGho7OkRCAdJS8FtW2UtzEkYqoofrgrLohArDkkQrxm2CqtCHPJeu1iqQ5HenTZ+08oh2ri5Q==
X-Received: by 2002:a05:6a20:3cab:b0:148:9ce9:2f46 with SMTP id b43-20020a056a203cab00b001489ce92f46mr3047533pzj.6.1692611386507;
        Mon, 21 Aug 2023 02:49:46 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00270900b0068a4cd8b530sm1674892pfv.139.2023.08.21.02.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 02:49:46 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pauld@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 1/2] sched/core: Introduce sched_class::can_stop_tick()
Date:   Mon, 21 Aug 2023 17:49:26 +0800
Message-Id: <20230821094927.51079-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230821094927.51079-1-jiahao.os@bytedance.com>
References: <20230821094927.51079-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract a can_stop_tick() callback function for each
sched_class from sched_can_stop_tick(). It will
clean up some checks about cfs_bandwidth in sched/core.c.
Put these checks into their own sched_class,
and make some functions static.

This also makes it easier for us to deal with
"nohz_full vs rt_bandwidth" case later.

No functional changes.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c     | 67 ++++++-----------------------------------
 kernel/sched/deadline.c | 16 ++++++++++
 kernel/sched/fair.c     | 56 +++++++++++++++++++++++++++++++---
 kernel/sched/rt.c       | 34 +++++++++++++++++++++
 kernel/sched/sched.h    |  5 +--
 5 files changed, 114 insertions(+), 64 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index efe3848978a0..1107ce6e4f6c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1191,68 +1191,21 @@ static void nohz_csd_func(void *info)
 #endif /* CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
-static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
-{
-	if (rq->nr_running != 1)
-		return false;
-
-	if (p->sched_class != &fair_sched_class)
-		return false;
-
-	if (!task_on_rq_queued(p))
-		return false;
-
-	return true;
-}
-
 bool sched_can_stop_tick(struct rq *rq)
 {
-	int fifo_nr_running;
-
-	/* Deadline tasks, even if single, need the tick */
-	if (rq->dl.dl_nr_running)
-		return false;
-
-	/*
-	 * If there are more than one RR tasks, we need the tick to affect the
-	 * actual RR behaviour.
-	 */
-	if (rq->rt.rr_nr_running) {
-		if (rq->rt.rr_nr_running == 1)
-			return true;
-		else
-			return false;
-	}
-
-	/*
-	 * If there's no RR tasks, but FIFO tasks, we can skip the tick, no
-	 * forced preemption between FIFO tasks.
-	 */
-	fifo_nr_running = rq->rt.rt_nr_running - rq->rt.rr_nr_running;
-	if (fifo_nr_running)
-		return true;
-
-	/*
-	 * If there are no DL,RR/FIFO tasks, there must only be CFS tasks left;
-	 * if there's more than one we need the tick for involuntary
-	 * preemption.
-	 */
-	if (rq->nr_running > 1)
-		return false;
+	const struct sched_class *class;
+	int stop_next = 0;
+	bool ret = true;
 
-	/*
-	 * If there is one task and it has CFS runtime bandwidth constraints
-	 * and it's on the cpu now we don't want to stop the tick.
-	 * This check prevents clearing the bit if a newly enqueued task here is
-	 * dequeued by migrating while the constrained task continues to run.
-	 * E.g. going from 2->1 without going through pick_next_task().
-	 */
-	if (sched_feat(HZ_BW) && __need_bw_check(rq, rq->curr)) {
-		if (cfs_task_bw_constrained(rq->curr))
-			return false;
+	for_each_class(class) {
+		if (class->can_stop_tick) {
+			ret = class->can_stop_tick(rq, &stop_next);
+			if (stop_next)
+				break;
+		}
 	}
 
-	return true;
+	return ret;
 }
 #endif /* CONFIG_NO_HZ_FULL */
 #endif /* CONFIG_SMP */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 58b542bf2893..0b461cb40408 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2715,6 +2715,19 @@ static int task_is_throttled_dl(struct task_struct *p, int cpu)
 }
 #endif
 
+#ifdef CONFIG_NO_HZ_FULL
+static bool can_stop_tick_dl(struct rq *rq, int *stop_next)
+{
+	/* Deadline tasks, even if single, need the tick */
+	if (rq->dl.dl_nr_running) {
+		*stop_next = 1;
+		return false;
+	}
+
+	return true;
+}
+#endif
+
 DEFINE_SCHED_CLASS(dl) = {
 
 	.enqueue_task		= enqueue_task_dl,
@@ -2750,6 +2763,9 @@ DEFINE_SCHED_CLASS(dl) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_dl,
 #endif
+#ifdef CONFIG_NO_HZ_FULL
+	.can_stop_tick		= can_stop_tick_dl,
+#endif
 };
 
 /* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 128a78f3f264..7fa4892267f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6267,7 +6267,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	rq_clock_stop_loop_update(rq);
 }
 
-bool cfs_task_bw_constrained(struct task_struct *p)
+#ifdef CONFIG_NO_HZ_FULL
+static inline bool cfs_task_bw_constrained(struct task_struct *p)
 {
 	struct cfs_rq *cfs_rq = task_cfs_rq(p);
 
@@ -6281,7 +6282,6 @@ bool cfs_task_bw_constrained(struct task_struct *p)
 	return false;
 }
 
-#ifdef CONFIG_NO_HZ_FULL
 /* called from pick_next_task_fair() */
 static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 {
@@ -6305,6 +6305,44 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 	if (cfs_task_bw_constrained(p))
 		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
 }
+
+static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
+{
+	if (rq->nr_running != 1)
+		return false;
+
+	if (p->sched_class != &fair_sched_class)
+		return false;
+
+	if (!task_on_rq_queued(p))
+		return false;
+
+	return true;
+}
+
+static bool can_stop_tick_fair(struct rq *rq, int *stop_next)
+{
+	if (rq->nr_running > 1) {
+		*stop_next = 1;
+		return false;
+	}
+
+	/*
+	 * If there is one task and it has CFS runtime bandwidth constraints
+	 * and it's on the cpu now we don't want to stop the tick.
+	 * This check prevents clearing the bit if a newly enqueued task here is
+	 * dequeued by migrating while the constrained task continues to run.
+	 * E.g. going from 2->1 without going through pick_next_task().
+	 */
+	if (sched_feat(HZ_BW) && __need_bw_check(rq, rq->curr)) {
+		if (cfs_task_bw_constrained(rq->curr)) {
+			*stop_next = 1;
+			return false;
+		}
+	}
+
+	return true;
+}
 #endif
 
 #else /* CONFIG_CFS_BANDWIDTH */
@@ -6348,10 +6386,15 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static inline void update_runtime_enabled(struct rq *rq) {}
 static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
-#ifdef CONFIG_CGROUP_SCHED
-bool cfs_task_bw_constrained(struct task_struct *p)
+#ifdef CONFIG_NO_HZ_FULL
+static bool can_stop_tick_fair(struct rq *rq, int *stop_next)
 {
-	return false;
+	if (rq->nr_running > 1) {
+		*stop_next = 1;
+		return false;
+	}
+
+	return true;
 }
 #endif
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -12864,6 +12907,9 @@ DEFINE_SCHED_CLASS(fair) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_fair,
 #endif
+#ifdef CONFIG_NO_HZ_FULL
+	.can_stop_tick		= can_stop_tick_fair,
+#endif
 
 #ifdef CONFIG_UCLAMP_TASK
 	.uclamp_enabled		= 1,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0597ba0f85ff..0b9e9467ef61 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1740,6 +1740,37 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 #endif
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+static bool can_stop_tick_rt(struct rq *rq, int *stop_next)
+{
+	int fifo_nr_running;
+
+	/*
+	 * If there are more than one RR tasks, we need the tick to affect the
+	 * actual RR behaviour.
+	 */
+	if (rq->rt.rr_nr_running) {
+		*stop_next = 1;
+		if (rq->rt.rr_nr_running == 1)
+			return true;
+		else
+			return false;
+	}
+
+	/*
+	 * If there's no RR tasks, but FIFO tasks, we can skip the tick, no
+	 * forced preemption between FIFO tasks.
+	 */
+	fifo_nr_running = rq->rt.rt_nr_running - rq->rt.rr_nr_running;
+	if (fifo_nr_running) {
+		*stop_next = 1;
+		return true;
+	}
+
+	return true;
+}
+#endif
+
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
@@ -2732,6 +2763,9 @@ DEFINE_SCHED_CLASS(rt) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_rt,
 #endif
+#ifdef CONFIG_NO_HZ_FULL
+	.can_stop_tick		= can_stop_tick_rt,
+#endif
 
 #ifdef CONFIG_UCLAMP_TASK
 	.uclamp_enabled		= 1,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4d4b6f178e99..f464e7fff0ef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -459,7 +459,6 @@ extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
-extern bool cfs_task_bw_constrained(struct task_struct *p);
 
 extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 		struct sched_rt_entity *rt_se, int cpu,
@@ -495,7 +494,6 @@ static inline void set_task_rq_fair(struct sched_entity *se,
 #else /* CONFIG_CGROUP_SCHED */
 
 struct cfs_bandwidth { };
-static inline bool cfs_task_bw_constrained(struct task_struct *p) { return false; }
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
@@ -2289,6 +2287,9 @@ struct sched_class {
 #ifdef CONFIG_SCHED_CORE
 	int (*task_is_throttled)(struct task_struct *p, int cpu);
 #endif
+#ifdef CONFIG_NO_HZ_FULL
+	bool (*can_stop_tick)(struct rq *rq, int *stop_next);
+#endif
 };
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
-- 
2.39.2

