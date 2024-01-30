Return-Path: <linux-kernel+bounces-44682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34108425EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EC01C2575E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F66D1A9;
	Tue, 30 Jan 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+rSmKXL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65406BB5E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620459; cv=none; b=fpKcYFwcR5LWsmDGjEBKaNl7GCDkUP+LLyiZAxUCe4cqa/9fDlBjsxoj0VqWrVi5t62Im+bzAbneFFi7mDCxJzFdSTcv49fGWBUnxZp6KgV163NijuXBwGdgbEzJWei7Aatj6Rof/PreBOHMRTcQ0p7iuvUs8ApFR9JBfHrkpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620459; c=relaxed/simple;
	bh=ju/4UGtzVW6SMMVqyOTJ6eGP1qKCB+pqoyI2kbcnF5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONHjn4+l6AEpkgkCJI5Ks9RPx9d4gjoCxc6tp1mJDuZ2D3a8uzrqloL8EkSHhmncEO6TupISlY1fwuGJBz1AyOcRQ98TadZKRjL888TaE4tj+ZX/BhmOWMwfj5tT5IeunYe5qnfYB/jJQWg4sJ2gzVhfgd3DAWTvFVdn1Hzykd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+rSmKXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492A9C43390;
	Tue, 30 Jan 2024 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620459;
	bh=ju/4UGtzVW6SMMVqyOTJ6eGP1qKCB+pqoyI2kbcnF5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+rSmKXLmTHihSSFyJ4yx5grOtzvxCwZlnzkXT6/iEIPoynRQj+uDJ8exj9aZSIXo
	 gd8YhhYRov+kTJhXjm1pDqTZtOHfgVUudtzlqDorAWeGvWHgX8O7qGkrxrwlF4+JSg
	 q6ahcfZ9EtXpX55r/h3oYBzuEVWDhNYoyaZ0C9XeIFEfq+QeXIKM0jbobVtN8fBrnX
	 cjlpxu0254qHcJ3DWA/uyaB1g0vxpOtHOqZnHEdHTFgI+y8Gq1ADKXiNhQImoXY1nF
	 Cx73dgHIv2wIt18YvX5h3+OUSk9c3KIk8SFZ5XTdtc6K0RlOWdAIQ4ZzRjQByfU/KH
	 20sKkZBjHz0eg==
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
Subject: [PATCH v2 2/6] sched/fair: remove unused parameters
Date: Tue, 30 Jan 2024 21:17:04 +0800
Message-ID: <20240130131708.429425-2-alexs@kernel.org>
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

sds isn't used in function sched_asym(), so remove it to cleanup code.

Signed-off-by: Alex Shi <alexs@kernel.org>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46ba8329b10a..8d70417f5125 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9750,7 +9750,6 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 /**
  * sched_asym - Check if the destination CPU can do asym_packing load balance
  * @env:	The load balancing environment
- * @sds:	Load-balancing data with statistics of the local group
  * @sgs:	Load-balancing statistics of the candidate busiest group
  * @group:	The candidate busiest group
  *
@@ -9769,8 +9768,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * otherwise.
  */
 static inline bool
-sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
-	   struct sched_group *group)
+sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
 {
 	/* Ensure that the whole local core is idle, if applicable. */
 	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
@@ -9941,7 +9939,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_asym(env, sds, sgs, group)) {
+	    sched_asym(env, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
-- 
2.43.0


