Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B6080B15B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574944AbjLIBSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574920AbjLIBSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:18:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DE91720
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:18:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so23219435e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 17:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702084714; x=1702689514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH4HZJ/dfTu6217drQ+xYkdWR8mtBBjVdaWtH0+GlOI=;
        b=FFTAty1SiPExmVqQHNEjfqWQuxO2ToiPJyqvokMRzs5/3ARHvNosvra1wmuGzad0Ib
         /SReGWEMlD6IX35ViLQ7gKo+Wj3RuweS8+6H1xWUmrOpPpoHOqGZZ53YIB6QR+4/5KQy
         Va9hzuOazt10UwJJEWKEc6pCTnCLZhPihbQ2aO9qQvZLwkHzZW/R7VdzgWNhOIZY7eYV
         Yc0KHgYS88Xmv4+k6YfI+VBrtOJv9uc77pgWJCA2oMbSK+J6yDzgHQYnVzFFA5lNL0xx
         RdzN27P+UURFcFCPqGbf6zCY7nNyUZ5J/PDh/ndbA6zp3acGLUWUp8SZlKgO6qPJQc4Z
         9yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702084714; x=1702689514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH4HZJ/dfTu6217drQ+xYkdWR8mtBBjVdaWtH0+GlOI=;
        b=smnCx9uhtZ+uEeEFLczD8ju/ZePuA4ylJcECPDyoNMrD0SAbbYOFXzE69sUdY4MLJt
         0U1sFswYmnJG5zXartKii3o//rZdrS08UfdDwKo/HsmArjvX4rmq1Hh9RvRoTKklgjYl
         57nZijK2KnkCWmIknzeeCLOz99R5zm4bFIkRJEI05haK6XlEYox5afl10fnRl7BgOnWo
         sWo9HB7SocaVxNaIcL88iqU4mqtgOlQPBXVO2WQCr2DAkuXZi7yhH6W4H28TSz/9w5O8
         QfM2qOn9eWcFERlNtPTejyAdqtkHMQSJB4Hk5j1e518u4Qdhmre97wU7h/hUAM8plAYD
         9saA==
X-Gm-Message-State: AOJu0YwuIKGN8WSeXh4Zsky/aBPeGx9nMMURBT7vRU+qKxT2d7QZi9Qs
        TKNsjOFKiHeMFlSmPC6XjySzpA==
X-Google-Smtp-Source: AGHT+IHPTiL6sN7N3QRKUcLtrzsWb/jcO7SlI6eRSvxPNJa0OB4QQkWn1z6TzNmydH0IJqYSEI8org==
X-Received: by 2002:a05:600c:2e42:b0:40b:5f03:b3dd with SMTP id q2-20020a05600c2e4200b0040b5f03b3ddmr208478wmf.255.1702084713929;
        Fri, 08 Dec 2023 17:18:33 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm4772125wmq.43.2023.12.08.17.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 17:18:33 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH RFC 3/3] sched/fair: Implement new type of misfit MISFIT_POWER
Date:   Sat,  9 Dec 2023 01:17:59 +0000
Message-Id: <20231209011759.398021-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209011759.398021-1-qyousef@layalina.io>
References: <20231209011759.398021-1-qyousef@layalina.io>
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

MISFIT_POWER requires moving the task to a more efficient CPU.

This can happen when a big task is capped by uclamp_max, but another
task wakes up on this CPU that can lift the capping, in this case we
need to migrate it to another, likely smaller, CPU to save power.

To enable that we need to be smarter about which CPU should do the pull.
But this requires enabling load balance on all CPUs so that the correct
CPU does the pull. Instead of the current behavior of nominating the CPU
with the largest capacity in the group to do the pull.

This is important to ensure the MISFIT_POWER tasks don't end up on most
performant CPUs, which is the default behavior of the load balance.  We
could end up wasting energy unnecessarily or interfere with more
important tasks on these big CPUs - leading to worse user experience.

To ensure optimal decision is made, we need to enable calling feec() to
pick the most efficient CPU for us. Which means we need to force feec()
to ignore overutilized flag. If feec() returns the same value as the CPU
that is doing the balance, we perform the pull. Otherwise we'd have to
defer for another CPU to do the pull.

To minimize the overhead, this is only done for MISFIT_POWER.

For capacity aware scheduling or none HMP systems, we will pick a CPU
that we won't cause its uclamp_max to be uncapped.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c  | 77 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  1 +
 2 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dd49b89a6e3e..328467dbe88b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5066,10 +5066,33 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 static inline int is_misfit_task(struct task_struct *p, struct rq *rq,
 				 misfit_reason_t *reason)
 {
+	unsigned long rq_util_max;
+	unsigned long p_util_min;
+	unsigned long p_util_max;
+	unsigned long util;
+
 	if (!p || p->nr_cpus_allowed == 1)
 		return 0;
 
-	if (task_fits_cpu(p, cpu_of(rq)))
+	rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
+	p_util_min = uclamp_eff_value(p, UCLAMP_MIN);
+	p_util_max = uclamp_eff_value(p, UCLAMP_MAX);
+	util = task_util_est(p);
+
+	if (uclamp_is_used()) {
+		/*
+		* Check if a big task is capped by uclamp max is now sharing
+		* the cpu with something else uncapped and must be moved away
+		*/
+		if (rq_util_max > p_util_max && util > p_util_max) {
+			if (reason)
+				*reason = MISFIT_POWER;
+
+			return 1;
+		}
+	}
+
+	if (util_fits_cpu(util, p_util_min, p_util_max, cpu_of(rq)))
 		return 0;
 
 	if (reason)
@@ -7923,7 +7946,8 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
  * other use-cases too. So, until someone finds a better way to solve this,
  * let's keep things simple by re-using the existing slow path.
  */
-static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
+static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu,
+				     bool ignore_ou)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
@@ -7940,7 +7964,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || READ_ONCE(rd->overutilized))
+	if (!pd || (READ_ONCE(rd->overutilized) && !ignore_ou))
 		goto unlock;
 
 	/*
@@ -8144,7 +8168,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 			return cpu;
 
 		if (sched_energy_enabled()) {
-			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
+			new_cpu = find_energy_efficient_cpu(p, prev_cpu, false);
 			if (new_cpu >= 0)
 				return new_cpu;
 			new_cpu = prev_cpu;
@@ -9030,6 +9054,7 @@ static int detach_tasks(struct lb_env *env)
 {
 	struct list_head *tasks = &env->src_rq->cfs_tasks;
 	unsigned long util, load;
+	misfit_reason_t reason;
 	struct task_struct *p;
 	int detached = 0;
 
@@ -9118,9 +9143,28 @@ static int detach_tasks(struct lb_env *env)
 
 		case migrate_misfit:
 			/* This is not a misfit task */
-			if (!is_misfit_task(p, cpu_rq(env->src_cpu), NULL))
+			if (!is_misfit_task(p, cpu_rq(env->src_cpu), &reason))
 				goto next;
 
+			if (reason == MISFIT_POWER) {
+				if (sched_energy_enabled()) {
+					int new_cpu = find_energy_efficient_cpu(p, env->src_cpu, true);
+					if (new_cpu != env->dst_cpu)
+						goto next;
+				} else {
+					unsigned long dst_uclamp_max = uclamp_rq_get(env->dst_rq, UCLAMP_MAX);
+					unsigned long p_uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
+
+					/*
+					 * Pick a task that will not cause us
+					 * to uncap dst_cpu. Or give up until
+					 * another CPU tries to do the pull.
+					 */
+					if (p_uclamp_max > dst_uclamp_max)
+						goto next;
+				}
+			}
+
 			env->imbalance = 0;
 			break;
 		}
@@ -11203,6 +11247,18 @@ static int should_we_balance(struct lb_env *env)
 	if (!cpumask_test_cpu(env->dst_cpu, env->cpus))
 		return 0;
 
+	/*
+	 * For MISFIT_POWER, we need every CPU to do the lb so that we can pick
+	 * the most energy efficient one via EAS if available or by making sure
+	 * the dst_rq uclamp_max higher than the misfit task's uclamp_max.
+	 *
+	 * We don't want to do a pull if both src and dst cpus are in
+	 * MISFIT_POWER state.
+	 */
+	if (env->src_rq->misfit_reason == MISFIT_POWER &&
+	    env->dst_rq->misfit_reason != MISFIT_POWER)
+			return 1;
+
 	/*
 	 * In the newly idle case, we will allow all the CPUs
 	 * to do the newly idle load balance.
@@ -11431,8 +11487,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 * We do not want newidle balance, which can be very
 		 * frequent, pollute the failure counter causing
 		 * excessive cache_hot migrations and active balances.
+		 *
+		 * MISFIT_POWER can also trigger a lot of failed misfit
+		 * migrations as we need to ask every CPU to do the pull and
+		 * expectedly lots of failures will incur.
 		 */
-		if (idle != CPU_NEWLY_IDLE)
+		if (idle != CPU_NEWLY_IDLE && env.src_rq->misfit_reason != MISFIT_POWER)
 			sd->nr_balance_failed++;
 
 		if (need_active_balance(&env)) {
@@ -11515,8 +11575,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	 * repeatedly reach this code, which would lead to balance_interval
 	 * skyrocketing in a short amount of time. Skip the balance_interval
 	 * increase logic to avoid that.
+	 *
+	 * So does MISFIT_POWER which asks every CPU to do the pull as we can't
+	 * tell which one would be the best one to move to before hand.
 	 */
-	if (env.idle == CPU_NEWLY_IDLE)
+	if (env.idle == CPU_NEWLY_IDLE || env.src_rq->misfit_reason == MISFIT_POWER)
 		goto out;
 
 	/* tune up the balancing interval */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 399b6526afab..3852109ffe62 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -964,6 +964,7 @@ struct balance_callback {
 
 typedef enum misfit_reason {
 	MISFIT_PERF,		/* Requires moving to a more performant CPU */
+	MISFIT_POWER,		/* Requires moving to a more efficient CPU */
 } misfit_reason_t;
 
 /*
-- 
2.34.1

