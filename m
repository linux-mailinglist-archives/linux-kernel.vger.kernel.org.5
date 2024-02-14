Return-Path: <linux-kernel+bounces-64717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27178541E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9A5289C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B8BA38;
	Wed, 14 Feb 2024 03:54:21 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB711BA22
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707882861; cv=none; b=g08IhMzWGy7nQOTExP5Fy6d55hzteSXfN3mzmOVkxrshA6T8esH6n5/6YakjrpQ4KP4p2gChJ9O7oHVgPuDx5AEq2ylGXqGkwgo8SWzl6raQwIlXPPMDicjWNQs5XAv98E8PtXgjRvqiO3+964j5KhuBo9Uui2Xm4CeIqFXoP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707882861; c=relaxed/simple;
	bh=FrIuJZ5FwLSqA+IuFZPm9PO3C2DWtjfmjjxrAGW4qNw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RiYeSVgMfsdievGQmKv+nJ9MbNPz7tMZDonKh+Aw5QmQdsstBpNZQBQuFdk55i7oLwLu4fJcM0pdG+P85OihQSfxor6dUW8HV+/CHGQuShuY+XpBGoEYTmFcIS3zbEyZBkDEbTQZCVWZ/9nbpv3R4F3nEIRyVbNON56qnloTjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-ae-65cc395d8c12
From: Byungchul Park <byungchul@sk.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	akpm@linux-foundation.org
Subject: [PATCH] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
Date: Wed, 14 Feb 2024 12:53:55 +0900
Message-Id: <20240214035355.18335-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsXC9ZZnoW6c5ZlUg3N/WCzmrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XlXXPYLO6t+c9qMfndM0aLSwcWMFkc7z3AZLGv4wGTRceRb8wW
	W49+Z3fg9Vgzbw2jR8u+W+weCzaVemxeoeWx6dMkdo871/aweZyY8ZvF4/2+q2wem09Xe3ze
	JBfAFcVlk5Kak1mWWqRvl8CV8fbGOtaCE0oVp1riGxj/yHQxcnBICJhILF6Q2MXICWbumLee
	BcRmE1CXuHHjJ3MXIxeHiMAbRonOZWfYQBLMAnkSrf/7mEBsYYEAic33r4A1sAioSpzcvJwR
	xOYVMJWY0bKKFWKovMTqDQfABkkIrGGTOPz2B1RCUuLgihssExi5FzAyrGIUyswry03MzDHR
	y6jMy6zQS87P3cQIDMJltX+idzB+uhB8iFGAg1GJh/dEwulUIdbEsuLK3EOMEhzMSiK8l2ac
	SBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAGNP3P+gG
	I3tl6mJpGcM9h2YvDruk9zlkhrL2or/79BtiL6RoVekd/sX/PrCxyvHEwcbTX3zY8uYJljJO
	XJLUf6OlI3nu/WzZnoXLLtY84vl858db/jV6bXmZuZsEBG+EP0iNKp/DO8FnmqG0D//9zCbn
	kwt3T2Aocjun3vtulUWiZ858viUVSizFGYmGWsxFxYkA/IN2JD4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsXC5WfdrBtreSbVoPOGicWc9WvYLC49vspm
	Mf1lI4vF0wlbmS3u9k9lsTg89ySrxeVdc9gs7q35z2ox+d0zRotLBxYwWRzvPcBksa/jAZNF
	x5FvzBZbj35nd+DzWDNvDaNHy75b7B4LNpV6bF6h5bHp0yR2jzvX9rB5nJjxm8Xj/b6rbB6L
	X3xg8th8utrj8ya5AO4oLpuU1JzMstQifbsEroy3N9axFpxQqjjVEt/A+Eemi5GTQ0LARGLH
	vPUsIDabgLrEjRs/mbsYuThEBN4wSnQuO8MGkmAWyJNo/d/HBGILCwRIbL5/BayBRUBV4uTm
	5YwgNq+AqcSMllWsEEPlJVZvOMA8gZFjASPDKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMCg
	Wlb7Z+IOxi+X3Q8xCnAwKvHwnkg4nSrEmlhWXJl7iFGCg1lJhPfSjBOpQrwpiZVVqUX58UWl
	OanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYz+B34vkI58+f+zIzP7jbsTlO4b
	bT16cbs/e3mwvGZKbIrAVamm6QsZ+jiXvpPmXmKcfePdgctVBRd0Bby6Jxcc/fTOk0XyhInM
	Thf/j3tvCfkEbD8de5nXUrhOfvnqtarTQvc5qFsEKD3WClh+62nWnbmOTHatYf8/CJz+xv7v
	67YTJmf01J8qsRRnJBpqMRcVJwIA2sikGiYCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

While running qemu with a configuration where some CPUs don't have their
local memory and with a kernel numa balancing on, the following oops has
been observed. It's because of null pointers of ->zone_pgdat of zones of
those nodes that are not initialized at booting time. So should avoid
nodes not set N_MEMORY from getting promoted.

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
> Modules linked in:
> CR2: 00000000000033f3
> ---[ end trace 0000000000000000  ]---
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
> note: masim[895] exited with irqs disabled

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reported-by: hyeongtak.ji@sk.com
---
 kernel/sched/fair.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..6d215cc85f14 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1828,6 +1828,23 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	/*
+	 * A node of dst_nid might not have its local memory. Promoting
+	 * a folio to the node is meaningless. What's even worse, oops
+	 * can be observed by the null pointer of ->zone_pgdat in
+	 * various points of the code during migration.
+	 *
+	 * For instance, oops has been observed at CPU2 while qemu'ing:
+	 *
+	 * {qemu} \
+	 *    -numa node,nodeid=0,mem=1G,cpus=0-1 \
+	 *    -numa node,nodeid=1,cpus=2-3 \
+	 *    -numa node,nodeid=2,mem=8G \
+	 *    ...
+	 */
+	if (!node_state(dst_nid, N_MEMORY))
+		return false;
+
 	/*
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
-- 
2.17.1


