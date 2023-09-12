Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E7579CFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjILL0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjILLZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:25:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56FC10DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:25:17 -0700 (PDT)
Date:   Tue, 12 Sep 2023 13:25:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694517916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Giexub31eoT2M3pJL4RJcgEhkLH4GSIc1g8csDINTA=;
        b=MZ4y28LVY1Qb7gl1TA7tFK66dzARosg8FE1yaq6CA5NylwEs/jPueQrnuqoaMJGaMwDrMi
        BRBNi4z0hcHFIzcVl45wJQf00fusTUauS2JL2F+FYAu6TJs/hYokSYsuA3BVhbbuZi/b2t
        KQY4N/vjdi2c5MtJjqLcQKJnHxrkzXQyFZoRlTtN+bhDNDVJz5Am9qBfi/P7X9Jfe/qkxT
        uONUA09GRmhBJzvP7SJCYChSBBlVLx/iDXLvO8RYCM7eqSMszZ2HmM1DQA4CaAzFs6gu+/
        j3ChBmG3R+yaq2HNYla1BGgqpwrG93cs1/XOvPFhvZpFZjMtPBK6q/cjWD3ecg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694517916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Giexub31eoT2M3pJL4RJcgEhkLH4GSIc1g8csDINTA=;
        b=WIfwihenYDLF1loYnPxNSjGSm/Hb/pp45r2I5D2gC0pp4s9hW8g1JEGBHxls6detJTWVKG
        WU+gjUBTRNgdvQBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, jstultz@google.com,
        juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
        mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20230912112514.1MUllckW@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <20230912111711.DHVKG-B4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230912111711.DHVKG-B4@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 13:17:16 [+0200], To Peter Zijlstra wrote:
> Comments follow=E2=80=A6
>=20
> diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
> index f8e65b27d9d6b..d8866278e92ff 100644
> --- a/kernel/futex/pi.c
> +++ b/kernel/futex/pi.c
> @@ -611,29 +611,16 @@ int futex_lock_pi_atomic(u32 __user *uaddr, struct =
futex_hash_bucket *hb,
>  /*
>   * Caller must hold a reference on @pi_state.
>   */
> -static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_st=
ate *pi_state)
> +static int wake_futex_pi(u32 __user *uaddr, u32 uval,
> +			 struct futex_pi_state *pi_state,
> +			 struct rt_mutex_waiter *top_waiter)
>  {
> -	struct rt_mutex_waiter *top_waiter;
>  	struct task_struct *new_owner;
>  	bool postunlock =3D false;
>  	DEFINE_RT_WAKE_Q(wqh);
>  	u32 curval, newval;
>  	int ret =3D 0;
> =20
> -	top_waiter =3D rt_mutex_top_waiter(&pi_state->pi_mutex);
> -	if (WARN_ON_ONCE(!top_waiter)) {
> -		/*
> -		 * As per the comment in futex_unlock_pi() this should not happen.
> -		 *
> -		 * When this happens, give up our locks and try again, giving
> -		 * the futex_lock_pi() instance time to complete, either by
> -		 * waiting on the rtmutex or removing itself from the futex
> -		 * queue.
> -		 */
> -		ret =3D -EAGAIN;
> -		goto out_unlock;
> -	}
> -
>  	new_owner =3D top_waiter->task;
> =20
>  	/*
> @@ -1046,15 +1033,18 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int=
 flags, ktime_t *time, int tryl
>  	ret =3D rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
> =20
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
>  	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_wait=
er))
>  		ret =3D 0;
> @@ -1063,6 +1053,12 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int =
flags, ktime_t *time, int tryl
>  	 * Waiter is unqueued.
>  	 */
>  	rt_mutex_post_schedule();

So no new lock-task can enter but one can give up and vanish.

> +
> +	/*
> +	 * Now that the rt_waiter has been dequeued, it is safe to use
> +	 * spinlock/rtlock, which will enqueue a new rt_waiter.
> +	 */
> +	spin_lock(q.lock_ptr);
>  no_block:
>  	/*
>  	 * Fixup the pi_state owner and possibly acquire the lock if we
> @@ -1143,6 +1139,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int=
 flags)
>  	top_waiter =3D futex_top_waiter(hb, &key);
>  	if (top_waiter) {
>  		struct futex_pi_state *pi_state =3D top_waiter->pi_state;
> +		struct rt_mutex_waiter *rt_waiter;
> =20
>  		ret =3D -EINVAL;
>  		if (!pi_state)
> @@ -1158,19 +1155,34 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned i=
nt flags)
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
> +		rt_waiter =3D rt_mutex_top_waiter(&pi_state->pi_mutex);
> +		if (!rt_waiter)
> +			goto do_uncontended;

So I spent some time to come up with a test case for this and then
hacked the kernel to get into exact this situation. The wait_lock from
above needs to be released since it is done by wake_futex_pi()
otherwise.

Then we do earlier get_pi_state(pi_state) and I think a put here is in
order right?=20

We own the hb lock here but it is released later in the do_uncontended
label so that looks okay.

The userland state is modified under the hb-lock so that should work.=20

> +
>  		spin_unlock(&hb->lock);
> =20
>  		/* drops pi_state->pi_mutex.wait_lock */
> -		ret =3D wake_futex_pi(uaddr, uval, pi_state);
> +		ret =3D wake_futex_pi(uaddr, uval, pi_state, rt_waiter);
> =20
>  		put_pi_state(pi_state);
> =20
> @@ -1198,6 +1210,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int=
 flags)
>  		return ret;
>  	}
> =20
> +do_uncontended:
>  	/*
>  	 * We have no kernel internal state, i.e. no waiters in the
>  	 * kernel. Waiters which are about to queue themselves are stuck

So I *think* this could work. Then we need something similar for
requeue-pi.
=20
Sebastian
