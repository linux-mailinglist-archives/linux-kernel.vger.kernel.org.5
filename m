Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5407F1204
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjKTLbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjKTLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:31:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9382BFC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=olTJQwBS3ubhzSRJsqrMCxN3w/D68ONkPCsGWjWzOPk=; b=K/LRxm1ApSLmH2cdXiFaJL9j9g
        5I28SBHzXKpS+2YfhOTsGo3gqyUetIQpIf8NFFAYQsooV0z3jm30h/ObCzoWgXsIx0h39U/Y4KoMv
        z6BKZzXOyso4mlzIqCLc9BXJR2KzjzpMBVML5oS1y5pSwKlijsrVfKVMtJ7DqFo1RKB8zepdl7uQY
        RP5zsv4rfT797d3MMYAMTXjWFSFRQnp5OBpTuu0giXUnGOSbwhBlZ22J03sf+WtHGSX8PoAyujpTo
        59m+O1TgSARgUM/73zeVWMXJ0UnpEqbhFRM/mJPGQ+mcOfep8jlWJz1Fc2iN56QIQG2oG3ye1x24Q
        6Y+pC4lg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r52Uc-004Pvj-N8; Mon, 20 Nov 2023 11:31:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C61B300419; Mon, 20 Nov 2023 12:31:05 +0100 (CET)
Date:   Mon, 20 Nov 2023 12:31:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>, mathieu.desnoyers@efficios.com
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 04/34] sched: add cpumask_find_and_set() and use it in
 __mm_cid_get()
Message-ID: <20231120113105.GR8262@noisy.programming.kicks-ass.net>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-5-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118155105.25678-5-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 07:50:35AM -0800, Yury Norov wrote:
> __mm_cid_get() uses a __mm_cid_try_get() helper to atomically acquire a
> bit in mm cid mask. Now that we have atomic find_and_set_bit(), we can
> easily extend it to cpumasks and use in the scheduler code.
> 
> __mm_cid_try_get() has an infinite loop, which may delay forward
> progress of __mm_cid_get() when the mask is dense. The
> cpumask_find_and_set() doesn't poll the mask infinitely, and returns as
> soon as nothing has found after the first iteration, allowing to acquire
> the lock, and set use_cid_lock faster, if needed.

Methieu, I forgot again, but the comment delete seems to suggest you did
this on purpose...

> cpumask_find_and_set() considers cid mask as a volatile region of memory,
> as it actually is in this case. So, if it's changed while search is in
> progress, KCSAN wouldn't fire warning on it.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/cpumask.h | 12 ++++++++++
>  kernel/sched/sched.h    | 52 ++++++++++++-----------------------------
>  2 files changed, 27 insertions(+), 37 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index cfb545841a2c..c2acced8be4e 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -271,6 +271,18 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>  		small_cpumask_bits, n + 1);
>  }
>  
> +/**
> + * cpumask_find_and_set - find the first unset cpu in a cpumask and
> + *			  set it atomically
> + * @srcp: the cpumask pointer
> + *
> + * Return: >= nr_cpu_ids if nothing is found.
> + */
> +static inline unsigned int cpumask_find_and_set(volatile struct cpumask *srcp)
> +{
> +	return find_and_set_bit(cpumask_bits(srcp), small_cpumask_bits);
> +}
> +
>  /**
>   * for_each_cpu - iterate over every cpu in a mask
>   * @cpu: the (optionally unsigned) integer iterator
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2e5a95486a42..b2f095a9fc40 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3345,28 +3345,6 @@ static inline void mm_cid_put(struct mm_struct *mm)
>  	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
>  }
>  
> -static inline int __mm_cid_try_get(struct mm_struct *mm)
> -{
> -	struct cpumask *cpumask;
> -	int cid;
> -
> -	cpumask = mm_cidmask(mm);
> -	/*
> -	 * Retry finding first zero bit if the mask is temporarily
> -	 * filled. This only happens during concurrent remote-clear
> -	 * which owns a cid without holding a rq lock.
> -	 */
> -	for (;;) {
> -		cid = cpumask_first_zero(cpumask);
> -		if (cid < nr_cpu_ids)
> -			break;
> -		cpu_relax();
> -	}
> -	if (cpumask_test_and_set_cpu(cid, cpumask))
> -		return -1;
> -	return cid;
> -}
> -
>  /*
>   * Save a snapshot of the current runqueue time of this cpu
>   * with the per-cpu cid value, allowing to estimate how recently it was used.
> @@ -3381,25 +3359,25 @@ static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
>  
>  static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
>  {
> +	struct cpumask *cpumask = mm_cidmask(mm);
>  	int cid;
>  
> -	/*
> -	 * All allocations (even those using the cid_lock) are lock-free. If
> -	 * use_cid_lock is set, hold the cid_lock to perform cid allocation to
> -	 * guarantee forward progress.
> -	 */
> +	/* All allocations (even those using the cid_lock) are lock-free. */
>  	if (!READ_ONCE(use_cid_lock)) {
> -		cid = __mm_cid_try_get(mm);
> -		if (cid >= 0)
> +		cid = cpumask_find_and_set(cpumask);
> +		if (cid < nr_cpu_ids)
>  			goto end;
> -		raw_spin_lock(&cid_lock);
> -	} else {
> -		raw_spin_lock(&cid_lock);
> -		cid = __mm_cid_try_get(mm);
> -		if (cid >= 0)
> -			goto unlock;
>  	}
>  
> +	/*
> +	 * If use_cid_lock is set, hold the cid_lock to perform cid
> +	 * allocation to guarantee forward progress.
> +	 */
> +	raw_spin_lock(&cid_lock);
> +	cid = cpumask_find_and_set(cpumask);
> +	if (cid < nr_cpu_ids)
> +		goto unlock;
> +
>  	/*
>  	 * cid concurrently allocated. Retry while forcing following
>  	 * allocations to use the cid_lock to ensure forward progress.
> @@ -3415,9 +3393,9 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
>  	 * all newcoming allocations observe the use_cid_lock flag set.
>  	 */
>  	do {
> -		cid = __mm_cid_try_get(mm);
> +		cid = cpumask_find_and_set(cpumask);
>  		cpu_relax();
> -	} while (cid < 0);
> +	} while (cid >= nr_cpu_ids);
>  	/*
>  	 * Allocate before clearing use_cid_lock. Only care about
>  	 * program order because this is for forward progress.
> -- 
> 2.39.2
> 
