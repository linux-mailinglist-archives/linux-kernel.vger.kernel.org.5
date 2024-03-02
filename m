Return-Path: <linux-kernel+bounces-89340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E078986EEFB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 07:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD10283824
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576111724;
	Sat,  2 Mar 2024 06:44:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7910C11711
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709361844; cv=none; b=n6SfngA6yBpcKJ46t+WZU7OdM4bCuITPGlpVCRi1P4S8mnFICl0PagrZF1kgulkOd/kQ5II82qD8YAXM5iPLa9WQ5tCppeYa/XO7MiZ8LIGJxbfv8+VGOwoA3gKSyetXdqqX+Uw2clJihBXAxmTLMgaS8fjSPDj8zMQrdoyCD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709361844; c=relaxed/simple;
	bh=lgkmANJ9GjhUxs6fepVIKeywrq1p1C99rLUgiB21uuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CYCdid48+mpqzeBKEcYJAbSnLuhslr2S4s++Mf+F1IFITfMmE3j3KOkzHizEGtHs5wsxrkImXYrD5iLnKDh72CsuCYCbF4r9JCYJ1IlIB2/LuuYHt1bWjNXCS5g8ZHqyBi8qUEb12xMCUDjGY4rj1zY924LE+WVGoAcr7gqKSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TmwQx31LTz1FLPf;
	Sat,  2 Mar 2024 14:43:53 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BFFB140120;
	Sat,  2 Mar 2024 14:43:57 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 14:43:56 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Yue Sun <samsun1006219@gmail.com>
Subject: [PATCH] mm: memory: fix shift-out-of-bounds in fault_around_bytes_set
Date: Sat, 2 Mar 2024 14:43:12 +0800
Message-ID: <20240302064312.2358924-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)

The rounddown_pow_of_two(0) is undefined, so val = 0 is not allowed in
the fault_around_bytes_set(), and leads to shift-out-of-bounds,

UBSAN: shift-out-of-bounds in include/linux/log2.h:67:13
shift exponent 4294967295 is too large for 64-bit type 'long unsigned int'
CPU: 7 PID: 107 Comm: sh Not tainted 6.8.0-rc6-next-20240301 #294
Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
Call trace:
 dump_backtrace+0x94/0xec
 show_stack+0x18/0x24
 dump_stack_lvl+0x78/0x90
 dump_stack+0x18/0x24
 ubsan_epilogue+0x10/0x44
 __ubsan_handle_shift_out_of_bounds+0x98/0x134
 fault_around_bytes_set+0xa4/0xb0
 simple_attr_write_xsigned.isra.0+0xe4/0x1ac
 simple_attr_write+0x18/0x24
 debugfs_attr_write+0x4c/0x98
 vfs_write+0xd0/0x4b0
 ksys_write+0x6c/0xfc
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x44/0x104
 el0_svc_common.constprop.0+0x40/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x34/0xdc
 el0t_64_sync_handler+0xc0/0xc4
 el0t_64_sync+0x190/0x194
---[ end trace ]---

Fix it by setting the minimum val to PAGE_SIZE.

Reported-by: Yue Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/all/CAEkJfYPim6DQqW1GqCiHLdh2-eweqk1fGyXqs3JM+8e1qGge8w@mail.gmail.com/
Fixes: 53d36a56d8c4 ("mm: prefer fault_around_pages to fault_around_bytes")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index abd4f33d62c9..e17669d4f72f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4776,7 +4776,8 @@ static int fault_around_bytes_set(void *data, u64 val)
 	 * The minimum value is 1 page, however this results in no fault-around
 	 * at all. See should_fault_around().
 	 */
-	fault_around_pages = max(rounddown_pow_of_two(val) >> PAGE_SHIFT, 1UL);
+	val = max(val, PAGE_SIZE);
+	fault_around_pages = rounddown_pow_of_two(val) >> PAGE_SHIFT;
 
 	return 0;
 }
-- 
2.27.0


