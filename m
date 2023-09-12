Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD079CF05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjILK6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjILK6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:58:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A875010F3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K272GeFOt25I2i7O+fmNqZ4rD0ZkqfHOakI0lXPH8ig=; b=OlWo4EUwykMY4TPWvsghWqmf+S
        cvmIJZxVjbH5JMMRiXtiVMLAZ7DxMspmeB94iCKS4R35YAz7gUfn5bZq2MCcnvPCRZ9HzsrnwMuZ1
        vuwa/66C8bEAPBwb+0UpWzcQRS99gkpUnL/UcYKA+cMUs9cje8BiKqY3JNfGoI+7BHMHSmT+JVCgu
        DrxjzcwQY3w/bHi8G8tFoLtWOloQEyJrjOcDKeQBBlpAf7ubp6avzuGjQ9YFfqZxlv1/0FgJ7HyV/
        M+o1MOgqYGHZG7iiKwdzzxOis+UUCKr9SGWEmLQZRNgO9ods3TzpkJp8tVNYlvK9jb+cEbB0r+aFi
        7vs7Rx1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg15W-007A2V-8N; Tue, 12 Sep 2023 10:57:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDF60300348; Tue, 12 Sep 2023 12:57:45 +0200 (CEST)
Date:   Tue, 12 Sep 2023 12:57:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, jstultz@google.com,
        juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
        mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20230912105745.GB13926@noisy.programming.kicks-ass.net>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911141135.GB9098@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:11:35PM +0200, Peter Zijlstra wrote:

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
> 
> *However* the case at hand is where a waiter is leaving, in this case
> what happens is that we'll fail to observe a waiter that is already
> gone, which is harmless afaict.
> 
> Would not something like the below work instead?

I forgot to say this is complete untested and hasn't evne seen a
compiler up close...

> ---
> diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
> index ce2889f12375..8c76a52da9bd 100644
> --- a/kernel/futex/pi.c
> +++ b/kernel/futex/pi.c
> @@ -610,29 +610,16 @@ int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
>  /*
>   * Caller must hold a reference on @pi_state.
>   */
> -static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
> +static int wake_futex_pi(u32 __user *uaddr, u32 uval,
> +			 struct futex_pi_state *pi_state,
> +			 rt_mutex_waiter *top_waiter)
>  {
> -	struct rt_mutex_waiter *top_waiter;
>  	struct task_struct *new_owner;
>  	bool postunlock = false;
>  	DEFINE_RT_WAKE_Q(wqh);
>  	u32 curval, newval;
>  	int ret = 0;
>  
> -	top_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
> -	if (WARN_ON_ONCE(!top_waiter)) {
> -		/*
> -		 * As per the comment in futex_unlock_pi() this should not happen.
> -		 *
> -		 * When this happens, give up our locks and try again, giving
> -		 * the futex_lock_pi() instance time to complete, either by
> -		 * waiting on the rtmutex or removing itself from the futex
> -		 * queue.
> -		 */
> -		ret = -EAGAIN;
> -		goto out_unlock;
> -	}
> -
>  	new_owner = top_waiter->task;
>  
>  	/*
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
>  	 *
> -	 * In particular; it is important that futex_unlock_pi() can not
> -	 * observe this inconsistency.
> +	 * Cannot hold hb->lock because rt_mutex already has a waiter enqueued
> +	 * and hb->lock can itself try and enqueue an rt_waiter through rtlock.
> +	 *
> +	 * Doing the cleanup without holding hb->lock can cause inconsistent
> +	 * state between hb and pi_state, but only in the direction of seeing a
> +	 * waiter that is leaving.
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
> +		 * waiters even though futex thinkgs there are, then the waiter
> +		 * is leaving and the uncontended path is safe to take.
> +		 */
> +		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
> +		if (!rt_waiter)
> +			goto do_uncontended;

That ^ needs to drop wait_lock before the goto.

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
> 
