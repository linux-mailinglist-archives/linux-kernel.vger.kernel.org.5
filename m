Return-Path: <linux-kernel+bounces-46448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C7843FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3797AB25EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53457AE5E;
	Wed, 31 Jan 2024 12:59:19 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0179DA6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705959; cv=none; b=FaloWQ4tm4n11/NUcYZvvV3TmovlmvPfLxiFpf2MrE52F7JLQ2nBYV38hFMGjdXW6ftoDind3/KrjtacQzOo6FD6DJWSO0dCV2yVc5ZqlnyoxUpNnvLHdlCZkkn3pfR/yo2DqHmlZZXmwk40pjQjmB7Y4nlCno2Alh9/OH7LVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705959; c=relaxed/simple;
	bh=YQlXIdm7qMwVqhQEJvAw6fcm6RlKimVydVPzfD3qE9A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0SSq0pMwddBCXWb9D+GI2c0K7Mw/rmVG7A3aCYvpKKpMpNqtdjvXDV7N9cVHF0V+ng6Rntap1+KB+bReoFVRnyHwzcQgMeUf/TNFOyRcGXCuGVwXxQMs0iRky2uUludSlByh3srsGgAbf+FXslFLsPvlXixa7ofM8LXe5QDTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TQ2B62ZyKz29kp4;
	Wed, 31 Jan 2024 20:57:18 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (unknown [7.185.36.59])
	by mail.maildlp.com (Postfix) with ESMTPS id DE2D41402E0;
	Wed, 31 Jan 2024 20:59:08 +0800 (CST)
Received: from huawei.com (10.175.112.125) by dggpeml500005.china.huawei.com
 (7.185.36.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 31 Jan
 2024 20:59:08 +0800
From: Yongqiang Liu <liuyongqiang13@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: <yanaijie@huawei.com>, <zhangxiaoxu5@huawei.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<linux@armlinux.org.uk>, <rppt@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <keescook@chromium.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <willy@infradead.org>,
	<liuyongqiang13@huawei.com>
Subject: [PATCH] arm: flush: don't abuse pfn_valid() to check if pfn is in RAM
Date: Wed, 31 Jan 2024 20:59:07 +0800
Message-ID: <20240131125907.1006760-1-liuyongqiang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500005.china.huawei.com (7.185.36.59)

Since commit a4d5613c4dc6 ("arm: extend pfn_valid to take into account
freed memory map alignment") changes the semantics of pfn_valid() to check
presence of the memory map for a PFN. __sync_icache_dcache() should use
memblock_is_map_memory() instead of pfn_valid() to check if a PFN is in
RAM or not.In Some uio case we will get a crash on a system with the
following memory layout:

 node   0: [mem 0x00000000c0a00000-0x00000000cc8fffff]
 node   0: [mem 0x00000000d0000000-0x00000000da1fffff]
 the uio layout is：0xc0900000, 0x100000

the crash backtrace like:

  Unable to handle kernel paging request at virtual address bff00000
  [...]
  CPU: 1 PID: 465 Comm: startapp.bin Tainted: G           O      5.10.0 #1
  Hardware name: Generic DT based system
  PC is at b15_flush_kern_dcache_area+0x24/0x3c
  LR is at __sync_icache_dcache+0x6c/0x98
  [...]
   (b15_flush_kern_dcache_area) from (__sync_icache_dcache+0x6c/0x98)
   (__sync_icache_dcache) from (set_pte_at+0x28/0x54)
   (set_pte_at) from (remap_pfn_range+0x1a0/0x274)
   (remap_pfn_range) from (uio_mmap+0x184/0x1b8 [uio])
   (uio_mmap [uio]) from (__mmap_region+0x264/0x5f4)
   (__mmap_region) from (__do_mmap_mm+0x3ec/0x440)
   (__do_mmap_mm) from (do_mmap+0x50/0x58)
   (do_mmap) from (vm_mmap_pgoff+0xfc/0x188)
   (vm_mmap_pgoff) from (ksys_mmap_pgoff+0xac/0xc4)
   (ksys_mmap_pgoff) from (ret_fast_syscall+0x0/0x5c)
  Code: e0801001 e2423001 e1c00003 f57ff04f (ee070f3e)
  ---[ end trace 09cf0734c3805d52 ]---
  Kernel panic - not syncing: Fatal exception

Fixes: a4d5613c4dc6 ("arm: extend pfn_valid to take into account freed memory map alignment")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 arch/arm/mm/flush.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index d19d140a10c7..11ec6c5ff5fc 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -15,6 +15,7 @@
 #include <asm/smp_plat.h>
 #include <asm/tlbflush.h>
 #include <linux/hugetlb.h>
+#include <linux/memblock.h>
 
 #include "mm.h"
 
@@ -292,7 +293,7 @@ void __sync_icache_dcache(pte_t pteval)
 		/* only flush non-aliasing VIPT caches for exec mappings */
 		return;
 	pfn = pte_pfn(pteval);
-	if (!pfn_valid(pfn))
+	if (!memblock_is_map_memory(PFN_PHYS(pfn)))
 		return;
 
 	folio = page_folio(pfn_to_page(pfn));
-- 
2.25.1


