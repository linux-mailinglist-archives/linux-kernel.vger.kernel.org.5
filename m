Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F03E7D8A70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjJZVfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjJZVfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:35:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33EBDC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:35:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32000C433C8;
        Thu, 26 Oct 2023 21:35:30 +0000 (UTC)
Date:   Thu, 26 Oct 2023 17:35:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Message-ID: <20231026173527.2ad215cc@gandalf.local.home>
In-Reply-To: <20231026152022.668ca0f3@gandalf.local.home>
References: <20231025235413.597287e1@gandalf.local.home>
        <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
        <20231026071413.4ed47b0e@gandalf.local.home>
        <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
        <20231026152022.668ca0f3@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/=uzH+ow/_xOFCsWFh3XaCEE"
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/=uzH+ow/_xOFCsWFh3XaCEE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 26 Oct 2023 15:20:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Anyway, I changed the code to use:
> 
> static inline unsigned clrbit(volatile unsigned *ptr)
> {
> 	unsigned ret;
> 
> 	asm volatile("andb %b1,%0"
> 		     : "+m" (*(volatile char *)ptr)
> 		     : "iq" (0x2)
> 		     : "memory");
> 
> 	ret = *ptr;
> 	*ptr = 0;
> 
> 	return ret;
> }

Mathieu also told me that glibc's rseq has some extra padding at the end,
that happens to be big enough to hold this feature. That means you can run
the code without adding:

  GLIBC_TUNABLES=glibc.pthread.rseq=0

Attached is the updated test program.

-- Steve

--MP_/=uzH+ow/_xOFCsWFh3XaCEE
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=extend-sched.c


// Run with: GLIBC_TUNABLES=glibc.pthread.rseq=0 

#include <stdio.h>
#include <stddef.h>
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
static __thread struct rseq_abi *rseq_ptr;

static bool no_rseq;

static void init_extend_map(void)
{
	extern ptrdiff_t __rseq_offset;
	extern unsigned int __rseq_size;
	int ret;

	if (no_rseq)
		return;

	if (__rseq_size) {
		if (__rseq_size < sizeof(rseq_map)) {
			printf("glibc rseq less than required mapping\n");
			return;
		}
		rseq_ptr = __builtin_thread_pointer() + __rseq_offset;
		printf("Using glibc rseq %p\n", rseq_ptr);
		return;
	}

	rseq_ptr = &rseq_map;
	ret = rseq(rseq_ptr, sizeof(rseq_map), 0, 0);
	perror("rseq");
	printf("ret = %d (%zd) %p\n", ret, sizeof(rseq_map), &rseq_map);
	if (ret < 0)
		rseq_ptr = NULL;
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

static inline unsigned clrbit(volatile unsigned *ptr)
{
	unsigned ret;

	asm volatile("andb %b1,%0"
		     : "+m" (*(volatile char *)ptr)
		     : "iq" (0x2)
		     : "memory");

	ret = *ptr;
	*ptr = 0;

	return ret;
}

static void extend(void)
{
	if (!rseq_ptr)
		return;

	rseq_ptr->cr_flags = 1;
}

static void unextend(void)
{
	unsigned prev;

	if (!rseq_ptr)
		return;

	prev = clrbit(&rseq_ptr->cr_flags);
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

--MP_/=uzH+ow/_xOFCsWFh3XaCEE--
