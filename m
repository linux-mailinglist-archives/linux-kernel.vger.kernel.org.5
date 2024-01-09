Return-Path: <linux-kernel+bounces-21149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D7D828AC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9351F24AE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B873AC25;
	Tue,  9 Jan 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gS9xhmNu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC843A8DC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=//pxZM9j6oBiMHjQDWvj5xy5Fv3+yMPMO7nX8mFWlyQ=; b=gS9xhmNuHQm9vKSmTc9wbnZT8T
	V3dRJRejYEpi0zi0hBPtUh9LFJCzzfSThHw+cU6u5tWtPlhLTYW2ulWW6P9lSLkaBg1nCibcSEMwA
	lxLKhoqWQ/zbvyIQOwrDsAZA/irsx+MY739mEnMfAATHlpIeI5Y7yjjZsNCILSghOAIyp3X+Ok1dZ
	p1wRUNY0uLTi4mujGHwR8sUMN3ZeM6eo+Tye+LpPtFR1V1PSDJKKn9Zen/69IvsD46OQ2UwozOLZM
	W/F8/CP+5EwH5okccu+xtNRRkdSnFzF6OxyhdpsonVJx/EdI4SHuxbYD1Z60cxqgrUtMzQhxpxA4f
	ouTsJ3rQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNFe2-00A6LU-Ht; Tue, 09 Jan 2024 17:12:06 +0000
Date: Tue, 9 Jan 2024 17:12:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam.howlett@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [RFC] Sleep waiting for an rwsem to be unlocked
Message-ID: <ZZ1+ZicgN8dZ3zj3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The problem we're trying to solve is a lock-free walk of
/proc/$pid/maps. If the process is modifying the VMAs at the same time
the reader is walking them, it can see garbage.  For page faults, we
handle this by taking the mmap_lock for read and retrying the page fault
(excluding any further modifications).

We don't want to take that approach for the maps file.  The monitoring
task may have a significantly lower process priority, and so taking
the mmap_lock for read can block it for a significant period of time.
The obvious answer is to do some kind of backoff+sleep.  But we already
have a wait queue, so why not use it?

I haven't done the rwbase version; this is just a demonstration of what
we could do.  It's also untested other than by compilation.  It might
well be missing something.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rwsem.h  |   6 +++
 kernel/locking/rwsem.c | 104 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 4f1c18992f76..e7bf9dfc471a 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -250,6 +250,12 @@ DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
  */
 extern void downgrade_write(struct rw_semaphore *sem);
 
+/*
+ * wait for current writer to be finished
+ */
+void rwsem_wait(struct rw_semaphore *sem);
+int __must_check rwsem_wait_killable(struct rw_semaphore *sem);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * nested locking. NOTE: rwsems are not allowed to recurse
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2340b6d90ec6..7c8096c5586f 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -332,7 +332,8 @@ EXPORT_SYMBOL(__init_rwsem);
 
 enum rwsem_waiter_type {
 	RWSEM_WAITING_FOR_WRITE,
-	RWSEM_WAITING_FOR_READ
+	RWSEM_WAITING_FOR_READ,
+	RWSEM_WAITING_FOR_RELEASE,
 };
 
 struct rwsem_waiter {
@@ -511,7 +512,8 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
 			continue;
 
-		woken++;
+		if (waiter->type == RWSEM_WAITING_FOR_READ)
+			woken++;
 		list_move_tail(&waiter->list, &wlist);
 
 		/*
@@ -1401,6 +1403,67 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	preempt_enable();
 }
 
+static inline int __wait_read_common(struct rw_semaphore *sem, int state)
+{
+	int ret = 0;
+	long adjustment = 0;
+	struct rwsem_waiter waiter;
+	DEFINE_WAKE_Q(wake_q);
+
+	waiter.task = current;
+	waiter.type = RWSEM_WAITING_FOR_RELEASE;
+	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
+	waiter.handoff_set = false;
+
+	preempt_disable();
+	raw_spin_lock_irq(&sem->wait_lock);
+	if (list_empty(&sem->wait_list)) {
+		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
+			/* Provide lock ACQUIRE */
+			smp_acquire__after_ctrl_dep();
+			raw_spin_unlock_irq(&sem->wait_lock);
+			goto done;
+		}
+		adjustment = RWSEM_FLAG_WAITERS;
+	}
+	rwsem_add_waiter(sem, &waiter);
+	if (adjustment) {
+		long count = atomic_long_add_return(adjustment, &sem->count);
+		rwsem_cond_wake_waiter(sem, count, &wake_q);
+	}
+	raw_spin_unlock_irq(&sem->wait_lock);
+
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
+
+	for (;;) {
+		set_current_state(state);
+		if (!smp_load_acquire(&waiter.task)) {
+			/* Matches rwsem_mark_wake()'s smp_store_release(). */
+			break;
+		}
+		if (signal_pending_state(state, current)) {
+			raw_spin_lock_irq(&sem->wait_lock);
+			if (waiter.task)
+				goto out_nolock;
+			raw_spin_unlock_irq(&sem->wait_lock);
+			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
+			break;
+		}
+		schedule_preempt_disabled();
+	}
+
+	__set_current_state(TASK_RUNNING);
+done:
+	preempt_enable();
+	return ret;
+out_nolock:
+	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
+	__set_current_state(TASK_RUNNING);
+	ret = -EINTR;
+	goto done;
+}
+
 #else /* !CONFIG_PREEMPT_RT */
 
 #define RT_MUTEX_BUILD_MUTEX
@@ -1500,6 +1563,11 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	rwbase_write_downgrade(&sem->rwbase);
 }
 
+static inline int __wait_read_killable(struct rw_semaphore *sem)
+{
+	return rwbase_wait_lock(&sem->rwbase, TASK_KILLABLE);
+}
+
 /* Debug stubs for the common API */
 #define DEBUG_RWSEMS_WARN_ON(c, sem)
 
@@ -1643,6 +1711,38 @@ void downgrade_write(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(downgrade_write);
 
+/**
+ * rwsem_wait_killable - Wait for current write lock holder to release lock
+ * @sem: The semaphore to wait on.
+ *
+ * This is equivalent to calling down_read(); up_read() but avoids the
+ * possibility that the thread will be preempted while holding the lock
+ * causing threads that want to take the lock for writes to block.  The
+ * intended use case is for lockless readers who notice an inconsistent
+ * state and want to wait for the current writer to finish.
+ */
+int rwsem_wait_killable(struct rw_semaphore *sem)
+{
+	might_sleep();
+
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
+	rwsem_release(&sem->dep_map, _RET_IP_);
+
+	return __wait_read_common(sem, TASK_KILLABLE);
+}
+EXPORT_SYMBOL(rwsem_wait_killable);
+
+void rwsem_wait(struct rw_semaphore *sem)
+{
+	might_sleep();
+
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
+	rwsem_release(&sem->dep_map, _RET_IP_);
+
+	__wait_read_common(sem, TASK_UNINTERRUPTIBLE);
+}
+EXPORT_SYMBOL(rwsem_wait);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 void down_read_nested(struct rw_semaphore *sem, int subclass)
-- 
2.43.0


