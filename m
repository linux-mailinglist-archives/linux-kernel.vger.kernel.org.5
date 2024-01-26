Return-Path: <linux-kernel+bounces-40275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8826783DD6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C29B2684C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6F1DDC9;
	Fri, 26 Jan 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dYyUEugy"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DF1D55F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282750; cv=none; b=Ss5iokE7sHK8BmsARIOHM0YlWtY/MokLW3PoYiYBYiNBquuHclaMXw7sVlCf//tciHKo3NaB7+fOPo4hOq0F2YC5oQq93jc+AO3Gt/ejGcJ2LcWzduFEJygCqbVE5ZD84gA10oP0hZ3B3MyHudmScWhfVfXepWenXT50smbOh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282750; c=relaxed/simple;
	bh=c2eGy8j5jjUuuogbCux3HCSCTf68lnabsdin1Kloo8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGHeOHZB3lOEiUegydXOiZgm5PRGeGnViaOyPIkYjZRt1gk7iyiMgVuwJ19D/mAz5J1IUCukz33V9FzxDaKir+3CAOiVhioTgmGEb6uqmyMns33T3fxPs4cVzcpli8erQHlWHhx0gzhnPaQb87+syqFx0ic/vATrUoAsOQvYwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dYyUEugy; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706282746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iArgVEROeDskUb/co444WxwcA+iCGyxYPbAZNymH1g=;
	b=dYyUEugy+xtDscuDVSmLIJChMKlpJo7hUQlBy8G4LmvOhGPDib/TUY2KXKt7cRInLKAa1I
	b1QrLCFOaKrSbCu0c2Y3x47nwNUIIzTHzZvBCbhCbYQlzL25YqVImvkO36hN0p1LqAbwUF
	8bvuvbI8HTBoL2mr29vGEt4GJQlLJPQ=
From: Gang Li <gang.li@linux.dev>
To: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v5 7/7] hugetlb: parallelize 1G hugetlb initialization
Date: Fri, 26 Jan 2024 23:24:11 +0800
Message-Id: <20240126152411.1238072-8-gang.li@linux.dev>
In-Reply-To: <20240126152411.1238072-1-gang.li@linux.dev>
References: <20240126152411.1238072-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Optimizing the initialization speed of 1G huge pages through
parallelization.

1G hugetlbs are allocated from bootmem, a process that is already
very fast and does not currently require optimization. Therefore,
we focus on parallelizing only the initialization phase in
`gather_bootmem_prealloc`.

Here are some test results:
      test case       no patch(ms)   patched(ms)   saved
 ------------------- -------------- ------------- --------
  256c2T(4 node) 1G           4745          2024   57.34%
  128c1T(2 node) 1G           3358          1712   49.02%
     12T         1G          77000         18300   76.23%

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Tested-by: David Rientjes <rientjes@google.com>
---
 arch/powerpc/mm/hugetlbpage.c |  2 +-
 include/linux/hugetlb.h       |  2 +-
 mm/hugetlb.c                  | 44 ++++++++++++++++++++++++++++-------
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 0a540b37aab62..a1651d5471862 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -226,7 +226,7 @@ static int __init pseries_alloc_bootmem_huge_page(struct hstate *hstate)
 		return 0;
 	m = phys_to_virt(gpage_freearray[--nr_gpages]);
 	gpage_freearray[nr_gpages] = 0;
-	list_add(&m->list, &huge_boot_pages);
+	list_add(&m->list, &huge_boot_pages[0]);
 	m->hstate = hstate;
 	return 1;
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c1ee640d87b11..77b30a8c6076b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -178,7 +178,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
 extern int sysctl_hugetlb_shm_group;
-extern struct list_head huge_boot_pages;
+extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
 /* arch callbacks */
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 385840397bce5..eee0c456f6571 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -69,7 +69,7 @@ static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
 #endif
 static unsigned long hugetlb_cma_size __initdata;
 
-__initdata LIST_HEAD(huge_boot_pages);
+__initdata struct list_head huge_boot_pages[MAX_NUMNODES];
 
 /* for command line parsing */
 static struct hstate * __initdata parsed_hstate;
@@ -3301,7 +3301,7 @@ int alloc_bootmem_huge_page(struct hstate *h, int nid)
 int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
 	struct huge_bootmem_page *m = NULL; /* initialize for clang */
-	int nr_nodes, node;
+	int nr_nodes, node = nid;
 
 	/* do node specific alloc */
 	if (nid != NUMA_NO_NODE) {
@@ -3339,7 +3339,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 		huge_page_size(h) - PAGE_SIZE);
 	/* Put them into a private list first because mem_map is not up yet */
 	INIT_LIST_HEAD(&m->list);
-	list_add(&m->list, &huge_boot_pages);
+	list_add(&m->list, &huge_boot_pages[node]);
 	m->hstate = h;
 	return 1;
 }
@@ -3390,8 +3390,6 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 	/* Send list for bulk vmemmap optimization processing */
 	hugetlb_vmemmap_optimize_folios(h, folio_list);
 
-	/* Add all new pool pages to free lists in one lock cycle */
-	spin_lock_irqsave(&hugetlb_lock, flags);
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
 		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
 			/*
@@ -3404,23 +3402,27 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 					HUGETLB_VMEMMAP_RESERVE_PAGES,
 					pages_per_huge_page(h));
 		}
+		/* Subdivide locks to achieve better parallel performance */
+		spin_lock_irqsave(&hugetlb_lock, flags);
 		__prep_account_new_huge_page(h, folio_nid(folio));
 		enqueue_hugetlb_folio(h, folio);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 	}
-	spin_unlock_irqrestore(&hugetlb_lock, flags);
 }
 
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
  */
-static void __init gather_bootmem_prealloc(void)
+static void __init gather_bootmem_prealloc_node(unsigned long start, unsigned long end, void *arg)
+
 {
+	int nid = start;
 	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
 	struct hstate *h = NULL, *prev_h = NULL;
 
-	list_for_each_entry(m, &huge_boot_pages, list) {
+	list_for_each_entry(m, &huge_boot_pages[nid], list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
 
@@ -3453,6 +3455,22 @@ static void __init gather_bootmem_prealloc(void)
 	prep_and_add_bootmem_folios(h, &folio_list);
 }
 
+static void __init gather_bootmem_prealloc(void)
+{
+	struct padata_mt_job job = {
+		.thread_fn	= gather_bootmem_prealloc_node,
+		.fn_arg		= NULL,
+		.start		= 0,
+		.size		= num_node_state(N_MEMORY),
+		.align		= 1,
+		.min_chunk	= 1,
+		.max_threads	= num_node_state(N_MEMORY),
+		.numa_aware	= true,
+	};
+
+	padata_do_multithreaded(&job);
+}
+
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 {
 	unsigned long i;
@@ -3600,6 +3618,7 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long allocated;
+	static bool initialied __initdata;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
@@ -3607,6 +3626,15 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 		return;
 	}
 
+	/* hugetlb_hstate_alloc_pages will be called many times, initialize huge_boot_pages once */
+	if (!initialied) {
+		int i = 0;
+
+		for (i = 0; i < MAX_NUMNODES; i++)
+			INIT_LIST_HEAD(&huge_boot_pages[i]);
+		initialied = true;
+	}
+
 	/* do node specific alloc */
 	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
 		return;
-- 
2.20.1


