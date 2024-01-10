Return-Path: <linux-kernel+bounces-21645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830B829241
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4EE1C253F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982F917C8;
	Wed, 10 Jan 2024 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu02W16l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CA1373
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704851698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQB1ySGO9qpTzdm6wA65jYPIimFzJZS/mRh8eq61ypU=;
	b=Mu02W16lHR9mpzQ2ZlB8KT33UN1ZcVaW6SC0otr06XSM9PpLk+1jJaccnqYqnfZy1SqRWt
	n4h3tX8sH32ojllVjXfpLQL4padj+CDbz+S3fd+qSvv5iM8/YUJu/bAr9VavSf0z/6bgiJ
	ZqqhzmqA50TzLLRMgfbBBCywdB4iYWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-nbkjtnjTMAmNtuft_HnKGw-1; Tue, 09 Jan 2024 20:54:53 -0500
X-MC-Unique: nbkjtnjTMAmNtuft_HnKGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1124282DFE0;
	Wed, 10 Jan 2024 01:54:53 +0000 (UTC)
Received: from [10.22.9.97] (unknown [10.22.9.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8F46CC15A0C;
	Wed, 10 Jan 2024 01:54:52 +0000 (UTC)
Message-ID: <1e5cf85b-9fa1-42ad-8cfa-46d83bdefda3@redhat.com>
Date: Tue, 9 Jan 2024 20:54:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Sleep waiting for an rwsem to be unlocked
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <liam.howlett@oracle.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <ZZ1+ZicgN8dZ3zj3@casper.infradead.org>
 <04d23913-fb0e-4f47-9e6c-dae50ee28a3a@redhat.com>
 <ZZ29q3x3I0Z3dQ8y@casper.infradead.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZZ29q3x3I0Z3dQ8y@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


On 1/9/24 16:42, Matthew Wilcox wrote:
> On Tue, Jan 09, 2024 at 04:04:08PM -0500, Waiman Long wrote:
>> On 1/9/24 12:12, Matthew Wilcox wrote:
>>> The problem we're trying to solve is a lock-free walk of
>>> /proc/$pid/maps. If the process is modifying the VMAs at the same time
>>> the reader is walking them, it can see garbage.  For page faults, we
>>> handle this by taking the mmap_lock for read and retrying the page fault
>>> (excluding any further modifications).
>>>
>>> We don't want to take that approach for the maps file.  The monitoring
>>> task may have a significantly lower process priority, and so taking
>>> the mmap_lock for read can block it for a significant period of time.
>>> The obvious answer is to do some kind of backoff+sleep.  But we already
>>> have a wait queue, so why not use it?
>>>
>>> I haven't done the rwbase version; this is just a demonstration of what
>>> we could do.  It's also untested other than by compilation.  It might
>>> well be missing something.
>> It is not clear what exactly is the purpose of this new API. Are you just
> ... really?  I wrote it out in the part you quoted, and I wrote it out
> differently in the kernel-doc for the function:
>
> + * rwsem_wait_killable - Wait for current write lock holder to release lock
> + * @sem: The semaphore to wait on.
> + *
> + * This is equivalent to calling down_read(); up_read() but avoids the
> + * possibility that the thread will be preempted while holding the lock
> + * causing threads that want to take the lock for writes to block.  The
> + * intended use case is for lockless readers who notice an inconsistent
> + * state and want to wait for the current writer to finish.
>
> Something I forgot to add was that we only guarantee that _a_ writer
> finished; another writer may have the lock when the function returns.

OK, I focused on the commit log and it didn't mention that. I also 
looked at __wait_read_common() and hadn't paid much attention to the 
other wrappers.

BTW, how did the a lockless reader notices an inconsistent state? Will 
something like a write sequence count help? Though that will require 
increasing the size of the rwsem.

>
>> waiting in the rwsem wait queue until it gets waken up without taking a read
>> or write lock? I see two issues at the moment.
>>
>> 1) The handoff processing should exclude the new RWSEM_WAITING_FOR_RELEASE
>> waiter types.
> Hmm.  I thought I'd done that by only incrementing 'woken' for
> RWSEM_WAITING_FOR_READ types.
Some minor change is needed in case the RWSEM_WAITING_FOR_RELEASE waiter 
is the first one in the queue to be woken up.
>
>> 2) If the rwsem is free, it should call rwsem_wake() again to wake up the
>> next waiter, like what is being done in up_write().
> because the wait queue might have a waiter followed by a writer?  I
> think calling rwsem_wake() again is probably a bad idea as it will
> defeat the MAX_READERS_WAKEUP limit.  Probably rwsem_mark_wake()
> needs to handle that case itself; maybe something like this?

I am talking about the case that the new waiter is the only one to be 
waking up and the rwsem has no reader or writer owner.

I also think that __wait_read_common() should be merged with 
rwsem_down_read_slowpath() in some way to minimize duplicated code.

>
> +++ b/kernel/locking/rwsem.c
> @@ -419,6 +419,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>
>          lockdep_assert_held(&sem->wait_lock);
>
> +again:
>          /*
>           * Take a peek at the queue head waiter such that we can determine
>           * the wakeup(s) to perform.
> @@ -542,6 +543,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>                   */
>                  if (oldcount & RWSEM_FLAG_HANDOFF)
>                          adjustment -= RWSEM_FLAG_HANDOFF;
> +       } else {
> +               /*
> +                * Everybody we woke was a waiter, not a reader.  Wake the
> +                * first writer instead.
> +                */
> +               goto again;
>          }
>
>          if (adjustment)

That will probably work.

Cheers,
Longman


