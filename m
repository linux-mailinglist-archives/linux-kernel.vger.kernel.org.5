Return-Path: <linux-kernel+bounces-48037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEFF84568A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0920C2834FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA815D5DB;
	Thu,  1 Feb 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+KXnWMX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D315D5BE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788320; cv=none; b=n7FNZ5ZDv2kE8jYYD1Y8UaEBCtJG82fqWHqgyqDaftRKjC/GtQ4z2i+PCfQWMGcTsQ6nBV2DuAwPmCg/aMVf72wLD+8+ircGpqEjVa2NrI49EZM5dEA642+whmgkUv8K2TjKJYbDnmE0r8+xDcrCH1eRjksS+meBTxDvBE8Lnx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788320; c=relaxed/simple;
	bh=ju/4UGtzVW6SMMVqyOTJ6eGP1qKCB+pqoyI2kbcnF5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otUe8GJ4a9SCqaJnihai60aUt4i6F93PH8YM18grSvyx35IFnjV4TnZb+rCnvBCpFBn6wqGCPojj09o9KzP30HJqlUv/X3vNGNWbNL0alxfjuI7vJVS2iw6n1iflrELoa033zTBLZFMbypdaO4BEVqnMBBkMXDwSzokUVdDR278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+KXnWMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE76C433F1;
	Thu,  1 Feb 2024 11:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788319;
	bh=ju/4UGtzVW6SMMVqyOTJ6eGP1qKCB+pqoyI2kbcnF5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+KXnWMXwhwHFTKJt6QVUJNK6XtR8bwisq9pN4aKgCFMi8QvURWfxy7fv5OVpv923
	 mpKvjbVUd6HL5Max7LczCta8jXD2UJl0fruvMQsTNUvBZ8zxcC3YbQe40xHf7yojaT
	 SBRPSqFCedZtI94XKAyVRrt4Yq1n/+ZLBixZOCqah2q3lq4PTXvOM/M//SyEbdY+66
	 4cyD83JcN++6cKgsvw34J0fW13E2k7TPVYEI/H/U58ClB4JgDVb5uuDmHPbsVKi3Jn
	 ycxyLj9tbJVeyHkqfZ82CFStW4/H2l8RLB58DX2oh4XOsTJC+C9hnOsy2SvAYxsx8w
	 2TkFTxQjlqkHw==
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
Subject: [PATCH v3 2/4] sched/fair: remove unused parameters
Date: Thu,  1 Feb 2024 19:54:45 +0800
Message-ID: <20240201115447.522627-2-alexs@kernel.org>
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


