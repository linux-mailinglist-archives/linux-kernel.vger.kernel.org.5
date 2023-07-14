Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54A7531D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjGNGOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjGNGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:14:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D8602680
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:14:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C25591570;
        Thu, 13 Jul 2023 23:15:29 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.49.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3B4B3F73F;
        Thu, 13 Jul 2023 23:14:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/rmap: Convert rmap_t into enum rmap_flags
Date:   Fri, 14 Jul 2023 11:44:38 +0530
Message-Id: <20230714061438.122391-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rmap_t tracks bitwise positions for various page reverse map related flags.
enum could provide more compact representation. This converts these flags
into an enum listing, without any functional change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.5-rc1

 include/linux/rmap.h | 26 +++++++-------------------
 mm/huge_memory.c     |  2 +-
 mm/memory.c          |  2 +-
 mm/migrate.c         |  2 +-
 mm/rmap.c            |  4 ++--
 mm/swapfile.c        |  2 +-
 6 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b87d01660412..aee6ee7ddac6 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -168,30 +168,18 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *folio_get_anon_vma(struct folio *folio);
 
-/* RMAP flags, currently only relevant for some anon rmap operations. */
-typedef int __bitwise rmap_t;
-
-/*
- * No special request: if the page is a subpage of a compound page, it is
- * mapped via a PTE. The mapped (sub)page is possibly shared between processes.
- */
-#define RMAP_NONE		((__force rmap_t)0)
-
-/* The (sub)page is exclusive to a single process. */
-#define RMAP_EXCLUSIVE		((__force rmap_t)BIT(0))
-
-/*
- * The compound page is not mapped via PTEs, but instead via a single PMD and
- * should be accounted accordingly.
- */
-#define RMAP_COMPOUND		((__force rmap_t)BIT(1))
+enum rmap_flags {
+	RMAP_NONE	= 0x0,	/* No special request - (sub)page is mapped via a single PTE */
+	RMAP_EXCLUSIVE	= 0x1,	/* The (sub)page is exclusive to a single process */
+	RMAP_COMPOUND	= 0x2,	/* The compound page is mapped via a single PMD */
+};
 
 /*
  * rmap interfaces called when adding or removing pte of page
  */
 void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long address, rmap_t flags);
+		unsigned long address, enum rmap_flags flags);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address);
 void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
@@ -202,7 +190,7 @@ void page_remove_rmap(struct page *, struct vm_area_struct *,
 		bool compound);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long address, rmap_t flags);
+		unsigned long address, enum rmap_flags flags);
 void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 965d845d73fc..79a790d1cfa8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3297,7 +3297,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		pmde = pmd_mkdirty(pmde);
 
 	if (PageAnon(new)) {
-		rmap_t rmap_flags = RMAP_COMPOUND;
+		enum rmap_flags rmap_flags = RMAP_COMPOUND;
 
 		if (!is_readable_migration_entry(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
diff --git a/mm/memory.c b/mm/memory.c
index 01f39e8144ef..1710aa6826d4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3717,7 +3717,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct folio *swapcache, *folio = NULL;
 	struct page *page;
 	struct swap_info_struct *si = NULL;
-	rmap_t rmap_flags = RMAP_NONE;
+	enum rmap_flags rmap_flags = RMAP_NONE;
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
diff --git a/mm/migrate.c b/mm/migrate.c
index 24baad2571e3..bdb73b11845a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -186,7 +186,7 @@ static bool remove_migration_pte(struct folio *folio,
 	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
 
 	while (page_vma_mapped_walk(&pvmw)) {
-		rmap_t rmap_flags = RMAP_NONE;
+		enum rmap_flags rmap_flags = RMAP_NONE;
 		pte_t old_pte;
 		pte_t pte;
 		swp_entry_t entry;
diff --git a/mm/rmap.c b/mm/rmap.c
index 0c0d8857dfce..4d4c821d8e56 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1213,7 +1213,7 @@ static void __page_check_anon_rmap(struct page *page,
  * (but PageKsm is never downgraded to PageAnon).
  */
 void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
-		unsigned long address, rmap_t flags)
+		unsigned long address, enum rmap_flags flags)
 {
 	struct folio *folio = page_folio(page);
 	atomic_t *mapped = &folio->_nr_pages_mapped;
@@ -2539,7 +2539,7 @@ void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc)
  * RMAP_COMPOUND is ignored.
  */
 void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
-			    unsigned long address, rmap_t flags)
+			    unsigned long address, enum rmap_flags flags)
 {
 	struct folio *folio = page_folio(page);
 	struct anon_vma *anon_vma = vma->anon_vma;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8e6dde68b389..3a9b1d8b3151 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1788,7 +1788,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	get_page(page);
 	if (page == swapcache) {
-		rmap_t rmap_flags = RMAP_NONE;
+		enum rmap_flags rmap_flags = RMAP_NONE;
 
 		/*
 		 * See do_swap_page(): PageWriteback() would be problematic.
-- 
2.30.2

