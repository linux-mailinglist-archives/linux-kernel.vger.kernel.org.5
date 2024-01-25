Return-Path: <linux-kernel+bounces-38474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8383C06E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD21C22A37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A915C5E9;
	Thu, 25 Jan 2024 11:05:22 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538505BAF0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180722; cv=none; b=CTKgJHxszRYe5UTjMub6Sb5gzJKTLITgX+CXRLJBaEWUaz4sr5UO4LBkdnYFNL/WVceyPGdSKcIxszBxoRirXlPsQxESOC1ZpS/3+62idxj2Iok1mSi/JkmcktwLr4/IInoAalshW6VXOYLIfDbDQxjFu7nsW4XirsquYQmNI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180722; c=relaxed/simple;
	bh=dkocADbOYvTMw/1B14GzZTy0MDUDsy+hKS032mNu1oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhoscBlI9IK4BbQsjPf63k9/sdG8eqZVoaoM5u5B5eBCW/Gezkz7M3/aJLVzMK729juTCQi5D+kFbXkhZHONaU+AW2RVe8SY9/DVyQC0swRtmMzUkGk2B82fidRZ0aDVWTOAZkyL8g9AbK875E8w2vM++4JEUNTFD0FA3TWKIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.48])
	by sina.com (10.75.12.45) with ESMTP
	id 65B2406000006131; Thu, 25 Jan 2024 19:05:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 90902331457749
X-SMAIL-UIID: C48E56203AD94D7ABC5CFEFD23E8F7E5-20240125-190507-1
From: Hillf Danton <hdanton@sina.com>
To: Benjamin Segall <bsegall@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in percpu_up_write
Date: Thu, 25 Jan 2024 19:04:56 +0800
Message-Id: <20240125110456.783-1-hdanton@sina.com>
In-Reply-To: <xm26v87imlgc.fsf@bsegall-linux.svl.corp.google.com>
References: <xm26zfwx7z5p.fsf@google.com> <20240123150541.1508-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Jan 2024 14:10:43 -0800 Benjamin Segall <bsegall@google.com>
> Hillf Danton <hdanton@sina.com> writes:
> > On Mon, 22 Jan 2024 14:59:14 -0800 Benjamin Segall <bsegall@google.com>
> >> So the actual problem we saw was that one job had severe slowdowns
> >> during startup with certain other jobs on the machine, and the slowdowns
> >> turned out to be some cgroup moves it did during startup. The antagonist
> >> jobs were spawning huge numbers of threads and some other internal bugs
> >> were exacerbating their contention. The lock handoff meant that a batch
> >> of antagonist threads would receive the read lock of
> >> cgroup_threadgroup_rwsem and at least some of those threads would take a
> >> long time to be scheduled.
> >
> > If you want to avoid starved lock waiter, take a look at RWSEM_FLAG_HANDOFF
> > in rwsem_down_read_slowpath().
> 
> rwsem's HANDOFF flag is the exact opposite of what this patch is doing.

You and I are not on the same page.

> Percpu-rwsem's current code has perfect handoff for read->write, and a very
> short window for write->read (or write->write) to be beaten by a new writer.

Given no chance left for spin on owner who is legal to take a ten-minute nap,
the right thing known to do on behalf of starved waiters is to add the HANDOFF
mechanism without any heuristic like you proposed for instance, in order to
force lock acquirers to go the slow path.

Only for thoughts.

--- x/kernel/locking/percpu-rwsem.c
+++ y/kernel/locking/percpu-rwsem.c
@@ -22,6 +22,7 @@ int __percpu_init_rwsem(struct percpu_rw
 	rcuwait_init(&sem->writer);
 	init_waitqueue_head(&sem->waiters);
 	atomic_set(&sem->block, 0);
+	atomic_set(&sem->ww, 0);	/* write waiters */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
 	lockdep_init_map(&sem->dep_map, name, key, 0);
@@ -135,6 +136,9 @@ static int percpu_rwsem_wake_function(st
 	wake_up_process(p);
 	put_task_struct(p);
 
+	if (!reader)
+		atomic_dec(&sem->ww);
+
 	return !reader; /* wake (readers until) 1 writer */
 }
 
@@ -148,8 +152,10 @@ static void percpu_rwsem_wait(struct per
 	 * Serialize against the wakeup in percpu_up_write(), if we fail
 	 * the trylock, the wakeup must see us on the list.
 	 */
-	wait = !__percpu_rwsem_trylock(sem, reader);
+	wait = atomic_read(&sem->ww) || !__percpu_rwsem_trylock(sem, reader);
 	if (wait) {
+		if (!reader)
+			atomic_inc(&sem->ww);
 		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
 		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
 	}
@@ -166,7 +172,7 @@ static void percpu_rwsem_wait(struct per
 
 bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
-	if (__percpu_down_read_trylock(sem))
+	if (!atomic_read(&sem->ww) && __percpu_down_read_trylock(sem))
 		return true;
 
 	if (try)
@@ -234,7 +240,7 @@ void __sched percpu_down_write(struct pe
 	 * Try set sem->block; this provides writer-writer exclusion.
 	 * Having sem->block set makes new readers block.
 	 */
-	if (!__percpu_down_write_trylock(sem))
+	if (atomic_read(&sem->ww) || !__percpu_down_read_trylock(sem))
 		percpu_rwsem_wait(sem, /* .reader = */ false);
 
 	/* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */

