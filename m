Return-Path: <linux-kernel+bounces-25932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C518F82D87F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D851C21897
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AFF2C68D;
	Mon, 15 Jan 2024 11:40:15 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FC1E4BF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e69b31365so22139945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 03:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705318811; x=1705923611;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/JE3pgYyoXhsBd768qeS7qfVWuQhtK8AXhWVHxiBZ4=;
        b=V+JShkF2Z5bh4ylQzGe0K9tDK6ReLFkukWABdd0CHpb2WzwFqx1V8cLbBc0oIbBx3d
         7MRflewRBzE0UBPCbA6pLfVv8AsyFvouvBrXMbl26AVK/l5bbLUsSmTyg0ptKvgqcNie
         xHmNxnBK4n+btoJDRUwUWnBldW6nrQdIUXfo1kw8vu+34JpdbSN6rBt/THEujDdmylMS
         j/Dh+YSy5EYEvscp4C7xD0POOoURaHHpY84y9wASVgMoO2a3nUt87UxzkiL2Qqj66nox
         ZyxvSamw2mZVRH0CVzskp1BlUVxCyoUJUxf1YTpF/QjyhnC7YLzQqiBoBwuyJFo9OQ2O
         ij5w==
X-Gm-Message-State: AOJu0Yx7bWTOQxSGniE8YliJ0v3hOLvHzpj/U7Z6gbZgyOgYGSd6EuZp
	IgYuTaXqmpoLyoX5+h9T69c=
X-Google-Smtp-Source: AGHT+IHV17vJ9+n0L0Wv24y9oYVMNcaxzM+lspRSjLwtaDyprIHb1OxQ5jvthaJAqGEDMoTYKL8QDg==
X-Received: by 2002:a05:600c:190f:b0:40e:4551:8c21 with SMTP id j15-20020a05600c190f00b0040e45518c21mr2877409wmq.26.1705318810601;
        Mon, 15 Jan 2024 03:40:10 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0040d5f466deesm15529718wmq.38.2024.01.15.03.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 03:40:10 -0800 (PST)
Message-ID: <4611bcf2-44d0-4c34-9b84-17406f881003@kernel.org>
Date: Mon, 15 Jan 2024 12:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, boqun.feng@gmail.com, bristot@redhat.com,
 bsegall@google.com, dietmar.eggemann@arm.com, jstultz@google.com,
 juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
 mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
 vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net> <87fs3f1tl0.ffs@tglx>
 <20230915151943.GD6743@noisy.programming.kicks-ass.net>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20230915151943.GD6743@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 09. 23, 17:19, Peter Zijlstra wrote:
> On Fri, Sep 15, 2023 at 02:58:35PM +0200, Thomas Gleixner wrote:
> 
>> I spent quite some time to convince myself that this is correct. I was
>> not able to poke a hole into it. So that really should be safe to
>> do. Famous last words ...
> 
> IKR :-/
> 
> Something like so then...
> 
> ---
> Subject: futex/pi: Fix recursive rt_mutex waiter state

So this breaks some random test in APR:

 From 
https://build.opensuse.org/package/live_build_log/openSUSE:Factory:Staging:G/apr/standard/x86_64:
testprocmutex       :  Line 122: child did not terminate with success

The child in fact terminates on 
https://github.com/apache/apr/blob/trunk/test/testprocmutex.c#L93:
                 while ((rv = apr_proc_mutex_timedlock(proc_lock, 1))) {
                     if (!APR_STATUS_IS_TIMEUP(rv))
                         exit(1); <----- here

The test creates 6 children and does some 
pthread_mutex_timedlock/unlock() repeatedly (200 times) in parallel 
while sleeping 1 us inside the lock. The timeout is 1 us above. And the 
test expects all them to fail (to time out). But the time out does not 
always happen in 6.7 (it's racy, so the failure is semi-random: like 1 
of 1000 attempts is bad).

If I revert this patch (commit fbeb558b0dd0d), the test works.

I know, the test could be broken too, but I have no idea, really. The 
testsuite is sort of hairy and I could not come up with a simple repro.

Note APR sets up PTHREAD_PROCESS_SHARED, _ROBUST, and _PRIO_INHERIT 
attrs for the mutex.

Anyway:
downstream report: https://bugzilla.suse.com/show_bug.cgi?id=1218801
APR report: https://bz.apache.org/bugzilla/show_bug.cgi?id=68481

Any idea if this patch should cause the above (or even is a desired 
behavior)?

Thanks.

> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 12 Sep 2023 13:17:11 +0200
> 
> Some new assertions pointed out that the existing code has nested rt_mutex wait
> state in the futex code.
> 
> Specifically, the futex_lock_pi() cancel case uses spin_lock() while there
> still is a rt_waiter enqueued for this task, resulting in a state where there
> are two waiters for the same task (and task_struct::pi_blocked_on gets
> scrambled).
> 
> The reason to take hb->lock at this point is to avoid the wake_futex_pi()
> EAGAIN case.
> 
> This happens when futex_top_waiter() and rt_mutex_top_waiter() state becomes
> inconsistent. The current rules are such that this inconsistency will not be
> observed.
> 
> Notably the case that needs to be avoided is where futex_lock_pi() and
> futex_unlock_pi() interleave such that unlock will fail to observe a new
> waiter.
> 
> *However* the case at hand is where a waiter is leaving, in this case the race
> means a waiter that is going away is not observed -- which is harmless,
> provided this race is explicitly handled.
> 
> This is a somewhat dangerous proposition because the converse race is not
> observing a new waiter, which must absolutely not happen. But since the race is
> valid this cannot be asserted.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   pi.c      |   76 +++++++++++++++++++++++++++++++++++++++-----------------------
>   requeue.c |    6 +++-
>   2 files changed, 52 insertions(+), 30 deletions(-)
> 
> Index: linux-2.6/kernel/futex/pi.c
> ===================================================================
> --- linux-2.6.orig/kernel/futex/pi.c
> +++ linux-2.6/kernel/futex/pi.c
> @@ -610,29 +610,16 @@ int futex_lock_pi_atomic(u32 __user *uad
>   /*
>    * Caller must hold a reference on @pi_state.
>    */
> -static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
> +static int wake_futex_pi(u32 __user *uaddr, u32 uval,
> +			 struct futex_pi_state *pi_state,
> +			 struct rt_mutex_waiter *top_waiter)
>   {
> -	struct rt_mutex_waiter *top_waiter;
>   	struct task_struct *new_owner;
>   	bool postunlock = false;
>   	DEFINE_RT_WAKE_Q(wqh);
>   	u32 curval, newval;
>   	int ret = 0;
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
>   	new_owner = top_waiter->task;
>   
>   	/*
> @@ -1039,19 +1026,33 @@ retry_private:
>   	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
>   
>   cleanup:
> -	spin_lock(q.lock_ptr);
>   	/*
>   	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
> -	 * first acquire the hb->lock before removing the lock from the
> -	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
> -	 * lists consistent.
> +	 * must unwind the above, however we canont lock hb->lock because
> +	 * rt_mutex already has a waiter enqueued and hb->lock can itself try
> +	 * and enqueue an rt_waiter through rtlock.
> +	 *
> +	 * Doing the cleanup without holding hb->lock can cause inconsistent
> +	 * state between hb and pi_state, but only in the direction of not
> +	 * seeing a waiter that is leaving.
> +	 *
> +	 * See futex_unlock_pi(), it deals with this inconsistency.
> +	 *
> +	 * There be dragons here, since we must deal with the inconsistency on
> +	 * the way out (here), it is impossible to detect/warn about the race
> +	 * the other way around (missing an incoming waiter).
>   	 *
> -	 * In particular; it is important that futex_unlock_pi() can not
> -	 * observe this inconsistency.
> +	 * What could possibly go wrong...
>   	 */
>   	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
>   		ret = 0;
>   
> +	/*
> +	 * Now that the rt_waiter has been dequeued, it is safe to use
> +	 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
> +	 * the
> +	 */
> +	spin_lock(q.lock_ptr);
>   no_block:
>   	/*
>   	 * Fixup the pi_state owner and possibly acquire the lock if we
> @@ -1132,6 +1133,7 @@ retry:
>   	top_waiter = futex_top_waiter(hb, &key);
>   	if (top_waiter) {
>   		struct futex_pi_state *pi_state = top_waiter->pi_state;
> +		struct rt_mutex_waiter *rt_waiter;
>   
>   		ret = -EINVAL;
>   		if (!pi_state)
> @@ -1144,22 +1146,39 @@ retry:
>   		if (pi_state->owner != current)
>   			goto out_unlock;
>   
> -		get_pi_state(pi_state);
>   		/*
>   		 * By taking wait_lock while still holding hb->lock, we ensure
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
>   		 *
>   		 * In particular; this forces __rt_mutex_start_proxy() to
>   		 * complete such that we're guaranteed to observe the
> -		 * rt_waiter. Also see the WARN in wake_futex_pi().
> +		 * rt_waiter.
>   		 */
>   		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
> +
> +		/*
> +		 * Futex vs rt_mutex waiter state -- if there are no rt_mutex
> +		 * waiters even though futex thinks there are, then the waiter
> +		 * is leaving and the uncontended path is safe to take.
> +		 */
> +		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
> +		if (!rt_waiter) {
> +			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
> +			goto do_uncontended;
> +		}
> +
> +		get_pi_state(pi_state);
>   		spin_unlock(&hb->lock);
>   
>   		/* drops pi_state->pi_mutex.wait_lock */
> -		ret = wake_futex_pi(uaddr, uval, pi_state);
> +		ret = wake_futex_pi(uaddr, uval, pi_state, rt_waiter);
>   
>   		put_pi_state(pi_state);
>   
> @@ -1187,6 +1206,7 @@ retry:
>   		return ret;
>   	}
>   
> +do_uncontended:
>   	/*
>   	 * We have no kernel internal state, i.e. no waiters in the
>   	 * kernel. Waiters which are about to queue themselves are stuck
> Index: linux-2.6/kernel/futex/requeue.c
> ===================================================================
> --- linux-2.6.orig/kernel/futex/requeue.c
> +++ linux-2.6/kernel/futex/requeue.c
> @@ -850,11 +850,13 @@ int futex_wait_requeue_pi(u32 __user *ua
>   		pi_mutex = &q.pi_state->pi_mutex;
>   		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
>   
> -		/* Current is not longer pi_blocked_on */
> -		spin_lock(q.lock_ptr);
> +		/*
> +		 * See futex_unlock_pi()'s cleanup: comment.
> +		 */
>   		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
>   			ret = 0;
>   
> +		spin_lock(q.lock_ptr);
>   		debug_rt_mutex_free_waiter(&rt_waiter);
>   		/*
>   		 * Fixup the pi_state owner and possibly acquire the lock if we
> 

-- 
js
suse labs


