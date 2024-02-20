Return-Path: <linux-kernel+bounces-72200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0982585B0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20DB1F2180F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1F13A8F7;
	Tue, 20 Feb 2024 02:08:08 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E188465
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394887; cv=none; b=osvM6i4X9PzDq4OwVfbmfWNezAtAxVHLhc+liq5sCrBhV7Vzo9mWue8hTBJRd4E5ibPIcuEPLZkiJ73Aiz8aYX75oboFe47AxFoF0C4QT6MiNDuPISeUy44inCRl1LmtqP2rGGGUFm6Py3mRV0fZcToKXiR53lGhhTqd4bNVuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394887; c=relaxed/simple;
	bh=APJfew27VQ0v3mk16aVpKGackeZkEcMk0nMGzmDw30A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYrh6N4r9GOEb46IMH+zZaax+79GtCjmt3Gqk2b0Cs+WVwVoLEGEFtyP3KcH8UQWq4WpMkZZp4jaBv0nwvNh7ZjAl2ZsyeufKXfPREhSmTCCU6S8h5yFozYS8YsgNYxZC9ZR1XywnhXu+DI/DGVUW/6cq6zooBZCPI7RpCv9Sq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-96-65d40980b13f
Date: Tue, 20 Feb 2024 11:07:55 +0900
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
Message-ID: <20240220020755.GE65758@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsXC9ZZnkW4D55VUg/M7tS3mrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XlXXPYLO6t+c9qMfndM0aLSwcWMFkc7z3AZLGv4wGTRceRb8wW
	W49+Z7c4OWsyiwOfx5p5axg9WvbdYvdYsKnUY/MKLY/Fe14yeWz6NInd4861PWweJ2b8ZvF4
	v+8qm8fm09UenzfJBXBHcdmkpOZklqUW6dslcGUc+zmVvWC9RsXE5p/MDYwTFLsYOTkkBEwk
	bsz9zQJjNzROAbNZBFQlvs6dzgpiswmoS9y48ZMZxBYR0JVY9XwXmM0scJ1J4vq/QhBbWCBK
	YsaSL4wgNq+AhcS7b6fYuxi5OIQEVjJKXDyxlR0iIShxcuYTFohmLYkb/14ydTFyANnSEsv/
	cYCEOQW8Jd6degc2X1RAWeLAtuNMIHMkBLrZJaZ27IE6VFLi4IobLBMYBWYhGTsLydhZCGMX
	MDKvYhTKzCvLTczMMdHLqMzLrNBLzs/dxAiMrGW1f6J3MH66EHyIUYCDUYmH90Hc5VQh1sSy
	4srcQ4wSHMxKIrzuTRdShXhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgt
	gskycXBKNTD2TOrmO3Hl2+lZOvxcj2wtnn86nPjwate3rlvtiW1lcncX9tVFsHWtrauWKrg9
	Xfx0qsami9UnZ6jdsXarKnZaJ3bTcsFUw28fvZsie6+fOdb1guGq9rkrT79sD3nTuVAnup69
	y+dyWTrnmwiR319krPWOv86+tr3X/vJnhs6dytPiQxLrfnoosRRnJBpqMRcVJwIAILNVLqgC
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsXC5WfdrNvAeSXVYM8aBYs569ewWVx6fJXN
	YvrLRhaLpxO2Mlvc7Z/KYnF47klWi8u75rBZ3Fvzn9Vi8rtnjBaXDixgsjjee4DJYl/HAyaL
	jiPfmC22Hv3ObnFy1mQWB36PNfPWMHq07LvF7rFgU6nH5hVaHov3vGTy2PRpErvHnWt72DxO
	zPjN4vF+31U2j8UvPjB5bD5d7fF5k1wATxSXTUpqTmZZapG+XQJXxrGfU9kL1mtUTGz+ydzA
	OEGxi5GTQ0LARKKhcQoLiM0ioCrxde50VhCbTUBd4saNn8wgtoiArsSq57vAbGaB60wS1/8V
	gtjCAlESM5Z8YQSxeQUsJN59O8XexcjFISSwklHi4omt7BAJQYmTM5+wQDRrSdz495Kpi5ED
	yJaWWP6PAyTMKeAt8e7UO7D5ogLKEge2HWeawMg7C0n3LCTdsxC6FzAyr2IUycwry03MzDHV
	K87OqMzLrNBLzs/dxAiMk2W1fybuYPxy2f0QowAHoxIP74O4y6lCrIllxZW5hxglOJiVRHjd
	my6kCvGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTD6Xe9c
	kWIT0zuzz3O1bpGrKluMwfuoG75zUyxdfp/1u2h1RGfj8f176tSWCapPvmATmXtcJ2RmjnyW
	KO9myU97K3y9lnP8/vkm74qV+4cGub+L17/95nng8Be/xSlVfJfyrnCer9jfJn/3X5NG2L+i
	+8HvH918Fen+imOWHPch0W/NtyTSvFOUWIozEg21mIuKEwE9GqczjwIAAA==
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
> 
> I pulled together the below, please check.

Plus, two guys gave the tags for the optimization patch as well:

   Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
   Acked-by: David Hildenbrand <david@redhat.com>

	Byungchul

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

