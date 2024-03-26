Return-Path: <linux-kernel+bounces-118924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A088C144
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A65B23213
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B07173C;
	Tue, 26 Mar 2024 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xaO2fr1c"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F66BFCB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453904; cv=none; b=Zeo8Rjm7XMQF8WwBS81aU/3pF5LcARa/7cfXGp70dbjTbtcpyvJV+D43MV7xeXvbTfa4bnBJvuHAZjVgJbMdHh7etvOB4S2sMGlSc1xdfwKZLWS0fDKc8USQd+z/3ImEZOOmrAzNkxZtQYSL9mprhRb+yHc+TRNVrFg4jLoVDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453904; c=relaxed/simple;
	bh=3A9NL0YFY4aJmuwuoSe0HBvblAKeymm7qJNy2a+QBvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bF6RdpAmfUzwzKFxkbNL4Pclx5ni79Td97Zy/Uf8U42exyk6LhmTDi1D+FC/HQRN5Sj5Pl89wtrfK92clmg3peYPV7liu7QROe4P/7o/gQeGlRU4kZEJf1P7fzCsbsJ64uLD4vWeSDMJ5BvbnK8G8w3pQhybAFKrzmY9eNJzGKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xaO2fr1c; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711453899; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qq9URdAuWFaYVRUE0/jOGxRLImW74nNlrBDDLc2W6Zw=;
	b=xaO2fr1cCBwmKuVUZTU1dyG4ygflCnkOCftVfXp8KHf7INTrkQEyBlZ5rqFLtc8hGhrgHQeST0lCYQYScrfPzY2efT68w7rS8jIMBUR6d6rXpbuXryD1p+KSrm/B79p+nxO3HUmU1oyP2HYPQ7uhgngsxN9swlslqPEOMZ4clJk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3LKqyp_1711453897;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3LKqyp_1711453897)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 19:51:37 +0800
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
Subject: [PATCH 2/2] mm: support multi-size THP numa balancing
Date: Tue, 26 Mar 2024 19:51:25 +0800
Message-Id: <dee4268f1797f31c6bb6bdab30f8ad3df9053d3d.1711453317.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
References: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
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
to avoid GUP pages migration, that will also skip the mTHP numa scaning.
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
224.70				137.23
numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
118.05				50.57
numa02				numa02
13.45				9.30
numa02_SMT			numa02_SMT
14.80				7.43

mTHP:64K
Base				Patched
numa01				numa01
216.15				135.20
numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
115.35				46.93
numa02				numa02
13.24				9.24
numa02_SMT			numa02_SMT
14.67				7.31

mTHP:128K
Base				Patched
numa01				numa01
205.13				140.41
numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
112.93				44.78
numa02				numa02
13.16				9.19
numa02_SMT			numa02_SMT
14.81				7.39

[1] https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c   | 56 +++++++++++++++++++++++++++++++++++++++++++--------
 mm/mprotect.c |  3 ++-
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c30fb4b95e15..36191a9c799c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5068,16 +5068,55 @@ static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_area_str
 	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
 }
 
+static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
+				       struct folio *folio, pte_t fault_pte, bool ignore_writable)
+{
+	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
+	unsigned long start = max(vmf->address - nr * PAGE_SIZE, vma->vm_start);
+	unsigned long end = min(start + folio_nr_pages(folio) * PAGE_SIZE, vma->vm_end);
+	pte_t *start_ptep = vmf->pte - (vmf->address - start) / PAGE_SIZE;
+	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
+	unsigned long addr;
+
+	/* Restore all PTEs' mapping of the large folio */
+	for (addr = start; addr != end; start_ptep++, addr += PAGE_SIZE) {
+		pte_t pte, old_pte;
+		pte_t ptent = ptep_get(start_ptep);
+		bool writable = false;
+
+		if (!pte_present(ptent) || !pte_protnone(ptent))
+			continue;
+
+		if (vm_normal_folio(vma, addr, ptent) != folio)
+			continue;
+
+		if (!ignore_writable) {
+			writable = pte_write(pte);
+			if (!writable && pte_write_upgrade &&
+			    can_change_pte_writable(vma, addr, pte))
+				writable = true;
+		}
+
+		old_pte = ptep_modify_prot_start(vma, addr, start_ptep);
+		pte = pte_modify(old_pte, vma->vm_page_prot);
+		pte = pte_mkyoung(pte);
+		if (writable)
+			pte = pte_mkwrite(pte, vma);
+		ptep_modify_prot_commit(vma, addr, start_ptep, old_pte, pte);
+		update_mmu_cache_range(vmf, vma, addr, start_ptep, 1);
+	}
+}
+
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = NULL;
 	int nid = NUMA_NO_NODE;
-	bool writable = false;
+	bool writable = false, ignore_writable = false;
 	int last_cpupid;
 	int target_nid;
 	pte_t pte, old_pte;
-	int flags = 0;
+	int flags = 0, nr_pages;
 
 	/*
 	 * The pte cannot be used safely until we verify, while holding the page
@@ -5107,10 +5146,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
-	/* TODO: handle PTE-mapped THP */
-	if (folio_test_large(folio))
-		goto out_map;
-
 	/*
 	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
 	 * much anyway since they can be in shared cache state. This misses
@@ -5130,6 +5165,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_SHARED;
 
 	nid = folio_nid(folio);
+	nr_pages = folio_nr_pages(folio);
 	/*
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
@@ -5146,6 +5182,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	}
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	writable = false;
+	ignore_writable = true;
 
 	/* Migrate to the requested node */
 	if (migrate_misplaced_folio(folio, vma, target_nid)) {
@@ -5166,14 +5203,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
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
+		numa_rebuild_large_mapping(vmf, vma, folio, pte, ignore_writable);
+	else
+		numa_rebuild_single_mapping(vmf, vma, writable);
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


