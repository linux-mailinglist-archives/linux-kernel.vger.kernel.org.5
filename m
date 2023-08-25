Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDF0788E40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjHYSKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjHYSKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:10:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6327E1BF1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:10:37 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692987035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2bSgLo38NbvECGjj3AIyJluHgcrNvk9AGOxqfrGjIZU=;
        b=2/WsH4iUaA3x8ED3au7ggnx5AeCVCUA616z01+kvzi/qyVT1DgEPdl9LUQ5XAJOIouEwiY
        0eryvrEr4mubDSMawFy7aIEkuEeoXT2Ds7gyTpQEdrDaTXT89K7E9UqrTHdySVTeYqKHBy
        IIpTYEEbYYUzZysI3ZNUdHO9PmlzWafUFPZMW9/wgEZeT3hOQFCIKmAxN6CiiHMHRuGLgR
        YlsSCckXctbOG+yIX+rJgaRtFzm1AzE8yDDzQQvTfOHlxvIo0RMp2jxyyxBnLv+5ZYaCef
        bsyjHLEk3456fUZ55skdYEpDhlf/jWV97bjpKclxplbT2AUiOBGmfRh+HkwXLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692987035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2bSgLo38NbvECGjj3AIyJluHgcrNvk9AGOxqfrGjIZU=;
        b=6fT0yPmHPFGnTWA6KPb1NtUsGzWyv3My7NtNPouyyVibxhbdjexCdPf+rnZxT41VQURx08
        P70y4bOXMiseZZBA==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v2 0/6] locking/rtmutex: Avoid PI state recursion through sched_submit_work()
Date:   Fri, 25 Aug 2023 20:10:27 +0200
Message-Id: <20230825181033.504534-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is basically the 'same' patches as send earlier by PeterZ here:
	https://lore.kernel.org/all/20230815110121.117752409@infradead.org/

Here is a diff vs the original submission, which includes what has been
discussed on the list, only patch 5 has been changed:

|5:  2b0bb1b525cf1 ! 5:  91f7c083c398d locking/rtmutex: Use rt_mutex specif=
ic scheduler helpers
|    @@ Commit message
|         Link: https://lore.kernel.org/r/20230815111430.421408298@infradea=
d.org
|         Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
|=20=20=20=20=20
|    + ## kernel/futex/pi.c ##
|    +@@
|    + // SPDX-License-Identifier: GPL-2.0-or-later
|    +=20
|    + #include <linux/slab.h>
|    ++#include <linux/sched/rt.h>
|    + #include <linux/sched/task.h>
|    +=20
|    + #include "futex.h"
|    +@@ kernel/futex/pi.c: int futex_lock_pi(u32 __user *uaddr, unsigned i=
nt flags, ktime_t *time, int tryl
|    + 		goto no_block;
|    + 	}
|    +=20
|    ++	/*
|    ++	 * Must be done before we enqueue the waiter, here is unfortunately
|    ++	 * under the hb lock, but that *should* work because it does nothin=
g.
|    ++	 */
|    ++	rt_mutex_pre_schedule();
|    ++
|    + 	rt_mutex_init_waiter(&rt_waiter);
|    +=20
|    + 	/*
|    +@@ kernel/futex/pi.c: int futex_lock_pi(u32 __user *uaddr, unsigned i=
nt flags, ktime_t *time, int tryl
|    + 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_=
waiter))
|    + 		ret =3D 0;
|    +=20
|    ++	/*
|    ++	 * Waiter is unqueued.
|    ++	 */
|    ++	rt_mutex_post_schedule();
|    + no_block:
|    + 	/*
|    + 	 * Fixup the pi_state owner and possibly acquire the lock if we
|    +
|      ## kernel/locking/rtmutex.c ##
|     @@ kernel/locking/rtmutex.c: static int __sched rt_mutex_slowlock_blo=
ck(struct rt_mutex_base *lock,
|      		raw_spin_unlock_irq(&lock->wait_lock);
|    @@ kernel/locking/rwbase_rt.c: static int __sched __rwbase_read_lock(s=
truct rwbase_
|      	return ret;
|      }
|=20=20=20=20=20=20
|    +@@ kernel/locking/rwbase_rt.c: static int __sched rwbase_write_lock(s=
truct rwbase_rt *rwb,
|    + 	/* Force readers into slow path */
|    + 	atomic_sub(READER_BIAS, &rwb->readers);
|    +=20
|    ++	rt_mutex_pre_schedule();
|    ++
|    + 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
|    + 	if (__rwbase_write_trylock(rwb))
|    + 		goto out_unlock;
|    +@@ kernel/locking/rwbase_rt.c: static int __sched rwbase_write_lock(s=
truct rwbase_rt *rwb,
|    + 		if (rwbase_signal_pending_state(state, current)) {
|    + 			rwbase_restore_current_state();
|    + 			__rwbase_write_unlock(rwb, 0, flags);
|    ++			rt_mutex_post_schedule();
|    + 			trace_contention_end(rwb, -EINTR);
|    + 			return -EINTR;
|    + 		}
|    +@@ kernel/locking/rwbase_rt.c: static int __sched rwbase_write_lock(s=
truct rwbase_rt *rwb,
|    +=20
|    + out_unlock:
|    + 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
|    ++	rt_mutex_post_schedule();
|    + 	return 0;
|    + }
|    +=20
|=20=20=20=20=20
|      ## kernel/locking/rwsem.c ##
|     @@ kernel/locking/rwsem.c: static inline void __downgrade_write(struc=
t rw_semaphore *sem)

I just stuffed this into latest -RT. As for the futex_lock_pi() change,
I wouldn't do the "whole" rt_mutex_pre_schedule() thingy since for futex
as it has to be a nop because no I/O is done. So something like
|  rt_mutex_pre_schedule_futex()
|  {
|    lockdep_assert(!fetch_and_set(current->sched_rt_mutex, 1));
|    WARN_ON_ONCE(tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER));
|    SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
|    WARN_ON_ONCE(tsk->plug);
|  }

but then why over complicate things. Speaking of over complicating, this
triggered:
| ------------[ cut here ]------------
| WARNING: CPU: 6 PID: 2155 at kernel/locking/spinlock_rt.c:40 rt_spin_lock=
+0x5a/0xf0
| Modules linked in:
| CPU: 6 PID: 2155 Comm: futex_requeue_p Not tainted 6.5.0-rc7-rt3+ #272
| Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
| RIP: 0010:rt_spin_lock+0x5a/0xf0
| Call Trace:
|  <TASK>
|  ? rt_spin_lock+0x5a/0xf0
|  futex_wait_requeue_pi+0x3a4/0x5c0
|  do_futex+0x152/0x190
|  __x64_sys_futex+0x110/0x1b0
|  do_syscall_64+0x44/0x90
|  entry_SYSCALL_64_after_hwframe+0x6f/0xd9
| RIP: 0033:0x7f8a79ed34f9
| ---[ end trace 0000000000000000 ]---

and is
| static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
| {
|         lockdep_assert(!current->pi_blocked_on);

Here, rt_mutex_wait_proxy_lock() returned with -EINTR, didn't acquire
the lock. Later rt_mutex_cleanup_proxy_lock() would clean
->pi_blocked_on but that happens after=20
|                 /* Current is not longer pi_blocked_on */
|                 spin_lock(q.lock_ptr);

and that comment is accurate for r !=3D 0. This isn't a regression from
before, I just didn't spot it earlier.

Sebastian


