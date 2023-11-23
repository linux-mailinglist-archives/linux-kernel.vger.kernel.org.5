Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4667F5CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbjKWKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKWKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:54:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C5619D;
        Thu, 23 Nov 2023 02:54:41 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:54:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700736880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2eFWnDEqxXSuc/cK5nLMNb9JQcyzISUrPlchF43Ms8=;
        b=MON0W2Va7AnkUWI4M72gKk2OtiVuDPNu2zAzZzUOMcUd3aJWOsztdpt6apxvAxCCn9wTbC
        7vnZPX0U6Vd/PuFJyM15S9AQsqCPouJm409m8T9Y9ebskX/LUk5ouNrObe99QS1NpGrnL1
        SgQZiSIUBfM2iGVZYqrD50Yu6JtP+4vqzig7zJxcBQBY90UpnAtPVCU8sYeZFn4C8rX8IA
        9V1GXH7DHhYa50OK2PGbttvuYcfG1cqtEzeVDEnr1AkjECPxDEyy5hAMbFGqzHOeZQK7ED
        Wo7FRncTk63kGfCwwdnEoE9Oo/vDRdBgEJnOlRDFkVkbjWTMnuC9ArU6scw5Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700736880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2eFWnDEqxXSuc/cK5nLMNb9JQcyzISUrPlchF43Ms8=;
        b=CzGCUfyP2GjpJ5dUBDDYxVCaMjJ7eupepc6xT6f4xNtwOb4oy+aBOUrvwfwHcwXgRH07OL
        ts1pNagfFHEst9BA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpufreq: Rework iowait boost
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231122133904.446032-3-vincent.guittot@linaro.org>
References: <20231122133904.446032-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <170073687956.398.18178236012727780020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f12560779f9d734446508f3df17f5632e9aaa2c8
Gitweb:        https://git.kernel.org/tip/f12560779f9d734446508f3df17f5632e9aaa2c8
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 22 Nov 2023 14:39:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Nov 2023 11:32:02 +01:00

sched/cpufreq: Rework iowait boost

Use the max value that has already been computed inside sugov_get_util()
to cap the iowait boost and remove dependency with uclamp_rq_util_with()
which is not used anymore.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20231122133904.446032-3-vincent.guittot@linaro.org
---
 kernel/sched/cpufreq_schedutil.c | 29 +++++++--------
 kernel/sched/sched.h             | 60 +-------------------------------
 2 files changed, 14 insertions(+), 75 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f3acf2c..4ee8ad7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -169,11 +169,12 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 	return max(min, max);
 }
 
-static void sugov_get_util(struct sugov_cpu *sg_cpu)
+static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 {
 	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
 
 	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
+	util = max(util, boost);
 	sg_cpu->bw_min = min;
 	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
 }
@@ -266,18 +267,16 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
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
@@ -286,7 +285,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		sg_cpu->iowait_boost >>= 1;
 		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
 			sg_cpu->iowait_boost = 0;
-			return;
+			return 0;
 		}
 	}
 
@@ -296,10 +295,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
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
@@ -329,6 +325,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned long max_cap,
 					      unsigned int flags)
 {
+	unsigned long boost;
+
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -337,8 +335,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
 		return false;
 
-	sugov_get_util(sg_cpu);
-	sugov_iowait_apply(sg_cpu, time, max_cap);
+	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
+	sugov_get_util(sg_cpu, boost);
 
 	return true;
 }
@@ -439,9 +437,10 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
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
index c1574cd..e58a54b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3058,59 +3058,6 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
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
@@ -3148,13 +3095,6 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
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
