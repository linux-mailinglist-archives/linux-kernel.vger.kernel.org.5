Return-Path: <linux-kernel+bounces-28673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817508301B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B3F1F266FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AA31DDDB;
	Wed, 17 Jan 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr4207a5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354741DDC8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481762; cv=none; b=dH/RMScGauWz3Tqz8x9zLFb1hr+2BLkWdUCk/rVfibdUAXwp6FZj/nplgId5WnfieLlTwib2QFiRMSOoUztpZ1NyUJgdqfXTtpXpquWzxPHf1B5A8Sg3nHI6YuQqDmWKUM099IOtgaKgQbLmeALJXUPZi0fQFQMRRelccMs6lvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481762; c=relaxed/simple;
	bh=1gKV14yFhqUD2HBstqbx5w7q3LD/bVO0O+RqRHy8IH4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=AXHo1F7XOnK1aYIeCqiogaVmKe1r2hUQEdmwGtJCqdhr2conx2ZPlW7Jl/b9jEmNDJaz8XQrQ1rd8tEIbeMiCL72oEzfJpJ7WLtT5twmQilELx79aOhrYqnPHLgeRhSQqxJ1i1cn8p7z9BayHqYqK9msdJPX7oTtfxKHKo8wM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr4207a5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47565C433C7;
	Wed, 17 Jan 2024 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705481761;
	bh=1gKV14yFhqUD2HBstqbx5w7q3LD/bVO0O+RqRHy8IH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sr4207a50yCvAIl6nyqEr2IDuKxVplkzQScr+Xb9bXG7YxCon8rmCgEIgJYJmj1+N
	 rTyxiekUrGahQUF5ID/RaaPDjPoAPCPCztaRR7CHmDYIDMqr5Mmkxz/0St5M1zvQPf
	 F7cGQYQYDMS/y9MakUZGDkbZqxYUej039o7BlZZh5u0mNccL3kNeaNp9NhO15Vx4Z6
	 Z6DeaL/uahPcGuICiAYAkiXPngYbp954pa2nZ3XNQwQL+Xh2Wh1BOp6br2nOse/Nh2
	 n0SGlMzpk/RKOMXFLQmdslkjMDOjczRQElwk6pV51A3NkfCx3ksx4hGerf7gCozq+c
	 l/XGmc+3qdYOQ==
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
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 2/5] sched/fair: remove unused parameters
Date: Wed, 17 Jan 2024 16:57:12 +0800
Message-ID: <20240117085715.2614671-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117085715.2614671-1-alexs@kernel.org>
References: <20240117085715.2614671-1-alexs@kernel.org>
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


