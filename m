Return-Path: <linux-kernel+bounces-72189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CACE85B09B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EA01F22223
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BA15677F;
	Tue, 20 Feb 2024 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hxR8vxdP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907C5674F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708393510; cv=none; b=omltKYCgxOWKsa7t+0bxcXBu8G/S0ELD8P8szx7qU0YE1x8QkJzCkxNCbjjzbsfXLs2LLW210FbnX7Dn5L8eBwolRfD2YJAsasqDB9gtTLqZShtNcU9ByjpqkBKgL2MQag7wwImWoLZuoN2M4w/PDTGjt21KiEnAxw2G3y2ozgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708393510; c=relaxed/simple;
	bh=bH5h5ony5qUQ486pdiFhGnBGdeuVTtKFvRLLq+v8VYI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MnYPdw39hNYzG+0KJmzDKTUFfxuBlXM77oJSWT1ZLOFJJaJWJG4vWABFzT2z7FXLn73nDf38mBJcEUhm1OrYyZ+nwhrIgviveqMIzoRqffej5EoNoCfdC0Tbx7B7ka7PZ3+tDWUUK34sU+jb8Ix7t6vH3qMOqjh1Ih4AmcXzTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hxR8vxdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F097AC433F1;
	Tue, 20 Feb 2024 01:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708393509;
	bh=bH5h5ony5qUQ486pdiFhGnBGdeuVTtKFvRLLq+v8VYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hxR8vxdPW00n/OfLARc9/pKeR04gPBW96rZWwFbk2PzH0AhVwwSkqjVLakNemn0B5
	 9mBkpGKCsQvT1SPUYLnNk0HgfuzTsfB2Sv/oS51qMcX3D8fCbxkx+jDrH/vWHqLS97
	 QZNfNJ8+FXT1hwSnO3INDXKuGAAb6E7/OdrycdQA=
Date: Mon, 19 Feb 2024 17:45:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Byungchul Park <byungchul@sk.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH v4] sched/numa, mm: do not try to migrate memory to
 memoryless nodes
Message-Id: <20240219174508.bc6256248a163c3ab9a58369@linux-foundation.org>
In-Reply-To: <87o7ccrghz.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240219041920.1183-1-byungchul@sk.com>
	<87o7ccrghz.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 16:43:36 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> > +	/*
> > +	 * Cannot migrate to memoryless nodes.
> > +	 */
> > +	if (!node_state(dst_nid, N_MEMORY))
> > +		return false;
> > +
> >  	/*
> >  	 * The pages in slow memory node should be migrated according
> >  	 * to hot/cold instead of private/shared.
> 
> Good catch!
> 
> IIUC, you will use patch as fix to the issue in
> 
> https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/
> 
> If so, we need the Fixes: tag to make it land in -stable properly.

Yes, this changelog is missing rather a lot of important information.

I pulled together the below, please check.


From: Byungchul Park <byungchul@sk.com>
Subject: sched/numa, mm: do not try to migrate memory to memoryless nodes
Date: Mon, 19 Feb 2024 13:10:47 +0900

With numa balancing on, when a numa system is running where a numa node
doesn't have its local memory so it has no managed zones, the following
oops has been observed.  It's because wakeup_kswapd() is called with a
wrong zone index, -1.  Fixed it by checking the index before calling
wakeup_kswapd().

> BUG: unable to handle page fault for address: 00000000000033f3
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> Code: (omitted)
> RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
> ? __die
> ? page_fault_oops
> ? __pte_offset_map_lock
> ? exc_page_fault
> ? asm_exc_page_fault
> ? wakeup_kswapd
> migrate_misplaced_page
> __handle_mm_fault
> handle_mm_fault
> do_user_addr_fault
> exc_page_fault
> asm_exc_page_fault
> RIP: 0033:0x55b897ba0808
> Code: (omitted)
> RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
> RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
> RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
> RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
>  </TASK>

Fix this by avoiding any attempt to migrate memory to memoryless nodes.

Link: https://lkml.kernel.org/r/20240219041920.1183-1-byungchul@sk.com
Link: https://lkml.kernel.org/r/20240216111502.79759-1-byungchul@sk.com
Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")
Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Cc: Benjamin Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/sched/fair.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/sched/fair.c~sched-numa-mm-do-not-try-to-migrate-memory-to-memoryless-nodes
+++ a/kernel/sched/fair.c
@@ -1831,6 +1831,12 @@ bool should_numa_migrate_memory(struct t
 	int last_cpupid, this_cpupid;
 
 	/*
+	 * Cannot migrate to memoryless nodes.
+	 */
+	if (!node_state(dst_nid, N_MEMORY))
+		return false;
+
+	/*
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
 	 */
_


