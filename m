Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D6E7E6799
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjKIKPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjKIKPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:15:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D798F30D5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:15:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40839807e82so4048495e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524899; x=1700129699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeh/ejHIslK7GUpigz7eOxRJ5nIZNkForzOfukaDKm0=;
        b=r4t1ibiOa66uJtVLUNjZ3X3zQsZ+Awg425wX7LcAY4Gp69+CEFUXdMvAXkATcWePZV
         z6QefD6qL6CVN1gv+m98Iv3uI7FrDkQvkitUMY0DFCOH3E+S6+7/5emJ6AbU2dmizGJQ
         MsqwOrxVLF5txOevqS3x6rUch5ueEQQX4bL68f2BJTbrkktV780i1vHpnDXXF3kTEBS5
         U0T0Mnps+4l7tUy42gS+cjQJupK3LXlcLTvDtkJnjW2WoH/hsRQN9bfuuorncUFZFWt9
         vRnx/cblg67XdV08PQJuqCGUCB7ZwR9sGxOFZqV/3Y4zk/C6vJya22lvSWapEgwIeraN
         mPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524899; x=1700129699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yeh/ejHIslK7GUpigz7eOxRJ5nIZNkForzOfukaDKm0=;
        b=aesLyRgmwUj4JveO2PoVB8RsNsq1e/ar25uiLAB7YH9xvPQeBybjgoAaeiu49XZXnh
         9xNZl9ej9v9xJM/jjpi8gka7pjXWz1M80RuoG0N+uaQrezcCwb9RNToMhbI7mHiIBND9
         qUL3Q4g4ZArS0eMV657pklSTYSTWL67wa7mNdSlLmMqzOo6QLEa+9ezWnveKbTHnOhgn
         dytl48lYg0b0gnvskXWaHxgn1bOsD2w2m3byOtfx8ZGk57DCS/6Ecq2RQ6gXrQqlur4L
         baIn12Hyg/x/Fd+ttKSUArhecgD6xqqMfCDLRkDmCapnK3rUAsbEJ1v47pYEifFzUU1d
         ecdw==
X-Gm-Message-State: AOJu0YyGEu6L4pn6jSiFOtq4AaxLKO1CqxLBJqvWIu3eIxq35Xq1+hqo
        SGCly7moC1lvgCu8k+2mjgkcFg==
X-Google-Smtp-Source: AGHT+IGlIQP4ExpYKEcJPouG3NAgRbcbvugwDfKHk5La7RKyXTFl7Z52+KMescuL7ihHOYDKBftYUA==
X-Received: by 2002:a05:600c:3c97:b0:406:5a14:5c1e with SMTP id bg23-20020a05600c3c9700b004065a145c1emr10570874wmb.1.1699524899315;
        Thu, 09 Nov 2023 02:14:59 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:58 -0800 (PST)
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
Subject: [PATCH v6 7/7] arm64/amu: Use capacity_ref_freq to set AMU ratio
Date:   Thu,  9 Nov 2023 11:14:38 +0100
Message-Id: <20231109101438.1139696-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109101438.1139696-1-vincent.guittot@linaro.org>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new capacity_ref_freq to set the ratio that is used by AMU for
computing the arch_scale_freq_capacity().
This helps to keep everything aligned using the same reference for
computing CPUs capacity.

The default value of the ratio (stored in per_cpu(arch_max_freq_scale))
ensures that arch_scale_freq_capacity() returns max capacity until it is
set to its correct value with the cpu capacity and capacity_ref_freq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/topology.c  | 26 +++++++++++++-------------
 drivers/base/arch_topology.c  | 12 +++++++++++-
 include/linux/arch_topology.h |  1 +
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 817d788cd866..1a2c72f3e7f8 100644
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
index 0a2e43728286..0906114963ff 100644
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
index 32c24ff4f2a8..a63d61ca55af 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+void freq_inv_set_max_ratio(int cpu, u64 max_rate);
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.34.1

