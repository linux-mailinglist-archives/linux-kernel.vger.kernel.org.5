Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1C7E0EDE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjKDK7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 06:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjKDK72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 06:59:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A82D63
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 03:59:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so41345781fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699095562; x=1699700362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puBr9Yi+x/uGsFwHwq4a0yYN/Ns1a0YGcW8YSLOPxLY=;
        b=rU6Sct9dQ3KOhotIAC5vJ9DeXMWPD7ytPGmb3vvlHTF09c4XEYF4+KnouTq+M58lWt
         0iptqEdcOf8iA/m2pTU9Wkb8YMngQVIa88cfrg3StBiP4t3NY5PPmd+OPJ3K63+gXUTQ
         zEzdbNBWeo1G8AE5Yh/nzp+N6nMrHlfmaw8Aa73sC4qRtJ/4KMi5eGuJndDNCPOIpL2K
         d10PAkUQVdSHVpozsRG7JjC3R7AeHXN3E1X13OUHGvfUxpzbhknelY0+xWH9edCEbZSo
         5PfluqzrRdQK9mBFlLnCZyLA+EXdmQ5H5Z5RdqRA0aU61vKQzgCSSRyncv+iho4kYckX
         spew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699095562; x=1699700362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puBr9Yi+x/uGsFwHwq4a0yYN/Ns1a0YGcW8YSLOPxLY=;
        b=oXCshlRcYG7N0lFiNKPwvo075QJ+2vW03RmlvDTjfbb2LJvAiT8NMOfMz3zDBI//Gv
         PBo8lwkXfBzZqxspA5e9dXt7szLlYUf1yDKA6HXIW+3noTJtsS27oFqjhC7RA/aF7OQr
         N1IOV+tbCqJqTen6he0+naSLPFYPH5qpWw09+xGiP3dbm1HZd+QcOqVW9zJUaoxS4KsM
         8W1t0b9AU5n56EbiVht7kPy4xva6wzk2ohtUgUMAMqNJLShclHYiV/WHMADQ0iB4NexK
         vH0r9Zd66JnTqYCJqL3bshC/kjBTCShZOynOHUU0erO/FCzjhDJaQ7xbhpz09Szby3mm
         OHAA==
X-Gm-Message-State: AOJu0Yw2Ue8V5030I4gZYKwfuh++YQT3M6jIifsisG8R8V1BcOY3VZZo
        vlB3uU4AGX5ipv8LXKGnS2x8MQ==
X-Google-Smtp-Source: AGHT+IEk3sTFfQuHQKw0m3Mw4hvWfZEgdZ+z4UdSyOUZS5HQSWjuNsjHdiJp1Ig/quZGDOQeGEFaig==
X-Received: by 2002:a2e:8796:0:b0:2bc:f5a0:cc25 with SMTP id n22-20020a2e8796000000b002bcf5a0cc25mr18906281lji.2.1699095562622;
        Sat, 04 Nov 2023 03:59:22 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b004053a6b8c41sm5315809wmq.12.2023.11.04.03.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 03:59:22 -0700 (PDT)
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
Subject: [PATCH v5 7/7] arm64/amu: Use capacity_ref_freq to set AMU ratio
Date:   Sat,  4 Nov 2023 11:59:07 +0100
Message-Id: <20231104105907.1365392-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104105907.1365392-1-vincent.guittot@linaro.org>
References: <20231104105907.1365392-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
---
 arch/arm64/kernel/topology.c  | 26 ++++++++++++++------------
 drivers/base/arch_topology.c  | 12 +++++++++++-
 include/linux/arch_topology.h |  1 +
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 817d788cd866..615c1a20129f 100644
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
@@ -139,12 +144,12 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
 	ratio = div64_u64(ratio, max_rate);
 	if (!ratio) {
 		WARN_ONCE(1, "Reference frequency too low.\n");
-		return -EINVAL;
+		return;
 	}
 
-	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
+	WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)ratio);
 
-	return 0;
+	return;
 }
 
 static void amu_scale_freq_tick(void)
@@ -195,10 +200,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
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

