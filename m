Return-Path: <linux-kernel+bounces-22234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF565829B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769B51F2373A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066C48CC5;
	Wed, 10 Jan 2024 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AgUEf/dr"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EA1482F6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DVbpt
	mUmHIdsmu0W26VjUj3qLOQiaRb5m5BFHT8Ly58=; b=AgUEf/drnFjEWzGyfGgCX
	ULb78l7Gpb36aWNSGntqeHIZYPzVofxancQyqvdJqFQlMtkvPGRdim3gvwe6Xx6u
	qlJ9tBEdH59zeG9skW7R9ExO9rkJ5zIgqfvFiUdmII2XCbNx2Slf1CmWZ6DFNW/Z
	knAGnbytao7B5XkdFr3TS0=
Received: from ubuntu.lan (unknown [120.229.70.208])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDXfxAAnJ5lYxpYAA--.6639S2;
	Wed, 10 Jan 2024 21:30:42 +0800 (CST)
From: Junwen Wu <wudaemon@163.com>
To: bristot@redhat.com,
	mingo@redhat.com,
	laoar.shao@gmail.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com
Cc: mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Junwen Wu <wudaemon@163.com>
Subject: [PATCH v4] sched/stats: Fix rt/dl task's sched latency statistics error in sched_stat_wait trace_point
Date: Wed, 10 Jan 2024 13:30:38 +0000
Message-Id: <20240110133038.46903-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXfxAAnJ5lYxpYAA--.6639S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF15CF4fWw1UKFW8AFW8WFg_yoW8ZF4kp3
	yqgaykJw4qgayjgw4xZr4DWrWruwn3J342gFn3GayftF4Ykr1Fq3ZaqFW3XFZ09r95CF17
	tr40939rKa1v9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piZNVPUUUUU=
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisANhbWV4HUmeAQAAsp

The sched_stat_wait tracepoint is showing unreasonably long
latencies for real-time tasks. For example:

sched_stat_wait: comm=rcu_preempt pid=14 delay=4936139545261 [ns]

This error happens when the rt task balances off the source CPU because
the dequeue operation is not updating the sched_statistics. So, follow
update_stats_wait_end_fair() and update the stats. Do the same for
SCHED_DEADLINE.

Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched class")
Signed-off-by: Junwen Wu <wudaemon@163.com>
---
 kernel/sched/deadline.c | 5 ++++-
 kernel/sched/rt.c       | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b28114478b82..4a9aad291fb9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1558,10 +1558,13 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
 			int flags)
 {
 	struct task_struct *p = dl_task_of(dl_se);
+	struct rq *rq = rq_of_dl_rq(dl_rq);
 
 	if (!schedstat_enabled())
 		return;
-
+	/*  Mark the end of the wait period if dequeueing a waiting task.*/
+	if (p && (p != rq->curr))
+		 update_stats_wait_end_dl(dl_rq, dl_se);
 	if ((flags & DEQUEUE_SLEEP)) {
 		unsigned int state;
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..5cb3a54d6b13 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1360,12 +1360,16 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 			int flags)
 {
 	struct task_struct *p = NULL;
+	struct rq *rq = rq_of_rt_se(rt_se);
 
 	if (!schedstat_enabled())
 		return;
 
 	if (rt_entity_is_task(rt_se))
 		p = rt_task_of(rt_se);
+	/* Mark the end of the wait period if dequeueing a waiting task. */
+	if (p && (p != rq->curr))
+		update_stats_wait_end_rt(rt_rq, rt_se);
 
 	if ((flags & DEQUEUE_SLEEP) && p) {
 		unsigned int state;
-- 
2.34.1


