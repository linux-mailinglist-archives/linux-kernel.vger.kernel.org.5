Return-Path: <linux-kernel+bounces-68072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC16C85759A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC522870DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96FA1401F;
	Fri, 16 Feb 2024 05:26:38 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940FB13FF5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708061198; cv=none; b=iAZC+f5b3/lDg9HL/mTj3V58B4ufjzx4VgqEx08PvxGqdqQaifXaIqKjHxi0JtoYM2uFL2qEc+C3WN4N0NxEKz691xvkNmLdhmTpppyIOApjkPtYDu/eKxgllB1Tl8jK3m1ntTPh03fjqfMcF87GYiLvzDlfUfho2bxSw4AHMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708061198; c=relaxed/simple;
	bh=BCGUs+XPqlsHMKywtVkBNYulrsfSierwkDKEjUULfzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6eSzuf3oMOrS+vxjC1mybfl0G8e2HXVcIVBecLUL9h5r/p4qaxYyyI9SHaJkBxKoLJkomSdj9C81mhsZKK3YxtWGsgyzesUM9hUGoaMvpVtQwJiwF4hXRUAtQplxDjqgZXz3/MGlMFLLss7tMwUff2YdR+1NQb+qrIIVPsPDBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-73-65cef2034c86
Date: Fri, 16 Feb 2024 14:26:22 +0900
From: Byungchul Park <byungchul@sk.com>
To: Phil Auld <pauld@redhat.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH] sched/numa, mm: do not promote folios to nodes not set
 N_MEMORY
Message-ID: <20240216052621.GA32626@system.software.com>
References: <20240214035355.18335-1-byungchul@sk.com>
 <20240214123137.GA70927@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214123137.GA70927@lorien.usersys.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LhesuzSJf507lUgwtnZS3mrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XlXXPYLO6t+c9qMfndM0aLSwcWMFmc2HuW0eJ47wEmi30dD5gs
	Oo58Y7bYevQ7uwOfx5p5axg9WvbdYvdYsKnUY/MKLY9Nnyaxe9y5tofN48SM3ywe7/ddZfPY
	fLra4/MmuQCuKC6blNSczLLUIn27BK6MQ78PsBf81qxoO3+aqYHxhGIXIyeHhICJxPMn71i7
	GDnA7L9LxUDCLAKqEg1P57GA2GwC6hI3bvxkBrFFBBQk3k3vYu9i5OJgFjjFJDHh8wV2kF5h
	gTCJv28UQGp4BSwk/n/cww5iCwlkScyacp4RIi4ocXLmE7CZzAJaEjf+vWQCaWUWkJZY/o8D
	JMwpYC8x7Vc/WImogLLEgW3HmUBWSQi0s0ss+zGBCeJkSYmDK26wTGAUmIVk7CwkY2chjF3A
	yLyKUSgzryw3MTPHRC+jMi+zQi85P3cTIzCWltX+id7B+OlC8CFGAQ5GJR7eA3/OpgqxJpYV
	V+YeYpTgYFYS4Z3UeyZViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQi
	mCwTB6dUA6PnpuomucLjDLfq2H/s/CZ69DiXZrvoQx79P/bnDFk3THS6w/4s+c/+g2md+9n+
	hZdGPzgg+4HhgfnuaOPPi8qWn2gWT53YwJ0zk/fuN3a+8pOpghkiG/bNVJF6Ldj8VPjR1rrP
	d7rnOXX+/afz/VdOmwzDTNHv6RPb/fa0y7C88+0y3VqoOFOJpTgj0VCLuag4EQAJH9QvoQIA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsXC5WfdrMv86VyqwcafAhZz1q9hs7j0+Cqb
	xfSXjSwWTydsZba42z+VxeLw3JOsFpd3zWGzuLfmP6vF5HfPGC0uHVjAZHFi71lGi+O9B5gs
	9nU8YLLoOPKN2WLr0e/sDvwea+atYfRo2XeL3WPBplKPzSu0PDZ9msTucefaHjaPEzN+s3i8
	33eVzWPxiw9MHptPV3t83iQXwB3FZZOSmpNZllqkb5fAlXHo9wH2gt+aFW3nTzM1MJ5Q7GLk
	4JAQMJH4u1Ssi5GTg0VAVaLh6TwWEJtNQF3ixo2fzCC2iICCxLvpXexdjFwczAKnmCQmfL7A
	DtIrLBAm8feNAkgNr4CFxP+Pe9hBbCGBLIlZU84zQsQFJU7OfAI2k1lAS+LGv5dMIK3MAtIS
	y/9xgIQ5Bewlpv3qBysRFVCWOLDtONMERt5ZSLpnIemehdC9gJF5FaNIZl5ZbmJmjqlecXZG
	ZV5mhV5yfu4mRmBkLKv9M3EH45fL7ocYBTgYlXh4D/w5myrEmlhWXJl7iFGCg1lJhHdS75lU
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBkZR9VPzRd6l
	CkUq/JrLfk9YS12MgS361cX/0qEsLL/5jj/jd7jyccn39yKWUTd3C4mUbgiZL3rRq9dU8rp5
	yS+vqowDQkcsDwsHP+uetzxu7p60nNvPP1zKWSwa+u/2hvtLm41ZKtkatj8NkVHM6vF4+a+H
	Z576sw3mnhvlNyyaw5oib978wleJpTgj0VCLuag4EQBti/rFiAIAAA==
X-CFilter-Loop: Reflected

On Wed, Feb 14, 2024 at 07:31:37AM -0500, Phil Auld wrote:
> Hi,
> 
> On Wed, Feb 14, 2024 at 12:53:55PM +0900 Byungchul Park wrote:
> > While running qemu with a configuration where some CPUs don't have their
> > local memory and with a kernel numa balancing on, the following oops has
> > been observed. It's because of null pointers of ->zone_pgdat of zones of
> > those nodes that are not initialized at booting time. So should avoid
> > nodes not set N_MEMORY from getting promoted.
> > 
> > > BUG: unable to handle page fault for address: 00000000000033f3
> > > #PF: supervisor read access in kernel mode
> > > #PF: error_code(0x0000) - not-present page
> > > PGD 0 P4D 0
> > > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > >    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> > > Code: (omitted)
> > > RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> > > RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> > > RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> > > R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> > > R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> > > FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > Call Trace:
> > >  <TASK>
> > > ? __die
> > > ? page_fault_oops
> > > ? __pte_offset_map_lock
> > > ? exc_page_fault
> > > ? asm_exc_page_fault
> > > ? wakeup_kswapd
> > > migrate_misplaced_page
> > > __handle_mm_fault
> > > handle_mm_fault
> > > do_user_addr_fault
> > > exc_page_fault
> > > asm_exc_page_fault
> > > RIP: 0033:0x55b897ba0808
> > > Code: (omitted)
> > > RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
> > > RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
> > > RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
> > > RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
> > > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> > > R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
> > >  </TASK>
> > > Modules linked in:
> > > CR2: 00000000000033f3
> > > ---[ end trace 0000000000000000  ]---
> > > RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> > > Code: (omitted)
> > > RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> > > RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> > > RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> > > R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> > > R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> > > FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > PKRU: 55555554
> > > note: masim[895] exited with irqs disabled
> 
> I think you could trim the down a little bit.

Thank you for the feedback. I will.

> > 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Reported-by: hyeongtak.ji@sk.com
> > ---
> >  kernel/sched/fair.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d7a3c63a2171..6d215cc85f14 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1828,6 +1828,23 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
> >  	int dst_nid = cpu_to_node(dst_cpu);
> >  	int last_cpupid, this_cpupid;
> >  
> > +	/*
> > +	 * A node of dst_nid might not have its local memory. Promoting
> > +	 * a folio to the node is meaningless. What's even worse, oops
> > +	 * can be observed by the null pointer of ->zone_pgdat in
> > +	 * various points of the code during migration.
> > +	 *
> 
> > +	 * For instance, oops has been observed at CPU2 while qemu'ing:
> > +	 *
> > +	 * {qemu} \
> > +	 *    -numa node,nodeid=0,mem=1G,cpus=0-1 \
> > +	 *    -numa node,nodeid=1,cpus=2-3 \
> > +	 *    -numa node,nodeid=2,mem=8G \
> > +	 *    ...
> 
> This part above should probably be in the commit message not in the code.
> The first paragraph of comment is plenty.

I will.

Thanks. I will respin it.

	Byungchul

> Otherwise, I think the check probably makes sense.
> 
> 
> Cheers,
> Phil
> 
> > +	 */
> > +	if (!node_state(dst_nid, N_MEMORY))
> > +		return false;
> > +
> >  	/*
> >  	 * The pages in slow memory node should be migrated according
> >  	 * to hot/cold instead of private/shared.
> > -- 
> > 2.17.1
> > 
> > 
> 
> -- 

