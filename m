Return-Path: <linux-kernel+bounces-88299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABA286DFD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3D1C22690
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CA06CDD1;
	Fri,  1 Mar 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh97PiU1"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F96BFD4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291402; cv=none; b=gq5E6s0eFjNxCx9SvQYtmMKx4EQiSJLe5JQBc527RkBlUpwmM525w2YfWmtidIpchX6O9dJvux5dQ5CtqJ+FrS8bwyrsuusRe1/DaNh7dWdqVHVbXrB9NWnfCyV1JVVFSpSEX4kaMIEG/WNPyo0M9Um4IilKAdZZEMSENLjj4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291402; c=relaxed/simple;
	bh=wGnnv0R/i5/PFNWqQGKADyW9AWcXKqVYmEaB4jhEARo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DS9AfkOUmaohriF5p75lHQqRSIvKJrvGztOkgaA9ZMSZXUKSL/Y/FGD0VfuhZsqgcFUq8HYivwyYP09kIvXDWkX4WetZPlmSNb7zuK2XLxzgMnZJXyJPekOUfE+vOrEmmHQjrNPNf3VHvjmXfM/ZUkyoAb3YrdohynZz0M896AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh97PiU1; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5131f3fc695so2055467e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291398; x=1709896198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqL84XLNVn0Cp5LtqkDs2ZJplR67S7lT/DN/daWYchI=;
        b=Vh97PiU1PGM9Bp9jBhkg+LDjmTR0z1kZWEYY9IYMAD/KXJ711X20hfu4aP2bg7f+0B
         VKua4AOUlPn3ohOMuoxa/Ik/faD72WpTkRpp2KvfuOiOS4ZvE3KlR9kEfjbe4ZnXSw4v
         JM2pn4+gaIvSjwUNj9YQFCNVylyZYoiH2rAV/depH2RjCwtpsw6jXiOsdR9sxHpwEMgD
         Y/l1u0RXGN1N9sThTmo/tCoasGmqpsetKMdHKXVagnNtSOEacM45eytoaUPCBEMp5XOD
         GAxrq8y0iyBkabzoumH9uqaaRXsD33/jqJbW9/l27jv5h2iciLLH8T7f0eKAfMY5XMcD
         jhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291398; x=1709896198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tqL84XLNVn0Cp5LtqkDs2ZJplR67S7lT/DN/daWYchI=;
        b=rmMJBQX55BY61EEikTiaiuR9KpM2+zBL+OCLoaQRuv3H7fxZ9Thq57xeLkF41EX6hv
         U/3TrjrRV5s1Y4ALgpCx3juYYhEXixO4SAwQ9lx6FXxosinJU49sLsfPUfBi/DkzawRS
         226E+Rgt5GE3/ExTeaCaWVLetJqOg0zqeRyRo5I3uXWHMUK1/JUZPhLRhs57juhneaRY
         SMC92p8LdjnVGLcb0NvukQcG84HCapzfK/j3b9azKywDUWZwaqYU3pGwre8ur/X5y4HH
         uk22753XHK8o7oomA+GCE3tJBrjzzI4k6IG8eKc+OgGvkFzeQW/YiV5rVsywRU0STjp4
         7yLg==
X-Gm-Message-State: AOJu0Yy44fuoCcVjvq9XCuUosVLHnWRfENgyGUXKOMS3OYaaZn6tI793
	1ghRnCKf1K2bSJUYlj7Ir+QRgp1uYcIJ3X2/U7s/d+geHsaiePSVvNE7sVii1mA=
X-Google-Smtp-Source: AGHT+IHupKWUY0EdwZIbjZg9mZUJXRc76nqyTBVtIc99+Q5/S+2RV61Oo6zZSnfGYuAUSvDkvRgwJQ==
X-Received: by 2002:ac2:5199:0:b0:513:1a9c:ae77 with SMTP id u25-20020ac25199000000b005131a9cae77mr896636lfi.52.1709291398405;
        Fri, 01 Mar 2024 03:09:58 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b00412cad66f8fsm490264wmq.44.2024.03.01.03.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:09:57 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 2/7] sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions
Date: Fri,  1 Mar 2024 12:09:46 +0100
Message-Id: <20240301110951.3707367-3-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301110951.3707367-1-mingo@kernel.org>
References: <20240301110951.3707367-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpu_idle_type enum has the confusingly inverted property
that 'not idle' is 1, and 'idle' is '0'.

This resulted in a number of unnecessary complications in the code.

Reverse the order, remove the CPU_NOT_IDLE type, and convert
all code to a natural boolean form.

It's much more readable:

  -       enum cpu_idle_type idle = this_rq->idle_balance ?
  -                                               CPU_IDLE : CPU_NOT_IDLE;
  -
  +       enum cpu_idle_type idle = this_rq->idle_balance;

  --------------------------------

  -       if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
  +       if (!env->idle || !busiest->sum_nr_running)

  --------------------------------

And gets rid of the double negation in these usages:

  -               if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
  +               if (env->idle && env->src_rq->nr_running <= 1)

Furthermore, this makes code much more obvious where there's
differentiation between CPU_IDLE and CPU_NEWLY_IDLE.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/sched/idle.h |  3 +--
 kernel/sched/fair.c        | 27 ++++++++++++---------------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 478084f9105e..4a6423700ffc 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -5,8 +5,7 @@
 #include <linux/sched.h>
 
 enum cpu_idle_type {
-	CPU_IDLE,
-	CPU_NOT_IDLE,
+	CPU_IDLE = 1,
 	CPU_NEWLY_IDLE,
 	CPU_MAX_IDLE_TYPES
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 64ae3d8dc93b..f11fc6dd39b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9070,7 +9070,7 @@ static int detach_tasks(struct lb_env *env)
 		 * We don't want to steal all, otherwise we may be treated likewise,
 		 * which could at worst lead to a livelock crash.
 		 */
-		if (env->idle != CPU_NOT_IDLE && env->src_rq->nr_running <= 1)
+		if (env->idle && env->src_rq->nr_running <= 1)
 			break;
 
 		env->loop++;
@@ -9803,7 +9803,7 @@ static inline bool smt_vs_nonsmt_groups(struct sched_group *sg1,
 static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 			       struct sched_group *group)
 {
-	if (env->idle == CPU_NOT_IDLE)
+	if (!env->idle)
 		return false;
 
 	/*
@@ -9827,7 +9827,7 @@ static inline long sibling_imbalance(struct lb_env *env,
 	int ncores_busiest, ncores_local;
 	long imbalance;
 
-	if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
+	if (!env->idle || !busiest->sum_nr_running)
 		return 0;
 
 	ncores_busiest = sds->busiest->cores;
@@ -9927,8 +9927,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				sgs->group_misfit_task_load = rq->misfit_task_load;
 				*sg_status |= SG_OVERLOAD;
 			}
-		} else if ((env->idle != CPU_NOT_IDLE) &&
-			   sched_reduced_capacity(rq, env->sd)) {
+		} else if (env->idle && sched_reduced_capacity(rq, env->sd)) {
 			/* Check for a task running on a CPU with reduced capacity */
 			if (sgs->group_misfit_task_load < load)
 				sgs->group_misfit_task_load = load;
@@ -9940,7 +9939,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_weight = group->group_weight;
 
 	/* Check if dst CPU is idle and preferred to this group */
-	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+	if (!local_group && env->idle && sgs->sum_h_nr_running &&
 	    sched_group_asym(env, sgs, group))
 		sgs->group_asym_packing = 1;
 
@@ -10698,7 +10697,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * waiting task in this overloaded busiest group. Let's
 			 * try to pull it.
 			 */
-			if (env->idle != CPU_NOT_IDLE && env->imbalance == 0) {
+			if (env->idle && env->imbalance == 0) {
 				env->migration_type = migrate_task;
 				env->imbalance = 1;
 			}
@@ -10913,7 +10912,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded) {
-		if (env->idle == CPU_NOT_IDLE) {
+		if (!env->idle) {
 			/*
 			 * If the busiest group is not overloaded (and as a
 			 * result the local one too) but this CPU is already
@@ -11121,7 +11120,7 @@ asym_active_balance(struct lb_env *env)
 	 * the lower priority @env::dst_cpu help it. Do not follow
 	 * CPU priority.
 	 */
-	return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
+	return env->idle && sched_use_asym_prio(env->sd, env->dst_cpu) &&
 	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
 		!sched_use_asym_prio(env->sd, env->src_cpu));
 }
@@ -11159,7 +11158,7 @@ static int need_active_balance(struct lb_env *env)
 	 * because of other sched_class or IRQs if more capacity stays
 	 * available on dst_cpu.
 	 */
-	if ((env->idle != CPU_NOT_IDLE) &&
+	if (env->idle &&
 	    (env->src_rq->cfs.h_nr_running == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
@@ -11735,8 +11734,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 				 * env->dst_cpu, so we can't know our idle
 				 * state even if we migrated tasks. Update it.
 				 */
-				idle = idle_cpu(cpu) ? CPU_IDLE : CPU_NOT_IDLE;
-				busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
+				idle = idle_cpu(cpu);
+				busy = !idle && !sched_idle_cpu(cpu);
 			}
 			sd->last_balance = jiffies;
 			interval = get_sd_balance_interval(sd, busy);
@@ -12416,9 +12415,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {
 	struct rq *this_rq = this_rq();
-	enum cpu_idle_type idle = this_rq->idle_balance ?
-						CPU_IDLE : CPU_NOT_IDLE;
-
+	enum cpu_idle_type idle = this_rq->idle_balance;
 	/*
 	 * If this CPU has a pending nohz_balance_kick, then do the
 	 * balancing on behalf of the other idle CPUs whose ticks are
-- 
2.40.1


