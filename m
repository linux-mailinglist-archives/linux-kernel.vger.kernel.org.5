Return-Path: <linux-kernel+bounces-13820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2088212E6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 04:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1436DB21BBF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 03:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE41870;
	Mon,  1 Jan 2024 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L7wZziSo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167EC17C8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=78rvv
	5vRxcrC9Qr4qOI+5DrrZFZ+xcT1jYy/BiyFMqY=; b=L7wZziSolnirBsREX6/mL
	xyt6wJRQydbZYKsRC9nqhElLCs9e7g2eY4H7QPgvn44KHztWaw3tCw8kkWu15A3e
	xqpRGgy/Rqze7Rheunda1228ZRdY+wpOpEeIR0COwVFh45fyxhR6c58rrYkjgIEa
	R5vECx6epSusS1SiIIv+tY=
Received: from ubuntu.lan (unknown [120.229.70.93])
	by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wCXkomyLpJlw_TNBA--.40935S2;
	Mon, 01 Jan 2024 11:17:08 +0800 (CST)
From: Junwen Wu <wudaemon@163.com>
To: mingo@redhat.com,
	laoar.shao@gmail.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com
Cc: mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Junwen Wu <wudaemon@163.com>
Subject: [PATCH v3] sched/stats: Fix rt/dl task's sched latency statistics error in sched_stat_wait trace_point
Date: Mon,  1 Jan 2024 03:17:04 +0000
Message-Id: <20240101031704.227541-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXkomyLpJlw_TNBA--.40935S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur17Kry8AryDKr1fWFyrtFb_yoW8ZrWfp3
	yDWay8Jw4qq3y0g3yxZr4DGr45Wwn3J342gF97GayftF4Fyr1YqFn0qry3WrZ09rn5uF17
	tF40krZxKa1vkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKZX7UUUUU=
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisBhYbWV4HH2segAAs3

When enable sched_stat_wait trace_point, some rt tasks sched latency so long, like this,
sched_stat_wait: comm=rcu_preempt pid=14 delay=4936139545261 [ns]
Rt task has low latency, it must have a bug. When rt task balance off source cpu,
dequeue operation not update the sched_statistics, so follow update_stats_wait_end_fair
update method, so do dl tasks.

Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched class")
Signed-off-by: Junwen Wu <wudaemon@163.com>
---
 kernel/sched/deadline.c | 8 +++++++-
 kernel/sched/rt.c       | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b28114478b82..29223163ee22 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1558,10 +1558,16 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
 			int flags)
 {
 	struct task_struct *p = dl_task_of(dl_se);
+	struct rq *rq = rq_of_dl_rq(dl_rq);
 
 	if (!schedstat_enabled())
 		return;
-
+	/*
+	 * Mark the end of the wait period
+	 * if dequeueing a waiting task.
+	 */
+	if (p && (p != rq->curr))
+		 update_stats_wait_end_dl(dl_rq, dl_se);
 	if ((flags & DEQUEUE_SLEEP)) {
 		unsigned int state;
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..6a2600213991 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1360,12 +1360,19 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 			int flags)
 {
 	struct task_struct *p = NULL;
+	struct rq *rq = rq_of_rt_se(rt_se);
 
 	if (!schedstat_enabled())
 		return;
 
 	if (rt_entity_is_task(rt_se))
 		p = rt_task_of(rt_se);
+	 /*
+	  * Mark the end of the wait period
+	  * if dequeueing a waiting task.
+	  */
+	if (p && (p != rq->curr))
+		update_stats_wait_end_rt(rt_rq, rt_se);
 
 	if ((flags & DEQUEUE_SLEEP) && p) {
 		unsigned int state;
-- 
2.34.1


