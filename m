Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D080EF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346588AbjLLO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376776AbjLLO1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:27:35 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CCFFD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c2308faedso59266565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702391259; x=1702996059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLQdXWxqcE8aKZEzrPx5c+qhH1Q+ID9rmLaxmd4LW08=;
        b=tIr6XE7Kpuulxq4kwOY2Y7uTlRkaF7omAUc3DTYTGsDcguIb8cGvvfJLs+9KNGsFlF
         FykmAkLSjNDfnO6h3j+M5oeX5GxHgovFfQueZc7y7HVIpfR01dcjoMhbpmwb7CP9RP1z
         rsGoxxKFa3BgdsUfJmpaUcTdgScH8WY4v4NKTFuH6vqB7w16G87pn/yD0w7STUVBAOw3
         uKdmT3Gr04a2m7kxHiRSsgVFCa9Ne8CcCvHZnYJjmCmMurAXSvJ1THtvmX2JmXxtNhtz
         lkmbUcGpTYm6JBrMECbD95f710z2gsplLtzdHBjEK+CqoYJ1Nxnx9mFKXjSP1Ilz+Gas
         5KNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391259; x=1702996059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLQdXWxqcE8aKZEzrPx5c+qhH1Q+ID9rmLaxmd4LW08=;
        b=pkQv5Jkz1cFRMiywSmdgYW93aQniQJcdDjc+VBd+3fazR7xr/YI/FDDJ6MQwy6fulm
         VKK+QD6Ul3FULAc2nKPDzQ3EBY1L+0otAv8aGfLllSWb2fkWAqTsZaMkkBa3UD0lLeqJ
         62D1Wc1QcwS8+9tmJZSTQQ9uSfKRgdHu5gHA6sXp96eLFJGzd+mxDq4FXAX47FNpOa+L
         0AEPyj0FV8OMUoLUjkrTLwVrc4/fTnkyQRRs23cdRwSmNPZv8/rVkq2rcxnHnmUAV4Wo
         DjxSAeBReXk0eFYN1MhnoSf3CPY2+CDNcx38rnHuaAiB2qbfEndvzPgSNUkOF2HQc3T+
         8Bfg==
X-Gm-Message-State: AOJu0YxvZ7dXXBqmNrYyzXohGS1RCrAX+/bBgBaFc4DFtp5Aeswi2pq+
        0ijaVTB3x1a/xWXP380ZVANtLw==
X-Google-Smtp-Source: AGHT+IHbqScGd7JjGKcWeC3RSyHp3cCEg8NG5/xmphu8ZwSRPr7mgum3HD3ooekcumPPTTr74rJr8w==
X-Received: by 2002:a05:600c:1827:b0:40c:3828:b8cb with SMTP id n39-20020a05600c182700b0040c3828b8cbmr2852611wmp.101.1702391259009;
        Tue, 12 Dec 2023 06:27:39 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a004:6e24:43ee:dd81])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm9078291wmb.46.2023.12.12.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:27:38 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/4] sched: Take cpufreq feedback into account
Date:   Tue, 12 Dec 2023 15:27:28 +0100
Message-Id: <20231212142730.998913-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212142730.998913-1-vincent.guittot@linaro.org>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aggregate the different pressures applied on the capacity of CPUs and
create a new function that returns the actual capacity of the CPU:
  get_actual_cpu_capacity()

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..11d3be829302 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4932,12 +4932,20 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
+static inline unsigned long get_actual_cpu_capacity(int cpu)
+{
+	unsigned long capacity = arch_scale_cpu_capacity(cpu);
+
+	capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
+
+	return capacity;
+}
 static inline int util_fits_cpu(unsigned long util,
 				unsigned long uclamp_min,
 				unsigned long uclamp_max,
 				int cpu)
 {
-	unsigned long capacity_orig, capacity_orig_thermal;
+	unsigned long capacity_orig;
 	unsigned long capacity = capacity_of(cpu);
 	bool fits, uclamp_max_fits;
 
@@ -4970,7 +4978,6 @@ static inline int util_fits_cpu(unsigned long util,
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 */
 	capacity_orig = arch_scale_cpu_capacity(cpu);
-	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -5045,7 +5052,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+	if (fits && (util < uclamp_min) && (uclamp_min > get_actual_cpu_capacity(cpu)))
 		return -1;
 
 	return fits;
@@ -7426,7 +7433,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		 * Look for the CPU with best capacity.
 		 */
 		else if (fits < 0)
-			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
+			cpu_cap = get_actual_cpu_capacity(cpu);
 
 		/*
 		 * First, select CPU which fits better (-1 being better than 0).
@@ -7919,8 +7926,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
 	int prev_fits = -1, best_fits = -1;
-	unsigned long best_thermal_cap = 0;
-	unsigned long prev_thermal_cap = 0;
+	unsigned long best_actual_cap = 0;
+	unsigned long prev_actual_cap = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -7950,7 +7957,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
-		unsigned long cpu_cap, cpu_thermal_cap, util;
+		unsigned long cpu_cap, cpu_actual_cap, util;
 		long prev_spare_cap = -1, max_spare_cap = -1;
 		unsigned long rq_util_min, rq_util_max;
 		unsigned long cur_delta, base_energy;
@@ -7962,18 +7969,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		if (cpumask_empty(cpus))
 			continue;
 
-		/* Account thermal pressure for the energy estimation */
+		/* Account external pressure for the energy estimation */
 		cpu = cpumask_first(cpus);
-		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
-		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
+		cpu_actual_cap = get_actual_cpu_capacity(cpu);
 
-		eenv.cpu_cap = cpu_thermal_cap;
+		eenv.cpu_cap = cpu_actual_cap;
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
 			struct rq *rq = cpu_rq(cpu);
 
-			eenv.pd_cap += cpu_thermal_cap;
+			eenv.pd_cap += cpu_actual_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 				continue;
@@ -8044,7 +8050,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (prev_delta < base_energy)
 				goto unlock;
 			prev_delta -= base_energy;
-			prev_thermal_cap = cpu_thermal_cap;
+			prev_actual_cap = cpu_actual_cap;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -8059,7 +8065,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * but best energy cpu has better capacity.
 			 */
 			if ((max_fits < 0) &&
-			    (cpu_thermal_cap <= best_thermal_cap))
+			    (cpu_actual_cap <= best_actual_cap))
 				continue;
 
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
@@ -8080,14 +8086,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			best_delta = cur_delta;
 			best_energy_cpu = max_spare_cap_cpu;
 			best_fits = max_fits;
-			best_thermal_cap = cpu_thermal_cap;
+			best_actual_cap = cpu_actual_cap;
 		}
 	}
 	rcu_read_unlock();
 
 	if ((best_fits > prev_fits) ||
 	    ((best_fits > 0) && (best_delta < prev_delta)) ||
-	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
+	    ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
 		target = best_energy_cpu;
 
 	return target;
@@ -9466,7 +9472,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(cpu);
+	unsigned long max = get_actual_cpu_capacity(cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -9478,12 +9484,9 @@ static unsigned long scale_rt_capacity(int cpu)
 	/*
 	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
 	 * (running and not running) with weights 0 and 1024 respectively.
-	 * avg_thermal.load_avg tracks thermal pressure and the weighted
-	 * average uses the actual delta max capacity(load).
 	 */
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
-	used += thermal_load_avg(rq);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.34.1

