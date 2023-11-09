Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD027E6792
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjKIKO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjKIKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:14:52 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700DF2D73
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:14:50 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c7420d5a83so4633231fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524889; x=1700129689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZHd4Q0/7Gj/HYpU63Kx8UoTWa/0lydYthjIniNUNCQ=;
        b=N5uDv07ImQLBw5fxm/msYLJ+xQaGauZUKIw/cPOycO6TKtzNrHV5G5kS5k15hQqVmM
         Un5Q8QVOGRdjKiXGO2cr2uIu3NrxDfbyZG/t0PfLnHrdo6GsOR6aG+bCWN7yvrz+bnee
         taNuZ+1QEEujvmuhG+T0OsGLRrV/rj86DPlx3IhRdkGGnXDcfb3cUAUfc/3dgXmlSG6i
         QqmLXjvA7zj6ifG3DiXF8fDYtpMbwAO/JrgA5aMjaWYh7xTuC9G+wxVJaK/pMBvMCtoU
         60Ck4BVxjH5uNVPxqfJX0jsWKDw0rx8KneR2V0tGf2ClWfiu5KsQw1y6T0vd4CUiY/hi
         xddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524889; x=1700129689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZHd4Q0/7Gj/HYpU63Kx8UoTWa/0lydYthjIniNUNCQ=;
        b=ghe5EGmf8kcuWZlIjwzgdZaH0W1l+7GenfYerL6PE2/wn6vkXWhwz5ImzqVAEEyDs0
         QuEE5uMxCbgavyxy9T9IzFvEcICYZ0V7rSnA4A/0GrpxID54KzVVjz+YfBX7YvVAms7Y
         ws0QtZ/KweWn4zGMBT66LV5oTAd79iY8beuRuxDH6taK+QY7I2f+HCoCX9A9MsaGbXfq
         16oGJoH1Zyxxs44d72vnUwmgrEK4jDD24EZwY467VIT/2o9r577iZ4Znkcn+gtZvrNTu
         tlPapqvD1B9JYWmKb9RIeWcR8i1iDf3LYRqfOSsZQELI4HUYysCYCoLpytIxRTrsX7YU
         VJEg==
X-Gm-Message-State: AOJu0Yx/pvM3DUcXsuvM8Gc9XupRnhnb0rrKzjbbkB85rvrwg0FmlYnx
        CtCsnJYQC/9nlcNBH+CtZ/RPdA==
X-Google-Smtp-Source: AGHT+IFzSGT/2ARlAkyBpCbVthGu2S6+dkq+V3FmAfhv1iZuIGqmYIvAERnuPKPypzZ1uKKlA6pX/w==
X-Received: by 2002:a05:6512:36d3:b0:500:b553:c09e with SMTP id e19-20020a05651236d300b00500b553c09emr864687lfs.32.1699524888525;
        Thu, 09 Nov 2023 02:14:48 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:48 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, beata.michalska@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 1/7] topology: Add a new arch_scale_freq_reference
Date:   Thu,  9 Nov 2023 11:14:32 +0100
Message-Id: <20231109101438.1139696-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109101438.1139696-1-vincent.guittot@linaro.org>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new method to get a unique and fixed max frequency. Currently
cpuinfo.max_freq or the highest (or last) state of performance domain are
used as the max frequency when computing the frequency for a level of
utilization but:
- cpuinfo_max_freq can change at runtime. boost is one example of
  such change.
- cpuinfo.max_freq and last item of the PD can be different leading to
  different results between cpufreq and energy model.

We need to save the reference frequency that has been used when computing
the CPUs capacity and use this fixed and coherent value to convert between
frequency and CPU's capacity.

In fact, we already save the frequency that has been used when computing
the capacity of each CPU. We extend the precision to save kHz instead of
MHz currently and we modify the type to be aligned with other variables
used when converting frequency to capacity and the other way.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 arch/riscv/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      | 29 ++++++++++++++---------------
 include/linux/arch_topology.h     |  7 +++++++
 include/linux/sched/topology.h    |  8 ++++++++
 6 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index c7d2510e5a78..853c4f81ba4a 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -13,6 +13,7 @@
 #define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
+#define arch_scale_freq_ref topology_get_freq_ref
 #endif
 
 /* Replace task scheduler's default cpu-invariant accounting */
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 9fab663dd2de..a323b109b9c4 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -23,6 +23,7 @@ void update_freq_counters_refs(void);
 #define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
+#define arch_scale_freq_ref topology_get_freq_ref
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 #define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
index e316ab3b77f3..61183688bdd5 100644
--- a/arch/riscv/include/asm/topology.h
+++ b/arch/riscv/include/asm/topology.h
@@ -9,6 +9,7 @@
 #define arch_set_freq_scale		topology_set_freq_scale
 #define arch_scale_freq_capacity	topology_get_freq_scale
 #define arch_scale_freq_invariant	topology_scale_freq_invariant
+#define arch_scale_freq_ref		topology_get_freq_ref
 
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity	topology_get_cpu_scale
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b741b5ba82bd..e8d1cdf1f761 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/units.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/thermal_pressure.h>
@@ -26,7 +27,8 @@
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
-static DEFINE_PER_CPU(u32, freq_factor) = 1;
+DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
+EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
 {
@@ -170,9 +172,9 @@ DEFINE_PER_CPU(unsigned long, thermal_pressure);
  * operating on stale data when hot-plug is used for some CPUs. The
  * @capped_freq reflects the currently allowed max CPUs frequency due to
  * thermal capping. It might be also a boost frequency value, which is bigger
- * than the internal 'freq_factor' max frequency. In such case the pressure
- * value should simply be removed, since this is an indication that there is
- * no thermal throttling. The @capped_freq must be provided in kHz.
+ * than the internal 'capacity_freq_ref' max frequency. In such case the
+ * pressure value should simply be removed, since this is an indication that
+ * there is no thermal throttling. The @capped_freq must be provided in kHz.
  */
 void topology_update_thermal_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq)
@@ -183,10 +185,7 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 
 	cpu = cpumask_first(cpus);
 	max_capacity = arch_scale_cpu_capacity(cpu);
-	max_freq = per_cpu(freq_factor, cpu);
-
-	/* Convert to MHz scale which is used in 'freq_factor' */
-	capped_freq /= 1000;
+	max_freq = arch_scale_freq_ref(cpu);
 
 	/*
 	 * Handle properly the boost frequencies, which should simply clean
@@ -279,13 +278,13 @@ void topology_normalize_cpu_scale(void)
 
 	capacity_scale = 1;
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
 		capacity_scale = max(capacity, capacity_scale);
 	}
 
 	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 			capacity_scale);
 		topology_set_cpu_scale(cpu, capacity);
@@ -321,15 +320,15 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			cpu_node, raw_capacity[cpu]);
 
 		/*
-		 * Update freq_factor for calculating early boot cpu capacities.
+		 * Update capacity_freq_ref for calculating early boot cpu capacities.
 		 * For non-clk CPU DVFS mechanism, there's no way to get the
 		 * frequency value now, assuming they are running at the same
-		 * frequency (by keeping the initial freq_factor value).
+		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
 		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
-			per_cpu(freq_factor, cpu) =
-				clk_get_rate(cpu_clk) / 1000;
+			per_cpu(capacity_freq_ref, cpu) =
+				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);
 		}
 	} else {
@@ -411,7 +410,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus)
-		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
+		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a07b510e7dc5..32c24ff4f2a8 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
+DECLARE_PER_CPU(unsigned long, capacity_freq_ref);
+
+static inline unsigned long topology_get_freq_ref(int cpu)
+{
+	return per_cpu(capacity_freq_ref, cpu);
+}
+
 DECLARE_PER_CPU(unsigned long, arch_freq_scale);
 
 static inline unsigned long topology_get_freq_scale(int cpu)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index de545ba85218..a6e04b4a21d7 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -279,6 +279,14 @@ void arch_update_thermal_pressure(const struct cpumask *cpus,
 { }
 #endif
 
+#ifndef arch_scale_freq_ref
+static __always_inline
+unsigned int arch_scale_freq_ref(int cpu)
+{
+	return 0;
+}
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
-- 
2.34.1

