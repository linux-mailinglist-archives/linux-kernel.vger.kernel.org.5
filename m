Return-Path: <linux-kernel+bounces-55908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B484C340
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05571C247FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364CD1CF8D;
	Wed,  7 Feb 2024 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVqunjyh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF11CF80
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277461; cv=none; b=p8/kDztpGY8GF/53rdRr35G8KaapV4uAJQnUJCrgP8uKHAB4caApKQ00F6G8rwtnZaqyyUIwYfn7SZIrdEqLJ+imH99GeCn9x4hERrCF1zpEFP64y3k0836HkBaUx1ugEKGVuNPZoYEXa2MS+C8JMa+QXEAQ1+ux0AmvbPHVgiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277461; c=relaxed/simple;
	bh=JRihQeRnvMv6IBslLO3YQYd+JbOoJjzD4VVOTcl40hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Noh0DryfFOr5uoJz4+0xvrx29k90XL6ew0ohQoEfYaCDIL1Cy85PdC2wQLPeN7l/ghRRsnQqLxVG/Ob2TmAQDSmtLn2laFb1j2bq6WXOxYwkZdbWzkp7u0FiXmK3YjMi9vStyyGNVKuurmykNOmPo1rwkzxD9hmIFgPkEQxBztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVqunjyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4A7C433C7;
	Wed,  7 Feb 2024 03:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707277460;
	bh=JRihQeRnvMv6IBslLO3YQYd+JbOoJjzD4VVOTcl40hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVqunjyhj6v9iIXA7+241LS3sT9Zrqu2nctH3nylTQFehdPLbLm1Bh9DUwe2RVHEv
	 3SiRF9snGljzV3h3qluoCadqVVBBJ6y9bpUWjUG8/VRuAqnng08hvVWuRPtF/vJsdC
	 Nd/yS6E5P3GlrE1+sqsuIRu97G0px/UEftKWACDtSVYmjzoYevAeWtCeG9KS5NxgO/
	 cgHFPzBjQNUqa5zhVaSYSV96MqtsKFYN6J1eMy00l/XzypTsRiRygSbxE5TfFhux6y
	 zZYLiE4mAzS2C4jD5rkLx+nm9b0rbjYjctvzYmZ5vI0oR/SMWbLEh3oMPVcNc9LY5l
	 Mplk7d9HIqjYw==
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
Subject: [PATCH v4 4/4] sched/fair: Check the SD_ASYM_PACKING flag in sched_use_asym_prio()
Date: Wed,  7 Feb 2024 11:47:04 +0800
Message-ID: <20240207034704.935774-4-alexs@kernel.org>
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

sched_use_asym_prio() checks whether CPU priorities should be used. It
makes sense to check for the SD_ASYM_PACKING() inside the function.
Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
remove the now superfluous checks for the flag in various places.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
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
 kernel/sched/fair.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 942b6358f683..10ae28e1c088 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9740,6 +9740,9 @@ group_type group_classify(unsigned int imbalance_pct,
  */
 static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 {
+	if (!(sd->flags & SD_ASYM_PACKING))
+		return false;
+
 	if (!sched_smt_active())
 		return true;
 
@@ -9941,11 +9944,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_weight = group->group_weight;
 
 	/* Check if dst CPU is idle and preferred to this group */
-	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
-	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_group_asym(env, sgs, group)) {
+	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+	    sched_group_asym(env, sgs, group))
 		sgs->group_asym_packing = 1;
-	}
 
 	/* Check for loaded SMT group to be balanced to dst CPU */
 	if (!local_group && smt_balance(env, sgs, group))
@@ -11041,9 +11042,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * If balancing between cores, let lower priority CPUs help
 		 * SMT cores with more than one busy sibling.
 		 */
-		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_asym(env->sd, i, env->dst_cpu) &&
-		    nr_running == 1)
+		if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
 			continue;
 
 		switch (env->migration_type) {
@@ -11139,8 +11138,7 @@ asym_active_balance(struct lb_env *env)
 	 * the lower priority @env::dst_cpu help it. Do not follow
 	 * CPU priority.
 	 */
-	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
-	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
+	return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
 	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
 		!sched_use_asym_prio(env->sd, env->src_cpu));
 }
-- 
2.43.0


