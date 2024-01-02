Return-Path: <linux-kernel+bounces-14388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22944821C62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60861F22A15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CEB14F7A;
	Tue,  2 Jan 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wooXcU/d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4386B14F61
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704201226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PV0S7W1YGzJ0pEPZj279MYSeM1ClpTdHk3joXGH5wj8=;
	b=wooXcU/dpB/9amxwWmyP5fx/4g8+s4Wt1e1ITrrRQgXh2eG2jtsfU0P9ici3t88EkmQfCM
	MJRecVKTfFX3pTTZU6TfsN5mYo5/0+ARbG4H+KzX5EFaHgXHY+NU17YkBHCK8+K0nyvYdy
	VrYNkQIKDDwuAPmaCwH0QTwGhcuFBOI=
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
Subject: [PATCH v3 7/7] hugetlb: parallelize 1G hugetlb initialization
Date: Tue,  2 Jan 2024 21:12:49 +0800
Message-Id: <20240102131249.76622-8-gang.li@linux.dev>
In-Reply-To: <20240102131249.76622-1-gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
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
        test          no patch(ms)   patched(ms)   saved
 ------------------- -------------- ------------- --------
  256c2t(4 node) 1G           4745          2024   57.34%
  128c1t(2 node) 1G           3358          1712   49.02%
      12t        1G          77000         18300   76.23%

Signed-off-by: Gang Li <gang.li@linux.dev>
---
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 40 +++++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 8 deletions(-)

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
index d1629df5f399f..e5a55707f8814 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -69,7 +69,7 @@ static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
 #endif
 static unsigned long hugetlb_cma_size __initdata;
 
-__initdata LIST_HEAD(huge_boot_pages);
+__initdata struct list_head huge_boot_pages[MAX_NUMNODES];
 
 /* for command line parsing */
 static struct hstate * __initdata parsed_hstate;
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
+static void __init __gather_bootmem_prealloc(unsigned long start, unsigned long end, void *arg)
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
+		.thread_fn	= __gather_bootmem_prealloc,
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
@@ -3606,6 +3624,14 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 		return;
 	}
 
+	/* hugetlb_hstate_alloc_pages will be called many times, init huge_boot_pages once*/
+	if (huge_boot_pages[0].next == NULL) {
+		int i = 0;
+
+		for (i = 0; i < MAX_NUMNODES; i++)
+			INIT_LIST_HEAD(&huge_boot_pages[i]);
+	}
+
 	/* do node specific alloc */
 	if (hugetlb_hstate_alloc_pages_node_specific(h))
 		return;
-- 
2.20.1


