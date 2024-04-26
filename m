Return-Path: <linux-kernel+bounces-159867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1D18B3545
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AE32818A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9281442FD;
	Fri, 26 Apr 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQgJv2Be"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B4143889;
	Fri, 26 Apr 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127227; cv=none; b=LzULGTOIKA5u4L40yfCzF00K9ON+64W+YCIQr6RcqoKENdBukR4hgZsxUcdThB+2SHqnX5mWTEIW36L8an2n/gEwpXfEf4wHNlVnAZ9xqHyJlC+moumyYJTvB+lhlJtLbHeb48rqCw0IFkqyN669lWLVQbZiwh9R174zoc6vxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127227; c=relaxed/simple;
	bh=ogdfpTSv7psc3Klm1D9XfroiXN2VW40F38W066AD6Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyxNEOtzY3v4M09axyky/QDxx47DEBG92YfEkFjR7Hj1LJRkSmtCN1yAIwiLbc7ZsDp7zNzTO0ZLxYu84grl/YltEPe2pSIlODVS+pKRv/7QSccAqiCKEUTm1q9TjOf1haHDHAfPlLyMoJApy5JRC+bRHeyMS7T4b69WL3q74gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQgJv2Be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27913C113CD;
	Fri, 26 Apr 2024 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714127227;
	bh=ogdfpTSv7psc3Klm1D9XfroiXN2VW40F38W066AD6Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQgJv2Be/d3f7gY4YhCGiZ0nGCXTvXtF2lPoaOp8IvkvodT5XjgiaHz5C4NLUeZez
	 /jZxQw52aEsmg5BRaBxrOZVL2xZGpI/5NDrT2ndx/IkxWkM/1f2pUeB3SZyzl6FGE5
	 onzdvpPGAiCnB6b6d7OFml9shofr4lNXi4DdQtAeg8Qz2kZ5ayaapf27d0fHhjuN/9
	 9vk/bZulZVRR+mLNev30oQKEjxw7vcowhW2/lMJupR3Ia3nZHvZ00hD7z33c4iNkSZ
	 +et4evTt8wY83wZd/mwDkmnWoYuB2TwKRbuSNMdHvR32j2Vrg7Mgu64ubgBE5dIuvs
	 a2vPuR57n6gaA==
Date: Fri, 26 Apr 2024 12:26:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>, 
	linux-api@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com, 
	carlos@redhat.com, Peter Oskolkov <posk@posk.io>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Chris Kennelly <ckennelly@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>, 
	Jonathan Corbet <corbet@lwn.net>, Noah Goldstein <goldstein.w.n@gmail.com>, 
	Daniel Colascione <dancol@google.com>, longman@redhat.com, kernel-dev@igalia.com
Subject: Re: [RFC PATCH 0/1] Add FUTEX_SPIN operation
Message-ID: <20240426-gaumen-zweibeinig-3490b06e86c2@brauner>
References: <20240425204332.221162-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425204332.221162-1-andrealmeid@igalia.com>

On Thu, Apr 25, 2024 at 05:43:31PM -0300, André Almeida wrote:
> Hi,
> 
> In the last LPC, Mathieu Desnoyers and I presented[0] a proposal to extend the
> rseq interface to be able to implement spin locks in userspace correctly. Thomas
> Gleixner agreed that this is something that Linux could improve, but asked for
> an alternative proposal first: a futex operation that allows to spin a user
> lock inside the kernel. This patchset implements a prototype of this idea for
> further discussion.
> 
> With FUTEX2_SPIN flag set during a futex_wait(), the futex value is expected to
> be the PID of the lock owner. Then, the kernel gets the task_struct of the
> corresponding PID, and checks if it's running. It spins until the futex
> is awaken, the task is scheduled out or if a timeout happens.  If the lock owner
> is scheduled out at any time, then the syscall follows the normal path of
> sleeping as usual.
> 
> If the futex is awaken and we are spinning, we can return to userspace quickly,
> avoid the scheduling out and in again to wake from a futex_wait(), thus
> speeding up the wait operation.
> 
> I didn't manage to find a good mechanism to prevent race conditions between
> setting *futex = PID in userspace and doing find_get_task_by_vpid(PID) in kernel
> space, giving that there's enough room for the original PID owner exit and such
> PID to be relocated to another unrelated task in the system. I didn't performed

One option would be to also allow pidfds. Starting with v6.9 they can be
used to reference individual threads.

So for the really fast case where you have multiple threads and you
somehow may really do care about the impact of the atomic_long_inc() on
pidfd_file->f_count during fdget() (for the single-threaded case the
increment is elided), callers can pass the TID. But in cases where the
inc and put aren't a performance sensitive, you can use pidfds.

So something like the _completely untested_ below:

diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 94feac92cf4f..b842680aa7e0 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -4,6 +4,9 @@
 #include <linux/sched/task.h>
 #include <linux/sched/signal.h>
 #include <linux/freezer.h>
+#include <linux/cleanup.h>
+#include <linux/file.h>
+#include <uapi/linux/pidfd.h>
 
 #include "futex.h"
 
@@ -385,19 +388,29 @@ static int futex_spin(struct futex_hash_bucket *hb, struct futex_q *q,
 		       struct hrtimer_sleeper *timeout, void __user *uaddr, u32 val)
 {
 	struct task_struct *p;
-	u32 pid, uval;
+	struct pid *pid;
+	u32 pidfd, uval;
 	unsigned int i = 0;
 
 	if (futex_get_value_locked(&uval, uaddr))
 		return -EFAULT;
 
-	pid = uval;
+	pidfd = uval;
+	CLASS(fd, f)(pidfd);
 
-	p = find_get_task_by_vpid(pid);
-	if (!p) {
-		printk("%s: no task found with PID %d\n", __func__, pid);
-		return -EAGAIN;
-	}
+	if (!f.file)
+		return -EBADF;
+
+	pid = pidfd_pid(f.file);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
+
+	if (f.file->f_flags & PIDFD_THREAD)
+		p = get_pid_task(pid, PIDTYPE_PID); /* individual thread */
+	else
+		p = get_pid_task(pid, PIDTYPE_TGID); /* thread-group leader */
+	if (!p)
+		return -ESRCH;
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		put_task_struct(p);


> benchmarks so far, as I hope to clarify if this interface makes sense prior to
> doing measurements on it.
> 
> This implementation has some debug prints to make it easy to inspect what the
> kernel is doing, so you can check if the futex woke during spinning or if
> just slept as the normal path:
> 
> [ 6331] futex_spin: spinned 64738 times, sleeping
> [ 6331] futex_spin: woke after 1864606 spins
> [ 6332] futex_spin: woke after 1820906 spins
> [ 6351] futex_spin: spinned 1603293 times, sleeping
> [ 6352] futex_spin: woke after 1848199 spins
> 
> [0] https://lpc.events/event/17/contributions/1481/
> 
> You can find a small snippet to play with this interface here:
> 
> ---
> 
> /*
>  * futex2_spin example, by André Almeida <andrealmeid@igalia.com>
>  *
>  * gcc spin.c -o spin
>  */
> 
> #define _GNU_SOURCE
> #include <err.h>
> #include <errno.h>
> #include <linux/futex.h>
> #include <linux/sched.h>
> #include <pthread.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <unistd.h>
> 
> #define __NR_futex_wake 454
> #define __NR_futex_wait 455
> 
> #define WAKE_WAIT_US	10000
> #define FUTEX2_SPIN	0x08
> #define STACK_SIZE	(1024 * 1024)
> 
> #define FUTEX2_SIZE_U32	0x02
> #define FUTEX2_PRIVATE	FUTEX_PRIVATE_FLAG
> 
> #define timeout_ns  30000000
> 
> void *futex;
> 
> static inline int futex2_wake(volatile void *uaddr, unsigned long mask, int nr, unsigned int flags)
> {
> 	return syscall(__NR_futex_wake, uaddr, mask, nr, flags);
> }
> 
> static inline int futex2_wait(volatile void *uaddr, unsigned long val, unsigned long mask,
> 			      unsigned int flags, struct timespec *timo, clockid_t clockid)
> {
> 	return syscall(__NR_futex_wait, uaddr, val, mask, flags, timo, clockid);
> }
> 
> void waiter_fn()
> {
> 	struct timespec to;
> 	unsigned int flags = FUTEX2_PRIVATE | FUTEX2_SIZE_U32 | FUTEX2_SPIN;
> 
> 	uint32_t child_pid = *(uint32_t *) futex;
> 
> 	clock_gettime(CLOCK_MONOTONIC, &to);
> 	to.tv_nsec += timeout_ns;
> 	if (to.tv_nsec >= 1000000000) {
> 		to.tv_sec++;
> 		to.tv_nsec -= 1000000000;
> 	}
> 
> 	printf("waiting on PID %d...\n", child_pid);
> 	if (futex2_wait(futex, child_pid, ~0U, flags, &to, CLOCK_MONOTONIC))
> 		printf("waiter failed errno %d\n", errno);
> 
> 	puts("waiting done");
> }
> 
> int function(int n)
> {
> 	return n + n;
> }
> 
> #define CHILD_LOOPS 500000
> 
> static int child_fn(void *arg)
> {
> 	int i, n = 2;
> 
> 	for (i = 0; i < CHILD_LOOPS; i++)
> 		n = function(n);
> 
> 	futex2_wake(futex, ~0U, 1, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG);
> 
> 	puts("child thread is done");
> 
> 	return 0;
> }
> 
> int main() {
> 	uint32_t child_pid = 0;
> 	char *stack;
> 
> 	futex = &child_pid;
> 
> 	stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
> 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
> 
> 	if (stack == MAP_FAILED)
> 		err(EXIT_FAILURE, "mmap");
> 
> 	child_pid = clone(child_fn, stack + STACK_SIZE, CLONE_VM, NULL);
> 
> 	waiter_fn();
> 
> 	usleep(WAKE_WAIT_US * 10);
> 
> 	return 0;
> }
> 
> ---
> 
> André Almeida (1):
>   futex: Add FUTEX_SPIN operation
> 
>  include/uapi/linux/futex.h |  2 +-
>  kernel/futex/futex.h       |  6 ++-
>  kernel/futex/waitwake.c    | 79 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 83 insertions(+), 4 deletions(-)
> 
> -- 
> 2.44.0
> 

