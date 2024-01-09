Return-Path: <linux-kernel+bounces-21437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA91828F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F24288875
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68BD3F8F8;
	Tue,  9 Jan 2024 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RNWn93Rj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5A3F8F1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D47kuEUuvY/SrXunoNEbi3Kkq7SL6IKph7l39rRXOkA=; b=RNWn93RjQaoOeXeMsl8H+OA4py
	NXoKNEhNNHWWuomGV6O8Wr2hOdVYNb7AJxYDZCw6AXMhIj71E1JaZYENde6tEe8+OXgQjpyYiFiok
	avPWrWxjLKnrJdyKsoUWbpEdQZgQA3R4/pTyTIyo8KBQENc1bDN30WVklnA1woOQ00FBYVp6LRVV9
	bHBbDJN050IGQmSdZ1jeu+hwWDQDlG1Mq6Ti4Q7YToN7o+6WmquSGmIAqtTNJUbqMF0XAsIzSCreX
	+LJnKXMBRISm8WJjS+T8K6MHVdp2K+460zdXI9aOLFtdgjKhEXVv7A7AJMj1EAUjdqnwHuSaLX2cV
	Kzk1+xsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNJrH-00AMnq-PL; Tue, 09 Jan 2024 21:42:03 +0000
Date: Tue, 9 Jan 2024 21:42:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam.howlett@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC] Sleep waiting for an rwsem to be unlocked
Message-ID: <ZZ29q3x3I0Z3dQ8y@casper.infradead.org>
References: <ZZ1+ZicgN8dZ3zj3@casper.infradead.org>
 <04d23913-fb0e-4f47-9e6c-dae50ee28a3a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d23913-fb0e-4f47-9e6c-dae50ee28a3a@redhat.com>

On Tue, Jan 09, 2024 at 04:04:08PM -0500, Waiman Long wrote:
> On 1/9/24 12:12, Matthew Wilcox wrote:
> > The problem we're trying to solve is a lock-free walk of
> > /proc/$pid/maps. If the process is modifying the VMAs at the same time
> > the reader is walking them, it can see garbage.  For page faults, we
> > handle this by taking the mmap_lock for read and retrying the page fault
> > (excluding any further modifications).
> > 
> > We don't want to take that approach for the maps file.  The monitoring
> > task may have a significantly lower process priority, and so taking
> > the mmap_lock for read can block it for a significant period of time.
> > The obvious answer is to do some kind of backoff+sleep.  But we already
> > have a wait queue, so why not use it?
> > 
> > I haven't done the rwbase version; this is just a demonstration of what
> > we could do.  It's also untested other than by compilation.  It might
> > well be missing something.
> 
> It is not clear what exactly is the purpose of this new API. Are you just

.. really?  I wrote it out in the part you quoted, and I wrote it out
differently in the kernel-doc for the function:

+ * rwsem_wait_killable - Wait for current write lock holder to release lock
+ * @sem: The semaphore to wait on.
+ *
+ * This is equivalent to calling down_read(); up_read() but avoids the
+ * possibility that the thread will be preempted while holding the lock
+ * causing threads that want to take the lock for writes to block.  The
+ * intended use case is for lockless readers who notice an inconsistent
+ * state and want to wait for the current writer to finish.

Something I forgot to add was that we only guarantee that _a_ writer
finished; another writer may have the lock when the function returns.

> waiting in the rwsem wait queue until it gets waken up without taking a read
> or write lock? I see two issues at the moment.
> 
> 1) The handoff processing should exclude the new RWSEM_WAITING_FOR_RELEASE
> waiter types.

Hmm.  I thought I'd done that by only incrementing 'woken' for
RWSEM_WAITING_FOR_READ types.

> 2) If the rwsem is free, it should call rwsem_wake() again to wake up the
> next waiter, like what is being done in up_write().

because the wait queue might have a waiter followed by a writer?  I
think calling rwsem_wake() again is probably a bad idea as it will
defeat the MAX_READERS_WAKEUP limit.  Probably rwsem_mark_wake()
needs to handle that case itself; maybe something like this?

+++ b/kernel/locking/rwsem.c
@@ -419,6 +419,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,

        lockdep_assert_held(&sem->wait_lock);

+again:
        /*
         * Take a peek at the queue head waiter such that we can determine
         * the wakeup(s) to perform.
@@ -542,6 +543,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
                 */
                if (oldcount & RWSEM_FLAG_HANDOFF)
                        adjustment -= RWSEM_FLAG_HANDOFF;
+       } else {
+               /*
+                * Everybody we woke was a waiter, not a reader.  Wake the
+                * first writer instead.
+                */
+               goto again;
        }

        if (adjustment)


