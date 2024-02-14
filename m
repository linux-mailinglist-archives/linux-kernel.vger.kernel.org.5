Return-Path: <linux-kernel+bounces-65911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBFD85539D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACCC1C22F16
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF113DB8F;
	Wed, 14 Feb 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2DS/huq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B31292D4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941029; cv=none; b=pU2zWrek9VIp66Y/aj9+u4796LoVtwjwbk1W/q5PqHBUpwKfOyE79eJO54nC8UDh99HmrkieRGEHaSI8uEV/mzs6pRCwHa3PF7q83o6Sw5LfH1obdjqJnlFmLCF+R55JkbG2rni+I9bblDlx66DihuyPK7WCWhMhtKMSY4wnlZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941029; c=relaxed/simple;
	bh=jZLBXQKQLglga9662VyENxHMEUWgFFV3sLEJL7yFSRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAbsxZhrVdaqGPJWKaX1msr5M/A0Uuv/7sOgwvJFVU5wWejLaJ9jMobpYWQuc0O/+nERMuIPkHNlhhRkXYCYD4DORuA7Ot7IzuaeSIMrsA/OTRemOwYTm65cH0w/ovevZR5tWb8oFNCng3Hg6qgdaKEStsmu3FIN1LIjlLNDWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2DS/huq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707941026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CLxhbccijdLbqEHOPRIA/Ab924uWKmLPLU2fxFN5Ws=;
	b=D2DS/huqNzAUEyGmE5WnB8T5tjK/heR5ajl527KZMc37BMPWgcoCkk34kzjfOUwM7N6JEw
	A6DnPLDLZJ0Bn/dCCIMWmKCMtx+qVIUT1Cto6yRbBbV8O4l2BUFWgePJBbLOrrDD8hCWEM
	xlk9IybkKU5o7Qtr1sTjt2GPQsWzR/g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-UE3PNMBuOli5idaLMadW9Q-1; Wed,
 14 Feb 2024 15:03:40 -0500
X-MC-Unique: UE3PNMBuOli5idaLMadW9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA0A43C23FCF;
	Wed, 14 Feb 2024 20:03:29 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.192.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D29F640CD14A;
	Wed, 14 Feb 2024 20:03:22 +0000 (UTC)
Date: Wed, 14 Feb 2024 15:03:18 -0500
From: Phil Auld <pauld@redhat.com>
To: Byungchul Park <byungchul@sk.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH] sched/numa, mm: do not promote folios to nodes not set
 N_MEMORY
Message-ID: <20240214200318.GA74174@lorien.usersys.redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Feb 14, 2024 at 07:31:37AM -0500 Phil Auld wrote:
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
> 
> 
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
> 
> Otherwise, I think the check probably makes sense.
>

Actually, after looking at the memory.c code I wonder if this check should
not be made farther up in the numa migrate machinery.


Cheers,
Phil

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
> 
> 

-- 


