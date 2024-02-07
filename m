Return-Path: <linux-kernel+bounces-55907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479DB84C33F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489A91C24A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDCA1CD1B;
	Wed,  7 Feb 2024 03:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSWUTl5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28AF1C694
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277458; cv=none; b=nnjTJCf3epIqzGhG685VMDY5zNBwOF/n/vq9KDS8qRIB4eQNG6rk/soP1VZb9aVef4qXs6VZyUpLnoGtoR4/r/QcdSkIAWd0IzOCW+fZKI89B4Z50Z08Tp4JJvI79lWFmLEBDQOJjKWmzUIrRz//gGcdeU13bCdUc1GEsm2UXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277458; c=relaxed/simple;
	bh=ZBWabr/sl4BLAglGWdQysfp0ZTpL5iL55T/CdtsmPuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSs/rvFp8VYsn62nmeFgY4eEVAjKYN0oU9ZVRthPIlPC5zUPteTR7BGP17ysPHhoV2j/3W1OQv5HotN5yPzOAUIxDRIJwSXOQmGsI732Hq0Za5dkoP2sMPVEQ0NtG8T8R3MzcSqeGVNWEWstHlYwe2ALYcmlI0n18U1c0hbPFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSWUTl5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F2DC433F1;
	Wed,  7 Feb 2024 03:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707277457;
	bh=ZBWabr/sl4BLAglGWdQysfp0ZTpL5iL55T/CdtsmPuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSWUTl5MrVR3aRqaLNPAk0UvumXyYjyTudHP0DvKUQpEUu8DiZdBWzjLL3F7C8MED
	 JcjrVw3T/pkkEP/V/FSUU/hlGHNoNKKDoqC5ay/0S8uu8PGzom6PTfAzDgsq5PQN/X
	 BmFs3agVrqKEKfVS7TAVYDB2KztXTTEgQSTc1EA3hjRWZVOZeXGi21cr+Hi9bKlsjL
	 1NhuATAg6EMERrch94F3xAUivLqTF9dCXFOn9eRs8idRL+0uvdkQouBqL5mtghLeQa
	 CFYJo3eAVYuLP57L1h7rUcMlVMhqliBsYDtQfGEnLeFm46k1E53Ihf54MUq/VVPf+v
	 LvD1Obi8r8odA==
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
	yangyicong@hisilicon.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v4 3/4] sched/fair: Rework sched_use_asym_prio() and sched_asym_prefer()
Date: Wed,  7 Feb 2024 11:47:03 +0800
Message-ID: <20240207034704.935774-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207034704.935774-1-alexs@kernel.org>
References: <20240207034704.935774-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

sched_use_asym_prio() sched_asym_prefer() are used together in various
places. Consolidate them into a single function sched_asym().

The existing sched_group_asym() is only used when collecting statistics
of a scheduling group. Rename it as sched_group_asym().
This makes the code easier to read. No functional changes.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 607dc310b355..942b6358f683 100644
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
@@ -9767,22 +9777,17 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
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
@@ -9938,7 +9943,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_asym(env, sgs, group)) {
+	    sched_group_asym(env, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
@@ -11037,8 +11042,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * SMT cores with more than one busy sibling.
 		 */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_use_asym_prio(env->sd, i) &&
-		    sched_asym_prefer(i, env->dst_cpu) &&
+		    sched_asym(env->sd, i, env->dst_cpu) &&
 		    nr_running == 1)
 			continue;
 
@@ -11908,8 +11912,7 @@ static void nohz_balancer_kick(struct rq *rq)
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


