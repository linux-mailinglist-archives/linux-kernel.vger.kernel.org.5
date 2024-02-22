Return-Path: <linux-kernel+bounces-75809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983D85EF57
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D99C1C21E56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A75168D8;
	Thu, 22 Feb 2024 02:56:26 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EBB11C82;
	Thu, 22 Feb 2024 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570586; cv=none; b=H5eK+12rWZ3Qmn1iw17XSP+969gxkr/ZipMN+SDjd7bjCUChIRXUsWJ2tfpsLc1xLn5MPQZAw0UKE34+xrWzMAaT94uJCOQR9UVRv3siz5DHFmDsD6n8puCzWH1vyC5SKqaHxEQZxmK0B9JBm4Ow/O3lbX40IZmOQQdxAJNUhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570586; c=relaxed/simple;
	bh=owZ8qqgeTtYrNFwZVsLbpW5ktf+EvacwmKJTqWLTSME=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/K9By7QUHTFunyxGmCg9vGl2TQDO47Mu2OzDmLOgzoDZ3rOai3snTJbXXU9w70b9Jw3w5AZgfJE+BZ6GJWiRoyXF/pfOZH6bHV8hWZQsoydVVC/HrJiMrjVfja1BlbktScBta2EbnGm2bnNhdDI73+kr4teFxzyxtlYHdWozkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TgHm92VknzvVwW;
	Thu, 22 Feb 2024 10:54:17 +0800 (CST)
Received: from dggpemd100002.china.huawei.com (unknown [7.185.36.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BA5418005D;
	Thu, 22 Feb 2024 10:56:20 +0800 (CST)
Received: from huawei.com (10.67.174.33) by dggpemd100002.china.huawei.com
 (7.185.36.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Thu, 22 Feb
 2024 10:56:20 +0800
From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, Muchun Song
	<muchun.song@linux.dev>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>, Wang Weiyang
	<wangweiyang2@huawei.com>, Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v2 stable] memcg: add refcnt for pcpu stock to avoid UAF problem in drain_all_stock()
Date: Thu, 22 Feb 2024 11:02:37 +0800
Message-ID: <20240222030237.82486-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100002.china.huawei.com (7.185.36.164)

commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.

NOTE: This is a partial backport since we only need the refcnt between
memcg and stock to fix the problem stated below, and in this way
multiple versions use the same code and align with each other.

---

There was a kernel panic happened on an in-house environment running
3.10, and the same problem was reproduced on 4.19:

general protection fault: 0000 [#1] SMP PTI
CPU: 1 PID: 2085 Comm: bash Kdump: loaded Tainted: G             L    4.19.90+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
RIP: 0010 drain_all_stock+0xad/0x140
Code: 00 00 4d 85 ff 74 2c 45 85 c9 74 27 4d 39 fc 74 42 41 80 bc 24 28 04 00 00 00 74 17 49 8b 04 24 49 8b 17 48 8b 88 90 02 00 00 <48> 39 8a 90 02 00 00 74 02 eb 86 48 63 88 3c 01 00 00 39 8a 3c 01
RSP: 0018:ffffa7efc5813d70 EFLAGS: 00010202
RAX: ffff8cb185548800 RBX: ffff8cb89f420160 RCX: ffff8cb1867b6000
RDX: babababababababa RSI: 0000000000000001 RDI: 0000000000231876
RBP: 0000000000000000 R08: 0000000000000415 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8cb186f89040
R13: 0000000000020160 R14: 0000000000000001 R15: ffff8cb186b27040
FS:  00007f4a308d3740(0000) GS:ffff8cb89f440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe4d634a68 CR3: 000000010b022000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 mem_cgroup_force_empty_write+0x31/0xb0
 cgroup_file_write+0x60/0x140
 ? __check_object_size+0x136/0x147
 kernfs_fop_write+0x10e/0x190
 __vfs_write+0x37/0x1b0
 ? selinux_file_permission+0xe8/0x130
 ? security_file_permission+0x2e/0xb0
 vfs_write+0xb6/0x1a0
 ksys_write+0x57/0xd0
 do_syscall_64+0x63/0x250
 ? async_page_fault+0x8/0x30
 entry_SYSCALL_64_after_hwframe+0x5c/0xc1
Modules linked in: ...

It is found that in case of stock->nr_pages == 0, the memcg on
stock->cached could be freed due to its refcnt decreased to 0, which
made stock->cached become a dangling pointer. It could cause a UAF
problem in drain_all_stock() in the following concurrent scenario. Note
that drain_all_stock() doesn't disable irq but only preemption.

CPU1                             CPU2
==============================================================================
stock->cached = memcgA (freed)
                                 drain_all_stock(memcgB)
                                  rcu_read_lock()
                                  memcg = CPU1's stock->cached (memcgA)
                                  (interrupted)
refill_stock(memcgC)
 drain_stock(memcgA)
 stock->cached = memcgC
 stock->nr_pages += xxx (> 0)
                                  stock->nr_pages > 0
                                  mem_cgroup_is_descendant(memcgA, memcgB) [UAF]
                                  rcu_read_unlock()

This problem is, unintentionally, fixed at 5.9, where commit
1a3e1f40962c ("mm: memcontrol: decouple reference counting from page
accounting") adds memcg refcnt for stock. Therefore affected LTS
versions include 4.19 and 5.4.

For 4.19, memcg's css offline process doesn't call drain_all_stock(). so
it's easier for the released memcg to be left on the stock. For 5.4,
although mem_cgroup_css_offline() does call drain_all_stock(), but the
flushing could be skipped when stock->nr_pages happens to be 0, and
besides the async draining could be delayed and take place after the UAF
problem has happened.

Fix this problem by adding (and decreasing) memcg's refcnt when memcg is
put onto (and removed from) stock, just like how commit 1a3e1f40962c
("mm: memcontrol: decouple reference counting from page accounting")
does. After all, "being on the stock" is a kind of reference with
regards to memcg. As such, it's guaranteed that a css on stock would not
be freed.

It's good to mention that refill_stock() is executed in an irq-disabled
context, so the drain_stock() patched with css_put() would not actually
free memcgA until the end of refill_stock(), since css_put() is an RCU
free and it's still in grace period. For CPU2, the access to CPU1's
stock->cached is protected by rcu_read_lock(), so in this case it gets
either NULL from stock->cached or a memcgA that is still good.

Cc: stable@vger.kernel.org      # 4.19 5.4
Fixes: cdec2e4265df ("memcg: coalesce charging via percpu storage")
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---

v2:
- Add a statement of this patch being a partial backport
- Add a paragraph to mention the grace period in refill_stock()


 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5a366cf79821..8c04296df1c7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2015,6 +2015,9 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 {
 	struct mem_cgroup *old = stock->cached;
 
+	if (!old)
+		return;
+
 	if (stock->nr_pages) {
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
@@ -2022,6 +2025,8 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
+
+	css_put(&old->css);
 	stock->cached = NULL;
 }
 
@@ -2057,6 +2062,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
+		css_get(&memcg->css);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
-- 
2.25.1


