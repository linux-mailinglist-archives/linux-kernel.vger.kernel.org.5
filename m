Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99179CFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjILL0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjILL0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:26:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAC3BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=W4Ml6P5OQLBVBA+tbKfHSvEtgZpFP7HBzWOlnvG5ufs=; b=AGhrasSsyESAxOLntyRvhPyG92
        ZrCZn9Q0Qt9pvHYKhxxdjgiZCGK570KCCgh/JwpybkXaacll52CSSrgsVrfsSYdgmtX+lKdrwMjwu
        ZwYGmrInf28/ugEOxPGIod+HECJ4hL1rrWy+EfgitHv5Snvb5x4fzXVD077hrnY2dG0sU648JTliM
        PrMqGpxaTQ8mnuRpdpCXMsFwsAqo/RUILxvRc4IgrZG/ZjnXZ9fXhpfN4H65VEPb0Y1GkrzU07eHn
        Sy91gwqz2bQBwxHwesVBFoSOckL3PhQXBLGddbnjxq/+T2NM/Trk4iX77xfGb0j2Oxgv8MLB0ktvt
        IgxlMSJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg1Wi-007Hyq-6r; Tue, 12 Sep 2023 11:25:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D140B300348; Tue, 12 Sep 2023 13:25:51 +0200 (CEST)
Date:   Tue, 12 Sep 2023 13:25:51 +0200
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
Message-ID: <20230912112551.GH35261@noisy.programming.kicks-ass.net>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <20230912111711.DHVKG-B4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912111711.DHVKG-B4@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:17:11PM +0200, Sebastian Andrzej Siewior wrote:

> Comments follow…
> 
> diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
> index f8e65b27d9d6b..d8866278e92ff 100644
> --- a/kernel/futex/pi.c
> +++ b/kernel/futex/pi.c
> @@ -611,29 +611,16 @@ int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
>  /*
>   * Caller must hold a reference on @pi_state.
>   */
> -static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
> +static int wake_futex_pi(u32 __user *uaddr, u32 uval,
> +			 struct futex_pi_state *pi_state,
> +			 struct rt_mutex_waiter *top_waiter)
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
> @@ -1046,15 +1033,18 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
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
> @@ -1063,6 +1053,12 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
>  	 * Waiter is unqueued.
>  	 */
>  	rt_mutex_post_schedule();
> +
> +	/*
> +	 * Now that the rt_waiter has been dequeued, it is safe to use
> +	 * spinlock/rtlock, which will enqueue a new rt_waiter.
> +	 */
> +	spin_lock(q.lock_ptr);
>  no_block:
>  	/*
>  	 * Fixup the pi_state owner and possibly acquire the lock if we
> @@ -1143,6 +1139,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
>  	top_waiter = futex_top_waiter(hb, &key);
>  	if (top_waiter) {
>  		struct futex_pi_state *pi_state = top_waiter->pi_state;
> +		struct rt_mutex_waiter *rt_waiter;
>  
>  		ret = -EINVAL;
>  		if (!pi_state)
> @@ -1158,19 +1155,34 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
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

That wants to be:

		if (!rt_waiter) {
			raw_spin_unlock_irQ(&pi_state->pi_mutex.wait_lock);
			goto do_uncontended;
		}

> +
>  		spin_unlock(&hb->lock);
>  
>  		/* drops pi_state->pi_mutex.wait_lock */
> -		ret = wake_futex_pi(uaddr, uval, pi_state);
> +		ret = wake_futex_pi(uaddr, uval, pi_state, rt_waiter);
>  
>  		put_pi_state(pi_state);
>  
> @@ -1198,6 +1210,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
>  		return ret;
>  	}
>  
> +do_uncontended:
>  	/*
>  	 * We have no kernel internal state, i.e. no waiters in the
>  	 * kernel. Waiters which are about to queue themselves are stuck
> 

And I think there was a requeue site that wants updating too.. the above
was more or less a starting point for discussion :-)
