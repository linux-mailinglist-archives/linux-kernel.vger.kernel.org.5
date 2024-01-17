Return-Path: <linux-kernel+bounces-28851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A28303C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9903C1C24886
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503D31C6BA;
	Wed, 17 Jan 2024 10:41:07 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9714AA8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488066; cv=none; b=h8GyTPyXoR001zTqActT8STbA12f8xCMLszufTI8Ei2AcoIfKjNYiufMeLNZV8bY/6cIWmJds+7NdoMduUBr74/FgYperxCu99MRypeZoYzLoCSZZBtti1w6sCBeaf3ollLIcADU7vH3QwEQWot/XkYJ1vY/x1l/bIOPJGb0dbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488066; c=relaxed/simple;
	bh=rWJwV8MZcwjK1H7Uf74Eygs3TKx5RsNSPy1WPJLyfN8=;
	h=Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy; b=tyO5lUGr9pYCejef7gRKTqoVR0vg+jdmT3TW5GhcqAqx3qHjBnVARTPOBqje3Nv0et844hOWGqluEySMiFi6oL238+yGY1DKayPTkZOdxUXQoLkhtHXHSrlZ3IDwAazKISDT1ix0tqCvlFJGmmpeUBdRuvmfI85WFmdokW0Wdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TFMnR1xjRz1gxdv;
	Wed, 17 Jan 2024 18:39:23 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 36FE41A0172;
	Wed, 17 Jan 2024 18:41:01 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 18:41:00 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, David
 Hildenbrand <david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] mm: memory: move mem_cgroup_charge() into alloc_anon_folio()
Date: Wed, 17 Jan 2024 18:39:54 +0800
Message-ID: <20240117103954.2756050-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

mem_cgroup_charge() uses the GFP flags in a fairly sophisticated way.
In addition to checking gfpflags_allow_blocking(), it pays attention
to __GFP_NORETRY and __GFP_RETRY_MAYFAIL to ensure that processes within
this memcg do not exceed their quotas. Using the same GFP flags ensures
that we handle large anonymous folios correctly, including falling back
to smaller orders when there is plenty of memory available in the system
but this memcg is close to its limits.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
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


