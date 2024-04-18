Return-Path: <linux-kernel+bounces-149441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EC68A912B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A8F281C58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8664F896;
	Thu, 18 Apr 2024 02:22:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB5495CB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406950; cv=none; b=bcv7Rk4wZDCo0ap8Gra7wqrFIub79d7GJCXFoFRz68BmrsiQp/lIzD1vsim5DwHOIax9gRpyZRklGH5KwSl9+9AqEy1AB5KdbhaQOj6GMG7DhJAqxBEoFW0D4/YkNIk9RGZFSvLiSzgaMCGIroqK9i+3Z1NZQOL+y/trWWG56HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406950; c=relaxed/simple;
	bh=G70+RZNAEMmyYjIqT9sWZ/xjR9oHRWpamG9o+KTbufk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ln/EwtqUfzZNiWwjb+UFhWesSxtzabFqvwdVwPXOd19+jsc8sN1HdPDIbuDH4+ii4N0qIT9AUaakbGWni+qsiBSsPgeIYbovRusoXi6DpG+9C0GMU/dGkGbeSoX3nONxFwiHotMJRF+3NJBJ0cajoY9dPJVUm9XoWyPGwMOIvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VKhL10tW4zwSxx;
	Thu, 18 Apr 2024 10:19:21 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id EB9C01800C5;
	Thu, 18 Apr 2024 10:22:24 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:22:24 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <david@redhat.com>, <vbabka@suse.cz>, <willy@infradead.org>,
	<linmiaohe@huawei.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] mm/hugetlb: fix unable to handle page fault for address dead000000000108
Date: Thu, 18 Apr 2024 10:20:00 +0800
Message-ID: <20240418022000.3524229-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240418022000.3524229-1-linmiaohe@huawei.com>
References: <20240418022000.3524229-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

Below panic occurs when I did memory failure test:

BUG: unable to handle page fault for address: dead000000000108
PGD 0 P4D 0
Oops: Oops: 0001 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 1073 Comm: bash Not tainted 6.9.0-rc4-next-20240417-dirty #52
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:enqueue_hugetlb_folio+0x46/0xe0
RSP: 0018:ffff9e0207f03d10 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dead000000000122
RDX: ffffcbb244460008 RSI: dead000000000100 RDI: ffff976a09da6f90
RBP: ffffcbb244460000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 7a088d6100000000 R12: ffffffffbcc93160
R13: 0000000000000246 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fdb749b1740(0000) GS:ffff97711fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: dead000000000108 CR3: 00000001078ac000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 free_huge_folio+0x28d/0x420
 dissolve_free_hugetlb_folio+0x135/0x1d0
 __page_handle_poison+0x18/0xb0
 memory_failure+0x712/0xd30
 hard_offline_page_store+0x55/0xa0
 kernfs_fop_write_iter+0x12c/0x1d0
 vfs_write+0x380/0x540
 ksys_write+0x64/0xe0
 do_syscall_64+0xbc/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdb74714887
RSP: 002b:00007ffdfc7074e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007fdb74714887
RDX: 000000000000000c RSI: 00005653ec7c0e10 RDI: 0000000000000001
RBP: 00005653ec7c0e10 R08: 00007fdb747d1460 R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 00007fdb7481b780 R14: 00007fdb74817600 R15: 00007fdb74816a00
 </TASK>
Modules linked in: mce_inject hwpoison_inject
CR2: dead000000000108
---[ end trace 0000000000000000 ]---
RIP: 0010:enqueue_hugetlb_folio+0x46/0xe0
RSP: 0018:ffff9e0207f03d10 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: dead000000000122
RDX: ffffcbb244460008 RSI: dead000000000100 RDI: ffff976a09da6f90
RBP: ffffcbb244460000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 7a088d6100000000 R12: ffffffffbcc93160
R13: 0000000000000246 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fdb749b1740(0000) GS:ffff97711fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: dead000000000108 CR3: 00000001078ac000 CR4: 00000000000006f0
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x38a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception ]---

The root cause is that list_del() is used to remove folio from list when
dissolve_free_hugetlb_folio(). But list_move() might be used to reenqueue
hugetlb folio when free_huge_folio() leading to above panic. Fix this
issue by using list_del_init() to remove folio.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1da9a14a5513..08634732dca4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1642,7 +1642,7 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	list_del(&folio->lru);
+	list_del_init(&folio->lru);
 
 	if (folio_test_hugetlb_freed(folio)) {
 		h->free_huge_pages--;
-- 
2.33.0


