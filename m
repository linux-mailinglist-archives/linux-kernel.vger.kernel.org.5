Return-Path: <linux-kernel+bounces-134258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A489AFBE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8941C2113D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7141C69E;
	Sun,  7 Apr 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlTjVYq8"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3EF1118E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479432; cv=none; b=GBefnl30R4BNe+HN/erwyfvDmnNudx5mw+Rl/yN/OpeT61sIVfTpAVAoyYiN7U50TDiCCbJvwttHcKczmUL0tNlivxrg7O0Xcc8NZC68hAewXX+0pkGKJyu+CoT6niYXQX5sizNRGvn5FqO/tV9+ruHJnVS0iu2b7Z1Q+qjsSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479432; c=relaxed/simple;
	bh=GpqckT4PQWS5UGY5qS1vIf767JaV3bKOohoBleDdXec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kwm0IModx5nIcic+b3QydAI22E474NhwHEEDGGrf70ijNbOWqsPkHTI9EijdSmkZMqU/LRClUgbKNZy9PU2hU1y4H3K9fIlBxtuojoIDHcuBZAeCC6gsv5mhxzQJ2XzjjzdsmLNCMlSkgEkrCFUMj5UA8tcbj74zS+DPM5Dl6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlTjVYq8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51d05c50b2so20643966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712479425; x=1713084225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X5+KOwLFw5wxxr4yK4f1vWf4/L1Olar3a9d+X8Qauk=;
        b=mlTjVYq8KtaOl+PpkR5bSw+ptOGuZ1QJ9XBsYgEMdMAJwdjZ5DvZBLqf/naMh9Tm2L
         s1+PlqlRxQxuLziBWQfEqczlv8796OwgOGk22+WBNkthqT2ZEBZFboe43hHi9Pm2rV7w
         GmvPHjMkQo2Qyy4dCpoIjISD9V5l7ZmevH+ft1X8JHrpofeo44F1/KPMT9wNt/qKLKl4
         fZf3ZkgmBUx+gKdPty80YQQFv2WADUHOH99iJdTnyeUIhHmsV2xVXhMlPY0n/A5S+PWx
         WQIXH32z0jUrHS4tlWLHpiQW8U+QCYk7ar7jIwn2HFK6Ybx8LbsaN2KLOoXE1Yp9gpno
         ebCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712479425; x=1713084225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7X5+KOwLFw5wxxr4yK4f1vWf4/L1Olar3a9d+X8Qauk=;
        b=RnkG88k4MB9xQfMKSvNkOCLAJsMwobPzYBReeauzAsB31P5luc0sr72eNXHFEOfynP
         7nx8AlKa0pDMHsOitdyR3Zh7x0XEHBMqVD/O2xYdh+c3EEwE3hEr2accHI3Tvi9uNeAp
         kPwd8zfgrAasJWujAG4lIf5GpioYatUYu4GmogYqmKCxF1b7Iof9Qr5YYqvgeGfVPI/X
         fAqm/SyHzOA0vtVsN072tzUhBXidarP7MpKHvmwooas3A0p2O7S5G/b+PC/Egl6TcVov
         glIWapgu8OPpF9UTEt2GJBpvsqRImX4dz874W8h83nd3AASleUfUqQ88L7hO6ojF4p9j
         9pTg==
X-Gm-Message-State: AOJu0YxqY+9ip7hTaESX0qYfxCYkUGdxKp2jHnKBOZCX0LXNhl0zntPW
	sGpsnjGGuXnmrWOQZ8G01w6ayoqw+8c6f1Imu9mGx/v7iX7Sk1nUA7t7uDpnkXE=
X-Google-Smtp-Source: AGHT+IF/WtfxhIQeIrbtH5Scm0qgNed7RCQlvHGzybtcj/GG9AEyXj8Skw3vYf4Pglehjl2prfkTjQ==
X-Received: by 2002:a17:907:985b:b0:a4e:109f:7b4b with SMTP id jj27-20020a170907985b00b00a4e109f7b4bmr4235700ejc.41.1712479423775;
        Sun, 07 Apr 2024 01:43:43 -0700 (PDT)
Received: from thule.. (84-236-113-28.pool.digikabel.hu. [84.236.113.28])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00a4e28cacbddsm2891579ejz.57.2024.04.07.01.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:43:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/5] sched: Split out kernel/sched/syscalls.c from kernel/sched/core.c
Date: Sun,  7 Apr 2024 10:43:15 +0200
Message-Id: <20240407084319.1462211-2-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240407084319.1462211-1-mingo@kernel.org>
References: <20240407084319.1462211-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

core.c has become rather large, move most scheduler syscall
related functionality into a separate file, syscalls.c.

Move the alloc_user_cpus_ptr(), __rt_effective_prio(),
rt_effective_prio(), uclamp_none(), uclamp_se_set()
and uclamp_bucket_id() inlines to kernel/sched/sched.h.

Internally export the __sched_setscheduler(), __sched_setaffinity(),
__setscheduler_prio(), set_load_weight(), enqueue_task(), dequeue_task(),
check_class_changed(), splice_balance_callbacks() and balance_callbacks()
methods to better facilitate this.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/Makefile   |    1 +
 kernel/sched/core.c     | 1950 ++++---------------------------------------------------------------
 kernel/sched/sched.h    |  106 +++-
 kernel/sched/syscalls.c | 1691 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1892 insertions(+), 1856 deletions(-)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 976092b7bd45..c7afe445480a 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -29,6 +29,7 @@ endif
 # build parallelizes well and finishes roughly at once:
 #
 obj-y += core.o
+obj-y += syscalls.o
 obj-y += fair.o
 obj-y += build_policy.o
 obj-y += build_utility.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0621e4ee31de..7fbb53d27229 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1324,7 +1324,7 @@ int tg_nop(struct task_group *tg, void *data)
 }
 #endif
 
-static void set_load_weight(struct task_struct *p, bool update_load)
+void set_load_weight(struct task_struct *p, bool update_load)
 {
 	int prio = p->static_prio - MAX_RT_PRIO;
 	struct load_weight *load = &p->se.load;
@@ -1384,7 +1384,7 @@ static unsigned int __maybe_unused sysctl_sched_uclamp_util_max = SCHED_CAPACITY
  * This knob will not override the system default sched_util_clamp_min defined
  * above.
  */
-static unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
+unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
 
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
@@ -1409,32 +1409,6 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
  */
 DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
 
-/* Integer rounded range for each bucket */
-#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
-
-#define for_each_clamp_id(clamp_id) \
-	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
-
-static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
-{
-	return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
-}
-
-static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
-{
-	if (clamp_id == UCLAMP_MIN)
-		return 0;
-	return SCHED_CAPACITY_SCALE;
-}
-
-static inline void uclamp_se_set(struct uclamp_se *uc_se,
-				 unsigned int value, bool user_defined)
-{
-	uc_se->value = value;
-	uc_se->bucket_id = uclamp_bucket_id(value);
-	uc_se->user_defined = user_defined;
-}
-
 static inline unsigned int
 uclamp_idle_value(struct rq *rq, enum uclamp_id clamp_id,
 		  unsigned int clamp_value)
@@ -1898,107 +1872,6 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 }
 #endif
 
-static int uclamp_validate(struct task_struct *p,
-			   const struct sched_attr *attr)
-{
-	int util_min = p->uclamp_req[UCLAMP_MIN].value;
-	int util_max = p->uclamp_req[UCLAMP_MAX].value;
-
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
-		util_min = attr->sched_util_min;
-
-		if (util_min + 1 > SCHED_CAPACITY_SCALE + 1)
-			return -EINVAL;
-	}
-
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
-		util_max = attr->sched_util_max;
-
-		if (util_max + 1 > SCHED_CAPACITY_SCALE + 1)
-			return -EINVAL;
-	}
-
-	if (util_min != -1 && util_max != -1 && util_min > util_max)
-		return -EINVAL;
-
-	/*
-	 * We have valid uclamp attributes; make sure uclamp is enabled.
-	 *
-	 * We need to do that here, because enabling static branches is a
-	 * blocking operation which obviously cannot be done while holding
-	 * scheduler locks.
-	 */
-	static_branch_enable(&sched_uclamp_used);
-
-	return 0;
-}
-
-static bool uclamp_reset(const struct sched_attr *attr,
-			 enum uclamp_id clamp_id,
-			 struct uclamp_se *uc_se)
-{
-	/* Reset on sched class change for a non user-defined clamp value. */
-	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) &&
-	    !uc_se->user_defined)
-		return true;
-
-	/* Reset on sched_util_{min,max} == -1. */
-	if (clamp_id == UCLAMP_MIN &&
-	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
-	    attr->sched_util_min == -1) {
-		return true;
-	}
-
-	if (clamp_id == UCLAMP_MAX &&
-	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
-	    attr->sched_util_max == -1) {
-		return true;
-	}
-
-	return false;
-}
-
-static void __setscheduler_uclamp(struct task_struct *p,
-				  const struct sched_attr *attr)
-{
-	enum uclamp_id clamp_id;
-
-	for_each_clamp_id(clamp_id) {
-		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
-		unsigned int value;
-
-		if (!uclamp_reset(attr, clamp_id, uc_se))
-			continue;
-
-		/*
-		 * RT by default have a 100% boost value that could be modified
-		 * at runtime.
-		 */
-		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			value = sysctl_sched_uclamp_util_min_rt_default;
-		else
-			value = uclamp_none(clamp_id);
-
-		uclamp_se_set(uc_se, value, false);
-
-	}
-
-	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
-		return;
-
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
-	    attr->sched_util_min != -1) {
-		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
-			      attr->sched_util_min, true);
-	}
-
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
-	    attr->sched_util_max != -1) {
-		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
-			      attr->sched_util_max, true);
-	}
-}
-
 static void uclamp_fork(struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
@@ -2066,13 +1939,6 @@ static void __init init_uclamp(void)
 #else /* !CONFIG_UCLAMP_TASK */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
-static inline int uclamp_validate(struct task_struct *p,
-				  const struct sched_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-static void __setscheduler_uclamp(struct task_struct *p,
-				  const struct sched_attr *attr) { }
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void uclamp_post_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
@@ -2102,7 +1968,7 @@ unsigned long get_wchan(struct task_struct *p)
 	return ip;
 }
 
-static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
+void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
@@ -2119,7 +1985,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		sched_core_enqueue(rq, p);
 }
 
-static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
+void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (sched_core_enabled(rq))
 		sched_core_dequeue(rq, p, flags);
@@ -2157,52 +2023,6 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_task(rq, p, flags);
 }
 
-static inline int __normal_prio(int policy, int rt_prio, int nice)
-{
-	int prio;
-
-	if (dl_policy(policy))
-		prio = MAX_DL_PRIO - 1;
-	else if (rt_policy(policy))
-		prio = MAX_RT_PRIO - 1 - rt_prio;
-	else
-		prio = NICE_TO_PRIO(nice);
-
-	return prio;
-}
-
-/*
- * Calculate the expected normal priority: i.e. priority
- * without taking RT-inheritance into account. Might be
- * boosted by interactivity modifiers. Changes upon fork,
- * setprio syscalls, and whenever the interactivity
- * estimator recalculates.
- */
-static inline int normal_prio(struct task_struct *p)
-{
-	return __normal_prio(p->policy, p->rt_priority, PRIO_TO_NICE(p->static_prio));
-}
-
-/*
- * Calculate the current priority, i.e. the priority
- * taken into account by the scheduler. This value might
- * be boosted by RT tasks, or might be boosted by
- * interactivity modifiers. Will be RT if the task got
- * RT-boosted. If not then it returns p->normal_prio.
- */
-static int effective_prio(struct task_struct *p)
-{
-	p->normal_prio = normal_prio(p);
-	/*
-	 * If we are RT tasks or we were boosted to RT priority,
-	 * keep the priority unchanged. Otherwise, update priority
-	 * to the normal priority:
-	 */
-	if (!rt_prio(p->prio))
-		return p->normal_prio;
-	return p->prio;
-}
-
 /**
  * task_curr - is this task currently executing on a CPU?
  * @p: the task in question.
@@ -2221,9 +2041,9 @@ inline int task_curr(const struct task_struct *p)
  * this means any call to check_class_changed() must be followed by a call to
  * balance_callback().
  */
-static inline void check_class_changed(struct rq *rq, struct task_struct *p,
-				       const struct sched_class *prev_class,
-				       int oldprio)
+void check_class_changed(struct rq *rq, struct task_struct *p,
+			 const struct sched_class *prev_class,
+			 int oldprio)
 {
 	if (prev_class != p->sched_class) {
 		if (prev_class->switched_from)
@@ -2392,9 +2212,6 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 static void
 __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
 
-static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  struct affinity_context *ctx);
-
 static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 {
 	struct affinity_context ac = {
@@ -2821,16 +2638,6 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
 }
 
-static cpumask_t *alloc_user_cpus_ptr(int node)
-{
-	/*
-	 * See do_set_cpus_allowed() above for the rcu_head usage.
-	 */
-	int size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
-
-	return kmalloc_node(size, GFP_KERNEL, node);
-}
-
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 		      int node)
 {
@@ -3199,8 +3006,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
  * task must not exit() & deallocate itself prematurely. The
  * call is not atomic; no spinlocks may be held.
  */
-static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  struct affinity_context *ctx)
+int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -3319,9 +3125,6 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 	free_cpumask_var(new_mask);
 }
 
-static int
-__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
-
 /*
  * Restore the affinity of a task @p which was previously restricted by a
  * call to force_compatible_cpus_allowed_ptr().
@@ -3701,12 +3504,6 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 
 #else /* CONFIG_SMP */
 
-static inline int __set_cpus_allowed_ptr(struct task_struct *p,
-					 struct affinity_context *ctx)
-{
-	return set_cpus_allowed_ptr(p, ctx->new_mask);
-}
-
 static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
 
 static inline bool rq_has_pinned_tasks(struct rq *rq)
@@ -3714,11 +3511,6 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return false;
 }
 
-static inline cpumask_t *alloc_user_cpus_ptr(int node)
-{
-	return NULL;
-}
-
 #endif /* !CONFIG_SMP */
 
 static void
@@ -5096,7 +4888,7 @@ __splice_balance_callbacks(struct rq *rq, bool split)
 	return head;
 }
 
-static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
+struct balance_callback *splice_balance_callbacks(struct rq *rq)
 {
 	return __splice_balance_callbacks(rq, true);
 }
@@ -5106,7 +4898,7 @@ static void __balance_callbacks(struct rq *rq)
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
 
-static inline void balance_callbacks(struct rq *rq, struct balance_callback *head)
+void balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	unsigned long flags;
 
@@ -5123,15 +4915,6 @@ static inline void __balance_callbacks(struct rq *rq)
 {
 }
 
-static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
-{
-	return NULL;
-}
-
-static inline void balance_callbacks(struct rq *rq, struct balance_callback *head)
-{
-}
-
 #endif
 
 static inline void
@@ -7081,7 +6864,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-static void __setscheduler_prio(struct task_struct *p, int prio)
+void __setscheduler_prio(struct task_struct *p, int prio)
 {
 	if (dl_prio(prio))
 		p->sched_class = &dl_sched_class;
@@ -7121,21 +6904,6 @@ void rt_mutex_post_schedule(void)
 	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
 }
 
-static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
-{
-	if (pi_task)
-		prio = min(prio, pi_task->prio);
-
-	return prio;
-}
-
-static inline int rt_effective_prio(struct task_struct *p, int prio)
-{
-	struct task_struct *pi_task = rt_mutex_get_top_task(p);
-
-	return __rt_effective_prio(pi_task, prio);
-}
-
 /*
  * rt_mutex_setprio - set the current priority of a task
  * @p: task to boost
@@ -7264,1434 +7032,117 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	preempt_enable();
 }
-#else
-static inline int rt_effective_prio(struct task_struct *p, int prio)
-{
-	return prio;
-}
 #endif
 
-void set_user_nice(struct task_struct *p, long nice)
+#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
+int __sched __cond_resched(void)
 {
-	bool queued, running;
-	struct rq *rq;
-	int old_prio;
-
-	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
-		return;
-	/*
-	 * We have to be careful, if called from sys_setpriority(),
-	 * the task might be in the middle of scheduling on another CPU.
-	 */
-	CLASS(task_rq_lock, rq_guard)(p);
-	rq = rq_guard.rq;
-
-	update_rq_clock(rq);
-
-	/*
-	 * The RT priorities are set via sched_setscheduler(), but we still
-	 * allow the 'normal' nice value to be set - but as expected
-	 * it won't have any effect on scheduling until the task is
-	 * SCHED_DEADLINE, SCHED_FIFO or SCHED_RR:
-	 */
-	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
-		p->static_prio = NICE_TO_PRIO(nice);
-		return;
+	if (should_resched(0)) {
+		preempt_schedule_common();
+		return 1;
 	}
-
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->static_prio = NICE_TO_PRIO(nice);
-	set_load_weight(p, true);
-	old_prio = p->prio;
-	p->prio = effective_prio(p);
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
-
 	/*
-	 * If the task increased its priority or is running and
-	 * lowered its priority, then reschedule its CPU:
+	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
+	 * whether the current CPU is in an RCU read-side critical section,
+	 * so the tick can report quiescent states even for CPUs looping
+	 * in kernel context.  In contrast, in non-preemptible kernels,
+	 * RCU readers leave no in-memory hints, which means that CPU-bound
+	 * processes executing in kernel context might never report an
+	 * RCU quiescent state.  Therefore, the following code causes
+	 * cond_resched() to report a quiescent state, but only when RCU
+	 * is in urgent need of one.
 	 */
-	p->sched_class->prio_changed(rq, p, old_prio);
+#ifndef CONFIG_PREEMPT_RCU
+	rcu_all_qs();
+#endif
+	return 0;
 }
-EXPORT_SYMBOL(set_user_nice);
+EXPORT_SYMBOL(__cond_resched);
+#endif
 
-/*
- * is_nice_reduction - check if nice value is an actual reduction
- *
- * Similar to can_nice() but does not perform a capability check.
- *
- * @p: task
- * @nice: nice value
- */
-static bool is_nice_reduction(const struct task_struct *p, const int nice)
-{
-	/* Convert nice value [19,-20] to rlimit style value [1,40]: */
-	int nice_rlim = nice_to_rlimit(nice);
+#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+#define cond_resched_dynamic_enabled	__cond_resched
+#define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
+DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
+EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
-	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE));
+#define might_resched_dynamic_enabled	__cond_resched
+#define might_resched_dynamic_disabled	((void *)&__static_call_return0)
+DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
+EXPORT_STATIC_CALL_TRAMP(might_resched);
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
+int __sched dynamic_cond_resched(void)
+{
+	klp_sched_try_switch();
+	if (!static_branch_unlikely(&sk_dynamic_cond_resched))
+		return 0;
+	return __cond_resched();
 }
+EXPORT_SYMBOL(dynamic_cond_resched);
 
-/*
- * can_nice - check if a task can reduce its nice value
- * @p: task
- * @nice: nice value
- */
-int can_nice(const struct task_struct *p, const int nice)
+static DEFINE_STATIC_KEY_FALSE(sk_dynamic_might_resched);
+int __sched dynamic_might_resched(void)
 {
-	return is_nice_reduction(p, nice) || capable(CAP_SYS_NICE);
+	if (!static_branch_unlikely(&sk_dynamic_might_resched))
+		return 0;
+	return __cond_resched();
 }
-
-#ifdef __ARCH_WANT_SYS_NICE
+EXPORT_SYMBOL(dynamic_might_resched);
+#endif
+#endif
 
 /*
- * sys_nice - change the priority of the current process.
- * @increment: priority increment
+ * __cond_resched_lock() - if a reschedule is pending, drop the given lock,
+ * call schedule, and on return reacquire the lock.
  *
- * sys_setpriority is a more generic, but much slower function that
- * does similar things.
+ * This works OK both with and without CONFIG_PREEMPTION. We do strange low-level
+ * operations here to prevent schedule() from being called twice (once via
+ * spin_unlock(), once by hand).
  */
-SYSCALL_DEFINE1(nice, int, increment)
+int __cond_resched_lock(spinlock_t *lock)
 {
-	long nice, retval;
-
-	/*
-	 * Setpriority might change our priority at the same moment.
-	 * We don't have to worry. Conceptually one call occurs first
-	 * and we have a single winner.
-	 */
-	increment = clamp(increment, -NICE_WIDTH, NICE_WIDTH);
-	nice = task_nice(current) + increment;
-
-	nice = clamp_val(nice, MIN_NICE, MAX_NICE);
-	if (increment < 0 && !can_nice(current, nice))
-		return -EPERM;
+	int resched = should_resched(PREEMPT_LOCK_OFFSET);
+	int ret = 0;
 
-	retval = security_task_setnice(current, nice);
-	if (retval)
-		return retval;
+	lockdep_assert_held(lock);
 
-	set_user_nice(current, nice);
-	return 0;
+	if (spin_needbreak(lock) || resched) {
+		spin_unlock(lock);
+		if (!_cond_resched())
+			cpu_relax();
+		ret = 1;
+		spin_lock(lock);
+	}
+	return ret;
 }
+EXPORT_SYMBOL(__cond_resched_lock);
 
-#endif
-
-/**
- * task_prio - return the priority value of a given task.
- * @p: the task in question.
- *
- * Return: The priority value as seen by users in /proc.
- *
- * sched policy         return value   kernel prio    user prio/nice
- *
- * normal, batch, idle     [0 ... 39]  [100 ... 139]          0/[-20 ... 19]
- * fifo, rr             [-2 ... -100]     [98 ... 0]  [1 ... 99]
- * deadline                     -101             -1           0
- */
-int task_prio(const struct task_struct *p)
+int __cond_resched_rwlock_read(rwlock_t *lock)
 {
-	return p->prio - MAX_RT_PRIO;
+	int resched = should_resched(PREEMPT_LOCK_OFFSET);
+	int ret = 0;
+
+	lockdep_assert_held_read(lock);
+
+	if (rwlock_needbreak(lock) || resched) {
+		read_unlock(lock);
+		if (!_cond_resched())
+			cpu_relax();
+		ret = 1;
+		read_lock(lock);
+	}
+	return ret;
 }
+EXPORT_SYMBOL(__cond_resched_rwlock_read);
 
-/**
- * idle_cpu - is a given CPU idle currently?
- * @cpu: the processor in question.
- *
- * Return: 1 if the CPU is currently idle. 0 otherwise.
- */
-int idle_cpu(int cpu)
+int __cond_resched_rwlock_write(rwlock_t *lock)
 {
-	struct rq *rq = cpu_rq(cpu);
+	int resched = should_resched(PREEMPT_LOCK_OFFSET);
+	int ret = 0;
 
-	if (rq->curr != rq->idle)
-		return 0;
-
-	if (rq->nr_running)
-		return 0;
-
-#ifdef CONFIG_SMP
-	if (rq->ttwu_pending)
-		return 0;
-#endif
-
-	return 1;
-}
-
-/**
- * available_idle_cpu - is a given CPU idle for enqueuing work.
- * @cpu: the CPU in question.
- *
- * Return: 1 if the CPU is currently idle. 0 otherwise.
- */
-int available_idle_cpu(int cpu)
-{
-	if (!idle_cpu(cpu))
-		return 0;
-
-	if (vcpu_is_preempted(cpu))
-		return 0;
-
-	return 1;
-}
-
-/**
- * idle_task - return the idle task for a given CPU.
- * @cpu: the processor in question.
- *
- * Return: The idle task for the CPU @cpu.
- */
-struct task_struct *idle_task(int cpu)
-{
-	return cpu_rq(cpu)->idle;
-}
-
-#ifdef CONFIG_SCHED_CORE
-int sched_core_idle_cpu(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	if (sched_core_enabled(rq) && rq->curr == rq->idle)
-		return 1;
-
-	return idle_cpu(cpu);
-}
-
-#endif
-
-#ifdef CONFIG_SMP
-/*
- * This function computes an effective utilization for the given CPU, to be
- * used for frequency selection given the linear relation: f = u * f_max.
- *
- * The scheduler tracks the following metrics:
- *
- *   cpu_util_{cfs,rt,dl,irq}()
- *   cpu_bw_dl()
- *
- * Where the cfs,rt and dl util numbers are tracked with the same metric and
- * synchronized windows and are thus directly comparable.
- *
- * The cfs,rt,dl utilization are the running times measured with rq->clock_task
- * which excludes things like IRQ and steal-time. These latter are then accrued
- * in the irq utilization.
- *
- * The DL bandwidth number otoh is not a measured metric but a value computed
- * based on the task model parameters and gives the minimal utilization
- * required to meet deadlines.
- */
-unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long *min,
-				 unsigned long *max)
-{
-	unsigned long util, irq, scale;
-	struct rq *rq = cpu_rq(cpu);
-
-	scale = arch_scale_cpu_capacity(cpu);
-
-	/*
-	 * Early check to see if IRQ/steal time saturates the CPU, can be
-	 * because of inaccuracies in how we track these -- see
-	 * update_irq_load_avg().
-	 */
-	irq = cpu_util_irq(rq);
-	if (unlikely(irq >= scale)) {
-		if (min)
-			*min = scale;
-		if (max)
-			*max = scale;
-		return scale;
-	}
-
-	if (min) {
-		/*
-		 * The minimum utilization returns the highest level between:
-		 * - the computed DL bandwidth needed with the IRQ pressure which
-		 *   steals time to the deadline task.
-		 * - The minimum performance requirement for CFS and/or RT.
-		 */
-		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
-
-		/*
-		 * When an RT task is runnable and uclamp is not used, we must
-		 * ensure that the task will run at maximum compute capacity.
-		 */
-		if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
-			*min = max(*min, scale);
-	}
-
-	/*
-	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
-	 * CFS tasks and we use the same metric to track the effective
-	 * utilization (PELT windows are synchronized) we can directly add them
-	 * to obtain the CPU's actual utilization.
-	 */
-	util = util_cfs + cpu_util_rt(rq);
-	util += cpu_util_dl(rq);
-
-	/*
-	 * The maximum hint is a soft bandwidth requirement, which can be lower
-	 * than the actual utilization because of uclamp_max requirements.
-	 */
-	if (max)
-		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
-
-	if (util >= scale)
-		return scale;
-
-	/*
-	 * There is still idle time; further improve the number by using the
-	 * irq metric. Because IRQ/steal time is hidden from the task clock we
-	 * need to scale the task numbers:
-	 *
-	 *              max - irq
-	 *   U' = irq + --------- * U
-	 *                 max
-	 */
-	util = scale_irq_capacity(util, irq, scale);
-	util += irq;
-
-	return min(scale, util);
-}
-
-unsigned long sched_cpu_util(int cpu)
-{
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
-}
-#endif /* CONFIG_SMP */
-
-/**
- * find_process_by_pid - find a process with a matching PID value.
- * @pid: the pid in question.
- *
- * The task of @pid, if found. %NULL otherwise.
- */
-static struct task_struct *find_process_by_pid(pid_t pid)
-{
-	return pid ? find_task_by_vpid(pid) : current;
-}
-
-static struct task_struct *find_get_task(pid_t pid)
-{
-	struct task_struct *p;
-	guard(rcu)();
-
-	p = find_process_by_pid(pid);
-	if (likely(p))
-		get_task_struct(p);
-
-	return p;
-}
-
-DEFINE_CLASS(find_get_task, struct task_struct *, if (_T) put_task_struct(_T),
-	     find_get_task(pid), pid_t pid)
-
-/*
- * sched_setparam() passes in -1 for its policy, to let the functions
- * it calls know not to change it.
- */
-#define SETPARAM_POLICY	-1
-
-static void __setscheduler_params(struct task_struct *p,
-		const struct sched_attr *attr)
-{
-	int policy = attr->sched_policy;
-
-	if (policy == SETPARAM_POLICY)
-		policy = p->policy;
-
-	p->policy = policy;
-
-	if (dl_policy(policy))
-		__setparam_dl(p, attr);
-	else if (fair_policy(policy))
-		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
-
-	/*
-	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
-	 * !rt_policy. Always setting this ensures that things like
-	 * getparam()/getattr() don't report silly values for !rt tasks.
-	 */
-	p->rt_priority = attr->sched_priority;
-	p->normal_prio = normal_prio(p);
-	set_load_weight(p, true);
-}
-
-/*
- * Check the target process has a UID that matches the current process's:
- */
-static bool check_same_owner(struct task_struct *p)
-{
-	const struct cred *cred = current_cred(), *pcred;
-	guard(rcu)();
-
-	pcred = __task_cred(p);
-	return (uid_eq(cred->euid, pcred->euid) ||
-		uid_eq(cred->euid, pcred->uid));
-}
-
-/*
- * Allow unprivileged RT tasks to decrease priority.
- * Only issue a capable test if needed and only once to avoid an audit
- * event on permitted non-privileged operations:
- */
-static int user_check_sched_setscheduler(struct task_struct *p,
-					 const struct sched_attr *attr,
-					 int policy, int reset_on_fork)
-{
-	if (fair_policy(policy)) {
-		if (attr->sched_nice < task_nice(p) &&
-		    !is_nice_reduction(p, attr->sched_nice))
-			goto req_priv;
-	}
-
-	if (rt_policy(policy)) {
-		unsigned long rlim_rtprio = task_rlimit(p, RLIMIT_RTPRIO);
-
-		/* Can't set/change the rt policy: */
-		if (policy != p->policy && !rlim_rtprio)
-			goto req_priv;
-
-		/* Can't increase priority: */
-		if (attr->sched_priority > p->rt_priority &&
-		    attr->sched_priority > rlim_rtprio)
-			goto req_priv;
-	}
-
-	/*
-	 * Can't set/change SCHED_DEADLINE policy at all for now
-	 * (safest behavior); in the future we would like to allow
-	 * unprivileged DL tasks to increase their relative deadline
-	 * or reduce their runtime (both ways reducing utilization)
-	 */
-	if (dl_policy(policy))
-		goto req_priv;
-
-	/*
-	 * Treat SCHED_IDLE as nice 20. Only allow a switch to
-	 * SCHED_NORMAL if the RLIMIT_NICE would normally permit it.
-	 */
-	if (task_has_idle_policy(p) && !idle_policy(policy)) {
-		if (!is_nice_reduction(p, task_nice(p)))
-			goto req_priv;
-	}
-
-	/* Can't change other user's priorities: */
-	if (!check_same_owner(p))
-		goto req_priv;
-
-	/* Normal users shall not reset the sched_reset_on_fork flag: */
-	if (p->sched_reset_on_fork && !reset_on_fork)
-		goto req_priv;
-
-	return 0;
-
-req_priv:
-	if (!capable(CAP_SYS_NICE))
-		return -EPERM;
-
-	return 0;
-}
-
-static int __sched_setscheduler(struct task_struct *p,
-				const struct sched_attr *attr,
-				bool user, bool pi)
-{
-	int oldpolicy = -1, policy = attr->sched_policy;
-	int retval, oldprio, newprio, queued, running;
-	const struct sched_class *prev_class;
-	struct balance_callback *head;
-	struct rq_flags rf;
-	int reset_on_fork;
-	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
-	struct rq *rq;
-	bool cpuset_locked = false;
-
-	/* The pi code expects interrupts enabled */
-	BUG_ON(pi && in_interrupt());
-recheck:
-	/* Double check policy once rq lock held: */
-	if (policy < 0) {
-		reset_on_fork = p->sched_reset_on_fork;
-		policy = oldpolicy = p->policy;
-	} else {
-		reset_on_fork = !!(attr->sched_flags & SCHED_FLAG_RESET_ON_FORK);
-
-		if (!valid_policy(policy))
-			return -EINVAL;
-	}
-
-	if (attr->sched_flags & ~(SCHED_FLAG_ALL | SCHED_FLAG_SUGOV))
-		return -EINVAL;
-
-	/*
-	 * Valid priorities for SCHED_FIFO and SCHED_RR are
-	 * 1..MAX_RT_PRIO-1, valid priority for SCHED_NORMAL,
-	 * SCHED_BATCH and SCHED_IDLE is 0.
-	 */
-	if (attr->sched_priority > MAX_RT_PRIO-1)
-		return -EINVAL;
-	if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
-	    (rt_policy(policy) != (attr->sched_priority != 0)))
-		return -EINVAL;
-
-	if (user) {
-		retval = user_check_sched_setscheduler(p, attr, policy, reset_on_fork);
-		if (retval)
-			return retval;
-
-		if (attr->sched_flags & SCHED_FLAG_SUGOV)
-			return -EINVAL;
-
-		retval = security_task_setscheduler(p);
-		if (retval)
-			return retval;
-	}
-
-	/* Update task specific "requested" clamps */
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
-		retval = uclamp_validate(p, attr);
-		if (retval)
-			return retval;
-	}
-
-	/*
-	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
-	 * information.
-	 */
-	if (dl_policy(policy) || dl_policy(p->policy)) {
-		cpuset_locked = true;
-		cpuset_lock();
-	}
-
-	/*
-	 * Make sure no PI-waiters arrive (or leave) while we are
-	 * changing the priority of the task:
-	 *
-	 * To be able to change p->policy safely, the appropriate
-	 * runqueue lock must be held.
-	 */
-	rq = task_rq_lock(p, &rf);
-	update_rq_clock(rq);
-
-	/*
-	 * Changing the policy of the stop threads its a very bad idea:
-	 */
-	if (p == rq->stop) {
-		retval = -EINVAL;
-		goto unlock;
-	}
-
-	/*
-	 * If not changing anything there's no need to proceed further,
-	 * but store a possible modification of reset_on_fork.
-	 */
-	if (unlikely(policy == p->policy)) {
-		if (fair_policy(policy) && attr->sched_nice != task_nice(p))
-			goto change;
-		if (rt_policy(policy) && attr->sched_priority != p->rt_priority)
-			goto change;
-		if (dl_policy(policy) && dl_param_changed(p, attr))
-			goto change;
-		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
-			goto change;
-
-		p->sched_reset_on_fork = reset_on_fork;
-		retval = 0;
-		goto unlock;
-	}
-change:
-
-	if (user) {
-#ifdef CONFIG_RT_GROUP_SCHED
-		/*
-		 * Do not allow realtime tasks into groups that have no runtime
-		 * assigned.
-		 */
-		if (rt_bandwidth_enabled() && rt_policy(policy) &&
-				task_group(p)->rt_bandwidth.rt_runtime == 0 &&
-				!task_group_is_autogroup(task_group(p))) {
-			retval = -EPERM;
-			goto unlock;
-		}
-#endif
-#ifdef CONFIG_SMP
-		if (dl_bandwidth_enabled() && dl_policy(policy) &&
-				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
-			cpumask_t *span = rq->rd->span;
-
-			/*
-			 * Don't allow tasks with an affinity mask smaller than
-			 * the entire root_domain to become SCHED_DEADLINE. We
-			 * will also fail if there's no bandwidth available.
-			 */
-			if (!cpumask_subset(span, p->cpus_ptr) ||
-			    rq->rd->dl_bw.bw == 0) {
-				retval = -EPERM;
-				goto unlock;
-			}
-		}
-#endif
-	}
-
-	/* Re-check policy now with rq lock held: */
-	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
-		policy = oldpolicy = -1;
-		task_rq_unlock(rq, p, &rf);
-		if (cpuset_locked)
-			cpuset_unlock();
-		goto recheck;
-	}
-
-	/*
-	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
-	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
-	 * is available.
-	 */
-	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
-		retval = -EBUSY;
-		goto unlock;
-	}
-
-	p->sched_reset_on_fork = reset_on_fork;
-	oldprio = p->prio;
-
-	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
-	if (pi) {
-		/*
-		 * Take priority boosted tasks into account. If the new
-		 * effective priority is unchanged, we just store the new
-		 * normal parameters and do not touch the scheduler class and
-		 * the runqueue. This will be done when the task deboost
-		 * itself.
-		 */
-		newprio = rt_effective_prio(p, newprio);
-		if (newprio == oldprio)
-			queue_flags &= ~DEQUEUE_MOVE;
-	}
-
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flags);
-	if (running)
-		put_prev_task(rq, p);
-
-	prev_class = p->sched_class;
-
-	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
-		__setscheduler_params(p, attr);
-		__setscheduler_prio(p, newprio);
-	}
-	__setscheduler_uclamp(p, attr);
-
-	if (queued) {
-		/*
-		 * We enqueue to tail when the priority of a task is
-		 * increased (user space view).
-		 */
-		if (oldprio < p->prio)
-			queue_flags |= ENQUEUE_HEAD;
-
-		enqueue_task(rq, p, queue_flags);
-	}
-	if (running)
-		set_next_task(rq, p);
-
-	check_class_changed(rq, p, prev_class, oldprio);
-
-	/* Avoid rq from going away on us: */
-	preempt_disable();
-	head = splice_balance_callbacks(rq);
-	task_rq_unlock(rq, p, &rf);
-
-	if (pi) {
-		if (cpuset_locked)
-			cpuset_unlock();
-		rt_mutex_adjust_pi(p);
-	}
-
-	/* Run balance callbacks after we've adjusted the PI chain: */
-	balance_callbacks(rq, head);
-	preempt_enable();
-
-	return 0;
-
-unlock:
-	task_rq_unlock(rq, p, &rf);
-	if (cpuset_locked)
-		cpuset_unlock();
-	return retval;
-}
-
-static int _sched_setscheduler(struct task_struct *p, int policy,
-			       const struct sched_param *param, bool check)
-{
-	struct sched_attr attr = {
-		.sched_policy   = policy,
-		.sched_priority = param->sched_priority,
-		.sched_nice	= PRIO_TO_NICE(p->static_prio),
-	};
-
-	/* Fixup the legacy SCHED_RESET_ON_FORK hack. */
-	if ((policy != SETPARAM_POLICY) && (policy & SCHED_RESET_ON_FORK)) {
-		attr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
-		policy &= ~SCHED_RESET_ON_FORK;
-		attr.sched_policy = policy;
-	}
-
-	return __sched_setscheduler(p, &attr, check, true);
-}
-/**
- * sched_setscheduler - change the scheduling policy and/or RT priority of a thread.
- * @p: the task in question.
- * @policy: new policy.
- * @param: structure containing the new RT priority.
- *
- * Use sched_set_fifo(), read its comment.
- *
- * Return: 0 on success. An error code otherwise.
- *
- * NOTE that the task may be already dead.
- */
-int sched_setscheduler(struct task_struct *p, int policy,
-		       const struct sched_param *param)
-{
-	return _sched_setscheduler(p, policy, param, true);
-}
-
-int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
-{
-	return __sched_setscheduler(p, attr, true, true);
-}
-
-int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
-{
-	return __sched_setscheduler(p, attr, false, true);
-}
-EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
-
-/**
- * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
- * @p: the task in question.
- * @policy: new policy.
- * @param: structure containing the new RT priority.
- *
- * Just like sched_setscheduler, only don't bother checking if the
- * current context has permission.  For example, this is needed in
- * stop_machine(): we create temporary high priority worker threads,
- * but our caller might not have that capability.
- *
- * Return: 0 on success. An error code otherwise.
- */
-int sched_setscheduler_nocheck(struct task_struct *p, int policy,
-			       const struct sched_param *param)
-{
-	return _sched_setscheduler(p, policy, param, false);
-}
-
-/*
- * SCHED_FIFO is a broken scheduler model; that is, it is fundamentally
- * incapable of resource management, which is the one thing an OS really should
- * be doing.
- *
- * This is of course the reason it is limited to privileged users only.
- *
- * Worse still; it is fundamentally impossible to compose static priority
- * workloads. You cannot take two correctly working static prio workloads
- * and smash them together and still expect them to work.
- *
- * For this reason 'all' FIFO tasks the kernel creates are basically at:
- *
- *   MAX_RT_PRIO / 2
- *
- * The administrator _MUST_ configure the system, the kernel simply doesn't
- * know enough information to make a sensible choice.
- */
-void sched_set_fifo(struct task_struct *p)
-{
-	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 };
-	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
-}
-EXPORT_SYMBOL_GPL(sched_set_fifo);
-
-/*
- * For when you don't much care about FIFO, but want to be above SCHED_NORMAL.
- */
-void sched_set_fifo_low(struct task_struct *p)
-{
-	struct sched_param sp = { .sched_priority = 1 };
-	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
-}
-EXPORT_SYMBOL_GPL(sched_set_fifo_low);
-
-void sched_set_normal(struct task_struct *p, int nice)
-{
-	struct sched_attr attr = {
-		.sched_policy = SCHED_NORMAL,
-		.sched_nice = nice,
-	};
-	WARN_ON_ONCE(sched_setattr_nocheck(p, &attr) != 0);
-}
-EXPORT_SYMBOL_GPL(sched_set_normal);
-
-static int
-do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
-{
-	struct sched_param lparam;
-
-	if (!param || pid < 0)
-		return -EINVAL;
-	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
-		return -EFAULT;
-
-	CLASS(find_get_task, p)(pid);
-	if (!p)
-		return -ESRCH;
-
-	return sched_setscheduler(p, policy, &lparam);
-}
-
-/*
- * Mimics kernel/events/core.c perf_copy_attr().
- */
-static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *attr)
-{
-	u32 size;
-	int ret;
-
-	/* Zero the full structure, so that a short copy will be nice: */
-	memset(attr, 0, sizeof(*attr));
-
-	ret = get_user(size, &uattr->size);
-	if (ret)
-		return ret;
-
-	/* ABI compatibility quirk: */
-	if (!size)
-		size = SCHED_ATTR_SIZE_VER0;
-	if (size < SCHED_ATTR_SIZE_VER0 || size > PAGE_SIZE)
-		goto err_size;
-
-	ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
-	if (ret) {
-		if (ret == -E2BIG)
-			goto err_size;
-		return ret;
-	}
-
-	if ((attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) &&
-	    size < SCHED_ATTR_SIZE_VER1)
-		return -EINVAL;
-
-	/*
-	 * XXX: Do we want to be lenient like existing syscalls; or do we want
-	 * to be strict and return an error on out-of-bounds values?
-	 */
-	attr->sched_nice = clamp(attr->sched_nice, MIN_NICE, MAX_NICE);
-
-	return 0;
-
-err_size:
-	put_user(sizeof(*attr), &uattr->size);
-	return -E2BIG;
-}
-
-static void get_params(struct task_struct *p, struct sched_attr *attr)
-{
-	if (task_has_dl_policy(p))
-		__getparam_dl(p, attr);
-	else if (task_has_rt_policy(p))
-		attr->sched_priority = p->rt_priority;
-	else
-		attr->sched_nice = task_nice(p);
-}
-
-/**
- * sys_sched_setscheduler - set/change the scheduler policy and RT priority
- * @pid: the pid in question.
- * @policy: new policy.
- * @param: structure containing the new RT priority.
- *
- * Return: 0 on success. An error code otherwise.
- */
-SYSCALL_DEFINE3(sched_setscheduler, pid_t, pid, int, policy, struct sched_param __user *, param)
-{
-	if (policy < 0)
-		return -EINVAL;
-
-	return do_sched_setscheduler(pid, policy, param);
-}
-
-/**
- * sys_sched_setparam - set/change the RT priority of a thread
- * @pid: the pid in question.
- * @param: structure containing the new RT priority.
- *
- * Return: 0 on success. An error code otherwise.
- */
-SYSCALL_DEFINE2(sched_setparam, pid_t, pid, struct sched_param __user *, param)
-{
-	return do_sched_setscheduler(pid, SETPARAM_POLICY, param);
-}
-
-/**
- * sys_sched_setattr - same as above, but with extended sched_attr
- * @pid: the pid in question.
- * @uattr: structure containing the extended parameters.
- * @flags: for future extension.
- */
-SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
-			       unsigned int, flags)
-{
-	struct sched_attr attr;
-	int retval;
-
-	if (!uattr || pid < 0 || flags)
-		return -EINVAL;
-
-	retval = sched_copy_attr(uattr, &attr);
-	if (retval)
-		return retval;
-
-	if ((int)attr.sched_policy < 0)
-		return -EINVAL;
-	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
-		attr.sched_policy = SETPARAM_POLICY;
-
-	CLASS(find_get_task, p)(pid);
-	if (!p)
-		return -ESRCH;
-
-	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
-		get_params(p, &attr);
-
-	return sched_setattr(p, &attr);
-}
-
-/**
- * sys_sched_getscheduler - get the policy (scheduling class) of a thread
- * @pid: the pid in question.
- *
- * Return: On success, the policy of the thread. Otherwise, a negative error
- * code.
- */
-SYSCALL_DEFINE1(sched_getscheduler, pid_t, pid)
-{
-	struct task_struct *p;
-	int retval;
-
-	if (pid < 0)
-		return -EINVAL;
-
-	guard(rcu)();
-	p = find_process_by_pid(pid);
-	if (!p)
-		return -ESRCH;
-
-	retval = security_task_getscheduler(p);
-	if (!retval) {
-		retval = p->policy;
-		if (p->sched_reset_on_fork)
-			retval |= SCHED_RESET_ON_FORK;
-	}
-	return retval;
-}
-
-/**
- * sys_sched_getparam - get the RT priority of a thread
- * @pid: the pid in question.
- * @param: structure containing the RT priority.
- *
- * Return: On success, 0 and the RT priority is in @param. Otherwise, an error
- * code.
- */
-SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
-{
-	struct sched_param lp = { .sched_priority = 0 };
-	struct task_struct *p;
-	int retval;
-
-	if (!param || pid < 0)
-		return -EINVAL;
-
-	scoped_guard (rcu) {
-		p = find_process_by_pid(pid);
-		if (!p)
-			return -ESRCH;
-
-		retval = security_task_getscheduler(p);
-		if (retval)
-			return retval;
-
-		if (task_has_rt_policy(p))
-			lp.sched_priority = p->rt_priority;
-	}
-
-	/*
-	 * This one might sleep, we cannot do it with a spinlock held ...
-	 */
-	return copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
-}
-
-/*
- * Copy the kernel size attribute structure (which might be larger
- * than what user-space knows about) to user-space.
- *
- * Note that all cases are valid: user-space buffer can be larger or
- * smaller than the kernel-space buffer. The usual case is that both
- * have the same size.
- */
-static int
-sched_attr_copy_to_user(struct sched_attr __user *uattr,
-			struct sched_attr *kattr,
-			unsigned int usize)
-{
-	unsigned int ksize = sizeof(*kattr);
-
-	if (!access_ok(uattr, usize))
-		return -EFAULT;
-
-	/*
-	 * sched_getattr() ABI forwards and backwards compatibility:
-	 *
-	 * If usize == ksize then we just copy everything to user-space and all is good.
-	 *
-	 * If usize < ksize then we only copy as much as user-space has space for,
-	 * this keeps ABI compatibility as well. We skip the rest.
-	 *
-	 * If usize > ksize then user-space is using a newer version of the ABI,
-	 * which part the kernel doesn't know about. Just ignore it - tooling can
-	 * detect the kernel's knowledge of attributes from the attr->size value
-	 * which is set to ksize in this case.
-	 */
-	kattr->size = min(usize, ksize);
-
-	if (copy_to_user(uattr, kattr, kattr->size))
-		return -EFAULT;
-
-	return 0;
-}
-
-/**
- * sys_sched_getattr - similar to sched_getparam, but with sched_attr
- * @pid: the pid in question.
- * @uattr: structure containing the extended parameters.
- * @usize: sizeof(attr) for fwd/bwd comp.
- * @flags: for future extension.
- */
-SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
-		unsigned int, usize, unsigned int, flags)
-{
-	struct sched_attr kattr = { };
-	struct task_struct *p;
-	int retval;
-
-	if (!uattr || pid < 0 || usize > PAGE_SIZE ||
-	    usize < SCHED_ATTR_SIZE_VER0 || flags)
-		return -EINVAL;
-
-	scoped_guard (rcu) {
-		p = find_process_by_pid(pid);
-		if (!p)
-			return -ESRCH;
-
-		retval = security_task_getscheduler(p);
-		if (retval)
-			return retval;
-
-		kattr.sched_policy = p->policy;
-		if (p->sched_reset_on_fork)
-			kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
-		get_params(p, &kattr);
-		kattr.sched_flags &= SCHED_FLAG_ALL;
-
-#ifdef CONFIG_UCLAMP_TASK
-		/*
-		 * This could race with another potential updater, but this is fine
-		 * because it'll correctly read the old or the new value. We don't need
-		 * to guarantee who wins the race as long as it doesn't return garbage.
-		 */
-		kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
-		kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
-#endif
-	}
-
-	return sched_attr_copy_to_user(uattr, &kattr, usize);
-}
-
-#ifdef CONFIG_SMP
-int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
-{
-	/*
-	 * If the task isn't a deadline task or admission control is
-	 * disabled then we don't care about affinity changes.
-	 */
-	if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
-		return 0;
-
-	/*
-	 * Since bandwidth control happens on root_domain basis,
-	 * if admission test is enabled, we only admit -deadline
-	 * tasks allowed to run on all the CPUs in the task's
-	 * root_domain.
-	 */
-	guard(rcu)();
-	if (!cpumask_subset(task_rq(p)->rd->span, mask))
-		return -EBUSY;
-
-	return 0;
-}
-#endif
-
-static int
-__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
-{
-	int retval;
-	cpumask_var_t cpus_allowed, new_mask;
-
-	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
-		return -ENOMEM;
-
-	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
-		retval = -ENOMEM;
-		goto out_free_cpus_allowed;
-	}
-
-	cpuset_cpus_allowed(p, cpus_allowed);
-	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
-
-	ctx->new_mask = new_mask;
-	ctx->flags |= SCA_CHECK;
-
-	retval = dl_task_check_affinity(p, new_mask);
-	if (retval)
-		goto out_free_new_mask;
-
-	retval = __set_cpus_allowed_ptr(p, ctx);
-	if (retval)
-		goto out_free_new_mask;
-
-	cpuset_cpus_allowed(p, cpus_allowed);
-	if (!cpumask_subset(new_mask, cpus_allowed)) {
-		/*
-		 * We must have raced with a concurrent cpuset update.
-		 * Just reset the cpumask to the cpuset's cpus_allowed.
-		 */
-		cpumask_copy(new_mask, cpus_allowed);
-
-		/*
-		 * If SCA_USER is set, a 2nd call to __set_cpus_allowed_ptr()
-		 * will restore the previous user_cpus_ptr value.
-		 *
-		 * In the unlikely event a previous user_cpus_ptr exists,
-		 * we need to further restrict the mask to what is allowed
-		 * by that old user_cpus_ptr.
-		 */
-		if (unlikely((ctx->flags & SCA_USER) && ctx->user_mask)) {
-			bool empty = !cpumask_and(new_mask, new_mask,
-						  ctx->user_mask);
-
-			if (WARN_ON_ONCE(empty))
-				cpumask_copy(new_mask, cpus_allowed);
-		}
-		__set_cpus_allowed_ptr(p, ctx);
-		retval = -EINVAL;
-	}
-
-out_free_new_mask:
-	free_cpumask_var(new_mask);
-out_free_cpus_allowed:
-	free_cpumask_var(cpus_allowed);
-	return retval;
-}
-
-long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
-{
-	struct affinity_context ac;
-	struct cpumask *user_mask;
-	int retval;
-
-	CLASS(find_get_task, p)(pid);
-	if (!p)
-		return -ESRCH;
-
-	if (p->flags & PF_NO_SETAFFINITY)
-		return -EINVAL;
-
-	if (!check_same_owner(p)) {
-		guard(rcu)();
-		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE))
-			return -EPERM;
-	}
-
-	retval = security_task_setscheduler(p);
-	if (retval)
-		return retval;
-
-	/*
-	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
-	 * alloc_user_cpus_ptr() returns NULL.
-	 */
-	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
-	if (user_mask) {
-		cpumask_copy(user_mask, in_mask);
-	} else if (IS_ENABLED(CONFIG_SMP)) {
-		return -ENOMEM;
-	}
-
-	ac = (struct affinity_context){
-		.new_mask  = in_mask,
-		.user_mask = user_mask,
-		.flags     = SCA_USER,
-	};
-
-	retval = __sched_setaffinity(p, &ac);
-	kfree(ac.user_mask);
-
-	return retval;
-}
-
-static int get_user_cpu_mask(unsigned long __user *user_mask_ptr, unsigned len,
-			     struct cpumask *new_mask)
-{
-	if (len < cpumask_size())
-		cpumask_clear(new_mask);
-	else if (len > cpumask_size())
-		len = cpumask_size();
-
-	return copy_from_user(new_mask, user_mask_ptr, len) ? -EFAULT : 0;
-}
-
-/**
- * sys_sched_setaffinity - set the CPU affinity of a process
- * @pid: pid of the process
- * @len: length in bytes of the bitmask pointed to by user_mask_ptr
- * @user_mask_ptr: user-space pointer to the new CPU mask
- *
- * Return: 0 on success. An error code otherwise.
- */
-SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
-		unsigned long __user *, user_mask_ptr)
-{
-	cpumask_var_t new_mask;
-	int retval;
-
-	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	retval = get_user_cpu_mask(user_mask_ptr, len, new_mask);
-	if (retval == 0)
-		retval = sched_setaffinity(pid, new_mask);
-	free_cpumask_var(new_mask);
-	return retval;
-}
-
-long sched_getaffinity(pid_t pid, struct cpumask *mask)
-{
-	struct task_struct *p;
-	int retval;
-
-	guard(rcu)();
-	p = find_process_by_pid(pid);
-	if (!p)
-		return -ESRCH;
-
-	retval = security_task_getscheduler(p);
-	if (retval)
-		return retval;
-
-	guard(raw_spinlock_irqsave)(&p->pi_lock);
-	cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
-
-	return 0;
-}
-
-/**
- * sys_sched_getaffinity - get the CPU affinity of a process
- * @pid: pid of the process
- * @len: length in bytes of the bitmask pointed to by user_mask_ptr
- * @user_mask_ptr: user-space pointer to hold the current CPU mask
- *
- * Return: size of CPU mask copied to user_mask_ptr on success. An
- * error code otherwise.
- */
-SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
-		unsigned long __user *, user_mask_ptr)
-{
-	int ret;
-	cpumask_var_t mask;
-
-	if ((len * BITS_PER_BYTE) < nr_cpu_ids)
-		return -EINVAL;
-	if (len & (sizeof(unsigned long)-1))
-		return -EINVAL;
-
-	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	ret = sched_getaffinity(pid, mask);
-	if (ret == 0) {
-		unsigned int retlen = min(len, cpumask_size());
-
-		if (copy_to_user(user_mask_ptr, cpumask_bits(mask), retlen))
-			ret = -EFAULT;
-		else
-			ret = retlen;
-	}
-	free_cpumask_var(mask);
-
-	return ret;
-}
-
-static void do_sched_yield(void)
-{
-	struct rq_flags rf;
-	struct rq *rq;
-
-	rq = this_rq_lock_irq(&rf);
-
-	schedstat_inc(rq->yld_count);
-	current->sched_class->yield_task(rq);
-
-	preempt_disable();
-	rq_unlock_irq(rq, &rf);
-	sched_preempt_enable_no_resched();
-
-	schedule();
-}
-
-/**
- * sys_sched_yield - yield the current processor to other threads.
- *
- * This function yields the current CPU to other tasks. If there are no
- * other threads running on this CPU then this function will return.
- *
- * Return: 0.
- */
-SYSCALL_DEFINE0(sched_yield)
-{
-	do_sched_yield();
-	return 0;
-}
-
-#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
-int __sched __cond_resched(void)
-{
-	if (should_resched(0)) {
-		preempt_schedule_common();
-		return 1;
-	}
-	/*
-	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
-	 * whether the current CPU is in an RCU read-side critical section,
-	 * so the tick can report quiescent states even for CPUs looping
-	 * in kernel context.  In contrast, in non-preemptible kernels,
-	 * RCU readers leave no in-memory hints, which means that CPU-bound
-	 * processes executing in kernel context might never report an
-	 * RCU quiescent state.  Therefore, the following code causes
-	 * cond_resched() to report a quiescent state, but only when RCU
-	 * is in urgent need of one.
-	 */
-#ifndef CONFIG_PREEMPT_RCU
-	rcu_all_qs();
-#endif
-	return 0;
-}
-EXPORT_SYMBOL(__cond_resched);
-#endif
-
-#ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-#define cond_resched_dynamic_enabled	__cond_resched
-#define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
-DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(cond_resched);
-
-#define might_resched_dynamic_enabled	__cond_resched
-#define might_resched_dynamic_disabled	((void *)&__static_call_return0)
-DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(might_resched);
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
-int __sched dynamic_cond_resched(void)
-{
-	klp_sched_try_switch();
-	if (!static_branch_unlikely(&sk_dynamic_cond_resched))
-		return 0;
-	return __cond_resched();
-}
-EXPORT_SYMBOL(dynamic_cond_resched);
-
-static DEFINE_STATIC_KEY_FALSE(sk_dynamic_might_resched);
-int __sched dynamic_might_resched(void)
-{
-	if (!static_branch_unlikely(&sk_dynamic_might_resched))
-		return 0;
-	return __cond_resched();
-}
-EXPORT_SYMBOL(dynamic_might_resched);
-#endif
-#endif
-
-/*
- * __cond_resched_lock() - if a reschedule is pending, drop the given lock,
- * call schedule, and on return reacquire the lock.
- *
- * This works OK both with and without CONFIG_PREEMPTION. We do strange low-level
- * operations here to prevent schedule() from being called twice (once via
- * spin_unlock(), once by hand).
- */
-int __cond_resched_lock(spinlock_t *lock)
-{
-	int resched = should_resched(PREEMPT_LOCK_OFFSET);
-	int ret = 0;
-
-	lockdep_assert_held(lock);
-
-	if (spin_needbreak(lock) || resched) {
-		spin_unlock(lock);
-		if (!_cond_resched())
-			cpu_relax();
-		ret = 1;
-		spin_lock(lock);
-	}
-	return ret;
-}
-EXPORT_SYMBOL(__cond_resched_lock);
-
-int __cond_resched_rwlock_read(rwlock_t *lock)
-{
-	int resched = should_resched(PREEMPT_LOCK_OFFSET);
-	int ret = 0;
-
-	lockdep_assert_held_read(lock);
-
-	if (rwlock_needbreak(lock) || resched) {
-		read_unlock(lock);
-		if (!_cond_resched())
-			cpu_relax();
-		ret = 1;
-		read_lock(lock);
-	}
-	return ret;
-}
-EXPORT_SYMBOL(__cond_resched_rwlock_read);
-
-int __cond_resched_rwlock_write(rwlock_t *lock)
-{
-	int resched = should_resched(PREEMPT_LOCK_OFFSET);
-	int ret = 0;
-
-	lockdep_assert_held_write(lock);
+	lockdep_assert_held_write(lock);
 
 	if (rwlock_needbreak(lock) || resched) {
 		write_unlock(lock);
@@ -8911,100 +7362,6 @@ static inline void preempt_dynamic_init(void) { }
 
 #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
 
-/**
- * yield - yield the current processor to other threads.
- *
- * Do not ever use this function, there's a 99% chance you're doing it wrong.
- *
- * The scheduler is at all times free to pick the calling task as the most
- * eligible task to run, if removing the yield() call from your code breaks
- * it, it's already broken.
- *
- * Typical broken usage is:
- *
- * while (!event)
- *	yield();
- *
- * where one assumes that yield() will let 'the other' process run that will
- * make event true. If the current task is a SCHED_FIFO task that will never
- * happen. Never use yield() as a progress guarantee!!
- *
- * If you want to use yield() to wait for something, use wait_event().
- * If you want to use yield() to be 'nice' for others, use cond_resched().
- * If you still want to use yield(), do not!
- */
-void __sched yield(void)
-{
-	set_current_state(TASK_RUNNING);
-	do_sched_yield();
-}
-EXPORT_SYMBOL(yield);
-
-/**
- * yield_to - yield the current processor to another thread in
- * your thread group, or accelerate that thread toward the
- * processor it's on.
- * @p: target task
- * @preempt: whether task preemption is allowed or not
- *
- * It's the caller's job to ensure that the target task struct
- * can't go away on us before we can do any checks.
- *
- * Return:
- *	true (>0) if we indeed boosted the target task.
- *	false (0) if we failed to boost the target.
- *	-ESRCH if there's no task to yield to.
- */
-int __sched yield_to(struct task_struct *p, bool preempt)
-{
-	struct task_struct *curr = current;
-	struct rq *rq, *p_rq;
-	int yielded = 0;
-
-	scoped_guard (irqsave) {
-		rq = this_rq();
-
-again:
-		p_rq = task_rq(p);
-		/*
-		 * If we're the only runnable task on the rq and target rq also
-		 * has only one task, there's absolutely no point in yielding.
-		 */
-		if (rq->nr_running == 1 && p_rq->nr_running == 1)
-			return -ESRCH;
-
-		guard(double_rq_lock)(rq, p_rq);
-		if (task_rq(p) != p_rq)
-			goto again;
-
-		if (!curr->sched_class->yield_to_task)
-			return 0;
-
-		if (curr->sched_class != p->sched_class)
-			return 0;
-
-		if (task_on_cpu(p_rq, p) || !task_is_running(p))
-			return 0;
-
-		yielded = curr->sched_class->yield_to_task(rq, p);
-		if (yielded) {
-			schedstat_inc(rq->yld_count);
-			/*
-			 * Make p's CPU reschedule; pick_next_entity
-			 * takes care of fairness.
-			 */
-			if (preempt && rq != p_rq)
-				resched_curr(p_rq);
-		}
-	}
-
-	if (yielded)
-		schedule();
-
-	return yielded;
-}
-EXPORT_SYMBOL_GPL(yield_to);
-
 int io_schedule_prepare(void)
 {
 	int old_iowait = current->in_iowait;
@@ -9046,123 +7403,6 @@ void __sched io_schedule(void)
 }
 EXPORT_SYMBOL(io_schedule);
 
-/**
- * sys_sched_get_priority_max - return maximum RT priority.
- * @policy: scheduling class.
- *
- * Return: On success, this syscall returns the maximum
- * rt_priority that can be used by a given scheduling class.
- * On failure, a negative error code is returned.
- */
-SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
-{
-	int ret = -EINVAL;
-
-	switch (policy) {
-	case SCHED_FIFO:
-	case SCHED_RR:
-		ret = MAX_RT_PRIO-1;
-		break;
-	case SCHED_DEADLINE:
-	case SCHED_NORMAL:
-	case SCHED_BATCH:
-	case SCHED_IDLE:
-		ret = 0;
-		break;
-	}
-	return ret;
-}
-
-/**
- * sys_sched_get_priority_min - return minimum RT priority.
- * @policy: scheduling class.
- *
- * Return: On success, this syscall returns the minimum
- * rt_priority that can be used by a given scheduling class.
- * On failure, a negative error code is returned.
- */
-SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
-{
-	int ret = -EINVAL;
-
-	switch (policy) {
-	case SCHED_FIFO:
-	case SCHED_RR:
-		ret = 1;
-		break;
-	case SCHED_DEADLINE:
-	case SCHED_NORMAL:
-	case SCHED_BATCH:
-	case SCHED_IDLE:
-		ret = 0;
-	}
-	return ret;
-}
-
-static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
-{
-	unsigned int time_slice = 0;
-	int retval;
-
-	if (pid < 0)
-		return -EINVAL;
-
-	scoped_guard (rcu) {
-		struct task_struct *p = find_process_by_pid(pid);
-		if (!p)
-			return -ESRCH;
-
-		retval = security_task_getscheduler(p);
-		if (retval)
-			return retval;
-
-		scoped_guard (task_rq_lock, p) {
-			struct rq *rq = scope.rq;
-			if (p->sched_class->get_rr_interval)
-				time_slice = p->sched_class->get_rr_interval(rq, p);
-		}
-	}
-
-	jiffies_to_timespec64(time_slice, t);
-	return 0;
-}
-
-/**
- * sys_sched_rr_get_interval - return the default timeslice of a process.
- * @pid: pid of the process.
- * @interval: userspace pointer to the timeslice value.
- *
- * this syscall writes the default timeslice value of a given process
- * into the user-space timespec buffer. A value of '0' means infinity.
- *
- * Return: On success, 0 and the timeslice is in @interval. Otherwise,
- * an error code.
- */
-SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
-		struct __kernel_timespec __user *, interval)
-{
-	struct timespec64 t;
-	int retval = sched_rr_get_interval(pid, &t);
-
-	if (retval == 0)
-		retval = put_timespec64(&t, interval);
-
-	return retval;
-}
-
-#ifdef CONFIG_COMPAT_32BIT_TIME
-SYSCALL_DEFINE2(sched_rr_get_interval_time32, pid_t, pid,
-		struct old_timespec32 __user *, interval)
-{
-	struct timespec64 t;
-	int retval = sched_rr_get_interval(pid, &t);
-
-	if (retval == 0)
-		retval = put_old_timespec32(&t, interval);
-	return retval;
-}
-#endif
-
 void sched_show_task(struct task_struct *p)
 {
 	unsigned long free = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7c39dbf31f75..18b4c8147364 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2418,8 +2418,19 @@ extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void sched_balance_trigger(struct rq *rq);
 
+extern int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx);
 extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
 
+static inline cpumask_t *alloc_user_cpus_ptr(int node)
+{
+	/*
+	 * See do_set_cpus_allowed() above for the rcu_head usage.
+	 */
+	int size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
+
+	return kmalloc_node(size, GFP_KERNEL, node);
+}
+
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
 	struct task_struct *p = rq->curr;
@@ -2441,7 +2452,20 @@ static inline struct task_struct *get_push_task(struct rq *rq)
 
 extern int push_cpu_stop(void *arg);
 
-#endif
+#else /* !CONFIG_SMP: */
+
+static inline int __set_cpus_allowed_ptr(struct task_struct *p,
+					 struct affinity_context *ctx)
+{
+	return set_cpus_allowed_ptr(p, ctx->new_mask);
+}
+
+static inline cpumask_t *alloc_user_cpus_ptr(int node)
+{
+	return NULL;
+}
+
+#endif /* !CONFIG_SMP */
 
 #ifdef CONFIG_CPU_IDLE
 static inline void idle_set_state(struct rq *rq,
@@ -3113,6 +3137,36 @@ static inline bool uclamp_is_used(void)
 {
 	return static_branch_likely(&sched_uclamp_used);
 }
+
+#define for_each_clamp_id(clamp_id) \
+	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
+
+extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
+
+
+static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
+{
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+	return SCHED_CAPACITY_SCALE;
+}
+
+/* Integer rounded range for each bucket */
+#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
+
+static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
+{
+	return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
+}
+
+static inline void uclamp_se_set(struct uclamp_se *uc_se,
+				 unsigned int value, bool user_defined)
+{
+	uc_se->value = value;
+	uc_se->bucket_id = uclamp_bucket_id(value);
+	uc_se->user_defined = user_defined;
+}
+
 #else /* CONFIG_UCLAMP_TASK */
 static inline unsigned long uclamp_eff_value(struct task_struct *p,
 					     enum uclamp_id clamp_id)
@@ -3148,6 +3202,7 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 {
 	return false;
 }
+
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
@@ -3490,4 +3545,53 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
+#ifdef CONFIG_RT_MUTEXES
+static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
+{
+	if (pi_task)
+		prio = min(prio, pi_task->prio);
+
+	return prio;
+}
+
+static inline int rt_effective_prio(struct task_struct *p, int prio)
+{
+	struct task_struct *pi_task = rt_mutex_get_top_task(p);
+
+	return __rt_effective_prio(pi_task, prio);
+}
+#else
+static inline int rt_effective_prio(struct task_struct *p, int prio)
+{
+	return prio;
+}
+#endif
+
+extern int __sched_setscheduler(struct task_struct *p, const struct sched_attr *attr, bool user, bool pi);
+extern int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
+extern void __setscheduler_prio(struct task_struct *p, int prio);
+extern void set_load_weight(struct task_struct *p, bool update_load);
+extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
+extern void dequeue_task(struct rq *rq, struct task_struct *p, int flags);
+
+extern void check_class_changed(struct rq *rq, struct task_struct *p,
+				const struct sched_class *prev_class,
+				int oldprio);
+
+#ifdef CONFIG_SMP
+extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
+extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
+#else
+
+static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
+{
+	return NULL;
+}
+
+static inline void balance_callbacks(struct rq *rq, struct balance_callback *head)
+{
+}
+
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
new file mode 100644
index 000000000000..7b37a7bfbb16
--- /dev/null
+++ b/kernel/sched/syscalls.c
@@ -0,0 +1,1691 @@
+#include <linux/sched.h>
+#include <linux/cpuset.h>
+#include <linux/sched/debug.h>
+
+#include <uapi/linux/sched/types.h>
+
+#include "sched.h"
+#include "autogroup.h"
+
+static inline int __normal_prio(int policy, int rt_prio, int nice)
+{
+	int prio;
+
+	if (dl_policy(policy))
+		prio = MAX_DL_PRIO - 1;
+	else if (rt_policy(policy))
+		prio = MAX_RT_PRIO - 1 - rt_prio;
+	else
+		prio = NICE_TO_PRIO(nice);
+
+	return prio;
+}
+
+/*
+ * Calculate the expected normal priority: i.e. priority
+ * without taking RT-inheritance into account. Might be
+ * boosted by interactivity modifiers. Changes upon fork,
+ * setprio syscalls, and whenever the interactivity
+ * estimator recalculates.
+ */
+static inline int normal_prio(struct task_struct *p)
+{
+	return __normal_prio(p->policy, p->rt_priority, PRIO_TO_NICE(p->static_prio));
+}
+
+/*
+ * Calculate the current priority, i.e. the priority
+ * taken into account by the scheduler. This value might
+ * be boosted by RT tasks, or might be boosted by
+ * interactivity modifiers. Will be RT if the task got
+ * RT-boosted. If not then it returns p->normal_prio.
+ */
+static int effective_prio(struct task_struct *p)
+{
+	p->normal_prio = normal_prio(p);
+	/*
+	 * If we are RT tasks or we were boosted to RT priority,
+	 * keep the priority unchanged. Otherwise, update priority
+	 * to the normal priority:
+	 */
+	if (!rt_prio(p->prio))
+		return p->normal_prio;
+	return p->prio;
+}
+
+void set_user_nice(struct task_struct *p, long nice)
+{
+	bool queued, running;
+	struct rq *rq;
+	int old_prio;
+
+	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
+		return;
+	/*
+	 * We have to be careful, if called from sys_setpriority(),
+	 * the task might be in the middle of scheduling on another CPU.
+	 */
+	CLASS(task_rq_lock, rq_guard)(p);
+	rq = rq_guard.rq;
+
+	update_rq_clock(rq);
+
+	/*
+	 * The RT priorities are set via sched_setscheduler(), but we still
+	 * allow the 'normal' nice value to be set - but as expected
+	 * it won't have any effect on scheduling until the task is
+	 * SCHED_DEADLINE, SCHED_FIFO or SCHED_RR:
+	 */
+	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
+		p->static_prio = NICE_TO_PRIO(nice);
+		return;
+	}
+
+	queued = task_on_rq_queued(p);
+	running = task_current(rq, p);
+	if (queued)
+		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
+	if (running)
+		put_prev_task(rq, p);
+
+	p->static_prio = NICE_TO_PRIO(nice);
+	set_load_weight(p, true);
+	old_prio = p->prio;
+	p->prio = effective_prio(p);
+
+	if (queued)
+		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
+	if (running)
+		set_next_task(rq, p);
+
+	/*
+	 * If the task increased its priority or is running and
+	 * lowered its priority, then reschedule its CPU:
+	 */
+	p->sched_class->prio_changed(rq, p, old_prio);
+}
+EXPORT_SYMBOL(set_user_nice);
+
+/*
+ * is_nice_reduction - check if nice value is an actual reduction
+ *
+ * Similar to can_nice() but does not perform a capability check.
+ *
+ * @p: task
+ * @nice: nice value
+ */
+static bool is_nice_reduction(const struct task_struct *p, const int nice)
+{
+	/* Convert nice value [19,-20] to rlimit style value [1,40]: */
+	int nice_rlim = nice_to_rlimit(nice);
+
+	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE));
+}
+
+/*
+ * can_nice - check if a task can reduce its nice value
+ * @p: task
+ * @nice: nice value
+ */
+int can_nice(const struct task_struct *p, const int nice)
+{
+	return is_nice_reduction(p, nice) || capable(CAP_SYS_NICE);
+}
+
+#ifdef __ARCH_WANT_SYS_NICE
+
+/*
+ * sys_nice - change the priority of the current process.
+ * @increment: priority increment
+ *
+ * sys_setpriority is a more generic, but much slower function that
+ * does similar things.
+ */
+SYSCALL_DEFINE1(nice, int, increment)
+{
+	long nice, retval;
+
+	/*
+	 * Setpriority might change our priority at the same moment.
+	 * We don't have to worry. Conceptually one call occurs first
+	 * and we have a single winner.
+	 */
+	increment = clamp(increment, -NICE_WIDTH, NICE_WIDTH);
+	nice = task_nice(current) + increment;
+
+	nice = clamp_val(nice, MIN_NICE, MAX_NICE);
+	if (increment < 0 && !can_nice(current, nice))
+		return -EPERM;
+
+	retval = security_task_setnice(current, nice);
+	if (retval)
+		return retval;
+
+	set_user_nice(current, nice);
+	return 0;
+}
+
+#endif
+
+/**
+ * task_prio - return the priority value of a given task.
+ * @p: the task in question.
+ *
+ * Return: The priority value as seen by users in /proc.
+ *
+ * sched policy         return value   kernel prio    user prio/nice
+ *
+ * normal, batch, idle     [0 ... 39]  [100 ... 139]          0/[-20 ... 19]
+ * fifo, rr             [-2 ... -100]     [98 ... 0]  [1 ... 99]
+ * deadline                     -101             -1           0
+ */
+int task_prio(const struct task_struct *p)
+{
+	return p->prio - MAX_RT_PRIO;
+}
+
+/**
+ * idle_cpu - is a given CPU idle currently?
+ * @cpu: the processor in question.
+ *
+ * Return: 1 if the CPU is currently idle. 0 otherwise.
+ */
+int idle_cpu(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (rq->curr != rq->idle)
+		return 0;
+
+	if (rq->nr_running)
+		return 0;
+
+#ifdef CONFIG_SMP
+	if (rq->ttwu_pending)
+		return 0;
+#endif
+
+	return 1;
+}
+
+/**
+ * available_idle_cpu - is a given CPU idle for enqueuing work.
+ * @cpu: the CPU in question.
+ *
+ * Return: 1 if the CPU is currently idle. 0 otherwise.
+ */
+int available_idle_cpu(int cpu)
+{
+	if (!idle_cpu(cpu))
+		return 0;
+
+	if (vcpu_is_preempted(cpu))
+		return 0;
+
+	return 1;
+}
+
+/**
+ * idle_task - return the idle task for a given CPU.
+ * @cpu: the processor in question.
+ *
+ * Return: The idle task for the CPU @cpu.
+ */
+struct task_struct *idle_task(int cpu)
+{
+	return cpu_rq(cpu)->idle;
+}
+
+#ifdef CONFIG_SCHED_CORE
+int sched_core_idle_cpu(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (sched_core_enabled(rq) && rq->curr == rq->idle)
+		return 1;
+
+	return idle_cpu(cpu);
+}
+
+#endif
+
+#ifdef CONFIG_SMP
+/*
+ * This function computes an effective utilization for the given CPU, to be
+ * used for frequency selection given the linear relation: f = u * f_max.
+ *
+ * The scheduler tracks the following metrics:
+ *
+ *   cpu_util_{cfs,rt,dl,irq}()
+ *   cpu_bw_dl()
+ *
+ * Where the cfs,rt and dl util numbers are tracked with the same metric and
+ * synchronized windows and are thus directly comparable.
+ *
+ * The cfs,rt,dl utilization are the running times measured with rq->clock_task
+ * which excludes things like IRQ and steal-time. These latter are then accrued
+ * in the irq utilization.
+ *
+ * The DL bandwidth number otoh is not a measured metric but a value computed
+ * based on the task model parameters and gives the minimal utilization
+ * required to meet deadlines.
+ */
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long *min,
+				 unsigned long *max)
+{
+	unsigned long util, irq, scale;
+	struct rq *rq = cpu_rq(cpu);
+
+	scale = arch_scale_cpu_capacity(cpu);
+
+	/*
+	 * Early check to see if IRQ/steal time saturates the CPU, can be
+	 * because of inaccuracies in how we track these -- see
+	 * update_irq_load_avg().
+	 */
+	irq = cpu_util_irq(rq);
+	if (unlikely(irq >= scale)) {
+		if (min)
+			*min = scale;
+		if (max)
+			*max = scale;
+		return scale;
+	}
+
+	if (min) {
+		/*
+		 * The minimum utilization returns the highest level between:
+		 * - the computed DL bandwidth needed with the IRQ pressure which
+		 *   steals time to the deadline task.
+		 * - The minimum performance requirement for CFS and/or RT.
+		 */
+		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
+
+		/*
+		 * When an RT task is runnable and uclamp is not used, we must
+		 * ensure that the task will run at maximum compute capacity.
+		 */
+		if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
+			*min = max(*min, scale);
+	}
+
+	/*
+	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
+	 * CFS tasks and we use the same metric to track the effective
+	 * utilization (PELT windows are synchronized) we can directly add them
+	 * to obtain the CPU's actual utilization.
+	 */
+	util = util_cfs + cpu_util_rt(rq);
+	util += cpu_util_dl(rq);
+
+	/*
+	 * The maximum hint is a soft bandwidth requirement, which can be lower
+	 * than the actual utilization because of uclamp_max requirements.
+	 */
+	if (max)
+		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
+
+	if (util >= scale)
+		return scale;
+
+	/*
+	 * There is still idle time; further improve the number by using the
+	 * irq metric. Because IRQ/steal time is hidden from the task clock we
+	 * need to scale the task numbers:
+	 *
+	 *              max - irq
+	 *   U' = irq + --------- * U
+	 *                 max
+	 */
+	util = scale_irq_capacity(util, irq, scale);
+	util += irq;
+
+	return min(scale, util);
+}
+
+unsigned long sched_cpu_util(int cpu)
+{
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
+}
+#endif /* CONFIG_SMP */
+
+/**
+ * find_process_by_pid - find a process with a matching PID value.
+ * @pid: the pid in question.
+ *
+ * The task of @pid, if found. %NULL otherwise.
+ */
+static struct task_struct *find_process_by_pid(pid_t pid)
+{
+	return pid ? find_task_by_vpid(pid) : current;
+}
+
+static struct task_struct *find_get_task(pid_t pid)
+{
+	struct task_struct *p;
+	guard(rcu)();
+
+	p = find_process_by_pid(pid);
+	if (likely(p))
+		get_task_struct(p);
+
+	return p;
+}
+
+DEFINE_CLASS(find_get_task, struct task_struct *, if (_T) put_task_struct(_T),
+	     find_get_task(pid), pid_t pid)
+
+/*
+ * sched_setparam() passes in -1 for its policy, to let the functions
+ * it calls know not to change it.
+ */
+#define SETPARAM_POLICY	-1
+
+static void __setscheduler_params(struct task_struct *p,
+		const struct sched_attr *attr)
+{
+	int policy = attr->sched_policy;
+
+	if (policy == SETPARAM_POLICY)
+		policy = p->policy;
+
+	p->policy = policy;
+
+	if (dl_policy(policy))
+		__setparam_dl(p, attr);
+	else if (fair_policy(policy))
+		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
+
+	/*
+	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
+	 * !rt_policy. Always setting this ensures that things like
+	 * getparam()/getattr() don't report silly values for !rt tasks.
+	 */
+	p->rt_priority = attr->sched_priority;
+	p->normal_prio = normal_prio(p);
+	set_load_weight(p, true);
+}
+
+/*
+ * Check the target process has a UID that matches the current process's:
+ */
+static bool check_same_owner(struct task_struct *p)
+{
+	const struct cred *cred = current_cred(), *pcred;
+	guard(rcu)();
+
+	pcred = __task_cred(p);
+	return (uid_eq(cred->euid, pcred->euid) ||
+		uid_eq(cred->euid, pcred->uid));
+}
+
+#ifdef CONFIG_UCLAMP_TASK
+
+static int uclamp_validate(struct task_struct *p,
+			   const struct sched_attr *attr)
+{
+	int util_min = p->uclamp_req[UCLAMP_MIN].value;
+	int util_max = p->uclamp_req[UCLAMP_MAX].value;
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		util_min = attr->sched_util_min;
+
+		if (util_min + 1 > SCHED_CAPACITY_SCALE + 1)
+			return -EINVAL;
+	}
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		util_max = attr->sched_util_max;
+
+		if (util_max + 1 > SCHED_CAPACITY_SCALE + 1)
+			return -EINVAL;
+	}
+
+	if (util_min != -1 && util_max != -1 && util_min > util_max)
+		return -EINVAL;
+
+	/*
+	 * We have valid uclamp attributes; make sure uclamp is enabled.
+	 *
+	 * We need to do that here, because enabling static branches is a
+	 * blocking operation which obviously cannot be done while holding
+	 * scheduler locks.
+	 */
+	static_branch_enable(&sched_uclamp_used);
+
+	return 0;
+}
+
+static bool uclamp_reset(const struct sched_attr *attr,
+			 enum uclamp_id clamp_id,
+			 struct uclamp_se *uc_se)
+{
+	/* Reset on sched class change for a non user-defined clamp value. */
+	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) &&
+	    !uc_se->user_defined)
+		return true;
+
+	/* Reset on sched_util_{min,max} == -1. */
+	if (clamp_id == UCLAMP_MIN &&
+	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
+	    attr->sched_util_min == -1) {
+		return true;
+	}
+
+	if (clamp_id == UCLAMP_MAX &&
+	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
+	    attr->sched_util_max == -1) {
+		return true;
+	}
+
+	return false;
+}
+
+static void __setscheduler_uclamp(struct task_struct *p,
+				  const struct sched_attr *attr)
+{
+	enum uclamp_id clamp_id;
+
+	for_each_clamp_id(clamp_id) {
+		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
+		unsigned int value;
+
+		if (!uclamp_reset(attr, clamp_id, uc_se))
+			continue;
+
+		/*
+		 * RT by default have a 100% boost value that could be modified
+		 * at runtime.
+		 */
+		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
+			value = sysctl_sched_uclamp_util_min_rt_default;
+		else
+			value = uclamp_none(clamp_id);
+
+		uclamp_se_set(uc_se, value, false);
+
+	}
+
+	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
+		return;
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
+	    attr->sched_util_min != -1) {
+		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
+			      attr->sched_util_min, true);
+	}
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
+	    attr->sched_util_max != -1) {
+		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
+			      attr->sched_util_max, true);
+	}
+}
+
+#else /* !CONFIG_UCLAMP_TASK: */
+
+static inline int uclamp_validate(struct task_struct *p,
+				  const struct sched_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+static void __setscheduler_uclamp(struct task_struct *p,
+				  const struct sched_attr *attr) { }
+#endif
+
+/*
+ * Allow unprivileged RT tasks to decrease priority.
+ * Only issue a capable test if needed and only once to avoid an audit
+ * event on permitted non-privileged operations:
+ */
+static int user_check_sched_setscheduler(struct task_struct *p,
+					 const struct sched_attr *attr,
+					 int policy, int reset_on_fork)
+{
+	if (fair_policy(policy)) {
+		if (attr->sched_nice < task_nice(p) &&
+		    !is_nice_reduction(p, attr->sched_nice))
+			goto req_priv;
+	}
+
+	if (rt_policy(policy)) {
+		unsigned long rlim_rtprio = task_rlimit(p, RLIMIT_RTPRIO);
+
+		/* Can't set/change the rt policy: */
+		if (policy != p->policy && !rlim_rtprio)
+			goto req_priv;
+
+		/* Can't increase priority: */
+		if (attr->sched_priority > p->rt_priority &&
+		    attr->sched_priority > rlim_rtprio)
+			goto req_priv;
+	}
+
+	/*
+	 * Can't set/change SCHED_DEADLINE policy at all for now
+	 * (safest behavior); in the future we would like to allow
+	 * unprivileged DL tasks to increase their relative deadline
+	 * or reduce their runtime (both ways reducing utilization)
+	 */
+	if (dl_policy(policy))
+		goto req_priv;
+
+	/*
+	 * Treat SCHED_IDLE as nice 20. Only allow a switch to
+	 * SCHED_NORMAL if the RLIMIT_NICE would normally permit it.
+	 */
+	if (task_has_idle_policy(p) && !idle_policy(policy)) {
+		if (!is_nice_reduction(p, task_nice(p)))
+			goto req_priv;
+	}
+
+	/* Can't change other user's priorities: */
+	if (!check_same_owner(p))
+		goto req_priv;
+
+	/* Normal users shall not reset the sched_reset_on_fork flag: */
+	if (p->sched_reset_on_fork && !reset_on_fork)
+		goto req_priv;
+
+	return 0;
+
+req_priv:
+	if (!capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	return 0;
+}
+
+int __sched_setscheduler(struct task_struct *p,
+			 const struct sched_attr *attr,
+			 bool user, bool pi)
+{
+	int oldpolicy = -1, policy = attr->sched_policy;
+	int retval, oldprio, newprio, queued, running;
+	const struct sched_class *prev_class;
+	struct balance_callback *head;
+	struct rq_flags rf;
+	int reset_on_fork;
+	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	struct rq *rq;
+	bool cpuset_locked = false;
+
+	/* The pi code expects interrupts enabled */
+	BUG_ON(pi && in_interrupt());
+recheck:
+	/* Double check policy once rq lock held: */
+	if (policy < 0) {
+		reset_on_fork = p->sched_reset_on_fork;
+		policy = oldpolicy = p->policy;
+	} else {
+		reset_on_fork = !!(attr->sched_flags & SCHED_FLAG_RESET_ON_FORK);
+
+		if (!valid_policy(policy))
+			return -EINVAL;
+	}
+
+	if (attr->sched_flags & ~(SCHED_FLAG_ALL | SCHED_FLAG_SUGOV))
+		return -EINVAL;
+
+	/*
+	 * Valid priorities for SCHED_FIFO and SCHED_RR are
+	 * 1..MAX_RT_PRIO-1, valid priority for SCHED_NORMAL,
+	 * SCHED_BATCH and SCHED_IDLE is 0.
+	 */
+	if (attr->sched_priority > MAX_RT_PRIO-1)
+		return -EINVAL;
+	if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
+	    (rt_policy(policy) != (attr->sched_priority != 0)))
+		return -EINVAL;
+
+	if (user) {
+		retval = user_check_sched_setscheduler(p, attr, policy, reset_on_fork);
+		if (retval)
+			return retval;
+
+		if (attr->sched_flags & SCHED_FLAG_SUGOV)
+			return -EINVAL;
+
+		retval = security_task_setscheduler(p);
+		if (retval)
+			return retval;
+	}
+
+	/* Update task specific "requested" clamps */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
+		retval = uclamp_validate(p, attr);
+		if (retval)
+			return retval;
+	}
+
+	/*
+	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
+	 * information.
+	 */
+	if (dl_policy(policy) || dl_policy(p->policy)) {
+		cpuset_locked = true;
+		cpuset_lock();
+	}
+
+	/*
+	 * Make sure no PI-waiters arrive (or leave) while we are
+	 * changing the priority of the task:
+	 *
+	 * To be able to change p->policy safely, the appropriate
+	 * runqueue lock must be held.
+	 */
+	rq = task_rq_lock(p, &rf);
+	update_rq_clock(rq);
+
+	/*
+	 * Changing the policy of the stop threads its a very bad idea:
+	 */
+	if (p == rq->stop) {
+		retval = -EINVAL;
+		goto unlock;
+	}
+
+	/*
+	 * If not changing anything there's no need to proceed further,
+	 * but store a possible modification of reset_on_fork.
+	 */
+	if (unlikely(policy == p->policy)) {
+		if (fair_policy(policy) && attr->sched_nice != task_nice(p))
+			goto change;
+		if (rt_policy(policy) && attr->sched_priority != p->rt_priority)
+			goto change;
+		if (dl_policy(policy) && dl_param_changed(p, attr))
+			goto change;
+		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
+			goto change;
+
+		p->sched_reset_on_fork = reset_on_fork;
+		retval = 0;
+		goto unlock;
+	}
+change:
+
+	if (user) {
+#ifdef CONFIG_RT_GROUP_SCHED
+		/*
+		 * Do not allow realtime tasks into groups that have no runtime
+		 * assigned.
+		 */
+		if (rt_bandwidth_enabled() && rt_policy(policy) &&
+				task_group(p)->rt_bandwidth.rt_runtime == 0 &&
+				!task_group_is_autogroup(task_group(p))) {
+			retval = -EPERM;
+			goto unlock;
+		}
+#endif
+#ifdef CONFIG_SMP
+		if (dl_bandwidth_enabled() && dl_policy(policy) &&
+				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
+			cpumask_t *span = rq->rd->span;
+
+			/*
+			 * Don't allow tasks with an affinity mask smaller than
+			 * the entire root_domain to become SCHED_DEADLINE. We
+			 * will also fail if there's no bandwidth available.
+			 */
+			if (!cpumask_subset(span, p->cpus_ptr) ||
+			    rq->rd->dl_bw.bw == 0) {
+				retval = -EPERM;
+				goto unlock;
+			}
+		}
+#endif
+	}
+
+	/* Re-check policy now with rq lock held: */
+	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
+		policy = oldpolicy = -1;
+		task_rq_unlock(rq, p, &rf);
+		if (cpuset_locked)
+			cpuset_unlock();
+		goto recheck;
+	}
+
+	/*
+	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
+	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
+	 * is available.
+	 */
+	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
+		retval = -EBUSY;
+		goto unlock;
+	}
+
+	p->sched_reset_on_fork = reset_on_fork;
+	oldprio = p->prio;
+
+	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
+	if (pi) {
+		/*
+		 * Take priority boosted tasks into account. If the new
+		 * effective priority is unchanged, we just store the new
+		 * normal parameters and do not touch the scheduler class and
+		 * the runqueue. This will be done when the task deboost
+		 * itself.
+		 */
+		newprio = rt_effective_prio(p, newprio);
+		if (newprio == oldprio)
+			queue_flags &= ~DEQUEUE_MOVE;
+	}
+
+	queued = task_on_rq_queued(p);
+	running = task_current(rq, p);
+	if (queued)
+		dequeue_task(rq, p, queue_flags);
+	if (running)
+		put_prev_task(rq, p);
+
+	prev_class = p->sched_class;
+
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+		__setscheduler_params(p, attr);
+		__setscheduler_prio(p, newprio);
+	}
+	__setscheduler_uclamp(p, attr);
+
+	if (queued) {
+		/*
+		 * We enqueue to tail when the priority of a task is
+		 * increased (user space view).
+		 */
+		if (oldprio < p->prio)
+			queue_flags |= ENQUEUE_HEAD;
+
+		enqueue_task(rq, p, queue_flags);
+	}
+	if (running)
+		set_next_task(rq, p);
+
+	check_class_changed(rq, p, prev_class, oldprio);
+
+	/* Avoid rq from going away on us: */
+	preempt_disable();
+	head = splice_balance_callbacks(rq);
+	task_rq_unlock(rq, p, &rf);
+
+	if (pi) {
+		if (cpuset_locked)
+			cpuset_unlock();
+		rt_mutex_adjust_pi(p);
+	}
+
+	/* Run balance callbacks after we've adjusted the PI chain: */
+	balance_callbacks(rq, head);
+	preempt_enable();
+
+	return 0;
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+	if (cpuset_locked)
+		cpuset_unlock();
+	return retval;
+}
+
+static int _sched_setscheduler(struct task_struct *p, int policy,
+			       const struct sched_param *param, bool check)
+{
+	struct sched_attr attr = {
+		.sched_policy   = policy,
+		.sched_priority = param->sched_priority,
+		.sched_nice	= PRIO_TO_NICE(p->static_prio),
+	};
+
+	/* Fixup the legacy SCHED_RESET_ON_FORK hack. */
+	if ((policy != SETPARAM_POLICY) && (policy & SCHED_RESET_ON_FORK)) {
+		attr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
+		policy &= ~SCHED_RESET_ON_FORK;
+		attr.sched_policy = policy;
+	}
+
+	return __sched_setscheduler(p, &attr, check, true);
+}
+/**
+ * sched_setscheduler - change the scheduling policy and/or RT priority of a thread.
+ * @p: the task in question.
+ * @policy: new policy.
+ * @param: structure containing the new RT priority.
+ *
+ * Use sched_set_fifo(), read its comment.
+ *
+ * Return: 0 on success. An error code otherwise.
+ *
+ * NOTE that the task may be already dead.
+ */
+int sched_setscheduler(struct task_struct *p, int policy,
+		       const struct sched_param *param)
+{
+	return _sched_setscheduler(p, policy, param, true);
+}
+
+int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
+{
+	return __sched_setscheduler(p, attr, true, true);
+}
+
+int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
+{
+	return __sched_setscheduler(p, attr, false, true);
+}
+EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
+
+/**
+ * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
+ * @p: the task in question.
+ * @policy: new policy.
+ * @param: structure containing the new RT priority.
+ *
+ * Just like sched_setscheduler, only don't bother checking if the
+ * current context has permission.  For example, this is needed in
+ * stop_machine(): we create temporary high priority worker threads,
+ * but our caller might not have that capability.
+ *
+ * Return: 0 on success. An error code otherwise.
+ */
+int sched_setscheduler_nocheck(struct task_struct *p, int policy,
+			       const struct sched_param *param)
+{
+	return _sched_setscheduler(p, policy, param, false);
+}
+
+/*
+ * SCHED_FIFO is a broken scheduler model; that is, it is fundamentally
+ * incapable of resource management, which is the one thing an OS really should
+ * be doing.
+ *
+ * This is of course the reason it is limited to privileged users only.
+ *
+ * Worse still; it is fundamentally impossible to compose static priority
+ * workloads. You cannot take two correctly working static prio workloads
+ * and smash them together and still expect them to work.
+ *
+ * For this reason 'all' FIFO tasks the kernel creates are basically at:
+ *
+ *   MAX_RT_PRIO / 2
+ *
+ * The administrator _MUST_ configure the system, the kernel simply doesn't
+ * know enough information to make a sensible choice.
+ */
+void sched_set_fifo(struct task_struct *p)
+{
+	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 };
+	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
+}
+EXPORT_SYMBOL_GPL(sched_set_fifo);
+
+/*
+ * For when you don't much care about FIFO, but want to be above SCHED_NORMAL.
+ */
+void sched_set_fifo_low(struct task_struct *p)
+{
+	struct sched_param sp = { .sched_priority = 1 };
+	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
+}
+EXPORT_SYMBOL_GPL(sched_set_fifo_low);
+
+void sched_set_normal(struct task_struct *p, int nice)
+{
+	struct sched_attr attr = {
+		.sched_policy = SCHED_NORMAL,
+		.sched_nice = nice,
+	};
+	WARN_ON_ONCE(sched_setattr_nocheck(p, &attr) != 0);
+}
+EXPORT_SYMBOL_GPL(sched_set_normal);
+
+static int
+do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
+{
+	struct sched_param lparam;
+
+	if (!param || pid < 0)
+		return -EINVAL;
+	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
+		return -EFAULT;
+
+	CLASS(find_get_task, p)(pid);
+	if (!p)
+		return -ESRCH;
+
+	return sched_setscheduler(p, policy, &lparam);
+}
+
+/*
+ * Mimics kernel/events/core.c perf_copy_attr().
+ */
+static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *attr)
+{
+	u32 size;
+	int ret;
+
+	/* Zero the full structure, so that a short copy will be nice: */
+	memset(attr, 0, sizeof(*attr));
+
+	ret = get_user(size, &uattr->size);
+	if (ret)
+		return ret;
+
+	/* ABI compatibility quirk: */
+	if (!size)
+		size = SCHED_ATTR_SIZE_VER0;
+	if (size < SCHED_ATTR_SIZE_VER0 || size > PAGE_SIZE)
+		goto err_size;
+
+	ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
+	if (ret) {
+		if (ret == -E2BIG)
+			goto err_size;
+		return ret;
+	}
+
+	if ((attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) &&
+	    size < SCHED_ATTR_SIZE_VER1)
+		return -EINVAL;
+
+	/*
+	 * XXX: Do we want to be lenient like existing syscalls; or do we want
+	 * to be strict and return an error on out-of-bounds values?
+	 */
+	attr->sched_nice = clamp(attr->sched_nice, MIN_NICE, MAX_NICE);
+
+	return 0;
+
+err_size:
+	put_user(sizeof(*attr), &uattr->size);
+	return -E2BIG;
+}
+
+static void get_params(struct task_struct *p, struct sched_attr *attr)
+{
+	if (task_has_dl_policy(p))
+		__getparam_dl(p, attr);
+	else if (task_has_rt_policy(p))
+		attr->sched_priority = p->rt_priority;
+	else
+		attr->sched_nice = task_nice(p);
+}
+
+/**
+ * sys_sched_setscheduler - set/change the scheduler policy and RT priority
+ * @pid: the pid in question.
+ * @policy: new policy.
+ * @param: structure containing the new RT priority.
+ *
+ * Return: 0 on success. An error code otherwise.
+ */
+SYSCALL_DEFINE3(sched_setscheduler, pid_t, pid, int, policy, struct sched_param __user *, param)
+{
+	if (policy < 0)
+		return -EINVAL;
+
+	return do_sched_setscheduler(pid, policy, param);
+}
+
+/**
+ * sys_sched_setparam - set/change the RT priority of a thread
+ * @pid: the pid in question.
+ * @param: structure containing the new RT priority.
+ *
+ * Return: 0 on success. An error code otherwise.
+ */
+SYSCALL_DEFINE2(sched_setparam, pid_t, pid, struct sched_param __user *, param)
+{
+	return do_sched_setscheduler(pid, SETPARAM_POLICY, param);
+}
+
+/**
+ * sys_sched_setattr - same as above, but with extended sched_attr
+ * @pid: the pid in question.
+ * @uattr: structure containing the extended parameters.
+ * @flags: for future extension.
+ */
+SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
+			       unsigned int, flags)
+{
+	struct sched_attr attr;
+	int retval;
+
+	if (!uattr || pid < 0 || flags)
+		return -EINVAL;
+
+	retval = sched_copy_attr(uattr, &attr);
+	if (retval)
+		return retval;
+
+	if ((int)attr.sched_policy < 0)
+		return -EINVAL;
+	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
+		attr.sched_policy = SETPARAM_POLICY;
+
+	CLASS(find_get_task, p)(pid);
+	if (!p)
+		return -ESRCH;
+
+	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
+		get_params(p, &attr);
+
+	return sched_setattr(p, &attr);
+}
+
+/**
+ * sys_sched_getscheduler - get the policy (scheduling class) of a thread
+ * @pid: the pid in question.
+ *
+ * Return: On success, the policy of the thread. Otherwise, a negative error
+ * code.
+ */
+SYSCALL_DEFINE1(sched_getscheduler, pid_t, pid)
+{
+	struct task_struct *p;
+	int retval;
+
+	if (pid < 0)
+		return -EINVAL;
+
+	guard(rcu)();
+	p = find_process_by_pid(pid);
+	if (!p)
+		return -ESRCH;
+
+	retval = security_task_getscheduler(p);
+	if (!retval) {
+		retval = p->policy;
+		if (p->sched_reset_on_fork)
+			retval |= SCHED_RESET_ON_FORK;
+	}
+	return retval;
+}
+
+/**
+ * sys_sched_getparam - get the RT priority of a thread
+ * @pid: the pid in question.
+ * @param: structure containing the RT priority.
+ *
+ * Return: On success, 0 and the RT priority is in @param. Otherwise, an error
+ * code.
+ */
+SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
+{
+	struct sched_param lp = { .sched_priority = 0 };
+	struct task_struct *p;
+	int retval;
+
+	if (!param || pid < 0)
+		return -EINVAL;
+
+	scoped_guard (rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
+
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
+
+		if (task_has_rt_policy(p))
+			lp.sched_priority = p->rt_priority;
+	}
+
+	/*
+	 * This one might sleep, we cannot do it with a spinlock held ...
+	 */
+	return copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
+}
+
+/*
+ * Copy the kernel size attribute structure (which might be larger
+ * than what user-space knows about) to user-space.
+ *
+ * Note that all cases are valid: user-space buffer can be larger or
+ * smaller than the kernel-space buffer. The usual case is that both
+ * have the same size.
+ */
+static int
+sched_attr_copy_to_user(struct sched_attr __user *uattr,
+			struct sched_attr *kattr,
+			unsigned int usize)
+{
+	unsigned int ksize = sizeof(*kattr);
+
+	if (!access_ok(uattr, usize))
+		return -EFAULT;
+
+	/*
+	 * sched_getattr() ABI forwards and backwards compatibility:
+	 *
+	 * If usize == ksize then we just copy everything to user-space and all is good.
+	 *
+	 * If usize < ksize then we only copy as much as user-space has space for,
+	 * this keeps ABI compatibility as well. We skip the rest.
+	 *
+	 * If usize > ksize then user-space is using a newer version of the ABI,
+	 * which part the kernel doesn't know about. Just ignore it - tooling can
+	 * detect the kernel's knowledge of attributes from the attr->size value
+	 * which is set to ksize in this case.
+	 */
+	kattr->size = min(usize, ksize);
+
+	if (copy_to_user(uattr, kattr, kattr->size))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * sys_sched_getattr - similar to sched_getparam, but with sched_attr
+ * @pid: the pid in question.
+ * @uattr: structure containing the extended parameters.
+ * @usize: sizeof(attr) for fwd/bwd comp.
+ * @flags: for future extension.
+ */
+SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
+		unsigned int, usize, unsigned int, flags)
+{
+	struct sched_attr kattr = { };
+	struct task_struct *p;
+	int retval;
+
+	if (!uattr || pid < 0 || usize > PAGE_SIZE ||
+	    usize < SCHED_ATTR_SIZE_VER0 || flags)
+		return -EINVAL;
+
+	scoped_guard (rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
+
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
+
+		kattr.sched_policy = p->policy;
+		if (p->sched_reset_on_fork)
+			kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
+		get_params(p, &kattr);
+		kattr.sched_flags &= SCHED_FLAG_ALL;
+
+#ifdef CONFIG_UCLAMP_TASK
+		/*
+		 * This could race with another potential updater, but this is fine
+		 * because it'll correctly read the old or the new value. We don't need
+		 * to guarantee who wins the race as long as it doesn't return garbage.
+		 */
+		kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
+		kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
+#endif
+	}
+
+	return sched_attr_copy_to_user(uattr, &kattr, usize);
+}
+
+#ifdef CONFIG_SMP
+int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
+{
+	/*
+	 * If the task isn't a deadline task or admission control is
+	 * disabled then we don't care about affinity changes.
+	 */
+	if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
+		return 0;
+
+	/*
+	 * Since bandwidth control happens on root_domain basis,
+	 * if admission test is enabled, we only admit -deadline
+	 * tasks allowed to run on all the CPUs in the task's
+	 * root_domain.
+	 */
+	guard(rcu)();
+	if (!cpumask_subset(task_rq(p)->rd->span, mask))
+		return -EBUSY;
+
+	return 0;
+}
+#endif /* CONFIG_SMP */
+
+int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
+{
+	int retval;
+	cpumask_var_t cpus_allowed, new_mask;
+
+	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
+		return -ENOMEM;
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
+		retval = -ENOMEM;
+		goto out_free_cpus_allowed;
+	}
+
+	cpuset_cpus_allowed(p, cpus_allowed);
+	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
+
+	ctx->new_mask = new_mask;
+	ctx->flags |= SCA_CHECK;
+
+	retval = dl_task_check_affinity(p, new_mask);
+	if (retval)
+		goto out_free_new_mask;
+
+	retval = __set_cpus_allowed_ptr(p, ctx);
+	if (retval)
+		goto out_free_new_mask;
+
+	cpuset_cpus_allowed(p, cpus_allowed);
+	if (!cpumask_subset(new_mask, cpus_allowed)) {
+		/*
+		 * We must have raced with a concurrent cpuset update.
+		 * Just reset the cpumask to the cpuset's cpus_allowed.
+		 */
+		cpumask_copy(new_mask, cpus_allowed);
+
+		/*
+		 * If SCA_USER is set, a 2nd call to __set_cpus_allowed_ptr()
+		 * will restore the previous user_cpus_ptr value.
+		 *
+		 * In the unlikely event a previous user_cpus_ptr exists,
+		 * we need to further restrict the mask to what is allowed
+		 * by that old user_cpus_ptr.
+		 */
+		if (unlikely((ctx->flags & SCA_USER) && ctx->user_mask)) {
+			bool empty = !cpumask_and(new_mask, new_mask,
+						  ctx->user_mask);
+
+			if (WARN_ON_ONCE(empty))
+				cpumask_copy(new_mask, cpus_allowed);
+		}
+		__set_cpus_allowed_ptr(p, ctx);
+		retval = -EINVAL;
+	}
+
+out_free_new_mask:
+	free_cpumask_var(new_mask);
+out_free_cpus_allowed:
+	free_cpumask_var(cpus_allowed);
+	return retval;
+}
+
+long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+{
+	struct affinity_context ac;
+	struct cpumask *user_mask;
+	int retval;
+
+	CLASS(find_get_task, p)(pid);
+	if (!p)
+		return -ESRCH;
+
+	if (p->flags & PF_NO_SETAFFINITY)
+		return -EINVAL;
+
+	if (!check_same_owner(p)) {
+		guard(rcu)();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE))
+			return -EPERM;
+	}
+
+	retval = security_task_setscheduler(p);
+	if (retval)
+		return retval;
+
+	/*
+	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
+	 * alloc_user_cpus_ptr() returns NULL.
+	 */
+	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
+	if (user_mask) {
+		cpumask_copy(user_mask, in_mask);
+	} else if (IS_ENABLED(CONFIG_SMP)) {
+		return -ENOMEM;
+	}
+
+	ac = (struct affinity_context){
+		.new_mask  = in_mask,
+		.user_mask = user_mask,
+		.flags     = SCA_USER,
+	};
+
+	retval = __sched_setaffinity(p, &ac);
+	kfree(ac.user_mask);
+
+	return retval;
+}
+
+static int get_user_cpu_mask(unsigned long __user *user_mask_ptr, unsigned len,
+			     struct cpumask *new_mask)
+{
+	if (len < cpumask_size())
+		cpumask_clear(new_mask);
+	else if (len > cpumask_size())
+		len = cpumask_size();
+
+	return copy_from_user(new_mask, user_mask_ptr, len) ? -EFAULT : 0;
+}
+
+/**
+ * sys_sched_setaffinity - set the CPU affinity of a process
+ * @pid: pid of the process
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
+ * @user_mask_ptr: user-space pointer to the new CPU mask
+ *
+ * Return: 0 on success. An error code otherwise.
+ */
+SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
+		unsigned long __user *, user_mask_ptr)
+{
+	cpumask_var_t new_mask;
+	int retval;
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	retval = get_user_cpu_mask(user_mask_ptr, len, new_mask);
+	if (retval == 0)
+		retval = sched_setaffinity(pid, new_mask);
+	free_cpumask_var(new_mask);
+	return retval;
+}
+
+long sched_getaffinity(pid_t pid, struct cpumask *mask)
+{
+	struct task_struct *p;
+	int retval;
+
+	guard(rcu)();
+	p = find_process_by_pid(pid);
+	if (!p)
+		return -ESRCH;
+
+	retval = security_task_getscheduler(p);
+	if (retval)
+		return retval;
+
+	guard(raw_spinlock_irqsave)(&p->pi_lock);
+	cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
+
+	return 0;
+}
+
+/**
+ * sys_sched_getaffinity - get the CPU affinity of a process
+ * @pid: pid of the process
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
+ * @user_mask_ptr: user-space pointer to hold the current CPU mask
+ *
+ * Return: size of CPU mask copied to user_mask_ptr on success. An
+ * error code otherwise.
+ */
+SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
+		unsigned long __user *, user_mask_ptr)
+{
+	int ret;
+	cpumask_var_t mask;
+
+	if ((len * BITS_PER_BYTE) < nr_cpu_ids)
+		return -EINVAL;
+	if (len & (sizeof(unsigned long)-1))
+		return -EINVAL;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = sched_getaffinity(pid, mask);
+	if (ret == 0) {
+		unsigned int retlen = min(len, cpumask_size());
+
+		if (copy_to_user(user_mask_ptr, cpumask_bits(mask), retlen))
+			ret = -EFAULT;
+		else
+			ret = retlen;
+	}
+	free_cpumask_var(mask);
+
+	return ret;
+}
+
+static void do_sched_yield(void)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	rq = this_rq_lock_irq(&rf);
+
+	schedstat_inc(rq->yld_count);
+	current->sched_class->yield_task(rq);
+
+	preempt_disable();
+	rq_unlock_irq(rq, &rf);
+	sched_preempt_enable_no_resched();
+
+	schedule();
+}
+
+/**
+ * sys_sched_yield - yield the current processor to other threads.
+ *
+ * This function yields the current CPU to other tasks. If there are no
+ * other threads running on this CPU then this function will return.
+ *
+ * Return: 0.
+ */
+SYSCALL_DEFINE0(sched_yield)
+{
+	do_sched_yield();
+	return 0;
+}
+
+/**
+ * yield - yield the current processor to other threads.
+ *
+ * Do not ever use this function, there's a 99% chance you're doing it wrong.
+ *
+ * The scheduler is at all times free to pick the calling task as the most
+ * eligible task to run, if removing the yield() call from your code breaks
+ * it, it's already broken.
+ *
+ * Typical broken usage is:
+ *
+ * while (!event)
+ *	yield();
+ *
+ * where one assumes that yield() will let 'the other' process run that will
+ * make event true. If the current task is a SCHED_FIFO task that will never
+ * happen. Never use yield() as a progress guarantee!!
+ *
+ * If you want to use yield() to wait for something, use wait_event().
+ * If you want to use yield() to be 'nice' for others, use cond_resched().
+ * If you still want to use yield(), do not!
+ */
+void __sched yield(void)
+{
+	set_current_state(TASK_RUNNING);
+	do_sched_yield();
+}
+EXPORT_SYMBOL(yield);
+
+/**
+ * yield_to - yield the current processor to another thread in
+ * your thread group, or accelerate that thread toward the
+ * processor it's on.
+ * @p: target task
+ * @preempt: whether task preemption is allowed or not
+ *
+ * It's the caller's job to ensure that the target task struct
+ * can't go away on us before we can do any checks.
+ *
+ * Return:
+ *	true (>0) if we indeed boosted the target task.
+ *	false (0) if we failed to boost the target.
+ *	-ESRCH if there's no task to yield to.
+ */
+int __sched yield_to(struct task_struct *p, bool preempt)
+{
+	struct task_struct *curr = current;
+	struct rq *rq, *p_rq;
+	int yielded = 0;
+
+	scoped_guard (irqsave) {
+		rq = this_rq();
+
+again:
+		p_rq = task_rq(p);
+		/*
+		 * If we're the only runnable task on the rq and target rq also
+		 * has only one task, there's absolutely no point in yielding.
+		 */
+		if (rq->nr_running == 1 && p_rq->nr_running == 1)
+			return -ESRCH;
+
+		guard(double_rq_lock)(rq, p_rq);
+		if (task_rq(p) != p_rq)
+			goto again;
+
+		if (!curr->sched_class->yield_to_task)
+			return 0;
+
+		if (curr->sched_class != p->sched_class)
+			return 0;
+
+		if (task_on_cpu(p_rq, p) || !task_is_running(p))
+			return 0;
+
+		yielded = curr->sched_class->yield_to_task(rq, p);
+		if (yielded) {
+			schedstat_inc(rq->yld_count);
+			/*
+			 * Make p's CPU reschedule; pick_next_entity
+			 * takes care of fairness.
+			 */
+			if (preempt && rq != p_rq)
+				resched_curr(p_rq);
+		}
+	}
+
+	if (yielded)
+		schedule();
+
+	return yielded;
+}
+EXPORT_SYMBOL_GPL(yield_to);
+
+/**
+ * sys_sched_get_priority_max - return maximum RT priority.
+ * @policy: scheduling class.
+ *
+ * Return: On success, this syscall returns the maximum
+ * rt_priority that can be used by a given scheduling class.
+ * On failure, a negative error code is returned.
+ */
+SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
+{
+	int ret = -EINVAL;
+
+	switch (policy) {
+	case SCHED_FIFO:
+	case SCHED_RR:
+		ret = MAX_RT_PRIO-1;
+		break;
+	case SCHED_DEADLINE:
+	case SCHED_NORMAL:
+	case SCHED_BATCH:
+	case SCHED_IDLE:
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
+/**
+ * sys_sched_get_priority_min - return minimum RT priority.
+ * @policy: scheduling class.
+ *
+ * Return: On success, this syscall returns the minimum
+ * rt_priority that can be used by a given scheduling class.
+ * On failure, a negative error code is returned.
+ */
+SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
+{
+	int ret = -EINVAL;
+
+	switch (policy) {
+	case SCHED_FIFO:
+	case SCHED_RR:
+		ret = 1;
+		break;
+	case SCHED_DEADLINE:
+	case SCHED_NORMAL:
+	case SCHED_BATCH:
+	case SCHED_IDLE:
+		ret = 0;
+	}
+	return ret;
+}
+
+static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
+{
+	unsigned int time_slice = 0;
+	int retval;
+
+	if (pid < 0)
+		return -EINVAL;
+
+	scoped_guard (rcu) {
+		struct task_struct *p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
+
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
+
+		scoped_guard (task_rq_lock, p) {
+			struct rq *rq = scope.rq;
+			if (p->sched_class->get_rr_interval)
+				time_slice = p->sched_class->get_rr_interval(rq, p);
+		}
+	}
+
+	jiffies_to_timespec64(time_slice, t);
+	return 0;
+}
+
+/**
+ * sys_sched_rr_get_interval - return the default timeslice of a process.
+ * @pid: pid of the process.
+ * @interval: userspace pointer to the timeslice value.
+ *
+ * this syscall writes the default timeslice value of a given process
+ * into the user-space timespec buffer. A value of '0' means infinity.
+ *
+ * Return: On success, 0 and the timeslice is in @interval. Otherwise,
+ * an error code.
+ */
+SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
+		struct __kernel_timespec __user *, interval)
+{
+	struct timespec64 t;
+	int retval = sched_rr_get_interval(pid, &t);
+
+	if (retval == 0)
+		retval = put_timespec64(&t, interval);
+
+	return retval;
+}
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
+SYSCALL_DEFINE2(sched_rr_get_interval_time32, pid_t, pid,
+		struct old_timespec32 __user *, interval)
+{
+	struct timespec64 t;
+	int retval = sched_rr_get_interval(pid, &t);
+
+	if (retval == 0)
+		retval = put_old_timespec32(&t, interval);
+	return retval;
+}
+#endif
+
-- 
2.40.1


