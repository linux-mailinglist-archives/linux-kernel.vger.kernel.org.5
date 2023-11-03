Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065007E03B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377722AbjKCNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377627AbjKCNSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:18:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CE3D62
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:18:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4094301d505so16060875e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699017508; x=1699622308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMhZpNg5qvSUb3GObDAJDoBlrGoMrTREaqDW44ExX70=;
        b=KldbSS+EFCCP7HVG4VI4DBGVIrdCV/Hhtuf5rN3ln30/zJ63Q397n0YgVmnBmIy8ea
         /m0Eg8LOi9hQRn/g28Pxs28AQlkl6sB/yjRM3zEPQ6sbCHt9nnks/MT1uOaxGR/QyBcL
         Uj08CVfG+twi5E1aK16l4Cjh7W1CRNS/lrIsLXT9yRqzDmK7F5ChFP2de++Vd1JO9sUR
         Jj4nSPEgvxcxOKNo/clNX+j1RHc85HdQ1g9wEt4d/g3G5bYeWqPhOT8xdIjb4uTJqB/6
         ++SOQtkh7lwnbTwtqZzF7tD7GS9EPfkLfG/3R9x79cMpfN2RBOSTOZ67pUeuG+Nb3shj
         JTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017508; x=1699622308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMhZpNg5qvSUb3GObDAJDoBlrGoMrTREaqDW44ExX70=;
        b=dKM3MKQd2N/xcU6PdvB7Erm2hwieKP3X+vU5bXrXdKEO8lPIl4iXtUjSS4UHhw2t5x
         2I8Dj/Nk3uzsJc5EFv6a6Qhbw9KU3aImsds5poaj0uRLuuUI3s/k+ppOuEjKA/hAw6q+
         pbKlExgvY3ICr+Mw7P3I+JfgMtkTwJ89YJJeKUuWSyb2viDEuKFjNyFb5V8msxU98ZRn
         nOHZh6nZnEdQ7qarZYetwt4bJxv3/oeBObAWf+rVCClWGdXEiMWYluu9B6vDM0cotTcO
         yItM9gXR1g3k0GZ4jl/f7lGxNulhsAPVhW2N7/LbF7Oddf8C6A2Q/8mDIlnBKm4zwEAC
         5sQQ==
X-Gm-Message-State: AOJu0YweQ7qQ3nDUaOLDf9inkjq5A53NJxYhNY1kxGNXIihSdogsGqpF
        emHgj71RxUjUGwlP/shk1JlxcQ==
X-Google-Smtp-Source: AGHT+IGWrAN/H+X8FEYNP67uf3M/vt9LdJmfFS0VyN03+MkYI7ACUhX0kx9ubSO+ftLUYUoii0blkA==
X-Received: by 2002:a05:600c:3d9a:b0:408:5ba9:d707 with SMTP id bi26-20020a05600c3d9a00b004085ba9d707mr17721293wmb.16.1699017507814;
        Fri, 03 Nov 2023 06:18:27 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d68ce000000b0032daf848f68sm1877565wrw.59.2023.11.03.06.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:18:26 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 2/2] sched/schedutil: Rework iowait boost
Date:   Fri,  3 Nov 2023 14:18:21 +0100
Message-Id: <20231103131821.1176294-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103131821.1176294-1-vincent.guittot@linaro.org>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the max value that has already been computed inside sugov_get_util()
to cap the iowait boost and remove dependency with uclamp_rq_util_with()
which is not used anymore.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 29 ++++++++-------
 kernel/sched/sched.h             | 60 --------------------------------
 2 files changed, 14 insertions(+), 75 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 38accd8c854b..068c895517fb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -174,11 +174,12 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 	return max(min, max);
 }
 
-static void sugov_get_util(struct sugov_cpu *sg_cpu)
+static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 {
 	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
 
 	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
+	util = max(util, boost);
 	sg_cpu->bw_min = map_util_perf(min);
 	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
 }
@@ -271,18 +272,16 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * This mechanism is designed to boost high frequently IO waiting tasks, while
  * being more conservative on tasks which does sporadic IO operations.
  */
-static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
+static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 			       unsigned long max_cap)
 {
-	unsigned long boost;
-
 	/* No boost currently required */
 	if (!sg_cpu->iowait_boost)
-		return;
+		return 0;
 
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sugov_iowait_reset(sg_cpu, time, false))
-		return;
+		return 0;
 
 	if (!sg_cpu->iowait_boost_pending) {
 		/*
@@ -291,7 +290,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		sg_cpu->iowait_boost >>= 1;
 		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
 			sg_cpu->iowait_boost = 0;
-			return;
+			return 0;
 		}
 	}
 
@@ -301,10 +300,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 	 * sg_cpu->util is already in capacity scale; convert iowait_boost
 	 * into the same scale so we can compare.
 	 */
-	boost = (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
-	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
-	if (sg_cpu->util < boost)
-		sg_cpu->util = boost;
+	return (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -334,6 +330,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned long max_cap,
 					      unsigned int flags)
 {
+	unsigned long boost;
+
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -342,8 +340,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
 		return false;
 
-	sugov_get_util(sg_cpu);
-	sugov_iowait_apply(sg_cpu, time, max_cap);
+	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
+	sugov_get_util(sg_cpu, boost);
 
 	return true;
 }
@@ -444,9 +442,10 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
+		unsigned long boost;
 
-		sugov_get_util(j_sg_cpu);
-		sugov_iowait_apply(j_sg_cpu, time, max_cap);
+		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
+		sugov_get_util(j_sg_cpu, boost);
 
 		util = max(j_sg_cpu->util, util);
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 302b451a3fd8..e3cb8e004bd1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3025,59 +3025,6 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
 }
 
-/**
- * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
- * @rq:		The rq to clamp against. Must not be NULL.
- * @util:	The util value to clamp.
- * @p:		The task to clamp against. Can be NULL if you want to clamp
- *		against @rq only.
- *
- * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
- *
- * If sched_uclamp_used static key is disabled, then just return the util
- * without any clamping since uclamp aggregation at the rq level in the fast
- * path is disabled, rendering this operation a NOP.
- *
- * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
- * will return the correct effective uclamp value of the task even if the
- * static key is disabled.
- */
-static __always_inline
-unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
-				  struct task_struct *p)
-{
-	unsigned long min_util = 0;
-	unsigned long max_util = 0;
-
-	if (!static_branch_likely(&sched_uclamp_used))
-		return util;
-
-	if (p) {
-		min_util = uclamp_eff_value(p, UCLAMP_MIN);
-		max_util = uclamp_eff_value(p, UCLAMP_MAX);
-
-		/*
-		 * Ignore last runnable task's max clamp, as this task will
-		 * reset it. Similarly, no need to read the rq's min clamp.
-		 */
-		if (uclamp_rq_is_idle(rq))
-			goto out;
-	}
-
-	min_util = max_t(unsigned long, min_util, uclamp_rq_get(rq, UCLAMP_MIN));
-	max_util = max_t(unsigned long, max_util, uclamp_rq_get(rq, UCLAMP_MAX));
-out:
-	/*
-	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
-	 * RUNNABLE tasks with _different_ clamps, we can end up with an
-	 * inversion. Fix it now when the clamps are applied.
-	 */
-	if (unlikely(min_util >= max_util))
-		return min_util;
-
-	return clamp(util, min_util, max_util);
-}
-
 /* Is the rq being capped/throttled by uclamp_max? */
 static inline bool uclamp_rq_is_capped(struct rq *rq)
 {
@@ -3115,13 +3062,6 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline
-unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
-				  struct task_struct *p)
-{
-	return util;
-}
-
 static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
 
 static inline bool uclamp_is_used(void)
-- 
2.34.1

