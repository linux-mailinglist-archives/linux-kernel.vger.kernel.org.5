Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0077C61A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjJLASd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJLASc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:18:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03A94
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:18:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9e06f058bso597815ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697069910; x=1697674710; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQN9vSH8iWVgcD57W2RcIWZ/SjzvV3Q0OmDN0z8ptDI=;
        b=M7j++fpFlQQHNdNAF3r/i3RcFKqhfMGxHpmNVnLjc8ifSIaULWrYRP0nGpm6Y71jMR
         2r17db967sUU884N0ozvFUBOjWv4dGO517LaGgSOB6G4Vb3bJQnmKAjch4LN8AHuU8Vg
         JK8Xv/ydoKGgZNHZqEH6tm6WDSIgg38SMeMoGB0q7s3hkCBmqFl38Y2+G4dtb7cgNJc1
         j9iJexKHb6HndKfo09THPHKlY1kJMdzcaxW5M3lXr7D8SJx2ZSXNDnmSSrvCtVLX9KQY
         dfSrAtHmr4CJ2l06bkbmTdYbPB39kBJE5iw7xoCXNOVzkz7LBN0FJeZZXMT6pQ9GJTXl
         jniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697069910; x=1697674710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQN9vSH8iWVgcD57W2RcIWZ/SjzvV3Q0OmDN0z8ptDI=;
        b=HFmVfYa02h2/jIRBEqNWVE4lG5FM1t4QiJfm1TCxVxe/KoXuyjFWZ59hXl8cnrl4Rz
         DwZGGLn9KWlMgTuWcGolre32YeFVcH3qL7M39SbijYTEqJytwOum92A60ZUM0iCMjWpd
         5G+Kw795Az9URaJyDdeUkiw0oy/ygFkZdUs7k7JkTfVLcjYYU7ZuYrrD9da33thynz9G
         Q5LYlISRjdUX77c4JL0BGQgpTCt1DhPSAHGpNCPyUcatynOKhRqvl+HFdirMdz2sou/x
         2EiIJTIsp9dKa95zlPOk5iCG2iTwokKH0zTe0wt/ZnuxJ/trgJ2+mynWqUspil76zxdD
         jIKg==
X-Gm-Message-State: AOJu0YyG88znyrfe1con07RWPXj+3hOKNDKhjbZBpzoy0GpsX/PkELbE
        vU3QuJEAtQZG7TzG1lQZuVQ=
X-Google-Smtp-Source: AGHT+IG98wO7FcURIdjLoQPmsNCek4Xf6WZBrqwekNrfkwlUVVnoj+q22YdqjCJUGgTgNKbya4DoGA==
X-Received: by 2002:a17:902:c404:b0:1c9:9fa6:ce5b with SMTP id k4-20020a170902c40400b001c99fa6ce5bmr14972432plk.16.1697069910374;
        Wed, 11 Oct 2023 17:18:30 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170903278e00b001adf6b21c77sm463933plb.107.2023.10.11.17.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 17:18:29 -0700 (PDT)
Date:   Wed, 11 Oct 2023 17:16:16 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Ankit Jain <ankitja@vmware.com>
Cc:     peterz@infradead.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, qyousef@layalina.io, pjt@google.com,
        joshdon@google.com, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, namit@vmware.com,
        amakhalov@vmware.com, srinidhir@vmware.com, vsirnapalli@vmware.com,
        vbrahmajosyula@vmware.com, akaher@vmware.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
Message-ID: <ZSc60HJ8mZGhLkAn@yury-ThinkPad>
References: <20231011071925.761590-1-ankitja@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011071925.761590-1-ankitja@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:49:25PM +0530, Ankit Jain wrote:
> commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
> and commit 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
> introduced the logic to distribute the tasks at initial wakeup on cpus
> where load balancing works poorly or disabled at all (isolated cpus).
> 
> There are cases in which the distribution of tasks
> that are spawned on isolcpus does not happen properly.
> In production deployment, initial wakeup of tasks spawn from
> housekeeping cpus to isolcpus[nohz_full cpu] happens on first cpu
> within isolcpus range instead of distributed across isolcpus.
> 
> Usage of distribute_cpu_mask_prev from one processes group,
> will clobber previous value of another or other groups and vice-versa.
> 
> When housekeeping cpus spawn multiple child tasks to wakeup on
> isolcpus[nohz_full cpu], using cpusets.cpus/sched_setaffinity(),
> distribution is currently performed based on per-cpu
> distribute_cpu_mask_prev counter.
> At the same time, on housekeeping cpus there are percpu
> bounded timers interrupt/rcu threads and other system/user tasks
> would be running with affinity as housekeeping cpus. In a real-life
> environment, housekeeping cpus are much fewer and are too much loaded.
> So, distribute_cpu_mask_prev value from these tasks impacts
> the offset value for the tasks spawning to wakeup on isolcpus and
> thus most of the tasks end up waking up on first cpu within the
> isolcpus set.
> 
> Steps to reproduce:
> Kernel cmdline parameters:
> isolcpus=2-5 skew_tick=1 nohz=on nohz_full=2-5
> rcu_nocbs=2-5 rcu_nocb_poll idle=poll irqaffinity=0-1
> 
> * pid=$(echo $$)
> * taskset -pc 0 $pid
> * cat loop-normal.c
> int main(void)
> {
>         while (1)
>                 ;
>         return 0;
> }
> * gcc -o loop-normal loop-normal.c
> * for i in {1..50}; do ./loop-normal & done
> * pids=$(ps -a | grep loop-normal | cut -d' ' -f5)
> * for i in $pids; do taskset -pc 2-5 $i ; done
> 
> Expected output:
> * All 50 “loop-normal” tasks should wake up on cpu2-5
> equally distributed.
> * ps -eLo cpuid,pid,tid,ppid,cls,psr,cls,cmd | grep "^    [2345]"
> 
> Actual output:
> * All 50 “loop-normal” tasks got woken up on cpu2 only
> 
> Analysis:
> There are percpu bounded timer interrupt/rcu threads activities
> going on every few microseconds on housekeeping cpus, exercising
> find_lowest_rq() -> cpumask_any_and_distribute()/cpumask_any_distribute()
> So, per cpu variable distribute_cpu_mask_prev for housekeeping cpus
> keep on getting set to housekeeping cpus. Bash/docker processes
> are sharing same per cpu variable as they run on housekeeping cpus.
> Thus intersection of clobbered distribute_cpu_mask_prev and
> new mask(isolcpus) return always first cpu within the new mask(isolcpus)
> in accordance to the logic mentioned in commits above.
> 
> Fix the issue by using random cores out of the applicable CPU set
> instead of relying on distribute_cpu_mask_prev.
> 
> Fixes: 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
> Fixes: 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
> 
> Signed-off-by: Ankit Jain <ankitja@vmware.com>
> ---
>  lib/cpumask.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index a7fd02b5ae26..95a7c1b40e95 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -155,45 +155,47 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
>  }
>  EXPORT_SYMBOL(cpumask_local_spread);
>  
> -static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
> -
>  /**
>   * cpumask_any_and_distribute - Return an arbitrary cpu within src1p & src2p.
>   * @src1p: first &cpumask for intersection
>   * @src2p: second &cpumask for intersection
>   *
> - * Iterated calls using the same srcp1 and srcp2 will be distributed within
> - * their intersection.
> + * Iterated calls using the same srcp1 and srcp2 will be randomly distributed
> + * within their intersection.
>   *
>   * Returns >= nr_cpu_ids if the intersection is empty.
>   */

This has been discussed a while ago, and the bottomline is that 'any'
is not the same as 'random'. In practice, it means that getting 'any'
cpu is cheaper than getting randomized one.

I'm not that deep in context of the problem you're trying to solve, but
if you need randomized CPU, can you just add a new function for it?
Something like cpumask_get_random().

The approach with find_nth_bit() itself looks good to me.

Thanks,
Yury

>  unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
>  			       const struct cpumask *src2p)
>  {
> -	unsigned int next, prev;
> +	unsigned int n_cpus, nth_cpu;
>  
> -	/* NOTE: our first selection will skip 0. */
> -	prev = __this_cpu_read(distribute_cpu_mask_prev);
> +	n_cpus = cpumask_weight_and(src1p, src2p);
> +	if (n_cpus == 0)
> +		return nr_cpu_ids;
>  
> -	next = find_next_and_bit_wrap(cpumask_bits(src1p), cpumask_bits(src2p),
> -					nr_cpumask_bits, prev + 1);
> -	if (next < nr_cpu_ids)
> -		__this_cpu_write(distribute_cpu_mask_prev, next);
> +	nth_cpu = get_random_u32_below(n_cpus);
>  
> -	return next;
> +	return find_nth_and_bit(cpumask_bits(src1p), cpumask_bits(src2p),
> +					nr_cpumask_bits, nth_cpu);
>  }
>  EXPORT_SYMBOL(cpumask_any_and_distribute);
>  
> +/**
> + * Returns an arbitrary cpu within srcp.
> + *
> + * Iterated calls using the same srcp will be randomly distributed
> + */
>  unsigned int cpumask_any_distribute(const struct cpumask *srcp)
>  {
> -	unsigned int next, prev;
> +	unsigned int n_cpus, nth_cpu;
>  
> -	/* NOTE: our first selection will skip 0. */
> -	prev = __this_cpu_read(distribute_cpu_mask_prev);
> -	next = find_next_bit_wrap(cpumask_bits(srcp), nr_cpumask_bits, prev + 1);
> -	if (next < nr_cpu_ids)
> -		__this_cpu_write(distribute_cpu_mask_prev, next);
> +	n_cpus = cpumask_weight(srcp);
> +	if (n_cpus == 0)
> +		return nr_cpu_ids;
>  
> -	return next;
> +	nth_cpu = get_random_u32_below(n_cpus);
> +
> +	return find_nth_bit(cpumask_bits(srcp), nr_cpumask_bits, nth_cpu);
>  }
>  EXPORT_SYMBOL(cpumask_any_distribute);
> -- 
> 2.23.1
