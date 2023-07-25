Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E3762245
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGYTaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjGYTaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:30:13 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0B1FFC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1690313409;
        bh=eksg/xSQaqbvhzxjIvfY0VWqJKo9vV4O1aJahYJV9EU=;
        h=From:To:Cc:Subject:Date:From;
        b=eXeG+43Pt5Ybsmy61t2JpU5U9Bbulf/sp2lq3j+akg+AtWvpxqBhpUJ23PVSw1+at
         oJObQ7aUzj7wNJGZU/M9yv2YsVMMFxwNCJkmcHpiGWTNFNPz4UbYTSr8X7pxZfuooL
         kP6JK1GFJF1L1jT4f0LLW5gPNf8GBFf9NIESdlCjAswZaFycQT0bYLqt3hTDuYCAHB
         ztXFfdObz06oinFRCUFIvpx37fn7opjlH3JZTtGnaBiXlF4/vyq9r3ko5yGFs6hTtA
         u9OToijt0yeBlshWrDePz6KdFwRcpxL6+y/AKoI/dELDqNQ/V9c8yQ85R4IPbno8zr
         ZtfK3Jd2cw/6Q==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4R9Rv463Hcz1JZF;
        Tue, 25 Jul 2023 15:30:08 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org
Subject: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Date:   Tue, 25 Jul 2023 15:30:48 -0400
Message-Id: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow select_task_rq to consider a cpu as idle for 1ms after that cpu
has exited the idle loop.

This speeds up the following hackbench workload on a 192 cores AMD EPYC
9654 96-Core Processor (over 2 sockets):

hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

from 49s to 34s. (30% speedup)

My working hypothesis for why this helps is: queuing more than a single
task on the runqueue of a cpu which just exited idle rather than
spreading work over other idle cpus helps power efficiency on systems
with large number of cores.

This was developed as part of the investigation into a weird regression
reported by AMD where adding a raw spinlock in the scheduler context
switch accelerated hackbench.

It turned out that changing this raw spinlock for a loop of 10000x
cpu_relax within do_idle() had similar benefits.

This patch achieve a similar effect without the busy-waiting by
introducing a runqueue state sampling the sched_clock() when exiting
idle, which allows select_task_rq to consider "as idle" a cpu which has
recently exited idle.

This patch should be considered "food for thoughts", and I would be glad
to hear feedback on whether it causes regressions on _other_ workloads,
and whether it helps with the hackbench workload on large Intel system
as well.

Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: x86@kernel.org
---
 kernel/sched/core.c  | 4 ++++
 kernel/sched/sched.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..d40e3a0a5ced 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6769,6 +6769,7 @@ void __sched schedule_idle(void)
 	 * TASK_RUNNING state.
 	 */
 	WARN_ON_ONCE(current->__state);
+	WRITE_ONCE(this_rq()->idle_end_time, sched_clock());
 	do {
 		__schedule(SM_NONE);
 	} while (need_resched());
@@ -7300,6 +7301,9 @@ int idle_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
+	if (sched_clock() < READ_ONCE(rq->idle_end_time) + IDLE_CPU_DELAY_NS)
+		return 1;
+
 	if (rq->curr != rq->idle)
 		return 0;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 81ac605b9cd5..8932e198a33a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -97,6 +97,8 @@
 # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
 #endif
 
+#define IDLE_CPU_DELAY_NS	1000000		/* 1ms */
+
 struct rq;
 struct cpuidle_state;
 
@@ -1010,6 +1012,7 @@ struct rq {
 
 	struct task_struct __rcu	*curr;
 	struct task_struct	*idle;
+	u64			idle_end_time;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
 	struct mm_struct	*prev_mm;
-- 
2.39.2

