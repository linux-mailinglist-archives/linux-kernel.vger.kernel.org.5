Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C675F804123
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjLDVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDVsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F10CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701726537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kS6i2Wl+xaKGI8Nxc2Ui6Ue4SF9Vi6p3GOlQqdih5uY=;
        b=Vlmpo3HnUBuPm333y6wM7IdBNxVbv/G+ZV8lM1wPHxYjG1gvg8T1YOT5rv7aa8iV7WSxbL
        wdQ2I+PQOh5dzP6e2WlJi5AGFL3lAU0iDep1H6qfnd9k8dxig2intwXEneKwvBTdub0u+P
        k3kdqi7d3APETdAzDqHXg1+SY5RXSFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-nQcEPCKXOGmuo3KymdYJ7w-1; Mon, 04 Dec 2023 16:48:51 -0500
X-MC-Unique: nQcEPCKXOGmuo3KymdYJ7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B778E85A59D;
        Mon,  4 Dec 2023 21:48:50 +0000 (UTC)
Received: from [10.22.9.47] (unknown [10.22.9.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 753272166B26;
        Mon,  4 Dec 2023 21:48:49 +0000 (UTC)
Message-ID: <a7879293-c25d-4226-b646-0811299b72ad@redhat.com>
Date:   Mon, 4 Dec 2023 16:48:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] locking: Document that some lock types must stay alive
 during unlock
Content-Language: en-US
To:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231204132259.112152-1-jannh@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231204132259.112152-1-jannh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 08:22, Jann Horn wrote:
> I have seen several cases of attempts to use mutex_unlock() to release an
> object such that the object can then be freed by another task.
>
> This is not safe because mutex_unlock(), in the
> MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
> structure after having marked it as unlocked; so mutex_unlock() requires
> its caller to ensure that the mutex stays alive until mutex_unlock()
> returns.
>
> If MUTEX_FLAG_WAITERS is set and there are real waiters, those waiters
> have to keep the mutex alive, but we could have a spurious
> MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
> between the points where __mutex_unlock_slowpath() did the cmpxchg
> reading the flags and where it acquired the wait_lock.
>
> ( With spinlocks, that kind of code pattern is allowed and, from what I
>    remember, used in several places in the kernel. )
>
> Document this, such a semantic difference between mutexes and spinlocks
> is fairly unintuitive. Based on feedback on the list, this should be
> documented as a general locking caveat, not as a mutex-specific thing.
>
> (changelog with some input from mingo)
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Based on feedback on the list, I've gotten rid of the confusing
> "atomic" wording.
> Also, based on Peter Zijlstra's feedback that this more of a general
> thing with sleeping locks and not specific to mutexes, I have rewritten
> the patch to have some central documentation on the caveat in
> Documentation/locking/locktypes.rst, and then just sprinkle some
> references to that in a few other places.
>
> I saw that the first version of this patch already landed in tip tree;
> can you still yank that back out of the tree? If not, maybe revert that
> for now, and then later land this new version (or a future revision of
> it) once we've figured out if the new wording is good?
>
>
>   Documentation/locking/locktypes.rst    | 23 +++++++++++++++++++++++
>   Documentation/locking/mutex-design.rst |  2 ++
>   kernel/locking/mutex.c                 |  5 +++++
>   kernel/locking/rwsem.c                 | 10 ++++++++++
>   4 files changed, 40 insertions(+)
>
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
> index 80c914f6eae7..c9a4bcc967ea 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -95,6 +95,29 @@ rw_semaphores have a special interface which allows non-owner release for
>   readers.
>   
>   
> +Releasing and freeing
> +=====================
> +For some lock types, such as spinlocks, the lock release operation is designed
> +to allow another concurrent task to free the lock as soon as the lock has been
> +released - in other words, similarly to refcounts, the unlock operation will not
> +access the lock object anymore after marking it as unlocked.
> +
> +This behavior is guaranteed for:
> +
> + - spinlock_t (including in PREEMPT_RT kernels, where spinlock_t is
> +   implemented as an rtmutex)
> +
> +There are other lock types where the lock release operation makes no such
> +guarantee and the caller must ensure that the lock is not destroyed before the
> +unlock operation has returned.
> +Most sleeping locks are in this category.
> +
> +This is the case in particular for (not an exhaustive list):
> +
> + - mutex
> + - rw_semaphore
> +
> +
>   rtmutex
>   =======
>   
> diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
> index 78540cd7f54b..bbb4c4d56ed0 100644
> --- a/Documentation/locking/mutex-design.rst
> +++ b/Documentation/locking/mutex-design.rst
> @@ -101,6 +101,8 @@ features that make lock debugging easier and faster:
>       - Detects multi-task circular deadlocks and prints out all affected
>         locks and tasks (and only those tasks).
>   
> +The mutex user must ensure that the mutex is not destroyed while a unlock
> +operation is still in progress, see Documentation/locking/locktypes.rst.
>   
>   Interfaces
>   ----------
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 2deeeca3e71b..fa4834dba407 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -532,6 +532,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>    * This function must not be used in interrupt context. Unlocking
>    * of a not locked mutex is not allowed.
>    *
> + * The caller must ensure that the mutex stays alive until this function has
> + * returned - mutex_unlock() can NOT directly be used to release an object such
> + * that another concurrent task can free it.
> + * See Documentation/locking/locktypes.rst.
> + *
>    * This function is similar to (but not equivalent to) up().
>    */
>   void __sched mutex_unlock(struct mutex *lock)
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2340b6d90ec6..cbc00a269deb 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1615,6 +1615,11 @@ EXPORT_SYMBOL(down_write_trylock);
>   
>   /*
>    * release a read lock
> + *
> + * The caller must ensure that the rw_semaphore stays alive until this function
> + * has returned - up_read() can NOT directly be used to release an object such
> + * that another concurrent task can free it.
> + * See Documentation/locking/locktypes.rst.
>    */
>   void up_read(struct rw_semaphore *sem)
>   {
> @@ -1625,6 +1630,11 @@ EXPORT_SYMBOL(up_read);
>   
>   /*
>    * release a write lock
> + *
> + * The caller must ensure that the rw_semaphore stays alive until this function
> + * has returned - up_write() can NOT directly be used to release an object such
> + * that another concurrent task can free it.
> + * See Documentation/locking/locktypes.rst.
>    */
>   void up_write(struct rw_semaphore *sem)
>   {

The explanation is much clearer now.

Acked-by: Waiman Long <longman@redhat.com>

