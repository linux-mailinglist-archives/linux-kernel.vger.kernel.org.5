Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318677D8768
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjJZRQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:16:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C835110A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:16:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c50906f941so17609061fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698340584; x=1698945384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAXugWJXz2tWF/v9bAEH0aP/gr53zAhiNlv87i6hDDw=;
        b=Zj74g7aNbNRxVYsFNVBeVCOzXEV86QA12J0IBenxyHBRFaE5RBtaNyhCg7A+uHsyQk
         qKvRjoxEy6SH2f/KHIZAuEiqrv1w9Li7gYWDX3xPAEtxoCYHcwxDsJ9kNn++XcC0ql6U
         uJ7rfyidhExFo/VKF3N81gfQHh85wbMlEpF2g0+JBAk3E2viEu5qGtiMYQxhs8gOzhzD
         5z7/CRdKiIg1Ru+KQTjydO5OzcZ6QUjR88fsONC0Sxc6NnkBeobyS/5PUAD1HMcaq2Z7
         Yzk5KVdcvG6VTfiI8oiKQa9PEvxk55IgWmxXhUIlaS6Nvm6rle9VAY0kVpzVoKlR1MgX
         cxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340584; x=1698945384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAXugWJXz2tWF/v9bAEH0aP/gr53zAhiNlv87i6hDDw=;
        b=GiY/2nQG0QFzbLthhcdlg3kx571DHXAkoO4R87HQP42JX3kKWm30u/5VCh74G+Abgm
         4q4nb1hL0gbzwRhuk2+X9yLTu40sYcSBkNX8GzWUXrVTUegR3/7X4e1p4oIp/k7uyB5W
         Me+8JO7HYizzak1I1u+sWdd6wscLqKoyHrGW8v2iou+vd21ORJOc99763xCBo6WSG6fI
         2wSRk6qVS5d1Wroi3CMBZ7ok+S8I/xxZaBhio5+z8uxeBBFvB4uzFSDPxO1yuKF2eo+Q
         g3gL61a0tPVhPpod1oSJR6SWjVJeRUJZE27yogrUfLjZ1nzePb0dmA9UBY+RKnmNBOeK
         lrkA==
X-Gm-Message-State: AOJu0Yzekc+ImCq0yjDBTTIpGg4NV22RVapamcWvg+/28zuAGJjh9rld
        C0uBcA+v68IVytZnSVj8ptMQoLQgCRC2i27nB9E=
X-Google-Smtp-Source: AGHT+IH0O3UAGl5mPHihC7aLhTtHwtvazXZHY8fNARSxJ2LCT1ghYVzamiZIcAE2bEzvR6/oMQZ+7w==
X-Received: by 2002:a2e:bc83:0:b0:2c3:3c0b:d747 with SMTP id h3-20020a2ebc83000000b002c33c0bd747mr185854ljf.17.1698340165456;
        Thu, 26 Oct 2023 10:09:25 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0040839fcb217sm3037721wmb.8.2023.10.26.10.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:09:24 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/2] sched/schedutil: rework iowait boost
Date:   Thu, 26 Oct 2023 19:09:13 +0200
Message-Id: <20231026170913.32605-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026170913.32605-1-vincent.guittot@linaro.org>
References: <20231026170913.32605-1-vincent.guittot@linaro.org>
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

Use the max value that has already been computed inside sugov_get_util()
to cap the iowait boost and remove dependency with uclamp_rq_util_with()
which is not used anymore.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 29 ++++++++-------
 kernel/sched/sched.h             | 60 --------------------------------
 2 files changed, 14 insertions(+), 75 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index be90d7ac0140..efd4b77471ab 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -177,11 +177,12 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 	return max(target, max);
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
@@ -274,18 +275,16 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
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
@@ -294,7 +293,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		sg_cpu->iowait_boost >>= 1;
 		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
 			sg_cpu->iowait_boost = 0;
-			return;
+			return 0;
 		}
 	}
 
@@ -304,10 +303,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
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
@@ -337,6 +333,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned long max_cap,
 					      unsigned int flags)
 {
+	unsigned long boost;
+
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -345,8 +343,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
 		return false;
 
-	sugov_get_util(sg_cpu);
-	sugov_iowait_apply(sg_cpu, time, max_cap);
+	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
+	sugov_get_util(sg_cpu, boost);
 
 	return true;
 }
@@ -447,9 +445,10 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
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

