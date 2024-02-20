Return-Path: <linux-kernel+bounces-72192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5396C85B09F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7744D1C22466
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CC4597A;
	Tue, 20 Feb 2024 01:53:57 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE6C45942
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394037; cv=none; b=GwOG8m2Zd+Lgj0imUWvcBdwuNf3c1pY8BmBUSwOmtgtrWFjgcAXZVxVI2D0UL+sxwwk1qUYKumCn/RFeIFxGejaMfQaiktyW4vI2UpTDfEH5Hm4hld3rhlkkR1wKrT6/m7NfnCNuNoUAmFoNtwi2vETCw2QeOLMbSpArK9XEsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394037; c=relaxed/simple;
	bh=VJx61Ql+39p34/8mtX65G1+dN/14rOW4qxtGIhxrw8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgqA6iKv71fbYPoTs0qEoSAue5weehKpelZbzSlyyESbxVCJAdm5ajDPQwy4A6xwNBmnychj3kiRlSxjYcKS+nusx8rfXtYbWRvbj6yJqEdZSDw5xcJQmzD3YBJXbQ2AriB3MUaOo3OqsSUonOB5t3ozWIFlco4REAgqEtTzyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-63-65d4062c8186
Date: Tue, 20 Feb 2024 10:53:43 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: Re: [PATCH v4] sched/numa, mm: do not try to migrate memory to
 memoryless nodes
Message-ID: <20240220015343.GD65758@system.software.com>
References: <20240219041920.1183-1-byungchul@sk.com>
 <87o7ccrghz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240219174508.bc6256248a163c3ab9a58369@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219174508.bc6256248a163c3ab9a58369@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXC9ZZnoa4O25VUg/5HmhZz1q9hs7j0+Cqb
	xfSXjSwWTydsZba42z+VxeLyrjlsFvfW/Ge1mPzuGaPFpQMLmCyO9x5gstjX8YDJouPIN2aL
	rUe/s1ucnDWZxYHPY828NYweLftusXss2FTqsXmFlsfiPS+ZPDZ9msTucefaHjaPEzN+s3i8
	33eVzWPz6WqPz5vkArijuGxSUnMyy1KL9O0SuDJe9cYUXNGsOLjqBUsD41ylLkYODgkBE4nv
	jZFdjJxgZnfvN1YQm0VAVeL4q/VsIDabgLrEjRs/mUFsEQFdiVXPd4HZzALXmSSu/ysEsYUF
	oiRmLPnCCGLzClhInH92E6iXi0NIYCWjxMUTW9khEoISJ2c+YYFo1pK48e8lE8gNzALSEsv/
	cYCEOQW8Jd6degc2X1RAWeLAtuNMIHMkBNrZJbY3tbFCHCopcXDFDZYJjAKzkIydhWTsLISx
	CxiZVzEKZeaV5SZm5pjoZVTmZVboJefnbmIERtWy2j/ROxg/XQg+xCjAwajEw/sg7nKqEGti
	WXFl7iFGCQ5mJRFe96YLqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphak
	FsFkmTg4pRoYy8x5PqgxW+WZaCl/3vaJT/TevvlfDuV/teqw0rhb9im3lXli585w8cbFU5uK
	jxdE7phie2fCtDe/nNe2P3igujig0kfx8Q8mWQE3n2RLz73ZBznPXRZabZyq1LfZsyex7/qO
	6m99nPtW9d/N4LqgdH1a67ro303/cnu3GHMqsE/7s6H8QKGVEktxRqKhFnNRcSIASgL1b6YC
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsXC5WfdrKvDdiXV4P4/aYs569ewWVx6fJXN
	YvrLRhaLpxO2Mlvc7Z/KYnF47klWi8u75rBZ3Fvzn9Vi8rtnjBaXDixgsjjee4DJYl/HAyaL
	jiPfmC22Hv3ObnFy1mQWB36PNfPWMHq07LvF7rFgU6nH5hVaHov3vGTy2PRpErvHnWt72DxO
	zPjN4vF+31U2j8UvPjB5bD5d7fF5k1wATxSXTUpqTmZZapG+XQJXxqvemIIrmhUHV71gaWCc
	q9TFyMkhIWAi0d37jRXEZhFQlTj+aj0biM0moC5x48ZPZhBbREBXYtXzXWA2s8B1Jonr/wpB
	bGGBKIkZS74wgti8AhYS55/dBOrl4hASWMkocfHEVnaIhKDEyZlPWCCatSRu/HvJ1MXIAWRL
	Syz/xwES5hTwlnh36h3YfFEBZYkD244zTWDknYWkexaS7lkI3QsYmVcximTmleUmZuaY6hVn
	Z1TmZVboJefnbmIERsmy2j8TdzB+uex+iFGAg1GJh/dB3OVUIdbEsuLK3EOMEhzMSiK87k0X
	UoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYlZUl2Spb
	ObfP4eQJWyfmdnJv2PaN82dtnvtu4dd26RPSzoJWU1jsL2xtPMg88WU1k5HzgqmHLyqkp6tq
	7A0t57+qGMSzWPQNW7GcTZHa5ut2lqoMn9Q4FtilXNZte/Mxzl9zJsOlf9F/Jx5721E001uY
	S0SSWUDN7fbsW8Ya138I3XnRWxCnxFKckWioxVxUnAgAxiV0yo4CAAA=
X-CFilter-Loop: Reflected

On Mon, Feb 19, 2024 at 05:45:08PM -0800, Andrew Morton wrote:
> On Mon, 19 Feb 2024 16:43:36 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
> 
> > > +	/*
> > > +	 * Cannot migrate to memoryless nodes.
> > > +	 */
> > > +	if (!node_state(dst_nid, N_MEMORY))
> > > +		return false;
> > > +
> > >  	/*
> > >  	 * The pages in slow memory node should be migrated according
> > >  	 * to hot/cold instead of private/shared.
> > 
> > Good catch!
> > 
> > IIUC, you will use patch as fix to the issue in
> > 
> > https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/
> > 
> > If so, we need the Fixes: tag to make it land in -stable properly.
> 
> Yes, this changelog is missing rather a lot of important information.

This is not the root cause fix any more but just optimization. That's
why I didn't add Fixes: tag and cc stable@vger.kernel.org in here.

Instead, I added Fixes: tag and cc'ed stable@vger.kernel.org in the real
fix patch. check the following link please:

https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/

	Byungchul

> I pulled together the below, please check.
> 
> 
> From: Byungchul Park <byungchul@sk.com>
> Subject: sched/numa, mm: do not try to migrate memory to memoryless nodes
> Date: Mon, 19 Feb 2024 13:10:47 +0900
> 
> With numa balancing on, when a numa system is running where a numa node
> doesn't have its local memory so it has no managed zones, the following
> oops has been observed.  It's because wakeup_kswapd() is called with a
> wrong zone index, -1.  Fixed it by checking the index before calling
> wakeup_kswapd().
> 
> > BUG: unable to handle page fault for address: 00000000000033f3
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> > Code: (omitted)
> > RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> > RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> > RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> > R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> > R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> > FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> > ? __die
> > ? page_fault_oops
> > ? __pte_offset_map_lock
> > ? exc_page_fault
> > ? asm_exc_page_fault
> > ? wakeup_kswapd
> > migrate_misplaced_page
> > __handle_mm_fault
> > handle_mm_fault
> > do_user_addr_fault
> > exc_page_fault
> > asm_exc_page_fault
> > RIP: 0033:0x55b897ba0808
> > Code: (omitted)
> > RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
> > RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
> > RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
> > RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
> > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> > R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
> >  </TASK>
> 
> Fix this by avoiding any attempt to migrate memory to memoryless nodes.
> 
> Link: https://lkml.kernel.org/r/20240219041920.1183-1-byungchul@sk.com
> Link: https://lkml.kernel.org/r/20240216111502.79759-1-byungchul@sk.com
> Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Cc: Benjamin Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  kernel/sched/fair.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/kernel/sched/fair.c~sched-numa-mm-do-not-try-to-migrate-memory-to-memoryless-nodes
> +++ a/kernel/sched/fair.c
> @@ -1831,6 +1831,12 @@ bool should_numa_migrate_memory(struct t
>  	int last_cpupid, this_cpupid;
>  
>  	/*
> +	 * Cannot migrate to memoryless nodes.
> +	 */
> +	if (!node_state(dst_nid, N_MEMORY))
> +		return false;
> +
> +	/*
>  	 * The pages in slow memory node should be migrated according
>  	 * to hot/cold instead of private/shared.
>  	 */
> _

