Return-Path: <linux-kernel+bounces-15544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B625E822DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD36B1C234D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325821A29B;
	Wed,  3 Jan 2024 12:57:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE76B19BCC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D95B152B;
	Wed,  3 Jan 2024 04:57:46 -0800 (PST)
Received: from e126645.nice.arm.com (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6AF2E3F64C;
	Wed,  3 Jan 2024 04:56:58 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 2/2] sched/fair: Use rq in idle_cpu_without()
Date: Wed,  3 Jan 2024 13:56:48 +0100
Message-Id: <20240103125648.194516-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103125648.194516-1-pierre.gondois@arm.com>
References: <20240103125648.194516-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idle_cpu_without() could receive a 'struct rq' instead of a
cpu number to avoid converting the cpu number to a 'struct rq'
two times. Indeed update_sg_wakeup_stats() already makes the
conversion.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 93e928e76959..d38fec26fd3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10184,15 +10184,13 @@ static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
 
 /**
  * idle_cpu_without - would a given CPU be idle without p ?
- * @cpu: the processor on which idleness is tested.
+ * @rq: the rq on which idleness is tested.
  * @p: task which should be ignored.
  *
  * Return: 1 if the CPU would be idle. 0 otherwise.
  */
-static int idle_cpu_without(int cpu, struct task_struct *p)
+static int idle_cpu_without(struct rq *rq, struct task_struct *p)
 {
-	struct rq *rq = cpu_rq(cpu);
-
 	if (rq->curr != rq->idle && rq->curr != p)
 		return 0;
 
@@ -10247,7 +10245,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		/*
 		 * No need to call idle_cpu_without() if nr_running is not 0
 		 */
-		if (!nr_running && idle_cpu_without(i, p))
+		if (!nr_running && idle_cpu_without(rq, p))
 			sgs->idle_cpus++;
 
 		/* Check if task fits in the CPU */
-- 
2.25.1


