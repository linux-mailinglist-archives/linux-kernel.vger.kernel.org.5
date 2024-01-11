Return-Path: <linux-kernel+bounces-23757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D782B148
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E1A1F23696
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6A4B5CB;
	Thu, 11 Jan 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jiGy7jUj"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261ED4B5A9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=m/pqE
	Xf08c+vliWE8lSPeFsP2w2ISvMh2c2RA9T/8Vk=; b=jiGy7jUjzM8eqr0WaiGnV
	g96UwcNwS19UoxjDFFnojFRyVX9m0UqsW1YiEGCCNj/3W94Wk5XbWbgXauZgHkPL
	a53T4UY/faYyT5XcqzWBRgA+fUxGnoQ4B9osqB2thRZTmjGLCVcAS4NNSy/UAwYg
	DegEtlbmH58qcSJEPTOpqA=
Received: from localhost.localdomain (unknown [120.229.70.38])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3H_LlAqBlABYnAA--.8189S2;
	Thu, 11 Jan 2024 23:02:00 +0800 (CST)
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
Subject: [PATCH v5] sched/stats: Fix rt/dl task's sched latency statistics error in sched_stat_wait tracepoint
Date: Thu, 11 Jan 2024 15:01:47 +0000
Message-Id: <20240111150147.182937-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H_LlAqBlABYnAA--.8189S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF15CF4fWw1UKFW8AFW8WFg_yoW8ur1Up3
	yDWay8Jw4qg3yjgw4xZr4DWrW5Wwn3J342gFnrGayftF4Ykr1Yq3WSqFW3XFZ09r9YkF17
	tr40939rKw4v9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX4S7UUUUU=
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisQtibWVOBBV09gAAsN

The sched_stat_wait tracepoint is showing unreasonably long
latencies for real-time tasks. For example:

sched_stat_wait: comm=rcu_preempt pid=14 delay=4936139545261 [ns]

This error happens when the rt task balances off the source CPU because
the dequeue operation is not updating the sched_statistics. So, follow
update_stats_wait_end_fair() and update the stats. Do the same for
SCHED_DEADLINE.

Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched class")
Acked-by: Yafang Shao <laoar.shao@gmail.com>
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
+		update_stats_wait_end_dl(dl_rq, dl_se);
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


