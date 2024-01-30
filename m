Return-Path: <linux-kernel+bounces-44684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D484260B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57229B262C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662236DD03;
	Tue, 30 Jan 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGMAktKI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E26DCFC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620466; cv=none; b=Fh+tjIvbUpit1/hcoFzl6qEQLDTQ0OJJENSy4DLVIGj8TChG3Q0r+FxcXpzp+qm+4bZpLmWH4FQv3rajGZqlKNn5POaWsh/CfJkIm9Ph2mGt9O7hsgYG1u7E1hSMbCGZ65r8WnbFUjKoLQ4FrZyPMwiSUfLt/P9QaPBGAP7f5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620466; c=relaxed/simple;
	bh=FRfl9LrFeYMC1cDiZLWNe9rb4nE8aM3Q/PfT7DsOvNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJR1qJ7Zeas6Of2nSgnt919XlxY3dHiKFpasxX+mi7d4MB1eiCtFcTbksSp6WVgzmogvIQB2se3JlIqgY2lJW4fPRJRv0T+OpX6lR7EaFF6/Eb+fjAtQVEHul3HKPGZb1pE93wAtX2w0fVuFiFrf3u+FON2cY5Z+DzCJ2ent3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGMAktKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9E3C43390;
	Tue, 30 Jan 2024 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620466;
	bh=FRfl9LrFeYMC1cDiZLWNe9rb4nE8aM3Q/PfT7DsOvNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGMAktKIPWx+UA6lRmEHNpsiezEGpGSZhakC+xSZTNJezazZntNRd/UXfwH3wyJwT
	 AJlyqQ237C2li/uyMCjkS9BHBWtrlMe70vUAmZR3nDzF6aam7rAG1dNwlL/4o+WBCe
	 6tq+HseJYkNtRsOmb2cbNVcD8GzLTQ3BjaPhZUn7JcYfh9XtFkM0v7Y1rtHwKCCb5N
	 cmE2vXxa04zgMiet1Kcg2EjjOr5AFWWSH/fzypKROew8Sy8AXAwFPslyHc7EU1YXSt
	 ljcLuQdgCw6Npaja2spDj3vElTzJwFkr3PYRpdlxF+csgON2Ml/pMJfqFX3SAgudTj
	 +IxCh0y/DbI/Q==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	ricardo.neri-calderon@linux.intel.com,
	sshegde@linux.ibm.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v2 4/6] sched/fair: packing func sched_use_asym_prio/sched_asym_prefer
Date: Tue, 30 Jan 2024 21:17:06 +0800
Message-ID: <20240130131708.429425-4-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130131708.429425-1-alexs@kernel.org>
References: <20240130131708.429425-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Packing the func sched_use_asym_prio/sched_asym_prefer into one, Using
new func to simply code. No function change.

Thanks Ricardo Neri for func rename and comments suggestion!

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebd659af2d78..835dbe77b260 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9745,8 +9745,15 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
 }
 
+static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
+{
+	/* Check if asym balance applicable, then check priorities.*/
+	return sched_use_asym_prio(sd, dst_cpu) &&
+		sched_asym_prefer(dst_cpu, src_cpu);
+}
+
 /**
- * sched_asym - Check if the destination CPU can do asym_packing load balance
+ * sched_group_asym - Check if the destination CPU can do asym_packing balance
  * @env:	The load balancing environment
  * @sgs:	Load-balancing statistics of the candidate busiest group
  * @group:	The candidate busiest group
@@ -9766,22 +9773,15 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * otherwise.
  */
 static inline bool
-sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
+sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
 {
-	/* Ensure that the whole local core is idle, if applicable. */
-	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
-		return false;
-
 	/*
-	 * CPU priorities does not make sense for SMT cores with more than one
+	 * CPU priorities do not make sense for SMT cores with more than one
 	 * busy sibling.
 	 */
-	if (group->flags & SD_SHARE_CPUCAPACITY) {
-		if (sgs->group_weight - sgs->idle_cpus != 1)
-			return false;
-	}
-
-	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+	return !(group->flags & SD_SHARE_CPUCAPACITY &&
+			sgs->group_weight - sgs->idle_cpus != 1) &&
+		sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
 }
 
 /* One group has more than one SMT CPU while the other group does not */
@@ -9937,7 +9937,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_asym(env, sgs, group)) {
+	    sched_group_asym(env, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
@@ -11036,8 +11036,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * SMT cores with more than one busy sibling.
 		 */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_use_asym_prio(env->sd, i) &&
-		    sched_asym_prefer(i, env->dst_cpu) &&
+		    sched_asym(env->sd, i, env->dst_cpu) &&
 		    nr_running == 1)
 			continue;
 
@@ -11907,8 +11906,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * preferred CPU must be idle.
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_use_asym_prio(sd, i) &&
-			    sched_asym_prefer(i, cpu)) {
+			if (sched_asym(sd, i, cpu)) {
 				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 				goto unlock;
 			}
-- 
2.43.0


