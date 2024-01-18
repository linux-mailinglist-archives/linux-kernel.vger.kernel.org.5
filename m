Return-Path: <linux-kernel+bounces-30110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A3831947
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DE61C22F62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C1F2C193;
	Thu, 18 Jan 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ur3J0rdF"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A92941B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581582; cv=none; b=WRyQh6sbTLibwd43lLE4+EXle++93loRY+rt92fja5kO4zXTh1weca2V6hZ0U2FoSnTrSBY/ktJR5qTnR66ZAIhm4Ht/pFJB3e1jxiIaSRdUf1RAGEgeYh6XV6yvY7DmTzvvlQHUS6Gb8CYaIT0PUbSJidw0zARthybjZ8SA374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581582; c=relaxed/simple;
	bh=KAUJjBxia9wk+iRLLIfTP61p2acEJKBvxPRVPu03VSE=;
	h=X-Report-Abuse:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Migadu-Flow; b=KnImcLS/p6je5T6sNsbbn+W0AcdRCg4h4uhNMEVLd1g62ecLTgo6PSussSvTezcmK525qEidSKMyejLg7Y/ap5VrtnbQC3dTGNAXFFxqTj54TAm6Isu5Cmb04HkkoolpTekT0oSBnmNybx2bzSSVu0BsDm/0FQkNXKvZcTGvrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ur3J0rdF; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705581579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASpAHuGdRPUV+HgZTqugmZdcOurDfxWM74nOvo7+sGU=;
	b=ur3J0rdFoKrBHOlkNFrybggpwIpG8n2CJi1qMK84hfgA7E/TaiI1w9l1BBbJDIM1msiwBL
	gh9ANKc6TXOhjrRqRFpEcDA4BexqtUJi0cSm6TSIfI5jMiX4hdqupg3XRmcKAxMIh5GVCp
	t+89Jvp6g6U0aik5bbwsy7+HbeHAzPc=
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
Subject: [PATCH v4 7/7] hugetlb: parallelize 1G hugetlb initialization
Date: Thu, 18 Jan 2024 20:39:11 +0800
Message-Id: <20240118123911.88833-8-gang.li@linux.dev>
In-Reply-To: <20240118123911.88833-1-gang.li@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
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
Tested-by: David Rientjes <rientjes@google.com>
---
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 42 +++++++++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c1ee640d87b1..77b30a8c6076 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -178,7 +178,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
 extern int sysctl_hugetlb_shm_group;
-extern struct list_head huge_boot_pages;
+extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
 /* arch callbacks */
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9b348ba418f5..2f4b77630ada 100644
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
@@ -3602,6 +3620,14 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
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
 	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
 		return;
-- 
2.20.1


