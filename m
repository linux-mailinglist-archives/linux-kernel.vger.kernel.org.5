Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558E77D7B59
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJZDyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZDyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:54:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59DB9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 20:54:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FABC433C7;
        Thu, 26 Oct 2023 03:54:14 +0000 (UTC)
Date:   Wed, 25 Oct 2023 23:54:13 -0400
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Message-ID: <20231025235413.597287e1@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/ZDyvUi=w9Td/hqvN2ahFssO"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/ZDyvUi=w9Td/hqvN2ahFssO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

This has very good performance improvements on user space implemented spin
locks, and I'm sure this can be used for spin locks in VMs too. That will
come shortly.

I started with Thomas's PREEMPT_AUTO.patch from the rt-devel tree:

 https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/PREEMPT_AUTO.patch?h=v6.6-rc6-rt10-patches

So you need to select:

  CONFIG_PREEMPT_AUTO

The below is my proof of concept patch. It still has debugging in it, and
although I now use rseq, I likely used it incorrectly, and it needs to be
changed. It's missing necessary comments too. But this is still just POC.

I added a "cr_flags" to the end of the struct rseq. OK, the name sucks, I
just thought of "critical" and had to pick something. Let's bikeshed
that later. Now, that the bits live in the rseq structure, there's no need
to open up any files. Although, you need to run the test with:

 GLIBC_TUNABLES=glibc.pthread.rseq=0 ./extend-sched

It will prevent glibc from adding its own rseq, and you can use the new
extensions.

Now my extend() and unextend() look like this:


 static void extend(void)
 {
	rseq_map.cr_flags = 1;
 }

 static void unextend(void)
 {
	unsigned long prev;

	prev = xchg(&rseq_map.cr_flags, 0);
	if (prev & 2) {
		tracefs_printf(NULL, "Yield!\n");
		sched_yield();
	}
 }

Note that any system call will do. sched_yield() is just something that
"makes sense", but it could also be gettid(), which is probably even more
efficient as the schedule will happen on the way back to user space,
because the bit is now cleared but NEED_RESCHED_LAZY is still set.

The magic will be how we get the rseq_map to play with. There's various
ways to do that, but that's an exercise for later.

So, bit 1 is for user space to tell the kernel "please extend me", and bit
two is for the kernel to tell user space "OK, I extended you, but call
sched_yield() (or any system call) when done".

The attached test program creates 1 + number of CPUs threads, that run in a
loop for 5 seconds. Each thread will grab a user space spin lock (not a
futex, but just shared memory). Before grabbing the lock it will call
"extend()", if it fails to grab the lock, it calls "unextend()" and spins
on the lock until its free, where it will try again. Then after it gets the
lock, it will update a counter, and release the lock, calling "unextend()"
as well. Then it will spin on the counter until it increments again to
allow another task to get into the critical section.

With the init of the extend_map disabled and it doesn't use the extend
code, it ends with:

 Ran for 3908165 times
 Total wait time: 33.965654

I can give you stdev and all that too, but the above is pretty much the
same after several runs.

After enabling the extend code, it has:

 Ran for 4829340 times
 Total wait time: 32.635407

It was able to get into the critical section almost 1 million times more in
those 5 seconds! That's a 23% improvement!

The wait time for getting into the critical section also dropped by the
total of over a second (4% improvement).

I ran a traceeval tool on it (still work in progress, but I can post when
it's done), and with the following trace, and the writes to trace-marker
(tracefs_printf)

 trace-cmd record -e sched_switch ./extend-sched

It showed that without the extend, each task was preempted while holding
the lock around 200 times. With the extend, only one task was ever
preempted while holding the lock, and it only happened once!

Note, I tried replacing the user space spin lock with a futex, and it
dropped performance down so much with and without the update, that the
benefit is in the noise.

Below is my patch (with debugging and on top of Thomas's PREEMPT_AUTO.patch):

Attached is the program I tested it with. It uses libtracefs to write to
the trace_marker file, but if you don't want to build it with libtracefs:

  gcc -o extend-sched extend-sched.c `pkg-config --libs --cflags libtracefs` -lpthread

You can just do:

 grep -v tracefs extend-sched.c > extend-sched-notracefs.c

And build that.

But either way, to run it you need to export

  GLIBC_TUNABLES=glibc.pthread.rseq=0

Otherwise it will fail to register the rseq structure because glibc has
already done that, but the glibc version doesn't include the extended size.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20231025054219.1acaa3dd@gandalf.local.home/

 - Use rseq as the interface (Peter Zijlsta)

 (This patch is getting smaller and smaller!)

 include/uapi/linux/rseq.h | 14 ++++++++++++++
 kernel/entry/common.c     | 17 ++++++++++++++++-
 kernel/rseq.c             | 27 +++++++++++++++++++++++++++
 kernel/sched/fair.c       |  5 +++--
 4 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae5eac9..bd3aa4085e7b 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -37,6 +37,18 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
 };
 
+enum rseq_cr_flags_bit {
+	RSEQ_CR_FLAG_IN_CRITICAL_SECTION_BIT	= 0,
+	RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED_BIT	= 1,
+};
+
+enum rseq_cr_flags {
+	RSEQ_CR_FLAG_IN_CRITICAL_SECTION	=
+		(1U << RSEQ_CR_FLAG_IN_CRITICAL_SECTION_BIT),
+	RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED	=
+	(1U << RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED_BIT),
+};
+
 /*
  * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line. It is usually declared as
@@ -148,6 +160,8 @@ struct rseq {
 	 */
 	__u32 mm_cid;
 
+	__u32 cr_flags;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index c1f706038637..d8b46b9e5fd7 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -143,21 +143,35 @@ void noinstr exit_to_user_mode(void)
 
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
+bool rseq_ignore_lazy_resched(void);
 
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
 {
+	unsigned long ignore_mask;
+
 	/*
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
 	 */
 	while (ti_work & EXIT_TO_USER_MODE_WORK) {
+		ignore_mask = 0;
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
+		if (ti_work & _TIF_NEED_RESCHED) {
 			schedule();
 
+		} else if (ti_work & _TIF_NEED_RESCHED_LAZY) {
+			if (rseq_ignore_lazy_resched()) {
+				trace_printk("Extend!\n");
+				/* Allow to leave with NEED_RESCHED_LAZY still set */
+				ignore_mask |= _TIF_NEED_RESCHED_LAZY;
+			} else {
+				schedule();
+			}
+		}
+
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
@@ -184,6 +198,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		tick_nohz_user_enter_prepare();
 
 		ti_work = read_thread_flags();
+		ti_work &= ~ignore_mask;
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe679..fd9d18f60c04 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -339,6 +339,33 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	force_sigsegv(sig);
 }
 
+bool rseq_ignore_lazy_resched(void)
+{
+	struct task_struct *t = current;
+	u32 flags;
+
+	if (!t->rseq)
+		return false;
+
+	/* Make sure the cr_flags exist */
+	if (t->rseq_len <= offsetof(struct rseq, cr_flags))
+		return false;
+
+	if (copy_from_user(&flags, &t->rseq->cr_flags, sizeof(flags)))
+		return false;
+
+	if (!(flags & RSEQ_CR_FLAG_IN_CRITICAL_SECTION))
+		return false;
+
+	flags |= RSEQ_CR_FLAG_KERNEL_REQUEST_SCHED;
+
+	/* If we fault writing, then do not give it an extended slice */
+	if (copy_to_user(&t->rseq->cr_flags, &flags, sizeof(flags)))
+		return false;
+
+	return true;
+}
+
 #ifdef CONFIG_DEBUG_RSEQ
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 700b140ac1bb..17ca22e80384 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -993,9 +993,10 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se, bool
 		resched_curr(rq);
 	} else {
 		/* Did the task ignore the lazy reschedule request? */
-		if (tick && test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
+		if (tick && test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY)) {
+			trace_printk("Force resched?\n");
 			resched_curr(rq);
-		else
+		} else
 			resched_curr_lazy(rq);
 	}
 	clear_buddies(cfs_rq, se);
-- 
2.42.0


--MP_/ZDyvUi=w9Td/hqvN2ahFssO
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=extend-sched.c


// Run with: GLIBC_TUNABLES=glibc.pthread.rseq=0 

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <errno.h>
#include <pthread.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <tracefs.h>
#include <sys/syscall.h>
#include "rseq-abi.h"
#include <linux/tls.h>

#define rseq(rseq, len, flags, sig) syscall(SYS_rseq, rseq, len, \
					    flags, sig);

#define __weak __attribute__((weak))

//#define barrier() asm volatile ("" ::: "memory")
#define rmb() asm volatile ("lfence" ::: "memory")
#define wmb() asm volatile ("sfence" ::: "memory")


static pthread_barrier_t pbarrier;

static __thread struct rseq_abi __attribute__((aligned(sizeof(struct rseq_abi)))) rseq_map;

static void init_extend_map(void)
{
	int ret;

	ret = rseq(&rseq_map, sizeof(rseq_map), 0, 0);
	perror("rseq");
	printf("ret = %d (%zd) %p\n", ret, sizeof(rseq_map), &rseq_map);
}

struct data;

struct thread_data {
	unsigned long long			start_wait;
	unsigned long long			x_count;
	unsigned long long			total;
	unsigned long long			max;
	unsigned long long			min;
	unsigned long long			total_wait;
	unsigned long long			max_wait;
	unsigned long long			min_wait;
	struct data				*data;
};

struct data {
	unsigned long long		x;
	unsigned long			lock;
	struct thread_data		*tdata;
	bool				done;
};

static inline unsigned long
cmpxchg(volatile unsigned long *ptr, unsigned long old, unsigned long new)
{
        unsigned long prev;

	asm volatile("lock; cmpxchg %b1,%2"
		     : "=a"(prev)
		     : "q"(new), "m"(*(ptr)), "0"(old)
		     : "memory");
        return prev;
}

static inline unsigned long
xchg(volatile unsigned *ptr, unsigned new)
{
        unsigned ret = new;

	asm volatile("xchg %b0,%1"
		     : "+r"(ret), "+m"(*(ptr))
		     : : "memory");
        return ret;
}

static void extend(void)
{
	rseq_map.cr_flags = 1;
}

static void unextend(void)
{
	unsigned long prev;

	prev = xchg(&rseq_map.cr_flags, 0);
	if (prev & 2) {
		tracefs_printf(NULL, "Yield!\n");
		sched_yield();
	}
}

#define sec2usec(sec) (sec * 1000000ULL)
#define usec2sec(usec) (usec / 1000000ULL)

static unsigned long long get_time(void)
{
	struct timeval tv;
	unsigned long long time;

	gettimeofday(&tv, NULL);

	time = sec2usec(tv.tv_sec);
	time += tv.tv_usec;

	return time;
}

static void grab_lock(struct thread_data *tdata, struct data *data)
{
	unsigned long long start, end, delta;
	unsigned long long end_wait;
	unsigned long long last;
	unsigned long prev;

	if (!tdata->start_wait)
		tdata->start_wait = get_time();

	while (data->lock && !data->done)
		rmb();

	extend();
	start = get_time();
	prev = cmpxchg(&data->lock, 0, 1);
	if (prev) {
		unextend();
		return;
	}
	end_wait = get_time();
	tracefs_printf(NULL, "Have lock!\n");

	delta = end_wait - tdata->start_wait;
	tdata->start_wait = 0;
	if (!tdata->total_wait || tdata->max_wait < delta)
		tdata->max_wait = delta;
	if (!tdata->total_wait || tdata->min_wait > delta)
		tdata->min_wait = delta;
	tdata->total_wait += delta;

	data->x++;
	last = data->x;

	if (data->lock != 1) {
		printf("Failed locking\n");
		exit(-1);
	}
	prev = cmpxchg(&data->lock, 1, 0);
	end = get_time();
	if (prev != 1) {
		printf("Failed unlocking\n");
		exit(-1);
	}
	tracefs_printf(NULL, "released lock!\n");
	unextend();

	delta = end - start;
	if (!tdata->total || tdata->max < delta)
		tdata->max = delta;

	if (!tdata->total || tdata->min > delta)
		tdata->min = delta;

	tdata->total += delta;
	tdata->x_count++;

	/* Let someone else have a turn */
	while (data->x == last && !data->done)
		rmb();
}

	
	
static void *run_thread(void *d)
{
	struct thread_data *tdata = d;
	struct data *data = tdata->data;

	init_extend_map();

	pthread_barrier_wait(&pbarrier);

	while (!data->done) {
		grab_lock(tdata, data);
	}
	return NULL;
}

int main (int argc, char **argv)
{
	unsigned long long total_wait = 0;
	unsigned long long secs;
	pthread_t *threads;
	struct data data;
	int cpus;

	memset(&data, 0, sizeof(data));

	cpus = sysconf(_SC_NPROCESSORS_CONF);

	threads = calloc(cpus + 1, sizeof(*threads));
	if (!threads) {
		perror("threads");
		exit(-1);
	}

	data.tdata = calloc(cpus + 1, sizeof(*data.tdata));
	if (!data.tdata) {
		perror("Allocating tdata");
		exit(-1);
	}

	tracefs_print_init(NULL);
	pthread_barrier_init(&pbarrier, NULL, cpus + 2);

	for (int i = 0; i <= cpus; i++) {
		int ret;

		data.tdata[i].data = &data;
		ret = pthread_create(&threads[i], NULL, run_thread, &data.tdata[i]);
		if (ret < 0) {
			perror("creating threads");
			exit(-1);
		}
	}

	pthread_barrier_wait(&pbarrier);
	sleep(5);

	printf("Finish up\n");
	data.done = true;
	wmb();

	for (int i = 0; i <= cpus; i++) {
		pthread_join(threads[i], NULL);
		printf("thread %i:\n", i);
		printf("   count:\t%lld\n", data.tdata[i].x_count);
		printf("   total:\t%lld\n", data.tdata[i].total);
		printf("     max:\t%lld\n", data.tdata[i].max);
		printf("     min:\t%lld\n", data.tdata[i].min);
		printf("   total wait:\t%lld\n", data.tdata[i].total_wait);
		printf("     max wait:\t%lld\n", data.tdata[i].max_wait);
		printf("     min wait:\t%lld\n", data.tdata[i].min_wait);
		total_wait += data.tdata[i].total_wait;
	}

	secs = usec2sec(total_wait);

	printf("Ran for %lld times\n", data.x);
	printf("Total wait time: %lld.%06lld\n", secs, total_wait - sec2usec(secs));
	return 0;
}

--MP_/ZDyvUi=w9Td/hqvN2ahFssO--
