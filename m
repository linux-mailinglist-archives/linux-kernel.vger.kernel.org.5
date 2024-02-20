Return-Path: <linux-kernel+bounces-73206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4149685BF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAD71F23118
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019E76021;
	Tue, 20 Feb 2024 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsqrX2FP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E77318C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441199; cv=none; b=llbMogyERKAZoW5cCgk8i3Hz/Rionc6Lof4MQzMtkd5YcNYIV/pE2yFi68DIJmGK6pGlGh4feIIveMSrn3rvKGQ8yLPWrkhq95OIFQ56cKlptIARdCD3NgOpd69torvEZeoGQ1IP86tM08T32/LhyTZdT1nmvjtnHcEVPlaaKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441199; c=relaxed/simple;
	bh=AmI+mhJl5AlGT+h0sLAqwwDtScLVW9svqVOc58XxKko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bz0QdaIRlWZ66z/rao5EMhwacmKSnN7ooqYjfkfjNQw1gdcb6wDefUkXgG8r+cLHVztjSjnpMI7MKv7auDJWwH2jKAytafc6lms13xIvDojIFiN6zvgEyS4923SGJA3+s0XEAIJNieXW5rtXzL7NEuSry8SLj/vSRuBRBg4Dkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IsqrX2FP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410e820a4feso37286425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708441196; x=1709045996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQpO3XD9z+4WKZF9p2pzV79fzV1uiBng4ssGTZt9l7o=;
        b=IsqrX2FPMBFlRuvG9ZdTR+XzNxypJO70Qyhu/GM20pYEiFd+gQdQcEPk3a5wpkbpmy
         HsIAQcTeQsLlsHEpG/ZL4m02LLaH3HJJQ2CeuHF7+ZRA8WIQWsl+L/qsapzCLMNDDMhX
         5YylWYZ2QnapX6wQloXbooSVlUAjS+Z2EssOc+P+FHVMd/yUm4MOovbB2kbO8T9PqOJU
         abrPAf72ya+aDtsmOkOAbCYV8MC/hSLfOHVvZVlAwl2CBmR5TbwnwOvRzPxUbeR7HwjG
         w0K3gDUFeePjjGe0g6pDVcMSuhLlk7GUnr+2H64Brv7jeely7/8qfIsiK1UQniPVkWQI
         rIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441196; x=1709045996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQpO3XD9z+4WKZF9p2pzV79fzV1uiBng4ssGTZt9l7o=;
        b=OitUM0ooEq0WZ5ibDskQGfnFBWtdEEitCOdgsGBJMnJ8ahxIm1IIDSx2k/acHnov4/
         Yuv5skZXXR0EpySbBmw/A0lntjWJSh7w0Bkv7QfDWzxSzIScaseQUrYUp6G+69PfXdvA
         f176ITkOqpI49PaMQupjknM4VPRXgf8k2p61v132GCioP6FJGWGLGo1NuSA+5t7oyz7A
         DYye+S1ZKFr69TtEeY2XE8TEN+3pb7UV4b9yx9xshXr8CCyyMOgivF8jnL8qNYxe+j38
         XC3cQPi6LNF1HHu6pdbJP/BUktSSFL3l5q0VxojdyK0jiCMh5Snky9jHsHYFkspgfQ4S
         lRAw==
X-Forwarded-Encrypted: i=1; AJvYcCVb9HK5FCSRz1oHmgt15Qg2firIochVotbjNTCpE+IencEkIi7/IAKUbNRsfaOGfB8vzu/DOLUCzRvCMdDdYnS1dPB+BvE4UR7ePpCx
X-Gm-Message-State: AOJu0YwQZWFm00cWpTBGvEYH67oe9MuXvdp3TPanKxYblRG49QpYt0jE
	RC7N1liw5rcMamr3je3RNZPeuBQtGlZvlxk49W1u2NSbw9WM0BiEX6IWgp4eOG8=
X-Google-Smtp-Source: AGHT+IHU5FRmUVcTFyEWR5U3HbJ8O+99oQkcpexS5vm6MWZn87bgLjkitzYpQO0uvuGQ7Rvj1Y78tg==
X-Received: by 2002:a5d:64eb:0:b0:33d:3ff3:f888 with SMTP id g11-20020a5d64eb000000b0033d3ff3f888mr7428353wri.0.1708441196168;
        Tue, 20 Feb 2024 06:59:56 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:8deb:bfb9:b028:6d5c])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033d39626c27sm9304405wru.76.2024.02.20.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:59:55 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	mhiramat@kernel.org,
	daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v5 1/5] cpufreq: Add a cpufreq pressure feedback for the scheduler
Date: Tue, 20 Feb 2024 15:59:43 +0100
Message-Id: <20240220145947.1107937-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220145947.1107937-1-vincent.guittot@linaro.org>
References: <20240220145947.1107937-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide to the scheduler a feedback about the temporary max available
capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
filtered as the pressure will happen for dozens ms or more.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
---
 drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44db4f59c4cc..f4eee3d107f1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2563,6 +2563,40 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_get_policy);
 
+DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
+
+/**
+ * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
+ * @policy: cpufreq policy of the CPUs.
+ *
+ * Update the value of cpufreq pressure for all @cpus in the policy.
+ */
+static void cpufreq_update_pressure(struct cpufreq_policy *policy)
+{
+	unsigned long max_capacity, capped_freq, pressure;
+	u32 max_freq;
+	int cpu;
+
+	cpu = cpumask_first(policy->related_cpus);
+	max_freq = arch_scale_freq_ref(cpu);
+	capped_freq = policy->max;
+
+	/*
+	 * Handle properly the boost frequencies, which should simply clean
+	 * the cpufreq pressure value.
+	 */
+	if (max_freq <= capped_freq) {
+		pressure = 0;
+	} else {
+		max_capacity = arch_scale_cpu_capacity(cpu);
+		pressure = max_capacity -
+			   mult_frac(max_capacity, capped_freq, max_freq);
+	}
+
+	for_each_cpu(cpu, policy->related_cpus)
+		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
+}
+
 /**
  * cpufreq_set_policy - Modify cpufreq policy parameters.
  * @policy: Policy object to modify.
@@ -2618,6 +2652,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
 	trace_cpu_frequency_limits(policy);
 
+	cpufreq_update_pressure(policy);
+
 	policy->cached_target_freq = UINT_MAX;
 
 	pr_debug("new min and max freqs are %u - %u kHz\n",
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..13b69a816747 100644
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
+	return READ_ONCE(per_cpu(cpufreq_pressure, cpu));
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


