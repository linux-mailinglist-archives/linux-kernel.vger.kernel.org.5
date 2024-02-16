Return-Path: <linux-kernel+bounces-68185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360018576F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE12928291B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8017BCE;
	Fri, 16 Feb 2024 07:46:08 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF03F17BBB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069567; cv=none; b=NyapTieDZ1N0lMjwUivYfu/D+N9y0ZVzHBgJuULdKM2nlMeX0x0WFV8vgdUuUK2TH3FEkbNsZeTpMVfLK8WYvDgbsmy+RxriaC3L0bGxFGjjBcx/8iaGfhdzZ8accaBzHZkIEBEYvQeP7fG0GreMngeg6lgxug6Jip8g+g8LFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069567; c=relaxed/simple;
	bh=qxi68lyOJMjik5eJnJg22N7ge48TRtALAJKarbJRt28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kos63eomcd4MZxSsiafbAGQH/O5CkBSYwx+EwJcilZfYQq31cQvkmemnQUgMIbWc26yOuY7R5uZ7C6AyTNWvSQ+WrbbM9+Fxy2+wqT1We0ayHWy5WO2OwQHNNjEje9F9zsdVNe/mwBlFLyrgr34hEiGy3oS7nS1uicNT65U+W18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-62-65cf12b5bc6e
Date: Fri, 16 Feb 2024 16:45:51 +0900
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
Message-ID: <20240216074551.GD32626@system.software.com>
References: <20240214035355.18335-1-byungchul@sk.com>
 <20240214123137.GA70927@lorien.usersys.redhat.com>
 <20240214200318.GA74174@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214200318.GA74174@lorien.usersys.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LhesuzSHer0PlUg4f9AhZz1q9hs7j0+Cqb
	xfSXjSwWTydsZba42z+VxeLyrjlsFvfW/Ge1mPzuGaPFpQMLmCxO7D3LaHG89wCTxb6OB0wW
	HUe+MVtsPfqd3YHPY828NYweLftusXss2FTqsXmFlsemT5PYPe5c28PmcWLGbxaP9/uusnls
	Pl3t8XmTXABXFJdNSmpOZllqkb5dAlfGtlUrWQrmGlQcvr6BsYHxnWoXIweHhICJxIpuSRjz
	xk/xLkZODhYBVYk7e1sYQWw2AXWJGzd+MoPYIgIKEu+md7F3MXJxMAucYpKY8PkCO0ivsECY
	xN83CiA1vAIWEr1//jCC1AgJzGeUuHRpMyNEQlDi5MwnLCA2s4CWxI1/L5lAepkFpCWW/+MA
	CXMK2Et0P7/FBGKLCihLHNh2nAlkjoRAO7vEol+dYHMkBCQlDq64wTKBUWAWkrGzkIydhTB2
	ASPzKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAWFpW+yd6B+OnC8GHGAU4GJV4eA/8OZsqxJpY
	VlyZe4hRgoNZSYR3Uu+ZVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtS
	i2CyTBycUg2MYuqabcGKxb1yTzZMO9O583b3qu3PHJoF1Bd9Z3LiYi9cF/zd7cUTbrlXN25l
	HGSfsWKdxIW4ByEb9CZOjFp1SpBDRnOxTomIEkPWXqfnvkF7Db4FeRkGt6/ebuqziatLrY49
	ecOhOaf4lPdJv0ya9CHmgqzJ9AWrNirXTLScqbvrh/KuCcVvlViKMxINtZiLihMBQVHqGqEC
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsXC5WfdrLtF6Hyqwe8XNhZz1q9hs7j0+Cqb
	xfSXjSwWTydsZba42z+VxeLw3JOsFpd3zWGzuLfmP6vF5HfPGC0uHVjAZHFi71lGi+O9B5gs
	9nU8YLLoOPKN2WLr0e/sDvwea+atYfRo2XeL3WPBplKPzSu0PDZ9msTucefaHjaPEzN+s3i8
	33eVzWPxiw9MHptPV3t83iQXwB3FZZOSmpNZllqkb5fAlbFt1UqWgrkGFYevb2BsYHyn2sXI
	wSEhYCJx46d4FyMnB4uAqsSdvS2MIDabgLrEjRs/mUFsEQEFiXfTu9i7GLk4mAVOMUlM+HyB
	HaRXWCBM4u8bBZAaXgELid4/fxhBaoQE5jNKXLq0mREiIShxcuYTFhCbWUBL4sa/l0wgvcwC
	0hLL/3GAhDkF7CW6n99iArFFBZQlDmw7zjSBkXcWku5ZSLpnIXQvYGRexSiSmVeWm5iZY6pX
	nJ1RmZdZoZecn7uJERgby2r/TNzB+OWy+yFGAQ5GJR7eA3/OpgqxJpYVV+YeYpTgYFYS4Z3U
	eyZViDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgfFUipif
	dEhtxu1palscp3CIfQo0n5OZfKJk2aIrEZ5BbQHpi7xnCDPlMSzd8S5+5drnnWZKqTsZdsjq
	plge0rn28KzZasWiSoFdjMWcss0Skkp382Ye875rYLDhhdbOhkfqvQ3LbEplUm8nJltM6VuU
	+vwvn8HZEuW7jwukxbiuCPIeTQ/do8RSnJFoqMVcVJwIAK76GJCJAgAA
X-CFilter-Loop: Reflected

On Wed, Feb 14, 2024 at 03:03:18PM -0500, Phil Auld wrote:
> On Wed, Feb 14, 2024 at 07:31:37AM -0500 Phil Auld wrote:
> > Hi,
> > 
> > On Wed, Feb 14, 2024 at 12:53:55PM +0900 Byungchul Park wrote:
> > > While running qemu with a configuration where some CPUs don't have their
> > > local memory and with a kernel numa balancing on, the following oops has
> > > been observed. It's because of null pointers of ->zone_pgdat of zones of
> > > those nodes that are not initialized at booting time. So should avoid
> > > nodes not set N_MEMORY from getting promoted.
> > > 
> > > > BUG: unable to handle page fault for address: 00000000000033f3
> > > > #PF: supervisor read access in kernel mode
> > > > #PF: error_code(0x0000) - not-present page
> > > > PGD 0 P4D 0
> > > > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > > CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > >    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > > RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> > > > Code: (omitted)
> > > > RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> > > > RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> > > > RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> > > > R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> > > > R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> > > > FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > PKRU: 55555554
> > > > Call Trace:
> > > >  <TASK>
> > > > ? __die
> > > > ? page_fault_oops
> > > > ? __pte_offset_map_lock
> > > > ? exc_page_fault
> > > > ? asm_exc_page_fault
> > > > ? wakeup_kswapd
> > > > migrate_misplaced_page
> > > > __handle_mm_fault
> > > > handle_mm_fault
> > > > do_user_addr_fault
> > > > exc_page_fault
> > > > asm_exc_page_fault
> > > > RIP: 0033:0x55b897ba0808
> > > > Code: (omitted)
> > > > RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
> > > > RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
> > > > RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
> > > > RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
> > > > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> > > > R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
> > > >  </TASK>
> > > > Modules linked in:
> > > > CR2: 00000000000033f3
> > > > ---[ end trace 0000000000000000  ]---
> > > > RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> > > > Code: (omitted)
> > > > RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> > > > RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> > > > RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> > > > R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> > > > R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> > > > FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > PKRU: 55555554
> > > > note: masim[895] exited with irqs disabled
> > 
> > I think you could trim the down a little bit.
> > 
> > 
> > > 
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > Reported-by: hyeongtak.ji@sk.com
> > > ---
> > >  kernel/sched/fair.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d7a3c63a2171..6d215cc85f14 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -1828,6 +1828,23 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
> > >  	int dst_nid = cpu_to_node(dst_cpu);
> > >  	int last_cpupid, this_cpupid;
> > >  
> > > +	/*
> > > +	 * A node of dst_nid might not have its local memory. Promoting
> > > +	 * a folio to the node is meaningless. What's even worse, oops
> > > +	 * can be observed by the null pointer of ->zone_pgdat in
> > > +	 * various points of the code during migration.
> > > +	 *
> > 
> > > +	 * For instance, oops has been observed at CPU2 while qemu'ing:
> > > +	 *
> > > +	 * {qemu} \
> > > +	 *    -numa node,nodeid=0,mem=1G,cpus=0-1 \
> > > +	 *    -numa node,nodeid=1,cpus=2-3 \
> > > +	 *    -numa node,nodeid=2,mem=8G \
> > > +	 *    ...
> > 
> > This part above should probably be in the commit message not in the code.
> > The first paragraph of comment is plenty.
> > 
> > Otherwise, I think the check probably makes sense.
> >
> 
> Actually, after looking at the memory.c code I wonder if this check should
> not be made farther up in the numa migrate machinery.

First of all, we cannot avoid hinting fault. It's because no one knows
which node a task eventually runs on until a hinting fault occurs. So
should let it go get hinting fault *and then* we can make the decision
if we can migrate the folio or not. Assuming that, IMHO,
should_numa_migrate_memory() is a good place to make it.

Thoughts? Am I missing something?

	Byungchul

> Cheers,
> Phil
> 
> > 
> > Cheers,
> > Phil
> > 
> > > +	 */
> > > +	if (!node_state(dst_nid, N_MEMORY))
> > > +		return false;
> > > +
> > >  	/*
> > >  	 * The pages in slow memory node should be migrated according
> > >  	 * to hot/cold instead of private/shared.
> > > -- 
> > > 2.17.1
> > > 
> > > 
> > 
> > -- 
> > 
> > 
> 
> -- 

