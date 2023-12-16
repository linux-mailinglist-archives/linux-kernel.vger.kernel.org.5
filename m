Return-Path: <linux-kernel+bounces-2235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA84815A04
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89721B22843
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EF92FE3A;
	Sat, 16 Dec 2023 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fs5U4g4B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5CF2E3E5
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GaTjV
	g2IaMxHh9YmDz9za8nhwGmWiOHYXGJH1Gbhsoc=; b=fs5U4g4Bj20Z3JunFayJ0
	DWdGRrQW9CmL/MAqiEjMmCO8+S6aLp9leVco0UuYXXisAPnC+g1Sr3Gm3dtQSQQU
	4H5pZMrAenJt7KyvwQHgDLo/h6h3lnQ0FOr0bv1e5TDui4Mti5gtMqD3YTeBB1Fn
	PiEQWzA1PXeOzqf/DEJolM=
Received: from ubuntu.lan (unknown [120.229.70.109])
	by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3_3zOxX1lzv7_AQ--.61139S2;
	Sat, 16 Dec 2023 23:44:16 +0800 (CST)
From: Junwen Wu <wudaemon@163.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	bsegall@google.com,
	vschneid@redhat.com
Cc: mgorman@suse.de,
	bristot@redhat.com,
	linux-kernel@vger.kernel.org,
	Junwen Wu <wudaemon@163.com>
Subject: [PATCH v1] sched/debug: Update print_task formatin  /sys/kernel/debug/sched/debug
Date: Sat, 16 Dec 2023 15:44:12 +0000
Message-Id: <20231216154412.613443-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_3zOxX1lzv7_AQ--.61139S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4kXr13Cw48KF1fuF4xCrg_yoW5Gryrpw
	nxAF17Jr4DXw1Ygw17Ar1kZr15Kry8t34UWrn7Ar18JF18A345Kr1Utr1xtry5Gr97tw1a
	qFs8tr17G3WDXrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbXowUUUUU=
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBkw1HbVc67KCubwADsX

For the sched_debug interface, print_task function  has  output
sum_exec_runtime twice, and the promt message not align with
the output, so optimize the output.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
 kernel/sched/debug.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4580a450700e..459109c12d68 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -579,13 +579,12 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
 		SPLIT_NS(p->se.deadline),
 		SPLIT_NS(p->se.slice),
-		SPLIT_NS(p->se.sum_exec_runtime),
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
@@ -596,10 +595,10 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_block_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
-	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
+	SEQ_printf(m, "   %d   %d", task_node(p), task_numa_group_id(p));
 #endif
 #ifdef CONFIG_CGROUP_SCHED
-	SEQ_printf_task_group_path(m, task_group(p), " %s")
+	SEQ_printf_task_group_path(m, task_group(p), "   %s")
 #endif
 
 	SEQ_printf(m, "\n");
@@ -611,11 +610,18 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
-		   "     wait-time             sum-exec        sum-sleep\n");
-	SEQ_printf(m, "-------------------------------------------------------"
-		   "------------------------------------------------------\n");
-
+	SEQ_printf(m, " S            task   PID         tree-key          deadline"
+		"            slice  switches   prio"
+		"       wait-time         sum-exec        sum-sleep        sum-block"
+#ifdef CONFIG_NUMA_BALANCING
+		"  node_id"
+#endif
+#ifdef CONFIG_CGROUP_SCHED
+		"  group\n");
+#endif
+	SEQ_printf(m, "-----------------------------------------------------------------"
+			"--------------------------------------------------------------------"
+			"------------------------------------------\n");
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		if (task_cpu(p) != rq_cpu)
-- 
2.34.1


