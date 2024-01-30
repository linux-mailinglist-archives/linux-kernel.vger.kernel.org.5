Return-Path: <linux-kernel+bounces-45112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB95842BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E228614A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E819762DE;
	Tue, 30 Jan 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1P/12Gm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB1762CE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639641; cv=none; b=ptk0n2KCozO+eYd7r8IL3WqWvzTkx48XLywK/qlNQdlfpHu17MkIc3SCtj0K+ITxiuJqXgt1OUQBnQUqK5HZBwF/piZPGLH71btb2XwrqU80c2Wj7b5/6HyJiHXM1n2WyI9wHEw8UvS9eERgyOM13M++nFpIi2Pg+38R7rJzazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639641; c=relaxed/simple;
	bh=lL5qdWL2PB4mhrehemlKORG0nbLblNVPf8HOOqtCxN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pvp5F4qSWIcMqZYjSfYx3HEB8fvt21FcQrb+Kn/c0YlevCPCJFDEdFWaH7FVocs8+BT1Pl6DcOw9YklohtSGbDmkWMaAJCSvDh+iYEnlVzoxya0XWrLfu/jBwPZrf9R35/rbjyng7alyOJrgaRHdJTNOQ4g/BWc2CGAMc5U3ZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1P/12Gm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706639639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPefEzI7IPB8Pl2sd/W5lhgO3NwL39dr5Md44erL9pY=;
	b=N1P/12GmAJRt5gbJ9ND3JoCYoGaDo0gzkMhMI04MZRgeJ5r87TOq+ExnBxNAmy8jidFCUQ
	QzCwjB54+lSilqtkEfnLKXERijSvkRoEVFhFppzOSLQ9DBX2SOPXo3d/pT8i3mqoGh/dMj
	n4qe7jq2S1o0lTSmTz2PuNTkdIiV00s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-ndeUQeKQNOqMBNfJxAS7pw-1; Tue,
 30 Jan 2024 13:33:57 -0500
X-MC-Unique: ndeUQeKQNOqMBNfJxAS7pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 091EA38562CA;
	Tue, 30 Jan 2024 18:33:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BC2640CD14B;
	Tue, 30 Jan 2024 18:33:56 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 2/3] workqueue: Break out __queue_work_rcu_locked() from __queue_work()
Date: Tue, 30 Jan 2024 13:33:35 -0500
Message-Id: <20240130183336.511948-3-longman@redhat.com>
In-Reply-To: <20240130183336.511948-1-longman@redhat.com>
References: <20240130183336.511948-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Break out the core __queue_work() code into a __queue_work_rcu_locked
helper to be used by later patches.

There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/workqueue.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 350179382667..98c741eb43af 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1702,32 +1702,14 @@ static int wq_select_unbound_cpu(int cpu)
 	return new_cpu;
 }
 
-static void __queue_work(int cpu, struct workqueue_struct *wq,
-			 struct work_struct *work)
+static void __queue_work_rcu_locked(int cpu, struct workqueue_struct *wq,
+				    struct work_struct *work)
 {
 	struct pool_workqueue *pwq;
 	struct worker_pool *last_pool, *pool;
 	unsigned int work_flags;
 	unsigned int req_cpu = cpu;
 
-	/*
-	 * While a work item is PENDING && off queue, a task trying to
-	 * steal the PENDING will busy-loop waiting for it to either get
-	 * queued or lose PENDING.  Grabbing PENDING and queueing should
-	 * happen with IRQ disabled.
-	 */
-	lockdep_assert_irqs_disabled();
-
-
-	/*
-	 * For a draining wq, only works from the same workqueue are
-	 * allowed. The __WQ_DESTROYING helps to spot the issue that
-	 * queues a new work item to a wq after destroy_workqueue(wq).
-	 */
-	if (unlikely(wq->flags & (__WQ_DESTROYING | __WQ_DRAINING) &&
-		     WARN_ON_ONCE(!is_chained_work(wq))))
-		return;
-	rcu_read_lock();
 retry:
 	/* pwq which will be used unless @work is executing elsewhere */
 	if (req_cpu == WORK_CPU_UNBOUND) {
@@ -1808,6 +1790,30 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 
 out:
 	raw_spin_unlock(&pool->lock);
+}
+
+static void __queue_work(int cpu, struct workqueue_struct *wq,
+			 struct work_struct *work)
+{
+	/*
+	 * While a work item is PENDING && off queue, a task trying to
+	 * steal the PENDING will busy-loop waiting for it to either get
+	 * queued or lose PENDING.  Grabbing PENDING and queueing should
+	 * happen with IRQ disabled.
+	 */
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * For a draining wq, only works from the same workqueue are
+	 * allowed. The __WQ_DESTROYING helps to spot the issue that
+	 * queues a new work item to a wq after destroy_workqueue(wq).
+	 */
+	if (unlikely(wq->flags & (__WQ_DESTROYING | __WQ_DRAINING) &&
+		     WARN_ON_ONCE(!is_chained_work(wq))))
+		return;
+
+	rcu_read_lock();
+	__queue_work_rcu_locked(cpu, wq, work);
 	rcu_read_unlock();
 }
 
-- 
2.39.3


