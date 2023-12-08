Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97567809726
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjLHAYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444202AbjLHAYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:24:12 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471811990
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:24:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3335397607dso1868493f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995056; x=1702599856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nwlq0zhFu5FAStt4KBjg7mmh2j1Bzk1RkbICiq0xto=;
        b=OMNtVLE8/L55t5RGpgoTuYD5hxcyHPgVChQ3+c9sHAS8QuIcAzROMrVPzL2nH5P74V
         O6EkctcoMVX8q1HOxPP1CqZZXp+gAQ5PwhBzs2T1AdK3yyGZ7DrplrlwwlCj7Tut+O/K
         kG/k03zv8NL9cxG1nylXz05v1lMjSlQ2YffIumgm5HAwedQf6AeQxlXyF9ZeHf9OcEk8
         dSNToUI4qfS0/Co6X6FgQQidon1j2XdH86XESsCn0P/lePbMhxxstB+3bj0B8Ofcobww
         sehJjTlBxV8lOU7E0U0lqgcvAbfk7N0G7+CesMsVsj1aYwmCNI5BiN1D8Wq51s0GfIuQ
         GTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995056; x=1702599856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nwlq0zhFu5FAStt4KBjg7mmh2j1Bzk1RkbICiq0xto=;
        b=Uofr9N2ltuBE4SK1NW+JyJMqWIE76z5eJMYeNDEm8bKwiPWv1RDrbyoPspvU3yAcyd
         TnA6pa2psH9RhmI9zyH1P603Gpya+bLPrV3mlSYIq5S0ziAhPaLt4Nv5wIBAZ1R16NLS
         J/qpdoCs8XZwNvqYPvG5I6C2hPj3ApfGJzsETHjdv2EHo01Ugx+5EpdPDs/eJviGz9az
         Fb/+7hRZy5mLLIk1iLVeyebu2/nPRyiId3VwoyTTVn1Xx2vpaEhlmB7TfJ3mx/2YLikq
         7m+dNshXOk47SMAtOYD5/ILNzgO3ZCSajJzKmmEOnAY1ZzCmTkRFzUdN9BdPc6uN0hBv
         RzAA==
X-Gm-Message-State: AOJu0Yy1+UEP10aSmC2nGqMEJNwxzJR9ieEEpRAev67kI72spiIU3E4w
        bf/aV2T5YncTqPoCYyEoZNh6+w==
X-Google-Smtp-Source: AGHT+IGaBM/YAzJsink77cXmt66LEcA7F6asWDoic+NYkY33uXpybFXXPDoXowvaweViU1Heh3EQ4w==
X-Received: by 2002:a05:600c:45cf:b0:401:bdd7:49ae with SMTP id s15-20020a05600c45cf00b00401bdd749aemr1943026wmo.18.1701995055118;
        Thu, 07 Dec 2023 16:24:15 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:24:14 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 6/8] sched: cpufreq: Remove magic 1.25 headroom from apply_dvfs_headroom()
Date:   Fri,  8 Dec 2023 00:23:40 +0000
Message-Id: <20231208002342.367117-7-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208002342.367117-1-qyousef@layalina.io>
References: <20231208002342.367117-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 1.25 headroom in apply_dvfs_headroom() with better dynamic
logic.

Instead of the magical 1.25 headroom, use the new approximate_util_avg()
to provide headroom based on the dvfs_update_delay; which is the period
at which the cpufreq governor will send DVFS updates to the hardware.

Add a new percpu dvfs_update_delay that can be cheaply accessed whenever
apply_dvfs_headroom() is called. We expect cpufreq governors that rely
on util to drive its DVFS logic/algorithm to populate these percpu
variables. schedutil is the only such governor at the moment.

The behavior of schedutil will change as the headroom will be less than
1.25 for most systems as the rate_limit_us is usually short.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/core.c              |  1 +
 kernel/sched/cpufreq_schedutil.c | 13 +++++++++++--
 kernel/sched/sched.h             | 18 ++++++++++++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f..b4a1c8ea9e12 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -116,6 +116,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU_READ_MOSTLY(u64, dvfs_update_delay);
 
 #ifdef CONFIG_SCHED_DEBUG
 /*
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 79c3b96dc02c..1d4d6025c15f 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -157,7 +157,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max)
 {
 	/* Add dvfs headroom to actual utilization */
-	actual = apply_dvfs_headroom(actual);
+	actual = apply_dvfs_headroom(actual, cpu);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
 		max = actual;
@@ -535,15 +535,21 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
 	struct sugov_policy *sg_policy;
 	unsigned int rate_limit_us;
+	int cpu;
 
 	if (kstrtouint(buf, 10, &rate_limit_us))
 		return -EINVAL;
 
 	tunables->rate_limit_us = rate_limit_us;
 
-	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
+	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook) {
+
 		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
 
+		for_each_cpu(cpu, sg_policy->policy->cpus)
+			per_cpu(dvfs_update_delay, cpu) = rate_limit_us;
+	}
+
 	return count;
 }
 
@@ -824,6 +830,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu = cpu;
 		sg_cpu->sg_policy = sg_policy;
+
+		per_cpu(dvfs_update_delay, cpu) = sg_policy->tunables->rate_limit_us;
+
 		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
 	}
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2de64f59853c..bbece0eb053a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3005,6 +3005,15 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
 u64 approximate_runtime(unsigned long util);
 
+/*
+ * Any governor that relies on util signal to drive DVFS, must populate these
+ * percpu dvfs_update_delay variables.
+ *
+ * It should describe the rate/delay at which the governor sends DVFS freq
+ * update to the hardware in us.
+ */
+DECLARE_PER_CPU_READ_MOSTLY(u64, dvfs_update_delay);
+
 /*
  * DVFS decision are made at discrete points. If CPU stays busy, the util will
  * continue to grow, which means it could need to run at a higher frequency
@@ -3014,13 +3023,14 @@ u64 approximate_runtime(unsigned long util);
  * to run at adequate performance point.
  *
  * This function provides enough headroom to provide adequate performance
- * assuming the CPU continues to be busy.
+ * assuming the CPU continues to be busy. This headroom is based on the
+ * dvfs_update_delay of the cpufreq governor.
  *
- * At the moment it is a constant multiplication with 1.25.
+ * XXX: Should we provide headroom when the util is decaying?
  */
-static inline unsigned long apply_dvfs_headroom(unsigned long util)
+static inline unsigned long apply_dvfs_headroom(unsigned long util, int cpu)
 {
-	return util + (util >> 2);
+	return approximate_util_avg(util, per_cpu(dvfs_update_delay, cpu));
 }
 
 /*
-- 
2.34.1

