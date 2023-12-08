Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF91A8098D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjLHBxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjLHBxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:53:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD9A1722
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:53:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-33339d843b9so1700572f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702000378; x=1702605178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMxFu7ZWH7I2GJUc2EhA+ep8SVNyceUP9JuCj4DA05c=;
        b=yWf2LVuZPCpyfaz98NyeA4D3QOjl2sjA8/xbA1EzrxvnAn7q8ugIuBjtH0RX7wdp2M
         mxYJOWobdVrcSrqx86JpGn7u18T5eNtSZqHNUK2QIMfMyniY6WuWcv6vhYCPIDXUgB02
         Tjt+h3Tir2q9GjIZBL+c6rkcYxcJKGzxgeqIUWq7FiR04vbcJQNI46OmepmYlPgfuQuo
         FyDKLz2E+54wxT4C5lBcpOuPNrM9Zre5sPsHqUZCxgjRIQr4kZr2KN73CugoW7CMoJcB
         OqacmfI6X+OqXaXAvzBWTvHs1ZwaeCVHzHLMVtYy8ET9UI2FAVbbneAO8SpE5ZJdHEXP
         wAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702000378; x=1702605178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMxFu7ZWH7I2GJUc2EhA+ep8SVNyceUP9JuCj4DA05c=;
        b=xOzK7Qc3Trn6VDtx/22oyJcY0qYtiDq1WugcDDIYljQ8qjAieACA6JheZhW43pVTHP
         1Q9C5ORhbsNGh/wckV1asqENnvx9/sApppz04MydkjI4syBWhhzAOOk9efEH55USd7Ed
         kR85Hj56NJ26TquvfaKZo+3i65VEchDW4pDArbyvuadatXC+9kuQN1S8XKjpinM5Y3LP
         eyF/khVROlBxAXO8tWJgMhoOYIlgc+XPYAXrReY4Jdm8AqnDUgI5wN73WVUhtfkP60+I
         UgPSAQtMx3oXius8nTj9LIvMUczMUtVI1qoM+ml2KgTxe6Co04xioBz3cTgycpykFUP9
         nZsQ==
X-Gm-Message-State: AOJu0YwCcMH0lO39nz29z5lq5dvX6UqY935RAqRm2vlrzzM9ZAyb+k5y
        ++dUAT0sUHT3BOqtOMuJTRK9gA==
X-Google-Smtp-Source: AGHT+IFfqwxFCp/jd604GNIIQkttzgaQppk+z65XWwt8A9fHpn0upYszn9Qn5FAsgPHt5FMr5NNIhw==
X-Received: by 2002:a5d:46c3:0:b0:334:b31d:eeb3 with SMTP id g3-20020a5d46c3000000b00334b31deeb3mr1484318wrs.140.1702000378443;
        Thu, 07 Dec 2023 17:52:58 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id s12-20020adf978c000000b003333a0da243sm902521wrb.81.2023.12.07.17.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:52:58 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 2/4] sched/uclamp: Remove rq max aggregation
Date:   Fri,  8 Dec 2023 01:52:40 +0000
Message-Id: <20231208015242.385103-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208015242.385103-1-qyousef@layalina.io>
References: <20231208015242.385103-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max aggregation intended to facilitate combining different uclamp
performance hints from all RUNNABLE tasks on the rq. But in practice
this ended up being a pain, especially for making uclamp_max effective.

What we've seen in practice is that those busy tasks that we really want
to limit how much performance they can get (or how much power they can
consume); can easily be disrupted with a lot of small tasks waking up
during its busy run period. Combine this with schedutil rate limit, we
end up effectively running full throttle without capping being
effective as these small tasks keep being added to the rq making the
max aggregated value 1024 most (if not effectively all) of the time.

Instead of max aggregation, we can go with a simpler approach of
applying uclamp value based on the RUNNING task.

Note that max aggregation is important only for freq selection. For task
placement we already look at the task's uclamp values only in the load
balancer. In EAS we look at the rq, but EAS cares about the frequency
selection too, so it needed to care about max aggregation for that
reason when deciding where to place the task.

To make sure the cpufreq governor follows the new uclamp settings on
context switch, we add a new call to cpufreq_update_util() at the end of
the context switch. The governor should then apply clamp the util with
the uclamp value of whatever task that is currently running on each CPU
in the policy. A new flag SCHED_CPUFREQ_PERF_HINTS was added to help
distinguish this request.

This approach allows us to simplify the code by removing all notion of
buckets, uclamp static key, and the need to inc/dec at enqueue path
which was considered expensive addition to the fast path.

The down side is that we still have the issue of small tasks waking up
can cause the CPU to momentarily to spike to high frequency instigated
by the capped task. It is less severe though as the busy tasks will be
capped for the majority of time it is RUNNING (limited by DVFS hardware
response time to change frequency at each context switch). Compared to
previously whenever uncapped task is enqueued we were lifting the cap.

The problem of handling these small tasks causing a removal of the
capping (or even causing a boost if they had high uclamp_min value)
should be shifted to the governor. If a task runtime is shorter than
DVFS hardware ability to change frequency, then this task's requirements
should be ignored as they won't run long enough to observe the change
due to the hardware limitation.

To keep access to uclamp_eff_value() fast, we continue to store the
effective value there - but instead of relying on active flag which was
set at enqueue and cleared at dequeue; we do so unconditionally whenever
uclamp_min/max is changed via syscall to sched_setattr() or when we
change uclamp_min/max in the hierarchy including root group. Added new
update_uclamp_req() to help keep both p->uclamp_req and p->uclamp in
sync.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/sched.h            |  16 --
 include/linux/sched/cpufreq.h    |   3 +-
 init/Kconfig                     |  31 ---
 kernel/sched/core.c              | 426 +++++--------------------------
 kernel/sched/cpufreq_schedutil.c |   2 +-
 kernel/sched/fair.c              |  80 ++----
 kernel/sched/rt.c                |   4 -
 kernel/sched/sched.h             | 128 ++--------
 8 files changed, 104 insertions(+), 586 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d258162deb0..73b0c6ef8fd9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -700,25 +700,11 @@ struct sched_dl_entity {
 };
 
 #ifdef CONFIG_UCLAMP_TASK
-/* Number of utilization clamp buckets (shorter alias) */
-#define UCLAMP_BUCKETS CONFIG_UCLAMP_BUCKETS_COUNT
-
 /*
  * Utilization clamp for a scheduling entity
  * @value:		clamp value "assigned" to a se
- * @bucket_id:		bucket index corresponding to the "assigned" value
- * @active:		the se is currently refcounted in a rq's bucket
  * @user_defined:	the requested clamp value comes from user-space
  *
- * The bucket_id is the index of the clamp bucket matching the clamp value
- * which is pre-computed and stored to avoid expensive integer divisions from
- * the fast path.
- *
- * The active bit is set whenever a task has got an "effective" value assigned,
- * which can be different from the clamp value "requested" from user-space.
- * This allows to know a task is refcounted in the rq's bucket corresponding
- * to the "effective" bucket_id.
- *
  * The user_defined bit is set whenever a task has got a task-specific clamp
  * value requested from userspace, i.e. the system defaults apply to this task
  * just as a restriction. This allows to relax default clamps when a less
@@ -728,8 +714,6 @@ struct sched_dl_entity {
  */
 struct uclamp_se {
 	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
-	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
-	unsigned int active		: 1;
 	unsigned int user_defined	: 1;
 };
 #endif /* CONFIG_UCLAMP_TASK */
diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d01755d3142f..185f2470597b 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -8,7 +8,8 @@
  * Interface between cpufreq drivers and the scheduler:
  */
 
-#define SCHED_CPUFREQ_IOWAIT	(1U << 0)
+#define SCHED_CPUFREQ_IOWAIT		(1U << 0)
+#define SCHED_CPUFREQ_PERF_HINTS	(1U << 1)
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy;
diff --git a/init/Kconfig b/init/Kconfig
index 9ffb103fc927..8f0cf36cd577 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -809,37 +809,6 @@ config UCLAMP_TASK
 
 	  If in doubt, say N.
 
-config UCLAMP_BUCKETS_COUNT
-	int "Number of supported utilization clamp buckets"
-	range 5 20
-	default 5
-	depends on UCLAMP_TASK
-	help
-	  Defines the number of clamp buckets to use. The range of each bucket
-	  will be SCHED_CAPACITY_SCALE/UCLAMP_BUCKETS_COUNT. The higher the
-	  number of clamp buckets the finer their granularity and the higher
-	  the precision of clamping aggregation and tracking at run-time.
-
-	  For example, with the minimum configuration value we will have 5
-	  clamp buckets tracking 20% utilization each. A 25% boosted tasks will
-	  be refcounted in the [20..39]% bucket and will set the bucket clamp
-	  effective value to 25%.
-	  If a second 30% boosted task should be co-scheduled on the same CPU,
-	  that task will be refcounted in the same bucket of the first task and
-	  it will boost the bucket clamp effective value to 30%.
-	  The clamp effective value of a bucket is reset to its nominal value
-	  (20% in the example above) when there are no more tasks refcounted in
-	  that bucket.
-
-	  An additional boost/capping margin can be added to some tasks. In the
-	  example above the 25% task will be boosted to 30% until it exits the
-	  CPU. If that should be considered not acceptable on certain systems,
-	  it's always possible to reduce the margin by increasing the number of
-	  clamp buckets to trade off used memory for run-time tracking
-	  precision.
-
-	  If in doubt, use the default value.
-
 endmenu
 
 #
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9c8626b4ddff..5095f40edf0e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1389,37 +1389,9 @@ static unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCA
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
-/*
- * This static key is used to reduce the uclamp overhead in the fast path. It
- * primarily disables the call to uclamp_rq_{inc, dec}() in
- * enqueue/dequeue_task().
- *
- * This allows users to continue to enable uclamp in their kernel config with
- * minimum uclamp overhead in the fast path.
- *
- * As soon as userspace modifies any of the uclamp knobs, the static key is
- * enabled, since we have an actual users that make use of uclamp
- * functionality.
- *
- * The knobs that would enable this static key are:
- *
- *   * A task modifying its uclamp value with sched_setattr().
- *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
- *   * An admin modifying the cgroup cpu.uclamp.{min, max}
- */
-DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
-
-/* Integer rounded range for each bucket */
-#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
-
 #define for_each_clamp_id(clamp_id) \
 	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
 
-static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
-{
-	return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
-}
-
 static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
@@ -1431,73 +1403,25 @@ static inline void uclamp_se_set(struct uclamp_se *uc_se,
 				 unsigned int value, bool user_defined)
 {
 	uc_se->value = value;
-	uc_se->bucket_id = uclamp_bucket_id(value);
 	uc_se->user_defined = user_defined;
 }
 
-static inline unsigned int
-uclamp_idle_value(struct rq *rq, enum uclamp_id clamp_id,
-		  unsigned int clamp_value)
-{
-	/*
-	 * Avoid blocked utilization pushing up the frequency when we go
-	 * idle (which drops the max-clamp) by retaining the last known
-	 * max-clamp.
-	 */
-	if (clamp_id == UCLAMP_MAX) {
-		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
-		return clamp_value;
-	}
-
-	return uclamp_none(UCLAMP_MIN);
-}
-
-static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
-				     unsigned int clamp_value)
-{
-	/* Reset max-clamp retention only on idle exit */
-	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
-		return;
-
-	uclamp_rq_set(rq, clamp_id, clamp_value);
-}
-
-static inline
-unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
-				   unsigned int clamp_value)
-{
-	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
-	int bucket_id = UCLAMP_BUCKETS - 1;
-
-	/*
-	 * Since both min and max clamps are max aggregated, find the
-	 * top most bucket with tasks in.
-	 */
-	for ( ; bucket_id >= 0; bucket_id--) {
-		if (!bucket[bucket_id].tasks)
-			continue;
-		return bucket[bucket_id].value;
-	}
-
-	/* No tasks -- default clamp values */
-	return uclamp_idle_value(rq, clamp_id, clamp_value);
-}
+static inline void update_uclamp_req(struct task_struct *p,
+				     enum uclamp_id clamp_id,
+				     unsigned int value, bool user_defined);
 
 static void __uclamp_update_util_min_rt_default(struct task_struct *p)
 {
 	unsigned int default_util_min;
-	struct uclamp_se *uc_se;
 
 	lockdep_assert_held(&p->pi_lock);
 
-	uc_se = &p->uclamp_req[UCLAMP_MIN];
-
 	/* Only sync if user didn't override the default */
-	if (uc_se->user_defined)
+	if (p->uclamp_req[UCLAMP_MIN].user_defined)
 		return;
 
 	default_util_min = sysctl_sched_uclamp_util_min_rt_default;
-	uclamp_se_set(uc_se, default_util_min, false);
+	update_uclamp_req(p, UCLAMP_MIN, default_util_min, false);
 }
 
 static void uclamp_update_util_min_rt_default(struct task_struct *p)
@@ -1545,7 +1469,7 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
  *   group or in an autogroup
  * - the system default clamp value, defined by the sysadmin
  */
-static inline struct uclamp_se
+static inline unsigned long
 uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
@@ -1553,241 +1477,27 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 
 	/* System default restrictions always apply */
 	if (unlikely(uc_req.value > uc_max.value))
-		return uc_max;
+		return uc_max.value;
 
-	return uc_req;
+	return uc_req.value;
 }
 
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
-	struct uclamp_se uc_eff;
-
-	/* Task currently refcounted: use back-annotated (effective) value */
-	if (p->uclamp[clamp_id].active)
-		return (unsigned long)p->uclamp[clamp_id].value;
-
-	uc_eff = uclamp_eff_get(p, clamp_id);
-
-	return (unsigned long)uc_eff.value;
+	/* This should be kept up-to-date whenever uclamp value is changed */
+	return (unsigned long)p->uclamp[clamp_id].value;
 }
 
-/*
- * When a task is enqueued on a rq, the clamp bucket currently defined by the
- * task's uclamp::bucket_id is refcounted on that rq. This also immediately
- * updates the rq's clamp value if required.
- *
- * Tasks can have a task-specific value requested from user-space, track
- * within each bucket the maximum value for tasks refcounted in it.
- * This "local max aggregation" allows to track the exact "requested" value
- * for each bucket when all its RUNNABLE tasks require the same clamp.
- */
-static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
-				    enum uclamp_id clamp_id)
+/* Update task's p->uclamp_req and effective p->uclamp in one go */
+static inline void update_uclamp_req(struct task_struct *p,
+				     enum uclamp_id clamp_id,
+				     unsigned int value, bool user_defined)
 {
-	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
-	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
-	struct uclamp_bucket *bucket;
-
-	lockdep_assert_rq_held(rq);
-
-	/* Update task effective clamp */
-	p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
-
-	bucket = &uc_rq->bucket[uc_se->bucket_id];
-	bucket->tasks++;
-	uc_se->active = true;
-
-	uclamp_idle_reset(rq, clamp_id, uc_se->value);
-
-	/*
-	 * Local max aggregation: rq buckets always track the max
-	 * "requested" clamp value of its RUNNABLE tasks.
-	 */
-	if (bucket->tasks == 1 || uc_se->value > bucket->value)
-		bucket->value = uc_se->value;
-
-	if (uc_se->value > uclamp_rq_get(rq, clamp_id))
-		uclamp_rq_set(rq, clamp_id, uc_se->value);
-}
-
-/*
- * When a task is dequeued from a rq, the clamp bucket refcounted by the task
- * is released. If this is the last task reference counting the rq's max
- * active clamp value, then the rq's clamp value is updated.
- *
- * Both refcounted tasks and rq's cached clamp values are expected to be
- * always valid. If it's detected they are not, as defensive programming,
- * enforce the expected state and warn.
- */
-static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
-				    enum uclamp_id clamp_id)
-{
-	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
-	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
-	struct uclamp_bucket *bucket;
-	unsigned int bkt_clamp;
-	unsigned int rq_clamp;
-
-	lockdep_assert_rq_held(rq);
-
-	/*
-	 * If sched_uclamp_used was enabled after task @p was enqueued,
-	 * we could end up with unbalanced call to uclamp_rq_dec_id().
-	 *
-	 * In this case the uc_se->active flag should be false since no uclamp
-	 * accounting was performed at enqueue time and we can just return
-	 * here.
-	 *
-	 * Need to be careful of the following enqueue/dequeue ordering
-	 * problem too
-	 *
-	 *	enqueue(taskA)
-	 *	// sched_uclamp_used gets enabled
-	 *	enqueue(taskB)
-	 *	dequeue(taskA)
-	 *	// Must not decrement bucket->tasks here
-	 *	dequeue(taskB)
-	 *
-	 * where we could end up with stale data in uc_se and
-	 * bucket[uc_se->bucket_id].
-	 *
-	 * The following check here eliminates the possibility of such race.
-	 */
-	if (unlikely(!uc_se->active))
-		return;
-
-	bucket = &uc_rq->bucket[uc_se->bucket_id];
-
-	SCHED_WARN_ON(!bucket->tasks);
-	if (likely(bucket->tasks))
-		bucket->tasks--;
-
-	uc_se->active = false;
-
-	/*
-	 * Keep "local max aggregation" simple and accept to (possibly)
-	 * overboost some RUNNABLE tasks in the same bucket.
-	 * The rq clamp bucket value is reset to its base value whenever
-	 * there are no more RUNNABLE tasks refcounting it.
-	 */
-	if (likely(bucket->tasks))
-		return;
-
-	rq_clamp = uclamp_rq_get(rq, clamp_id);
-	/*
-	 * Defensive programming: this should never happen. If it happens,
-	 * e.g. due to future modification, warn and fixup the expected value.
-	 */
-	SCHED_WARN_ON(bucket->value > rq_clamp);
-	if (bucket->value >= rq_clamp) {
-		bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
-		uclamp_rq_set(rq, clamp_id, bkt_clamp);
-	}
-}
-
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
-{
-	enum uclamp_id clamp_id;
-
-	/*
-	 * Avoid any overhead until uclamp is actually used by the userspace.
-	 *
-	 * The condition is constructed such that a NOP is generated when
-	 * sched_uclamp_used is disabled.
-	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
-		return;
-
-	if (unlikely(!p->sched_class->uclamp_enabled))
-		return;
-
-	for_each_clamp_id(clamp_id)
-		uclamp_rq_inc_id(rq, p, clamp_id);
-
-	/* Reset clamp idle holding when there is one RUNNABLE task */
-	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
-		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
-}
-
-static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
-{
-	enum uclamp_id clamp_id;
-
-	/*
-	 * Avoid any overhead until uclamp is actually used by the userspace.
-	 *
-	 * The condition is constructed such that a NOP is generated when
-	 * sched_uclamp_used is disabled.
-	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
-		return;
-
-	if (unlikely(!p->sched_class->uclamp_enabled))
-		return;
-
-	for_each_clamp_id(clamp_id)
-		uclamp_rq_dec_id(rq, p, clamp_id);
-}
-
-static inline void uclamp_rq_reinc_id(struct rq *rq, struct task_struct *p,
-				      enum uclamp_id clamp_id)
-{
-	if (!p->uclamp[clamp_id].active)
-		return;
-
-	uclamp_rq_dec_id(rq, p, clamp_id);
-	uclamp_rq_inc_id(rq, p, clamp_id);
-
-	/*
-	 * Make sure to clear the idle flag if we've transiently reached 0
-	 * active tasks on rq.
-	 */
-	if (clamp_id == UCLAMP_MAX && (rq->uclamp_flags & UCLAMP_FLAG_IDLE))
-		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
-}
-
-static inline void
-uclamp_update_active(struct task_struct *p)
-{
-	enum uclamp_id clamp_id;
-	struct rq_flags rf;
-	struct rq *rq;
-
-	/*
-	 * Lock the task and the rq where the task is (or was) queued.
-	 *
-	 * We might lock the (previous) rq of a !RUNNABLE task, but that's the
-	 * price to pay to safely serialize util_{min,max} updates with
-	 * enqueues, dequeues and migration operations.
-	 * This is the same locking schema used by __set_cpus_allowed_ptr().
-	 */
-	rq = task_rq_lock(p, &rf);
-
-	/*
-	 * Setting the clamp bucket is serialized by task_rq_lock().
-	 * If the task is not yet RUNNABLE and its task_struct is not
-	 * affecting a valid clamp bucket, the next time it's enqueued,
-	 * it will already see the updated clamp bucket value.
-	 */
-	for_each_clamp_id(clamp_id)
-		uclamp_rq_reinc_id(rq, p, clamp_id);
-
-	task_rq_unlock(rq, p, &rf);
+	uclamp_se_set(&p->uclamp_req[clamp_id], value, user_defined);
+	uclamp_se_set(&p->uclamp[clamp_id], uclamp_eff_get(p, clamp_id), user_defined);
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
-static inline void
-uclamp_update_active_tasks(struct cgroup_subsys_state *css)
-{
-	struct css_task_iter it;
-	struct task_struct *p;
-
-	css_task_iter_start(css, 0, &it);
-	while ((p = css_task_iter_next(&it)))
-		uclamp_update_active(p);
-	css_task_iter_end(&it);
-}
-
 static void cpu_util_update_eff(struct cgroup_subsys_state *css);
 #endif
 
@@ -1874,15 +1584,11 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		update_root_tg = true;
 	}
 
-	if (update_root_tg) {
-		static_branch_enable(&sched_uclamp_used);
+	if (update_root_tg)
 		uclamp_update_root_tg();
-	}
 
-	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default) {
-		static_branch_enable(&sched_uclamp_used);
+	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default)
 		uclamp_sync_util_min_rt_default();
-	}
 
 	/*
 	 * We update all RUNNABLE tasks only when task groups are in use.
@@ -1923,15 +1629,6 @@ static int uclamp_validate(struct task_struct *p,
 	if (util_min != -1 && util_max != -1 && util_min > util_max)
 		return -EINVAL;
 
-	/*
-	 * We have valid uclamp attributes; make sure uclamp is enabled.
-	 *
-	 * We need to do that here, because enabling static branches is a
-	 * blocking operation which obviously cannot be done while holding
-	 * scheduler locks.
-	 */
-	static_branch_enable(&sched_uclamp_used);
-
 	return 0;
 }
 
@@ -1981,7 +1678,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		else
 			value = uclamp_none(clamp_id);
 
-		uclamp_se_set(uc_se, value, false);
+		update_uclamp_req(p, clamp_id, value, false);
 
 	}
 
@@ -1990,14 +1687,14 @@ static void __setscheduler_uclamp(struct task_struct *p,
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
 	    attr->sched_util_min != -1) {
-		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
-			      attr->sched_util_min, true);
+
+		update_uclamp_req(p, UCLAMP_MIN, attr->sched_util_min, true);
 	}
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
 	    attr->sched_util_max != -1) {
-		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
-			      attr->sched_util_max, true);
+
+		update_uclamp_req(p, UCLAMP_MAX, attr->sched_util_max, true);
 	}
 }
 
@@ -2009,15 +1706,12 @@ static void uclamp_fork(struct task_struct *p)
 	 * We don't need to hold task_rq_lock() when updating p->uclamp_* here
 	 * as the task is still at its early fork stages.
 	 */
-	for_each_clamp_id(clamp_id)
-		p->uclamp[clamp_id].active = false;
-
 	if (likely(!p->sched_reset_on_fork))
 		return;
 
 	for_each_clamp_id(clamp_id) {
-		uclamp_se_set(&p->uclamp_req[clamp_id],
-			      uclamp_none(clamp_id), false);
+		update_uclamp_req(&init_task, clamp_id,
+				  uclamp_none(clamp_id), false);
 	}
 }
 
@@ -2026,32 +1720,17 @@ static void uclamp_post_fork(struct task_struct *p)
 	uclamp_update_util_min_rt_default(p);
 }
 
-static void __init init_uclamp_rq(struct rq *rq)
-{
-	enum uclamp_id clamp_id;
-	struct uclamp_rq *uc_rq = rq->uclamp;
-
-	for_each_clamp_id(clamp_id) {
-		uc_rq[clamp_id] = (struct uclamp_rq) {
-			.value = uclamp_none(clamp_id)
-		};
-	}
-
-	rq->uclamp_flags = UCLAMP_FLAG_IDLE;
-}
-
 static void __init init_uclamp(void)
 {
 	struct uclamp_se uc_max = {};
 	enum uclamp_id clamp_id;
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		init_uclamp_rq(cpu_rq(cpu));
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp_req[clamp_id],
 			      uclamp_none(clamp_id), false);
+
+		uclamp_se_set(&init_task.uclamp[clamp_id],
+			      uclamp_none(clamp_id), false);
 	}
 
 	/* System defaults allow max clamp values for both indexes */
@@ -2066,8 +1745,6 @@ static void __init init_uclamp(void)
 }
 
 #else /* CONFIG_UCLAMP_TASK */
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
-static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline int uclamp_validate(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
@@ -2114,7 +1791,6 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
 
-	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 
 	if (sched_core_enabled(rq))
@@ -2134,7 +1810,6 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
 	}
 
-	uclamp_rq_dec(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
@@ -5150,6 +4825,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
+	uclamp_context_switch(rq);
 	__balance_callbacks(rq);
 	raw_spin_rq_unlock_irq(rq);
 }
@@ -7469,13 +7145,17 @@ int sched_core_idle_cpu(int cpu)
  */
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long *min,
-				 unsigned long *max)
+				 unsigned long *max,
+				 struct task_struct *p)
 {
 	unsigned long util, irq, scale;
 	struct rq *rq = cpu_rq(cpu);
 
 	scale = arch_scale_cpu_capacity(cpu);
 
+	if (!p)
+		p = rq->curr;
+
 	/*
 	 * Early check to see if IRQ/steal time saturates the CPU, can be
 	 * because of inaccuracies in how we track these -- see
@@ -7497,13 +7177,13 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 		 *   steals time to the deadline task.
 		 * - The minimum performance requirement for CFS and/or RT.
 		 */
-		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
+		*min = max(irq + cpu_bw_dl(rq), uclamp_eff_value(p, UCLAMP_MIN));
 
 		/*
 		 * When an RT task is runnable and uclamp is not used, we must
 		 * ensure that the task will run at maximum compute capacity.
 		 */
-		if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
+		if (!IS_ENABLED(CONFIG_UCLAMP_TASK) && rt_rq_is_runnable(&rq->rt))
 			*min = max(*min, scale);
 	}
 
@@ -7521,7 +7201,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * than the actual utilization because of uclamp_max requirements.
 	 */
 	if (max)
-		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
+		*max = min(scale, uclamp_eff_value(p, UCLAMP_MAX));
 
 	if (util >= scale)
 		return scale;
@@ -7543,7 +7223,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 
 unsigned long sched_cpu_util(int cpu)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL, NULL);
 }
 #endif /* CONFIG_SMP */
 
@@ -10585,6 +10265,30 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+static inline void
+uclamp_update_css_tasks(struct cgroup_subsys_state *css)
+{
+	enum uclamp_id clamp_id;
+	struct css_task_iter it;
+	struct task_struct *p;
+
+	/* Update effective uclamp value for all the css tasks */
+	css_task_iter_start(css, 0, &it);
+	while ((p = css_task_iter_next(&it))) {
+
+		/* Only RT and fair support uclamp */
+		if (!rt_policy(p->policy) && !fair_policy(p->policy))
+			continue;
+
+		/* Update task effect value */
+		for_each_clamp_id(clamp_id) {
+			uclamp_se_set(&p->uclamp[clamp_id],
+				      uclamp_eff_get(p, clamp_id), false);
+		}
+	}
+	css_task_iter_end(&it);
+}
+
 static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 {
 	struct cgroup_subsys_state *top_css = css;
@@ -10620,7 +10324,6 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 			if (eff[clamp_id] == uc_se[clamp_id].value)
 				continue;
 			uc_se[clamp_id].value = eff[clamp_id];
-			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
 			clamps |= (0x1 << clamp_id);
 		}
 		if (!clamps) {
@@ -10628,8 +10331,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 			continue;
 		}
 
-		/* Immediately update descendants RUNNABLE tasks */
-		uclamp_update_active_tasks(css);
+		uclamp_update_css_tasks(css);
 	}
 }
 
@@ -10687,8 +10389,6 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	if (req.ret)
 		return req.ret;
 
-	static_branch_enable(&sched_uclamp_used);
-
 	guard(mutex)(&uclamp_mutex);
 	guard(rcu)();
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 788208becc13..137636f62593 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -244,7 +244,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 {
 	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
 
-	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
+	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max, NULL);
 	util = max(util, boost);
 	sg_cpu->bw_min = min;
 	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f99910fc6705..74326179658c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4931,7 +4931,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 */
 	fits = fits_capacity(util, capacity);
 
-	if (!uclamp_is_used())
+	if (!IS_ENABLED(CONFIG_UCLAMP_TASK))
 		return fits;
 
 	/*
@@ -6624,11 +6624,18 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
-	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+	struct task_struct *p = cpu_rq(cpu)->curr;
+	unsigned long util_min = uclamp_eff_value(p, UCLAMP_MIN);
+	unsigned long util_max = uclamp_eff_value(p, UCLAMP_MAX);
 
-	/* Return true only if the utilization doesn't fit CPU's capacity */
-	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
+	/*
+	 * Return true only if the utilization doesn't fit CPU's capacity
+	 *
+	 * TODO: this definition of overutilized = misfit() is stale and no
+	 * longer fit for purpose and must be updated to reflect when the
+	 * system or a cluster is truly overloaded.
+	 */
+	return !util_fits_cpu(cpu_util_cfs(cpu), util_min, util_max, cpu);
 }
 
 static inline void update_overutilized_status(struct rq *rq)
@@ -7776,7 +7783,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	for_each_cpu(cpu, pd_cpus) {
 		unsigned long util = cpu_util(cpu, p, -1, 0);
 
-		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
+		busy_time += effective_cpu_util(cpu, util, NULL, NULL, NULL);
 	}
 
 	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
@@ -7801,30 +7808,9 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
 		unsigned long eff_util, min, max;
 
-		/*
-		 * Performance domain frequency: utilization clamping
-		 * must be considered since it affects the selection
-		 * of the performance domain frequency.
-		 * NOTE: in case RT tasks are running, by default the
-		 * FREQUENCY_UTIL's utilization can be max OPP.
-		 */
-		eff_util = effective_cpu_util(cpu, util, &min, &max);
-
-		/* Task's uclamp can modify min and max value */
-		if (tsk && uclamp_is_used()) {
-			min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
-
-			/*
-			 * If there is no active max uclamp constraint,
-			 * directly use task's one, otherwise keep max.
-			 */
-			if (uclamp_rq_is_idle(cpu_rq(cpu)))
-				max = uclamp_eff_value(p, UCLAMP_MAX);
-			else
-				max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
-		}
-
+		eff_util = effective_cpu_util(cpu, util, &min, &max, tsk);
 		eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
+
 		max_util = max(max_util, eff_util);
 	}
 
@@ -7897,8 +7883,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
-	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
-	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
+	unsigned long p_util_min = uclamp_eff_value(p, UCLAMP_MIN);
+	unsigned long p_util_max = uclamp_eff_value(p, UCLAMP_MAX);
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
 	int prev_fits = -1, best_fits = -1;
@@ -7932,10 +7918,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	eenv_task_busy_time(&eenv, p, prev_cpu);
 
 	for (; pd; pd = pd->next) {
-		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		long prev_spare_cap = -1, max_spare_cap = -1;
-		unsigned long rq_util_min, rq_util_max;
 		unsigned long cur_delta, base_energy;
 		int max_spare_cap_cpu = -1;
 		int fits, max_fits = -1;
@@ -7954,8 +7938,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
-			struct rq *rq = cpu_rq(cpu);
-
 			eenv.pd_cap += cpu_thermal_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
@@ -7967,29 +7949,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			util = cpu_util(cpu, p, cpu, 0);
 			cpu_cap = capacity_of(cpu);
 
-			/*
-			 * Skip CPUs that cannot satisfy the capacity request.
-			 * IOW, placing the task there would make the CPU
-			 * overutilized. Take uclamp into account to see how
-			 * much capacity we can get out of the CPU; this is
-			 * aligned with sched_cpu_util().
-			 */
-			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
-				/*
-				 * Open code uclamp_rq_util_with() except for
-				 * the clamp() part. Ie: apply max aggregation
-				 * only. util_fits_cpu() logic requires to
-				 * operate on non clamped util but must use the
-				 * max-aggregated uclamp_{min, max}.
-				 */
-				rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
-				rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
-
-				util_min = max(rq_util_min, p_util_min);
-				util_max = max(rq_util_max, p_util_max);
-			}
-
-			fits = util_fits_cpu(util, util_min, util_max, cpu);
+			fits = util_fits_cpu(util, p_util_min, p_util_max, cpu);
 			if (!fits)
 				continue;
 
@@ -13135,10 +13095,6 @@ DEFINE_SCHED_CLASS(fair) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_fair,
 #endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..86733bed0e3c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2681,10 +2681,6 @@ DEFINE_SCHED_CLASS(rt) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_rt,
 #endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a7c89c623250..f05a0674a036 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -912,50 +912,6 @@ extern void rto_push_irq_work_func(struct irq_work *work);
 #endif
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_UCLAMP_TASK
-/*
- * struct uclamp_bucket - Utilization clamp bucket
- * @value: utilization clamp value for tasks on this clamp bucket
- * @tasks: number of RUNNABLE tasks on this clamp bucket
- *
- * Keep track of how many tasks are RUNNABLE for a given utilization
- * clamp value.
- */
-struct uclamp_bucket {
-	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
-	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
-};
-
-/*
- * struct uclamp_rq - rq's utilization clamp
- * @value: currently active clamp values for a rq
- * @bucket: utilization clamp buckets affecting a rq
- *
- * Keep track of RUNNABLE tasks on a rq to aggregate their clamp values.
- * A clamp value is affecting a rq when there is at least one task RUNNABLE
- * (or actually running) with that value.
- *
- * There are up to UCLAMP_CNT possible different clamp values, currently there
- * are only two: minimum utilization and maximum utilization.
- *
- * All utilization clamping values are MAX aggregated, since:
- * - for util_min: we want to run the CPU at least at the max of the minimum
- *   utilization required by its currently RUNNABLE tasks.
- * - for util_max: we want to allow the CPU to run up to the max of the
- *   maximum utilization allowed by its currently RUNNABLE tasks.
- *
- * Since on each system we expect only a limited number of different
- * utilization clamp values (UCLAMP_BUCKETS), use a simple array to track
- * the metrics required to compute all the per-rq utilization clamp values.
- */
-struct uclamp_rq {
-	unsigned int value;
-	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
-};
-
-DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
-#endif /* CONFIG_UCLAMP_TASK */
-
 struct rq;
 struct balance_callback {
 	struct balance_callback *next;
@@ -994,13 +950,6 @@ struct rq {
 #endif
 	u64			nr_switches;
 
-#ifdef CONFIG_UCLAMP_TASK
-	/* Utilization clamp values based on CPU's RUNNABLE tasks */
-	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
-	unsigned int		uclamp_flags;
-#define UCLAMP_FLAG_IDLE 0x01
-#endif
-
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
@@ -2248,10 +2197,6 @@ extern s64 update_curr_common(struct rq *rq);
 
 struct sched_class {
 
-#ifdef CONFIG_UCLAMP_TASK
-	int uclamp_enabled;
-#endif
-
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
@@ -2997,7 +2942,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #ifdef CONFIG_SMP
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long *min,
-				 unsigned long *max);
+				 unsigned long *max,
+				 struct task_struct *p);
 
 unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
@@ -3072,49 +3018,35 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 #ifdef CONFIG_UCLAMP_TASK
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
-static inline unsigned long uclamp_rq_get(struct rq *rq,
-					  enum uclamp_id clamp_id)
-{
-	return READ_ONCE(rq->uclamp[clamp_id].value);
-}
-
-static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
-				 unsigned int value)
-{
-	WRITE_ONCE(rq->uclamp[clamp_id].value, value);
-}
-
-static inline bool uclamp_rq_is_idle(struct rq *rq)
-{
-	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
-}
-
 /* Is the rq being capped/throttled by uclamp_max? */
 static inline bool uclamp_rq_is_capped(struct rq *rq)
 {
 	unsigned long rq_util;
 	unsigned long max_util;
 
-	if (!static_branch_likely(&sched_uclamp_used))
-		return false;
-
 	rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
-	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+	max_util = uclamp_eff_value(rq->curr, UCLAMP_MAX);
 
 	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
 }
 
-/*
- * When uclamp is compiled in, the aggregation at rq level is 'turned off'
- * by default in the fast path and only gets turned on once userspace performs
- * an operation that requires it.
- *
- * Returns true if userspace opted-in to use uclamp and aggregation at rq level
- * hence is active.
- */
-static inline bool uclamp_is_used(void)
+/* Request freq update on context switch if necessary */
+static inline void uclamp_context_switch(struct rq *rq)
 {
-	return static_branch_likely(&sched_uclamp_used);
+	unsigned long uclamp_min;
+	unsigned long uclamp_max;
+	unsigned long util;
+
+	/* Only RT and FAIR tasks are aware of uclamp */
+	if (!rt_policy(current->policy) && !fair_policy(current->policy))
+		return;
+
+	uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
+	uclamp_max = uclamp_eff_value(current, UCLAMP_MAX);
+	util = rq->cfs.avg.util_avg;
+
+	if (uclamp_min > util || uclamp_max < util)
+		cpufreq_update_util(rq, SCHED_CPUFREQ_PERF_HINTS);
 }
 #else /* CONFIG_UCLAMP_TASK */
 static inline unsigned long uclamp_eff_value(struct task_struct *p,
@@ -3128,28 +3060,8 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
 
 static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
 
-static inline bool uclamp_is_used(void)
+static inline void uclamp_context_switch(struct rq *rq)
 {
-	return false;
-}
-
-static inline unsigned long uclamp_rq_get(struct rq *rq,
-					  enum uclamp_id clamp_id)
-{
-	if (clamp_id == UCLAMP_MIN)
-		return 0;
-
-	return SCHED_CAPACITY_SCALE;
-}
-
-static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
-				 unsigned int value)
-{
-}
-
-static inline bool uclamp_rq_is_idle(struct rq *rq)
-{
-	return false;
 }
 #endif /* CONFIG_UCLAMP_TASK */
 
-- 
2.34.1

