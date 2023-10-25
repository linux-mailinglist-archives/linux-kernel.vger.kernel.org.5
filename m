Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A726F7D5F92
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJYBuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYBuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:50:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7286B10CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:50:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28B4C433C7;
        Wed, 25 Oct 2023 01:50:00 +0000 (UTC)
Date:   Tue, 24 Oct 2023 21:49:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20231024214958.22fff0bc@gandalf.local.home>
In-Reply-To: <20231024103426.4074d319@gandalf.local.home>
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
        <20230908070258.GA19320@noisy.programming.kicks-ass.net>
        <87zg1v3xxh.fsf@oracle.com>
        <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
        <87edj64rj1.fsf@oracle.com>
        <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
        <87zg1u1h5t.fsf@oracle.com>
        <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
        <20230911150410.GC9098@noisy.programming.kicks-ass.net>
        <87h6o01w1a.fsf@oracle.com>
        <20230912082606.GB35261@noisy.programming.kicks-ass.net>
        <87cyyfxd4k.ffs@tglx>
        <20231024103426.4074d319@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/jsj69kGF.jAY9NqZHaY.orM"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/jsj69kGF.jAY9NqZHaY.orM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 24 Oct 2023 10:34:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm going to work on a POC, and see if I can get some benchmarks on how
> much this could help tasks like databases and VMs in general.

And that was much easier than I thought it would be. It also shows some
great results!

I started with Thomas's PREEMPT_AUTO.patch from the rt-devel tree:

 https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/PREEMPT_AUTO.patch?h=v6.6-rc6-rt10-patches

So you need to select:

  CONFIG_PREEMPT_AUTO

The below is my proof of concept patch. It still has debugging in it, and
I'm sure the interface will need to be changed.

There's now a new file:  /sys/kernel/extend_sched

Attached is a program that tests it. It mmaps that file, with:

 struct extend_map {
	unsigned long		flags;
 };

 static __thread struct extend_map *extend_map;

That is, there's this structure for every thread. It's assigned with:

	fd = open("/sys/kernel/extend_sched", O_RDWR);
	extend_map = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

I don't actually like this interface, as it wastes a full page for just two
bits :-p

Anyway, to tell the kernel to "extend" the time slice if possible because
it's in a critical section, we have:

 static void extend(void)
 {
	if (!extend_map)
		return;

	extend_map->flags = 1;
 }

And to say that's it's done:

 static void unextend(void)
 {
	unsigned long prev;

	if (!extend_map)
		return;

	prev = xchg(&extend_map->flags, 0);
	if (prev & 2)
		sched_yield();
 }

So, bit 1 is for user space to tell the kernel "please extend me", and bit
two is for the kernel to tell user space "OK, I extended you, but call
sched_yield() when done".

This test program creates 1 + number of CPUs threads, that run in a loop
for 5 seconds. Each thread will grab a user space spin lock (not a futex,
but just shared memory). Before grabbing the lock it will call "extend()",
if it fails to grab the lock, it calls "unextend()" and spins on the lock
until its free, where it will try again. Then after it gets the lock, it
will update a counter, and release the lock, calling "unextend()" as well.
Then it will spin on the counter until it increments again to allow another
task to get into the critical section.

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

Below is my patch (with debugging and on top of Thomas's PREEMPT_AUTO.patch):

Attached is the program I tested it with. It uses libtracefs to write to
the trace_marker file, but if you don't want to build it with libtracefs:

  gcc -o extend-sched extend-sched.c `pkg-config --libs --cflags libtracefs` -lpthread

You can just do:

 grep -v tracefs extend-sched.c > extend-sched-notracefs.c

And build that.

-- Steve

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9b13b7d4f1d3..fb540dd0dec0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -740,6 +740,10 @@ struct kmap_ctrl {
 #endif
 };
 
+struct extend_map {
+	long				flags;
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -802,6 +806,8 @@ struct task_struct {
 	unsigned int			core_occupation;
 #endif
 
+	struct extend_map		*extend_map;
+
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index c1f706038637..21d0e4d81d33 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -147,17 +147,32 @@ void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
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
+			if (!current->extend_map ||
+			    !(current->extend_map->flags & 1)) {
+				schedule();
+			} else {
+				trace_printk("Extend!\n");
+				/* Allow to leave with NEED_RESCHED_LAZY still set */
+				ignore_mask |= _TIF_NEED_RESCHED_LAZY;
+				current->extend_map->flags |= 2;
+			}
+		}
+
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
@@ -184,6 +199,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		tick_nohz_user_enter_prepare();
 
 		ti_work = read_thread_flags();
+		ti_work &= ~ignore_mask;
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
diff --git a/kernel/exit.c b/kernel/exit.c
index edb50b4c9972..ddf89ec9ab62 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -906,6 +906,13 @@ void __noreturn do_exit(long code)
 	if (tsk->io_context)
 		exit_io_context(tsk);
 
+	if (tsk->extend_map) {
+		unsigned long addr = (unsigned long)tsk->extend_map;
+
+		virt_to_page(addr)->mapping = NULL;
+		free_page(addr);
+	}
+
 	if (tsk->splice_pipe)
 		free_pipe_info(tsk->splice_pipe);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3b6d20dfb9a8..da2214082d25 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1166,6 +1166,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->wake_q.next = NULL;
 	tsk->worker_private = NULL;
 
+	tsk->extend_map = NULL;
+
 	kcov_task_init(tsk);
 	kmsan_task_create(tsk);
 	kmap_local_fork(tsk);
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 976092b7bd45..297061cfa08d 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -32,3 +32,4 @@ obj-y += core.o
 obj-y += fair.o
 obj-y += build_policy.o
 obj-y += build_utility.o
+obj-y += extend.o
diff --git a/kernel/sched/extend.c b/kernel/sched/extend.c
new file mode 100644
index 000000000000..a632e1a8f57b
--- /dev/null
+++ b/kernel/sched/extend.c
@@ -0,0 +1,90 @@
+#include <linux/kobject.h>
+#include <linux/pagemap.h>
+#include <linux/sysfs.h>
+#include <linux/init.h>
+
+#ifdef CONFIG_SYSFS
+static ssize_t extend_sched_read(struct file *file,  struct kobject *kobj,
+				 struct bin_attribute *bin_attr,
+				 char *buf, loff_t off, size_t len)
+{
+	static const char output[] = "Extend scheduling time slice\n";
+
+	printk("%s:%d\n", __func__, __LINE__);
+	if (off >= sizeof(output))
+		return 0;
+
+	strscpy(buf, output + off, len);
+	return min((ssize_t)len, sizeof(output) - off - 1);
+}
+
+static ssize_t extend_sched_write(struct file *file, struct kobject *kobj,
+				  struct bin_attribute *bin_attr,
+				  char *buf, loff_t off, size_t len)
+{
+	printk("%s:%d\n", __func__, __LINE__);
+	return -EINVAL;
+}
+
+static vm_fault_t extend_sched_mmap_fault(struct vm_fault *vmf)
+{
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+
+	trace_printk("%s:%d\n", __func__, __LINE__);
+	/* Only has one page */
+	if (vmf->pgoff || !current->extend_map)
+		return ret;
+
+	vmf->page = virt_to_page(current->extend_map);
+
+	get_page(vmf->page);
+	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
+	vmf->page->index   = vmf->pgoff;
+
+	return 0;
+}
+
+static void extend_sched_mmap_open(struct vm_area_struct *vma)
+{
+	printk("%s:%d\n", __func__, __LINE__);
+	WARN_ON(!current->extend_map);
+}
+
+static const struct vm_operations_struct extend_sched_vmops = {
+	.open		= extend_sched_mmap_open,
+	.fault		= extend_sched_mmap_fault,
+};
+
+static int extend_sched_mmap(struct file *file, struct kobject *kobj,
+			     struct bin_attribute *attr,
+			     struct vm_area_struct *vma)
+{
+	if (current->extend_map)
+		return -EBUSY;
+
+	current->extend_map = page_to_virt(alloc_page(GFP_USER | __GFP_ZERO));
+	if (!current->extend_map)
+		return -ENOMEM;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP | VM_MAYWRITE, 0);
+	vma->vm_ops = &extend_sched_vmops;
+
+	return 0;
+}
+
+static struct bin_attribute extend_sched_attr = {
+	.attr = {
+		.name = "extend_sched",
+		.mode = 0777,
+	},
+	.read = &extend_sched_read,
+	.write = &extend_sched_write,
+	.mmap = &extend_sched_mmap,
+};
+
+static __init int extend_init(void)
+{
+	return sysfs_create_bin_file(kernel_kobj, &extend_sched_attr);
+}
+late_initcall(extend_init);
+#endif
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

--MP_/jsj69kGF.jAY9NqZHaY.orM
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=extend-sched.c

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <errno.h>
#include <pthread.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/time.h>
#include <tracefs.h>

#define barrier() asm volatile ("" ::: "memory")
#define rmb() asm volatile ("lfence" ::: "memory")
#define wmb() asm volatile ("sfence" ::: "memory")

#define EXTEND_SCHED "/sys/kernel/extend_sched"

struct extend_map {
	unsigned long		flags;
};

static pthread_barrier_t pbarrier;

static __thread struct extend_map *extend_map;

static void init_extend_map(void)
{
	int page_size;
	void *map;
	int fd;

//	return;

	if (extend_map)
		return;

	fd = open(EXTEND_SCHED, O_RDWR);
	if (fd < 0)
		return;

	page_size = getpagesize();

	map = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (map == MAP_FAILED) {
		perror("mmap");
		exit(-1);
	}

	extend_map = map;

#ifdef TEST 
{
	int x = 0;
	extend_map->flags = 1;

	printf("Spinning\n");
	while (!(*(volatile int *)(&extend_map->flags) & 2)) {
		x++;
		barrier();
	}
	printf("Break! x=%d\n", x);
}
#endif
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
xchg(volatile unsigned long *ptr, unsigned long new)
{
        unsigned long ret = new;

	asm volatile("xchg %b0,%1"
		     : "+r"(ret), "+m"(*(ptr))
		     : : "memory");
        return ret;
}

static void extend(void)
{
	if (!extend_map)
		return;

	extend_map->flags = 1;
}

static void unextend(void)
{
	unsigned long prev;

	if (!extend_map)
		return;

	prev = xchg(&extend_map->flags, 0);
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

--MP_/jsj69kGF.jAY9NqZHaY.orM--
