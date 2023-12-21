Return-Path: <linux-kernel+bounces-8617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F781BA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD31F27455
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8E0539F9;
	Thu, 21 Dec 2023 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jSoF5Ebn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F5E539F7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wxvSD
	Li8T65lvh5EvTZQCJASQPtLkSwryZZLIIX8yC0=; b=jSoF5EbnbK07t/MiYUm2l
	wSfdYgrQzo1DXwC7fzJx0/RYm/SufECkaYwm3yfqi9Gylbrgq961fir5/KB7O3iI
	hEp8H2BWjzrg85msFeKLr7uXR7t7TA6GO1wTqk5K/AAOKkEZhKyTcMqdhGI98Vg1
	wx/3gO3idv9CReA6lOONvc=
Received: from localhost.localdomain (unknown [120.229.19.61])
	by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wDnb4aSU4Rl_YYfEQ--.29751S2;
	Thu, 21 Dec 2023 23:02:45 +0800 (CST)
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
Subject: [PATCH v2] sched/rt: Fix rt task's sched latency statistics error in sched_stat_wait trace_point
Date: Thu, 21 Dec 2023 15:02:38 +0000
Message-Id: <20231221150238.856960-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnb4aSU4Rl_YYfEQ--.29751S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZF17Zw1UtF4ktryUtryDGFg_yoW8Jr45p3
	909a92va1qqay2qa1xuFs7ur15Wwn3J342gF97Jw1ftF4Yyrn0qwnIvw4agrWv9rykCF1x
	tF40yrZxKa10vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKZX7UUUUU=
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisBRNbWV4G7fD9QABsC

When enable sched_stat_wait trace_point, some rt tasks sched latency
so long, like this:
sched_stat_wait: comm=rcu_preempt pid=14 delay=4936139545261 [ns]
Rt task has low latency, it must have a bug. When rt task balance off
source cpu, dequeue operation not update the sched_statistics, so follow
update_stats_wait_end_fair update method.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20231218150322.788382-1-wudaemon@163.com/

 kernel/sched/rt.c | 7 +++++++
 1 file changed, 7 insertions(+)

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


