Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9EB7EBA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 00:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjKNXJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKNXJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:09:37 -0500
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 15:09:32 PST
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601AFD0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 15:09:32 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1700002802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pcHXUDsGanMOyut+Xy6/Mo2iiVbD+Z4ELrwol5KTsJk=;
        b=e8sQ5g2eX4Vctxc2oWU4E+QB56O1NKIQVlJqdLVb5mkDXcY/cShnIMdjHWStj06J/QUP0B
        qHEjypsBrmw10sOcosDwo7dutTugIlRlRWaMUbjoMGZZoJoLBEv1UOE6wu/i37voZBjV32
        +AXSnxuU8sNCPaJLpl//AN3acMF0p1M=
From:   Ronan Pigott <ronan@rjp.ie>
To:     peterz@infradead.org
Cc:     Ronan Pigott <ronan@rjp.ie>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH] sched/debug: re-align header in sched/debug debugfs output
Date:   Tue, 14 Nov 2023 15:56:25 -0700
Message-ID: <20231114225833.1691370-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New fields were introduced with EEVDF, so we should adjust the table
header to match. Additionally, the sum_exec_runtime field was
duplicated, so one was removed.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Ronan Pigott <ronan@rjp.ie>
---
I decided to put each title section on its own line to match printf
invocation above, and to make it a little easier to see the intended
field width. I hope the kernel can suffer a few extra source lines for
this convenience.

 kernel/sched/debug.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4580a450700e..8d9f8f402059 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -579,7 +579,7 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, " %15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
@@ -589,14 +589,13 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
-	SEQ_printf(m, "%9lld.%06ld %9lld.%06ld %9lld.%06ld %9lld.%06ld",
+	SEQ_printf(m, "%9lld.%06ld %9lld.%06ld %9lld.%06ld",
 		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
-		SPLIT_NS(p->se.sum_exec_runtime),
 		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)),
 		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_block_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
-	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
+	SEQ_printf(m, " %5d %5d", task_node(p), task_numa_group_id(p));
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	SEQ_printf_task_group_path(m, task_group(p), " %s")
@@ -611,10 +610,37 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
-		   "     wait-time             sum-exec        sum-sleep\n");
-	SEQ_printf(m, "-------------------------------------------------------"
-		   "------------------------------------------------------\n");
+	SEQ_printf(m, " S"
+		"            task"
+		"   PID"
+		"         tree-key"
+		" E"
+		"         deadline"
+		"            slice"
+		"         sum-exec"
+		"  switches"
+		"  prio"
+		"        wait-time"
+		"        sum-sleep"
+		"        sum-block"
+#ifdef CONFIG_NUMA_BALANCING
+		"  node    id"
+#endif
+#ifdef CONFIG_CGROUP_SCHED
+		" task-group"
+#endif
+		"\n"
+	);
+	SEQ_printf(m, "--------------------------------------------------------"
+		"--------------------------------------------------------------"
+		"-------------------------------------------"
+#ifdef CONFIG_NUMA_BALANCING
+		"------------"
+#endif
+#ifdef CONFIG_CGROUP_SCHED
+		"-----------"
+#endif
+		"\n");
 
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
-- 
2.42.1

