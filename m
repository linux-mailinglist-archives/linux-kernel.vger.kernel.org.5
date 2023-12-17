Return-Path: <linux-kernel+bounces-2650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BAF815FE4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2281C21EFA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8610945BF1;
	Sun, 17 Dec 2023 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c4s2eGx8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481045BE8
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tfEK8
	34hFhHWJL3vUn8/GMuXyS9juv8wssBC4nzLML0=; b=c4s2eGx8Fwq9hYgGuVbTN
	fGEKBAkhZXLaLljjFpTvE5DnrPB8pm+P+hqxFDuNNaGO06FjvzQNhwcGkBG3/qEJ
	ceP6XZpEnwMmiL8eFuN7J7oaNmNI7pUX4D1D+cVv4thLfXnslDVGILgYontbkxxT
	jFm+9fzeEELK5fBVv8SGOI=
Received: from ubuntu.lan (unknown [120.229.19.33])
	by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wB3f0JABX9l13BJCA--.53408S2;
	Sun, 17 Dec 2023 22:27:14 +0800 (CST)
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
Subject: [PATCH v2] sched/debug: Update print_task format in sched_debug node
Date: Sun, 17 Dec 2023 14:27:10 +0000
Message-Id: <20231217142710.771888-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3f0JABX9l13BJCA--.53408S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr43XF1ftF4fJw1xtrykGrg_yoW5GF1fpw
	nxAF13Jr4DXw1Ygw17ArykZr15Kry8t34UWrn7Ar18JF10y345Kr17tr1xtry5Gryxtw1a
	qFs8tr17G3WDXrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piNzV8UUUUU=
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBlA5JbVgi4+fJZQAAss

For the sched_debug interface, print_task function  has  output
sum_exec_runtime twice, and the promt message not align with
the output, so optimize the output.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---

V1 -> V2: fix  compile error
 kernel/sched/debug.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4580a450700e..342a2a942d51 100644
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
@@ -611,11 +610,19 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
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
+		"  group\n"
+#endif
+	);
+	SEQ_printf(m, "-----------------------------------------------------------------"
+			"--------------------------------------------------------------------"
+			"------------------------------------------\n");
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		if (task_cpu(p) != rq_cpu)
-- 
2.34.1


