Return-Path: <linux-kernel+bounces-141836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA358A2418
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CCE1C22168
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077FE14016;
	Fri, 12 Apr 2024 03:00:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089D12E6A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890814; cv=none; b=ObFDU3U4ZlrpP1/B1nZnHIJhwakT9Pmfjp7QBZuQhd3FCLq93cPmHXVtrl6B9+pFTT3p0Nf3kbDvNjyTAH0gHxz6kWkZ79VfvxofXNZicQl7cU/rgCHkVGQMRlhqDzIG+ggS5syXKRAJuCLlXv3RXD6reMWGakzrLBKridtRe6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890814; c=relaxed/simple;
	bh=nVhnGeqrmkXQzFTyIccj5R+m3oQRiwWoGXRHPoy8DIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HsTRLC5bDFMvmQgPkWxBHsN268GhJ8KieafFTECijuxFy8Ek5McKHhWf6xFAjKcOqm45sL9uxwei9IxImDDNgwSoKhhTNKo1JJ8XmDaLoixJAgjnCE1mYD/ChLOmO9m6oFMuU1Pq7LsJqHJEvWZfbwRB16dKkc2JfYGa+B+svgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VG1SQ6hLqzwRcZ;
	Fri, 12 Apr 2024 10:57:10 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 406C8140124;
	Fri, 12 Apr 2024 11:00:08 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Apr
 2024 11:00:07 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>
CC: <linmiaohe@huawei.com>, <naoya.horiguchi@nec.com>, <osalvador@suse.de>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm/memory-failure: fix deadlock when hugetlb_optimize_vmemmap is enabled
Date: Fri, 12 Apr 2024 10:57:54 +0800
Message-ID: <20240412025754.1897615-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

When I did hard offline test with hugetlb pages, below deadlock occurs:

======================================================
WARNING: possible circular locking dependency detected
6.8.0-11409-gf6cef5f8c37f #1 Not tainted
------------------------------------------------------
bash/46904 is trying to acquire lock:
ffffffffabe68910 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_dec+0x16/0x60

but task is already holding lock:
ffffffffabf92ea8 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable+0x16/0x40

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (pcp_batch_high_lock){+.+.}-{3:3}:
       __mutex_lock+0x6c/0x770
       page_alloc_cpu_online+0x3c/0x70
       cpuhp_invoke_callback+0x397/0x5f0
       __cpuhp_invoke_callback_range+0x71/0xe0
       _cpu_up+0xeb/0x210
       cpu_up+0x91/0xe0
       cpuhp_bringup_mask+0x49/0xb0
       bringup_nonboot_cpus+0xb7/0xe0
       smp_init+0x25/0xa0
       kernel_init_freeable+0x15f/0x3e0
       kernel_init+0x15/0x1b0
       ret_from_fork+0x2f/0x50
       ret_from_fork_asm+0x1a/0x30

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
       __lock_acquire+0x1298/0x1cd0
       lock_acquire+0xc0/0x2b0
       cpus_read_lock+0x2a/0xc0
       static_key_slow_dec+0x16/0x60
       __hugetlb_vmemmap_restore_folio+0x1b9/0x200
       dissolve_free_huge_page+0x211/0x260
       __page_handle_poison+0x45/0xc0
       memory_failure+0x65e/0xc70
       hard_offline_page_store+0x55/0xa0
       kernfs_fop_write_iter+0x12c/0x1d0
       vfs_write+0x387/0x550
       ksys_write+0x64/0xe0
       do_syscall_64+0xca/0x1e0
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(pcp_batch_high_lock);
                               lock(cpu_hotplug_lock);
                               lock(pcp_batch_high_lock);
  rlock(cpu_hotplug_lock);

 *** DEADLOCK ***

5 locks held by bash/46904:
 #0: ffff98f6c3bb23f0 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x64/0xe0
 #1: ffff98f6c328e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xf8/0x1d0
 #2: ffff98ef83b31890 (kn->active#113){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1d0
 #3: ffffffffabf9db48 (mf_mutex){+.+.}-{3:3}, at: memory_failure+0x44/0xc70
 #4: ffffffffabf92ea8 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable+0x16/0x40

stack backtrace:
CPU: 10 PID: 46904 Comm: bash Kdump: loaded Not tainted 6.8.0-11409-gf6cef5f8c37f #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0xa0
 check_noncircular+0x129/0x140
 __lock_acquire+0x1298/0x1cd0
 lock_acquire+0xc0/0x2b0
 cpus_read_lock+0x2a/0xc0
 static_key_slow_dec+0x16/0x60
 __hugetlb_vmemmap_restore_folio+0x1b9/0x200
 dissolve_free_huge_page+0x211/0x260
 __page_handle_poison+0x45/0xc0
 memory_failure+0x65e/0xc70
 hard_offline_page_store+0x55/0xa0
 kernfs_fop_write_iter+0x12c/0x1d0
 vfs_write+0x387/0x550
 ksys_write+0x64/0xe0
 do_syscall_64+0xca/0x1e0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fc862314887
Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007fff19311268 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007fc862314887
RDX: 000000000000000c RSI: 000056405645fe10 RDI: 0000000000000001
RBP: 000056405645fe10 R08: 00007fc8623d1460 R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 00007fc86241b780 R14: 00007fc862417600 R15: 00007fc862416a00

In short, below scene breaks the lock dependency chain:

 memory_failure
  __page_handle_poison
   zone_pcp_disable -- lock(pcp_batch_high_lock)
   dissolve_free_huge_page
    __hugetlb_vmemmap_restore_folio
     static_key_slow_dec
      cpus_read_lock -- rlock(cpu_hotplug_lock)

Fix this by calling drain_all_pages() instead.

Fixes: a6b40850c442 ("mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
---
v2:
 collect Acked-by tag and extend comment per Oscar. Thanks.
---
 mm/memory-failure.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index edd6e114462f..c6750509d74c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -153,11 +153,21 @@ static int __page_handle_poison(struct page *page)
 {
 	int ret;
 
-	zone_pcp_disable(page_zone(page));
+	/*
+	 * zone_pcp_disable() can't be used here. It will hold pcp_batch_high_lock and
+	 * dissolve_free_huge_page() might hold cpu_hotplug_lock via static_key_slow_dec()
+	 * when hugetlb vmemmap optimization is enabled. This will break current lock
+	 * dependency chain and leads to deadlock.
+	 * Disabling pcp before dissolving the page was a deterministic approach because
+	 * we made sure that those pages cannot end up in any PCP list. Draining PCP lists
+	 * expels those pages to the buddy system, but nothing guarantees that those pages
+	 * do not get back to a PCP queue if we need to refill those.
+	 */
 	ret = dissolve_free_huge_page(page);
-	if (!ret)
+	if (!ret) {
+		drain_all_pages(page_zone(page));
 		ret = take_page_off_buddy(page);
-	zone_pcp_enable(page_zone(page));
+	}
 
 	return ret;
 }
-- 
2.33.0


