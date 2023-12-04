Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B95D803103
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjLDK4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344149AbjLDKz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:55:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 862BE11F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:55:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ECBC1650;
        Mon,  4 Dec 2023 02:56:38 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9E2E3F6C4;
        Mon,  4 Dec 2023 02:55:47 -0800 (PST)
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
Subject: [PATCH v3 15/15] arm64/mm: Implement clear_ptes() to optimize exit()
Date:   Mon,  4 Dec 2023 10:54:40 +0000
Message-Id: <20231204105440.61448-16-ryan.roberts@arm.com>
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

With the core-mm changes in place to batch-clear ptes during
zap_pte_range(), we can take advantage of this in arm64 to greatly
reduce the number of tlbis we have to issue, and recover the lost exit
performance incured when adding support for transparent contiguous ptes.

If we are clearing a whole contpte range, we can elide first unfolding
that range and save the tlbis. We just clear the whole range.

The following shows the results of running a kernel compilation workload
and measuring the cost of arm64_sys_exit_group() (which at ~1.5% is a
very small part of the overall workload).

Benchmarks were run on Ampere Altra in 2 configs; single numa node and 2
numa nodes (tlbis are more expensive in 2 node config).

 - baseline: v6.7-rc1 + anonfolio-v7
 - no-opt: contpte series without any attempt to optimize exit()
 - simple-ptep_get_clear_full: simple optimization to exploit full=1.
   ptep_get_clear_full() does not fully conform to its intended semantic
 - robust-ptep_get_clear_full: similar to previous but
   ptep_get_clear_full() fully conforms to its intended semantic
 - clear_ptes: optimization implemented by this patch

| config                     | numa=1 | numa=2 |
|----------------------------|--------|--------|
| baseline                   |     0% |     0% |
| no-opt                     |   190% |   768% |
| simple-ptep_get_clear_full |     8% |    29% |
| robust-ptep_get_clear_full |    21% |    19% |
| clear_ptes                 |    13% |     9% |

In all cases, the cost of arm64_sys_exit_group() increases; this is
anticipated because there is more work to do to tear down the page
tables. But clear_ptes() gives the smallest increase overall.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 32 ++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          | 42 ++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9bd2f57a9e11..ff6b3cc9e819 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1145,6 +1145,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
 extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
 extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr);
+extern pte_t contpte_clear_ptes(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, unsigned int nr);
 extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
@@ -1270,6 +1272,36 @@ static inline void pte_clear(struct mm_struct *mm,
 	__pte_clear(mm, addr, ptep);
 }
 
+#define clear_ptes clear_ptes
+static inline pte_t clear_ptes(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep, int full,
+				unsigned int nr)
+{
+	pte_t pte;
+
+	if (!contpte_is_enabled(mm)) {
+		unsigned int i;
+		pte_t tail;
+
+		pte = __ptep_get_and_clear(mm, addr, ptep);
+		for (i = 1; i < nr; i++) {
+			addr += PAGE_SIZE;
+			ptep++;
+			tail = __ptep_get_and_clear(mm, addr, ptep);
+			if (pte_dirty(tail))
+				pte = pte_mkdirty(pte);
+			if (pte_young(tail))
+				pte = pte_mkyoung(pte);
+		}
+	} else if (nr == 1) {
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		pte = __ptep_get_and_clear(mm, addr, ptep);
+	} else
+		pte = contpte_clear_ptes(mm, addr, ptep, nr);
+
+	return pte;
+}
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 2a57df16bf58..34b43bde3fcd 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -257,6 +257,48 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(contpte_set_ptes);
 
+pte_t contpte_clear_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+					unsigned int nr)
+{
+	/*
+	 * If we cover a partial contpte block at the beginning or end of the
+	 * batch, unfold if currently folded. This makes it safe to clear some
+	 * of the entries while keeping others. contpte blocks in the middle of
+	 * the range, which are fully covered don't need to be unfolded because
+	 * we will clear the full block.
+	 */
+
+	unsigned int i;
+	pte_t pte;
+	pte_t tail;
+
+	if (ptep != contpte_align_down(ptep) || nr < CONT_PTES)
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+
+	if (ptep + nr != contpte_align_down(ptep + nr))
+		contpte_try_unfold(mm, addr + PAGE_SIZE * (nr - 1),
+				   ptep + nr - 1,
+				   __ptep_get(ptep + nr - 1));
+
+	pte = __ptep_get_and_clear(mm, addr, ptep);
+
+	for (i = 1; i < nr; i++) {
+		addr += PAGE_SIZE;
+		ptep++;
+
+		tail = __ptep_get_and_clear(mm, addr, ptep);
+
+		if (pte_dirty(tail))
+			pte = pte_mkdirty(pte);
+
+		if (pte_young(tail))
+			pte = pte_mkyoung(pte);
+	}
+
+	return pte;
+}
+EXPORT_SYMBOL(contpte_clear_ptes);
+
 int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep)
 {
-- 
2.25.1

