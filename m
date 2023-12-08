Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9B809729
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjLHAYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444181AbjLHAYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:24:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057B5173C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:24:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-33349b3f99aso1598845f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995059; x=1702599859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhR18T0pl795l1uokayZxS7knBKykZG2R0Wh7Y1uyRw=;
        b=Plhi8pdnebPMWe8kgb9+o9Pz1IuoMKY0oZcZmNT4Bw7kDfx01XCrudolutc3wYM39p
         SULrJT4zhXQ3wKWImyLraQRHi9eWRegPaKXb8GbgpVSO+4U5jNHdWEcJ0qsUN3JPjxVQ
         DE1Zr6o3BES+hBF1e4cWPoi1vjXGCae/tvz8z2c1LHTHPrWHVpn83X61v6oVnjKqnGC3
         MMeBWO+hixdQztAmWsw0KXVvlKhm+qxg9e1he8f3cGKcE8r6FFr6wDHB5gli+zc2uzVk
         skv1igsi/pCaw4EqP6neufD+ewKC9P93V+fJGNtERq3f5SjZImh0gqkxyMMkC/n50Kx+
         9kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995059; x=1702599859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhR18T0pl795l1uokayZxS7knBKykZG2R0Wh7Y1uyRw=;
        b=jBwpkJnsMv461Uaxhz/4vWMSCBkz/7qP8yYcDGrHeAyA9URKUfsI9yksWjBRMVRfiY
         PeMmQji1+79UgggDMANnYnxAybyLQy+U4xSQc3uk72R/1U6ev+jTnXjB7lPXLTq/jolf
         bu5NzAHALH43J5921XHM2wbC5C6bWKQc+j2/gFLxrWTvYvZM9EuGDBKm9V2DkgWBWXlo
         WH2nYFki9xHyfymB+UHQuvYWrG2ZyeK2LJBu65Ny3EGUKL53RgchkECo6nPxtp0ACYGt
         07OKlXmUyhp84p3Im1aoFLECnx6R2sV8hMHw8DQClp1sEQY2Ya+AhG0L2qij8315ww5I
         W63A==
X-Gm-Message-State: AOJu0Yy2SZ3GkaGGWFCSfc2MqVHJenlEGeI9C8EagcuFNOp9Fp0volPk
        t9r1IyLEjNFgc29tGCR1t+soVg==
X-Google-Smtp-Source: AGHT+IHGV+dihn4V479bZq9OG6SLrPXcDvTxVqEsxDxJhTAT29NPCNJcjozrDlu2bVsOek2GebRGZw==
X-Received: by 2002:a05:600c:4b27:b0:40c:22b6:ce9d with SMTP id i39-20020a05600c4b2700b0040c22b6ce9dmr1891284wmp.141.1701995059146;
        Thu, 07 Dec 2023 16:24:19 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:24:18 -0800 (PST)
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
Subject: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
Date:   Fri,  8 Dec 2023 00:23:42 +0000
Message-Id: <20231208002342.367117-9-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208002342.367117-1-qyousef@layalina.io>
References: <20231208002342.367117-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index b4a1c8ea9e12..9c8626b4ddff 100644
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
index 00a1b9c1bf16..0a10e56f76c7 100644
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
 
-	accumulate_sum(delta, &sa, 1, 0, 1);
+	accumulate_sum(delta << sched_pelt_lshift, &sa, 1, 0, 1);
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
index bbece0eb053a..a7c89c623250 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1029,6 +1029,7 @@ struct rq {
 	u64			clock;
 	/* Ensure that all clocks are in the same cache line */
 	u64			clock_task ____cacheline_aligned;
+	u64			clock_task_mult;
 	u64			clock_pelt;
 	unsigned long		lost_idle_time;
 	u64			clock_pelt_idle;
-- 
2.34.1

