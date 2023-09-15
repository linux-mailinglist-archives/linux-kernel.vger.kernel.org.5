Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24247A1F59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjIOM6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjIOM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:58:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522E51713
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:58:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694782715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4TvGsRhJhKZwa4dopAjZ8jTK3b1p1lTf3hhGgnSRyQU=;
        b=lapWieaccc+ASnzHuiMGqmORojKOdhKNXa56TJz1K4mxhGKYmTcCaPp7G9AVq6ATh/4y0T
        KuJYh2B89KV3+HQhH3uaSFW6D1a9tXdjmaFbp2XDU5AJmB8jTYKqYki4VvnFhZ3WC9O055
        xxRL4nIdhQsKtDX0XL9Zi4dG6E/jcrUtft156LeYNKP/P2WjZF74Gk6f1RheCM1r9XymUM
        egVKHfwuR9BPz5OnENkLQzZiYGN600a/uVcDoHoKEBIaCBIWmQddaad1QgILk0dtYEV2ho
        XkxZmi/lwE7AIlAH92Qv0Y3H8J5G8xzMSukncA9XTeNQWflqQTLtMHP6kOyULA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694782715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4TvGsRhJhKZwa4dopAjZ8jTK3b1p1lTf3hhGgnSRyQU=;
        b=pXUzoa7/x/NljXHh9i/R/BR6VXMdoODScG0Uuj3DsqutZnZwlb3H64cXFmszDwsCehNS7p
        nV3g9TpZ9QnHJDCw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
In-Reply-To: <20230911141135.GB9098@noisy.programming.kicks-ass.net>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
Date:   Fri, 15 Sep 2023 14:58:35 +0200
Message-ID: <87fs3f1tl0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11 2023 at 16:11, Peter Zijlstra wrote:
> On Fri, Sep 08, 2023 at 06:22:54PM +0200, Sebastian Andrzej Siewior wrote:
> Aside from this being just plain gross, this also destroys determinism
> of futex_pi, which completely defeats the purpose of the whole thing.

It served the purpose to force the two dudes who wrote most of this
horrorshow to actually look at it. It worked :)

> Now.. the reason we need hb->lock at this point is to avoid the
> wake_futex_pi() -EAGAIN case.
>
> This happens when futex_top_waiter() and rt_mutex_top_waiter() state
> becomes inconsistent. The current rules are such that this inconsistency
> will not be observed.
>
> Notably the case that needs to be avoided is where futex_lock_pi() and
> futex_unlock_pi() interleave such that unlock will fail to observe a new
> waiter.

That's correct.

> *However* the case at hand is where a waiter is leaving, in this case
> what happens is that we'll fail to observe a waiter that is already
> gone, which is harmless afaict.

It is harmless, when the wakee handles the inconsistency between the
futex waiter list and the rtmutex waiter list correctly.

> @@ -1039,19 +1026,27 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
>  	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
>  
>  cleanup:
> -	spin_lock(q.lock_ptr);
>  	/*
>  	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
>  	 * first acquire the hb->lock before removing the lock from the
>  	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
>  	 * lists consistent.

This comment does not make sense anymore.

> -	 * In particular; it is important that futex_unlock_pi() can not
> -	 * observe this inconsistency.
> +	 * Cannot hold hb->lock because rt_mutex already has a waiter enqueued
> +	 * and hb->lock can itself try and enqueue an rt_waiter through rtlock.
> +	 *
> +	 * Doing the cleanup without holding hb->lock can cause inconsistent
> +	 * state between hb and pi_state, but only in the direction of seeing a
> +	 * waiter that is leaving.

+	* See futex_unlock_pi()

>  	 */
>  	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
>  		ret = 0;
>  
> +	/*
> +	 * Now that the rt_waiter has been dequeued, it is safe to use
> +	 * spinlock/rtlock, which will enqueue a new rt_waiter.
> +	 */
> +	spin_lock(q.lock_ptr);
>  no_block:
>  	/*
>  	 * Fixup the pi_state owner and possibly acquire the lock if we
> @@ -1132,6 +1127,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
>  	top_waiter = futex_top_waiter(hb, &key);
>  	if (top_waiter) {
>  		struct futex_pi_state *pi_state = top_waiter->pi_state;
> +		struct rt_mutex_waiter *rt_waiter;
>  
>  		ret = -EINVAL;
>  		if (!pi_state)
> @@ -1147,19 +1143,34 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
>  		get_pi_state(pi_state);
>  		/*
>  		 * By taking wait_lock while still holding hb->lock, we ensure
> -		 * there is no point where we hold neither; and therefore
> -		 * wake_futex_p() must observe a state consistent with what we
> -		 * observed.
> +		 * there is no point where we hold neither; and thereby
> +		 * wake_futex_pi() must observe any new waiters.
> +		 *
> +		 * Since the cleanup: case in futex_lock_pi() removes the
> +		 * rt_waiter without holding hb->lock, it is possible for
> +		 * wake_futex_pi() to not find a waiter while the above does,
> +		 * in this case the waiter is on the way out and it can be
> +		 * ignored.
>  		 *
>  		 * In particular; this forces __rt_mutex_start_proxy() to
>  		 * complete such that we're guaranteed to observe the
> -		 * rt_waiter. Also see the WARN in wake_futex_pi().
> +		 * rt_waiter.
>  		 */
>  		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
> +
> +		/*
> +		 * Futex vs rt_mutex waiter state -- if there are on rt_mutex

s/on/no/

> +		 * waiters even though futex thinkgs there are, then the waiter

thinkgs :)

> +		 * is leaving and the uncontended path is safe to take.
> +		 */
> +		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
> +		if (!rt_waiter)
> +			goto do_uncontended;

Leaks pi_mutex.wait_lock

> +
>  		spin_unlock(&hb->lock);
>  
>  		/* drops pi_state->pi_mutex.wait_lock */
> -		ret = wake_futex_pi(uaddr, uval, pi_state);
> +		ret = wake_futex_pi(uaddr, uval, pi_state, rt_waiter);
>  
>  		put_pi_state(pi_state);
>  
> @@ -1187,6 +1198,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
>  		return ret;
>  	}
>  
> +do_uncontended:
>  	/*
>  	 * We have no kernel internal state, i.e. no waiters in the
>  	 * kernel. Waiters which are about to queue themselves are stuck

Plus you need:

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index cba8b1a6a4cc..af1427689414 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -850,11 +850,11 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		/* Current is not longer pi_blocked_on */
-		spin_lock(q.lock_ptr);
+		/* Add a proper comment */
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
+		spin_lock(q.lock_ptr);
 		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we


I spent quite some time to convince myself that this is correct. I was
not able to poke a hole into it. So that really should be safe to
do. Famous last words ...

Thanks,

        tglx
