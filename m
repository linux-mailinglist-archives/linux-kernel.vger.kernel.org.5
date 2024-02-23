Return-Path: <linux-kernel+bounces-77839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F2860ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D131F244AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D80A14297;
	Fri, 23 Feb 2024 06:36:16 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FA1401D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670176; cv=none; b=p0tT+sVkejmY6g1cdf86IPHV4nFNHICGnqnHGe3bsDxtxznmxEqntU5P2+eOjx3uDhD98aU/CAYkQKmJ3vwAN2Qgv3BNl3eir2DIGbe45o71GgbewWtdmatAg6xh4rqexs8ufijciv/t3AEbNkJhfjq2PnKGXH9mUlOXwPdD2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670176; c=relaxed/simple;
	bh=q8pNuWaa5hgVcuh7dvNYS+X6QeCBAHKqdX/eWVAD+oQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UnNrGQpMwzw/ImXD2MHX3hstGEq14QPvzO4aY8SqEQid1GMjxIMonWfEZVjPZMMjLtgRzREPPSZN9Gvv4Z+VjjPsqnsq2VJ5T3aLs05vZGIquUufku7gGmQ606IQMGvMPYDuuu5xMR7c+W7OH1eNxrHn1ehwqVOB14r/5uBxK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Th0bC23Vqz2BdKl;
	Fri, 23 Feb 2024 14:33:59 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (unknown [7.185.36.59])
	by mail.maildlp.com (Postfix) with ESMTPS id C195B1A016B;
	Fri, 23 Feb 2024 14:36:09 +0800 (CST)
Received: from huawei.com (10.175.112.125) by dggpeml500005.china.huawei.com
 (7.185.36.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 14:36:09 +0800
From: Yongqiang Liu <liuyongqiang13@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: <yanaijie@huawei.com>, <zhangxiaoxu5@huawei.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<linux@armlinux.org.uk>, <rppt@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <keescook@chromium.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <willy@infradead.org>,
	<liuyongqiang13@huawei.com>
Subject: [PATCH v2] arm: flush: check if the folio is reserved for no-mapping addresses
Date: Fri, 23 Feb 2024 14:36:08 +0800
Message-ID: <20240223063608.2605736-1-liuyongqiang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500005.china.huawei.com (7.185.36.59)

Since commit a4d5613c4dc6 ("arm: extend pfn_valid to take into account
freed memory map alignment") changes the semantics of pfn_valid() to check
presence of the memory map for a PFN. A valid page for an address which
is reserved but not mapped by the kernel[1], the system crashed during
some uio test with the following memory layout:

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

So check if PG_reserved was set to solve this issue.

[1]: https://lore.kernel.org/lkml/Zbtdue57RO0QScJM@linux.ibm.com/

Fixes: a4d5613c4dc6 ("arm: extend pfn_valid to take into account freed memory map alignment")
Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
v1 -> v2
 - Improve commit message
 - Use helpers instead of PG_reserved
 - drop the unnecessary include headers

 arch/arm/mm/flush.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index d19d140a10c7..0749cf8a6637 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -296,6 +296,9 @@ void __sync_icache_dcache(pte_t pteval)
 		return;
 
 	folio = page_folio(pfn_to_page(pfn));
+	if (folio_test_reserved(folio))
+		return;
+
 	if (cache_is_vipt_aliasing())
 		mapping = folio_flush_mapping(folio);
 	else
-- 
2.25.1


