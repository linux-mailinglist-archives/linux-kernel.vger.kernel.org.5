Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F8078FDF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348970AbjIAND0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjIANDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:03:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724A9E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:03:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1605456f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693573399; x=1694178199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XGN82il/1YBgFB1xd1FuzsdVFxN2VHyBDMO8DeBOOo=;
        b=nNqDXUqClQHvapuHdw3Gjfoyglv76AC9Lc6rrn940rgKTsmlXnnJEmEnAjUSw6bUou
         DNAKrDN3q5GlX1cGvqCzGRdQwvTyWyhF1FCPcliBuTrJGCRfT6jssXEPtooBROetF+Lv
         ItsGObdPc4hkAU7bmUzqPoAE4grR0OBCAnijEQQ722+k5rrq8StdBG6GxUdIXh6ZlK90
         9rZAnpM4Yw/fevUyrFTz7h9NeTULpn3bvIenEtN1OizEN/GWXVSySlYIkuh6nPC8c9AQ
         xedsOtRm/MDJI/uUlLZmymtFajzcNWUOBrDePFXMTD6Cl1MVWsSPGJM7Uj/MI2KodxVP
         EpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573399; x=1694178199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XGN82il/1YBgFB1xd1FuzsdVFxN2VHyBDMO8DeBOOo=;
        b=U23df+giEcO1rnhCyhBnRn1dScSI1nHSOV+pfC50YQWtC9yxDArqJWE3KHdd/+YPs6
         RdXlTqt35mcpt+lVqVwwjoaB7P7CXJNUtHQRECbEBj/PwVXCoA5mFVNFzEN/faYB16Xg
         vxx1kEeCrr75dpH0+mr3dxndLwBoBrIB6si10UAndoAhYkNSEJB0s6e4h52UakhHQT96
         gowSNPWwdQQ+P7SMjmXTvo3bWIrTqxd8lJ5a6eHAZvUrte0VuT8hhAb6Bu6N2IRjg6mC
         JcMKO6pwzjl29uQW+aa4W1akE2wBjHibHuzNq3RR/ZM0jWTQUrsb+qhK4ygU40snhpDV
         pYbA==
X-Gm-Message-State: AOJu0YzNSL73sG/9+ovTJjnuR9KdKbA4yNfEhccrT9IWvnyyqawfRMp1
        R7cMeTiHcQPh6/hvKiyMrJtfdQ==
X-Google-Smtp-Source: AGHT+IERLKj3sQli7kquAJo1LxhyV8dn8e2ozcL/AJpoVa8ta4GyQxSWCkp906EBGCj0hP1nYCxKOQ==
X-Received: by 2002:adf:f282:0:b0:317:5d3d:c9df with SMTP id k2-20020adff282000000b003175d3dc9dfmr1892285wro.18.1693573397559;
        Fri, 01 Sep 2023 06:03:17 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:e9bd:add1:d9ac:7b3e])
        by smtp.gmail.com with ESMTPSA id i14-20020adfdece000000b003142e438e8csm5167452wrn.26.2023.09.01.06.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:03:16 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/4] sched: consolidate and cleanup access to CPU's max compute capacity
Date:   Fri,  1 Sep 2023 15:03:09 +0200
Message-Id: <20230901130312.247719-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901130312.247719-1-vincent.guittot@linaro.org>
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
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

Remove struct rq cpu_capacity_orig field and use arch_scale_cpu_capacity()
instead.

Scheduler uses 3 methods to get access to the CPU's max compute capacity:
- arch_scale_cpu_capacity(cpu) which is the default way to get CPU's capacity.
- cpu_capacity_orig field which is periodically updated with
  arch_scale_cpu_capacity().
- capacity_orig_of(cpu) which encapsulates rq->cpu_capacity_orig

There is no real need to save the value returned by arch_scale_cpu_capacity()
in struct rq. arch_scale_cpu_capacity() returns:
- either a per_cpu variable.
- or a const value for systems which have only one capacity.

Remove cpu_capacity_orig and use arch_scale_cpu_capacity() everywhere.

No functional changes.

some tests of Arm64:
small SMP device (hikey): no noticeable changes
HMP device (RB5): hackbench shows minor improvement (1-2%)
large smp (thx2): hackbench and tbench shows minor improvement (1%)

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c        |  2 +-
 kernel/sched/cpudeadline.c |  2 +-
 kernel/sched/deadline.c    |  4 ++--
 kernel/sched/fair.c        | 18 ++++++++----------
 kernel/sched/rt.c          |  2 +-
 kernel/sched/sched.h       |  6 ------
 kernel/sched/topology.c    |  7 +++++--
 7 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index efe3848978a0..6560392f2f83 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10014,7 +10014,7 @@ void __init sched_init(void)
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
index 58b542bf2893..c57ef2e0db41 100644
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
index 0b7445cd5af9..06d6d0dde48a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4690,7 +4690,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * To avoid overestimation of actual task utilization, skip updates if
 	 * we cannot grant there is idle time in this CPU.
 	 */
-	if (task_util(p) > capacity_orig_of(cpu_of(rq_of(cfs_rq))))
+	if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
 		return;
 
 	/*
@@ -4738,14 +4738,14 @@ static inline int util_fits_cpu(unsigned long util,
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
@@ -4757,7 +4757,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * For uclamp_max, we can tolerate a drop in performance level as the
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 */
-	capacity_orig = capacity_orig_of(cpu);
+	capacity_orig = arch_scale_cpu_capacity(cpu);
 	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
@@ -7226,7 +7226,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		 * Look for the CPU with best capacity.
 		 */
 		else if (fits < 0)
-			cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
+			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
 
 		/*
 		 * First, select CPU which fits better (-1 being better than 0).
@@ -7468,7 +7468,7 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 		util = max(util, util_est);
 	}
 
-	return min(util, capacity_orig_of(cpu));
+	return min(util, arch_scale_cpu_capacity(cpu));
 }
 
 unsigned long cpu_util_cfs(int cpu)
@@ -9251,8 +9251,6 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
 
-	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
-
 	if (!capacity)
 		capacity = 1;
 
@@ -9328,7 +9326,7 @@ static inline int
 check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 {
 	return ((rq->cpu_capacity * sd->imbalance_pct) <
-				(rq->cpu_capacity_orig * 100));
+				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
 }
 
 /*
@@ -9339,7 +9337,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
 {
 	return rq->misfit_task_load &&
-		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
+		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
 		 check_cpu_capacity(rq, sd));
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0597ba0f85ff..8f4e8db6e234 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -515,7 +515,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 	min_cap = uclamp_eff_value(p, UCLAMP_MIN);
 	max_cap = uclamp_eff_value(p, UCLAMP_MAX);
 
-	cpu_cap = capacity_orig_of(cpu);
+	cpu_cap = arch_scale_cpu_capacity(cpu);
 
 	return cpu_cap >= min(min_cap, max_cap);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3a01b7a2bf66..17ae151e90c0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1048,7 +1048,6 @@ struct rq {
 	struct sched_domain __rcu	*sd;
 
 	unsigned long		cpu_capacity;
-	unsigned long		cpu_capacity_orig;
 
 	struct balance_callback *balance_callback;
 
@@ -2974,11 +2973,6 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
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
index 05a5bc678c08..e6b0b6a8e60a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2479,12 +2479,15 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
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

