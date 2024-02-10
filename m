Return-Path: <linux-kernel+bounces-60380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D385043D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5597B23A60
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA523D964;
	Sat, 10 Feb 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPTNgJJJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C053D57A
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564990; cv=none; b=SOoyJ+HsN63GZjwpUtiN3C/dy13AeIaOP9TipS53N1Zut2z3hRTyaiHEbQg19rihPTjXYMS1C44eJz/LFmP7frg23FPo80hbyNnLPz5OmaZpXpgTrjVb14fWvDoKuHGYXoWahuo6DITeAeVECPILgOAirf9eg9iAS6Bfe8Z1d1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564990; c=relaxed/simple;
	bh=1Prw9eKOLc7XnYIr5gRAob0S2UL6jacinMD8Gm2WYdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Egjk2/N/xMLrjjBokei8igllw3P9auSDbz8+azQTYGuYE1Le8mQLYjJ9pDwRIB5Kugwk8UarUoYDGiU3PVdFUk1LPyH4BwSkigGBcOPEiVbbgA266yrZHG308LLh/yOH+v3l4aXQsMSnNWGx6pChuZ7j28bqK5xSf5ZcgjNXINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPTNgJJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D997C433F1;
	Sat, 10 Feb 2024 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707564989;
	bh=1Prw9eKOLc7XnYIr5gRAob0S2UL6jacinMD8Gm2WYdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPTNgJJJoqWOzrheU6wrV978/BrI/9/YQgRtoUDpe+kkI44Qmu6JZjehpwCk8I+oz
	 dgjxfEjpAJM01R8qbsg3zPGoLAsaaVSVrzkvo9T1NuMNEjquY+KhPVo/EvBAcAlVQR
	 kohn5lPFJz9UKh5TFmDnSy1YFsDB5k2ttBwNJSrwOqgWtNn5GFrxOJD14L6Yg6fufv
	 ewvEJdXpYaAAcDZuHH82WDgSZ0lLK9BdlS6PstLRI7PgtMxVRHiEWQt4aj8ZUKEJwY
	 Kd3eE/YHkO/TGPnC2YuwGrlNMxs3kNT7JLUMlkqsD1CxPe0N9lvD0UU+OXgQV1YJIT
	 KZ/NoNZMlhnAg==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: Alex Shi <alexs@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v5 3/5] sched/fair: Rework sched_use_asym_prio() and sched_asym_prefer()
Date: Sat, 10 Feb 2024 19:39:21 +0800
Message-ID: <20240210113924.1130448-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210113924.1130448-1-alexs@kernel.org>
References: <20240210113924.1130448-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

sched_use_asym_prio() and sched_asym_prefer() are used together in various
places. Consolidate them into a single function sched_asym().

The existing sched_group_asym() is only used when collecting statistics
of a scheduling group. Rename it as sched_group_asym(), and remove the
obsolete function description.

This makes the code easier to read. No functional changes.

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 kernel/sched/fair.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 607dc310b355..426eda9eda57 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9746,8 +9746,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
 }
 
+static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
+{
+	/*
+	 * First check if @dst_cpu can do asym_packing load balance. Only do it
+	 * if it has higher priority than @src_cpu.
+	 */
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
@@ -9755,34 +9765,21 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * @env::dst_cpu can do asym_packing if it has higher priority than the
  * preferred CPU of @group.
  *
- * SMT is a special case. If we are balancing load between cores, @env::dst_cpu
- * can do asym_packing balance only if all its SMT siblings are idle. Also, it
- * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
- * imbalances in the number of CPUS are dealt with in find_busiest_group().
- *
- * If we are balancing load within an SMT core, or at PKG domain level, always
- * proceed.
- *
  * Return: true if @env::dst_cpu can do with asym_packing load balance. False
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
+	if ((group->flags & SD_SHARE_CPUCAPACITY) &&
+	    (sgs->group_weight - sgs->idle_cpus != 1))
+		return false;
 
-	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
 }
 
 /* One group has more than one SMT CPU while the other group does not */
@@ -9938,7 +9935,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_asym(env, sgs, group)) {
+	    sched_group_asym(env, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
@@ -11037,8 +11034,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * SMT cores with more than one busy sibling.
 		 */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_use_asym_prio(env->sd, i) &&
-		    sched_asym_prefer(i, env->dst_cpu) &&
+		    sched_asym(env->sd, i, env->dst_cpu) &&
 		    nr_running == 1)
 			continue;
 
@@ -11908,8 +11904,7 @@ static void nohz_balancer_kick(struct rq *rq)
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


