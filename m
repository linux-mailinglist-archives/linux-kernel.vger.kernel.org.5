Return-Path: <linux-kernel+bounces-68315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B94985789C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FCE2822BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF651B952;
	Fri, 16 Feb 2024 09:14:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B21B941
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074843; cv=none; b=L3YIedlmJlFFFj7mqX4Sl+jPehVc81OqMQg/ZoMG8xPBDN+aN3rySqpUjyb0zawXfiWaLNI5GKFpMHVcDjZwS4mIl7WbeRDlTRNIIZ6rlP3AYZGazDGdPq5OEl6SDNtbx0o0CmJc3CUR9INwUYAK5MsJ4a3cf1KJ6ub6Uca8TIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074843; c=relaxed/simple;
	bh=wHL0yfZgtZwRPPxfhL88OC4Gpb6zU/CR4h2X12Ou9/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnF34gz8YuyDS0jbvt7dNuriRtVu6JqeyfohuqUm9n8Dfe9vv91gKgbx7Cp4qWqG5BrO6gIOdh0dp/0QY24t5dfLaFOKg4NQvdv+GJnwEEDjPjZtVMKcmyTjbPBAbWc6xU01kOxdCCmJcplW/Y+gOpb8LLHReI2XCFeHssOwMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-a1-65cf275412ba
Date: Fri, 16 Feb 2024 18:13:51 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2] sched/numa, mm: do not promote folios to nodes not
 set N_MEMORY
Message-ID: <20240216091351.GB75176@system.software.com>
References: <20240216073340.55404-1-byungchul@sk.com>
 <b7fa4eb9-2659-4766-b8da-d6281f34a4ee@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7fa4eb9-2659-4766-b8da-d6281f34a4ee@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LhesuzSDdE/Xyqwf17ahZz1q9hs7j0+Cqb
	xfSXjSwWX9f/YrZ4OmErs8Xd/qksFpd3zWGzuLfmP6vF5HfPGC0uHVjAZHG89wCTxb6OB0wW
	HUe+MVtsPfqd3YHPY828NYweLftusXss2FTqsXmFlsemT5PYPe5c28PmcWLGbxaP9/uusnls
	Pl3t8XmTXABXFJdNSmpOZllqkb5dAlfG9HkHmQrOSFbsOPCKsYHxkkgXIweHhICJxLFFXl2M
	nGBm98qdLCA2i4CqxJK/N8BsNgF1iRs3fjKD2CICGhKb2jYA2VwczAKnmCQmfL7ADpIQFoiU
	eDa/mRHE5hWwkFhz4yBYs5BApkTr5AZWiLigxMmZT8DizAJaEjf+vWQCuYFZQFpi+T8OkDCn
	gJ3EgxsrwcpFBZQlDmw7zgSyS0KgmV1i1qzF7BCHSkocXHGDZQKjwCwkY2chGTsLYewCRuZV
	jEKZeWW5iZk5JnoZlXmZFXrJ+bmbGIHRtKz2T/QOxk8Xgg8xCnAwKvHwHvhzNlWINbGsuDL3
	EKMEB7OSCO+k3jOpQrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZ
	ODilGhjZ5O7uyf9/8Pz2tXN/vbiedeta52/++9IXp0xcJ3r6Qd2MDyvvST5ld/6j+uaL8j++
	rTnShy3dZCx2d/Puv9qSq6dz+oP6/GCzp7xe237sL3x5Zemm26ynV7u4fCi5ybjur66l3PFf
	zYcsehcxChqqR8ZnhdUutK1yLeGZOF3Q6wLzh22pIoFTlFiKMxINtZiLihMBeDkdbaICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsXC5WfdrBuifj7VYPkuYYs569ewWVx6fJXN
	YvrLRhaLr+t/MVs8nbCV2eJu/1QWi8NzT7JaXN41h83i3pr/rBaT3z1jtLh0YAGTxfHeA0wW
	+zoeMFl0HPnGbLH16Hd2B36PNfPWMHq07LvF7rFgU6nH5hVaHps+TWL3uHNtD5vHiRm/WTze
	77vK5rH4xQcmj82nqz0+b5IL4I7isklJzcksSy3St0vgypg+7yBTwRnJih0HXjE2MF4S6WLk
	5JAQMJHoXrmTBcRmEVCVWPL3BpjNJqAucePGT2YQW0RAQ2JT2wYgm4uDWeAUk8SEzxfYQRLC
	ApESz+Y3M4LYvAIWEmtuHARrFhLIlGid3MAKEReUODnzCVicWUBL4sa/l0xdjBxAtrTE8n8c
	IGFOATuJBzdWgpWLCihLHNh2nGkCI+8sJN2zkHTPQuhewMi8ilEkM68sNzEzx1SvODujMi+z
	Qi85P3cTIzA6ltX+mbiD8ctl90OMAhyMSjy8B/6cTRViTSwrrsw9xCjBwawkwjup90yqEG9K
	YmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+PT+iVai1dqn5+/
	rMr50OfXf5ZWfxL5uD2+Rt9d0aJcxUJunpPp2VseO0TPu559za4Vfb3VoHXqlltLzsxzaqt1
	6fjsKXDq2Osjwl9SnKTV3C6s5k2P0m6asNLig2RH3alTURazPB/vVpZ1eDGjvXfHz7kinP8f
	5hZdXTvzm30sP/MOs5Ws6W5KLMUZiYZazEXFiQDQaJh4igIAAA==
X-CFilter-Loop: Reflected

On Fri, Feb 16, 2024 at 10:07:53AM +0100, David Hildenbrand wrote:
> On 16.02.24 08:33, Byungchul Park wrote:
> > Changes from v1:
> > 	1. Trim the verbose oops in the commit message. (feedbacked by
> > 	   Phil Auld)
> > 	2. Rewrite a comment in code. (feedbacked by Phil Auld)
> > 
> > --->8---
> >  From 6830b59db267a31b78f6f09af12ae0e3132b4bca Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Fri, 16 Feb 2024 16:26:23 +0900
> > Subject: [PATCH v2] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
> > 
> > While running qemu with a configuration where some CPUs don't have their
> > local memory and with a kernel numa balancing on, the following oops has
> > been observed. It's because of null pointers of ->zone_pgdat of zones of
> > those nodes that are not initialized properly at booting time. So should
> > avoid nodes not set N_MEMORY from getting promoted.
> > 
> > > BUG: unable to handle page fault for address: 00000000000033f3
> > > #PF: supervisor read access in kernel mode
> > > #PF: error_code(0x0000) - not-present page
> > > PGD 0 P4D 0
> > > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > >     rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
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
> > >   <TASK>
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
> > >   </TASK>
> > 
> 
> This sounds like we need a Fixes: and want to CC stable?

Sure. I will CC stable at the next spin - might need to rewrite the
reason.

	Byungchul

> -- 
> Cheers,
> 
> David / dhildenb

