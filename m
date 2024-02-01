Return-Path: <linux-kernel+bounces-48039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5274584568C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856BF1C255E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AB15DBDA;
	Thu,  1 Feb 2024 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvtSU/P5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3115DBB6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788327; cv=none; b=A1Ap8deo2sleAz4j78ZOUDKibXDTwUP1SzSoVN1sntJaHKa1uHr0cu3GdqdeRxChFVXWZ31X9ti5acHC0s+z7Jc+TPAfTcRUkIYPBoTJnYCBHZvK6S74Oc4st63XTpXxxCO3p8wPgQBsZRczE7dVsYLhgcGxQBlLfyY1ESCdQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788327; c=relaxed/simple;
	bh=ka9LtoyCvE401Vfn0WS2/PpohTLrZ5ojjcAJZr5Z/Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMCN5BtTsOw7vtUulWSQu4diEuULRM1/K36gTzFDq7wu4Y0iMJ+H8c8oVyEdQ6yeRyiPYZSHSgBFuItwe0V4qqOhWTydBStHVawV5c1M9p/vdMgrFg9bPcTFOzKW+BBK98VpCuouvLX/3Wwgz1pZ+XXCPeYtVrPejrSvEoRyqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvtSU/P5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B6AC433F1;
	Thu,  1 Feb 2024 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788327;
	bh=ka9LtoyCvE401Vfn0WS2/PpohTLrZ5ojjcAJZr5Z/Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PvtSU/P5U1/N9frNC/ZxKjQ/19PoMB2HY3//vZU0Ut17zcqCLAOySDBQpJN8+KZks
	 EpMFwaZ2kDkpbOPSVUxlwx6KuN9PO1Qlec+yyze3/5IIg9dWZd1Htw4Lead5h2gdIU
	 +AirSq8I77DAeBvtJ4JNRPRxUopnRZwD3AiaPjgYPe1yUQ17uyQuY5jmAlhUPF5sB6
	 oq/MqXbHD2GT5viM2ftMQklatuKUTasGd31RDzJwBMyJSVRlKVdEXu7/iWhp+oUqqN
	 wfjqCMo+W2qtWFcNcxxP9ViD/WZESlzgJLO0n2J5Huq3euqmNXWm+UcASryK6z/PUP
	 Sfvw2XyAbSgKA==
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
Subject: [PATCH v3 4/4] sched/fair: Check the SD_ASYM_PACKING flag in sched_use_asym_prio()
Date: Thu,  1 Feb 2024 19:54:47 +0800
Message-ID: <20240201115447.522627-4-alexs@kernel.org>
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

sched_use_asym_prio() checks whether CPU priorities should be used. It
makes sense to check for the SD_ASYM_PACKING() inside the function.
Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
remove the now superfluous checks for the flag in various places"

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
index 44fd5e2ca642..bd32efbea688 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9741,6 +9741,9 @@ group_type group_classify(unsigned int imbalance_pct,
  */
 static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 {
+	if (!(sd->flags & SD_ASYM_PACKING))
+		return false;
+
 	if (!sched_smt_active())
 		return true;
 
@@ -9940,11 +9943,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
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
@@ -11040,9 +11041,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * If balancing between cores, let lower priority CPUs help
 		 * SMT cores with more than one busy sibling.
 		 */
-		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_asym(env->sd, i, env->dst_cpu) &&
-		    nr_running == 1)
+		if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
 			continue;
 
 		switch (env->migration_type) {
@@ -11138,7 +11137,7 @@ asym_active_balance(struct lb_env *env)
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


