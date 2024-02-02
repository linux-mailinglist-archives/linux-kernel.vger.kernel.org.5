Return-Path: <linux-kernel+bounces-49444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C824846A62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C571C2048C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2FB1A286;
	Fri,  2 Feb 2024 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W18EPO9K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A3182C3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861458; cv=none; b=gNgWZWtvJuCrDK5FspCJYCtc2B9OKoZsJ/l+iyzK+OlwoM158scm34rPouvSWmPZa0DiAkwBXlkVR1+SUUSn+HHioHlagQAZNmvBFoZUGtK6sT4zRCVOma4JE0ARLbatLVqozdpTt3ZB5ZtKLvZxa779T8GEbdDGjHTZPi5nOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861458; c=relaxed/simple;
	bh=GKjGZ0nEYiWo/e0g4SCEgfAGOP3qsyIKHYvTEjh/1rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdB/Db2q69k17I6sSbW4eKgJuj6Nw5IFEJHBlO1Rjg2ScyrffzlkBP5+i+Y41j3hKur82idrr+2YCNx1ymdwkIDTzlM+MTeuHxkRN8havlKBCGhkz5mCut5qrMtCqYHCV0Emlvm9x7jsxIRzj27nsQrbvJBlixWWLv3i9timpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W18EPO9K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706861455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzFtBHR5zk59g+CzbXsW0xRKrMzCG41VI7+6LhlJ3kY=;
	b=W18EPO9Kjyaqv4DAb3oPrHqA6oxzwkQe2K3jGyhYIMP4/8YhfMdsGMjWvkOFjraKRKJyQd
	ugL34cqJy/ZMYsF1vdRtoDjhYSmhbVhM+ecAOyLLcwP4xpcrd0YUD2cK+d1OV/0oF9t+sp
	F5CV32/Fn89Q8YDj8tqukjNva3w85ks=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-VKghfcTmM0WgeKid_SqZiw-1; Fri,
 02 Feb 2024 03:10:51 -0500
X-MC-Unique: VKghfcTmM0WgeKid_SqZiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6132A3C0ED5E;
	Fri,  2 Feb 2024 08:10:51 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C2AB6C2590D;
	Fri,  2 Feb 2024 08:10:48 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH v2 5/5] sched/fair: Assert user/kernel/total nr invariants
Date: Fri,  2 Feb 2024 09:09:20 +0100
Message-ID: <20240202080920.3337862-6-vschneid@redhat.com>
In-Reply-To: <20240202080920.3337862-1-vschneid@redhat.com>
References: <20240202080920.3337862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Previous commits have added .h_kernel_running and .h_user_running to struct
cfs_rq, and are using them to play games with the hierarchical
h_nr_running.

Assert some count invariants under SCHED_DEBUG to improve debugging.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2b54d3813d18d..52d0ee0e4d47c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5780,6 +5780,30 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 static void enqueue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count);
 static void dequeue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count);
 
+#ifdef CONFIG_CFS_BANDWIDTH
+static inline void assert_cfs_rq_counts(struct cfs_rq *cfs_rq)
+{
+	lockdep_assert_rq_held(rq_of(cfs_rq));
+
+	/*
+	 * When !throttle_pending, this is the normal operating mode, all tasks
+	 * are pickable, so:
+	 * nr_kernel_tasks + nr_user_tasks == nr_pickable_tasks
+	 */
+	SCHED_WARN_ON(!cfs_rq->throttle_pending &&
+		      (cfs_rq->h_kernel_running + cfs_rq->h_user_running !=
+		       cfs_rq->h_nr_running));
+	/*
+	 * When throttle_pending, only kernel tasks are pickable, so:
+	 * nr_kernel_tasks == nr_pickable_tasks
+	 */
+	SCHED_WARN_ON(cfs_rq->throttle_pending &&
+		      (cfs_rq->h_kernel_running != cfs_rq->h_nr_running));
+}
+#else
+static inline void assert_cfs_rq_counts(struct cfs_rq *cfs_rq) { }
+#endif
+
 static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
@@ -5894,6 +5918,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		dequeue_kernel(qcfs_rq, se, kernel_delta);
 		qcfs_rq->h_user_running -= user_delta;
 
+		assert_cfs_rq_counts(qcfs_rq);
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -5918,6 +5943,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		dequeue_kernel(qcfs_rq, se, kernel_delta);
 		qcfs_rq->h_user_running -= user_delta;
+
+		assert_cfs_rq_counts(qcfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6013,6 +6040,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		enqueue_kernel(qcfs_rq, se, kernel_delta);
 		qcfs_rq->h_user_running += user_delta;
 
+		assert_cfs_rq_counts(qcfs_rq);
+
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
 			goto unthrottle_throttle;
@@ -6950,6 +6979,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
+		assert_cfs_rq_counts(cfs_rq);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -6965,6 +6995,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se_update_runnable(se);
 		update_cfs_group(se);
 
+		assert_cfs_rq_counts(cfs_rq);
 
 		if (kernel_task || (!throttle_pending && !cfs_rq->throttle_pending))
 			cfs_rq->h_nr_running++;
@@ -6979,6 +7010,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
+		assert_cfs_rq_counts(cfs_rq);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7051,6 +7083,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
+		assert_cfs_rq_counts(cfs_rq);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7092,6 +7125,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
+		assert_cfs_rq_counts(cfs_rq);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -8631,6 +8665,8 @@ static void handle_kernel_task_prev(struct task_struct *prev)
 
 			throttle_pending |= cfs_rq->throttle_pending;
 
+			assert_cfs_rq_counts(cfs_rq);
+
 			if (cfs_rq_throttled(cfs_rq))
 				break;
 		}
@@ -8648,6 +8684,8 @@ static void handle_kernel_task_prev(struct task_struct *prev)
 
 			throttle_pending |= cfs_rq->throttle_pending;
 
+			assert_cfs_rq_counts(cfs_rq);
+
 			if (cfs_rq_throttled(cfs_rq))
 				break;
 		}
-- 
2.43.0


