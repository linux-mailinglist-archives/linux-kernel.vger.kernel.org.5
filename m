Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2081E8098D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572945AbjLHBxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572943AbjLHBw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:52:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A221723
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:53:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-334b2ffaa3eso1546954f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702000380; x=1702605180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da7LLhF7dTBCpKaBg/sVxSbQ3IIX4np42FTWMRnWSyE=;
        b=h3NSf5psqsjkw7XBQeF3kO2syAHTzCZktpbn2UBoH05Gb9Mj+NjtvgHGhszvSSEEtK
         cdmcuAG9N7l7vQkGrRVGdTmULMWXFWxgt+igiUMabUkxV1ALobffFSZkqXQHq3eIv1w5
         S2MiHzYgaKWhqzunE8/uYLSqqPSPtRq6uHFJIWqF+g/TS98irxNdI0yabRjnJvmTViWP
         7CDXCAal0r+udd1WFyCdnw7gCAuU0kF2jrsRGjivYwpC+OJYz4CsGgIsdMhUFalDfKE1
         7gcPXrIq4Zm0/6iIIPrsBcE9kkeqG1rDFEtOwW96EjkaOUG/AaXdy07xtc7PvMO7gDhU
         ZozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702000380; x=1702605180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=da7LLhF7dTBCpKaBg/sVxSbQ3IIX4np42FTWMRnWSyE=;
        b=rW73YTWgjIhtBRN+hPtS/A7a+BlMAiRVv8gXAPcEYCmI6gQS5iOClXEkFHuGNsUa9x
         xfxSaylqJECRYH6Q476eWE2AZw0FN5RIc50hOFirVNZERC+txnw35eF73sibohUsHOfM
         VAXp4eksGkCBJD/VxUalgFdfQUVQskg9o7wXoe7zC6j3m2L2kvauJ9+rd628WF8UQzt/
         hzyifnBXQh2Waxiw73pPdjJP1+FKnbBUNz1r6DBr+X8sfwEP+tIqvZPseWF1KlSaEgwP
         1znW+HBgvo8ouzCv6oew6uzDOUxOGKGuvaxMnmbnlrFcZdKQL+RTCQHOkYI5SVvWBMU3
         RB7Q==
X-Gm-Message-State: AOJu0Ywe3u8xtLLemcHYUttGsacVvz9zXFn/5QfWyuntr5b420vYG8co
        SV7X1xJiLi/RyFMwvBSLZwkQGA==
X-Google-Smtp-Source: AGHT+IGrZHyEj+GDKOaEfnmPxdSCkC2yxj/SBOklZX3lgEv39Ku/B2G3SW2ba5uZHZqubXcqURrVgA==
X-Received: by 2002:a5d:4911:0:b0:333:2fd2:68f5 with SMTP id x17-20020a5d4911000000b003332fd268f5mr1934815wrq.136.1702000380663;
        Thu, 07 Dec 2023 17:53:00 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id s12-20020adf978c000000b003333a0da243sm902521wrb.81.2023.12.07.17.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:53:00 -0800 (PST)
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
        Hongyan Xia <hongyan.xia2@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 3/4] sched/schedutil: Ignore update requests for short running tasks
Date:   Fri,  8 Dec 2023 01:52:41 +0000
Message-Id: <20231208015242.385103-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208015242.385103-1-qyousef@layalina.io>
References: <20231208015242.385103-1-qyousef@layalina.io>
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

Ignore freq updates to honour uclamp requests if the task is short
running. It won't run long enough to see the changes, so avoid the
unnecessary work and noise.

Make sure SCHED_CPUFREQ_PERF_HINTS flag is set in task_tick_fair() so
that we can do correction action if the task continued to run such that
it is no longer considered a short task.

Should address the problem of noisy short running tasks unnecessary
causing frequency spikes when waking up on a CPU that is running a busy
task capped by UCLAMP_MAX.

Move helper functions to access task_util_est() and related attributes
to sched.h to enable using it from cpufreq_schedutil.c

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/cpufreq_schedutil.c | 59 ++++++++++++++++++++++++++++++++
 kernel/sched/fair.c              | 24 +------------
 kernel/sched/sched.h             | 22 ++++++++++++
 3 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 137636f62593..04a5cfcdbbf2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -8,11 +8,18 @@
 
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
+/*
+ * Min runtime in us a task should run for above rate_limit_us so that we don't
+ * ignore it in ignore_short_tasks().
+ */
+#define SHORT_TASK_MIN		500
+
 DEFINE_PER_CPU_READ_MOSTLY(unsigned long, response_time_mult);
 
 struct sugov_tunables {
 	struct gov_attr_set	attr_set;
 	unsigned int		rate_limit_us;
+	unsigned long		rate_limit_util;
 	unsigned int		response_time_ms;
 };
 
@@ -127,6 +134,49 @@ sugov_apply_response_time(unsigned long util, int cpu)
 	return mult >> SCHED_CAPACITY_SHIFT;
 }
 
+/*
+ * Ignore updates if current task's runtime is too short for the rate limit.
+ * The task must run for an average of rate_limit_us + SHORT_TASK_MIN for it
+ * not to be ignored.
+ *
+ * If we made a wrong decision and the task has changed characteristic such
+ * that it is no longer a short task, we should detect that at tick. Which can
+ * be a high penalty if the tick value is too high.
+ *
+ * XXX: can we take TICK_US into account somehow when verifying if we can
+ * ignore it?
+ *
+ * This is only valid for requests containing SCHED_CPUFREQ_PERF_HINTS flag,
+ * ie: uclamp hints requests at context switches.
+ *
+ * This flag is expected to be passed on context switch and tick. Only fair
+ * tasks are considered now as we use util to approximate its average runtime.
+ * We can't do the same without tracking the average runtime of the RT task in
+ * our accounting. And it might be risky to temporarily ignore the RT task's
+ * perf requirements as a mistake could have higher consequence.
+ *
+ * Once fair gains the concept of latency sensitive tasks, we might need to
+ * consider the consequence of ignoring them here too. For the same reason
+ * ignoring RT tasks is risky.
+ */
+static inline bool ignore_short_tasks(int cpu,
+				      struct sugov_policy *sg_policy,
+				      unsigned int flags)
+{
+	struct task_struct *p = cpu_rq(cpu)->curr;
+	unsigned long task_util;
+
+	if (!(flags & SCHED_CPUFREQ_PERF_HINTS))
+		return false;
+
+	if (!fair_policy(p->policy))
+		return false;
+
+	task_util = task_util_est(p);
+
+	return task_util < sg_policy->tunables->rate_limit_util;
+}
+
 static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
@@ -396,8 +446,12 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned long max_cap,
 					      unsigned int flags)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long boost;
 
+	if (ignore_short_tasks(sg_cpu->cpu, sg_policy, flags))
+		return false;
+
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -526,6 +580,9 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned int next_f;
 
+	if (ignore_short_tasks(sg_cpu->cpu, sg_policy, flags))
+		return;
+
 	raw_spin_lock(&sg_policy->update_lock);
 
 	sugov_iowait_boost(sg_cpu, time, flags);
@@ -612,6 +669,7 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 		return -EINVAL;
 
 	tunables->rate_limit_us = rate_limit_us;
+	tunables->rate_limit_util = approximate_util_avg(0, rate_limit_us + SHORT_TASK_MIN);
 
 	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook) {
 
@@ -853,6 +911,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	sg_policy->tunables = tunables;
 
 	tunables->rate_limit_us = cpufreq_policy_transition_delay_us(policy);
+	tunables->rate_limit_util = approximate_util_avg(0, tunables->rate_limit_us + SHORT_TASK_MIN);
 	tunables->response_time_ms = sugov_calc_freq_response_ms(sg_policy);
 	sugov_update_response_time_mult(sg_policy);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 74326179658c..b824e633ac2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4754,28 +4754,6 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 
 static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
 
-static inline unsigned long task_util(struct task_struct *p)
-{
-	return READ_ONCE(p->se.avg.util_avg);
-}
-
-static inline unsigned long task_runnable(struct task_struct *p)
-{
-	return READ_ONCE(p->se.avg.runnable_avg);
-}
-
-static inline unsigned long _task_util_est(struct task_struct *p)
-{
-	struct util_est ue = READ_ONCE(p->se.avg.util_est);
-
-	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
-}
-
-static inline unsigned long task_util_est(struct task_struct *p)
-{
-	return max(task_util(p), _task_util_est(p));
-}
-
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
@@ -12544,7 +12522,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
-	cpufreq_update_util(rq, 0);
+	cpufreq_update_util(rq, SCHED_CPUFREQ_PERF_HINTS);
 
 	task_tick_core(rq, curr);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f05a0674a036..b7a8cd768bef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2952,6 +2952,28 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
 u64 approximate_runtime(unsigned long util);
 
+static inline unsigned long task_util(struct task_struct *p)
+{
+	return READ_ONCE(p->se.avg.util_avg);
+}
+
+static inline unsigned long task_runnable(struct task_struct *p)
+{
+	return READ_ONCE(p->se.avg.runnable_avg);
+}
+
+static inline unsigned long _task_util_est(struct task_struct *p)
+{
+	struct util_est ue = READ_ONCE(p->se.avg.util_est);
+
+	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
+}
+
+static inline unsigned long task_util_est(struct task_struct *p)
+{
+	return max(task_util(p), _task_util_est(p));
+}
+
 /*
  * Any governor that relies on util signal to drive DVFS, must populate these
  * percpu dvfs_update_delay variables.
-- 
2.34.1

