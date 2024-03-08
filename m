Return-Path: <linux-kernel+bounces-96884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 852CB876293
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04F2B22849
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDFA56471;
	Fri,  8 Mar 2024 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ytr9j2hu"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91756444
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895561; cv=none; b=bPOj/77rhrI1VYdYgjwI5cGRc/ScpKSIq745vSoOrZV2krCjgXvnPADJ5SKHdHy3cy0W9KGIVZ+1C+3PSDS81MCAeBSu/ChsFNfOvbivZxN1Q3metab8i7jzwy54+MIxVXmQ4bM9bTDjaNodWNrekK01ZSp7UIJVcSYZHydhPW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895561; c=relaxed/simple;
	bh=IsD9VLCgHWQxmjX5aIcgnoL5USA9pg5IV19yprT6n3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sTscH0rvrXSbEqZpmsw+04k7JVdYfbHI71QHQcJQzBO3XJC1i8smZaaTs3e/5lfnxtTUEtHDz8CXbOU2ZRdiMziUeSCbS42SHznoW6H2rtD9wEoqzKzeNi4ubSUVgjA24xTjA3IX7JfMzLcXF8OMDPTIZZ69GCna6AvHlFU/gxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ytr9j2hu; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512bde3d197so1857758e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895558; x=1710500358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA33SUK/7qHtkaprcc+Lb3dKaC38v8lEQCVUVbmzndg=;
        b=Ytr9j2hu1lL3BPQZYpNoQ/WuHWMEx74Otfd2EcJzhjZPCbzKq0UQGS3gKm0fCQDhp4
         7zBY2lrkVSRSUKctHeGmHMZ8t0wx0EDxcXgD6eUWiZ59ecmI8UL/t6c0aVPqGayDyPqH
         xy0QRf/5loyVJBgWD04d4W6n9ZkGcQGqEEOB/hIb+fPqEI8VsDBFI7nBT6WWkde76NC9
         FGJxPA6IVGJMTO1ekganvfvXZlWAhwZXqK6Ycekf82B8Br/5b4MBl13h6ARGlXlQOMwb
         JUeK2O6vbnD8i0vlri/PAlGIqvxf253a77SXmA2di4mOogseuttzhuUo7RtGy5ffjyyI
         LMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895558; x=1710500358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tA33SUK/7qHtkaprcc+Lb3dKaC38v8lEQCVUVbmzndg=;
        b=FKUbEe8D5dsdEAXvcDDkHH39eaT+k3+iB+0XT7IWuFmW5smAlEbOWafUyCdFv0n2eZ
         kpiMXUaohbwj7c1IqCKYLsH7tI8aztlA7Q5bMcXDKj+kAOxix99R1vD+crQa1p2nUYpL
         2pjwQ7TZIfrbwxl0ZUpUpbNAwWcmPiq+csY/27+PBI5oN/waxvUfddf/1ZBgV1Yi04xM
         PYc+cjfcDzahQ6OOGEyi9rgLeZc0F9MdvQo1ciyvbcJvqW6fVLwQRaVzB8JBNpcI3AYA
         KH+YUJqtOLpBalOgq8Vlg3RESRQHKvlc7AD6B3ZyuYLjzW346TuXia8QHFt1WFF0YLuH
         2tvA==
X-Gm-Message-State: AOJu0Ywo6SitT+eh12QzMyw2ZrIkLpvPilgVfgaaQM75mXfn1HxTe7E6
	DPgvMyny44Zw9eoTPzishjsZ0YfjwIuWpmB/ZSIqeBnBTDEI1OLsGpU38GlN42w=
X-Google-Smtp-Source: AGHT+IFhttX7Kb3BJmXCqGr/TBUEKG/Yhv7fowEExAZuQPoHlQH0/EpWu9Ud1PLDoT73ZIylJYMPSw==
X-Received: by 2002:a19:ae0c:0:b0:513:2c92:4c95 with SMTP id f12-20020a19ae0c000000b005132c924c95mr3018872lfc.63.1709895557428;
        Fri, 08 Mar 2024 02:59:17 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:16 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 03/10] sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions
Date: Fri,  8 Mar 2024 11:58:54 +0100
Message-Id: <20240308105901.1096078-4-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308105901.1096078-1-mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
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
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/sched/idle.h |  2 +-
 kernel/sched/fair.c        | 27 ++++++++++++---------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 478084f9105e..e670ac282333 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -5,8 +5,8 @@
 #include <linux/sched.h>
 
 enum cpu_idle_type {
+	__CPU_NOT_IDLE = 0,
 	CPU_IDLE,
-	CPU_NOT_IDLE,
 	CPU_NEWLY_IDLE,
 	CPU_MAX_IDLE_TYPES
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ef89b36aed1..3a510cf1fb00 100644
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


