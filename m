Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291217E679D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjKIKPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjKIKPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:15:09 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD030D6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:14:57 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso7567391fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524896; x=1700129696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCeYYy5Thhb4RKaz86QJRj36sMkWMn4qr/sGF6e6Ivs=;
        b=kbfkzvGIy0XV98Yug5f3V7lYFzZsegoBdaRMmVgOvbtOBbeLdaeNgOMRJDcTPU4ke0
         PmW/QV/HRNKTYn3stmzQxdmqRYRCb5vcLiz+jT4qGAxuU9M5aCxMcckfS9CM99Ybbpqe
         DgHqMKzODAQAqcJdKu4yoI+S4PWeWXN87rskhQCN/P3n4IUHFpCPxCO35sgeOAdaoNRb
         Oy46Cuww4T9NnUOPKbhtXV3Pqp7sukksT/+H9KIlgufk2XJN0khloLnUEsYqp+4/nRb7
         22u6xY+yFo4eQU4na8UnvvfbGGWW24hcBfSHGoiSOAfYDyzGFw91dGsk8uhlYy+N+yMJ
         g2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524896; x=1700129696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCeYYy5Thhb4RKaz86QJRj36sMkWMn4qr/sGF6e6Ivs=;
        b=DSqlOcWKcAfLmw83RHUa4Kh5+G9wcaTsbCB2qgdiJdtnDfBqtp3h5na2X9ZfDkf8QL
         dzx4NbIU9bwdBcPWaaLW9Vq1ep1016JMpwfElJR3mecMzRnkSb0lYbkSet0W+D9qrJ/4
         EV5gRi0O1lSklcIXmsciShM9eMIlzaJ7ga9YjiYsH4pA4S+Up2quRuU84X2Y5Ldr8MZ/
         PSup9bTkDER57hoDv2B6s7lS2Q+n/AfBhJiLOu1TqZRt1h7Efb+zKDehA+3uEHlzHvoI
         lom9iqlUyU4XV418PBrFWSILGYmOXi1j396BSPbtFCnoMWUHDg4qH52uvrt2SOji2hc5
         DDtA==
X-Gm-Message-State: AOJu0Yw5OiyYBPgmGpbPXdCl89GRrfR2dgXKN08KcbyjCxFkEjxzF0FS
        e9aC6IP6GnVU84JICrCV5X7Iyw==
X-Google-Smtp-Source: AGHT+IGBoDudDQnmYAYbAg3sS2vQkxa5GehMipEZK1fFGMpvUqjDW36EmW0lVGcIfkmF004wnyx9zQ==
X-Received: by 2002:a2e:9441:0:b0:2bc:dab2:c7dc with SMTP id o1-20020a2e9441000000b002bcdab2c7dcmr3558708ljh.47.1699524895768;
        Thu, 09 Nov 2023 02:14:55 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:55 -0800 (PST)
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
Subject: [PATCH v6 5/7] cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
Date:   Thu,  9 Nov 2023 11:14:36 +0100
Message-Id: <20231109101438.1139696-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109101438.1139696-1-vincent.guittot@linaro.org>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move and rename cppc_cpufreq_perf_to_khz and cppc_cpufreq_khz_to_perf to
use them outside cppc_cpufreq in topology_init_cpu_capacity_cppc().

Modify the interface to use struct cppc_perf_caps *caps instead of
struct cppc_cpudata *cpu_data as we only use the fields of cppc_perf_caps.

cppc_cpufreq was converting the lowest and nominal freq from MHz to kHz
before using them. We move this conversion inside cppc_perf_to_khz and
cppc_khz_to_perf to make them generic and usable outside cppc_cpufreq.

No functional change

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/acpi/cppc_acpi.c       | 104 ++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 139 ++++-----------------------------
 include/acpi/cppc_acpi.h       |   2 +
 3 files changed, 123 insertions(+), 122 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7ff269a78c20..d155a86a8614 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -39,6 +39,9 @@
 #include <linux/rwsem.h>
 #include <linux/wait.h>
 #include <linux/topology.h>
+#include <linux/dmi.h>
+#include <linux/units.h>
+#include <asm/unaligned.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -1760,3 +1763,104 @@ unsigned int cppc_get_transition_latency(int cpu_num)
 	return latency_ns;
 }
 EXPORT_SYMBOL_GPL(cppc_get_transition_latency);
+
+/* Minimum struct length needed for the DMI processor entry we want */
+#define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
+
+/* Offset in the DMI processor structure for the max frequency */
+#define DMI_PROCESSOR_MAX_SPEED		0x14
+
+/* Callback function used to retrieve the max frequency from DMI */
+static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
+{
+	const u8 *dmi_data = (const u8 *)dm;
+	u16 *mhz = (u16 *)private;
+
+	if (dm->type == DMI_ENTRY_PROCESSOR &&
+	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
+		u16 val = (u16)get_unaligned((const u16 *)
+				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
+		*mhz = val > *mhz ? val : *mhz;
+	}
+}
+
+/* Look up the max frequency in DMI */
+static u64 cppc_get_dmi_max_khz(void)
+{
+	u16 mhz = 0;
+
+	dmi_walk(cppc_find_dmi_mhz, &mhz);
+
+	/*
+	 * Real stupid fallback value, just in case there is no
+	 * actual value set.
+	 */
+	mhz = mhz ? mhz : 1;
+
+	return KHZ_PER_MHZ * mhz;
+}
+
+/*
+ * If CPPC lowest_freq and nominal_freq registers are exposed then we can
+ * use them to convert perf to freq and vice versa. The conversion is
+ * extrapolated as an affine function passing by the 2 points:
+ *  - (Low perf, Low freq)
+ *  - (Nominal perf, Nominal freq)
+ */
+unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf)
+{
+	s64 retval, offset = 0;
+	static u64 max_khz;
+	u64 mul, div;
+
+	if (caps->lowest_freq && caps->nominal_freq) {
+		mul = caps->nominal_freq - caps->lowest_freq;
+		mul *= KHZ_PER_MHZ;
+		div = caps->nominal_perf - caps->lowest_perf;
+		offset = caps->nominal_freq * KHZ_PER_MHZ -
+			 div64_u64(caps->nominal_perf * mul, div);
+	} else {
+		if (!max_khz)
+			max_khz = cppc_get_dmi_max_khz();
+		mul = max_khz;
+		div = caps->highest_perf;
+	}
+
+	retval = offset + div64_u64(perf * mul, div);
+	if (retval >= 0)
+		return retval;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_perf_to_khz);
+
+unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq)
+{
+	s64 retval, offset = 0;
+	static u64 max_khz;
+	u64  mul, div;
+
+	if (caps->lowest_freq && caps->nominal_freq) {
+		mul = caps->nominal_perf - caps->lowest_perf;
+		div = caps->nominal_freq - caps->lowest_freq;
+		/*
+		 * We don't need to convert to kHz for computing offset and can
+		 * directly use nominal_freq and lowest_freq as the div64_u64
+		 * will remove the frequency unit.
+		 */
+		offset = caps->nominal_perf -
+			 div64_u64(caps->nominal_freq * mul, div);
+		/* But we need it for computing the perf level. */
+		div *= KHZ_PER_MHZ;
+	} else {
+		if (!max_khz)
+			max_khz = cppc_get_dmi_max_khz();
+		mul = caps->highest_perf;
+		div = max_khz;
+	}
+
+	retval = offset + div64_u64(freq * mul, div);
+	if (retval >= 0)
+		return retval;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_khz_to_perf);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index fe08ca419b3d..64420d9cfd1e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
-#include <linux/dmi.h>
 #include <linux/irq_work.h>
 #include <linux/kthread.h>
 #include <linux/time.h>
@@ -27,12 +26,6 @@
 
 #include <acpi/cppc_acpi.h>
 
-/* Minimum struct length needed for the DMI processor entry we want */
-#define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
-
-/* Offset in the DMI processor structure for the max frequency */
-#define DMI_PROCESSOR_MAX_SPEED		0x14
-
 /*
  * This list contains information parsed from per CPU ACPI _CPC and _PSD
  * structures: e.g. the highest and lowest supported performance, capabilities,
@@ -291,97 +284,9 @@ static inline void cppc_freq_invariance_exit(void)
 }
 #endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
 
-/* Callback function used to retrieve the max frequency from DMI */
-static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
-{
-	const u8 *dmi_data = (const u8 *)dm;
-	u16 *mhz = (u16 *)private;
-
-	if (dm->type == DMI_ENTRY_PROCESSOR &&
-	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
-		u16 val = (u16)get_unaligned((const u16 *)
-				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
-		*mhz = val > *mhz ? val : *mhz;
-	}
-}
-
-/* Look up the max frequency in DMI */
-static u64 cppc_get_dmi_max_khz(void)
-{
-	u16 mhz = 0;
-
-	dmi_walk(cppc_find_dmi_mhz, &mhz);
-
-	/*
-	 * Real stupid fallback value, just in case there is no
-	 * actual value set.
-	 */
-	mhz = mhz ? mhz : 1;
-
-	return (1000 * mhz);
-}
-
-/*
- * If CPPC lowest_freq and nominal_freq registers are exposed then we can
- * use them to convert perf to freq and vice versa. The conversion is
- * extrapolated as an affine function passing by the 2 points:
- *  - (Low perf, Low freq)
- *  - (Nominal perf, Nominal perf)
- */
-static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
-					     unsigned int perf)
-{
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	s64 retval, offset = 0;
-	static u64 max_khz;
-	u64 mul, div;
-
-	if (caps->lowest_freq && caps->nominal_freq) {
-		mul = caps->nominal_freq - caps->lowest_freq;
-		div = caps->nominal_perf - caps->lowest_perf;
-		offset = caps->nominal_freq - div64_u64(caps->nominal_perf * mul, div);
-	} else {
-		if (!max_khz)
-			max_khz = cppc_get_dmi_max_khz();
-		mul = max_khz;
-		div = caps->highest_perf;
-	}
-
-	retval = offset + div64_u64(perf * mul, div);
-	if (retval >= 0)
-		return retval;
-	return 0;
-}
-
-static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
-					     unsigned int freq)
-{
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	s64 retval, offset = 0;
-	static u64 max_khz;
-	u64  mul, div;
-
-	if (caps->lowest_freq && caps->nominal_freq) {
-		mul = caps->nominal_perf - caps->lowest_perf;
-		div = caps->nominal_freq - caps->lowest_freq;
-		offset = caps->nominal_perf - div64_u64(caps->nominal_freq * mul, div);
-	} else {
-		if (!max_khz)
-			max_khz = cppc_get_dmi_max_khz();
-		mul = caps->highest_perf;
-		div = max_khz;
-	}
-
-	retval = offset + div64_u64(freq * mul, div);
-	if (retval >= 0)
-		return retval;
-	return 0;
-}
-
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation)
-
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	unsigned int cpu = policy->cpu;
@@ -389,7 +294,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	u32 desired_perf;
 	int ret = 0;
 
-	desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
+	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	/* Return if it is exactly the same perf */
 	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
 		return ret;
@@ -417,7 +322,7 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	u32 desired_perf;
 	int ret;
 
-	desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
+	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 
@@ -530,7 +435,7 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 	min_step = min_cap / CPPC_EM_CAP_STEP;
 	max_step = max_cap / CPPC_EM_CAP_STEP;
 
-	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	perf_prev = cppc_khz_to_perf(perf_caps, *KHz);
 	step = perf_prev / perf_step;
 
 	if (step > max_step)
@@ -550,8 +455,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 			perf = step * perf_step;
 	}
 
-	*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
-	perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	*KHz = cppc_perf_to_khz(perf_caps, perf);
+	perf_check = cppc_khz_to_perf(perf_caps, *KHz);
 	step_check = perf_check / perf_step;
 
 	/*
@@ -561,8 +466,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 	 */
 	while ((*KHz == prev_freq) || (step_check != step)) {
 		perf++;
-		*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
-		perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+		*KHz = cppc_perf_to_khz(perf_caps, perf);
+		perf_check = cppc_khz_to_perf(perf_caps, *KHz);
 		step_check = perf_check / perf_step;
 	}
 
@@ -591,7 +496,7 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
 	perf_caps = &cpu_data->perf_caps;
 	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
 
-	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, KHz);
+	perf_prev = cppc_khz_to_perf(perf_caps, KHz);
 	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
 	step = perf_prev / perf_step;
 
@@ -679,10 +584,6 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
-	/* Convert the lowest and nominal freq from MHz to KHz */
-	cpu_data->perf_caps.lowest_freq *= 1000;
-	cpu_data->perf_caps.nominal_freq *= 1000;
-
 	list_add(&cpu_data->node, &cpu_data_list);
 
 	return cpu_data;
@@ -724,20 +625,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
 	 */
-	policy->min = cppc_cpufreq_perf_to_khz(cpu_data,
-					       caps->lowest_nonlinear_perf);
-	policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-					       caps->nominal_perf);
+	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
+	policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
 
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
 	 * available if userspace wants to use any perf between lowest & lowest
 	 * nonlinear perf
 	 */
-	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu_data,
-							    caps->lowest_perf);
-	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu_data,
-							    caps->nominal_perf);
+	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
@@ -773,7 +670,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		boost_supported = true;
 
 	/* Set policy->cur to max now. The governors will adjust later. */
-	policy->cur = cppc_cpufreq_perf_to_khz(cpu_data, caps->highest_perf);
+	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
@@ -863,7 +760,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
 					       &fb_ctrs_t1);
 
-	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
+	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
@@ -878,11 +775,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	}
 
 	if (state)
-		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-						       caps->highest_perf);
+		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
 	else
-		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-						       caps->nominal_perf);
+		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
 	policy->cpuinfo.max_freq = policy->max;
 
 	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
@@ -937,7 +832,7 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 	if (ret < 0)
 		return -EIO;
 
-	return cppc_cpufreq_perf_to_khz(cpu_data, desired_perf);
+	return cppc_perf_to_khz(&cpu_data->perf_caps, desired_perf);
 }
 
 static void cppc_check_hisi_workaround(void)
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 6126c977ece0..3a0995f8bce8 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -144,6 +144,8 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool cppc_perf_ctrs_in_pcc(void);
+extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
+extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
 extern bool acpi_cpc_valid(void);
 extern bool cppc_allow_fast_switch(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
-- 
2.34.1

