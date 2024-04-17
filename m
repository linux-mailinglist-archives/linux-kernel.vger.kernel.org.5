Return-Path: <linux-kernel+bounces-148260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA07C8A7FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B05B21DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAA913C3D5;
	Wed, 17 Apr 2024 09:39:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12113BC27
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346748; cv=none; b=F+FaCq9ZHqAe1nXr0ZUigc4hFXQRcmnPQHeVg534ZrTBj9i5YbeGCwqqhB7EolFVmXBdrOMwmiuAVqf98EcOoVaNpqTilt9dhwHWAQ18rnYv//08M4Z67nwAZCotiwlFrMAGADTLgvtgHlVJS30cuHyV9pWy1ORTjkkmprCF+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346748; c=relaxed/simple;
	bh=6Kf4TEq0xo+qbeDKaHo21g+8plqDAFb2M+va4OvXqcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EUh4VruzSt47uDbCKTjzmGE+B0yfzl+ZPoBfYKE02K7nyUIrvQC3Kx1OIy21gZYywugItqriG+pBXdns2Idmn+YTaJeYIbNAhK6Pd7/cc3RcWMSqtuy7xAdZFsDiSNSTQmARqEOrO2wOcehgxecICEFEzcmW5iCCOLYAiFUTOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47314339;
	Wed, 17 Apr 2024 02:39:34 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9881C3F64C;
	Wed, 17 Apr 2024 02:39:04 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com,
	vanshikonda@os.amperecomputing.com
Cc: sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	vincent.guittot@linaro.org,
	sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	lihuisong@huawei.com,
	viresh.kumar@linaro.org
Subject: [PATCH v5 3/5] arm64: Provide an AMU-based version of arch_freq_get_on_cpu
Date: Wed, 17 Apr 2024 10:38:46 +0100
Message-Id: <20240417093848.1555462-4-beata.michalska@arm.com>
In-Reply-To: <20240417093848.1555462-1-beata.michalska@arm.com>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the Frequency Invariance Engine (FIE) being already wired up with
sched tick and making use of relevant (core counter and constant
counter) AMU counters, getting the current frequency for a given CPU,
can be achieved by utilizing the frequency scale factor which reflects
an average CPU frequency for the last tick period length.

The solution is partially based on APERF/MPERF implementation of
arch_freq_get_on_cpu.

Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/kernel/topology.c | 110 +++++++++++++++++++++++++++++++----
 1 file changed, 100 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 3c814a278534..475fdbf3032a 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -17,6 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -88,18 +89,28 @@ int __init parse_acpi_topology(void)
  * initialized.
  */
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
-static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
-static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
 static cpumask_var_t amu_fie_cpus;
 
+struct amu_cntr_sample {
+	u64		arch_const_cycles_prev;
+	u64		arch_core_cycles_prev;
+	unsigned long	last_update;
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
+
 void update_freq_counters_refs(void)
 {
-	this_cpu_write(arch_core_cycles_prev, read_corecnt());
-	this_cpu_write(arch_const_cycles_prev, read_constcnt());
+	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
+
+	amu_sample->arch_core_cycles_prev = read_corecnt();
+	amu_sample->arch_const_cycles_prev = read_constcnt();
 }
 
 static inline bool freq_counters_valid(int cpu)
 {
+	struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
+
 	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
 		return false;
 
@@ -108,8 +119,8 @@ static inline bool freq_counters_valid(int cpu)
 		return false;
 	}
 
-	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
-		     !per_cpu(arch_core_cycles_prev, cpu))) {
+	if (unlikely(!amu_sample->arch_const_cycles_prev ||
+		     !amu_sample->arch_core_cycles_prev)) {
 		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
 		return false;
 	}
@@ -152,17 +163,22 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
 
 static void amu_scale_freq_tick(void)
 {
+	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
 	u64 prev_core_cnt, prev_const_cnt;
 	u64 core_cnt, const_cnt, scale;
 
-	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
-	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
+	prev_const_cnt = amu_sample->arch_const_cycles_prev;
+	prev_core_cnt = amu_sample->arch_core_cycles_prev;
 
 	update_freq_counters_refs();
 
-	const_cnt = this_cpu_read(arch_const_cycles_prev);
-	core_cnt = this_cpu_read(arch_core_cycles_prev);
+	const_cnt = amu_sample->arch_const_cycles_prev;
+	core_cnt = amu_sample->arch_core_cycles_prev;
 
+	/*
+	 * This should not happen unless the AMUs have been reset and the
+	 * counter values have not been restored - unlikely
+	 */
 	if (unlikely(core_cnt <= prev_core_cnt ||
 		     const_cnt <= prev_const_cnt))
 		return;
@@ -182,6 +198,8 @@ static void amu_scale_freq_tick(void)
 
 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
+
+	amu_sample->last_update = jiffies;
 }
 
 static struct scale_freq_data amu_sfd = {
@@ -189,6 +207,78 @@ static struct scale_freq_data amu_sfd = {
 	.set_freq_scale = amu_scale_freq_tick,
 };
 
+static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
+{
+	return cpumask_available(amu_fie_cpus) &&
+		cpumask_test_cpu(cpu, amu_fie_cpus);
+}
+
+#define AMU_SAMPLE_EXP_MS	20
+
+unsigned int arch_freq_get_on_cpu(int cpu)
+{
+	struct amu_cntr_sample *amu_sample;
+	unsigned int start_cpu = cpu;
+	unsigned long last_update;
+	unsigned int freq = 0;
+	u64 scale;
+
+	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
+		return 0;
+
+retry:
+	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
+
+	last_update = amu_sample->last_update;
+
+	/*
+	 * For those CPUs that are in full dynticks mode,
+	 * and those that have not seen tick for a while
+	 * try an alternative source for the counters (and thus freq scale),
+	 * if available, for given policy:
+	 * this boils down to identifying an active cpu within the same freq
+	 * domain, if any.
+	 */
+	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
+	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+		int ref_cpu = cpu;
+
+		if (!policy)
+			goto leave;
+
+		if (!policy_is_shared(policy)) {
+			cpufreq_cpu_put(policy);
+			goto leave;
+		}
+
+		do {
+			ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
+						    start_cpu, false);
+
+		} while (ref_cpu < nr_cpu_ids && idle_cpu(ref_cpu));
+
+		cpufreq_cpu_put(policy);
+
+		if (ref_cpu >= nr_cpu_ids)
+			/* No alternative to pull info from */
+			goto leave;
+
+		cpu = ref_cpu;
+		goto retry;
+	}
+	/*
+	 * Reversed computation to the one used to determine
+	 * the arch_freq_scale value
+	 * (see amu_scale_freq_tick for details)
+	 */
+	scale = arch_scale_freq_capacity(cpu);
+	freq = scale * arch_scale_freq_ref(cpu);
+	freq >>= SCHED_CAPACITY_SHIFT;
+leave:
+	return freq;
+}
+
 static void amu_fie_setup(const struct cpumask *cpus)
 {
 	int cpu;
-- 
2.25.1


