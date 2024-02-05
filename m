Return-Path: <linux-kernel+bounces-51984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4B84924B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404A4282A29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AFFB660;
	Mon,  5 Feb 2024 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xktyR0bY"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1F8F47
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099102; cv=none; b=p0xiPgMzDd6xO90Q9Mixgscl61yLBv9ZGRNc81kmdWI3wLjP9V+XZz+98JNJglaOgh8VuntJB9+qKT84f50ZDwS1ZnckHsLELsOg5YIMF4s23YA1OpVB4i1klF4LD5NgV2Y5foc48zuZpLRySOCf/3gfAvn3dBnVo3Y3Zw6DZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099102; c=relaxed/simple;
	bh=PMsc4K9BD1uYrMwqzPyh9tQ6u4MAjJ4W+8DnzZ9warA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNWGafpZ1VaFh0orHN/QyILj6Uo7G5UWAIXB2Hb7Mb+GFrvREZfLQnNmreutnCAKG2419KM64ryND1z60rCcWPtabZhn/3O+6OHm556jWKXsj3diiJbQ9161fTx4n9E0TYYZOcH0kcfKwOjwLxjZKEN+m7rt6JiDkOZz/2zK4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=xktyR0bY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fdd5bbe65so429705e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 18:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707099098; x=1707703898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrqO2B+XixMyeCid6/wthHwgVgi14v6y2AEDv2YkXgI=;
        b=xktyR0bYJ+z90fR8rjTCh+jByWk6K/SoRNyeDIqQdchtofwZf5DFkJq7As8OvZQiGo
         FCvKr5xP1ptpcxtosejL0s4+iovnIGltgdSWt5nPgL74UeFDUjqbFk1SoMLoSVTxui1P
         Zc9K3NjyrRTRB4Ln1N/kSf1xQsn28n0GYbe4WDVpyRc/7JiHWgAO15G5KXpzW+AF9mAf
         pKfdHuMJ7Bq7jq/ZOOfE8fxfkRP+79hAUwu5qRbZDxy/mH5FODZZmOOXPo31zndK6ylf
         5E1Gl4JDGLSMGyvzhgeshsZ02+8FHq37Knr8MKr/rurgEIdLMcW6d/dGtPvP3Vrd5JUZ
         UcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707099098; x=1707703898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrqO2B+XixMyeCid6/wthHwgVgi14v6y2AEDv2YkXgI=;
        b=j7BDZyJ9LCRyLKgcTWh0ZjDkc/yZ/9B7c08dyfoCBh4bqYRus72VGUYbXXHHTMAz86
         BMjb/u6TnDm27OdZ8ojlnHksLCMQ2myNl3PT6QoogvJdi4IpZ77wEfO3T8UXi0V/6GvS
         rfct3yJKK1tcOR1erD6JgIP5Xd9QL5KihhcyU0vXjJvxK14xmHSeqxn74unhBVU0f/6x
         8LwpYuLrlzadQ4w69okQQphJQoLqCSAT/KqTGl8nhHCOcGwEtiPQIdyuVfO7i09rw09D
         HuKmvG0OPUdk8td/OFMG5sVGDkuYjGTmWE4mCM/pjmzlPfp2QDXjmtJ2BJfdSViCh8pb
         ShFg==
X-Gm-Message-State: AOJu0YxLcCNZEEukYS7JB/+xUPzAero09hSlhTfd9Q+2tlEnk5XGr4K+
	CY6/yPlGGFVWg9Hf5kPhJlilkx4JmZqWTtfZULu6UiEeQcGT+mkXZhQCC7Q5f1c=
X-Google-Smtp-Source: AGHT+IGyVxX6aou1hcQpNo4ivtaHKilGSv1jF1i64t31J9mV465YpHZX7iyoJJlRJUtobD/ZFvYxzQ==
X-Received: by 2002:adf:f8c6:0:b0:33a:ea26:6a91 with SMTP id f6-20020adff8c6000000b0033aea266a91mr6839013wrq.0.1707099098627;
        Sun, 04 Feb 2024 18:11:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX6fU1gWVTH1AXCLzFeKYNKzOP9Ot7X+FrcWowicAYHIMDaauqeiixn6UmgcA4+k0HPoPJz2NAtff/m/JHIa6+Y6RVpRgOqgUWmXdl2kfuO3xKMC98/1qK/597jzpQk/csCNOxFwyWueu05XEiNtvp9L/oTt5jupHx6EOqzP4199K9atFHotZEEHjwEpHiSm590l0zMr8pfOME83uCyZRhWy340xyp+kQ==
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d4524000000b0033addeabd6fsm6999800wra.18.2024.02.04.18.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:11:38 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v5 2/2] sched/fair: Check a task has a fitting cpu when updating misfit
Date: Mon,  5 Feb 2024 02:11:23 +0000
Message-Id: <20240205021123.2225933-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205021123.2225933-1-qyousef@layalina.io>
References: <20240205021123.2225933-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a misfit task is affined to a subset of the possible cpus, we need to
verify that one of these cpus can fit it. Otherwise the load balancer
code will continuously trigger needlessly leading the balance_interval
to increase in return and eventually end up with a situation where real
imbalances take a long time to address because of this impossible
imbalance situation.

This can happen in Android world where it's common for background tasks
to be restricted to little cores.

Similarly if we can't fit the biggest core, triggering misfit is
pointless as it is the best we can ever get on this system.

To be able to detect that; we use asym_cap_list to iterate through
capacities in the system to see if the task is able to run at a higher
capacity level based on its p->cpus_ptr. We do that when the affinity
change, a fair task is forked, or when a task switched to fair policy.
We store the max_allowed_capacity in task_struct to allow for cheap
comparison in the fast path.

Improve check_misfit_status() function to be more readable. At one
iteration of the patch it was thought we can drop one of the checks. The
current form hopefully should make it more obvious what is being checked
and why.

Test:
=====

Add

	trace_printk("balance_interval = %lu\n", interval)

in get_sd_balance_interval().

run
	if [ "$MASK" != "0" ]; then
		adb shell "taskset -a $MASK cat /dev/zero > /dev/null"
	fi
	sleep 10
	// parse ftrace buffer counting the occurrence of each valaue

Where MASK is either:

	* 0: no busy task running
	* 1: busy task is pinned to 1 cpu; handled today to not cause
	  misfit
	* f: busy task pinned to little cores, simulates busy background
	  task, demonstrates the problem to be fixed

Results:
========

Note how occurrence of balance_interval = 128 overshoots for MASK = f.

BEFORE
------

	MASK=0

		   1 balance_interval = 175
		 120 balance_interval = 128
		 846 balance_interval = 64
		  55 balance_interval = 63
		 215 balance_interval = 32
		   2 balance_interval = 31
		   2 balance_interval = 16
		   4 balance_interval = 8
		1870 balance_interval = 4
		  65 balance_interval = 2

	MASK=1

		  27 balance_interval = 175
		  37 balance_interval = 127
		 840 balance_interval = 64
		 167 balance_interval = 63
		 449 balance_interval = 32
		  84 balance_interval = 31
		 304 balance_interval = 16
		1156 balance_interval = 8
		2781 balance_interval = 4
		 428 balance_interval = 2

	MASK=f

		   1 balance_interval = 175
		1328 balance_interval = 128
		  44 balance_interval = 64
		 101 balance_interval = 63
		  25 balance_interval = 32
		   5 balance_interval = 31
		  23 balance_interval = 16
		  23 balance_interval = 8
		4306 balance_interval = 4
		 177 balance_interval = 2

AFTER
-----

Note how the high values almost disappear for all MASK values. The
system has background tasks that could trigger the problem without
simulate it even with MASK=0.

	MASK=0

		 103 balance_interval = 63
		  19 balance_interval = 31
		 194 balance_interval = 8
		4827 balance_interval = 4
		 179 balance_interval = 2

	MASK=1

		 131 balance_interval = 63
		   1 balance_interval = 31
		  87 balance_interval = 8
		3600 balance_interval = 4
		   7 balance_interval = 2

	MASK=f

		   8 balance_interval = 127
		 182 balance_interval = 63
		   3 balance_interval = 31
		   9 balance_interval = 16
		 415 balance_interval = 8
		3415 balance_interval = 4
		  21 balance_interval = 2

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h |  1 +
 init/init_task.c      |  1 +
 kernel/sched/fair.c   | 84 +++++++++++++++++++++++++++++++++----------
 3 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 03bfe9ab2951..1e7bf52de607 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -827,6 +827,7 @@ struct task_struct {
 #endif
 
 	unsigned int			policy;
+	unsigned long			max_allowed_capacity;
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			*user_cpus_ptr;
diff --git a/init/init_task.c b/init/init_task.c
index 5727d42149c3..01b3199d4cde 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -82,6 +82,7 @@ struct task_struct init_task
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
 	.cpus_mask	= CPU_MASK_ALL,
+	.max_allowed_capacity	= SCHED_CAPACITY_SCALE,
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b803030c3a03..8b8035f5c8f6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5092,24 +5092,36 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
+	unsigned long cpu_cap;
+	int cpu = cpu_of(rq);
+
 	if (!sched_asym_cpucap_active())
 		return;
 
-	if (!p || p->nr_cpus_allowed == 1) {
-		rq->misfit_task_load = 0;
-		return;
-	}
+	if (!p || p->nr_cpus_allowed == 1)
+		goto out;
 
-	if (task_fits_cpu(p, cpu_of(rq))) {
-		rq->misfit_task_load = 0;
-		return;
-	}
+	cpu_cap = arch_scale_cpu_capacity(cpu);
+
+	/* If we can't fit the biggest CPU, that's the best we can ever get. */
+	if (cpu_cap == rq->rd->max_cpu_capacity)
+		goto out;
+
+	/* Affinity allows us to go somewhere higher? */
+	if (cpu_cap == p->max_allowed_capacity)
+		goto out;
+
+	if (task_fits_cpu(p, cpu))
+		goto out;
 
 	/*
 	 * Make sure that misfit_task_load will not be null even if
 	 * task_h_load() returns 0.
 	 */
 	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
+	return;
+out:
+	rq->misfit_task_load = 0;
 }
 
 #else /* CONFIG_SMP */
@@ -8241,6 +8253,36 @@ static void task_dead_fair(struct task_struct *p)
 	remove_entity_load_avg(&p->se);
 }
 
+/*
+ * Check the max capacity the task is allowed to run at for misfit detection.
+ */
+static void set_task_max_allowed_capacity(struct task_struct *p)
+{
+	struct asym_cap_data *entry;
+
+	if (!sched_asym_cpucap_active())
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
+		cpumask_t *cpumask;
+
+		cpumask = cpu_capacity_span(entry);
+		if (!cpumask_intersects(p->cpus_ptr, cpumask))
+			continue;
+
+		p->max_allowed_capacity = entry->capacity;
+		break;
+	}
+	rcu_read_unlock();
+}
+
+static void set_cpus_allowed_fair(struct task_struct *p, struct affinity_context *ctx)
+{
+	set_cpus_allowed_common(p, ctx);
+	set_task_max_allowed_capacity(p);
+}
+
 static int
 balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -9601,16 +9643,18 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
 }
 
-/*
- * Check whether a rq has a misfit task and if it looks like we can actually
- * help that task: we can migrate the task to a CPU of higher capacity, or
- * the task's current CPU is heavily pressured.
- */
-static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
+/* Check if the rq has a misfit task */
+static inline bool check_misfit_status(struct rq *rq, struct sched_domain *sd)
 {
-	return rq->misfit_task_load &&
-		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
-		 check_cpu_capacity(rq, sd));
+	if (!rq->misfit_task_load)
+		return false;
+
+	/* Can we migrate to a CPU with higher capacity? */
+	if (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity)
+		return true;
+
+	/* Is the task's CPU being heavily pressured? */
+	return check_cpu_capacity(rq, sd);
 }
 
 /*
@@ -12647,6 +12691,8 @@ static void task_fork_fair(struct task_struct *p)
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 
+	set_task_max_allowed_capacity(p);
+
 	cfs_rq = task_cfs_rq(current);
 	curr = cfs_rq->curr;
 	if (curr)
@@ -12770,6 +12816,8 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
 	attach_task_cfs_rq(p);
 
+	set_task_max_allowed_capacity(p);
+
 	if (task_on_rq_queued(p)) {
 		/*
 		 * We were most likely switched from sched_rt, so
@@ -13154,7 +13202,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.rq_offline		= rq_offline_fair,
 
 	.task_dead		= task_dead_fair,
-	.set_cpus_allowed	= set_cpus_allowed_common,
+	.set_cpus_allowed	= set_cpus_allowed_fair,
 #endif
 
 	.task_tick		= task_tick_fair,
-- 
2.34.1


