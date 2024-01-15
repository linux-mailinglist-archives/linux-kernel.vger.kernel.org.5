Return-Path: <linux-kernel+bounces-25914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 909E182D817
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444071F222A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A6F2BB06;
	Mon, 15 Jan 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nHMPZr4H"
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A2219E1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
	Content-Type; bh=iLvRjgtii0U9FsiG7za0k50TI4MDsT+FsH6CIxXQRL4=; b=nHMPZr4Hh5H7
	GbeQfTA5PEqm/hIjYuYcLWQZTBvuzBzefQ8BjRRSAsB3hGH1y0Zpb35humEe9Dxo5KBGDhw+48b9h
	sXozH/wJftQ2c1+yUMILYR8vUcof+oEkipmewKGqtKuLeA44yhsEjlXHBkoNacQePOv+GNYPINH/c
	pTcUEPTEfjWW4NLhdEnxt1FzSfM3j/qBeMxWZtG+tjn5LKuT43cxDzDsNGBNQ1ixj9pVXeWF1dHzb
	4bBaVw7eK1CnQiqPcczu1DpofHXJcD0eGO3fHxSCBGUOuzc28DWxd2FIQ0aZplMX+ipHWpejFIX0g
	wriD9OrRagE8D0yjkGAohg==;
Received: from [130.117.225.1] (helo=finist-alma9.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1rPKVW-008UGf-0M;
	Mon, 15 Jan 2024 11:50:45 +0100
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
	linux-kernel@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 RESEND] sched/fair: Do not scan non-movable tasks several times
Date: Mon, 15 Jan 2024 13:50:52 +0300
Message-Id: <20240115105052.398761-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
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
 kernel/sched/fair.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..920fb16e6e2f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11277,7 +11277,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		.dst_rq		= this_rq,
 		.dst_grpmask    = group_balance_mask(sd->groups),
 		.idle		= idle,
-		.loop_break	= SCHED_NR_MIGRATE_BREAK,
 		.cpus		= cpus,
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
@@ -11324,6 +11323,14 @@ static int load_balance(int this_cpu, struct rq *this_rq,
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
@@ -11386,13 +11393,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
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
@@ -11418,7 +11424,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 */
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
-				env.loop_break = SCHED_NR_MIGRATE_BREAK;
 				goto redo;
 			}
 			goto out_all_pinned;
-- 
2.39.3


