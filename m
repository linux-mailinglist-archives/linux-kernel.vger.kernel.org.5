Return-Path: <linux-kernel+bounces-11114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35481E171
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58ACD1F22147
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2A52F64;
	Mon, 25 Dec 2023 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C/4Z9vgI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A896524CC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
	Content-Type; bh=HGaBq9ixKr+elVaP+1SDYfug/E6zNtqo5465zLHvM88=; b=C/4Z9vgINiPL
	DalMqX02e8xs08pOVG6Sa/vSxHpn6ni7MsipYkLlHEogcpwiBv3SPax6vaAYnVM2Snfoif0uq+xMh
	rEU1qvongQP+iEgj/8VRl05sT6o3Tg49++pPk7vigEcZNeech5ySEyGrXYMkXAkyP668ZOdI2YSOw
	rUTKK9oEXTQEyecgMgTJuf+1gCVDG1WMtaNiQ3y8zlx6YfmQ6IXsASc37jrW7C2we6Y3rMn1hgopp
	MLVkgKvkZnxsJubMKJaZrlh29SzEuVCKq02HGgTSyrR1SaJyGRkB5d0Y3QvBSMpwJ+kbnqi3gjLuK
	I6gxXjn6Gk3ak6059C9Hug==;
Received: from [130.117.225.1] (helo=finist-alma9.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1rHmrV-003pq0-1k;
	Mon, 25 Dec 2023 16:29:36 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: Do not scan non-movable tasks several times
Date: Mon, 25 Dec 2023 18:29:43 +0300
Message-Id: <20231225152943.2657849-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <2cf94373-4f25-4a33-a0b4-cab04031bae7@virtuozzo.com>
References: <2cf94373-4f25-4a33-a0b4-cab04031bae7@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK and all
tasks are not movable, detach_tasks() should not iterate more than tasks
available in the busiest rq.

Before commit: b0defa7ae03e ("sched/fair: Make sure to try to detach at
least one movable task"), the (env->loop > env->loop_max) condition
prevented us from scanning non-movable tasks more than rq size times,
but after we start checking the LBF_ALL_PINNED flag, the "all tasks are
not movable" case is under threat.

Note: in case all tasks in the rq could not be moved in detach_tasks()
we always increase loop_break by SCHED_NR_MIGRATE_BREAK, so we can step
over loop_max, but i think it's a rare case and does not worth adding
here extra check for rq->nr_running overlimit.

Fixes: b0defa7ae03e ("sched/fair: Make sure to try to detach at least
one movable task")

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
Changes:
v1->v2:
 * added the exact commit id caused the unefficiency + Fixes: tag
 * dropped a couple of extra redundunt env.loop_break assignments in
   load_balance()

 kernel/sched/fair.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..bd69c33fe9b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11219,7 +11219,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.dst_rq		= this_rq,
 		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
-		.loop_break	= SCHED_NR_MIGRATE_BREAK,
 		.cpus		= cpus,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
@@ -11266,6 +11265,14 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		 */
 		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
 
+more_balance_reset_break:
+		/*
+		 * If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK
+		 * and all tasks are not movable, detach_tasks() should not
+		 * iterate more than tasks available in rq.
+		 */
+		env.loop_break = min(SCHED_NR_MIGRATE_BREAK, busiest->nr_running);
+
 more_balance:
 		rq_lock_irqsave(busiest, &rf);
 		update_rq_clock(busiest);
@@ -11328,13 +11335,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			env.dst_cpu	 = env.new_dst_cpu;
 			env.flags	&= ~LBF_DST_PINNED;
 			env.loop	 = 0;
-			env.loop_break	 = SCHED_NR_MIGRATE_BREAK;
 
 			/*
 			 * Go back to "more_balance" rather than "redo" since we
 			 * need to continue with same src_cpu.
 			 */
-			goto more_balance;
+			goto more_balance_reset_break;
 		}
 
 		/*
@@ -11360,7 +11366,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 */
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
-				env.loop_break = SCHED_NR_MIGRATE_BREAK;
 				goto redo;
 			}
 			goto out_all_pinned;
-- 
2.39.3


