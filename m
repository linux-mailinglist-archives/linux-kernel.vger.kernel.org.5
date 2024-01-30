Return-Path: <linux-kernel+bounces-44685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F6784261C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEC1B26C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ED86E2B4;
	Tue, 30 Jan 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd3ps/Y4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043936BB4E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620470; cv=none; b=PPNlMcd5Su4bp3C+wepRGJ8R2NTbA3OFhskt0lIyNAvjWloJ/KxCYxEOtDNeAdA5yRgF25g0g9zcyvs4aXHd3yVCcxVxzWHjWvZTdBgE6jfCwG6WgJvEKWP7zi+N6m0GfUg7Dpcvh2CoDsxF5DNDJ9i5kDky/rmRZh3pfAWgWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620470; c=relaxed/simple;
	bh=c/1WLOAzJwWvvX/sgjls1EE1+Z+vkWbOlUsZdDywdRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4AYmrzN0iB9ZRTbbx7TAuVBwAszXGlc+GQk2SvI/GawBI5UPqqgSuELlht2yAFzv3daalJ4gP8Hj8pReuCUlGSL2E5aR6ifTcmFMS42jq9PoaymI4CxT7QiRiB+QEBy6uwz8Ea0Cn9e6IfZAhvfKKpbww3aPC9swicwV0qYcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd3ps/Y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC96C433C7;
	Tue, 30 Jan 2024 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620469;
	bh=c/1WLOAzJwWvvX/sgjls1EE1+Z+vkWbOlUsZdDywdRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hd3ps/Y4HblMhC0xw3r7X70E3ks/5ppE6tv6mPpnNsmQdi6REpusZYFZPRRa1SK/X
	 INqbcdzMpKf2995ytotNzgE4BlgYua8EyVDtoQpUrzcWsJPqW0ChoyhzrP0FQnAW9E
	 WLk2kenCEZtpYj36bH1JgoZkxCEHSVfXRhHSHGktvuuSrP5FjEySvCUGNjvKQwi3lQ
	 NUzC6pZgq0zxSaXbBXQk1+enHWi5odj3VXDkfEMKTFvpbui92TbM+PHI+eDJu54QLr
	 x0DrFmYXKTaRRdKYGXNtxOQHFPO7emjI4370wjUbo5KBmP1Nk5D/urWWiDzCypGdYG
	 FefAncI4V72wA==
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
Subject: [PATCH v2 5/6] sched/fair: pack SD_ASYM_PACKING into sched_use_asym_prio
Date: Tue, 30 Jan 2024 21:17:07 +0800
Message-ID: <20240130131708.429425-5-alexs@kernel.org>
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

Then the flags check passed into sched_asym and sched_group_asym.
It's a code cleanup, no func changes.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Ben Segall <bsegall@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Valentin Schneider <vschneid@redhat.com>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 835dbe77b260..6680cb39c787 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9741,6 +9741,9 @@ group_type group_classify(unsigned int imbalance_pct,
  */
 static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 {
+	if (!(sd->flags & SD_ASYM_PACKING))
+		return false;
+
 	return (!sched_smt_active()) ||
 		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
 }
@@ -9935,11 +9938,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_weight = group->group_weight;
 
 	/* Check if dst CPU is idle and preferred to this group */
-	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
-	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_group_asym(env, sgs, group)) {
+	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+			sched_group_asym(env, sgs, group))
 		sgs->group_asym_packing = 1;
-	}
 
 	/* Check for loaded SMT group to be balanced to dst CPU */
 	if (!local_group && smt_balance(env, sgs, group))
@@ -11035,9 +11036,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * If balancing between cores, let lower priority CPUs help
 		 * SMT cores with more than one busy sibling.
 		 */
-		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_asym(env->sd, i, env->dst_cpu) &&
-		    nr_running == 1)
+		if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
 			continue;
 
 		switch (env->migration_type) {
@@ -11133,7 +11132,7 @@ asym_active_balance(struct lb_env *env)
 	 * the lower priority @env::dst_cpu help it. Do not follow
 	 * CPU priority.
 	 */
-	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
+	return env->idle != CPU_NOT_IDLE &&
 	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
 	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
 		!sched_use_asym_prio(env->sd, env->src_cpu));
-- 
2.43.0


