Return-Path: <linux-kernel+bounces-78420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE198861338
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8391428695D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD307F7CE;
	Fri, 23 Feb 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Zynzlw9D"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC447F7C1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696112; cv=none; b=rYaLk3mu9ANyB3BIQO9HMxPfNCPV3Q7XGATE+N8RJqUyOaavcOHfjhpNTbcHWUXSFgHgTm/Q4TKmgZCS9OIHJBXAZ0Dw+mcVaxRmKBv72VpheljnZ9yZwnsLFLTcxh3iTFSprM4Q9OmfZip1lFJNJipyavLbWE0KUR7p/06b7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696112; c=relaxed/simple;
	bh=kQC/AIyLSUbnucGdC650xY3KxtsDWvGUs9fXlnoKlhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cATImtYLACBiXiGTWOH7Qk/2vDhCnuhIZ6CbWHnaIml+2djEG8Twuun9TJpYDHsC8qA4lcbLFgC/A99Qygo0JaCBlvtzGccqT2A19QTwq8yG6gqIqZakVg1l1CUInCpxSkVIqxNEGXxKg2y9X3MiWVm29oUQZ0dgyLm+E1wy544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Zynzlw9D; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso585748f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708696109; x=1709300909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n970gOrqrt/XseDvY4zh60iTmTMFaC8GVqt55zhMiDc=;
        b=Zynzlw9DO5bcpHUrNQ+bwT4JMPOhxNY+jTrWCsskhI3yVu1rYw9rs/vBuNd9po3p6d
         +KuKFnkT2iA2uOvtTPG2WJr4Cs5gARC/5B4/q3mHleDEWO+RusfSlQSImO90WPeHG6rb
         G7VeOOhu49Dn/LLmWpLwWnBvWHJsqR0g/knuGzoSt+dBnHsZZRpLFN1Sm68Ns4EaBJao
         DDYZVC1osvXEhxT1bcOaosBpzWYI55LwBsYcMj2siquCuvUtnalRa+vNYq+Jevxr46Pr
         FSWFGiYbf794HWotO/17unU+QmUtfZozjzYmnOoq73JMTpx3hL0GcmU/R3Pn29kAr+/I
         w5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708696109; x=1709300909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n970gOrqrt/XseDvY4zh60iTmTMFaC8GVqt55zhMiDc=;
        b=xJeFHgpn4zZUlSCX3csxC12wNhSfhXT3wpP7gc5uWd0bwxGSptMP/cn2SB1rbJVotj
         6cJ+gB6dc936ZfdT0s8NKSR3BhRUkm0bE1T/dYti+1NiHXrh2drShwo8hY+NPVzhdVZQ
         UvDpFzssqBREkn5RWGK5FQU3fTD5BgEC4LByuqnIYpS2CGL8DOd6kxqb+DoauIj0NvYX
         sBtN5Qp2DGHoOYeZgU08xuM+TWB/7ClUzf8oXVDDXgfFRLnB8SPGNmGoBrIQqlfqbzao
         bdVqkgur+K3eLMQHS+xrJYQgCfAKrnotbXiSxZTGnCTOHvfZ1puBBHc6PGDAgyuWNmK6
         A47Q==
X-Gm-Message-State: AOJu0YzIImZccAY2Q9lq1OiXThM1sSH5AfiskMeYnQFRZjgR5JRh2FYS
	NjG8/QL4btvkm8nVkNV4cE15qAYSTFOHT/fBozGKs1FW/fdaUOi5op8auqxKV2NGRPhE67q9gr8
	N
X-Google-Smtp-Source: AGHT+IEFFPEt3QCtOj+C7dd9LMiMN+A9FA4BMmyFOCZNxBkZoZGt8HdAu7kdDycya+zqscsV3jLJBA==
X-Received: by 2002:adf:e742:0:b0:33d:3e02:a5b0 with SMTP id c2-20020adfe742000000b0033d3e02a5b0mr5350543wrn.11.1708696108514;
        Fri, 23 Feb 2024 05:48:28 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d6941000000b0033d8aeb229csm2837226wrw.27.2024.02.23.05.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:48:28 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v7] sched/fair: Check a task has a fitting cpu when updating misfit
Date: Fri, 23 Feb 2024 13:48:25 +0000
Message-Id: <20240223134825.2852766-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zdhlt9GZe502wpPy@vingu-book>
References: <Zdhlt9GZe502wpPy@vingu-book>
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

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h |  1 +
 init/init_task.c      |  1 +
 kernel/sched/fair.c   | 64 +++++++++++++++++++++++++++++++++----------
 3 files changed, 51 insertions(+), 15 deletions(-)

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
index 8e30e2bb77a0..593e85f90a36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5092,15 +5092,19 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
+	int cpu = cpu_of(rq);
+
 	if (!sched_asym_cpucap_active())
 		return;
 
-	if (!p || p->nr_cpus_allowed == 1) {
-		rq->misfit_task_load = 0;
-		return;
-	}
+	/*
+	 * Affinity allows us to go somewhere higher?  Or are we on biggest
+	 * available CPU already? Or do we fit into this CPU ?
+	 */
+	if (!p || (p->nr_cpus_allowed == 1) ||
+	    (arch_scale_cpu_capacity(cpu) == p->max_allowed_capacity) ||
+	    task_fits_cpu(p, cpu)) {
 
-	if (task_fits_cpu(p, cpu_of(rq))) {
 		rq->misfit_task_load = 0;
 		return;
 	}
@@ -8241,6 +8245,36 @@ static void task_dead_fair(struct task_struct *p)
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
@@ -8249,6 +8283,8 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return newidle_balance(rq, rf) != 0;
 }
+#else
+static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 #endif /* CONFIG_SMP */
 
 static void set_next_buddy(struct sched_entity *se)
@@ -9601,16 +9637,10 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
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
@@ -12645,6 +12675,8 @@ static void task_fork_fair(struct task_struct *p)
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 
+	set_task_max_allowed_capacity(p);
+
 	cfs_rq = task_cfs_rq(current);
 	curr = cfs_rq->curr;
 	if (curr)
@@ -12768,6 +12800,8 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
 	attach_task_cfs_rq(p);
 
+	set_task_max_allowed_capacity(p);
+
 	if (task_on_rq_queued(p)) {
 		/*
 		 * We were most likely switched from sched_rt, so
@@ -13139,7 +13173,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.rq_offline		= rq_offline_fair,
 
 	.task_dead		= task_dead_fair,
-	.set_cpus_allowed	= set_cpus_allowed_common,
+	.set_cpus_allowed	= set_cpus_allowed_fair,
 #endif
 
 	.task_tick		= task_tick_fair,
-- 
2.34.1


