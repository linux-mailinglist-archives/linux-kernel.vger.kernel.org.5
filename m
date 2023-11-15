Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5E7EC8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjKOQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjKOQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:31:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 175DDD57
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:31:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B84FDA7;
        Wed, 15 Nov 2023 08:32:04 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1AE63F641;
        Wed, 15 Nov 2023 08:31:15 -0800 (PST)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown
Date:   Wed, 15 Nov 2023 16:30:18 +0000
Message-Id: <20231115163018.1303287-15-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115163018.1303287-1-ryan.roberts@arm.com>
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
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

ptep_get_and_clear_full() adds a 'full' parameter which is not present
for the fallback ptep_get_and_clear() function. 'full' is set to 1 when
a full address space teardown is in progress. We use this information to
optimize arm64_sys_exit_group() by avoiding unfolding (and therefore
tlbi) contiguous ranges. Instead we just clear the PTE but allow all the
contiguous neighbours to keep their contig bit set, because we know we
are about to clear the rest too.

Before this optimization, the cost of arm64_sys_exit_group() exploded to
32x what it was before PTE_CONT support was wired up, when compiling the
kernel. With this optimization in place, we are back down to the
original cost.

This approach is not perfect though, as for the duration between
returning from the first call to ptep_get_and_clear_full() and making
the final call, the contpte block in an intermediate state, where some
ptes are cleared and others are still set with the PTE_CONT bit. If any
other APIs are called for the ptes in the contpte block during that
time, we have to be very careful. The core code currently interleaves
calls to ptep_get_and_clear_full() with ptep_get() and so ptep_get()
must be careful to ignore the cleared entries when accumulating the
access and dirty bits - the same goes for ptep_get_lockless(). The only
other calls we might resonably expect are to set markers in the
previously cleared ptes. (We shouldn't see valid entries being set until
after the tlbi, at which point we are no longer in the intermediate
state). Since markers are not valid, this is safe; set_ptes() will see
the old, invalid entry and will not attempt to unfold. And the new pte
is also invalid so it won't attempt to fold. We shouldn't see this for
the 'full' case anyway.

The last remaining issue is returning the access/dirty bits. That info
could be present in any of the ptes in the contpte block. ptep_get()
will gather those bits from across the contpte block. We don't bother
doing that here, because we know that the information is used by the
core-mm to mark the underlying folio as accessed/dirty. And since the
same folio must be underpinning the whole block (that was a requirement
for folding in the first place), that information will make it to the
folio eventually once all the ptes have been cleared. This approach
means we don't have to play games with accumulating and storing the
bits. It does mean that any interleaved calls to ptep_get() may lack
correct access/dirty information if we have already cleared the pte that
happened to store it. The core code does not rely on this though.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 18 +++++++++--
 arch/arm64/mm/contpte.c          | 54 ++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9bd2f57a9e11..ea58a9f4e700 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1145,6 +1145,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
 extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
 extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr);
+extern pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
@@ -1270,12 +1272,24 @@ static inline void pte_clear(struct mm_struct *mm,
 	__pte_clear(mm, addr, ptep);
 }
 
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
+static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep, int full)
+{
+	pte_t orig_pte = __ptep_get(ptep);
+
+	if (!pte_valid_cont(orig_pte) || !full) {
+		contpte_try_unfold(mm, addr, ptep, orig_pte);
+		return __ptep_get_and_clear(mm, addr, ptep);
+	} else
+		return contpte_ptep_get_and_clear_full(mm, addr, ptep);
+}
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
-	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-	return __ptep_get_and_clear(mm, addr, ptep);
+	return ptep_get_and_clear_full(mm, addr, ptep, 0);
 }
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 426be9cd4dea..5d1aaed82d32 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -144,6 +144,14 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
 	for (i = 0; i < CONT_PTES; i++, ptep++) {
 		pte = __ptep_get(ptep);
 
+		/*
+		 * Deal with the partial contpte_ptep_get_and_clear_full() case,
+		 * where some of the ptes in the range may be cleared but others
+		 * are still to do. See contpte_ptep_get_and_clear_full().
+		 */
+		if (pte_val(pte) == 0)
+			continue;
+
 		if (pte_dirty(pte))
 			orig_pte = pte_mkdirty(orig_pte);
 
@@ -256,6 +264,52 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(contpte_set_ptes);
 
+pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
+					unsigned long addr, pte_t *ptep)
+{
+	/*
+	 * When doing a full address space teardown, we can avoid unfolding the
+	 * contiguous range, and therefore avoid the associated tlbi. Instead,
+	 * just get and clear the pte. The caller is promising to call us for
+	 * every pte, so every pte in the range will be cleared by the time the
+	 * tlbi is issued.
+	 *
+	 * This approach is not perfect though, as for the duration between
+	 * returning from the first call to ptep_get_and_clear_full() and making
+	 * the final call, the contpte block in an intermediate state, where
+	 * some ptes are cleared and others are still set with the PTE_CONT bit.
+	 * If any other APIs are called for the ptes in the contpte block during
+	 * that time, we have to be very careful. The core code currently
+	 * interleaves calls to ptep_get_and_clear_full() with ptep_get() and so
+	 * ptep_get() must be careful to ignore the cleared entries when
+	 * accumulating the access and dirty bits - the same goes for
+	 * ptep_get_lockless(). The only other calls we might resonably expect
+	 * are to set markers in the previously cleared ptes. (We shouldn't see
+	 * valid entries being set until after the tlbi, at which point we are
+	 * no longer in the intermediate state). Since markers are not valid,
+	 * this is safe; set_ptes() will see the old, invalid entry and will not
+	 * attempt to unfold. And the new pte is also invalid so it won't
+	 * attempt to fold. We shouldn't see this for the 'full' case anyway.
+	 *
+	 * The last remaining issue is returning the access/dirty bits. That
+	 * info could be present in any of the ptes in the contpte block.
+	 * ptep_get() will gather those bits from across the contpte block. We
+	 * don't bother doing that here, because we know that the information is
+	 * used by the core-mm to mark the underlying folio as accessed/dirty.
+	 * And since the same folio must be underpinning the whole block (that
+	 * was a requirement for folding in the first place), that information
+	 * will make it to the folio eventually once all the ptes have been
+	 * cleared. This approach means we don't have to play games with
+	 * accumulating and storing the bits. It does mean that any interleaved
+	 * calls to ptep_get() may lack correct access/dirty information if we
+	 * have already cleared the pte that happened to store it. The core code
+	 * does not rely on this though.
+	 */
+
+	return __ptep_get_and_clear(mm, addr, ptep);
+}
+EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
+
 int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep)
 {
-- 
2.25.1

