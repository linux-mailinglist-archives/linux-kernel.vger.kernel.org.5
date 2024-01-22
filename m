Return-Path: <linux-kernel+bounces-34274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FB837739
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BB5B256B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56047F40;
	Mon, 22 Jan 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5p0qGuP"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6CE2111F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964360; cv=none; b=VtnKHVKzMPF6znmyj51FOkbJzBhd49jASbuWNBnoK4Zg6ZKzOuNKLJNv+3Inz/4uE6mjNRZnb29WjfsivyZR0BHokMFYsKHEk3zYQXtJCO07cfAW0Vvtp9bjTthOA5EMQd4jlIdu/oIi7kiiL9e1aVKY+YBmTQuzuWqxEzKQTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964360; c=relaxed/simple;
	bh=Q9hOdPEXe0ke/yugu8060AojaXG3WAMbwoljD1ccIIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hdXzYsVVD4Iwvb5ZXnKVw8+Y7tg1Nf33Ce8rJok513Ov3TqUORAs3BTUnxSq0ZSE6ucTaC/OyXW69mgCbhzadnRATl6eHi5wB+n/4kXJZslVf32sQGFIvXb7Sc95xRLKoqxozB29JMyDWMy7cfRWsuA4wQbVgRr3OOZwPW/+jBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5p0qGuP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d73130a63aso31755ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705964358; x=1706569158; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3gpFCfr+MFJxusJQ+/hrTJphcuHlmB4G30v/B/mFkJg=;
        b=f5p0qGuPJgdGzbANdKleJ8JZ0xKDtAoDRzPRkKphUnfqBl0VWIKE0gEQWbKd9EpXYT
         xbsxIqTOEeeDCZWBBk/xY20cZ3+rpbLYHEntmXp0uPu5wZb3BE3FJA/MWCMFZAjs20tx
         abpg0CNlHYbAvKh2lqdhOi41S7ODnJt5EfaWAQM9kO6UrUYMpVtGBbauGmI68w9KWUt6
         MpSSaRB+a71c/Ytt0RHJPO1NTCRGANA5bhk4Vleb8eaNg9rCn4ZBoLmp+5Vl9+xrEHSU
         3eB1h0BPOVIPbLZvw685F1yeXOUpbLliNIUd1i3vIEY2vMPVdAXXVz1tXszh5nbYUPRb
         vg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964358; x=1706569158;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gpFCfr+MFJxusJQ+/hrTJphcuHlmB4G30v/B/mFkJg=;
        b=l4Hva4z699C3he6iar6HKi80uOO7OP2hQ8OyFsDWh5DShjy63HuNtRn383mB+yOpBr
         xdXRGQaT/hSeYPTvkU0lIxegiU8uBBYVE25GQw8/+vt3h3nOlo1ylebhVHnXiy8nJWqI
         LjDuPlY3OBor+o2TPI8cjbcoxHa313rHc+GIWXZr3CW1a2Zz5gtSrgx5bX9axET+fkfh
         XVcm98qqGkucLXvZ/DbPSHyOpnmkZtxpiR7ZoJR89dTYehD6AFBu1/LPTSJeErSSh5aK
         3n998SNNOF/uVB6+btiKVpu0crlHL11TLzmTdvLHF4W4fETql3AVi2j3ulq8y7C9EVtU
         kyqQ==
X-Gm-Message-State: AOJu0YwTSf6eAuWjpRGShvQsZ+ScyQCCVKGwCbA4Hfzo6heNz9jXrvvy
	zVhyhlmWb354psg1r/uyVl/9pk7v9lRT2SYCLnWI3bab3mo5Lirdl4ISA8pkHdjzG8Qxhzs/XFn
	ZLw==
X-Google-Smtp-Source: AGHT+IHV74JFZ+Uo+QZqb6reD2IYCaubRfZ8DK2kPEylNVFoEigRVJ6u/G5TGZVv0gG/hG1zxEoznQ==
X-Received: by 2002:a17:902:dacb:b0:1d5:76a6:6402 with SMTP id q11-20020a170902dacb00b001d576a66402mr42888plx.17.1705964357712;
        Mon, 22 Jan 2024 14:59:17 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id hq15-20020a056a00680f00b006dbd2231184sm4306692pfb.70.2024.01.22.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:59:16 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun
 Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in
 percpu_up_write
Date: Mon, 22 Jan 2024 14:59:14 -0800
Message-ID: <xm26zfwx7z5p.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The waitq wakeup in percpu_up_write necessarily runs the wake function
immediately in the current thread. With it calling
__percpu_rwsem_trylock on behalf of the thread being woken, the lock is
extremely fair and FIFO, with the window for unfairness merely being the
time between the release of sem->block and the completion of a relevant
trylock.

However, the woken threads that now hold the lock may not be chosen to
run for a long time, and it would be useful to have more of this window
available for a currently running thread to unfairly take the lock
immediately and use it. This can result in priority-inversion issues
with high contention or things like CFS_BANDWIDTH quotas.

The even older version of percpu_rwsem that used an rwsem at its core
provided some related gains in a different fashion through
RWSEM_SPIN_ON_OWNER; while it had a similarly small window, waiting
writers could spin, making it far more likely that a thread would hit
this window.

Signed-off-by: Ben Segall <bsegall@google.com>

---

So the actual problem we saw was that one job had severe slowdowns
during startup with certain other jobs on the machine, and the slowdowns
turned out to be some cgroup moves it did during startup. The antagonist
jobs were spawning huge numbers of threads and some other internal bugs
were exacerbating their contention. The lock handoff meant that a batch
of antagonist threads would receive the read lock of
cgroup_threadgroup_rwsem and at least some of those threads would take a
long time to be scheduled.

As a totally artificial test, you can see occasional latencies up
to multiple seconds on moving singlethreaded processes with
cgroup.procs, with an antagonist cpu cgroup of thousands of cpusoakers
and tasks doing (pthread_create; pthread_join) or fork/join. A simple
antagonist is just a cpu+cpuset cgroup and:

bash -c 'enter cgroup; for i in {1..4000}; do bash -c "while true; do :; done&"; done' &
bash -c 'enter cgroup; for i in {1..4000}; do bash -c "while true; do /bin/true; done&"; done' &

favordynmods improves the average cost of the migrate, but doesn't help
much with the spikes. This patch does.

The locktorture results under the current locktorture are mixed (10m
runtime, 72 cpu machine, default settings):

With this patch:
Writes:  Total: 56094  Max/Min: 922/680   Fail: 0 
Reads :  Total: 21522  Max/Min: 305/292   Fail: 0

Baseline:
Writes:  Total: 33801  Max/Min: 472/468   Fail: 0
Reads :  Total: 33649  Max/Min: 475/463   Fail: 0

Under the old locktorture I originally tested against (or patching it
back in), where torture_rwsem_write_delay basically did
"mdelay(long_hold / 10)" when it wasn't doing the long hold, the results
were more clearly beneficial (there's actual noticeable variance in this
config, so I have stats and an example run near the median):

Baseline:
Writes:  Total: 11852  Max/Min: 167/164   Fail: 0
Reads :  Total: 11858  Max/Min: 169/164   Fail: 0
    N           Min           Max        Median           Avg        Stddev
R  50         10297         15142         11690      11951.72     1437.2562
W  50         10296         15144         11692      11952.04     1437.5479

Patched:
Writes:  Total: 27624  Max/Min: 442/334   Fail: 0
Reads :  Total: 13957  Max/Min: 197/192   Fail: 0
    N           Min           Max        Median           Avg        Stddev
R  30         13725         17133         13902     14458.467      1199.125
W  30         27525         28880         27683     27844.533     372.82701


Which of these locktorture setups is a more useful test in general I
don't know, the patch removing the mdelay ("locktorture: Add long_hold
to adjust lock-hold delays") left in some of the shortdelay type
mdelay/udelay calls for other locks.

Of course, whenever proxy execution lands, the downsides of the current
nearly 100% fifo behavior will be gone.


---
 kernel/locking/percpu-rwsem.c | 55 +++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 185bd1c906b01..251c1a7a94e40 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -112,22 +112,22 @@ static bool __percpu_rwsem_trylock(struct percpu_rw_semaphore *sem, bool reader)
  *
  * We use EXCLUSIVE for both readers and writers to preserve FIFO order,
  * and play games with the return value to allow waking multiple readers.
  *
  * Specifically, we wake readers until we've woken a single writer, or until a
- * trylock fails.
+ * check of the sem->block value fails.
  */
 static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 				      unsigned int mode, int wake_flags,
 				      void *key)
 {
 	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
 	struct percpu_rw_semaphore *sem = key;
 	struct task_struct *p;
 
-	/* concurrent against percpu_down_write(), can get stolen */
-	if (!__percpu_rwsem_trylock(sem, reader))
+	/* racy, just an optimization to stop waking if the lock is taken */
+	if (atomic_read(&sem->block))
 		return 1;
 
 	p = get_task_struct(wq_entry->private);
 	list_del_init(&wq_entry->entry);
 	smp_store_release(&wq_entry->private, NULL);
@@ -138,32 +138,44 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 	return !reader; /* wake (readers until) 1 writer */
 }
 
 static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
 {
-	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
 	bool wait;
+	bool first = true;
 
-	spin_lock_irq(&sem->waiters.lock);
-	/*
-	 * Serialize against the wakeup in percpu_up_write(), if we fail
-	 * the trylock, the wakeup must see us on the list.
-	 */
-	wait = !__percpu_rwsem_trylock(sem, reader);
-	if (wait) {
-		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
-		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
-	}
-	spin_unlock_irq(&sem->waiters.lock);
+	do {
+		DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
 
-	while (wait) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!smp_load_acquire(&wq_entry.private))
-			break;
-		schedule();
-	}
-	__set_current_state(TASK_RUNNING);
+		spin_lock_irq(&sem->waiters.lock);
+		/*
+		 * Serialize against the wakeup in percpu_up_write(), if we fail
+		 * the trylock, the wakeup must see us on the list.
+		 */
+		wait = !__percpu_rwsem_trylock(sem, reader);
+		if (wait) {
+			wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
+			/*
+			 * If we wake but lose a race for the lock, preserve
+			 * FIFO-ish behavior by skipping the queue
+			 */
+			if (first)
+				__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
+			else
+				__add_wait_queue(&sem->waiters, &wq_entry);
+			first = false;
+		}
+		spin_unlock_irq(&sem->waiters.lock);
+
+		while (wait) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			if (!smp_load_acquire(&wq_entry.private))
+				break;
+			schedule();
+		}
+		__set_current_state(TASK_RUNNING);
+	} while (wait && !__percpu_rwsem_trylock(sem, reader));
 }
 
 bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
 	if (__percpu_down_read_trylock(sem))
-- 
2.43.0.429.g432eaa2c6b-goog


