Return-Path: <linux-kernel+bounces-111113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D588680D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25799288444
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0777217589;
	Fri, 22 Mar 2024 08:16:05 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8F171C7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095364; cv=none; b=hT9A+vTzXS6CyQS8GaI7KLdY+MJNj1Qfb4q85M3+ULoNgtfUer5q66j0FS054sPZzc1yqQok412uSPeQfASt2MkF/BB58wtkv8yfOQ3CCwy2oS1xc9SaCjrJUnQYn74zASljVvfGTCJcyN43t8YRW7wMABe2lGtweX57J1hc4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095364; c=relaxed/simple;
	bh=qX9W0ylN2sPwDi09Z/FTDNjcpHGUfiTpvS/c2SCQe0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N9Fbxp8MVtSDiKyNY6yyxyluwJkQ/Ad2USMsehtEwbDeioemCEmdUEAL7H6bDq6+MniKHQDzPrJxcz59pZ+pMMUcLOKB+q/0JXdG+zzdjAqNeAb3YOshJ86ue20FoonVVND0I16LZkW3Fu5kY3M7Iw0ITB7EZ+ylnHEgtTOCdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V1FTB0l9VztQXK;
	Fri, 22 Mar 2024 16:13:34 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (unknown [7.185.36.186])
	by mail.maildlp.com (Postfix) with ESMTPS id B951218007C;
	Fri, 22 Mar 2024 16:15:52 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 16:15:52 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <qianjun.kernel@gmail.com>,
	<laoar.shao@gmail.com>, Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH] sched: Improve the accuracy of sched_stat_wait statistics for rt and dl
Date: Fri, 22 Mar 2024 16:15:21 +0800
Message-ID: <20240322081521.2687856-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)

Where commit b9c88f752268 ("sched/fair: Improve the accuracy of
sched_stat_wait statistics") fixed a wrong scenairio for cfs schedstat.

This wrong scenario is also present for the RT task. For avoiding this
scenario, add wait_start check in __update_stats_wait_end();

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/fair.c  |  9 ---------
 kernel/sched/stats.c | 11 ++++++++++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..36c81fe0086b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1208,15 +1208,6 @@ update_stats_wait_end_fair(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 	stats = __schedstats_from_se(se);
 
-	/*
-	 * When the sched_schedstat changes from 0 to 1, some sched se
-	 * maybe already in the runqueue, the se->statistics.wait_start
-	 * will be 0.So it will let the delta wrong. We need to avoid this
-	 * scenario.
-	 */
-	if (unlikely(!schedstat_val(stats->wait_start)))
-		return;
-
 	if (entity_is_task(se))
 		p = task_of(se);
 
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..7077eb490c09 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -20,8 +20,17 @@ void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
 void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
 			     struct sched_statistics *stats)
 {
-	u64 delta = rq_clock(rq) - schedstat_val(stats->wait_start);
+	u64 delta;
 
+	/*
+	 * When the sched_schedstat changes from 0 to 1, some sched se
+	 * maybe already in the runqueue, the stats->wait_start will be 0.
+	 * So it will let the delta wrong. We need to avoid this scenario.
+	 */
+	if (unlikely(!schedstat_val(stats->wait_start)))
+		return;
+
+	delta = rq_clock(rq) - schedstat_val(stats->wait_start);
 	if (p) {
 		if (task_on_rq_migrating(p)) {
 			/*
-- 
2.18.0.huawei.25


