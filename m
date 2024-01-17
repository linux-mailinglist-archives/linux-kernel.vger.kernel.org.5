Return-Path: <linux-kernel+bounces-29433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE379830E29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC361F22D21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A50250F4;
	Wed, 17 Jan 2024 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aseIdN4+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD524B23
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524406; cv=none; b=CwXhhkPX79+bwI0X8i9YcpHZqqR/zYxYarwwAyHGLUyjlIruc3qNnpl5v9g5JhFQroRJ7ANx0HRsUFatFSPmbzPld2/7QTz+6JL7cxt6R2PgazwBDrOtKCvmcLOy4hRAFdSkl6xSVNYB3YGcRe/5rwuOBIa4qlhcbE3xbKyhp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524406; c=relaxed/simple;
	bh=aaHodGRubbOZjIP65GIQv8uQ5qNxm2iUpK+FYvffHPI=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Scanned-By; b=k0zfjVvhsbXjkfsjX4vQXOpJhlGQW6uu9nZmDccHXQ4hNaU7P2jTycoZWdAQighOv5FR8naGQrGIy/1isjaKu+25neJXboG2tzpkzASy1864RueLgwMcpAUr3e+DKXcVNn07A8tnfZo7h+8T3/08LK60caNo+kyy2J3WgBOW0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aseIdN4+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705524403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C70ts/54UEYJcw/lgvKUhzDMrgIQBYpfoUXMj0i2oXk=;
	b=aseIdN4+tFqNsyacYXK97FbX3XM3xsJNYYR6Pafc3PmOYP5BsXhwhLUW3/dy1BZup28H8a
	sYiHdQpnqkMYOvP5CLLpYSf4q/9r+xkwxlepJaPtmoczAddiZn1PZr1qAtxknRwXT5eZXZ
	7/DxxVU1e8O43jd0SboMoNIqd4ZSyPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-PH6-t1Y_NEyaM7Wn0JRY5A-1; Wed, 17 Jan 2024 15:46:35 -0500
X-MC-Unique: PH6-t1Y_NEyaM7Wn0JRY5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AABA106D0F0;
	Wed, 17 Jan 2024 20:45:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.121])
	by smtp.corp.redhat.com (Postfix) with SMTP id CE04940C6EBC;
	Wed, 17 Jan 2024 20:45:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Jan 2024 21:44:23 +0100 (CET)
Date: Wed, 17 Jan 2024 21:44:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Stefan Roesch <shr@devkernel.io>, Joey Gouly <joey.gouly@arm.com>,
	Josh Triplett <josh@joshtriplett.org>, Helge Deller <deller@gmx.de>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Florent Revest <revest@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] getrusage: Use trylock when getting sighand lock.
Message-ID: <20240117204416.GB32526@redhat.com>
References: <20240117192534.1327608-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117192534.1327608-1-dylanbhatch@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Heh ;)

getrusage() should not use ->siglock at all.

On my TODO list. I'll try to make a patch this week.

Oleg.

On 01/17, Dylan Hatch wrote:
>
> Processes with many threads run the risk of causing a hard lockup if
> too many threads are calling getrusage() at once. This is because a
> calling thread with RUSAGE_SELF spins on the sighand lock with irq
> disabled, and the critical section of getrusage scales linearly with the
> size of the process. All cpus may end up spinning on the sighand lock
> for a long time because another thread has the lock and is busy
> iterating over 250k+ threads.
>
> In order to mitigate this, periodically re-enable interrupts while
> waiting for the sighand lock. This approach lacks the FIFO fairness of a
> normal spinlock mechanism, but this effect is somewhat contained to
> different threads within the same process.
>
> -- Alternatives Considered --
>
> In an earlier version of the above approach, we added a cond_resched()
> call when disabling interrupts to prevent soft lockups. This solution
> turned out not to be workable on its own since getrusage() is called
> from a non-preemptible context in kernel/exit.c, but could possibly be
> adapted by having an alternate version of getrusage() that can be called
> from a preemptible context.
>
> Another alternative would be to have getruage() itself release the lock
> and enable interrupts periodically while iterating over large numbers of
> threads. However, this would be difficult to implement correctly, and
> the correctness/consistency of the data reported by getrusage() would be
> questionable.
>
> One final alternative might be to add a per-process mutex for callers of
> getrusage() to acquire before acquiring the sighand lock, or to be used
> as a total replacement of the sigahnd lock. We haven't fully explored
> what the implications of this might be.
>
> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
> ---
>  include/linux/sched/signal.h | 13 +++++++++++
>  kernel/signal.c              | 43 ++++++++++++++++++++++++++++++++++++
>  kernel/sys.c                 |  8 ++++++-
>  3 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3499c1a8b9295..7852f16139965 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -747,6 +747,19 @@ static inline struct sighand_struct *lock_task_sighand(struct task_struct *task,
>  	return ret;
>  }
>
> +extern struct sighand_struct *__lock_task_sighand_safe(struct task_struct *task,
> +							unsigned long *flags);
> +
> +static inline struct sighand_struct *lock_task_sighand_safe(struct task_struct *task,
> +						       unsigned long *flags)
> +{
> +	struct sighand_struct *ret;
> +
> +	ret = __lock_task_sighand_safe(task, flags);
> +	(void)__cond_lock(&task->sighand->siglock, ret);
> +	return ret;
> +}
> +
>  static inline void unlock_task_sighand(struct task_struct *task,
>  						unsigned long *flags)
>  {
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 47a7602dfe8df..6d60c73b7ab91 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1397,6 +1397,49 @@ int zap_other_threads(struct task_struct *p)
>  	return count;
>  }
>
> +struct sighand_struct *__lock_task_sighand_safe(struct task_struct *tsk,
> +						unsigned long *flags)
> +{
> +	struct sighand_struct *sighand;
> +	int n;
> +	bool lock = false;
> +
> +again:
> +	rcu_read_lock();
> +	local_irq_save(*flags);
> +	for (n = 0; n < 500; n++) {
> +		sighand = rcu_dereference(tsk->sighand);
> +		if (unlikely(sighand == NULL))
> +			break;
> +
> +		/*
> +		 * The downside of this approach is we loose the fairness of
> +		 * FIFO waiting because the acqusition order between multiple
> +		 * waiting tasks is effectively random.
> +		 */
> +		lock = spin_trylock(&sighand->siglock);
> +		if (!lock) {
> +			cpu_relax();
> +			continue;
> +		}
> +
> +		/* __lock_task_sighand has context explaining this check. */
> +		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
> +			break;
> +		spin_unlock(&sighand->siglock);
> +		lock = false;
> +	}
> +	rcu_read_unlock();
> +
> +	/* Handle pending IRQ */
> +	if (!lock && sighand) {
> +		local_irq_restore(*flags);
> +		goto again;
> +	}
> +
> +	return sighand;
> +}
> +
>  struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
>  					   unsigned long *flags)
>  {
> diff --git a/kernel/sys.c b/kernel/sys.c
> index e219fcfa112d8..1b1254a3c506b 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1798,7 +1798,13 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
>  		goto out;
>  	}
>
> -	if (!lock_task_sighand(p, &flags))
> +	/*
> +	 * We use lock_task_sighand_safe here instead of lock_task_sighand
> +	 * because one process with many threads all calling getrusage may
> +	 * otherwise cause an NMI watchdog timeout by disabling IRQs for too
> +	 * long.
> +	 */
> +	if (!lock_task_sighand_safe(p, &flags))
>  		return;
>
>  	switch (who) {
> --
> 2.43.0.381.gb435a96ce8-goog
>


