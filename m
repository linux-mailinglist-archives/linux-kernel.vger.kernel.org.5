Return-Path: <linux-kernel+bounces-44221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217FB841EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C7F1C248ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE5C58ACF;
	Tue, 30 Jan 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFHRNa4w"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C35159170;
	Tue, 30 Jan 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605989; cv=none; b=Oshl/EUktDfevPd44eNvpKQimy12axhZi+H+ozjvLL2jEpSuSN93RnZ+dCA6GCSvNnGC/YrGDyqfk0HBrz7wbtZ0nSv6nHVX+d0FKHXaz+VNqNKh6zMKnXYfEfMIOn52BdenSmlXvC9WM5722Xp9bK7lyOHuUew7DiUtHvJn2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605989; c=relaxed/simple;
	bh=cpO6m2Pr5p3n/qePucxFD1UXJhPW8vRxbzSH1keUjbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eulRqqBW5p2IEZULNkA4gca6HB5MO1Upg/SMYmjXD4LtOgfYU7XUqBgYfDpBhN+NCZ4xYqJlZVK+/AfCqhSAuGixuCr7fMmGo/9I0p6+MJ2m2R41Wq2w3wUfY7ww68DL6SqymRLkDZ7+7duGE5Nl4X88jhT3bnYdv3hADKh90ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFHRNa4w; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8e7ebbbadso10388505ad.3;
        Tue, 30 Jan 2024 01:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605986; x=1707210786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f+E+7Yr7tZg5UZ5N5kXMlDMZoo9OCBh+FLJ8A0xtV0=;
        b=eFHRNa4wmLsWDG1/uAVCuvwsK8H7opNPnHKbhM9jyv23Mop2vOZETF/fTeRnhIeGR4
         VefkONdoxHbX8EHzh3IRC1fbYAc/z/Za1VvuEZ6bZL0F8d17SeUQa1OkQkW8pt+92Z2F
         wqDYIO/AbUj7G01o0a6ki7gEYXQVUVYx53RnoJ0l7cOr5lpU+GW5WomKT8aQvEpRFWun
         X0/3j2UVABUMACIM/eyli8arG4BzyIEdKRU5u0nIvLl9/dukhr/B0zrQALXNswRLibMZ
         WWX6aiNBgurPGo7BUPu56UtNUkOGvqFu9yNbMAKuDg+lfkxjPxefdMDj/M2+h01KWArE
         d+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605986; x=1707210786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0f+E+7Yr7tZg5UZ5N5kXMlDMZoo9OCBh+FLJ8A0xtV0=;
        b=E0j/7OV+NVb9Khql1uc4ZarpW4jdwKSA74jK/jw2+OLKNyHve8vDLy1MEPoyc55Sk3
         hKQfqxIFKzvB0DYjII5Ooy2uLBHs90aRINF/P7twukILDxJP1uOpYOapO6sHW6/qOSyP
         olmXriYumA8NhyHKNvvTzBe9js4mDD/j0fKbxSQvKpgcejptf28xQ7bb2pFgs7VFWRNo
         CHoOZYgN79+nDzYt1aa/h7fjJe5lJg5jLiedcG5/TdGXFkBoAxwMwjiFlVYcNtlFd1k7
         9eeYyGSLhi4vKal5JP++QOD9/3Sqp7iBUPi2YKrhURjN6fhe7glRAlLLoxQhTTY2mEoS
         Yc4g==
X-Gm-Message-State: AOJu0YwXQANRhC+oZakjZ6FqjDfIMRCXdxNhyifOOCJ7DGx/iRoLnUaB
	M1DK5YD7MPO0Dhd9bmpabz/MdG7aqGqSUEHk3r+ZhEj8wJrGsNjg
X-Google-Smtp-Source: AGHT+IHW8nd6s3CduJC+/WZAHKizzZVidAfFEzNUZ1XDA7JjpE2326FNHUnbnisZAxd67Me78MzjWA==
X-Received: by 2002:a17:903:491:b0:1d8:eb22:5f25 with SMTP id jj17-20020a170903049100b001d8eb225f25mr2684625plb.102.1706605986265;
        Tue, 30 Jan 2024 01:13:06 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b001d901e176afsm1171941plz.232.2024.01.30.01.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:13:05 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	msnitzer@redhat.com,
	ignat@cloudflare.com,
	damien.lemoal@wdc.com,
	bob.liu@oracle.com,
	houtao1@huawei.com,
	peterz@infradead.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/8] workqueue: Update lock debugging code
Date: Mon, 29 Jan 2024 23:11:48 -1000
Message-ID: <20240130091300.2968534-2-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130091300.2968534-1-tj@kernel.org>
References: <20240130091300.2968534-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes are in preparation of BH workqueue which will execute work
items from BH context.

- Update lock and RCU depth checks in process_one_work() so that it
  remembers and checks against the starting depths and prints out the depth
  changes.

- Factor out lockdep annotations in the flush paths into
  touch_{wq|work}_lockdep_map(). The work->lockdep_map touching is moved
  from __flush_work() to its callee - start_flush_work(). This brings it
  closer to the wq counterpart and will allow testing the associated wq's
  flags which will be needed to support BH workqueues. This is not expected
  to cause any functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 51 ++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9221a4c57ae1..3f2081bd05a4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2954,6 +2954,7 @@ __acquires(&pool->lock)
 	struct pool_workqueue *pwq = get_work_pwq(work);
 	struct worker_pool *pool = worker->pool;
 	unsigned long work_data;
+	int lockdep_start_depth, rcu_start_depth;
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * It is permissible to free the struct work_struct from
@@ -3016,6 +3017,8 @@ __acquires(&pool->lock)
 	pwq->stats[PWQ_STAT_STARTED]++;
 	raw_spin_unlock_irq(&pool->lock);
 
+	rcu_start_depth = rcu_preempt_depth();
+	lockdep_start_depth = lockdep_depth(current);
 	lock_map_acquire(&pwq->wq->lockdep_map);
 	lock_map_acquire(&lockdep_map);
 	/*
@@ -3051,12 +3054,15 @@ __acquires(&pool->lock)
 	lock_map_release(&lockdep_map);
 	lock_map_release(&pwq->wq->lockdep_map);
 
-	if (unlikely(in_atomic() || lockdep_depth(current) > 0 ||
-		     rcu_preempt_depth() > 0)) {
-		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d/%d\n"
-		       "     last function: %ps\n",
-		       current->comm, preempt_count(), rcu_preempt_depth(),
-		       task_pid_nr(current), worker->current_func);
+	if (unlikely((worker->task && in_atomic()) ||
+		     lockdep_depth(current) != lockdep_start_depth ||
+		     rcu_preempt_depth() != rcu_start_depth)) {
+		pr_err("BUG: workqueue leaked atomic, lock or RCU: %s[%d]\n"
+		       "     preempt=0x%08x lock=%d->%d RCU=%d->%d workfn=%ps\n",
+		       current->comm, task_pid_nr(current), preempt_count(),
+		       lockdep_start_depth, lockdep_depth(current),
+		       rcu_start_depth, rcu_preempt_depth(),
+		       worker->current_func);
 		debug_show_held_locks(current);
 		dump_stack();
 	}
@@ -3538,6 +3544,19 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 	return wait;
 }
 
+static void touch_wq_lockdep_map(struct workqueue_struct *wq)
+{
+	lock_map_acquire(&wq->lockdep_map);
+	lock_map_release(&wq->lockdep_map);
+}
+
+static void touch_work_lockdep_map(struct work_struct *work,
+				   struct workqueue_struct *wq)
+{
+	lock_map_acquire(&work->lockdep_map);
+	lock_map_release(&work->lockdep_map);
+}
+
 /**
  * __flush_workqueue - ensure that any scheduled work has run to completion.
  * @wq: workqueue to flush
@@ -3557,8 +3576,7 @@ void __flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
-	lock_map_acquire(&wq->lockdep_map);
-	lock_map_release(&wq->lockdep_map);
+	touch_wq_lockdep_map(wq);
 
 	mutex_lock(&wq->mutex);
 
@@ -3757,6 +3775,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	struct worker *worker = NULL;
 	struct worker_pool *pool;
 	struct pool_workqueue *pwq;
+	struct workqueue_struct *wq;
 
 	might_sleep();
 
@@ -3780,11 +3799,14 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 		pwq = worker->current_pwq;
 	}
 
-	check_flush_dependency(pwq->wq, work);
+	wq = pwq->wq;
+	check_flush_dependency(wq, work);
 
 	insert_wq_barrier(pwq, barr, work, worker);
 	raw_spin_unlock_irq(&pool->lock);
 
+	touch_work_lockdep_map(work, wq);
+
 	/*
 	 * Force a lock recursion deadlock when using flush_work() inside a
 	 * single-threaded or rescuer equipped workqueue.
@@ -3794,11 +3816,9 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	 * workqueues the deadlock happens when the rescuer stalls, blocking
 	 * forward progress.
 	 */
-	if (!from_cancel &&
-	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
-		lock_map_acquire(&pwq->wq->lockdep_map);
-		lock_map_release(&pwq->wq->lockdep_map);
-	}
+	if (!from_cancel && (wq->saved_max_active == 1 || wq->rescuer))
+		touch_wq_lockdep_map(wq);
+
 	rcu_read_unlock();
 	return true;
 already_gone:
@@ -3817,9 +3837,6 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!work->func))
 		return false;
 
-	lock_map_acquire(&work->lockdep_map);
-	lock_map_release(&work->lockdep_map);
-
 	if (start_flush_work(work, &barr, from_cancel)) {
 		wait_for_completion(&barr.done);
 		destroy_work_on_stack(&barr.work);
-- 
2.43.0


