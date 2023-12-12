Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D3D80EF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346591AbjLLO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376772AbjLLO1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:27:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38468D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c2308faedso59266345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702391258; x=1702996058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcWN9DAKeqNVxfGMQOa8sW2gEdyays6xiY37i8hYsMI=;
        b=pWOTgW37KxYd3nRqVldm/oz/ZRAw6Syj2HcVSLkkcmoEZkMtwNXgJR6T7j7VSkQsqg
         LH9o2HuH4ALyUcM9cjl6wBbwtM9ICvwXiD4ltrzBkazghNKi1YAMFPwvXqevIWV/pVY1
         stswJywp4C7x1Nu6pdmrxFvh41ViFbhjNdVhNNO+lt1x5trGD090nQrLD3a9h5GUNTH3
         CUq0CheObN8wUz7g2hIr6m3pl4kgWKe+fOJ2MaY8Jz1o2AlMbWeA7ALtedgotej3qbOT
         hLk+n8bUMcN4JmiZ/nOWy7oNpW2075s+4+lkuta7f6Rd9UGVlNmalwd6qlO/ldzGXP2o
         dbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391258; x=1702996058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcWN9DAKeqNVxfGMQOa8sW2gEdyays6xiY37i8hYsMI=;
        b=iQfMXF3MDMX+vX9ST+vmTtXurA4YMMj1STnkgkHzBF+Q0NjMeo71Vbx01+484Xv2wb
         YTbhJkV09izRWTITZN7yHBB0bAg3TW55SyI+6/H5lFmawXNc3qvJrnFhM8ggQ2nYaniU
         izLVr5ltNze00ZCiQrlzkRdlHYMWNz/K/yJgcC75pIyJjJs66ZhAbMbRCbjEpZOHN+e2
         gYgPbVOpFF1HXiswakvPpQxNhcZfL0nEh2X+y5Ogl0aorjQnG6mvjBD8wXQ+g1LtkPfz
         C+bf4GGJ0L9H/FpGuFtSFwVfDZEOYVhzIsCEGSMylj18hb0GLCy0jipZFbuBODwE3Ttv
         +DjA==
X-Gm-Message-State: AOJu0YyaUcNhX8KaVkjWik7zaohjBLQFYvYH5mpApQUkHEcnjZjKmvLa
        npdBlfL1+1imYpyQJMvSx6fMZQ==
X-Google-Smtp-Source: AGHT+IEgK2As3VnaEW3NpzD9+F0127H9s9y2RClkz+smDDtp0C3MHYd7jiwZSVSc0aF0fZIRdJ5kXA==
X-Received: by 2002:a05:600c:ac8:b0:405:3ae6:2413 with SMTP id c8-20020a05600c0ac800b004053ae62413mr3182722wmr.25.1702391257548;
        Tue, 12 Dec 2023 06:27:37 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a004:6e24:43ee:dd81])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm9078291wmb.46.2023.12.12.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:27:36 -0800 (PST)
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
Subject: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the scheduler
Date:   Tue, 12 Dec 2023 15:27:27 +0100
Message-Id: <20231212142730.998913-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212142730.998913-1-vincent.guittot@linaro.org>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide to the scheduler a feedback about the temporary max available
capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
filtered as the pressure will happen for dozens ms or more.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 48 +++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   | 10 ++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44db4f59c4cc..7d5f71be8d29 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2563,6 +2563,50 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_get_policy);
 
+DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
+EXPORT_PER_CPU_SYMBOL_GPL(cpufreq_pressure);
+
+/**
+ * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
+ * @cpus        : The related CPUs for which max capacity has been reduced
+ * @capped_freq : The maximum allowed frequency that CPUs can run at
+ *
+ * Update the value of cpufreq pressure for all @cpus in the mask. The
+ * cpumask should include all (online+offline) affected CPUs, to avoid
+ * operating on stale data when hot-plug is used for some CPUs. The
+ * @capped_freq reflects the currently allowed max CPUs frequency due to
+ * freq_qos capping. It might be also a boost frequency value, which is bigger
+ * than the internal 'capacity_freq_ref' max frequency. In such case the
+ * pressure value should simply be removed, since this is an indication that
+ * there is no capping. The @capped_freq must be provided in kHz.
+ */
+static void cpufreq_update_pressure(const struct cpumask *cpus,
+				      unsigned long capped_freq)
+{
+	unsigned long max_capacity, capacity, pressure;
+	u32 max_freq;
+	int cpu;
+
+	cpu = cpumask_first(cpus);
+	max_capacity = arch_scale_cpu_capacity(cpu);
+	max_freq = arch_scale_freq_ref(cpu);
+
+	/*
+	 * Handle properly the boost frequencies, which should simply clean
+	 * the thermal pressure value.
+	 */
+	if (max_freq <= capped_freq)
+		capacity = max_capacity;
+	else
+		capacity = mult_frac(max_capacity, capped_freq, max_freq);
+
+	pressure = max_capacity - capacity;
+
+
+	for_each_cpu(cpu, cpus)
+		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
+}
+
 /**
  * cpufreq_set_policy - Modify cpufreq policy parameters.
  * @policy: Policy object to modify.
@@ -2584,6 +2628,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
+	struct cpumask *cpus;
 	int ret;
 
 	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
@@ -2618,6 +2663,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
 	trace_cpu_frequency_limits(policy);
 
+	cpus = policy->related_cpus;
+	cpufreq_update_pressure(cpus, policy->max);
+
 	policy->cached_target_freq = UINT_MAX;
 
 	pr_debug("new min and max freqs are %u - %u kHz\n",
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..b1d97edd3253 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -241,6 +241,12 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
 bool has_target_index(void);
+
+DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
+static inline unsigned long cpufreq_get_pressure(int cpu)
+{
+	return per_cpu(cpufreq_pressure, cpu);
+}
 #else
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
@@ -263,6 +269,10 @@ static inline bool cpufreq_supports_freq_invariance(void)
 	return false;
 }
 static inline void disable_cpufreq(void) { }
+static inline unsigned long cpufreq_get_pressure(int cpu)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_CPU_FREQ_STAT
-- 
2.34.1

