Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7A77D90A7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjJ0IEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjJ0IEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:04:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B66AD62
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:04:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083f613275so13303485e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393858; x=1698998658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IF1VOPdi0K4kIRvpjz08HAORhp3LmbyMbIJ+gO1rNg=;
        b=Hf0glRMTjYhF+QmxPCc3BphrnRo7GwxHj5/6qmmHNeB2FzhBMbagqddrHWwL47y/4Q
         5JQ6DvRhT2qjVBc+LPTUOWX5VUBdfkDoN5ownLCJ9GUlkSwQAjIax1aCoPiz0I7XVzLO
         ChXb+SM/gPhtsnZ7pwW3e8iZHCU6gEvKNTy8+Ydv+XLaMy6/rgn4wCXZ4nE5KusDnYGK
         estgYZ/3sgrbWCKCMqHOf5vC0jh6UexRDv2BVmpaeisfvfq4TAgvg5lRYDG3ddA3UoCI
         DFVF+mO0PSxPz0/QLE6U3Oacj30dVe1A7fZW4XXZPWCkZxVO3gFRGGgrv1g/q/gDEYNX
         XO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393858; x=1698998658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IF1VOPdi0K4kIRvpjz08HAORhp3LmbyMbIJ+gO1rNg=;
        b=uIxMgqIyjCE2sJzIAOCESlQ96TJ9nDbjCAs9G52/GeS0bV/bMd93yAu4Wc5onlXuQB
         4jbnQeDEgyKYfAvY5jj6UAxcPIEistoJaNFnk/Jvd41dgDVjWsPk92B4ycEfmC8mSgHu
         WWWYlbc2iSBi+TFcjYdZ18hEqduRuJCzaZmJezgsjFMFaYtiPv6xsI4rwytTLgGUfIKq
         uRUxj3a+nY0RgiWRcjVdYBrRSdoQc7SR7Cp2QMVqT9TBlLeLLJf3nWrMxBOp6B/dsywX
         t6FX+pBC8CgPSkkxKzKueiaoasY8JDPBS+Bwn2WipBSa0Q1iqnaypnFEx5v4LXf90wEI
         +OXQ==
X-Gm-Message-State: AOJu0Yz1PW6YXLEvGJ8b3oYwEsOk39K6cAhIRv6IerBpua9CM/y/qphX
        4nN6Gn3ePJbGenxVhgzkQEC1VA==
X-Google-Smtp-Source: AGHT+IEQRB/mHoq8MdS5H9J472cmmp7qD59jkI6Y24bnao8Xq/XHqMqigjuK32VfYE7VWBECQ+sLRg==
X-Received: by 2002:a05:600c:4ed2:b0:408:2f50:f228 with SMTP id g18-20020a05600c4ed200b004082f50f228mr1650096wmq.41.1698393858093;
        Fri, 27 Oct 2023 01:04:18 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b004083729fc14sm4397488wmj.20.2023.10.27.01.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:04:17 -0700 (PDT)
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
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 7/7] arm64/amu: use capacity_ref_freq to set AMU ratio
Date:   Fri, 27 Oct 2023 10:04:00 +0200
Message-Id: <20231027080400.56703-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027080400.56703-1-vincent.guittot@linaro.org>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new capacity_ref_freq to set the ratio that is used by AMU for
computing the arch_scale_freq_capacity().
This helps to keep everything aligned using the same reference for
computing CPUs capacity.

The default value of the ratio (stored in per_cpu(arch_max_freq_scale)
ensures that arch_scale_freq_capacity() returns max capacity until it is
set to its correct value with the cpu capacity and capacity_ref_freq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm64/kernel/topology.c  | 26 ++++++++++++++------------
 drivers/base/arch_topology.c  | 12 +++++++++++-
 include/linux/arch_topology.h |  1 +
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 817d788cd866..626031076b75 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
 #undef pr_fmt
 #define pr_fmt(fmt) "AMU: " fmt
 
-static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
+/*
+ * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SCALE until
+ * the CPU capacity and its assosciated frequency have been correctly
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
index d4bef370feb3..3cba7dc753b3 100644
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
+				       per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
+
 		capacity = raw_capacity[cpu];
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 				     capacity_scale);
@@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
-	for_each_cpu(cpu, policy->related_cpus)
+	for_each_cpu(cpu, policy->related_cpus) {
 		per_cpu(capacity_ref_freq, cpu) = policy->cpuinfo.max_freq;
+		freq_inv_set_max_ratio(cpu,
+				       per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
+	}
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 38ca6c76af56..ffdf0b7c55fa 100644
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

