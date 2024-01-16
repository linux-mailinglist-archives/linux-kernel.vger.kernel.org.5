Return-Path: <linux-kernel+bounces-27058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34D682E9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85CD282341
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C1510A24;
	Tue, 16 Jan 2024 07:14:52 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B1710A1D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TDgHS4CYbz1wnCF;
	Tue, 16 Jan 2024 15:14:28 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BA701800B9;
	Tue, 16 Jan 2024 15:14:47 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 15:14:46 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, David
 Hildenbrand <david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: memory: move mem_cgroup_charge() into alloc_anon_folio()
Date: Tue, 16 Jan 2024 15:13:02 +0800
Message-ID: <20240116071302.2282230-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)

In order to allocate as much as possible of large folio, move
the mem charge into alloc_anon_folio() and try the next order
if mem_cgroup_charge() fails, also we change the GFP_KERNEL
to gfp to be consistent with PMD THP.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5e88d5379127..2e31a407e6f9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4206,15 +4206,21 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
 		folio = vma_alloc_folio(gfp, order, vma, addr, true);
 		if (folio) {
+			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
+				folio_put(folio);
+				goto next;
+			}
+			folio_throttle_swaprate(folio, gfp);
 			clear_huge_page(&folio->page, vmf->address, 1 << order);
 			return folio;
 		}
+next:
 		order = next_order(&orders, order);
 	}
 
 fallback:
 #endif
-	return vma_alloc_zeroed_movable_folio(vmf->vma, vmf->address);
+	return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
 }
 
 /*
@@ -4281,10 +4287,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	nr_pages = folio_nr_pages(folio);
 	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
 
-	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
-		goto oom_free_page;
-	folio_throttle_swaprate(folio, GFP_KERNEL);
-
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * preceding stores to the page contents become visible before
@@ -4338,8 +4340,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 release:
 	folio_put(folio);
 	goto unlock;
-oom_free_page:
-	folio_put(folio);
 oom:
 	return VM_FAULT_OOM;
 }
-- 
2.27.0


