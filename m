Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEED67FFE08
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377038AbjK3Vx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377025AbjK3Vx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAA610FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701381214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pG2lRKOWfMEjs9VpsMcZUPdW+pUgM81zvIo8oiA6l4=;
        b=b91mrb68zoVXgqPVGl1CzpK0nmD88am36WQuhBy1uxTYzJJ/AUn5Ko/UP8Q2AeV/sDQrxQ
        be8SOJwCShdcqPK7Gzv/mSoazNIl23vQRlINSHRi577Yh72FhLaUS7I7yWsf+VJWeYTdPv
        WZHDxwZO3IVDGwtDwuB4vd8u4DhusnE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-23t9BpumOcWX-WjgRFx-gw-1; Thu,
 30 Nov 2023 16:53:30 -0500
X-MC-Unique: 23t9BpumOcWX-WjgRFx-gw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5029B1C06E18;
        Thu, 30 Nov 2023 21:53:30 +0000 (UTC)
Received: from [10.22.9.192] (unknown [10.22.9.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4C2F40C6EB9;
        Thu, 30 Nov 2023 21:53:29 +0000 (UTC)
Message-ID: <2f17a9a6-5781-43ef-a09b-f39310843fe6@redhat.com>
Date:   Thu, 30 Nov 2023 16:53:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking: Document that mutex_unlock() is non-atomic
Content-Language: en-US
To:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231130204817.2031407-1-jannh@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231130204817.2031407-1-jannh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 15:48, Jann Horn wrote:
> I have seen several cases of attempts to use mutex_unlock() to release an
> object such that the object can then be freed by another task.
> My understanding is that this is not safe because mutex_unlock(), in the
> MUTEX_FLAG_WAITERS && !MUTEX_FLAG_HANDOFF case, accesses the mutex
> structure after having marked it as unlocked; so mutex_unlock() requires
> its caller to ensure that the mutex stays alive until mutex_unlock()
> returns.
>
> If MUTEX_FLAG_WAITERS is set and there are real waiters, those waiters
> have to keep the mutex alive, I think; but we could have a spurious
> MUTEX_FLAG_WAITERS left if an interruptible/killable waiter bailed
> between the points where __mutex_unlock_slowpath() did the cmpxchg
> reading the flags and where it acquired the wait_lock.

Could you clarify under what condition a concurrent task can decide to 
free the object holding the mutex? Is it !mutex_is_locked() or after a 
mutex_lock()/mutex_unlock sequence?

mutex_is_locked() will return true if the mutex has waiter even if it  
is currently free.

Cheers,
Longman

>
> (With spinlocks, that kind of code pattern is allowed and, from what I
> remember, used in several places in the kernel.)
>
> If my understanding of this is correct, we should probably document this -
> I think such a semantic difference between mutexes and spinlocks is fairly
> unintuitive.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I hope for some thorough review on this patch to make sure the comments
> I'm adding are actually true, and to confirm that mutexes intentionally
> do not support this usage pattern.
>
>   Documentation/locking/mutex-design.rst | 6 ++++++
>   kernel/locking/mutex.c                 | 5 +++++
>   2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
> index 78540cd7f54b..087716bfa7b2 100644
> --- a/Documentation/locking/mutex-design.rst
> +++ b/Documentation/locking/mutex-design.rst
> @@ -101,6 +101,12 @@ features that make lock debugging easier and faster:
>       - Detects multi-task circular deadlocks and prints out all affected
>         locks and tasks (and only those tasks).
>   
> +Releasing a mutex is not an atomic operation: Once a mutex release operation
> +has begun, another context may be able to acquire the mutex before the release
> +operation has completed. The mutex user must ensure that the mutex is not
> +destroyed while a release operation is still in progress - in other words,
> +callers of 'mutex_unlock' must ensure that the mutex stays alive until
> +'mutex_unlock' has returned.
>   
>   Interfaces
>   ----------
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 2deeeca3e71b..4c6b83bab643 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -532,6 +532,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>    * This function must not be used in interrupt context. Unlocking
>    * of a not locked mutex is not allowed.
>    *
> + * The caller must ensure that the mutex stays alive until this function has
> + * returned - mutex_unlock() can NOT directly be used to release an object such
> + * that another concurrent task can free it.
> + * Mutexes are different from spinlocks in this aspect.
> + *
>    * This function is similar to (but not equivalent to) up().
>    */
>   void __sched mutex_unlock(struct mutex *lock)
>
> base-commit: 3b47bc037bd44f142ac09848e8d3ecccc726be99

