Return-Path: <linux-kernel+bounces-73786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14C985CB34
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0AD8B21B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E030154456;
	Tue, 20 Feb 2024 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="b0dxgfZ+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E8152E0B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469800; cv=none; b=Wb1w8+pIH3/wd704ndW2d+lvQtFoAR0VsclQ1VKGJge0j3tjLQXaHg++5eV9RWrUNLNpMwGfYH3Vm+PtfQd41lKbr32jNs//y0JOO690D3BdZ/D9mxD246FvlZ/6s5JW3L5dY0dhTQhxcurhV1gevL1pj7MYK25y3VSiaIq/EG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469800; c=relaxed/simple;
	bh=Oe9MQLkXOInGOsgqFCqp5Pk6sTMkSt23DYmgc8HrYKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZW9YTxSShAFvC/qzUdvW1xKYC6xDwOmfP9TfhGVn3uThRbbzo9iXypytgFNl9dJDwUsDKCiPFBX2+xihLydGBUhUohTFo/lh5hYKZyvcGWtdTxC/uekam0mYmZlrbNl2d9nRlu1YoWeOjyGSelTo381iCi3A0mNAZ/pbiqzjYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=b0dxgfZ+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso1051093066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708469796; x=1709074596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0SnjLhmWiU4ahbZOfLIAejOCAQMGIkWwrZ4aZTqpFE=;
        b=b0dxgfZ+CzoE14z69QJzzEeGR/oZtAfILwUSsmJuX8Zt2UeyTIWM4epkf0Pv41KHbU
         9lxgvJXuePcyFXNOcXeYnMtZVSjIgui3dONSxGj7+L68lq61IMyY8wXTmvawDUJBHolY
         oGKzFlzpDfMjiSCUbMFItAnGUy3ldw8AszInU/YLTwgpRwvHRO0zBIttMn5jH05XbMu/
         DG2Ogov1cSBBQ2PnH+Woz0b5kk7fVD1zDMwGk2ujAsbc/QriW08xz14uHUIUPfyLhThH
         +gOdAqBcUw6hRa946aP00HrZ5OV74yRAu+ZAYbM+pUfg1NacVFtBUgz5Tbl/OhVTr9wN
         7tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469796; x=1709074596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0SnjLhmWiU4ahbZOfLIAejOCAQMGIkWwrZ4aZTqpFE=;
        b=Mpy9i+f0MEoGqM4+mxnT7PdfHecK6Mq5Yh3SmnJOlPTP9nDI/uTodX3QyzIT/91gBd
         krXCuFpxUkoyH3lWbDEZ1KdiKat1bYyEbZkKF7O2JhkFAMtfhV/TBX6cc6F0gpwzMGr0
         22nr7+VtmNLTzX9Sdpc8ouHVZoO+At02GcE/nrbhm4yHPJxhf5C+R9McQGSKZCz+51gA
         IPFpCsTTq4AhUlBsW1dJf9rOOPfQBgAcRDaXEAp1LvO3lEh7zr8L2Eo4mZ05AUbN3LtF
         HsMrL2e9LM3MJ2sdS7ZFXtouU6S3XlH/Ij6R+izPN3KpX1o55gUD9D7CxbAEy/sba8s7
         xAIg==
X-Gm-Message-State: AOJu0YyZbamaTKx79R5V9AjHijNsirQKpCLSVHCWsMgHJick6fhisn80
	x6tqmZ5hnz+El3pE2X4AgKdblrUPfJZf9/XE6ubslTTWo6PP0u2jQfpRKgYI8ug=
X-Google-Smtp-Source: AGHT+IGAeT91ktic70LGV6b9DmKjcRRrQcqHYRYgJED0I9z/HVPnCnHt66XwLs1Kx587JTLfaVyA/A==
X-Received: by 2002:a17:906:e83:b0:a3e:599:ae86 with SMTP id p3-20020a1709060e8300b00a3e0599ae86mr10648381ejf.9.1708469796620;
        Tue, 20 Feb 2024 14:56:36 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907a70d00b00a3c5d10bcdbsm4381946ejc.114.2024.02.20.14.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:56:36 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when updating misfit
Date: Tue, 20 Feb 2024 22:56:20 +0000
Message-Id: <20240220225622.2626569-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220225622.2626569-1-qyousef@layalina.io>
References: <20240220225622.2626569-1-qyousef@layalina.io>
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

Improve check_misfit_status() function by removing redundant checks.
misfit_task_load will be 0 if the task can't move to a bigger CPU. And
nohz_load_balance() already checks for cpu_check_capacity() before
calling check_misfit_status().

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
 kernel/sched/fair.c   | 77 +++++++++++++++++++++++++++++++++----------
 3 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..774cddbeab09 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -835,6 +835,7 @@ struct task_struct {
 #endif
 
 	unsigned int			policy;
+	unsigned long			max_allowed_capacity;
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			*user_cpus_ptr;
diff --git a/init/init_task.c b/init/init_task.c
index 7ecb458eb3da..b3dbab4c959e 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -77,6 +77,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
 	.cpus_mask	= CPU_MASK_ALL,
+	.max_allowed_capacity	= SCHED_CAPACITY_SCALE,
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e30e2bb77a0..20006fcf7df2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5092,24 +5092,35 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 
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
+	/*
+	 * Affinity allows us to go somewhere higher?  Or are we on biggest
+	 * available CPU already?
+	 */
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
@@ -8241,6 +8252,36 @@ static void task_dead_fair(struct task_struct *p)
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
@@ -8249,6 +8290,8 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return newidle_balance(rq, rf) != 0;
 }
+#else
+static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 #endif /* CONFIG_SMP */
 
 static void set_next_buddy(struct sched_entity *se)
@@ -9601,16 +9644,10 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
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
+	return rq->misfit_task_load;
 }
 
 /*
@@ -12645,6 +12682,8 @@ static void task_fork_fair(struct task_struct *p)
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 
+	set_task_max_allowed_capacity(p);
+
 	cfs_rq = task_cfs_rq(current);
 	curr = cfs_rq->curr;
 	if (curr)
@@ -12768,6 +12807,8 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
 	attach_task_cfs_rq(p);
 
+	set_task_max_allowed_capacity(p);
+
 	if (task_on_rq_queued(p)) {
 		/*
 		 * We were most likely switched from sched_rt, so
@@ -13139,7 +13180,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.rq_offline		= rq_offline_fair,
 
 	.task_dead		= task_dead_fair,
-	.set_cpus_allowed	= set_cpus_allowed_common,
+	.set_cpus_allowed	= set_cpus_allowed_fair,
 #endif
 
 	.task_tick		= task_tick_fair,
-- 
2.34.1


