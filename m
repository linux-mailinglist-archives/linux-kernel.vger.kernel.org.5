Return-Path: <linux-kernel+bounces-60379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A08D85043C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4632D286F58
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659F3D561;
	Sat, 10 Feb 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox5pYG88"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC33D55A
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564986; cv=none; b=eKtS/Lclhm/odPbZgpgM9CY9M3T4dSshpm029E9pLOFOMz8VjihzipiaSgQGAD3d6V/kdO4YKjhoFW6hQz0fx6wuu9+R4kYJDqmFbNL+jFWbDK3SRBFgApWL7wgJtgsrLqA9gAttvhS/a/GWPNqWGnDAjJjubUflL7D/4P0LmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564986; c=relaxed/simple;
	bh=GN38axMpDXwM+LiQWv9rCHV4je3GH/IUMqqcPRYdILM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbvyYeIytnmikZLRFMQutzW/D1N2haLc/bfAYs/f8p2dJ4h81MwgF+OwTNyFm53hytUVpCTrQrCM1rtH6rP3JjiwBv3ifkLNxLoM4rtXCS/eCvNO6ynoy/unmU3a/dQvL8XQnyEKeDm/U/+S8dTF1Nn8Ld7VF8ZsEUrDMb3CHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox5pYG88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00256C43390;
	Sat, 10 Feb 2024 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707564985;
	bh=GN38axMpDXwM+LiQWv9rCHV4je3GH/IUMqqcPRYdILM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ox5pYG88JOmXeQa3kRbicKLfW7BrjOnejepA6G+79dw76I8L4Zb9sPD1+wnHMYSgV
	 le+MqIeltleerizblAE4U/xg/PtbQ9wKTzCrpfaBtBV7gvBlbB4nnGMG5pOsJbhfUC
	 R0njwsf+sv4BhUCJXGSMCwvgjcLRyiuBoU1TKrbTrtRpJqaBoQI0n9z+D9nqkH3o2N
	 mBnkpu4xB0WwOkTNl7GqySpAgao/asJeUH2visJksyhpzHdgeN/sx/Sb0D+yhsDavW
	 o8wnX6SkAhmn+PX6GKYL+eRt6smqAn2OKm1va9lOx63m2m83gfdW/KkcSjYds+JDJM
	 GDqEePBQ4EKZQ==
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
	linux-kernel@vger.kernel.org (open list:SCHEDULER),
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v5 2/5] sched/fair: Remove unused parameters
Date: Sat, 10 Feb 2024 19:39:20 +0800
Message-ID: <20240210113924.1130448-2-alexs@kernel.org>
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

The argument sds is not used in function sched_asym(). Remove it.

Fixes: c9ca07886aaa ("sched/fair: Do not even the number of busy CPUs via asym_packing")
Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..607dc310b355 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9749,7 +9749,6 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 /**
  * sched_asym - Check if the destination CPU can do asym_packing load balance
  * @env:	The load balancing environment
- * @sds:	Load-balancing data with statistics of the local group
  * @sgs:	Load-balancing statistics of the candidate busiest group
  * @group:	The candidate busiest group
  *
@@ -9768,8 +9767,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * otherwise.
  */
 static inline bool
-sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
-	   struct sched_group *group)
+sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
 {
 	/* Ensure that the whole local core is idle, if applicable. */
 	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
@@ -9940,7 +9938,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_asym(env, sds, sgs, group)) {
+	    sched_asym(env, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
-- 
2.43.0


