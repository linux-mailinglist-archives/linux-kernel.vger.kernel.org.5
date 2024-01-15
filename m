Return-Path: <linux-kernel+bounces-26392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5A082DFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD2F28310F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB518644;
	Mon, 15 Jan 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x5qe/2my";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XOZ3xoW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B55134A2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jan 2024 19:33:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705343620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afQqCEnlGzWVpTgc36uxJWvLgG0N7VejWUgUSPxIKZQ=;
	b=x5qe/2myKKVBvba2tYrSJ7Ca4yU7IwUXSRYpjXD9AM7BBKzDB2OsqmXAcvFwjLArdi31dL
	wEOWk+1Mghjh+IVE8mDlHwGEpxOKQHG8KgrZqrXA30qfS6rXxCbZ4LgRK+5ZmiHVyime1q
	zGW4nPziazsSA4ERApaX5qwE25p8FaRGqdX5qWIWwQWxd9AKO2cUGkHtslwTzk244jNk+W
	cBT5GS0TChGW6HEUlzriVNeXYxiz5XqWi6pA0IbAUyorKW0hgpeLRhIfsHmgeUwz1RdsUr
	XHf+cJG3gaHp8Vq4QmRy0dPHFbaY8iRTlcF+gSHkwg6ZiN+PUug200TuA9/WpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705343620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afQqCEnlGzWVpTgc36uxJWvLgG0N7VejWUgUSPxIKZQ=;
	b=3XOZ3xoW7ohtt4gyGihogiGhT8UKV66w8dGW5XLPHK7M1tmgYT8EuCaWCPMWgXJOcGTYFQ
	wwXiuVUELjETbEAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
	dietmar.eggemann@arm.com, jstultz@google.com, juri.lelli@redhat.com,
	longman@redhat.com, mgorman@suse.de, mingo@redhat.com,
	rostedt@goodmis.org, swood@redhat.com, vincent.guittot@linaro.org,
	vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20240115183338.xW3GS3Ex@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <87fs3f1tl0.ffs@tglx>
 <20230915151943.GD6743@noisy.programming.kicks-ass.net>
 <4611bcf2-44d0-4c34-9b84-17406f881003@kernel.org>
 <9f75eb59-9b7a-4b49-9081-e6a3cbb00187@kernel.org>
 <c737a604-d441-49c6-a5cd-ef01e9f2a454@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c737a604-d441-49c6-a5cd-ef01e9f2a454@kernel.org>

On 2024-01-15 13:54:32 [+0100], Jiri Slaby wrote:
> A simplified reproducer attached (in particular, no APR anymore). Build with
> -pthread, obviously. If you see
> BADx rv=22
> 
> that's bad.

So task1 owns the futex, task2 does lock_pi_futex(). task2 setups the pi
state and everything for task1. Then task1 times out on the lock and
does not want the lock no more. And we break user state vs kernel via:


task1			task2

futex_unlock_pi();	futex_lock_pi();
			rt_mutex_wait_proxy_lock() // ETIMEDOUT
spin_lock(&hb->lock);
			rt_mutex_cleanup_proxy_lock()
			/* now the lock is still owned by task1, and the
			 * task2 removed itself as the waiter but its
			 * futex_q is still queued
			 */
			spin_lock(&hb->lock); /* block */

top_waiter = futex_top_waiter(hb, &key);
/* top_wait is task2's */
rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
/* rt_waiter is NULL and the 
   futex is unlocked in userland via uaddr 
*/

and now

task 3			task4
locks in userland
			futex_lock_pi();
			futex_lock_pi_atomic();
			   -EINVAL = attach_to_pi_state()
			   /*
			    * becauase pi_state says owner
			    * is task1 but uaddr says task3.
			    */

\*/

This is due to the new lock ordering and the guarantees we no longer
have since the commit cited. The pi-state is cleaned/ removed by the last
one that wants the lock so in the unlock path there is either pi-state
with a waiter or nothing.

This duct tape at the end waits until the pi-state leaves or we get a
waiter. So this works but is not a fix.

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 90e5197f4e56..f504ae864cc9 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1182,6 +1182,9 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
 		if (!rt_waiter) {
 			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+			spin_unlock(&hb->lock);
+			cpu_relax();
+			goto retry;
 			goto do_uncontended;
 		}
 
-- 
2.43.0

> regards,

Sebastian

