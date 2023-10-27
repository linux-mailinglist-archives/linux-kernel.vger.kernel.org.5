Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E77DA2AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbjJ0Vw2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Oct 2023 17:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0Vw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AFFE5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87754C433C7;
        Fri, 27 Oct 2023 21:52:18 +0000 (UTC)
Date:   Fri, 27 Oct 2023 17:52:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        PostgreSQL Developers <pgsql-hackers@lists.postgresql.org>,
        Robert Haas <robertmhaas@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Message-ID: <20231027175216.1424cd83@gandalf.local.home>
In-Reply-To: <20231025235413.597287e1@gandalf.local.home>
References: <20231025235413.597287e1@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As this change showed a really good improvement in my micro-benchmark, I
decided to give it a try on something that's a bit more of a real world
benchmark: PostgreSQL.

Hence, I'm also Cc'ing the postgres maintainers in case they are interested.
To bring them up to speed, here's what's been going on:

  A new feature is being discussed to add NEED_RESCHED_LAZY that will allow us
  (the kernel developers) to remove CONFIG_PREEMPT_NONE and
  CONFIG_PREEMPT_VOLUNTARY, and move that to user space runtime switches. The
  idea is that when the scheduler tick goes off and it's time to schedule out a
  SCHED_OTHER task, user space can have the option of not doing that in the
  kernel and wait till it enters back into user space before scheduling
  (simulating PREEMPT_NONE). The scheduler tick will set NEED_RESCHED_LAZY
  (instead of NEED_RESCHED which always schedules when possible), and that bit
  will only be looked at when exiting back into user space, where it will
  perform the schedule if it is set.

  My idea is to extend this into user space as well. Using the restartable
  sequences infrastructure (https://lwn.net/Articles/697979/) that maps memory
  between kernel and user space for threads, I'll use two bits (or one bit and a
  counter, but that's for later, I'll just discuss the current implementation).

   bit 0: is set by user space to tell the kernel that it's in a critical
          section.

   bit 1: is set by the kernel telling user space that it granted it a bit more
          time and that it should call back into the kernel with any system call
          (sched_yield() or gettid()), when it is out of its critical section.

  Bit 1 will never be set if bit 0 is not set (Note, there's talk about making
  bit 0 the one set by the kernel, or use a different word entirely to allow
  the rest of the bits to be used as a counter for nested critical sections).

  Now when returning back to user space, if the critical section bit (or
  counter) is set, then it will not call schedule when NEED_RESCHED_LAZY is set.
  Note that it will still always call schedule on NEED_RESCHED. This gives user
  space one more tick (1 ms with 1000 HZ kernel config, to 4 ms with 250 HZ
  kernel config). When user space is done with its critical section, it should
  check the bit that can be set by the kernel to see if it should then schedule.

  If the user side bit is not cleared after a tick, then the kernel will set
  NEED_RESCHED which will force a schedule no matter where user space happens to
  be. Note, this could also hurt that task in that the scheduler will take away
  the eligibility of that task to balance out the amount of extra time the task
  ran for, not to mention, the force schedule could now land in a critical
  section.

Back in 2014 at the Linux Collaboration Summit in Napa Valley I had a nice
conversation with Robet Haas about user space spin locks. He told me how they
are used in PostgreSQL where futexes did not meet their needs. This
conversation kicked off the idea about implementing user space adaptive spin
locks (which last year in Belgium, I asked André Almeida to implement -
https://lwn.net/Articles/931789/).

Even though user space adaptive spinning would greatly help out the contention
of a lock, there's still the issue of a lock owner being preempted which would
cause all those waiters to also go into the kernel and delay access to the
critical sections. In the real time kernel, this was solved by
NEED_RESCHED_LAZY:

   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/preempt-lazy-support.patch?h=v5.9-rc2-rt1-patches

Now Thomas has proposed using a similar solution to solve the PREEMPT_NONE /
VOLUNTARY issue.

  https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/

Which now has a prototype in the rt-devel tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/PREEMPT_AUTO.patch?h=v6.6-rc6-rt10-patches

For which I applied to v6.6-rc4 (my current working branch), and applied the
solution I explained above (POC with debugging still in it):

  https://lore.kernel.org/all/20231025235413.597287e1@gandalf.local.home/

Now I downloaded the latest postgres from:

  https://github.com/postgres/postgres.git

And built sha: 26f988212eada9c586223cbbf876c7eb455044d9

After installing it, I rebooted the machine with the updated kernel (requires
CONFIG_PREEMPT_AUTO being set), and ran the unmodified version of postgres
pgbench test:

  pgbench -c 100 -T 300 -j 8 -S -n

I ran it 16 times and looked at the transactions per second counter (tps).
Note, I threw out the first run as it had horrible numbers probably due to
everything in cold cache (memory and file system).

Then I applied the below patch, did a make clean, make install, rebooted the
box again and ran the test for another 16 times (again, the first run was
horrible).

Here are the results of the tests: I only used the 15 runs after the first run
for comparisons.

Without the patched postgres executable:

  First run:
    tps = 72573.188203 (without initial connection time)

  15 runs:
    tps = 74315.731978 (without initial connection time)
    tps = 74448.130108 (without initial connection time)
    tps = 74662.246100 (without initial connection time)
    tps = 73124.961311 (without initial connection time)
    tps = 74653.611878 (without initial connection time)
    tps = 74765.296134 (without initial connection time)
    tps = 74497.066104 (without initial connection time)
    tps = 74541.664031 (without initial connection time)
    tps = 74595.032066 (without initial connection time)
    tps = 74545.876793 (without initial connection time)
    tps = 74762.560651 (without initial connection time)
    tps = 74528.657018 (without initial connection time)
    tps = 74814.700753 (without initial connection time)
    tps = 74687.980967 (without initial connection time)
    tps = 74973.185122 (without initial connection time)

With the patched postgres executable:

  First run:
    tps = 73562.005970 (without initial connection time)

  15 runs:
    tps = 74560.101322 (without initial connection time)
    tps = 74711.177071 (without initial connection time)
    tps = 74551.093281 (without initial connection time)
    tps = 74559.452628 (without initial connection time)
    tps = 74737.604361 (without initial connection time)
    tps = 74521.606019 (without initial connection time)
    tps = 74870.859166 (without initial connection time)
    tps = 74545.423471 (without initial connection time)
    tps = 74805.939815 (without initial connection time)
    tps = 74665.240730 (without initial connection time)
    tps = 74701.479550 (without initial connection time)
    tps = 74897.154079 (without initial connection time)
    tps = 74879.687067 (without initial connection time)
    tps = 74792.563116 (without initial connection time)
    tps = 74852.101317 (without initial connection time)

Without the patch:

    Average: 74527.7800
    Std Dev: 420.6304

With the patch:
    Average: 74710.0988
    Std Dev: 136.7250

Notes about my setup. I ran this on one of my older test boxes (pretty much the
last of the bare metal machines I test on, as now I do most on VMs, but did not
want to run these tests on VMs).

It's a 4 core (2 hyper threaded) total of 8 CPUs:

  Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz

 32G of RAM.

Postgres has several types of locks. I first applied the extend()/unextend() to
only the raw spin locks but that didn't make much difference. When I traced
it, I found that the time slice seldom landed when one of these spin locks
were held. 10 or so during a 5 minute run (I added writes to the kernel
tracing buffer via trace_marker to know when the locks were held, and also
recorded sched_switch to see if it was ever preempted). So I expanded the
usage to the "light weight locks" (lwlocks), which are similar to the spin
locks but does some complex backing off. Basically a heuristic spin. Anyway,
after adding the logic to these locks, it definitely made a difference. Not a
huge one, but it was noticeable beyond the noise. I can imagine that if this
was implemented on a machine with many more CPUs than 8, it would make an even
bigger difference.

I also had to rerun my tests because I left some kernel config options enabled
that affected performance. I didn't want that to skew the results. But the
results were similar, except that with the slower kernel, the worse
performance with the patch was better than the best performance without it.
Not by much, but still. After removing the slowdown, that was no longer the
case. But I noticed that with the patch, the standard deviation was much
smaller than without the patch. I'm guessing that without the patch it depends
on how the scheduler interacts with the locking much more and a good run
without the patch was just the test being "lucky" that it didn't get preempted
as much in a critical section.

I personally think the smaller standard deviation is a win as it makes the
database run with a more deterministic behavior.

Anyway, I'd really like to know what others think about this, and perhaps they
can run this on their own testing infrastructure. All the code is available to
reproduce. If you want to reproduce it like I did. Checkout the latest Linus
tree (or do what I have which is v6.6-rc4), apply the above mentioned
PREEMPT_AUTO.patch, then apply my kernel patch. Select CONFIG_PREEMPT_AUTO and
build the kernel. Don't worry about that big banner that is on the kernel
console at boot up telling you that you are running a debug kernel. You are
running one, and it's because I still have a couple of trace_printk()s in it.

Run your postgres tests with and without the patch and let me know if there's a
difference. Only if you think it's worth it. Let me know if you don't ;-)

-- Steve

[ The biggest part of the below change is adding in the standard rseq_abi.h header ]


diff --git a/src/backend/storage/lmgr/lwlock.c b/src/backend/storage/lmgr/lwlock.c
index 315a78cda9..652d3a5560 100644
--- a/src/backend/storage/lmgr/lwlock.c
+++ b/src/backend/storage/lmgr/lwlock.c
@@ -89,11 +89,12 @@
 #include "storage/spin.h"
 #include "utils/memutils.h"
 
+#include "storage/rseq-abi.h"
+
 #ifdef LWLOCK_STATS
 #include "utils/hsearch.h"
 #endif
 
-
 /* We use the ShmemLock spinlock to protect LWLockCounter */
 extern slock_t *ShmemLock;
 
@@ -841,6 +842,8 @@ LWLockAttemptLock(LWLock *lock, LWLockMode mode)
 				desired_state += LW_VAL_SHARED;
 		}
 
+		if (lock_free)
+			extend();
 		/*
 		 * Attempt to swap in the state we are expecting. If we didn't see
 		 * lock to be free, that's just the old value. If we saw it as free,
@@ -863,9 +866,14 @@ LWLockAttemptLock(LWLock *lock, LWLockMode mode)
 #endif
 				return false;
 			}
-			else
+			else {
+				if (lock_free)
+					unextend();
 				return true;	/* somebody else has the lock */
+			}
 		}
+		if (lock_free)
+			unextend();
 	}
 	pg_unreachable();
 }
@@ -1868,6 +1876,7 @@ LWLockRelease(LWLock *lock)
 		LWLockWakeup(lock);
 	}
 
+	unextend();
 	/*
 	 * Now okay to allow cancel/die interrupts.
 	 */
diff --git a/src/backend/storage/lmgr/s_lock.c b/src/backend/storage/lmgr/s_lock.c
index 327ac64f7c..c22310cfe3 100644
--- a/src/backend/storage/lmgr/s_lock.c
+++ b/src/backend/storage/lmgr/s_lock.c
@@ -55,6 +55,8 @@
 #include "storage/s_lock.h"
 #include "utils/wait_event.h"
 
+#include "storage/rseq-abi.h"
+
 #define MIN_SPINS_PER_DELAY 10
 #define MAX_SPINS_PER_DELAY 1000
 #define NUM_DELAYS			1000
@@ -66,7 +68,6 @@ slock_t		dummy_spinlock;
 
 static int	spins_per_delay = DEFAULT_SPINS_PER_DELAY;
 
-
 /*
  * s_lock_stuck() - complain about a stuck spinlock
  */
@@ -94,6 +95,8 @@ s_lock(volatile slock_t *lock, const char *file, int line, const char *func)
 {
 	SpinDelayStatus delayStatus;
 
+	unextend();
+
 	init_spin_delay(&delayStatus, file, line, func);
 
 	while (TAS_SPIN(lock))
@@ -102,6 +105,7 @@ s_lock(volatile slock_t *lock, const char *file, int line, const char *func)
 	}
 
 	finish_spin_delay(&delayStatus);
+	extend();
 
 	return delayStatus.delays;
 }
diff --git a/src/include/storage/rseq-abi.h b/src/include/storage/rseq-abi.h
new file mode 100644
index 0000000000..b858cf1d6f
--- /dev/null
+++ b/src/include/storage/rseq-abi.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _RSEQ_ABI_H
+#define _RSEQ_ABI_H
+
+/*
+ * rseq-abi.h
+ *
+ * Restartable sequences system call API
+ *
+ * Copyright (c) 2015-2022 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include <ctype.h>
+#include <asm/types.h>
+
+enum rseq_abi_cpu_id_state {
+	RSEQ_ABI_CPU_ID_UNINITIALIZED			= -1,
+	RSEQ_ABI_CPU_ID_REGISTRATION_FAILED		= -2,
+};
+
+enum rseq_abi_flags {
+	RSEQ_ABI_FLAG_UNREGISTER = (1 << 0),
+};
+
+enum rseq_abi_cs_flags_bit {
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+};
+
+enum rseq_abi_cs_flags {
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT),
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+};
+
+/*
+ * struct rseq_abi_cs is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line. It is usually declared as
+ * link-time constant data.
+ */
+struct rseq_abi_cs {
+	/* Version of this structure. */
+	__u32 version;
+	/* enum rseq_abi_cs_flags */
+	__u32 flags;
+	__u64 start_ip;
+	/* Offset from start_ip. */
+	__u64 post_commit_offset;
+	__u64 abort_ip;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+/*
+ * struct rseq_abi is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line.
+ *
+ * A single struct rseq_abi per thread is allowed.
+ */
+struct rseq_abi {
+	/*
+	 * Restartable sequences cpu_id_start field. Updated by the
+	 * kernel. Read by user-space with single-copy atomicity
+	 * semantics. This field should only be read by the thread which
+	 * registered this data structure. Aligned on 32-bit. Always
+	 * contains a value in the range of possible CPUs, although the
+	 * value may not be the actual current CPU (e.g. if rseq is not
+	 * initialized). This CPU number value should always be compared
+	 * against the value of the cpu_id field before performing a rseq
+	 * commit or returning a value read from a data structure indexed
+	 * using the cpu_id_start value.
+	 */
+	__u32 cpu_id_start;
+	/*
+	 * Restartable sequences cpu_id field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This
+	 * field should only be read by the thread which registered this
+	 * data structure. Aligned on 32-bit. Values
+	 * RSEQ_CPU_ID_UNINITIALIZED and RSEQ_CPU_ID_REGISTRATION_FAILED
+	 * have a special semantic: the former means "rseq uninitialized",
+	 * and latter means "rseq initialization failed". This value is
+	 * meant to be read within rseq critical sections and compared
+	 * with the cpu_id_start value previously read, before performing
+	 * the commit instruction, or read and compared with the
+	 * cpu_id_start value before returning a value loaded from a data
+	 * structure indexed using the cpu_id_start value.
+	 */
+	__u32 cpu_id;
+	/*
+	 * Restartable sequences rseq_cs field.
+	 *
+	 * Contains NULL when no critical section is active for the current
+	 * thread, or holds a pointer to the currently active struct rseq_cs.
+	 *
+	 * Updated by user-space, which sets the address of the currently
+	 * active rseq_cs at the beginning of assembly instruction sequence
+	 * block, and set to NULL by the kernel when it restarts an assembly
+	 * instruction sequence block, as well as when the kernel detects that
+	 * it is preempting or delivering a signal outside of the range
+	 * targeted by the rseq_cs. Also needs to be set to NULL by user-space
+	 * before reclaiming memory that contains the targeted struct rseq_cs.
+	 *
+	 * Read and set by the kernel. Set by user-space with single-copy
+	 * atomicity semantics. This field should only be updated by the
+	 * thread which registered this data structure. Aligned on 64-bit.
+	 */
+	union {
+		__u64 ptr64;
+
+		/*
+		 * The "arch" field provides architecture accessor for
+		 * the ptr field based on architecture pointer size and
+		 * endianness.
+		 */
+		struct {
+#ifdef __LP64__
+			__u64 ptr;
+#elif defined(__BYTE_ORDER) ? (__BYTE_ORDER == __BIG_ENDIAN) : defined(__BIG_ENDIAN)
+			__u32 padding;		/* Initialized to zero. */
+			__u32 ptr;
+#else
+			__u32 ptr;
+			__u32 padding;		/* Initialized to zero. */
+#endif
+		} arch;
+	} rseq_cs;
+
+	/*
+	 * Restartable sequences flags field.
+	 *
+	 * This field should only be updated by the thread which
+	 * registered this data structure. Read by the kernel.
+	 * Mainly used for single-stepping through rseq critical sections
+	 * with debuggers.
+	 *
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT
+	 *     Inhibit instruction sequence block restart on preemption
+	 *     for this thread.
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL
+	 *     Inhibit instruction sequence block restart on signal
+	 *     delivery for this thread.
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE
+	 *     Inhibit instruction sequence block restart on migration for
+	 *     this thread.
+	 */
+	__u32 flags;
+
+	/*
+	 * Restartable sequences node_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current NUMA node ID.
+	 */
+	__u32 node_id;
+
+	/*
+	 * Restartable sequences mm_cid field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's concurrency ID
+	 * (allocated uniquely within a memory map).
+	 */
+	__u32 mm_cid;
+
+	__u32 cr_flags;
+	/*
+	 * Flexible array member at end of structure, after last feature field.
+	 */
+	char end[];
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+#endif /* _RSEQ_ABI_H */
diff --git a/src/include/storage/s_lock.h b/src/include/storage/s_lock.h
index c9fa84cc43..999a056c6f 100644
--- a/src/include/storage/s_lock.h
+++ b/src/include/storage/s_lock.h
@@ -96,6 +96,10 @@
 #ifndef S_LOCK_H
 #define S_LOCK_H
 
+#define __GNU_SOURCE
+#include <unistd.h>
+#include "storage/rseq-abi.h"
+
 #ifdef FRONTEND
 #error "s_lock.h may not be included from frontend code"
 #endif
@@ -131,6 +135,53 @@
  *----------
  */
 
+extern ptrdiff_t __rseq_offset;
+extern unsigned int __rseq_size;
+
+static inline unsigned clear_extend(volatile unsigned *ptr)
+{
+	unsigned ret;
+
+	asm volatile("andb %b1,%0"
+		     : "+m" (*(volatile char *)ptr)
+		     : "iq" (~0x1)
+		     : "memory");
+
+	ret = *ptr;
+	*ptr = 0;
+
+	return ret;
+}
+
+static inline void extend(void)
+{
+	struct rseq_abi *rseq_ptr;
+
+	if (!__rseq_size)
+		return;
+
+	rseq_ptr = (void *)((unsigned long)__builtin_thread_pointer() + __rseq_offset);
+	rseq_ptr->cr_flags = 1;
+}
+
+static inline void unextend(void)
+{
+	struct rseq_abi *rseq_ptr;
+	unsigned prev;
+
+	if (!__rseq_size)
+		return;
+
+	rseq_ptr = (void *)((unsigned long)__builtin_thread_pointer() + __rseq_offset);
+
+	prev = clear_extend(&rseq_ptr->cr_flags);
+	if (prev & 2) {
+		gettid();
+	}
+}
+
+#define __S_UNLOCK(lock) do { S_UNLOCK(lock); unextend(); } while (0)
+#define __S_LOCK(lock) do { extend(); S_LOCK(lock); } while (0)
 
 #ifdef __i386__		/* 32-bit i386 */
 #define HAS_TEST_AND_SET
diff --git a/src/include/storage/spin.h b/src/include/storage/spin.h
index 5d809cc980..4230025748 100644
--- a/src/include/storage/spin.h
+++ b/src/include/storage/spin.h
@@ -59,9 +59,9 @@
 
 #define SpinLockInit(lock)	S_INIT_LOCK(lock)
 
-#define SpinLockAcquire(lock) S_LOCK(lock)
+#define SpinLockAcquire(lock) __S_LOCK(lock)
 
-#define SpinLockRelease(lock) S_UNLOCK(lock)
+#define SpinLockRelease(lock) __S_UNLOCK(lock)
 
 #define SpinLockFree(lock)	S_LOCK_FREE(lock)
 
