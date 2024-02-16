Return-Path: <linux-kernel+bounces-68177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839E38576DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39193284804
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA9168DC;
	Fri, 16 Feb 2024 07:34:00 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6015E8B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068840; cv=none; b=ru0GPkPqkH7wGPlmRidzk5YlLf+bwM735Aijh0FXmUQYa5QSnwpElLPEPd45PqdQLQCJXMKixHicctGE6DEE6MmGYBc/wlIxdOtOzICn9uDpIzHHHhX32zQ2PE5A6gAPxD5scC9dzmHHXkM4QiQ8i5fD6VnHytQ041InQS0QzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068840; c=relaxed/simple;
	bh=cAH7DMxuXm3UwwG9aeS1vnD0RhVr10jUVfSZVMparjw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HnKpub/sw+BS4spwOxJpV7acg0kGwgO8IBwvxWrOX/ZeKqvns2we3vJjJTBmPLwOARIyR6p3Hg5QW7NorJObi3ww2lLoPuiJYlJvmyCskEuDZynFKP/uziHv4AbVouKaTbtDxFWCcv09s8HMGpZbIPWi7rNyTgXlYOB9qp+Kajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-0a-65cf0fde2f2c
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
Subject: [PATCH v2] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
Date: Fri, 16 Feb 2024 16:33:40 +0900
Message-Id: <20240216073340.55404-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsXC9ZZnke49/vOpBs9fSlrMWb+GzeLS46ts
	FtNfNrJYPJ2wldnibv9UFovLu+awWdxb85/VYvK7Z4wWlw4sYLI43nuAyWJfxwMmi44j35gt
	th79zu7A67Fm3hpGj5Z9t9g9Fmwq9di8Qstj06dJ7B53ru1h8zgx4zeLx/t9V9k8Np+u9vi8
	SS6AK4rLJiU1J7MstUjfLoEr4/X3p4wFJ2Uq+vZMY25gfCPexcjJISFgItF9aS4TjD21bTE7
	iM0moC5x48ZP5i5GLg4RgTeMEp3LzrCBJJgF8iRa//eBNQgLBEss2LOWBcRmEVCV2HyyixHE
	5hUwlTj84QkzxFB5idUbDoANkhDYwCaxeMFvVoiEpMTBFTdYJjByL2BkWMUolJlXlpuYmWOi
	l1GZl1mhl5yfu4kRGIjLav9E72D8dCH4EKMAB6MSD++BP2dThVgTy4orcw8xSnAwK4nwTuo9
	kyrEm5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBkeG6t7RV
	z+Lv3zazH5rH8NDrYszfcg9e346DylkSgmFBsUL9R2o5l22qbur+FiKT/WJtTqWcavcpaZZF
	b8VunJfVuJ6rJqSd4zJZXyNrZ6/b48ivi/0D/6Tue/WibMERQ8X3y20bNrmxM8peW6M84/wT
	vyfz5BcEv5U/GFaVILaRr7NAcm+uEktxRqKhFnNRcSIA4FVAu0ACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsXC5WfdrHuP/3yqwcWj3BZz1q9hs7j0+Cqb
	xfSXjSwWTydsZba42z+VxeLw3JOsFpd3zWGzuLfmP6vF5HfPGC0uHVjAZHG89wCTxb6OB0wW
	HUe+MVtsPfqd3YHPY828NYweLftusXss2FTqsXmFlsemT5PYPe5c28PmcWLGbxaP9/uusnks
	fvGByWPz6WqPz5vkArijuGxSUnMyy1KL9O0SuDJef3/KWHBSpqJvzzTmBsY34l2MnBwSAiYS
	U9sWs4PYbALqEjdu/GTuYuTiEBF4wyjRuewMG0iCWSBPovV/HxOILSwQLLFgz1oWEJtFQFVi
	88kuRhCbV8BU4vCHJ8wQQ+UlVm84wDyBkWMBI8MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2M
	wLBaVvtn4g7GL5fdDzEKcDAq8fAe+HM2VYg1say4MvcQowQHs5II76TeM6lCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjNUZnqo/itbvuv1Aeo511C6O
	i4pX9E2vfo7ekHNjo72qaMARVe4Da5zLNtbPPP7jdMHFTSc9J8hMuNbMs++iudYr3vlf9FYt
	+7IvRmQGZ9HKKoMG46mWLu47D1eV/D1dfNS0MGX/tTm5Fc3bp3RxBK4XfPV55TY73aDbOyaK
	TDUu6n9QXLFSRleJpTgj0VCLuag4EQAptKZcJwIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v1:
	1. Trim the verbose oops in the commit message. (feedbacked by
	   Phil Auld)
	2. Rewrite a comment in code. (feedbacked by Phil Auld)

--->8---
From 6830b59db267a31b78f6f09af12ae0e3132b4bca Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Fri, 16 Feb 2024 16:26:23 +0900
Subject: [PATCH v2] sched/numa, mm: do not promote folios to nodes not set N_MEMORY

While running qemu with a configuration where some CPUs don't have their
local memory and with a kernel numa balancing on, the following oops has
been observed. It's because of null pointers of ->zone_pgdat of zones of
those nodes that are not initialized properly at booting time. So should
avoid nodes not set N_MEMORY from getting promoted.

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

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reported-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..859ef78ef72b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1828,6 +1828,15 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	/*
+	 * A node of dst_nid might not have its local memory. Promoting
+	 * a folio to the node is meaningless. What's even worse, oops
+	 * can be observed by the null pointer of ->zone_pgdat in
+	 * various points of the code during migration.
+	 */
+	if (!node_state(dst_nid, N_MEMORY))
+		return false;
+
 	/*
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
-- 
2.17.1


