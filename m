Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093FE80EE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376452AbjLLOOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjLLOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:14:16 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586DE8F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702390460;
        bh=CZlz57rWloWiitqrkGaj9Jzas8iR7il2LGCiEK9NI+8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=x9AEh33aS1IU8cNjHWimEjSV5FcdC96JJV/XVb5wmeu3LQLZP2PwLg4DVxgMQQUlY
         7ATz53jDx/pinW8gD/upRkKXS6ADlepm7Hil/wUkw3wk2+aaGZPE5DVeI7yn+t46pd
         qDHwujasnlHU0ZZj5KN3v+kJMLxV3Pf0YigY2zPnqCEcMwNvTApRhZ39M4M0vVxDPF
         KiY0lmcNc6WioBwjzqoo0vb2QCR22HiNkgrhuqC32gmOeYsqPaQoAj/Dcgx8NmIeg0
         l94z3gkfOkt+cUgqO3N2j25W8eU7x328+xppya1yY37kx9UrAY+6MV5wjGVAniSzAu
         VMiJ9hcOfWusQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SqLG36XGTzGKC;
        Tue, 12 Dec 2023 09:14:19 -0500 (EST)
Message-ID: <ceff5706-e396-498a-95bf-b749ece952af@efficios.com>
Date:   Tue, 12 Dec 2023 09:14:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/35] sched: add cpumask_find_and_set() and use it in
 __mm_cid_get()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20231212022749.625238-1-yury.norov@gmail.com>
 <20231212022749.625238-6-yury.norov@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231212022749.625238-6-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-11 21:27, Yury Norov wrote:
> __mm_cid_get() uses __mm_cid_try_get() helper to atomically acquire a
> bit in mm cid mask. Now that we have atomic find_and_set_bit(), we can
> easily extend it to cpumasks and use in the scheduler code.
> 
> cpumask_find_and_set() considers cid mask as a volatile region of memory,
> as it actually is in this case. So, if it's changed while search is in
> progress, KCSAN wouldn't fire warning on it.
> 
> CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   include/linux/cpumask.h | 12 ++++++++++++
>   kernel/sched/sched.h    | 14 +++++---------
>   2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index cfb545841a2c..c2acced8be4e 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -271,6 +271,18 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>   		small_cpumask_bits, n + 1);
>   }
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
>   /**
>    * for_each_cpu - iterate over every cpu in a mask
>    * @cpu: the (optionally unsigned) integer iterator
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2e5a95486a42..2ce9112de89b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3347,23 +3347,19 @@ static inline void mm_cid_put(struct mm_struct *mm)
>   
>   static inline int __mm_cid_try_get(struct mm_struct *mm)
>   {
> -	struct cpumask *cpumask;
> -	int cid;
> +	struct cpumask *cpumask = mm_cidmask(mm);
> +	int cid = nr_cpu_ids;
>   
> -	cpumask = mm_cidmask(mm);
>   	/*
>   	 * Retry finding first zero bit if the mask is temporarily
>   	 * filled. This only happens during concurrent remote-clear
>   	 * which owns a cid without holding a rq lock.
>   	 */
> -	for (;;) {
> -		cid = cpumask_first_zero(cpumask);
> -		if (cid < nr_cpu_ids)
> -			break;
> +	while (cid >= nr_cpu_ids) {
> +		cid = cpumask_find_and_set(cpumask);
>   		cpu_relax();
>   	}
> -	if (cpumask_test_and_set_cpu(cid, cpumask))
> -		return -1;
> +
>   	return cid;
>   }
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

