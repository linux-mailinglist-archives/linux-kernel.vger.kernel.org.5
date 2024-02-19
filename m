Return-Path: <linux-kernel+bounces-71118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D285A0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FD12821DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A92C19F;
	Mon, 19 Feb 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+pvgGIa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2872B2C197
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338206; cv=none; b=dNPP5NSJbtNXOYznAq1OH24NKWhzi4Hi+40WapPi3EekNhY33miOVzN1cwkTLGyJ87HIZCftcjnr5tdWxhkJ6OIVqhdGWDCz0MEn5GlZ2P4FcF1xlNMY3Fkbws9tAWwCI7b5suk7mDnSe9Qj4OdZlBBuFgKHqlpFnxW505X+reU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338206; c=relaxed/simple;
	bh=jYpsbolF0EVLTeJbfTift3BZwEX6egktZxxqnTwQacc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ra7ArAxIjXK9yV6ygPGeDlUZm5A+QkykvHQHVpe7l1ujrKsYTZTLYbovzXeuV7fnpJf2ou9a0Y6g5UdIY/N20R8/Sd31vYBK8Pe+MibDfif0oiIGAtVstt4DoBXXGYH4Gh44l8aNmwEVd/6c0OXRDMfjc0DhHwBK4vxtohoOqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+pvgGIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29909C433B1;
	Mon, 19 Feb 2024 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708338205;
	bh=jYpsbolF0EVLTeJbfTift3BZwEX6egktZxxqnTwQacc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B+pvgGIaf/zednIhPmekQi+DlCHkKoDfU1AoaoP70LhH6qwU6oU+Pk3aWp96sVF7q
	 bKxqE5e3YnoYqIKWCoQtNvkZb+adLk+x8xywGcG7Ix5zAGTmg79LLAQsEoYtBcOCM6
	 PXKEXms2UL0YJqeWGfALwi/7it/Us7DpIvbqPW014Ah00YdW59NoXgP2RDeYCTohzz
	 qKADTn+ftmjKFMo6Wh+eKfvL1wdPe2xufffqfLy6a9Vt8IkP4+YKxg5/OVo7AHwo+j
	 gkDaqqFSJDLJDpJzLo+Ejc1gME4mnqCqaIfd/eaMtD/ZuquxAP6fUoa48lJgB8XEET
	 JUCMGkk4w7j4Q==
Message-ID: <23b87c48-c4b8-4b85-822a-33cffaf6f779@kernel.org>
Date: Mon, 19 Feb 2024 11:23:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] SCHED_DEADLINE server infrastructure
Content-Language: en-US, pt-BR, it-IT
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Aaron Lu <aaron.lu@intel.com>, Kairui Song <kasong@tencent.com>,
 Guo Ziliang <guo.ziliang@zte.com.cn>
References: <cover.1699095159.git.bristot@kernel.org>
 <8734tosyb9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <8734tosyb9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi

On 2/19/24 08:33, Huang, Ying wrote:
> Hi, Daniel,
> 
> Thanks a lot for your great patchset!
> 
> We have a similar starvation issue in mm subsystem too.  Details are in
> the patch description of the below commit.  In short, task A is busy
> looping on some event, while task B will signal the event after some
> work.  If the priority of task A is higher than that of task B, task B
> may be starved.

ok...

> 
> IIUC, if task A is RT task while task B is fair task, then your patchset
> will solve the issue.

This patch set will not solve the issue. It will mitigate the effect of the
problem. Still the system will perform very poorly...

If both task A and task B is RT tasks, is there
> some way to solve the issue?

I would say reworking the swap algorithm, as it is not meant to be used when
real-time tasks are in place.

As an exercise, let's say that we add a server per priority on FIFO, with a default
50ms/1s runtime period. Your "real-time" workload would suffer a 950ms latency,
busy loop in vain.

Then one would say, let's lower the parameters, so the granularity of
the server would provide lower latencies. The same problem would still
exist, as it exists with sched fair....

So, the solution is not on schedule. Busy loop waiting is not right when you
have RT tasks. That is why PREEMPT_RT reworks the locking pattern to remove
spin_locks that do busy waiting. spin_locks do not have this problem you
show because they disable preemption... but disabling preemption is not
the best solution either.

So, a first try of duct tape would using (local_?) locks like in
preempt rt to make things sleepable...

AFAICS, this was already discussed in the previous link, right?

> 
> Now, we use a ugly schedule_timeout_uninterruptible(1) in the loop to
> resolve the issue, is there something better?

I am not a swap/mm expert.. my guesses would be all on sleepable locking.
But I know there are many smart people on the mm side with better guesses...

It is just that the DL server or any type of starvation avoidance does not
seem to be a solution for your problem.

-- Daniel


> Best Regards,
> Huang, Ying
> 
> --------------------------8<---------------------------------------
> commit 029c4628b2eb2ca969e9bf979b05dc18d8d5575e
> Author: Guo Ziliang <guo.ziliang@zte.com.cn>
> Date:   Wed Mar 16 16:15:03 2022 -0700
> 
>     mm: swap: get rid of livelock in swapin readahead
>     
>     In our testing, a livelock task was found.  Through sysrq printing, same
>     stack was found every time, as follows:
>     
>       __swap_duplicate+0x58/0x1a0
>       swapcache_prepare+0x24/0x30
>       __read_swap_cache_async+0xac/0x220
>       read_swap_cache_async+0x58/0xa0
>       swapin_readahead+0x24c/0x628
>       do_swap_page+0x374/0x8a0
>       __handle_mm_fault+0x598/0xd60
>       handle_mm_fault+0x114/0x200
>       do_page_fault+0x148/0x4d0
>       do_translation_fault+0xb0/0xd4
>       do_mem_abort+0x50/0xb0
>     
>     The reason for the livelock is that swapcache_prepare() always returns
>     EEXIST, indicating that SWAP_HAS_CACHE has not been cleared, so that it
>     cannot jump out of the loop.  We suspect that the task that clears the
>     SWAP_HAS_CACHE flag never gets a chance to run.  We try to lower the
>     priority of the task stuck in a livelock so that the task that clears
>     the SWAP_HAS_CACHE flag will run.  The results show that the system
>     returns to normal after the priority is lowered.
>     
>     In our testing, multiple real-time tasks are bound to the same core, and
>     the task in the livelock is the highest priority task of the core, so
>     the livelocked task cannot be preempted.
>     
>     Although cond_resched() is used by __read_swap_cache_async, it is an
>     empty function in the preemptive system and cannot achieve the purpose
>     of releasing the CPU.  A high-priority task cannot release the CPU
>     unless preempted by a higher-priority task.  But when this task is
>     already the highest priority task on this core, other tasks will not be
>     able to be scheduled.  So we think we should replace cond_resched() with
>     schedule_timeout_uninterruptible(1), schedule_timeout_interruptible will
>     call set_current_state first to set the task state, so the task will be
>     removed from the running queue, so as to achieve the purpose of giving
>     up the CPU and prevent it from running in kernel mode for too long.
>     
>     (akpm: ugly hack becomes uglier.  But it fixes the issue in a
>     backportable-to-stable fashion while we hopefully work on something
>     better)
>     
>     Link: https://lkml.kernel.org/r/20220221111749.1928222-1-cgel.zte@gmail.com
>     Signed-off-by: Guo Ziliang <guo.ziliang@zte.com.cn>
>     Reported-by: Zeal Robot <zealci@zte.com.cn>
>     Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>     Reviewed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
>     Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
>     Acked-by: Hugh Dickins <hughd@google.com>
>     Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>     Cc: Michal Hocko <mhocko@kernel.org>
>     Cc: Minchan Kim <minchan@kernel.org>
>     Cc: Johannes Weiner <hannes@cmpxchg.org>
>     Cc: Roger Quadros <rogerq@kernel.org>
>     Cc: Ziliang Guo <guo.ziliang@zte.com.cn>
>     Cc: <stable@vger.kernel.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 8d4104242100..ee67164531c0 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -478,7 +478,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
>  		 * in swap_map, but not yet added its page to swap cache.
>  		 */
> -		cond_resched();
> +		schedule_timeout_uninterruptible(1);
>  	}
>  
>  	/*


