Return-Path: <linux-kernel+bounces-10491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0B681D500
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC2D1C21416
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E0018B1B;
	Sat, 23 Dec 2023 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2IpT6/n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qT4zZPFc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F011CA3;
	Sat, 23 Dec 2023 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Dec 2023 16:09:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703347791;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwgA6LdUqAO3XVfytZbrjuE7sIziL0RwjlTrMLwIR6w=;
	b=R2IpT6/nOIgu8teYJIo587WExji0zq2g6kWyrIldLrMSbv1Yw6DGBBHKyoSh7egcWaFxXN
	BX0PoyzXr2n+766A93BaWsmRQfk3MrN4j4NxLWEc89LXutUFyCaokspEloTzWSk7br+Hv7
	NWQ9qJCL5RrlzOx6mYNs/YLG7b6ud6PmbrsVKXVs4HpdK4BWtSfYIybohGRkv8uERsv/7i
	bENv9wSt7aeUV6+3HmzRVQYpEn6nUD3jjUBzUS/lmkGzLYUMdvCsquXacCXCFZzoSnmUxn
	jx8rVSKMAHZqsCdgSVcPQOi5ftaRONF9GGP8geS8lFHBv3wobIHHSdCgzcM7qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703347791;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwgA6LdUqAO3XVfytZbrjuE7sIziL0RwjlTrMLwIR6w=;
	b=qT4zZPFcjGbP6a6CgxbSsBugejfH+dql0SJAa8um2nohod809m5Fb2uQveigbj6n5RR8jv
	LLTJQAwFskQtljDw==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64/amu: Use capacity_ref_freq() to set AMU ratio
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231211104855.558096-8-vincent.guittot@linaro.org>
References: <20231211104855.558096-8-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170334779091.398.13322969154683634281.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1f023007f5e782bda19ad9104830c404fd622c5d
Gitweb:        https://git.kernel.org/tip/1f023007f5e782bda19ad9104830c404fd622c5d
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 11 Dec 2023 11:48:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Dec 2023 15:52:36 +01:00

arm64/amu: Use capacity_ref_freq() to set AMU ratio

Use the new capacity_ref_freq() method to set the ratio that is used by AMU for
computing the arch_scale_freq_capacity().
This helps to keep everything aligned using the same reference for
computing CPUs capacity.

The default value of the ratio (stored in per_cpu(arch_max_freq_scale))
ensures that arch_scale_freq_capacity() returns max capacity until it is
set to its correct value with the cpu capacity and capacity_ref_freq().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20231211104855.558096-8-vincent.guittot@linaro.org
---
 arch/arm64/kernel/topology.c  | 26 +++++++++++++-------------
 drivers/base/arch_topology.c  | 12 +++++++++++-
 include/linux/arch_topology.h |  1 +
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 817d788..1a2c72f 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
 #undef pr_fmt
 #define pr_fmt(fmt) "AMU: " fmt
 
-static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
+/*
+ * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SCALE until
+ * the CPU capacity and its associated frequency have been correctly
+ * initialized.
+ */
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
 static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
 static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
 static cpumask_var_t amu_fie_cpus;
@@ -112,14 +117,14 @@ static inline bool freq_counters_valid(int cpu)
 	return true;
 }
 
-static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
+void freq_inv_set_max_ratio(int cpu, u64 max_rate)
 {
-	u64 ratio;
+	u64 ratio, ref_rate = arch_timer_get_rate();
 
 	if (unlikely(!max_rate || !ref_rate)) {
-		pr_debug("CPU%d: invalid maximum or reference frequency.\n",
+		WARN_ONCE(1, "CPU%d: invalid maximum or reference frequency.\n",
 			 cpu);
-		return -EINVAL;
+		return;
 	}
 
 	/*
@@ -139,12 +144,10 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
 	ratio = div64_u64(ratio, max_rate);
 	if (!ratio) {
 		WARN_ONCE(1, "Reference frequency too low.\n");
-		return -EINVAL;
+		return;
 	}
 
-	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
-
-	return 0;
+	WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)ratio);
 }
 
 static void amu_scale_freq_tick(void)
@@ -195,10 +198,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
 		return;
 
 	for_each_cpu(cpu, cpus) {
-		if (!freq_counters_valid(cpu) ||
-		    freq_inv_set_max_ratio(cpu,
-					   cpufreq_get_hw_max_freq(cpu) * 1000ULL,
-					   arch_timer_get_rate()))
+		if (!freq_counters_valid(cpu))
 			return;
 	}
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1aa76b5..5aaa086 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -344,6 +344,10 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 	return !ret;
 }
 
+void __weak freq_inv_set_max_ratio(int cpu, u64 max_rate)
+{
+}
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
 
@@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
 	}
 
 	for_each_possible_cpu(cpu) {
+		freq_inv_set_max_ratio(cpu,
+				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
+
 		capacity = raw_capacity[cpu];
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 				     capacity_scale);
@@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
-	for_each_cpu(cpu, policy->related_cpus)
+	for_each_cpu(cpu, policy->related_cpus) {
 		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
+		freq_inv_set_max_ratio(cpu,
+				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
+	}
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 32c24ff..a63d61c 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+void freq_inv_set_max_ratio(int cpu, u64 max_rate);
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */

