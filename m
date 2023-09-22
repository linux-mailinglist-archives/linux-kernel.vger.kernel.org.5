Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9627AB17C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjIVL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjIVL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:58:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F36221AD;
        Fri, 22 Sep 2023 04:58:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A520143D;
        Fri, 22 Sep 2023 04:59:02 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C40783F67D;
        Fri, 22 Sep 2023 04:58:20 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: hugetlb: Fix set_huge_pte_at() to work with all swap entries
Date:   Fri, 22 Sep 2023 12:58:04 +0100
Message-Id: <20230922115804.2043771-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922115804.2043771-1-ryan.roberts@arm.com>
References: <20230922115804.2043771-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When called with a swap entry that does not embed a PFN (e.g.
PTE_MARKER_POISONED or PTE_MARKER_UFFD_WP), the previous implementation
of set_huge_pte_at() would either cause a BUG() to fire (if
CONFIG_DEBUG_VM is enabled) or cause a dereference of an invalid address
and subsequent panic.

arm64's huge pte implementation supports multiple huge page sizes, some
of which are implemented in the page table with multiple contiguous
entries. So set_huge_pte_at() needs to work out how big the logical pte
is, so that it can also work out how many physical ptes (or pmds) need
to be written. It previously did this by grabbing the folio out of the
pte and querying its size.

However, there are cases when the pte being set is actually a swap
entry. But this also used to work fine, because for huge ptes, we only
ever saw migration entries and hwpoison entries. And both of these types
of swap entries have a PFN embedded, so the code would grab that and
everything still worked out.

But over time, more calls to set_huge_pte_at() have been added that set
swap entry types that do not embed a PFN. And this causes the code to go
bang. The triggering case is for the uffd poison test, commit
99aa77215ad0 ("selftests/mm: add uffd unit test for UFFDIO_POISON"),
which causes a PTE_MARKER_POISONED swap entry to be set, coutesey of
commit 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for
hugetlbfs") - added in v6.5-rc7. Although review shows that there are
other call sites that set PTE_MARKER_UFFD_WP (which also has no PFN),
these don't trigger on arm64 because arm64 doesn't support UFFD WP.

Arguably, the root cause is really due to commit 18f3962953e4 ("mm:
hugetlb: kill set_huge_swap_pte_at()"), which aimed to simplify the
interface to the core code by removing set_huge_swap_pte_at() (which
took a page size parameter) and replacing it with calls to
set_huge_pte_at() where the size was inferred from the folio, as
descibed above. While that commit didn't break anything at the time, it
did break the interface because it couldn't handle swap entries without
PFNs. And since then new callers have come along which rely on this
working. But given the brokeness is only observable after commit
8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for hugetlbfs"),
that one gets the Fixes tag.

Now that we have modified the set_huge_pte_at() interface to pass the
huge page size in the previous patch, we can trivially fix this issue.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Fixes: 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for hugetlbfs")
Cc: <stable@vger.kernel.org> # 6.5+
---
 arch/arm64/mm/hugetlbpage.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index a7f8c8db3425..13fd592228b1 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -241,13 +241,6 @@ static void clear_flush(struct mm_struct *mm,
 	flush_tlb_range(&vma, saddr, addr);
 }
 
-static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
-{
-	VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
-
-	return page_folio(pfn_to_page(swp_offset_pfn(entry)));
-}
-
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, pte_t pte, unsigned long sz)
 {
@@ -257,13 +250,10 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long pfn, dpfn;
 	pgprot_t hugeprot;
 
-	if (!pte_present(pte)) {
-		struct folio *folio;
-
-		folio = hugetlb_swap_entry_to_folio(pte_to_swp_entry(pte));
-		ncontig = num_contig_ptes(folio_size(folio), &pgsize);
+	ncontig = num_contig_ptes(sz, &pgsize);
 
-		for (i = 0; i < ncontig; i++, ptep++)
+	if (!pte_present(pte)) {
+		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
 			set_pte_at(mm, addr, ptep, pte);
 		return;
 	}
@@ -273,7 +263,6 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		return;
 	}
 
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 	pfn = pte_pfn(pte);
 	dpfn = pgsize >> PAGE_SHIFT;
 	hugeprot = pte_pgprot(pte);
-- 
2.25.1

