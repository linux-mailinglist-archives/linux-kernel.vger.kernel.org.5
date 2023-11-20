Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4C67F185A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjKTQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjKTQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:17:09 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF42188
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700497022;
        bh=d6rqLDZNf/QFC9igObHmliF6PZsMbzLwVI6zQhhz1sg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mny2xXZkFOUjRmzxidnYj/qElPR9IvfrwEpeGh4yPxgShoozyU8QPpS8HZUHn00bx
         +ayPqqCrWspNW40b16orHLZS13uJ3dZUF7MdsFe/14nvv7sRAKHTpblqLBq0xZMI0b
         1n8s7RRbwOGkbZ9V7fvKPF8j2VA8m2xvzI9KGzSYlQ/ALe5VMgziPk9v9y718B2Y64
         9sg1RNpMPJQfNzJGXAIrvxEtn74Bf2u3g2CJZOhAQzA5G+N+ErCry/ibVX5jXWUyfH
         gSBEP5Bc0JXre4eW7IKfrQcGfIFsff5z/w6xXAOPxlbGm+/k5Tcr5yR6d7XDGhog/n
         9pdvCQhNpT56g==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SYt1n48m4z1d0X;
        Mon, 20 Nov 2023 11:17:01 -0500 (EST)
Message-ID: <1eb9435a-aa1c-4c30-ab1a-9167b73d1b83@efficios.com>
Date:   Mon, 20 Nov 2023 11:17:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/34] sched: add cpumask_find_and_set() and use it in
 __mm_cid_get()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>
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
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-5-yury.norov@gmail.com>
 <20231120113105.GR8262@noisy.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231120113105.GR8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-20 06:31, Peter Zijlstra wrote:
> On Sat, Nov 18, 2023 at 07:50:35AM -0800, Yury Norov wrote:
>> __mm_cid_get() uses a __mm_cid_try_get() helper to atomically acquire a
>> bit in mm cid mask. Now that we have atomic find_and_set_bit(), we can
>> easily extend it to cpumasks and use in the scheduler code.
>>
>> __mm_cid_try_get() has an infinite loop, which may delay forward
>> progress of __mm_cid_get() when the mask is dense. The
>> cpumask_find_and_set() doesn't poll the mask infinitely, and returns as
>> soon as nothing has found after the first iteration, allowing to acquire
>> the lock, and set use_cid_lock faster, if needed.
> 
> Methieu, I forgot again, but the comment delete seems to suggest you did
> this on purpose...

See comments below.

> 
>> cpumask_find_and_set() considers cid mask as a volatile region of memory,
>> as it actually is in this case. So, if it's changed while search is in
>> progress, KCSAN wouldn't fire warning on it.
>>
>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>> ---
>>   include/linux/cpumask.h | 12 ++++++++++
>>   kernel/sched/sched.h    | 52 ++++++++++++-----------------------------
>>   2 files changed, 27 insertions(+), 37 deletions(-)
>>
>> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
>> index cfb545841a2c..c2acced8be4e 100644
>> --- a/include/linux/cpumask.h
>> +++ b/include/linux/cpumask.h
>> @@ -271,6 +271,18 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>>   		small_cpumask_bits, n + 1);
>>   }
>>   
>> +/**
>> + * cpumask_find_and_set - find the first unset cpu in a cpumask and
>> + *			  set it atomically
>> + * @srcp: the cpumask pointer
>> + *
>> + * Return: >= nr_cpu_ids if nothing is found.
>> + */
>> +static inline unsigned int cpumask_find_and_set(volatile struct cpumask *srcp)
>> +{
>> +	return find_and_set_bit(cpumask_bits(srcp), small_cpumask_bits);
>> +}
>> +
>>   /**
>>    * for_each_cpu - iterate over every cpu in a mask
>>    * @cpu: the (optionally unsigned) integer iterator
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 2e5a95486a42..b2f095a9fc40 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -3345,28 +3345,6 @@ static inline void mm_cid_put(struct mm_struct *mm)
>>   	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
>>   }
>>   
>> -static inline int __mm_cid_try_get(struct mm_struct *mm)
>> -{
>> -	struct cpumask *cpumask;
>> -	int cid;
>> -
>> -	cpumask = mm_cidmask(mm);
>> -	/*
>> -	 * Retry finding first zero bit if the mask is temporarily
>> -	 * filled. This only happens during concurrent remote-clear
>> -	 * which owns a cid without holding a rq lock.
>> -	 */
>> -	for (;;) {
>> -		cid = cpumask_first_zero(cpumask);
>> -		if (cid < nr_cpu_ids)
>> -			break;
>> -		cpu_relax();
>> -	}
>> -	if (cpumask_test_and_set_cpu(cid, cpumask))
>> -		return -1;

This was split in find / test_and_set on purpose because following
patches I have (implementing numa-aware mm_cid) have a scan which
needs to scan sets of two cpumasks in parallel (with "and" and
and_not" operators).

Moreover, the "mask full" scenario only happens while a concurrent
remote-clear temporarily owns a cid without rq lock. See
sched_mm_cid_remote_clear():

         /*
          * The cid is unused, so it can be unset.
          * Disable interrupts to keep the window of cid ownership without rq
          * lock small.
          */
         local_irq_save(flags);
         if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
                 __mm_cid_put(mm, cid);
         local_irq_restore(flags);

The proposed patch here turns this scenario into something heavier
(setting the use_cid_lock) rather than just retrying. I guess the
question to ask here is whether it is theoretically possible to cause
__mm_cid_try_get() to fail to have forward progress if we have a high
rate of sched_mm_cid_remote_clear. If we decide that this is indeed
a possible progress-failure scenario, then it makes sense to fallback
to use_cid_lock as soon as a full mask is encountered.

However, removing the __mm_cid_try_get() helper will make it harder to
integrate the following numa-awareness patches I have on top.

I am not against using cpumask_find_and_set, but can we keep the
__mm_cid_try_get() helper to facilitate integration of future work ?
We just have to make it use cpumask_find_and_set, which should be
easy.

>> -	return cid;
>> -}
>> -
>>   /*
>>    * Save a snapshot of the current runqueue time of this cpu
>>    * with the per-cpu cid value, allowing to estimate how recently it was used.
>> @@ -3381,25 +3359,25 @@ static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
>>   
>>   static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
>>   {
>> +	struct cpumask *cpumask = mm_cidmask(mm);
>>   	int cid;
>>   
>> -	/*
>> -	 * All allocations (even those using the cid_lock) are lock-free. If
>> -	 * use_cid_lock is set, hold the cid_lock to perform cid allocation to
>> -	 * guarantee forward progress.
>> -	 */
>> +	/* All allocations (even those using the cid_lock) are lock-free. */
>>   	if (!READ_ONCE(use_cid_lock)) {
>> -		cid = __mm_cid_try_get(mm);
>> -		if (cid >= 0)
>> +		cid = cpumask_find_and_set(cpumask);
>> +		if (cid < nr_cpu_ids)
>>   			goto end;
>> -		raw_spin_lock(&cid_lock);
>> -	} else {
>> -		raw_spin_lock(&cid_lock);
>> -		cid = __mm_cid_try_get(mm);
>> -		if (cid >= 0)
>> -			goto unlock;
>>   	}
>>   
>> +	/*
>> +	 * If use_cid_lock is set, hold the cid_lock to perform cid
>> +	 * allocation to guarantee forward progress.
>> +	 */
>> +	raw_spin_lock(&cid_lock);
>> +	cid = cpumask_find_and_set(cpumask);
>> +	if (cid < nr_cpu_ids)
>> +		goto unlock;

In the !use_cid_lock case where we already failed a lookup above, this change
ends up doing another attempt at lookup before setting the use_cid_lock and
attempting again until success. I am not sure what is the motivation for changing
the code flow here ?

General comment about the rest of the series: please review code comments for
typos.

Thanks,

Mathieu

>> +
>>   	/*
>>   	 * cid concurrently allocated. Retry while forcing following
>>   	 * allocations to use the cid_lock to ensure forward progress.
>> @@ -3415,9 +3393,9 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
>>   	 * all newcoming allocations observe the use_cid_lock flag set.
>>   	 */
>>   	do {
>> -		cid = __mm_cid_try_get(mm);
>> +		cid = cpumask_find_and_set(cpumask);
>>   		cpu_relax();
>> -	} while (cid < 0);
>> +	} while (cid >= nr_cpu_ids);
>>   	/*
>>   	 * Allocate before clearing use_cid_lock. Only care about
>>   	 * program order because this is for forward progress.
>> -- 
>> 2.39.2
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

