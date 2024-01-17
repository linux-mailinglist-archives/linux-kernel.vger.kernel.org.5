Return-Path: <linux-kernel+bounces-28675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1638301B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57341F266CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749CF1DFEA;
	Wed, 17 Jan 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5oOdbwq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE521DFE0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481767; cv=none; b=klpbYHscCguqAkmbFE99gcpMJJ5uejt2yWPWOsLYM1EFfc0qkjCGwZ5EhBPyi3uRj4KatTutsLVcv2VRAOuk1neGLWUvuDs5aLAoqEkoYnLQMIuhcqDCPJjrXRPNvrcuq8nw4dI8jER7egM/Q2BQIpl/C71B87mQsUvtb5JPvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481767; c=relaxed/simple;
	bh=k/XnvnANSn1/1XeK7SQmCxa/M+A9XuFnbnGv+ODyieI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Hsv4KNCxLCig6Zn2UwaavQlTQd124tGqkmfnjtORxDi3d6LX6ofBNIvSy3ZpXCUOXpMHEcvxv4eIa6keds93O1np2y+DmTMq0/QkzOBSKgyaV/RvmsFwR1HTKN1zsKiMvpruV7/lo/rBHEoycylW6FppVgmgr8a/zTyz6gQR5BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5oOdbwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B3CC433C7;
	Wed, 17 Jan 2024 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705481767;
	bh=k/XnvnANSn1/1XeK7SQmCxa/M+A9XuFnbnGv+ODyieI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5oOdbwqQyQQafn4WtYMvSxEw4G3fIkEbcvuDzTS8o2SJkGULupMyVxN87xUfDv0K
	 wcJoZ6EtcZ+/bZNKFROiDgqcXwvs2QK2Xe5CcVTyzeuSjzmG4TS3P9mH1ue5qp3MjQ
	 wKctT0PrUMaey8rWWw73LBnPbY/jHoDmPNI8BWgTUWH/lvEb+Ogqus5UbR4IJPAI2y
	 yvpFe/fpwpCH2RcTbilkAug1JvyVNW4tPOzqb706smaNzAX6JaTsovpVXghmMZh/Iv
	 iRHKP1rzQCUgo0AcFFovvSOGeSXUWCWZ03Gi5xWHXP/CLr/vRfRAOXwlyzbJOjnMTx
	 BBlGTRCh8CJlQ==
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
Subject: [PATCH 4/5] sched/fair: add a func _sched_asym
Date: Wed, 17 Jan 2024 16:57:14 +0800
Message-ID: <20240117085715.2614671-4-alexs@kernel.org>
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

Use this func in sched_asym and other path to simply code.
No function change.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebd659af2d78..96163ab69ae0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9745,6 +9745,14 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
 }
 
+static inline bool _sched_asym(struct sched_domain *sd,
+			int dst_cpu, int repl_cpu)
+{
+	/* Ensure that the whole local core is idle, if applicable. */
+	return sched_use_asym_prio(sd, dst_cpu) &&
+			sched_asym_prefer(dst_cpu, repl_cpu);
+}
+
 /**
  * sched_asym - Check if the destination CPU can do asym_packing load balance
  * @env:	The load balancing environment
@@ -9768,20 +9776,13 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 static inline bool
 sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
 {
-	/* Ensure that the whole local core is idle, if applicable. */
-	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
-		return false;
-
 	/*
 	 * CPU priorities does not make sense for SMT cores with more than one
 	 * busy sibling.
 	 */
-	if (group->flags & SD_SHARE_CPUCAPACITY) {
-		if (sgs->group_weight - sgs->idle_cpus != 1)
-			return false;
-	}
-
-	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+	return !(group->flags & SD_SHARE_CPUCAPACITY &&
+			sgs->group_weight - sgs->idle_cpus != 1) &&
+		_sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
 }
 
 /* One group has more than one SMT CPU while the other group does not */
@@ -11036,8 +11037,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * SMT cores with more than one busy sibling.
 		 */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
-		    sched_use_asym_prio(env->sd, i) &&
-		    sched_asym_prefer(i, env->dst_cpu) &&
+		    _sched_asym(env->sd, i, env->dst_cpu) &&
 		    nr_running == 1)
 			continue;
 
@@ -11907,8 +11907,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * preferred CPU must be idle.
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_use_asym_prio(sd, i) &&
-			    sched_asym_prefer(i, cpu)) {
+			if (_sched_asym(sd, i, cpu)) {
 				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 				goto unlock;
 			}
-- 
2.43.0


