Return-Path: <linux-kernel+bounces-29323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50674830CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B466F1F267BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6155223748;
	Wed, 17 Jan 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Us1t548C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fiu9cZJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49322EE3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516625; cv=none; b=b+qaum5vZTtP1UZysmO2q83YGhEBypkQBGu3bZ9IASlMISpcv27wC3QLK2Zjzp+RCebPxxYi40VMLIcD6TZX5SVmzJwimqlOG9vcf6HPmC9rJXB/Wl/dvgXevUAc4+Zd5CD5FhL4lySFdtO93lTIfRLydCB7D5S/O34sLQw3OIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516625; c=relaxed/simple;
	bh=M3l5RgHD/1od8oUBFbbVk+/yrSOKVdEfp8uFd/iHBNk=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=VcmXVCEFF2fB0PLS7gjemgqD+6nDPuqJqDPu1iu7nWqZSbzsrP6fx53y2N2Ds+miUyaC3AlHy66KacejWHy5IiSTGuYsEwL59j1ovmdzn+snJpBdUuyYHvmCVQmm8VlPkaSMmAmEkKrDPvN1FdqI6omMWde/WZSSRCpq4SL5cfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Us1t548C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fiu9cZJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705516621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TInfxfPQEeri/W24YA0NOZ5UGgw0IlviSgqagYig9g0=;
	b=Us1t548CfcLMVvk1nGnos3AyugjPKcLo6H6PgP3kETIEoTUzstXdAtZ5Y9p0yvLXGctlaZ
	7+gywGyxroo4ruCw+O8GKRYrSK3zWX05SEvBVK9OTqoU41PsQYi6ZF6u8HqO0uXopO6Juh
	5DiYYUUG7CmAuucdjjR4uL6ZQDPG6Z1KOiaq6CiQSt88gTULHpoQdbt1ixBHhBhnvhCZQS
	K0fd2RIAXA2xGiognJLgOERqhwbXUOpU0qmeQ334EgY4KUyi0k2IgJjDAQAz1NanKe6wjL
	UU7uAB2MnR6+sCO9qPCO2oKj8BOJgbHC8acfJZ8zSSwe6g9+hoAWjLAOgz/qYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705516621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TInfxfPQEeri/W24YA0NOZ5UGgw0IlviSgqagYig9g0=;
	b=1fiu9cZJaesRbpdNrzOYWuNgPdeQbfScYq6QxpSGWyqYpLvKFJ+qXrCXL37qN/VVT1GRFV
	+f12xE+XPOgfteCQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby
 <jirislaby@kernel.org>, Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, bristot@redhat.com,
 bsegall@google.com, dietmar.eggemann@arm.com, jstultz@google.com,
 juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
 mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
 vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH] futex: Avoid reusing outdated pi_state.
In-Reply-To: <20240116130810.ji1YCxpg@linutronix.de>
References: <20240116130810.ji1YCxpg@linutronix.de>
Date: Wed, 17 Jan 2024 19:37:00 +0100
Message-ID: <87wms7g62b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 16 2024 at 14:08, Sebastian Andrzej Siewior wrote:
> @@ -628,10 +628,15 @@ int futex_unqueue(struct futex_q *q)
>  /*
>   * PI futexes can not be requeued and must remove themselves from the
>   * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
> + * If the PI futex was not acquired (due to timeout or signal) then it removes
> + * its rt_waiter before it removes itself from the futex queue. The unlocker
> + * will remove the futex_q from the queue if it observes an empty waitqueue.
> + * Therefore the unqueue is optional in this case.

This explanation is as confusing as the changelog.

>   */
> -void futex_unqueue_pi(struct futex_q *q)
> +void futex_unqueue_pi(struct futex_q *q, bool have_lock)
>  {
> -	__futex_unqueue(q);
> +	if (have_lock || !plist_node_empty(&q->list))
> +		__futex_unqueue(q);

If 'have_lock == true' then 'plist_node_empty()' must be 'false' with
you moving the callsite up, no?

So that 'have_lock' arguments is clearly pointless.

>  	BUG_ON(!q->pi_state);
>  	put_pi_state(q->pi_state);
> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
> index 8b195d06f4e8e..c7133ffb381fd 100644
> --- a/kernel/futex/futex.h
> +++ b/kernel/futex/futex.h
> @@ -252,7 +252,7 @@ static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
>  	spin_unlock(&hb->lock);
>  }
>  
> -extern void futex_unqueue_pi(struct futex_q *q);
> +extern void futex_unqueue_pi(struct futex_q *q, bool have_lock);
>  
>  extern void wait_for_owner_exiting(int ret, struct task_struct *exiting);
>  
> diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
> index 90e5197f4e569..4023841358eea 100644
> --- a/kernel/futex/pi.c
> +++ b/kernel/futex/pi.c
> @@ -1070,6 +1070,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
>  	 * haven't already.
>  	 */
>  	res = fixup_pi_owner(uaddr, &q, !ret);
> +	futex_unqueue_pi(&q, !ret);
>  	/*
>  	 * If fixup_pi_owner() returned an error, propagate that.  If it acquired
>  	 * the lock, clear our -ETIMEDOUT or -EINTR.
> @@ -1077,7 +1078,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
>  	if (res)
>  		ret = (res < 0) ? res : 0;
>  
> -	futex_unqueue_pi(&q);

Without the have_lock argument these two hunks are not required.

>  	spin_unlock(q.lock_ptr);
>  	goto out;
>  
> @@ -1135,6 +1135,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
>  
>  	hb = futex_hash(&key);
>  	spin_lock(&hb->lock);
> +retry_hb:
>  
>  	/*
>  	 * Check waiters first. We do not trust user space values at
> @@ -1177,12 +1178,15 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
>  		/*
>  		 * Futex vs rt_mutex waiter state -- if there are no rt_mutex
>  		 * waiters even though futex thinks there are, then the waiter
> -		 * is leaving and the uncontended path is safe to take.
> +		 * is leaving. We need to remove it from the list so that the
> +		 * current PI-state is not observed by future pi_futex_lock()
> +		 * caller before the leaving waiter had a chance to clean up.
>  		 */
>  		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
>  		if (!rt_waiter) {
> +			__futex_unqueue(top_waiter);
>  			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
> -			goto do_uncontended;
> +			goto retry_hb;

This clearly lacks a comment that there might be more than one waiter in
the hash-bucket which removed itself from the rtmutex and is now blocked
on the hash bucket lock.

Thanks,

        tglx

