Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B488F78A377
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjH0Xc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjH0XcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:32:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC45B5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so16067195e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179138; x=1693783938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFCzoEj222YOvKZmu/QASlOstFmAq8cTeKzq6GBcqv8=;
        b=oPeuQP9SR40dh1ZhVoOKwREqhU5VDqMV9TCmS1XyyVy4V5Kc+3W1k9m5/q6La7UVCK
         Why0ApkB6chSrJJ+2Lh8gnceaw6vPkvGh9icr45DvKaz+mQ/ejApMZU4AZgnGcOzfW1g
         EaXxyT650SX088zB2MEwb2UfI2pzGKgKZju81jl0XGajyaQHsqURXL5abWK5yXtBo38Y
         CpD1g6GopDdvnirmFPjmJoNqexrA+Eeel7uxylyRxnJJRcUgrDW9oBseuNyxAEOFBZE4
         fYb6sMXwoW/UCp4DjtDLXcQ7fvtLFLoLzgYjn2n3mpVx2c+8DA/w9eZBIbpSOgcWVZQd
         KmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179138; x=1693783938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFCzoEj222YOvKZmu/QASlOstFmAq8cTeKzq6GBcqv8=;
        b=cFpMV2Mznx4TZVT/96QsUvG+Y4kzMYcHlMWSlXtpLFxVMvtYhENrpjuxiHs59XeeRd
         6gQd11LcN8KIQ8XRmCdL9izg8TSMLSSetKKp0mxPg6zwbcqfWw4ALLLR+14JqrxN5J9z
         Hi7vNHIsAharMf+pCUU5B0rzMUhduLeW1x6KjrqIAx1xIlQOMHcfRYmFOtzVWtR/2+a2
         s8MaoBMe8bFfY+oiDBiK+VG8f/fvPXGJe4iVOMqxpfChL/nvWLFUwvk1ggBzvQqVn88e
         DYl5LhcFcURAeKxbQQkyS7lZjWB1PzxNuXqHigR2B4bUgHFhbE6z+qSSmsiH2Kg/ttBs
         lPZg==
X-Gm-Message-State: AOJu0Yz2I8q1TMF6adlYU+t2w56VcWGFhYMmpozmegHozFHaoYlmKE84
        fr7c5dsK7BPVrhMZvMxdkU/nfg==
X-Google-Smtp-Source: AGHT+IGmJ1ukE6kgXP4BwFh90Slk9aIfq9ysM3sXxR7HHWBVq7U3l502sYX87//+jFgXaGb8io1fSQ==
X-Received: by 2002:a05:600c:3653:b0:401:b0f2:88cf with SMTP id y19-20020a05600c365300b00401b0f288cfmr6665902wmq.40.1693179137900;
        Sun, 27 Aug 2023 16:32:17 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm12220395wmk.2.2023.08.27.16.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:32:17 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 4/7] sched: cpufreq: Remove magic 1.25 headroom from apply_dvfs_headroom()
Date:   Mon, 28 Aug 2023 00:32:00 +0100
Message-Id: <20230827233203.1315953-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827233203.1315953-1-qyousef@layalina.io>
References: <20230827233203.1315953-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the magical 1.25 headroom, use the new approximate_util_avg()
to provide headroom based on the dvfs_update_delay; which is the period
at which the cpufreq governor will send DVFS updates to the hardware.

Add a new percpu dvfs_update_delay that can be cheaply accessed whenever
apply_dvfs_headroom() is called. We expect cpufreq governors that rely
on util to drive its DVFS logic/algorithm to populate these percpu
variables. schedutil is the only such governor at the moment.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/core.c              |  3 ++-
 kernel/sched/cpufreq_schedutil.c | 10 +++++++++-
 kernel/sched/sched.h             | 25 ++++++++++++++-----------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 602e369753a3..f56eb44745a8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -116,6 +116,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU_SHARED_ALIGNED(u64, dvfs_update_delay);
 
 #ifdef CONFIG_SCHED_DEBUG
 /*
@@ -7439,7 +7440,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * frequency will be gracefully reduced with the utilization decay.
 	 */
 	if (type == FREQUENCY_UTIL) {
-		util = apply_dvfs_headroom(util_cfs) + cpu_util_rt(rq);
+		util = apply_dvfs_headroom(util_cfs, cpu) + cpu_util_rt(rq);
 		util = uclamp_rq_util_with(rq, util, p);
 	} else {
 		util = util_cfs + cpu_util_rt(rq);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 0c7565ac31fb..04aa06846f31 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -519,15 +519,21 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
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
 
@@ -772,6 +778,8 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu			= cpu;
 		sg_cpu->sg_policy		= sg_policy;
+
+		per_cpu(dvfs_update_delay, cpu) = sg_policy->tunables->rate_limit_us;
 	}
 
 	if (policy_is_shared(policy))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2b889ad399de..e06e512af192 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3001,6 +3001,15 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
 u64 approximate_runtime(unsigned long util);
 
+/*
+ * Any governor that relies on util signal to drive DVFS, must populate these
+ * percpu dvfs_update_delay variables.
+ *
+ * It should describe the rate/delay at which the governor sends DVFS freq
+ * update to the hardware in us.
+ */
+DECLARE_PER_CPU_SHARED_ALIGNED(u64, dvfs_update_delay);
+
 /*
  * DVFS decision are made at discrete points. If CPU stays busy, the util will
  * continue to grow, which means it could need to run at a higher frequency
@@ -3010,20 +3019,14 @@ u64 approximate_runtime(unsigned long util);
  * to run at adequate performance point.
  *
  * This function provides enough headroom to provide adequate performance
- * assuming the CPU continues to be busy.
- *
- * At the moment it is a constant multiplication with 1.25.
+ * assuming the CPU continues to be busy. This headroom is based on the
+ * dvfs_update_delay of the cpufreq governor.
  *
- * TODO: The headroom should be a function of the delay. 25% is too high
- * especially on powerful systems. For example, if the delay is 500us, it makes
- * more sense to give a small headroom as the next decision point is not far
- * away and will follow the util if it continues to rise. On the other hand if
- * the delay is 10ms, then we need a bigger headroom so the CPU won't struggle
- * at a lower frequency if it never goes to idle until then.
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

