Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582B578A37A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjH0Xc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjH0XcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:32:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A7BC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fef34c33d6so25440055e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179140; x=1693783940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFkXrdnu5Rx2v27Ln35XCpmFb3Nev2JNuwy0cpVVUik=;
        b=tV+JFh5yfUALbSfnvJit1Ls+W13haR2OqiehBVxoysLZ1A0LrytBIiPFjMAQbyDhk4
         Bqxcrdw6O5hbx2Tw/lvMwBIfLu9V5ms7iNAPSJ7WLZyADO/vTT+TbPV0vGeUhHDVP99H
         jDIQEe46b44N7l3YXCD2Ldh6B89HaZl9myHyZ4jRNzRglI3NorSRF7YDonRl/640Gogz
         HEMD4wWvbKeBU68TJ6MmUs3Nphn/JsiklnRkfjaHIh1GI9WyP0kg3gjPby4UGptVfG5d
         dMP2uwS7kUL/1+/DRdgcJe1Zxpu15yQ4lL9IajJDxRdBCndh7+Lx5Tf5IjS5p1BBtr8k
         vMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179140; x=1693783940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFkXrdnu5Rx2v27Ln35XCpmFb3Nev2JNuwy0cpVVUik=;
        b=JKhdvlra6lB13EI/KnBI5Qs/HIg/XkIcOvTlcnpTGOGl2J25n4zd5jSS0sffkZeIkC
         JZSYKmfl5h7Tgpqd1nn1HM7u3WRZTt82BGFJyGRDCRsuGv4Gk+wCXjJWIvlSLCn2wzi8
         0TrFxMzyFjxS8hqw7b43ZU+i87NOjXzgB+BM30q6BxnwTP/5YBnZpaOALyhEojXvMtko
         yzREvBOkoGsg/40tvHTEThOG9lLWQ4DR7oE/zHeRp4tJ2yiK63LJGCY6r+YrUq0kIueE
         jskFC+tjcXNaxJw5e8g+PQqz4bvyffxXK2EWksFUkCzOfDEd5VR/jctFF0/gUW9XEr1L
         Hcyg==
X-Gm-Message-State: AOJu0YyHkEovmpbU3klYCG4TRj5Onq2fYlVXBWjeEAjqvq8GN9GvmVAC
        ixZP/k8FUQb1q0LFcwcSI6hWOw==
X-Google-Smtp-Source: AGHT+IHuAYCkgo8BfKdgfPY4aun2VqisJcq5tzm5YC1Ri/kzZxza+pgOcrBisI+Ilsf+fWbIejFWaA==
X-Received: by 2002:a05:600c:2297:b0:401:b204:3b8d with SMTP id 23-20020a05600c229700b00401b2043b8dmr7055779wmf.27.1693179139958;
        Sun, 27 Aug 2023 16:32:19 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm12220395wmk.2.2023.08.27.16.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:32:19 -0700 (PDT)
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
Subject: [RFC PATCH 6/7] sched/pelt: Introduce PELT multiplier
Date:   Mon, 28 Aug 2023 00:32:02 +0100
Message-Id: <20230827233203.1315953-7-qyousef@layalina.io>
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

From: Vincent Donnefort <vincent.donnefort@arm.com>

The new sched_pelt_multiplier boot param allows a user to set a clock
multiplier to x2 or x4 (x1 being the default). This clock multiplier
artificially speeds up PELT ramp up/down similarly to use a faster
half-life than the default 32ms.

  - x1: 32ms half-life
  - x2: 16ms half-life
  - x4: 8ms  half-life

Internally, a new clock is created: rq->clock_task_mult. It sits in the
clock hierarchy between rq->clock_task and rq->clock_pelt.

The param is set as read only and can only be changed at boot time via

	kernel.sched_pelt_multiplier=[1, 2, 4]

PELT has a big impact on the overall system response and reactiveness to
change. Smaller PELT HF means it'll require less time to reach the
maximum performance point of the system when the system become fully
busy; and equally shorter time to go back to lowest performance point
when the system goes back to idle.

This faster reaction impacts both dvfs response and migration time
between clusters in HMP system.

Smaller PELT values are expected to give better performance at the cost
of more power. Under powered systems can particularly benefit from
smaller values. Powerful systems can still benefit from smaller values
if they want to be tuned towards perf more and power is not the major
concern for them.

This combined with respone_time_ms from schedutil should give the user
and sysadmin a deterministic way to control the triangular power, perf
and thermals for their system. The default response_time_ms will half
as PELT HF halves.

Update approximate_{util_avg, runtime}() to take into account the PELT
HALFLIFE multiplier.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
[Converted from sysctl to boot param and updated commit message]
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/pelt.c  | 52 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/pelt.h  | 42 +++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  1 +
 4 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f56eb44745a8..42ed86a6ad3c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -745,7 +745,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
-	update_rq_clock_pelt(rq, delta);
+	update_rq_clock_task_mult(rq, delta);
 }
 
 void update_rq_clock(struct rq *rq)
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index f673b9ab92dc..24886bab0f91 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -468,6 +468,54 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 }
 #endif /* CONFIG_HAVE_SCHED_AVG_IRQ */
 
+__read_mostly unsigned int sched_pelt_lshift;
+static unsigned int sched_pelt_multiplier = 1;
+
+static int set_sched_pelt_multiplier(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_int(val, kp);
+	if (ret)
+		goto error;
+
+	switch (sched_pelt_multiplier)  {
+	case 1:
+		fallthrough;
+	case 2:
+		fallthrough;
+	case 4:
+		WRITE_ONCE(sched_pelt_lshift,
+			   sched_pelt_multiplier >> 1);
+		break;
+	default:
+		ret = -EINVAL;
+		goto error;
+	}
+
+	return 0;
+
+error:
+	sched_pelt_multiplier = 1;
+	return ret;
+}
+
+static const struct kernel_param_ops sched_pelt_multiplier_ops = {
+	.set = set_sched_pelt_multiplier,
+	.get = param_get_int,
+};
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+/* XXX: should we use sched as prefix? */
+#define MODULE_PARAM_PREFIX "kernel."
+module_param_cb(sched_pelt_multiplier, &sched_pelt_multiplier_ops, &sched_pelt_multiplier, 0444);
+MODULE_PARM_DESC(sched_pelt_multiplier, "PELT HALFLIFE helps control the responsiveness of the system.");
+MODULE_PARM_DESC(sched_pelt_multiplier, "Accepted value: 1 32ms PELT HALIFE - roughly 200ms to go from 0 to max performance point (default).");
+MODULE_PARM_DESC(sched_pelt_multiplier, "                2 16ms PELT HALIFE - roughly 100ms to go from 0 to max performance point.");
+MODULE_PARM_DESC(sched_pelt_multiplier, "                4  8ms PELT HALIFE - roughly  50ms to go from 0 to max performance point.");
+
 /*
  * Approximate the new util_avg value assuming an entity has continued to run
  * for @delta us.
@@ -482,7 +530,7 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 	if (unlikely(!delta))
 		return util;
 
-	accumulate_sum(delta, &sa, 0, 0, 1);
+	accumulate_sum(delta << sched_pelt_lshift, &sa, 0, 0, 1);
 	___update_load_avg(&sa, 0);
 
 	return sa.util_avg;
@@ -494,7 +542,7 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 u64 approximate_runtime(unsigned long util)
 {
 	struct sched_avg sa = {};
-	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 delta = 1024 << sched_pelt_lshift; // period = 1024 = ~1ms
 	u64 runtime = 0;
 
 	if (unlikely(!util))
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 3a0e0dc28721..9b35b5072bae 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -61,6 +61,14 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	WRITE_ONCE(avg->util_est.enqueued, enqueued);
 }
 
+static inline u64 rq_clock_task_mult(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	assert_clock_updated(rq);
+
+	return rq->clock_task_mult;
+}
+
 static inline u64 rq_clock_pelt(struct rq *rq)
 {
 	lockdep_assert_rq_held(rq);
@@ -72,7 +80,7 @@ static inline u64 rq_clock_pelt(struct rq *rq)
 /* The rq is idle, we can sync to clock_task */
 static inline void _update_idle_rq_clock_pelt(struct rq *rq)
 {
-	rq->clock_pelt  = rq_clock_task(rq);
+	rq->clock_pelt = rq_clock_task_mult(rq);
 
 	u64_u32_store(rq->clock_idle, rq_clock(rq));
 	/* Paired with smp_rmb in migrate_se_pelt_lag() */
@@ -121,6 +129,27 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 	rq->clock_pelt += delta;
 }
 
+extern unsigned int sched_pelt_lshift;
+
+/*
+ * absolute time   |1      |2      |3      |4      |5      |6      |
+ * @ mult = 1      --------****************--------****************-
+ * @ mult = 2      --------********----------------********---------
+ * @ mult = 4      --------****--------------------****-------------
+ * clock task mult
+ * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
+ * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
+ *
+ */
+static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
+{
+	delta <<= READ_ONCE(sched_pelt_lshift);
+
+	rq->clock_task_mult += delta;
+
+	update_rq_clock_pelt(rq, delta);
+}
+
 /*
  * When rq becomes idle, we have to check if it has lost idle time
  * because it was fully busy. A rq is fully used when the /Sum util_sum
@@ -147,7 +176,7 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 	 * rq's clock_task.
 	 */
 	if (util_sum >= divider)
-		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
+		rq->lost_idle_time += rq_clock_task_mult(rq) - rq->clock_pelt;
 
 	_update_idle_rq_clock_pelt(rq);
 }
@@ -218,13 +247,18 @@ update_irq_load_avg(struct rq *rq, u64 running)
 	return 0;
 }
 
-static inline u64 rq_clock_pelt(struct rq *rq)
+static inline u64 rq_clock_task_mult(struct rq *rq)
 {
 	return rq_clock_task(rq);
 }
 
+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+	return rq_clock_task_mult(rq);
+}
+
 static inline void
-update_rq_clock_pelt(struct rq *rq, s64 delta) { }
+update_rq_clock_task_mult(struct rq *rq, s64 delta) { }
 
 static inline void
 update_idle_rq_clock_pelt(struct rq *rq) { }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e06e512af192..896b6655397c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1023,6 +1023,7 @@ struct rq {
 	u64			clock;
 	/* Ensure that all clocks are in the same cache line */
 	u64			clock_task ____cacheline_aligned;
+	u64			clock_task_mult;
 	u64			clock_pelt;
 	unsigned long		lost_idle_time;
 	u64			clock_pelt_idle;
-- 
2.34.1

