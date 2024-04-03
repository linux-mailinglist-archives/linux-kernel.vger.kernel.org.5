Return-Path: <linux-kernel+bounces-129351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A218968EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1617284FE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991376EB7C;
	Wed,  3 Apr 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qkbe6NUo"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FD44C8C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133573; cv=none; b=pIO1PmxxZj5o3NSfOjzADgY8b9cs7oPTr+dz3kztNwzTSyn1kYvRlos6sMqmUE6Pt0pAzPU9keJ7hvklhBzns/ED5/HvcLl2cKAFWn2rr+mTAIF7y7QFfP1P2YJV19CuoBM0mL4Ju90sPNSyA2ywSXV6Rtyb0H7XHkNfNiolAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133573; c=relaxed/simple;
	bh=3CQ/ujDqw1UmfH007IlD358QTRcUCjw7Ixl/LDHwJRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXBW37f/tv+tOXMJmHrYkZ8UAhjesZDj1Bos2LIdxYmy1488+f6EkANaNlmQZgmSA8p06B+dy9hlDoIMAhZ6PUo5wu0DzqLXb5BUtp0re4AjyOdxSDkgQJlzU995BUoUT4uCFTuJ9yJStS5t7VlRC+C6jqe1KcL8kEQHCAkhF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qkbe6NUo; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712133563; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dJyQ2t09mQLZqD5haLWTwuWBgyt7BYeOyjErTFbdfvE=;
	b=qkbe6NUoB0Xgp2T8Dyo2fsFId3iwgwsJ/sCFrbOWUMXOuxzTdxA+31mOG8cQ9nBVv0KS7AXFPxmEYKqL5WGuqvo8Sozl1mjczk2ML0iKN8R4PngUhHUw1DPAhsyyGkOnQW75A7EbUb44CSK1PRABOLsOhtGrhK2c/eDsUqTwoO8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3rEr4s_1712133560;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3rEr4s_1712133560)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 16:39:20 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	mgorman@techsingularity.net,
	wangkefeng.wang@huawei.com,
	jhubbard@nvidia.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm: support multi-size THP numa balancing
Date: Wed,  3 Apr 2024 16:39:10 +0800
Message-Id: <c33a5c0b0a0323b1f8ed53772f50501f4b196e25.1712132950.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1712132950.git.baolin.wang@linux.alibaba.com>
References: <cover.1712132950.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the anonymous page allocation already supports multi-size THP (mTHP),
but the numa balancing still prohibits mTHP migration even though it is an
exclusive mapping, which is unreasonable.

Allow scanning mTHP:
Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
pages") skips shared CoW pages' NUMA page migration to avoid shared data
segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
NUMA-migrate COW pages that have other uses") change to use page_count()
to avoid GUP pages migration, that will also skip the mTHP numa scanning.
Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
issue, although there is still a GUP race, the issue seems to have been
resolved by commit 80d47f5de5e3. Meanwhile, use the folio_likely_mapped_shared()
to skip shared CoW pages though this is not a precise sharers count. To
check if the folio is shared, ideally we want to make sure every page is
mapped to the same process, but doing that seems expensive and using
the estimated mapcount seems can work when running autonuma benchmark.

Allow migrating mTHP:
As mentioned in the previous thread[1], large folios (including THP) are
more susceptible to false sharing issues among threads than 4K base page,
leading to pages ping-pong back and forth during numa balancing, which is
currently not easy to resolve. Therefore, as a start to support mTHP numa
balancing, we can follow the PMD mapped THP's strategy, that means we can
reuse the 2-stage filter in should_numa_migrate_memory() to check if the
mTHP is being heavily contended among threads (through checking the CPU id
and pid of the last access) to avoid false sharing at some degree. Thus,
we can restore all PTE maps upon the first hint page fault of a large folio
to follow the PMD mapped THP's strategy. In the future, we can continue to
optimize the NUMA balancing algorithm to avoid the false sharing issue with
large folios as much as possible.

Performance data:
Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
Base: 2024-03-25 mm-unstable branch
Enable mTHP to run autonuma-benchmark

mTHP:16K
Base				Patched
numa01				numa01
224.70				143.48
numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
118.05				47.43
numa02				numa02
13.45				9.29
numa02_SMT			numa02_SMT
14.80				7.50

mTHP:64K
Base				Patched
numa01				numa01
216.15				114.40
numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
115.35				47.41
numa02				numa02
13.24				9.25
numa02_SMT			numa02_SMT
14.67				7.34

mTHP:128K
Base				Patched
numa01				numa01
205.13				144.45
numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
112.93				41.88
numa02				numa02
13.16				9.18
numa02_SMT			numa02_SMT
14.81				7.49

[1] https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/memory.c   | 62 +++++++++++++++++++++++++++++++++++++++++----------
 mm/mprotect.c |  3 ++-
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c30fb4b95e15..c6c216d9d95f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5055,17 +5055,51 @@ int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
 }
 
 static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
+					unsigned long fault_addr, pte_t *fault_pte,
 					bool writable)
 {
 	pte_t pte, old_pte;
 
-	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
+	old_pte = ptep_modify_prot_start(vma, fault_addr, fault_pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (writable)
 		pte = pte_mkwrite(pte, vma);
-	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	ptep_modify_prot_commit(vma, fault_addr, fault_pte, old_pte, pte);
+	update_mmu_cache_range(vmf, vma, fault_addr, fault_pte, 1);
+}
+
+static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
+				       struct folio *folio, pte_t fault_pte,
+				       bool ignore_writable, bool pte_write_upgrade)
+{
+	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
+	unsigned long start = max(vmf->address - nr * PAGE_SIZE, vma->vm_start);
+	unsigned long end = min(vmf->address + (folio_nr_pages(folio) - nr) * PAGE_SIZE, vma->vm_end);
+	pte_t *start_ptep = vmf->pte - (vmf->address - start) / PAGE_SIZE;
+	unsigned long addr;
+
+	/* Restore all PTEs' mapping of the large folio */
+	for (addr = start; addr != end; start_ptep++, addr += PAGE_SIZE) {
+		pte_t ptent = ptep_get(start_ptep);
+		bool writable = false;
+
+		if (!pte_present(ptent) || !pte_protnone(ptent))
+			continue;
+
+		if (pfn_folio(pte_pfn(ptent)) != folio)
+			continue;
+
+		if (!ignore_writable) {
+			ptent = pte_modify(ptent, vma->vm_page_prot);
+			writable = pte_write(ptent);
+			if (!writable && pte_write_upgrade &&
+			    can_change_pte_writable(vma, addr, ptent))
+				writable = true;
+		}
+
+		numa_rebuild_single_mapping(vmf, vma, addr, start_ptep, writable);
+	}
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
@@ -5073,11 +5107,12 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = NULL;
 	int nid = NUMA_NO_NODE;
-	bool writable = false;
+	bool writable = false, ignore_writable = false;
+	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
 	int last_cpupid;
 	int target_nid;
 	pte_t pte, old_pte;
-	int flags = 0;
+	int flags = 0, nr_pages;
 
 	/*
 	 * The pte cannot be used safely until we verify, while holding the page
@@ -5099,7 +5134,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * is only valid while holding the PT lock.
 	 */
 	writable = pte_write(pte);
-	if (!writable && vma_wants_manual_pte_write_upgrade(vma) &&
+	if (!writable && pte_write_upgrade &&
 	    can_change_pte_writable(vma, vmf->address, pte))
 		writable = true;
 
@@ -5107,10 +5142,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
-	/* TODO: handle PTE-mapped THP */
-	if (folio_test_large(folio))
-		goto out_map;
-
 	/*
 	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
 	 * much anyway since they can be in shared cache state. This misses
@@ -5130,6 +5161,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_SHARED;
 
 	nid = folio_nid(folio);
+	nr_pages = folio_nr_pages(folio);
 	/*
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
@@ -5146,6 +5178,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	}
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	writable = false;
+	ignore_writable = true;
 
 	/* Migrate to the requested node */
 	if (migrate_misplaced_folio(folio, vma, target_nid)) {
@@ -5166,14 +5199,19 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 out:
 	if (nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, 1, flags);
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
 	return 0;
 out_map:
 	/*
 	 * Make it present again, depending on how arch implements
 	 * non-accessible ptes, some can allow access by kernel mode.
 	 */
-	numa_rebuild_single_mapping(vmf, vma, writable);
+	if (folio && folio_test_large(folio))
+		numa_rebuild_large_mapping(vmf, vma, folio, pte, ignore_writable,
+					   pte_write_upgrade);
+	else
+		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
+					    writable);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	goto out;
 }
diff --git a/mm/mprotect.c b/mm/mprotect.c
index f8a4544b4601..94878c39ee32 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -129,7 +129,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 
 				/* Also skip shared copy-on-write pages */
 				if (is_cow_mapping(vma->vm_flags) &&
-				    folio_ref_count(folio) != 1)
+				    (folio_maybe_dma_pinned(folio) ||
+				     folio_likely_mapped_shared(folio)))
 					continue;
 
 				/*
-- 
2.39.3


