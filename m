Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1191F78FDF7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349639AbjIAND1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbjIANDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:03:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152FA10CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:03:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso1659697f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693573400; x=1694178200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc2/PThdglNLGfS0qJb++8JNKia8ENWEPE++6QMdKJg=;
        b=isk+rIEjOm07QeYfpOewfO+4OY+UQBLieRIcXY1xvZd32o7aFvL5jTMcEa02LpNADG
         zGbc8gs3YcWL4TSNB3p60PdQkGRMdt1jrBJl8+Gqztf69LlFC+vLhkcrPEfM+JwVZ0hk
         MQCG1zAyYe1tYaBbezn5C0FowM1Y+kYY4tfYQLBQD7qsLMhKPe20XufaBtsa3N1rWT25
         csPkkfq/BDw7MZMnnqkbLAs3CVqIOcS1sdwBUpaHmXDcrsSzESBHL4V6o2IcYSNbIlxm
         btkShGPr259KGYArv/KVi5Q1o2wSqYRUrCZJLXJmO78iZfK5dWjZPcf2lYhp+nx2GEI1
         CbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573400; x=1694178200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc2/PThdglNLGfS0qJb++8JNKia8ENWEPE++6QMdKJg=;
        b=KV9ELFE072t3yIncQUhte3hSs3CoOskf30hN2OFUY9GajJVPH9bXjbgPs1AF1A276X
         tqn1gFb28YeLp/fkwKJNjo8bKrSAIt2jwArwPWExw4cWfVH+SJ2eDM18o+tEJEp51pj8
         BDvnaTGjc4o7TtiLtbx+BVpfhWeI3VBOCbn94kjBcXGTLKhMknsFLJTqQjjxaP0ZPsa/
         59u+Kbjnt6Hgb57ML6Gmoi85P2klaUtsSOy5xgSRfDNmBM+jO0+ifhKVsubpJ9z4KlkF
         jsEGoMM049P19Ho/T+1Jsjx1V2founPpdfYDZrbtmdQzh7GQDrUVkckvPmFu2Ew0AqHD
         Ycpg==
X-Gm-Message-State: AOJu0Yzkj76MODsoCd1T1hNFjR25OaM5PBPUMWY4nm0gyskWjw9R55Kc
        Z12omw/XB9Fh64VdDxkQeukZKg==
X-Google-Smtp-Source: AGHT+IFhopL0OmPezFJfjy60UyNhSKg8ZqbBwJgAZmOJYjwD1j0DD1QYHLDKXKPgXXRmJOa5y8JoMw==
X-Received: by 2002:adf:ecc6:0:b0:317:58e4:e941 with SMTP id s6-20020adfecc6000000b0031758e4e941mr1608494wro.33.1693573400353;
        Fri, 01 Sep 2023 06:03:20 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:e9bd:add1:d9ac:7b3e])
        by smtp.gmail.com with ESMTPSA id i14-20020adfdece000000b003142e438e8csm5167452wrn.26.2023.09.01.06.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:03:19 -0700 (PDT)
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
Subject: [PATCH 2/4] topology: add a new arch_scale_freq_reference
Date:   Fri,  1 Sep 2023 15:03:10 +0200
Message-Id: <20230901130312.247719-3-vincent.guittot@linaro.org>
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

Create a new method to get a unique and fixed max frequency. Currently
cpuinfo.max_freq or last item of performance domain are used as the max
frequency when computing the frequency for a level of utilization but:
- cpuinfo_max_freq can change at runtime. boost is one example of
  such change.
- cpuinfo.max_freq and last item of the PD can be different leading to
  different results betwen cpufreq and energy model.

We need to save the max frequency that has been used when computing the
CPUs capacity and use this fixed and coherent value to convert between
frequency and CPU's capacity.

In fact, we already save the frequency that has been used when computing
the capacity of each CPU. We extend the precision to save khZ instead of
Mhz currently and we modify the type to be aligned with other variables
used when converting frequency to capacity and the other way.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/include/asm/topology.h   | 1 +
 arch/arm64/include/asm/topology.h | 1 +
 arch/riscv/include/asm/topology.h | 1 +
 drivers/base/arch_topology.c      | 9 +++------
 include/linux/arch_topology.h     | 7 +++++++
 5 files changed, 13 insertions(+), 6 deletions(-)

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
index b741b5ba82bd..75fa67477a9d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -26,7 +26,7 @@
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
-static DEFINE_PER_CPU(u32, freq_factor) = 1;
+DEFINE_PER_CPU(unsigned long, freq_factor) = 1;
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
 {
@@ -183,10 +183,7 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 
 	cpu = cpumask_first(cpus);
 	max_capacity = arch_scale_cpu_capacity(cpu);
-	max_freq = per_cpu(freq_factor, cpu);
-
-	/* Convert to MHz scale which is used in 'freq_factor' */
-	capped_freq /= 1000;
+	max_freq = arch_scale_freq_ref(cpu);
 
 	/*
 	 * Handle properly the boost frequencies, which should simply clean
@@ -411,7 +408,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus)
-		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
+		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq;
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a07b510e7dc5..7a2dba9c3dc0 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
+DECLARE_PER_CPU(unsigned long, freq_factor);
+
+static inline unsigned long topology_get_freq_ref(int cpu)
+{
+	return per_cpu(freq_factor, cpu);
+}
+
 DECLARE_PER_CPU(unsigned long, arch_freq_scale);
 
 static inline unsigned long topology_get_freq_scale(int cpu)
-- 
2.34.1

