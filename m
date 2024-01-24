Return-Path: <linux-kernel+bounces-36648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883483A459
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB3D1C276DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B318017BB2;
	Wed, 24 Jan 2024 08:40:42 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B617BA3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085642; cv=none; b=Krrqgd27zY2PX7WCGYRlTiwXJq1lT9rDoD/cTu8Bwg1xM5iwpTgju7cAfwhov4cgnhy3KRUHhjbcyJw5Zxu4qbhA/3hBzVI6bDOw/5S2sXM7fiM6VW8LVynMM1m0SJ/alFU56fFDjvFDEUXFtbMNnJaaB2Xh6Y6Z3eJPJxsWMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085642; c=relaxed/simple;
	bh=Wzb1bIyVGnMugHugykRzFwW2Qu2zYkAxJAPe8tSeGYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fopnNHK+NHKKa6e5lXFi4PxUwrirp3IJRVDRYfRqHmiddW+ctBGeeLTvkz+RJijixMKDb6js8nxezXPBSABQxd6CNBdE5j2OpSjeuS6+Lfyo5cUEQwUftTQ16PnF1hWYtdGwmEf8RgbHHKFt01H5S3u5V+M7giSLqEdx20T62EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TKcp15lpbzNlRk;
	Wed, 24 Jan 2024 16:39:37 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 93F5A14011A;
	Wed, 24 Jan 2024 16:40:30 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 16:40:30 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm/memory-failure: fix crash in split_huge_page_to_list from soft_offline_page
Date: Wed, 24 Jan 2024 16:40:14 +0800
Message-ID: <20240124084014.1772906-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

When I did soft offline stress test, a machine was observed to crash with
the following message:

  kernel BUG at include/linux/memcontrol.h:554!
  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 5 PID: 3837 Comm: hwpoison.sh Not tainted 6.7.0-next-20240112-00001-g8ecf3e7fb7c8-dirty #97
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
  RIP: 0010:folio_memcg+0xaf/0xd0
  Code: 10 5b 5d c3 cc cc cc cc 48 c7 c6 08 b1 f2 b2 48 89 ef e8 b4 c5 f8 ff 90 0f 0b 48 c7 c6 d0 b0 f2 b2 48 89 ef e8 a2 c5 f8 ff 90 <0f> 0b 48 c7 c6 08 b1 f2 b2 48 89 ef e8 90 c5 f8 ff 90 0f 0b 66 66
  RSP: 0018:ffffb6c043657c98 EFLAGS: 00000296
  RAX: 000000000000004b RBX: ffff932bc1d1e401 RCX: ffff933abfb5c908
  RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff933abfb5c900
  RBP: ffffea6f04019080 R08: ffffffffb3338ce8 R09: 0000000000009ffb
  R10: 00000000000004dd R11: ffffffffb3308d00 R12: ffffea6f04019080
  R13: ffffea6f04019080 R14: 0000000000000001 R15: ffffb6c043657da0
  FS:  00007f6c60f6b740(0000) GS:ffff933abfb40000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000559c3bc8b980 CR3: 0000000107f1c000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   ? die+0x32/0x90
   ? do_trap+0xde/0x110
   ? folio_memcg+0xaf/0xd0
   ? do_error_trap+0x60/0x80
   ? folio_memcg+0xaf/0xd0
   ? exc_invalid_op+0x53/0x70
   ? folio_memcg+0xaf/0xd0
   ? asm_exc_invalid_op+0x1a/0x20
   ? folio_memcg+0xaf/0xd0
   ? folio_memcg+0xae/0xd0
   split_huge_page_to_list+0x4d/0x1380
   ? sysvec_apic_timer_interrupt+0xf/0x80
   try_to_split_thp_page+0x3a/0xf0
   soft_offline_page+0x1ea/0x8a0
   soft_offline_page_store+0x52/0x90
   kernfs_fop_write_iter+0x118/0x1b0
   vfs_write+0x30b/0x430
   ksys_write+0x5e/0xe0
   do_syscall_64+0xb0/0x1b0
   entry_SYSCALL_64_after_hwframe+0x6d/0x75
  RIP: 0033:0x7f6c60d14697
  Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
  RSP: 002b:00007ffe9b72b8d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f6c60d14697
  RDX: 000000000000000c RSI: 0000559c3bc8b980 RDI: 0000000000000001
  RBP: 0000559c3bc8b980 R08: 00007f6c60dd1460 R09: 000000007fffffff
  R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
  R13: 00007f6c60e1a780 R14: 00007f6c60e16600 R15: 00007f6c60e15a00

The problem is that page->mapping is overloaded with slab->slab_list or
slabs fields now, so slab pages could be taken as non-LRU movable pages
if field slabs contains PAGE_MAPPING_MOVABLE or slab_list->prev is set
to LIST_POISON2. These slab pages will be treated as thp later leading
to crash in split_huge_page_to_list().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Fixes: 130d4df57390 ("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")
---
v2:
  Check PageSlab() first to leave the rest code alone per Matthew.
---
 mm/memory-failure.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 636280d04008..9349948f1abf 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1377,6 +1377,9 @@ void ClearPageHWPoisonTakenOff(struct page *page)
  */
 static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
 {
+	if (PageSlab(page))
+		return false;
+
 	/* Soft offline could migrate non-LRU movable pages */
 	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
 		return true;
-- 
2.33.0


