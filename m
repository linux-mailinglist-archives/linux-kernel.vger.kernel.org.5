Return-Path: <linux-kernel+bounces-167123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4078BA4B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332B92856A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7E5101EC;
	Fri,  3 May 2024 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+jvNSbB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C015E9B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697488; cv=none; b=sTDOhvIe6k4PCAJ93IottPt4Z0vjo18gkGwXtjyPtoVbtO5DcF8t6FbJbl5RLISjesWJ+2Q/KeEoxpAjk8VVzv1FBOibZ3oqlDw+7HH7Ie180edMUddPKmvpaai/f/OxRzP3KieL18mEac+VUdjjzXFsYb6sLj3T1dreWeOPww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697488; c=relaxed/simple;
	bh=YzHhYMj3uQPxfTb6VikRZEwdmbE7GFcDdgDgNuXcpRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXjNW4f5ts10s2wf/7Bb2bdVOpfsHCznOJ/RkyFcmy4hAU9mSSlWblsC9BFxtHXCkZ2X0JZtPiLn74Sb0wqREeOzhKZw9HYUHffNAdOIeas0INI/FtF52AjP1BcvjIbiz0dMIp9lhg3bLLpWbNADSA0ahbA3UXDyF+UA48q0fFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+jvNSbB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed012c1afbso9547405ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714697486; x=1715302286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCPlcQiDc4aEgZRUGIFwOS4XTVcepx+utYhjOWkqIL0=;
        b=i+jvNSbBO0RFzCaTpVfmycbfcuty+Qt26T6FJufmncje1bqOB5uuUv4xVxxfLGRsKh
         sQYVLOgoOAAzHEH6d7vdSS9YQJYo/jg0Z/kbrrVWq5ixVJbV089nBmuvvLDLqGp3epMD
         DQd2YHAVBnLeLnH1PnHnY3hTBzBG3+Kh0/Q5gwXL+3enQkt65ECRNK0uvRsa0U3QEx7v
         xEAaW4Csi3ovx+VZWu1x+xAnE5xGWCyulUzGWND3f3x+DWHfsIBzR/yRIfnUSGrnuPtN
         g1x4zbV8v1NzuvZAMDBrYzWtKVcLZds7j0Szat1Jg7BBwm+6eKeRPOlAYJ/jWCJDGfbV
         xuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697486; x=1715302286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCPlcQiDc4aEgZRUGIFwOS4XTVcepx+utYhjOWkqIL0=;
        b=dTd9giwMEuBQk0pvX3pmLz+E1KR+VVyZLfyGS3xJgzYvvuqglq4SD8eR1bNp09bQLR
         rmRE9TdGBtFh/iHLNac+Te4CLZ+6Sy0PrhA2jF3s1qbsN8XcLbJAu5+aVo+YjzqDIotd
         k6SepZ9AeuQXJ8VwzaIbDzzdEGPDQQwQY4AoeH8M1zp7cX861kRb4nH8wbrv+uGy7gHs
         tHhgN7NqB+L9BVVKZko1JeDmXQJo0kPJuVioXEutsv74ISrhlFSOoAccDKzJk5Vruci9
         Tu2cPNAbGRjlRWQa7er6w2pHUSGjEy2Iwd4zA5qJX5+JFoviwU665XMUwOF+U/jk7bi8
         xTtg==
X-Forwarded-Encrypted: i=1; AJvYcCVrAsF0YQcWbrnfHhoQbS1S0NZ2iJI1ujStgOS1qN08aZh5yv5YsUiuYZEOYz/G+EmSNVAuhrkr0WqYaKec36vQCjmncQWbrF1Wq7xm
X-Gm-Message-State: AOJu0Yz+Qb50NpHa7UuSc2dH1zOO16Mc0oGnUIoCEJp+G1XsScso/m6U
	sdAbkK+bItHuAx26cno2ZT8R48G8Zg5d+kgsxv5Ei4KpCnD9fKxc
X-Google-Smtp-Source: AGHT+IHl/5rfXtgmTPFxtFxlvOgwDmCzyiDZXrRPvhqN/z1hpeuCBJnRPssnBcPqlIhHPeY6Yn+CcQ==
X-Received: by 2002:a17:902:c407:b0:1e5:e676:4b09 with SMTP id k7-20020a170902c40700b001e5e6764b09mr1726427plk.25.1714697486404;
        Thu, 02 May 2024 17:51:26 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001ec48e41d2esm1969175plh.212.2024.05.02.17.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:51:26 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v3 6/6] mm: swap: entirely map large folios found in swapcache
Date: Fri,  3 May 2024 12:50:23 +1200
Message-Id: <20240503005023.174597-7-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503005023.174597-1-21cnbao@gmail.com>
References: <20240503005023.174597-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

When a large folio is found in the swapcache, the current implementation
requires calling do_swap_page() nr_pages times, resulting in nr_pages
page faults. This patch opts to map the entire large folio at once to
minimize page faults. Additionally, redundant checks and early exits
for ARM64 MTE restoring are removed.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 22e7c33cc747..940fdbe69fa1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
+	int nr_pages = 1;
+	unsigned long page_idx = 0;
+	unsigned long address = vmf->address;
+	pte_t *ptep;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_nomap;
 	}
 
+	ptep = vmf->pte;
+	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
+		int nr = folio_nr_pages(folio);
+		unsigned long idx = folio_page_idx(folio, page);
+		unsigned long folio_start = vmf->address - idx * PAGE_SIZE;
+		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
+		pte_t *folio_ptep;
+		pte_t folio_pte;
+
+		if (unlikely(folio_start < max(vmf->address & PMD_MASK, vma->vm_start)))
+			goto check_folio;
+		if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->vm_end)))
+			goto check_folio;
+
+		folio_ptep = vmf->pte - idx;
+		folio_pte = ptep_get(folio_ptep);
+		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
+		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
+			goto check_folio;
+
+		page_idx = idx;
+		address = folio_start;
+		ptep = folio_ptep;
+		nr_pages = nr;
+		entry = folio->swap;
+		page = &folio->page;
+	}
+
+check_folio:
+
 	/*
 	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
 	 * must never point at an anonymous page in the swapcache that is
@@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * We're already holding a reference on the page but haven't mapped it
 	 * yet.
 	 */
-	swap_free_nr(entry, 1);
+	swap_free_nr(entry, nr_pages);
 	if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+	folio_ref_add(folio, nr_pages - 1);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	/*
@@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * exclusivity.
 	 */
 	if (!folio_test_ksm(folio) &&
-	    (exclusive || folio_ref_count(folio) == 1)) {
+	    (exclusive || (folio_ref_count(folio) == nr_pages &&
+			   folio_nr_pages(folio) == nr_pages))) {
 		if (vmf->flags & FAULT_FLAG_WRITE) {
 			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 			vmf->flags &= ~FAULT_FLAG_WRITE;
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
-	flush_icache_page(vma, page);
+	flush_icache_pages(vma, page, nr_pages);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
 	if (pte_swp_uffd_wp(vmf->orig_pte))
 		pte = pte_mkuffd_wp(pte);
-	vmf->orig_pte = pte;
+	vmf->orig_pte = pte_advance_pfn(pte, page_idx);
 
 	/* ksm created a completely new copy */
 	if (unlikely(folio != swapcache && swapcache)) {
-		folio_add_new_anon_rmap(folio, vma, vmf->address);
+		folio_add_new_anon_rmap(folio, vma, address);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
+		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
 					rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
-			pte, vmf->orig_pte, 1);
+	set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
+	arch_do_swap_page_nr(vma->vm_mm, vma, address,
+			pte, pte, nr_pages);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
@@ -4291,7 +4327,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	update_mmu_cache_range(vmf, vma, address, ptep, nr_pages);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-- 
2.34.1


