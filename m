Return-Path: <linux-kernel+bounces-10311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA9B81D289
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA392860AB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA1F523A;
	Sat, 23 Dec 2023 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NeQoklkv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0744C46AD
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=o7hwV
	3qd1r+M+fgyqUOI5ooAyBPaGQyd0qEIr2EUceA=; b=NeQoklkvkKCBc3zVgO5Cu
	xW3u8bVBieOmytycj1/fw6sUd8rOnJih3x91cq5ndHBfDSdZuriPX3jhh/L+zWqn
	ZIEjsF5AdeWizM8gcfWSL9exdXp7H0DuWV7NQQBT70AFubq5cpiI9Hntu9WG/Vp6
	+PM0RD+INaD98cLkibeK4o=
Received: from ubuntu.lan (unknown [223.74.158.232])
	by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wCXv7nncYZlGKjPGQ--.35408S2;
	Sat, 23 Dec 2023 13:36:42 +0800 (CST)
From: Junwen Wu <wudaemon@163.com>
To: laoar.shao@gmail.com
Cc: bristot@redhat.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	wudaemon@163.com
Subject: Re: [PATCH v2] sched/rt: Fix rt task's sched latency statistics error in sched_stat_wait trace_point
Date: Sat, 23 Dec 2023 05:36:34 +0000
Message-Id: <20231223053634.942784-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CALOAHbDXWNbxeQEOhGW5m6bd3cLW_jnE2q6XgSpRBHzxt1GOeg@mail.gmail.com>
References: <CALOAHbDXWNbxeQEOhGW5m6bd3cLW_jnE2q6XgSpRBHzxt1GOeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXv7nncYZlGKjPGQ--.35408S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy3WFWfurW8Kw4DZF4rAFb_yoW8Kw4fpw
	4qgaykJw4qq3y0q3yxZrsrGr45uwn3J342qFnrGFWxtF4Yyr1FqFn0g343WrWqgr9Y9F17
	ta18K39xKa1v9F7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU3b18UUUUU=
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisQtPbWVOAoVlVwAAsG

>It seems DL has the same issue. Pls. also fix it in update_stats_dequeue_dl().
>And add the Fixes tag in the commit log:
>Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
>Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched class")

ok, the PATCH v3 below is ok?

Subject: [PATCH v3] sched/stats: Fix rt/dl task's sched latency statistics
 error in sched_stat_wait trace_point

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
+       struct rq *rq = rq_of_dl_rq(dl_rq);

        if (!schedstat_enabled())
                return;
-
+       /*
+        * Mark the end of the wait period
+        * if dequeueing a waiting task.
+        */
+       if (p && (p != rq->curr))
+                update_stats_wait_end_dl(dl_rq, dl_se);
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
+       struct rq *rq = rq_of_rt_se(rt_se);

        if (!schedstat_enabled())
                return;

        if (rt_entity_is_task(rt_se))
                p = rt_task_of(rt_se);
+        /*
+         * Mark the end of the wait period
+         * if dequeueing a waiting task.
+         */
+       if (p && (p != rq->curr))
+               update_stats_wait_end_rt(rt_rq, rt_se);

        if ((flags & DEQUEUE_SLEEP) && p) {
                unsigned int state;

--
Best regards


