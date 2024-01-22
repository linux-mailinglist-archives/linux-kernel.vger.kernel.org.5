Return-Path: <linux-kernel+bounces-32255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57F835919
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6569B21DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307717F8;
	Mon, 22 Jan 2024 01:17:50 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3966415BA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705886270; cv=none; b=dsEvNpO+3Yp8isWGTSvlw3C6pfAAqlwRsDagBoRPLezChhyIHX42w/c1aDgPU4tIm8ioIPCki4KLucOAWilPVzyKPDCW//2zH2Wrd7u/BBT+ulH0Oauz7yGvAzgroiX9Vy83zFIvPamkMDKrt7SBXZSqOYpma3ozHelstOoqNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705886270; c=relaxed/simple;
	bh=X1JCYHjLFc1Vjf+bOAbx3bAjp/9aMNA6yUU9J/H6l4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nmUKKoj0kPRa4xpcctVt2W1P9J5yNuAN5JpY0AQCZvh/Bz7v64W0WktHXC1mxjCmERMo5yhPoxO5uhPzKTAodX/7qQ9bYac7Y8kbtKRdU5VJPzkAASlRdkNtOX7gh8OecheGQGR5hHowuzSjZrn0jgC1T3+Jmwldafm4lZHflfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TJC3D2dhfzvTXb;
	Mon, 22 Jan 2024 09:16:08 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B9781404FC;
	Mon, 22 Jan 2024 09:17:38 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 09:17:37 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, David
 Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Roman
 Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeelb@google.com>, Muchun Song <songmuchun@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] mm: memory: move mem_cgroup_charge() into alloc_anon_folio()
Date: Mon, 22 Jan 2024 09:16:12 +0800
Message-ID: <20240122011612.501029-1-wangkefeng.wang@huawei.com>
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

The GFP flags from vma_thp_gfp_mask() according to user configuration
only used for large folio allocation but not for memory cgroup charge,
and GFP_KERNEL is used for both order-0 and large order folio when memory
cgroup charge at present. However, mem_cgroup_charge() uses the GFP
flags in a fairly sophisticated way. In addition to checking
gfpflags_allow_blocking(), it pays attention to __GFP_NORETRY and
__GFP_RETRY_MAYFAIL to ensure that processes within this memcg do not
exceed their quotas.

So we'd better to move mem_cgroup_charge() into alloc_anon_folio(),
1) it will make us to allocate as much as possible large order folio,
because we could try the next order if mem_cgroup_charge() fails,
although the memcg's memory usage is close to its limits.
2) using same GFP flags for allocation and charge is to be consistent
with PMD THP firstly, in addition, according to GFP flag returned from
vma_thp_gfp_mask(), GFP_TRANSHUGE_LIGHT could make us skip direct reclaim,
_GFP_NORETRY will make us skip mem_cgroup_oom() and won't trigger memory
cgroup oom from large order(order <= COSTLY_ORDER) folio charging.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v3:
- update changelog suggested by Michal Hocko
- add RB from Ryan
v2:
- fix built when !CONFIG_TRANSPARENT_HUGEPAGE
- update changelog suggested by Matthew Wilcox

 mm/memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5e88d5379127..551f0b21bc42 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4153,8 +4153,8 @@ static bool pte_range_none(pte_t *pte, int nr_pages)
 
 static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct vm_area_struct *vma = vmf->vma;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	unsigned long orders;
 	struct folio *folio;
 	unsigned long addr;
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


