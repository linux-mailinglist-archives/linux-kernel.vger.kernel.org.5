Return-Path: <linux-kernel+bounces-21405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B406828EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A17F1F2603E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040A3DB87;
	Tue,  9 Jan 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TN5CPoGR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873753DB80
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704834255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9EkMdOtj4r6uHh7Rf4MTrM07P8zEb0VwaBuUqSRWJQ=;
	b=TN5CPoGRZSrlsiCSgB9MXfbBQZTp9vicebUPOYre+dkbI7J5ilqbiTBpr1lToxq1yP6/OZ
	wycdmQ2LqbE1TAu5ikxQNIuC9FD8HVZMfBn77MXWKWYgqJk6h7rYitdO0vgPncVXiShyUv
	a+5BsV+V7hdzxthZWT1KWRmFdRkMW9Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-bdC-rmWsMPaqIlNSsHkEVg-1; Tue, 09 Jan 2024 16:04:10 -0500
X-MC-Unique: bdC-rmWsMPaqIlNSsHkEVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CD9E82DFE0;
	Tue,  9 Jan 2024 21:04:09 +0000 (UTC)
Received: from [10.22.9.97] (unknown [10.22.9.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DF0782166AE4;
	Tue,  9 Jan 2024 21:04:08 +0000 (UTC)
Message-ID: <04d23913-fb0e-4f47-9e6c-dae50ee28a3a@redhat.com>
Date: Tue, 9 Jan 2024 16:04:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Sleep waiting for an rwsem to be unlocked
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <liam.howlett@oracle.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <ZZ1+ZicgN8dZ3zj3@casper.infradead.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZZ1+ZicgN8dZ3zj3@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 1/9/24 12:12, Matthew Wilcox wrote:
> The problem we're trying to solve is a lock-free walk of
> /proc/$pid/maps. If the process is modifying the VMAs at the same time
> the reader is walking them, it can see garbage.  For page faults, we
> handle this by taking the mmap_lock for read and retrying the page fault
> (excluding any further modifications).
>
> We don't want to take that approach for the maps file.  The monitoring
> task may have a significantly lower process priority, and so taking
> the mmap_lock for read can block it for a significant period of time.
> The obvious answer is to do some kind of backoff+sleep.  But we already
> have a wait queue, so why not use it?
>
> I haven't done the rwbase version; this is just a demonstration of what
> we could do.  It's also untested other than by compilation.  It might
> well be missing something.

It is not clear what exactly is the purpose of this new API. Are you 
just waiting in the rwsem wait queue until it gets waken up without 
taking a read or write lock? I see two issues at the moment.

1) The handoff processing should exclude the new 
RWSEM_WAITING_FOR_RELEASE waiter types.
2) If the rwsem is free, it should call rwsem_wake() again to wake up 
the next waiter, like what is being done in up_write().

Cheers,
Longman

>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/rwsem.h  |   6 +++
>   kernel/locking/rwsem.c | 104 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 108 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 4f1c18992f76..e7bf9dfc471a 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -250,6 +250,12 @@ DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
>    */
>   extern void downgrade_write(struct rw_semaphore *sem);
>   
> +/*
> + * wait for current writer to be finished
> + */
> +void rwsem_wait(struct rw_semaphore *sem);
> +int __must_check rwsem_wait_killable(struct rw_semaphore *sem);
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /*
>    * nested locking. NOTE: rwsems are not allowed to recurse
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2340b6d90ec6..7c8096c5586f 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -332,7 +332,8 @@ EXPORT_SYMBOL(__init_rwsem);
>   
>   enum rwsem_waiter_type {
>   	RWSEM_WAITING_FOR_WRITE,
> -	RWSEM_WAITING_FOR_READ
> +	RWSEM_WAITING_FOR_READ,
> +	RWSEM_WAITING_FOR_RELEASE,
>   };
>   
>   struct rwsem_waiter {
> @@ -511,7 +512,8 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>   		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
>   			continue;
>   
> -		woken++;
> +		if (waiter->type == RWSEM_WAITING_FOR_READ)
> +			woken++;
>   		list_move_tail(&waiter->list, &wlist);
>   
>   		/*
> @@ -1401,6 +1403,67 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
>   	preempt_enable();
>   }
>   
> +static inline int __wait_read_common(struct rw_semaphore *sem, int state)
> +{
> +	int ret = 0;
> +	long adjustment = 0;
> +	struct rwsem_waiter waiter;
> +	DEFINE_WAKE_Q(wake_q);
> +
> +	waiter.task = current;
> +	waiter.type = RWSEM_WAITING_FOR_RELEASE;
> +	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> +	waiter.handoff_set = false;
> +
> +	preempt_disable();
> +	raw_spin_lock_irq(&sem->wait_lock);
> +	if (list_empty(&sem->wait_list)) {
> +		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
> +			/* Provide lock ACQUIRE */
> +			smp_acquire__after_ctrl_dep();
> +			raw_spin_unlock_irq(&sem->wait_lock);
> +			goto done;
> +		}
> +		adjustment = RWSEM_FLAG_WAITERS;
> +	}
> +	rwsem_add_waiter(sem, &waiter);
> +	if (adjustment) {
> +		long count = atomic_long_add_return(adjustment, &sem->count);
> +		rwsem_cond_wake_waiter(sem, count, &wake_q);
> +	}
> +	raw_spin_unlock_irq(&sem->wait_lock);
> +
> +	if (!wake_q_empty(&wake_q))
> +		wake_up_q(&wake_q);
> +
> +	for (;;) {
> +		set_current_state(state);
> +		if (!smp_load_acquire(&waiter.task)) {
> +			/* Matches rwsem_mark_wake()'s smp_store_release(). */
> +			break;
> +		}
> +		if (signal_pending_state(state, current)) {
> +			raw_spin_lock_irq(&sem->wait_lock);
> +			if (waiter.task)
> +				goto out_nolock;
> +			raw_spin_unlock_irq(&sem->wait_lock);
> +			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
> +			break;
> +		}
> +		schedule_preempt_disabled();
> +	}
> +
> +	__set_current_state(TASK_RUNNING);
> +done:
> +	preempt_enable();
> +	return ret;
> +out_nolock:
> +	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
> +	__set_current_state(TASK_RUNNING);
> +	ret = -EINTR;
> +	goto done;
> +}
> +
>   #else /* !CONFIG_PREEMPT_RT */
>   
>   #define RT_MUTEX_BUILD_MUTEX
> @@ -1500,6 +1563,11 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
>   	rwbase_write_downgrade(&sem->rwbase);
>   }
>   
> +static inline int __wait_read_killable(struct rw_semaphore *sem)
> +{
> +	return rwbase_wait_lock(&sem->rwbase, TASK_KILLABLE);
> +}
> +
>   /* Debug stubs for the common API */
>   #define DEBUG_RWSEMS_WARN_ON(c, sem)
>   
> @@ -1643,6 +1711,38 @@ void downgrade_write(struct rw_semaphore *sem)
>   }
>   EXPORT_SYMBOL(downgrade_write);
>   
> +/**
> + * rwsem_wait_killable - Wait for current write lock holder to release lock
> + * @sem: The semaphore to wait on.
> + *
> + * This is equivalent to calling down_read(); up_read() but avoids the
> + * possibility that the thread will be preempted while holding the lock
> + * causing threads that want to take the lock for writes to block.  The
> + * intended use case is for lockless readers who notice an inconsistent
> + * state and want to wait for the current writer to finish.
> + */
> +int rwsem_wait_killable(struct rw_semaphore *sem)
> +{
> +	might_sleep();
> +
> +	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> +	rwsem_release(&sem->dep_map, _RET_IP_);
> +
> +	return __wait_read_common(sem, TASK_KILLABLE);
> +}
> +EXPORT_SYMBOL(rwsem_wait_killable);
> +
> +void rwsem_wait(struct rw_semaphore *sem)
> +{
> +	might_sleep();
> +
> +	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> +	rwsem_release(&sem->dep_map, _RET_IP_);
> +
> +	__wait_read_common(sem, TASK_UNINTERRUPTIBLE);
> +}
> +EXPORT_SYMBOL(rwsem_wait);
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   
>   void down_read_nested(struct rw_semaphore *sem, int subclass)


