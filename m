Return-Path: <linux-kernel+bounces-44088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8344F841D33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384B91F285A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3F155E51;
	Tue, 30 Jan 2024 08:07:33 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931F55C02
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602053; cv=none; b=tlzoL+r/YRt0GfD0PGJ0ueZPUlU0LmTZN35wfHYUnGyaFtraMyHEHX43CLA2kfZidRbaxqfAKXb73320B+guf213/6x7rQfJtqMYMuLhZ9ZTIE/UiHCPU7FK3LcKCZCHupdFKu9AF39H+YylAMH7+cflHI+8Aior9kSdIT/mE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602053; c=relaxed/simple;
	bh=lixRsKqZbJZXIkGyOzAqZUfXdnrx6g0JD9mQ7KwNOJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CV9kgqBu2J/yTtdFBFw/PzI4gR89FkN3CEKvJu51M4OQBN1W33Wbz1HhT9CjVH7gJsW5mb0Q7mneHMTp9orzXLXOzF3evlVJ+Hk87CI3k4F+qMbAzF6NGtEPq4ZRog1UcwaQFGaK1dKC1wIlCA3TUU/8Xr9IlupsR7PVHBzZywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40U8796h038585;
	Tue, 30 Jan 2024 16:07:09 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TPHd15m7Dz2S73y6;
	Tue, 30 Jan 2024 15:59:33 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 30 Jan 2024 16:07:06 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <wuyun.abel@bytedance.com>, <ke.wang@unisoc.com>,
        <xuewen.yan94@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/eevdf: Prevent vlag from exceeding the limit value
Date: Tue, 30 Jan 2024 16:06:43 +0800
Message-ID: <20240130080643.1828-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40U8796h038585

There are some scenarios here that will cause vlag to
exceed eevdf's limit.

1. In set_next_entity, it will stash a copy of deadline
at the point of pick in vlag, and if the task fork child,
the child's vlag would inherit parent's vlag, as a result,
the child's vlag is equal to the deadline. And then,
when place_entity, because the se's vlag is wrong, it would
cause vruntime and deadline update error.

2. When reweight_entity, the vlag would be recalculated,
because the new weights are uncertain, and it may cause
the vlag to exceed eevdf's limit.

In order to ensure that vlag does not exceed the limit,
separate the calculation of limit from the update_entity_lag
and create a new func limit_entity_lag. When the vlag is
updated, use this func to prevent vlag from exceeding the limit.

And add check whether the se is forked in place_entity, and calc
the curr's vlag to update the se's vlag.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..3fc99b4b8b41 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -696,15 +696,22 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
+static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
+{
+	s64 limit;
+
+	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+	return clamp(lag, -limit, limit);
+}
+
 static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	s64 lag, limit;
+	s64 lag;
 
 	SCHED_WARN_ON(!se->on_rq);
 	lag = avg_vruntime(cfs_rq) - se->vruntime;
 
-	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
-	se->vlag = clamp(lag, -limit, limit);
+	se->vlag = limit_entity_lag(se, lag);
 }
 
 /*
@@ -3757,6 +3764,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	if (avruntime != se->vruntime) {
 		vlag = (s64)(avruntime - se->vruntime);
 		vlag = div_s64(vlag * old_weight, weight);
+		vlag = limit_entity_lag(se, vlag);
 		se->vruntime = avruntime - vlag;
 	}
 
@@ -3804,6 +3812,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	update_load_set(&se->load, weight);
 
+	if (!se->on_rq)
+		se-vlag = limit_entity_lag(se, se->vlag);
+
 #ifdef CONFIG_SMP
 	do {
 		u32 divider = get_pelt_divider(&se->avg);
@@ -5177,6 +5188,16 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 		lag = se->vlag;
 
+		/* When fork, the child would inherit parent's vlag,
+		 * but parent's vlag may be euqual to it's deadline.
+		 */
+		if (flag & ENQUEUE_INITIAL) {
+			if (curr)
+				lag = vruntime - curr->vruntime;
+
+			lag = limit_entity_lag(se, lag);
+			se->vlag = lag;
+		}
 		/*
 		 * If we want to place a task and preserve lag, we have to
 		 * consider the effect of the new entity on the weighted
@@ -5237,6 +5258,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		if (WARN_ON_ONCE(!load))
 			load = 1;
 		lag = div_s64(lag, load);
+		lag = limit_entity_lag(se, lag);
 	}
 
 	se->vruntime = vruntime - lag;
-- 
2.25.1


