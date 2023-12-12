Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AECB80EEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376591AbjLLO1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376799AbjLLO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:27:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4827DF2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c317723a8so47875675e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702391263; x=1702996063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsjgZ0JvZ8GCTDV26oBHnpMmwL1Wngf7WqLuUrOgCDA=;
        b=HLH7yBAbIPnc9NdDk4JcN9/kHcPLx6WOeANY328ZSHc69d+nHOmUT3AXQkSpY49h5w
         wgv497rMbN3DBUfu54bJqNTd8vbPjUT7KAeNJDkQsBuA1LtVOn/ePiFL+vS3qCgwg4B4
         tO5+2ze3nx0gE1zpkWQ9exzSYASeydLKrFx3mWsXne+454Q2bbbNo0LufBjP2GGTUDqE
         Lo4A5tEgR7LOoC+9ndRtD8ZlVNdleerj78ZSCtp0dToBF3SxmXdnsmSxkEMc2G9UZgNS
         QPmkOUoPSNbfGLbwdp+Z9CrLyXcoQIKNhcrHddwBZKyzOxIsgkZOigOpaGJicdQBwnCC
         /13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391263; x=1702996063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsjgZ0JvZ8GCTDV26oBHnpMmwL1Wngf7WqLuUrOgCDA=;
        b=nNR+4X7nrrqL1J/wl9raXlAR4QKjdUXrJjfu/sBjdnhBX6eArFjm3zTpLieafdR/9I
         rpC/MSQqcTlGADD45cHbxcYQ1n7PqODww/SX1EI3ecimtJxBy3IBTinSRzhmYcTRKnmx
         Jc6NypiwkGwHOtHmeDaX30akFhTmSdO69WDxMlHyAz1DbloMkorwd+kHoi1rR96j++VB
         /GzDWaWey1OlwtKla32FwJgPUfDhy0XzlU4rOJbLWozjnAtj+nHAut8S0a2rz/RoxcwR
         FwYF5am0Z+EGghuk8wbq6WCSozJpFyOLdrasrS1h6A2AvqKb9BTXPRyFegpsnLvD/54k
         u/0Q==
X-Gm-Message-State: AOJu0YzcNb23wtTM2S6ijT0e4eqUbM9dFzMsfeKZzasZD9rAYWi2VSon
        lhzSkkPd1iRkAy2BcHvUh73OqQ==
X-Google-Smtp-Source: AGHT+IEo88jh9qZzPOPKVsJ6GoVR9cmsillDCsffTZCEreD9WMVfvAWva+toRAdY6Grhz4nFuaVcNA==
X-Received: by 2002:a1c:4b05:0:b0:40c:2dd8:3a18 with SMTP id y5-20020a1c4b05000000b0040c2dd83a18mr2744182wma.6.1702391262602;
        Tue, 12 Dec 2023 06:27:42 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a004:6e24:43ee:dd81])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm9078291wmb.46.2023.12.12.06.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:27:41 -0800 (PST)
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
Subject: [PATCH 4/4] sched: Rename arch_update_thermal_pressure into arch_update_hw_pressure
Date:   Tue, 12 Dec 2023 15:27:30 +0100
Message-Id: <20231212142730.998913-5-vincent.guittot@linaro.org>
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

Now that cpufreq provides a pressure value to the scheduler, rename
arch_update_thermal_pressure into hw pressure to reflect that it returns
a pressure applied by HW with a high frequency and which needs filtering.
This pressure is not always related to thermal mitigation but can also be
generated by max current limitation as an example.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/include/asm/topology.h               |  6 ++---
 arch/arm64/include/asm/topology.h             |  6 ++---
 drivers/base/arch_topology.c                  | 26 +++++++++----------
 drivers/cpufreq/qcom-cpufreq-hw.c             |  4 +--
 include/linux/arch_topology.h                 |  8 +++---
 include/linux/sched/topology.h                |  8 +++---
 .../{thermal_pressure.h => hw_pressure.h}     | 14 +++++-----
 include/trace/events/sched.h                  |  2 +-
 init/Kconfig                                  | 12 ++++-----
 kernel/sched/core.c                           |  8 +++---
 kernel/sched/fair.c                           | 12 ++++-----
 kernel/sched/pelt.c                           | 18 ++++++-------
 kernel/sched/pelt.h                           | 16 ++++++------
 kernel/sched/sched.h                          |  4 +--
 14 files changed, 72 insertions(+), 72 deletions(-)
 rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 853c4f81ba4a..e175e8596b5d 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -22,9 +22,9 @@
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
-/* Replace task scheduler's default thermal pressure API */
-#define arch_scale_thermal_pressure topology_get_thermal_pressure
-#define arch_update_thermal_pressure	topology_update_thermal_pressure
+/* Replace task scheduler's default hw pressure API */
+#define arch_scale_hw_pressure topology_get_hw_pressure
+#define arch_update_hw_pressure	topology_update_hw_pressure
 
 #else
 
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index a323b109b9c4..a427650bdfba 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -35,9 +35,9 @@ void update_freq_counters_refs(void);
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
-/* Replace task scheduler's default thermal pressure API */
-#define arch_scale_thermal_pressure topology_get_thermal_pressure
-#define arch_update_thermal_pressure	topology_update_thermal_pressure
+/* Replace task scheduler's default hw pressure API */
+#define arch_scale_hw_pressure topology_get_hw_pressure
+#define arch_update_hw_pressure	topology_update_hw_pressure
 
 #include <asm-generic/topology.h>
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0906114963ff..3d8dc9d5c3ad 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -22,7 +22,7 @@
 #include <linux/units.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/thermal_pressure.h>
+#include <trace/events/hw_pressure.h>
 
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
@@ -160,26 +160,26 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
-DEFINE_PER_CPU(unsigned long, thermal_pressure);
+DEFINE_PER_CPU(unsigned long, hw_pressure);
 
 /**
- * topology_update_thermal_pressure() - Update thermal pressure for CPUs
+ * topology_update_hw_pressure() - Update hw pressure for CPUs
  * @cpus        : The related CPUs for which capacity has been reduced
  * @capped_freq : The maximum allowed frequency that CPUs can run at
  *
- * Update the value of thermal pressure for all @cpus in the mask. The
+ * Update the value of hw pressure for all @cpus in the mask. The
  * cpumask should include all (online+offline) affected CPUs, to avoid
  * operating on stale data when hot-plug is used for some CPUs. The
  * @capped_freq reflects the currently allowed max CPUs frequency due to
- * thermal capping. It might be also a boost frequency value, which is bigger
+ * hw capping. It might be also a boost frequency value, which is bigger
  * than the internal 'capacity_freq_ref' max frequency. In such case the
  * pressure value should simply be removed, since this is an indication that
- * there is no thermal throttling. The @capped_freq must be provided in kHz.
+ * there is no hw throttling. The @capped_freq must be provided in kHz.
  */
-void topology_update_thermal_pressure(const struct cpumask *cpus,
+void topology_update_hw_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq)
 {
-	unsigned long max_capacity, capacity, th_pressure;
+	unsigned long max_capacity, capacity, hw_pressure;
 	u32 max_freq;
 	int cpu;
 
@@ -189,21 +189,21 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 
 	/*
 	 * Handle properly the boost frequencies, which should simply clean
-	 * the thermal pressure value.
+	 * the hw pressure value.
 	 */
 	if (max_freq <= capped_freq)
 		capacity = max_capacity;
 	else
 		capacity = mult_frac(max_capacity, capped_freq, max_freq);
 
-	th_pressure = max_capacity - capacity;
+	hw_pressure = max_capacity - capacity;
 
-	trace_thermal_pressure_update(cpu, th_pressure);
+	trace_hw_pressure_update(cpu, hw_pressure);
 
 	for_each_cpu(cpu, cpus)
-		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
+		WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
 }
-EXPORT_SYMBOL_GPL(topology_update_thermal_pressure);
+EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
 
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 70b0f21968a0..a619202ba81d 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -347,8 +347,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 
 	throttled_freq = freq_hz / HZ_PER_KHZ;
 
-	/* Update thermal pressure (the boost frequencies are accepted) */
-	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
+	/* Update hw pressure (the boost frequencies are accepted) */
+	arch_update_hw_pressure(policy->related_cpus, throttled_freq);
 
 	/*
 	 * In the unlikely case policy is unregistered do not enable
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a63d61ca55af..b721f360d759 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -60,14 +60,14 @@ void topology_scale_freq_tick(void);
 void topology_set_scale_freq_source(struct scale_freq_data *data, const struct cpumask *cpus);
 void topology_clear_scale_freq_source(enum scale_freq_source source, const struct cpumask *cpus);
 
-DECLARE_PER_CPU(unsigned long, thermal_pressure);
+DECLARE_PER_CPU(unsigned long, hw_pressure);
 
-static inline unsigned long topology_get_thermal_pressure(int cpu)
+static inline unsigned long topology_get_hw_pressure(int cpu)
 {
-	return per_cpu(thermal_pressure, cpu);
+	return per_cpu(hw_pressure, cpu);
 }
 
-void topology_update_thermal_pressure(const struct cpumask *cpus,
+void topology_update_hw_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq);
 
 struct cpu_topology {
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index a6e04b4a21d7..e3b2cf7de018 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -264,17 +264,17 @@ unsigned long arch_scale_cpu_capacity(int cpu)
 }
 #endif
 
-#ifndef arch_scale_thermal_pressure
+#ifndef arch_scale_hw_pressure
 static __always_inline
-unsigned long arch_scale_thermal_pressure(int cpu)
+unsigned long arch_scale_hw_pressure(int cpu)
 {
 	return 0;
 }
 #endif
 
-#ifndef arch_update_thermal_pressure
+#ifndef arch_update_hw_pressure
 static __always_inline
-void arch_update_thermal_pressure(const struct cpumask *cpus,
+void arch_update_hw_pressure(const struct cpumask *cpus,
 				  unsigned long capped_frequency)
 { }
 #endif
diff --git a/include/trace/events/thermal_pressure.h b/include/trace/events/hw_pressure.h
similarity index 55%
rename from include/trace/events/thermal_pressure.h
rename to include/trace/events/hw_pressure.h
index b68680201360..b9cd68854128 100644
--- a/include/trace/events/thermal_pressure.h
+++ b/include/trace/events/hw_pressure.h
@@ -1,27 +1,27 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM thermal_pressure
+#define TRACE_SYSTEM hw_pressure
 
 #if !defined(_TRACE_THERMAL_PRESSURE_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_THERMAL_PRESSURE_H
 
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(thermal_pressure_update,
-	TP_PROTO(int cpu, unsigned long thermal_pressure),
-	TP_ARGS(cpu, thermal_pressure),
+TRACE_EVENT(hw_pressure_update,
+	TP_PROTO(int cpu, unsigned long hw_pressure),
+	TP_ARGS(cpu, hw_pressure),
 
 	TP_STRUCT__entry(
-		__field(unsigned long, thermal_pressure)
+		__field(unsigned long, hw_pressure)
 		__field(int, cpu)
 	),
 
 	TP_fast_assign(
-		__entry->thermal_pressure = thermal_pressure;
+		__entry->hw_pressure = hw_pressure;
 		__entry->cpu = cpu;
 	),
 
-	TP_printk("cpu=%d thermal_pressure=%lu", __entry->cpu, __entry->thermal_pressure)
+	TP_printk("cpu=%d hw_pressure=%lu", __entry->cpu, __entry->hw_pressure)
 );
 #endif /* _TRACE_THERMAL_PRESSURE_H */
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..d115d64c4011 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -752,7 +752,7 @@ DECLARE_TRACE(pelt_dl_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
-DECLARE_TRACE(pelt_thermal_tp,
+DECLARE_TRACE(pelt_hw_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
diff --git a/init/Kconfig b/init/Kconfig
index 9ffb103fc927..37ceeb67e01c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -538,24 +538,24 @@ config HAVE_SCHED_AVG_IRQ
 	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
 	depends on SMP
 
-config SCHED_THERMAL_PRESSURE
+config SCHED_HW_PRESSURE
 	bool
 	default y if ARM && ARM_CPU_TOPOLOGY
 	default y if ARM64
 	depends on SMP
 	depends on CPU_FREQ_THERMAL
 	help
-	  Select this option to enable thermal pressure accounting in the
-	  scheduler. Thermal pressure is the value conveyed to the scheduler
+	  Select this option to enable HW pressure accounting in the
+	  scheduler. HW pressure is the value conveyed to the scheduler
 	  that reflects the reduction in CPU compute capacity resulted from
-	  thermal throttling. Thermal throttling occurs when the performance of
-	  a CPU is capped due to high operating temperatures.
+	  HW throttling. HW throttling occurs when the performance of
+	  a CPU is capped due to high operating temperatures as an example.
 
 	  If selected, the scheduler will be able to balance tasks accordingly,
 	  i.e. put less load on throttled CPUs than on non/less throttled ones.
 
 	  This requires the architecture to implement
-	  arch_update_thermal_pressure() and arch_scale_thermal_pressure().
+	  arch_update_hw_pressure() and arch_scale_thermal_pressure().
 
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f..c68e47bfd5ae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -107,7 +107,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
-EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_hw_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
@@ -5658,7 +5658,7 @@ void scheduler_tick(void)
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
-	unsigned long thermal_pressure;
+	unsigned long hw_pressure;
 	u64 resched_latency;
 
 	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
@@ -5669,8 +5669,8 @@ void scheduler_tick(void)
 	rq_lock(rq, &rf);
 
 	update_rq_clock(rq);
-	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
-	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
+	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
+	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11d3be829302..07050955d6e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4936,7 +4936,7 @@ static inline unsigned long get_actual_cpu_capacity(int cpu)
 {
 	unsigned long capacity = arch_scale_cpu_capacity(cpu);
 
-	capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
+	capacity -= max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
 
 	return capacity;
 }
@@ -4968,7 +4968,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
 	 * should fit a little cpu even if there's some pressure.
 	 *
-	 * Only exception is for thermal pressure since it has a direct impact
+	 * Only exception is for hw or cpufreq pressure since it has a direct impact
 	 * on available OPP of the system.
 	 *
 	 * We honour it for uclamp_min only as a drop in performance level
@@ -9224,7 +9224,7 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
-	if (thermal_load_avg(rq))
+	if (hw_load_avg(rq))
 		return true;
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
@@ -9256,7 +9256,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 {
 	const struct sched_class *curr_class;
 	u64 now = rq_clock_pelt(rq);
-	unsigned long thermal_pressure;
+	unsigned long hw_pressure;
 	bool decayed;
 
 	/*
@@ -9265,11 +9265,11 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 */
 	curr_class = rq->curr->sched_class;
 
-	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
+	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
+		  update_hw_load_avg(now, rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 63b6cf898220..cd599a5185c4 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -384,30 +384,30 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
-#ifdef CONFIG_SCHED_THERMAL_PRESSURE
+#ifdef CONFIG_SCHED_HW_PRESSURE
 /*
- * thermal:
+ * hardware:
  *
  *   load_sum = \Sum se->avg.load_sum but se->avg.load_sum is not tracked
  *
  *   util_avg and runnable_load_avg are not supported and meaningless.
  *
  * Unlike rt/dl utilization tracking that track time spent by a cpu
- * running a rt/dl task through util_avg, the average thermal pressure is
- * tracked through load_avg. This is because thermal pressure signal is
+ * running a rt/dl task through util_avg, the average hw pressure is
+ * tracked through load_avg. This is because hw pressure signal is
  * time weighted "delta" capacity unlike util_avg which is binary.
  * "delta capacity" =  actual capacity  -
- *			capped capacity a cpu due to a thermal event.
+ *			capped capacity a cpu due to a hw event.
  */
 
-int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 {
-	if (___update_load_sum(now, &rq->avg_thermal,
+	if (___update_load_sum(now, &rq->avg_hw,
 			       capacity,
 			       capacity,
 			       capacity)) {
-		___update_load_avg(&rq->avg_thermal, 1);
-		trace_pelt_thermal_tp(rq);
+		___update_load_avg(&rq->avg_hw, 1);
+		trace_pelt_hw_tp(rq);
 		return 1;
 	}
 
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 3a0e0dc28721..e3ab44c4a2ef 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -7,21 +7,21 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
-#ifdef CONFIG_SCHED_THERMAL_PRESSURE
-int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
+#ifdef CONFIG_SCHED_HW_PRESSURE
+int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity);
 
-static inline u64 thermal_load_avg(struct rq *rq)
+static inline u64 hw_load_avg(struct rq *rq)
 {
-	return READ_ONCE(rq->avg_thermal.load_avg);
+	return READ_ONCE(rq->avg_hw.load_avg);
 }
 #else
 static inline int
-update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 {
 	return 0;
 }
 
-static inline u64 thermal_load_avg(struct rq *rq)
+static inline u64 hw_load_avg(struct rq *rq)
 {
 	return 0;
 }
@@ -202,12 +202,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 }
 
 static inline int
-update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 {
 	return 0;
 }
 
-static inline u64 thermal_load_avg(struct rq *rq)
+static inline u64 hw_load_avg(struct rq *rq)
 {
 	return 0;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..7eaf186d071e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1078,8 +1078,8 @@ struct rq {
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
-#ifdef CONFIG_SCHED_THERMAL_PRESSURE
-	struct sched_avg	avg_thermal;
+#ifdef CONFIG_SCHED_HW_PRESSURE
+	struct sched_avg	avg_hw;
 #endif
 	u64			idle_stamp;
 	u64			avg_idle;
-- 
2.34.1

