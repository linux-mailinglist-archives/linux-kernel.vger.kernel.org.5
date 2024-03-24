Return-Path: <linux-kernel+bounces-112532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D5887B3B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35A028259B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0133F7;
	Sun, 24 Mar 2024 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="z9a2vU0n"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA663B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711241180; cv=none; b=RFyOtOs69+zbIFwK8Eezikkv2JWUCkzfjMkOxxb38NtaMeltYmaqbES4VMXPhgcphtoYpWXwJaqFkCKwkudgYhzidxr3NmBs+gpOyj8EZ7kTIzqkm+e8+OPi4106rYXXFrFBzHxRnG7DyVmxZ+0NSVdERs6FzXFUBLHolXVkFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711241180; c=relaxed/simple;
	bh=fagvafmRW8bAsH4PlwGjJkpm+a8ityfbiaduDn++QaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djtutAOtba+7oJlIcPinTWBzh79TazhNSpYi4YjLAMInRatBPiyzOxlQrH/YpnNuTWVMYRnQtO1owyA8G95MqMsj6Y1Lg+ZvGvL50v0zBzBDtmejTatSJbcFPbYB2hv3mU2teJhUVGEJ2PKPLhJdR9jvAFTWTttrB0y/lYFIXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=z9a2vU0n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-414811d8241so3895995e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711241177; x=1711845977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxpj4P4M/KwhXcgLKvhRv6OYn6sM9Gs71BX39fQzMVY=;
        b=z9a2vU0nqm0lTF5a//AfOBYoxj9TSR4nmH09ZnCZECNWekfpzxR5OShVjJkjpBaiuu
         gf3MOCv3szcfmxweH3OccOtf/Os4Fj4RS6h6TYf5RfQYbSpQFIRYmvvska2ELAk0Ld6E
         cSpHVkCy3v0L+bhIN3IRDRRT0k2b5053XLE6k5wRjNgQMhdZVA7Z9Qi4cYwxcyKNO4nh
         098dTgTAwJvWWwSwtBhsUm93i6hhTxEsT8WUzUgIO0+d8jqEtekXY/72UjlHFgVrwY0N
         FoexWUOkEpD0J/8dj+uAi8PkZ1m05EMy4Wgjr6HUuts4cle5/tlU6/bnqnQ0bjDi+YVF
         DgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711241177; x=1711845977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxpj4P4M/KwhXcgLKvhRv6OYn6sM9Gs71BX39fQzMVY=;
        b=lruOG7pdp9B0fwaTKAquBXmS9PpMAKr2+/qQ5CshX1r+Guw5VP4wjv7sCU7xrmaIkw
         1ys11H5Kse1h834fwNLnB8xaw5PyTG/RXVRW2LcLngxVXKwRaaH6zzUhbvLZgg49r5he
         uwRi9M3JQeq/mBQvR7TlVfZtqQnMu2WlAvkHtm7/n+aY+K1blNZN078M6zgasq5od/o/
         XM+wIEMvuHuS9sbKowStF8UZMvqoWoKrR38EW0f8Oc+vz1HN6IuVPHkIvqSBkadB1csk
         NI8NBcNB1wf+AlQdOyczzGzCcF5EGW0Hj+JG4zDkrsfgowy+hV6nX7xSJXbR8umpF/Eb
         CbGg==
X-Gm-Message-State: AOJu0YwAB91dyN8kO+7e8qL0k29+9mlEa7TcgvGYwshC56OL5d4ffvil
	cJYF+kGmyZXMBZ+7q/Dw0jIVKvdAJDTvGyRE/QzMg0ZG2z+/lkk2q/T2re1FKQk=
X-Google-Smtp-Source: AGHT+IH2RobPfD8yX8gSuTNLW776CVT+XMomm7GaS5uOIbTqLVAz/wbTNVfGJnNan5dhUnV6plrdxw==
X-Received: by 2002:a05:600c:3ba8:b0:414:63c6:8665 with SMTP id n40-20020a05600c3ba800b0041463c68665mr2819002wms.2.1711241176860;
        Sat, 23 Mar 2024 17:46:16 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b00414674a1a40sm3778179wmq.45.2024.03.23.17.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 17:46:16 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v8 2/4] sched/fair: Check a task has a fitting cpu when updating misfit
Date: Sun, 24 Mar 2024 00:45:50 +0000
Message-Id: <20240324004552.999936-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324004552.999936-1-qyousef@layalina.io>
References: <20240324004552.999936-1-qyousef@layalina.io>
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
nohz_balancer_kick() already checks for cpu_check_capacity() before
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
 kernel/sched/fair.c   | 66 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7eb7f31af796..37b95dbdb4cb 100644
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
index 4daee6d761c8..2558b719e053 100644
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
index c8e50fbac345..3b88cf58fb45 100644
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
@@ -8247,6 +8251,36 @@ static void task_dead_fair(struct task_struct *p)
 	remove_entity_load_avg(&p->se);
 }
 
+/*
+ * Set the max capacity the task is allowed to run at for misfit detection.
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
@@ -8255,6 +8289,8 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return sched_balance_newidle(rq, rf) != 0;
 }
+#else
+static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 #endif /* CONFIG_SMP */
 
 static void set_next_buddy(struct sched_entity *se)
@@ -9604,16 +9640,10 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
 }
 
-/*
- * Check whether a rq has a misfit task and if it looks like we can actually
- * help that task: we can migrate the task to a CPU of higher capacity, or
- * the task's current CPU is heavily pressured.
- */
-static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
+/* Check if the rq has a misfit task */
+static inline bool check_misfit_status(struct rq *rq)
 {
-	return rq->misfit_task_load &&
-		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
-		 check_cpu_capacity(rq, sd));
+	return rq->misfit_task_load;
 }
 
 /*
@@ -11917,7 +11947,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
 		 * to run the misfit task on.
 		 */
-		if (check_misfit_status(rq, sd)) {
+		if (check_misfit_status(rq)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
@@ -12642,6 +12672,8 @@ static void task_fork_fair(struct task_struct *p)
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 
+	set_task_max_allowed_capacity(p);
+
 	cfs_rq = task_cfs_rq(current);
 	curr = cfs_rq->curr;
 	if (curr)
@@ -12765,6 +12797,8 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
 	attach_task_cfs_rq(p);
 
+	set_task_max_allowed_capacity(p);
+
 	if (task_on_rq_queued(p)) {
 		/*
 		 * We were most likely switched from sched_rt, so
@@ -13136,7 +13170,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.rq_offline		= rq_offline_fair,
 
 	.task_dead		= task_dead_fair,
-	.set_cpus_allowed	= set_cpus_allowed_common,
+	.set_cpus_allowed	= set_cpus_allowed_fair,
 #endif
 
 	.task_tick		= task_tick_fair,
-- 
2.34.1


