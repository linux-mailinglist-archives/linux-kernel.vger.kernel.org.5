Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE357BD8BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbjJIKge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbjJIKga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:36:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E629D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:36:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3296a998234so2517865f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696847787; x=1697452587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re7b+0McMMJs79AIsRmZVXLCw9N+5e5Qqk3aklm3ETc=;
        b=kmsDUtAsrjuA2Wdc3hsWu2yZ/c5ilHfeqWH+Uuy+u4uj5O8kL9oPPTgZY1WcBjFw00
         2rUWYUsebVOmdH72oqY/vP81dvhWhiUfXh6lx45D1eZclu88SolVvC3xPlKMhiL4KxUL
         OsoXCXNSp2WTNhwCszD/iWRBsRZfzua0Xb6RpVUpMIjjE9HYaaqfL9WRUU7dMOyDe4sH
         vkT7+eHAg0DNZ11O6t3qkkbDkYcrT/s7n6EdvchnMJXVUeqWblDWx7NE2ATUrcMeoPGL
         /9dQCqKGrKIeiqxQDcC1RWTBjHngA05H9WfR8uqH5iM6z7/sFuRxb5Eg7pIC3oKUji5I
         SI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847787; x=1697452587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re7b+0McMMJs79AIsRmZVXLCw9N+5e5Qqk3aklm3ETc=;
        b=apk2+i6zWJP/SRTykMZ21amPIzTTL4m6mQ6AMXsGNsYDYTv+uj+/EatZ9X9GywGSxH
         vKrERWB7wK07M2ELe5RMiUM0o6cuiFMtIpyLryjcVgeMjH2OfezsM+Vi6kHSKnVMb5Sv
         p+QppYpAoxtenI6AYDWh0vOoGMHqMUERHB9hAuU8pcRFWKwFe0h+YNbJvT3q9bC8diEF
         oV9HRhUIAt2yoUw3lfwyabB9kwe/BQcIW/DTHX+4dqZ0RvbMuqeIkSlqU0HzVCMdcWQ5
         H4dUJkbmykuNb+k0eMxE0zi4DKyfO3rvcixneNm5ckJ2bejYOIjhHxptuxX7Qf8cl37h
         yq/w==
X-Gm-Message-State: AOJu0YzNyLJvjLhBasgm95F2glwPInD0eebDfrtxqJUqbLGKERztczTn
        WF6m634gNX7HhDWp+LXjivpTOI5+JMmxVFbt+ac=
X-Google-Smtp-Source: AGHT+IEjQw3F2QpiyYMDHKQ0Ydoc0UsVzOGqUY2ht0reqHXmAAoEP6EJ50UQeRQWWBd0aG7tZrfNCQ==
X-Received: by 2002:adf:f505:0:b0:327:ffef:ba51 with SMTP id q5-20020adff505000000b00327ffefba51mr13155370wro.49.1696847786785;
        Mon, 09 Oct 2023 03:36:26 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:53f1:24bc:5e47:821d])
        by smtp.gmail.com with ESMTPSA id f16-20020adfdb50000000b0031ff89af0e4sm9226722wrj.99.2023.10.09.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:36:26 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 1/6] sched: consolidate and cleanup access to CPU's max compute capacity
Date:   Mon,  9 Oct 2023 12:36:16 +0200
Message-Id: <20231009103621.374412-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009103621.374412-1-vincent.guittot@linaro.org>
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove struct rq cpu_capacity_orig field and use arch_scale_cpu_capacity()
instead.

Scheduler uses 3 methods to get access to the CPU's max compute capacity:
- arch_scale_cpu_capacity(cpu) which is the default way to get CPU's capacity.
- cpu_capacity_orig field which is periodically updated with
  arch_scale_cpu_capacity().
- capacity_orig_of(cpu) which encapsulates rq->cpu_capacity_orig.

There is no real need to save the value returned by arch_scale_cpu_capacity()
in struct rq. arch_scale_cpu_capacity() returns:
- either a per_cpu variable.
- or a const value for systems which have only one capacity.

Remove cpu_capacity_orig and use arch_scale_cpu_capacity() everywhere.

No functional changes.

some tests of Arm64
small SMP device (hikey): no noticeable changes
HMP device (RB5): hackbench shows minor improvement (1-2%)
large smp (thx2): hackbench and tbench shows minor improvement (1%)

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

---
 Documentation/scheduler/sched-capacity.rst | 13 +++++++------
 kernel/sched/core.c                        |  2 +-
 kernel/sched/cpudeadline.c                 |  2 +-
 kernel/sched/deadline.c                    |  4 ++--
 kernel/sched/fair.c                        | 18 ++++++++----------
 kernel/sched/rt.c                          |  2 +-
 kernel/sched/sched.h                       |  6 ------
 kernel/sched/topology.c                    |  7 +++++--
 8 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index e2c1cf743158..de414b33dd2a 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -39,14 +39,15 @@ per Hz, leading to::
 -------------------
 
 Two different capacity values are used within the scheduler. A CPU's
-``capacity_orig`` is its maximum attainable capacity, i.e. its maximum
-attainable performance level. A CPU's ``capacity`` is its ``capacity_orig`` to
-which some loss of available performance (e.g. time spent handling IRQs) is
-subtracted.
+``original capacity`` is its maximum attainable capacity, i.e. its maximum
+attainable performance level. This original capacity is returned by
+the function arch_scale_cpu_capacity(). A CPU's ``capacity`` is its ``original
+capacity`` to which some loss of available performance (e.g. time spent
+handling IRQs) is subtracted.
 
 Note that a CPU's ``capacity`` is solely intended to be used by the CFS class,
-while ``capacity_orig`` is class-agnostic. The rest of this document will use
-the term ``capacity`` interchangeably with ``capacity_orig`` for the sake of
+while ``original capacity`` is class-agnostic. The rest of this document will use
+the term ``capacity`` interchangeably with ``original capacity`` for the sake of
 brevity.
 
 1.3 Platform examples
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf6d3fdd4eb5..a3f9cd52eec5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9929,7 +9929,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
 		rq->rd = NULL;
-		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
+		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
 		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 57c92d751bcd..95baa12a1029 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -131,7 +131,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 			if (!dl_task_fits_capacity(p, cpu)) {
 				cpumask_clear_cpu(cpu, later_mask);
 
-				cap = capacity_orig_of(cpu);
+				cap = arch_scale_cpu_capacity(cpu);
 
 				if (cap > max_cap ||
 				    (cpu == task_cpu(p) && cap == max_cap)) {
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d98408a274e5..7039a8d5ae9b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -132,7 +132,7 @@ static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
 	int i;
 
 	for_each_cpu_and(i, mask, cpu_active_mask)
-		cap += capacity_orig_of(i);
+		cap += arch_scale_cpu_capacity(i);
 
 	return cap;
 }
@@ -144,7 +144,7 @@ static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
 static inline unsigned long dl_bw_capacity(int i)
 {
 	if (!sched_asym_cpucap_active() &&
-	    capacity_orig_of(i) == SCHED_CAPACITY_SCALE) {
+	    arch_scale_cpu_capacity(i) == SCHED_CAPACITY_SCALE) {
 		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
 	} else {
 		RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fbcbda97d5..7e2027c810e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4713,7 +4713,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * To avoid overestimation of actual task utilization, skip updates if
 	 * we cannot grant there is idle time in this CPU.
 	 */
-	if (task_util(p) > capacity_orig_of(cpu_of(rq_of(cfs_rq))))
+	if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
 		return;
 
 	/*
@@ -4761,14 +4761,14 @@ static inline int util_fits_cpu(unsigned long util,
 		return fits;
 
 	/*
-	 * We must use capacity_orig_of() for comparing against uclamp_min and
+	 * We must use arch_scale_cpu_capacity() for comparing against uclamp_min and
 	 * uclamp_max. We only care about capacity pressure (by using
 	 * capacity_of()) for comparing against the real util.
 	 *
 	 * If a task is boosted to 1024 for example, we don't want a tiny
 	 * pressure to skew the check whether it fits a CPU or not.
 	 *
-	 * Similarly if a task is capped to capacity_orig_of(little_cpu), it
+	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
 	 * should fit a little cpu even if there's some pressure.
 	 *
 	 * Only exception is for thermal pressure since it has a direct impact
@@ -4780,7 +4780,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * For uclamp_max, we can tolerate a drop in performance level as the
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 */
-	capacity_orig = capacity_orig_of(cpu);
+	capacity_orig = arch_scale_cpu_capacity(cpu);
 	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
@@ -7261,7 +7261,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		 * Look for the CPU with best capacity.
 		 */
 		else if (fits < 0)
-			cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
+			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
 
 		/*
 		 * First, select CPU which fits better (-1 being better than 0).
@@ -7503,7 +7503,7 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 		util = max(util, util_est);
 	}
 
-	return min(util, capacity_orig_of(cpu));
+	return min(util, arch_scale_cpu_capacity(cpu));
 }
 
 unsigned long cpu_util_cfs(int cpu)
@@ -9294,8 +9294,6 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
 
-	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
-
 	if (!capacity)
 		capacity = 1;
 
@@ -9371,7 +9369,7 @@ static inline int
 check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 {
 	return ((rq->cpu_capacity * sd->imbalance_pct) <
-				(rq->cpu_capacity_orig * 100));
+				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
 }
 
 /*
@@ -9382,7 +9380,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
 {
 	return rq->misfit_task_load &&
-		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
+		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
 		 check_cpu_capacity(rq, sd));
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 88fc98601413..72f0a0767059 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -471,7 +471,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 	min_cap = uclamp_eff_value(p, UCLAMP_MIN);
 	max_cap = uclamp_eff_value(p, UCLAMP_MAX);
 
-	cpu_cap = capacity_orig_of(cpu);
+	cpu_cap = arch_scale_cpu_capacity(cpu);
 
 	return cpu_cap >= min(min_cap, max_cap);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 649eb9ec0657..74195eb39eaa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1033,7 +1033,6 @@ struct rq {
 	struct sched_domain __rcu	*sd;
 
 	unsigned long		cpu_capacity;
-	unsigned long		cpu_capacity_orig;
 
 	struct balance_callback *balance_callback;
 
@@ -2967,11 +2966,6 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_SMP
-static inline unsigned long capacity_orig_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_orig;
-}
-
 /**
  * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a7b50bba7829..1cc595907363 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2488,12 +2488,15 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	/* Attach the domains */
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
+		unsigned long capacity;
+
 		rq = cpu_rq(i);
 		sd = *per_cpu_ptr(d.sd, i);
 
+		capacity = arch_scale_cpu_capacity(i);
 		/* Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing: */
-		if (rq->cpu_capacity_orig > READ_ONCE(d.rd->max_cpu_capacity))
-			WRITE_ONCE(d.rd->max_cpu_capacity, rq->cpu_capacity_orig);
+		if (capacity > READ_ONCE(d.rd->max_cpu_capacity))
+			WRITE_ONCE(d.rd->max_cpu_capacity, capacity);
 
 		cpu_attach_domain(sd, d.rd, i);
 	}
-- 
2.34.1

