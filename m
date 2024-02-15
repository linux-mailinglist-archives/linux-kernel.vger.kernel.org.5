Return-Path: <linux-kernel+bounces-66636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CDE855F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CD81F231E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB5B12B159;
	Thu, 15 Feb 2024 10:32:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720D712AAD7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993149; cv=none; b=S/0OhcLO6WiEC8pB7M7/k7tE6Qm3AoM+F6HGbsGNfDXXLZi30dGzXkhOKpmGMS6YBmHlrZ6H3UrqYe0xR3nVcFBOMpY/3xEI60klmP8vT34utrYnhGDWrudmAaBsI+7dZLjIwxQ6yfUnY+7CP1NhVWI/0MFXCANNpDqZhEEs1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993149; c=relaxed/simple;
	bh=2hkmQn4Ed8vkkGt4I+ydMlyJoDxhv4t3yUe1PaYNzQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laiq4LB+frTw8Lgb7diwRXB7f/oV3rwWKCxi9NElGoWluLRoRpRDr3Z4JAnF2ylsuQK64bEQCUrdZluOt8RI24l3noqCksBelGjMw5ZrUwYx1xhG9C7vKHMHpcLI//NfEuZxtIjuHpiuhNJD+mvhul40pLoemKZtQw5FWX14HCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A52231480;
	Thu, 15 Feb 2024 02:33:07 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BFF83F7B4;
	Thu, 15 Feb 2024 02:32:23 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/18] mm: thp: Batch-collapse PMD with set_ptes()
Date: Thu, 15 Feb 2024 10:31:49 +0000
Message-Id: <20240215103205.2607016-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215103205.2607016-1-ryan.roberts@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor __split_huge_pmd_locked() so that a present PMD can be
collapsed to PTEs in a single batch using set_ptes().

This should improve performance a little bit, but the real motivation is
to remove the need for the arm64 backend to have to fold the contpte
entries. Instead, since the ptes are set as a batch, the contpte blocks
can be initially set up pre-folded (once the arm64 contpte support is
added in the next few patches). This leads to noticeable performance
improvement during split.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/huge_memory.c | 58 +++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 016e20bd813e..14888b15121e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2579,15 +2579,16 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 	pte = pte_offset_map(&_pmd, haddr);
 	VM_BUG_ON(!pte);
-	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
-		pte_t entry;
-		/*
-		 * Note that NUMA hinting access restrictions are not
-		 * transferred to avoid any possibility of altering
-		 * permissions across VMAs.
-		 */
-		if (freeze || pmd_migration) {
+
+	/*
+	 * Note that NUMA hinting access restrictions are not transferred to
+	 * avoid any possibility of altering permissions across VMAs.
+	 */
+	if (freeze || pmd_migration) {
+		for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
+			pte_t entry;
 			swp_entry_t swp_entry;
+
 			if (write)
 				swp_entry = make_writable_migration_entry(
 							page_to_pfn(page + i));
@@ -2606,25 +2607,32 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_swp_mksoft_dirty(entry);
 			if (uffd_wp)
 				entry = pte_swp_mkuffd_wp(entry);
-		} else {
-			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
-			if (write)
-				entry = pte_mkwrite(entry, vma);
-			if (!young)
-				entry = pte_mkold(entry);
-			/* NOTE: this may set soft-dirty too on some archs */
-			if (dirty)
-				entry = pte_mkdirty(entry);
-			if (soft_dirty)
-				entry = pte_mksoft_dirty(entry);
-			if (uffd_wp)
-				entry = pte_mkuffd_wp(entry);
+
+			VM_WARN_ON(!pte_none(ptep_get(pte + i)));
+			set_pte_at(mm, addr, pte + i, entry);
 		}
-		VM_BUG_ON(!pte_none(ptep_get(pte)));
-		set_pte_at(mm, addr, pte, entry);
-		pte++;
+	} else {
+		pte_t entry;
+
+		entry = mk_pte(page, READ_ONCE(vma->vm_page_prot));
+		if (write)
+			entry = pte_mkwrite(entry, vma);
+		if (!young)
+			entry = pte_mkold(entry);
+		/* NOTE: this may set soft-dirty too on some archs */
+		if (dirty)
+			entry = pte_mkdirty(entry);
+		if (soft_dirty)
+			entry = pte_mksoft_dirty(entry);
+		if (uffd_wp)
+			entry = pte_mkuffd_wp(entry);
+
+		for (i = 0; i < HPAGE_PMD_NR; i++)
+			VM_WARN_ON(!pte_none(ptep_get(pte + i)));
+
+		set_ptes(mm, haddr, pte, entry, HPAGE_PMD_NR);
 	}
-	pte_unmap(pte - 1);
+	pte_unmap(pte);
 
 	if (!pmd_migration)
 		folio_remove_rmap_pmd(folio, page, vma);
-- 
2.25.1


