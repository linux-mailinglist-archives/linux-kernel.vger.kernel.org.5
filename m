Return-Path: <linux-kernel+bounces-26092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DA282DB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BACE2826B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFB61798A;
	Mon, 15 Jan 2024 14:34:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD117743
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A047150C;
	Mon, 15 Jan 2024 06:35:29 -0800 (PST)
Received: from e126645.arm.com (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B64623F6C4;
	Mon, 15 Jan 2024 06:34:40 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH v2 2/3] sched/fair: Use rq in idle_cpu_without()
Date: Mon, 15 Jan 2024 15:34:25 +0100
Message-Id: <20240115143427.1820628-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115143427.1820628-1-pierre.gondois@arm.com>
References: <20240115143427.1820628-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idle_cpu_without() could receive a 'struct rq' instead of a
CPU number to avoid converting the CPU number to a 'struct rq'
two times. Indeed update_sg_wakeup_stats() already makes the
conversion.
idle_cpu_without() is also renamed to idle_rq_without()
to match the input parameter.

Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..97d9e0d32337 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10105,23 +10105,21 @@ static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
 }
 
 /**
- * idle_cpu_without - would a given CPU be idle without p ?
- * @cpu: the processor on which idleness is tested.
+ * idle_rq_without - would a given rq be idle without p ?
+ * @rq: the rq on which idleness is tested.
  * @p: task which should be ignored.
  *
- * Return: 1 if the CPU would be idle. 0 otherwise.
+ * Return: 1 if the rq would be idle. 0 otherwise.
  */
-static int idle_cpu_without(int cpu, struct task_struct *p)
+static int idle_rq_without(struct rq *rq, struct task_struct *p)
 {
-	struct rq *rq = cpu_rq(cpu);
-
 	if (rq->curr != rq->idle && rq->curr != p)
 		return 0;
 
 	/*
 	 * rq->nr_running can't be used but an updated version without the
 	 * impact of p on cpu must be used instead. The updated nr_running
-	 * be computed and tested before calling idle_cpu_without().
+	 * be computed and tested before calling idle_rq_without().
 	 */
 
 #ifdef CONFIG_SMP
@@ -10166,9 +10164,9 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		sgs->sum_nr_running += nr_running;
 
 		/*
-		 * No need to call idle_cpu_without() if nr_running is not 0
+		 * No need to call idle_rq_without() if nr_running is not 0
 		 */
-		if (!nr_running && idle_cpu_without(i, p))
+		if (!nr_running && idle_rq_without(rq, p))
 			sgs->idle_cpus++;
 
 		/* Check if task fits in the CPU */
-- 
2.25.1


