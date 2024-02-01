Return-Path: <linux-kernel+bounces-48038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB1784568B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EDD1F22DA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F1215DBBF;
	Thu,  1 Feb 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxVPFCiN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1D15DBB7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788323; cv=none; b=uLGOzrltwwApJ5dTapXrcGvT5201TXucQNyrFvk52ZGy9tRKb3JNW3MPO94teQVpCnZ9tonJ+/gjwloYYTAHG9p/bkKI09Kqc8mylO3TTux5+tG6xljI3AQli7FqWZ8U1d82Cp215KBKV/TroHG6KXgwJes6xokpytRzMbvqnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788323; c=relaxed/simple;
	bh=6fHb93UTc8nw6m+lpDs7DJDa48qUFCDPwdpwjwwbA0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwlyq5qbt1nexHDvA6M+fkNjTtWoEv1pBrYKISawwgaGsTBHMcaX/+9UbIvlw4d6HwbWkbL7dHtYODWHRhtCZoxiAGUo4L8ks/vsH1dDTUiyvDuXMWmvdKF5Xrvz7gohUvjJb9Sp63+TH1nro5NT+QjXz+E909wzPyBQI/9ZlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxVPFCiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BFAC43399;
	Thu,  1 Feb 2024 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788323;
	bh=6fHb93UTc8nw6m+lpDs7DJDa48qUFCDPwdpwjwwbA0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxVPFCiN8OEYMF9FTlrwAuCaeLGsIRSzaMVRL+BVdbieJsfaDfWDqMPfgRGfhbqmz
	 zgLCL5yX7umktKCuVTbTPc9kectKBzMw/rsWdh6zFTSGBE8NdEM5fValJhB73NIfGO
	 nvafsEfEFu35DijHeLpqA3fnMz3FXCd4J+XMUe5rHjOptzOrG/Ss+/xMVNEmqPPPsD
	 qMKFVJHgoKABTQPsulHyBvepMafTwjFoVk0Ne9sRUcCXa1XIRmOKDidWpFr7l9y6jB
	 ejE3rRd3w5uw/AkmpD4P5SexVXkLuDZ3e4wZH7ah9SXO0LKvTH7Jea46dwYSinSvtI
	 jNZkd+kkbe9rQ==
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
Subject: [PATCH v3 3/4] sched/fair: packing func sched_use_asym_prio()/sched_asym_prefer()
Date: Thu,  1 Feb 2024 19:54:46 +0800
Message-ID: <20240201115447.522627-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201115447.522627-1-alexs@kernel.org>
References: <20240201115447.522627-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Consolidate the functions sched_use_asym_prio() and sched_asym_prefer()
into one. and rename sched_asym() as sched_group_asym().
This makes the code easier to read. No functional changes.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8d70417f5125..44fd5e2ca642 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9747,8 +9747,15 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
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
@@ -9768,22 +9775,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
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
 
-	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+	if ((group->flags & SD_SHARE_CPUCAPACITY) &&
+	    (sgs->group_weight - sgs->idle_cpus != 1))
+		return false;
+
+	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
 }
 
 /* One group has more than one SMT CPU while the other group does not */
@@ -9939,7 +9942,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_asym(env, sgs, group)) {
+	    sched_group_asym(env, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
@@ -11038,8 +11041,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * SMT cores with more than one busy sibling.
 		 */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_use_asym_prio(env->sd, i) &&
-		    sched_asym_prefer(i, env->dst_cpu) &&
+		    sched_asym(env->sd, i, env->dst_cpu) &&
 		    nr_running == 1)
 			continue;
 
@@ -11909,8 +11911,7 @@ static void nohz_balancer_kick(struct rq *rq)
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


