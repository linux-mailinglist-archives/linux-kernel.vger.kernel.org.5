Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3A8030FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbjLDKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344017AbjLDKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:55:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B032F19F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:55:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2EA61650;
        Mon,  4 Dec 2023 02:56:05 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF7523F6C4;
        Mon,  4 Dec 2023 02:55:14 -0800 (PST)
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
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/15] arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
Date:   Mon,  4 Dec 2023 10:54:31 +0000
Message-Id: <20231204105440.61448-7-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204105440.61448-1-ryan.roberts@arm.com>
References: <20231204105440.61448-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new layer for the in-table PTE manipulation APIs. For now, The
existing API is prefixed with double underscore to become the
arch-private API and the public API is just a simple wrapper that calls
the private API.

The public API implementation will subsequently be used to transparently
manipulate the contiguous bit where appropriate. But since there are
already some contig-aware users (e.g. hugetlb, kernel mapper), we must
first ensure those users use the private API directly so that the future
contig-bit manipulations in the public API do not interfere with those
existing uses.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 5 +++--
 arch/arm64/mm/hugetlbpage.c      | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1464e990580a..994597a0bb0f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -941,8 +941,7 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
 	pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
@@ -1122,6 +1121,8 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 #define set_pte					__set_pte
 #define set_ptes				__set_ptes
 #define pte_clear				__pte_clear
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define ptep_get_and_clear			__ptep_get_and_clear
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 510b2d4b89a9..c2a753541d13 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -188,7 +188,7 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 	unsigned long i;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
+		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
 
 		/*
 		 * If HW_AFDBM is enabled, then the HW could turn on
@@ -236,7 +236,7 @@ static void clear_flush(struct mm_struct *mm,
 	unsigned long i, saddr = addr;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		ptep_clear(mm, addr, ptep);
+		__ptep_get_and_clear(mm, addr, ptep);
 
 	flush_tlb_range(&vma, saddr, addr);
 }
@@ -411,7 +411,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	pte_t orig_pte = ptep_get(ptep);
 
 	if (!pte_cont(orig_pte))
-		return ptep_get_and_clear(mm, addr, ptep);
+		return __ptep_get_and_clear(mm, addr, ptep);
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 
-- 
2.25.1

