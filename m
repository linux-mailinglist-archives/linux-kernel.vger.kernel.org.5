Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB975CB5B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGUPTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjGUPTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:19:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF6D4233
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:18:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F04451F894;
        Fri, 21 Jul 2023 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689952722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Z0mPuy3cG9Y6IXQ+G8D791fr6VEZjBe9UP8cC9gcgA=;
        b=DRK2oberLGzEyjqYUYKwGqCw7mNLzR2URnEP7OR//8G+OPTD5zbTZn3eFaQxL/rNL3V+R4
        Kg95ijUGqNrIxaO6LhDlBaPfD+uHu1Bw+Bm4r0wARyHJRUUXczjpmd/LXMABDwvMN/q162
        W5ePN2ibZ3ArkARLW475IqArM1BBdoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689952722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Z0mPuy3cG9Y6IXQ+G8D791fr6VEZjBe9UP8cC9gcgA=;
        b=EZkUmcSNUuZDtTynIumho0CFnGAxPHDf6uz+eUETmyoelXtzJMwwaVJ+yoC0JyoVh4OU/5
        QOoymRfsVXUA6vBw==
Received: from suse.de (mgorman.udp.ovpn2.nue.suse.de [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1C59E2C142;
        Fri, 21 Jul 2023 15:18:41 +0000 (UTC)
Date:   Fri, 21 Jul 2023 16:18:34 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [RFC PATCH V3 1/1] sched/numa: Fix disjoint set vma scan
 regression
Message-ID: <20230721151834.yaymi6emrppl3mzl@suse.de>
References: <cover.1685506205.git.raghavendra.kt@amd.com>
 <8581ca937d4064b3cd138845d5bd418580d177da.1685506205.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <8581ca937d4064b3cd138845d5bd418580d177da.1685506205.git.raghavendra.kt@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 09:55:26AM +0530, Raghavendra K T wrote:
>  With the numa scan enhancements [1], only the threads which had previously
> accessed vma are allowed to scan.
> 

I know it's very late to be reading this properly for the first time.  It's a
brief review as it's late but I'm not 100% convinced by the patch as-is.

To start off -- reference the specific commit e.g. Since commit fc137c0ddab2
("sched/numa: enhance vma scanning logic")...

> While this had improved significant system time overhead, there were corner
> cases, which genuinely need some relaxation. For e.g.,
> 
> 1) Concern raised by PeterZ, where if there are N partition sets of vmas
> belonging to tasks, then unfairness in allowing these threads to scan could
> potentially amplify the side effect of some of the vmas being left
> unscanned.
> 

This needs a much better description as there is too much guesswork
required to figure out what problem is being solved. You may be referring
to an issue where a VMA not accessed for a long time may be skipped for
scanning indefinitely. You could also be referring to an issue where a
highly active thread always traps the NUMA hinting fault first and other
tasks never pass the vma_is_accessed test. It also could be the case that
due to a malloc implementation behaviour that the thread using a particular
VMA changes and it's not detected. It's simply not clear how the VMAs are
partitioned or what exactly is unfair. I certainly can guess a number of
reasons why a patch like this is necessary but in a years time, it'll be
hard to be certain about the original intent.

> 2) Below reports of LKP numa01 benchmark regression.
> 
> Currently this is handled by allowing first two scanning unconditional
> as indicated by mm->numa_scan_seq. This is imprecise since for some
> benchmark vma scanning might itself start at numa_scan_seq > 2.
> 

Well, it's also not useful in many cases. There is nothing special about
the first two scans other than they happen early in the lifetime of the
process. A major change in phase behaviour that occurs after 2 scans
could miss the new access pattern.

> Solution:
> Allow unconditional scanning of vmas of tasks depending on vma size. This
> is achieved by maintaining a per vma scan counter, where
> 
> f(allowed_to_scan) = f(scan_counter <  vma_size / scan_size)
> 

This is a vague description as well and does not mention that the
scan_counter resets and the code does not appear to match the equation.
It's also a bit arbitrary that unconditional scanning occurs for every task
after the scan_count passes a threshold. The timing of when this occurs may
vary and all threads sharing the address space may conduct the scanning
which may be overkill. It should only be necessary for at least one task
to unconditionally mark the VMA for hinting, no? I'm generally a bit wary
that the time it takes to detect a VMA needs unconditonal scanning depends
on the size as due to VMA-merging, it may be non-deterministic when a VMA
gets scanned and there may be run-to-run variance to the timing of threads
allocating address space.

> Result:
> numa01_THREAD_ALLOC result on 6.4.0-rc2 (that has numascan enhancement)
>                 	base-numascan	base		base+fix
> real    		1m1.507s	1m23.259s	1m2.632s
> user    		213m51.336s	251m46.363s	220m35.528s
> sys     		3m3.397s	0m12.492s	2m41.393s
> 
> numa_hit 		5615517		4560123		4963875
> numa_local 		5615505		4560024		4963700
> numa_other 		12		99		175
> numa_pte_updates 	1822797		493		1559111
> numa_hint_faults 	1307113		523		1469031
> numa_hint_faults_local 	612617		488		884829
> numa_pages_migrated 	694370		35		584202
> 

It's not clear what these kernels are. Is base-numascan a 6.4-rc2 kernel
with at least commit fc137c0ddab2 ("sched/numa: enhance vma scanning
logic") reverted?

The numa_[hint|local|other] stats are not helpful. They are updated on
the allocation side and not related to actual behaviour.

As I'm unsure what the kernels are, I'm not sure how interesting it is
that the pte update stats and number of faults trapped are very different
for base to base+fix. Sure enough, the overall runtime is lower so it's
*probably* good but not sure as it may be also the case that disabling NUMA
balancing would be faster again given the nature of this particular test :P

The testing is a little thin and I'd worry slightly that this patch is
very specific to this particular workload.

> Summary: Regression in base is recovered by allowing scanning as required.
> 
> [1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
> 
> Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> regression.

Fixes may be a bit overkill as this patch is more of an enhancement than
something that justifies a backport to -stable but I don't feel strongly
about it.

> Reported-by: Aithal Srikanth <sraithal@amd.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  include/linux/mm_types.h |  1 +
>  kernel/sched/fair.c      | 31 ++++++++++++++++++++++++-------
>  2 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..992e460a713e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -479,6 +479,7 @@ struct vma_numab_state {
>  	unsigned long next_scan;
>  	unsigned long next_pid_reset;
>  	unsigned long access_pids[2];
> +	unsigned int scan_counter;
>  };

Vague name as it's not counting and gets reset. It might have been clearer
to name is something like scan_selective with an initial value related to
the VMA size that decrements. When it hits 0, the scan is forced *once*
for the unlucky task. The suggested name is also bad, I'm terrible at
naming but "counter" gives no hints either.

>  
>  /*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..4e71fb58085b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2931,17 +2931,30 @@ static void reset_ptenuma_scan(struct task_struct *p)
>  static bool vma_is_accessed(struct vm_area_struct *vma)
>  {
>  	unsigned long pids;
> +	unsigned int vma_size;
> +	unsigned int scan_threshold;
> +	unsigned int scan_size;
> +
> +	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
> +
> +	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
> +		return true;
> +
> +	scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);
> +	/* vma size in MB */
> +	vma_size = (vma->vm_end - vma->vm_start) >> 20;
> +
> +	/* Total scans needed to cover VMA */
> +	scan_threshold = vma_size / scan_size;
> +
>  	/*
> -	 * Allow unconditional access first two times, so that all the (pages)
> -	 * of VMAs get prot_none fault introduced irrespective of accesses.
> +	 * Allow the scanning of half of disjoint set's VMA to induce
> +	 * prot_none fault irrespective of accesses.
>  	 * This is also done to avoid any side effect of task scanning
>  	 * amplifying the unfairness of disjoint set of VMAs' access.
>  	 */

Much better description is required. It's not stated how the VMAs are
disjoint. For example, they all belong to the same address space so from that
perspective they are not disjoint. Clarify that it's related to accesses
at the very least or be clear on how a set of VMAs can be disjoint. Also,
it's not half the total VMAs or some other critieria either, it's related
to scanning events. There is a lot of guesswork involved here.

> -	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
> -		return true;
> -
> -	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
> -	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
> +	scan_threshold = 1 + (scan_threshold >> 1);
> +	return (vma->numab_state->scan_counter < scan_threshold);
>  }
>  
>  #define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
> @@ -3058,6 +3071,8 @@ static void task_numa_work(struct callback_head *work)
>  			/* Reset happens after 4 times scan delay of scan start */
>  			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
>  				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
> +
> +			vma->numab_state->scan_counter = 0;
>  		}
>  
>  		/*
> @@ -3084,6 +3099,8 @@ static void task_numa_work(struct callback_head *work)
>  			vma->numab_state->access_pids[1] = 0;
>  		}
>  
> +		vma->numab_state->scan_counter++;
> +
>  		do {
>  			start = max(start, vma->vm_start);
>  			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);

This has a potential timing issue as only tasks that accessed the VMA
update the counter. A task could create a VMA, access is heavily in an
init phase and then go completely idle waiting on other tasks to complete
(e.g. parallelised load that uses a single thread to setup the data and then
creates worker threads to process that data). As there is no guarantee other
tasks would trap a fault, the access bits would never be set, the counter
never increments and the VMA is ignored forever. It's late on a Friday so
maybe I'm wrong but it looks like this could have weird corner cases.

The counter should at least increase if the VMA could have been scanned
except the access bits were not set with the caveat that it may incur
excessive cache misses.

-- 
Mel Gorman
SUSE Labs
