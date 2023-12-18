Return-Path: <linux-kernel+bounces-3886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EF28174B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8031C241E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658BD3A1BA;
	Mon, 18 Dec 2023 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b3rdgRR0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21AC3A1C4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yVVj0
	ms6yYbBhgiPzB8MS/3H+dwi2Xyw+iNQAT3pKkI=; b=b3rdgRR0bvzFTd8qK2rJh
	RiGeEqpkCqWTJacVdEP7814JwrchIJCdniarIbPOrEVqg8Zau9hGawmV8PWdbr76
	90mKi1wzGXsQtt/W3nbrSIOoyAZ021dITxh0ye3Cwq27bD1a08OFoRAMikRXAWkL
	lugsQ4kliFAidmKxueJu7c=
Received: from localhost.localdomain (unknown [120.229.19.179])
	by zwqz-smtp-mta-g1-4 (Coremail) with SMTP id _____wDXX6I8X4Bl7UDSFw--.52364S2;
	Mon, 18 Dec 2023 23:03:25 +0800 (CST)
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
Subject: [PATCH v1] sched/rt: Fix rt task's sched latency statistics in sched_stat_wait trace_point
Date: Mon, 18 Dec 2023 15:03:22 +0000
Message-Id: <20231218150322.788382-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX6I8X4Bl7UDSFw--.52364S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF17Zw1UtF4kurWxtr1UWrg_yoWDuFgEq3
	sa9w4qkwn09Fn8tF43Gw4fXryrtayjqFn5Za18tFWDCrykJrZ8tas8KFs5Gws3Xws7AFWq
	krs2ga4vkrs7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKVyxJUUUUU==
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisR5KbWVOAiFeyAAAsW

When enable sched_stat_wait trace_point, some rt tasks sched latency
so long, like this:
sched_stat_wait: comm=rcu_preempt pid=14 delay=4936139545261 [ns]
Rt task has low latency, it must have a bug. I found the reason is 
When rt task balance off source cpu, dequeue operation not update 
the sched_statistics, so follow update_stats_wait_end_fair
update method.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
 kernel/sched/rt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..c75215947c20 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1360,12 +1360,15 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 			int flags)
 {
 	struct task_struct *p = NULL;
+	struct rq *rq = rq_of_rt_se(rt_se);
 
 	if (!schedstat_enabled())
 		return;
 
 	if (rt_entity_is_task(rt_se))
 		p = rt_task_of(rt_se);
+	if (p != rq->curr)
+		update_stats_wait_end_rt(rt_rq, rt_se);
 
 	if ((flags & DEQUEUE_SLEEP) && p) {
 		unsigned int state;
-- 
2.34.1


