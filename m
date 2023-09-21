Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1027AA05E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjIUUf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjIUUel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:34:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4299685D06;
        Thu, 21 Sep 2023 10:37:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 177461763;
        Thu, 21 Sep 2023 09:21:33 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A068D3F59C;
        Thu, 21 Sep 2023 09:20:51 -0700 (PDT)
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
Subject: [PATCH v1 7/8] arm64: hugetlb: Convert set_huge_pte_at() to take vma
Date:   Thu, 21 Sep 2023 17:20:06 +0100
Message-Id: <20230921162007.1630149-8-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921162007.1630149-1-ryan.roberts@arm.com>
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to fix a bug, arm64 needs access to the vma inside it's
implementation of set_huge_pte_at(). Provide for this by converting the
mm parameter to be a vma. Any implementations that require the mm can
access it via vma->vm_mm.

This commit makes the required arm64 modifications. Separate commits
update the other arches and core code, before the actual bug is fixed in
arm64.

No behavioral changes intended.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/hugetlb.h | 2 +-
 arch/arm64/mm/hugetlbpage.c      | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index f43a38ac1779..efc9025b9d27 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -27,7 +27,7 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
-extern void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+extern void set_huge_pte_at(struct vm_area_struct *vma, unsigned long addr,
 			    pte_t *ptep, pte_t pte);
 #define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
 extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 9c52718ea750..844832511c1e 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -248,9 +248,10 @@ static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
 	return page_folio(pfn_to_page(swp_offset_pfn(entry)));
 }
 
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+void set_huge_pte_at(struct vm_area_struct *vma, unsigned long addr,
 			    pte_t *ptep, pte_t pte)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	size_t pgsize;
 	int i;
 	int ncontig;
@@ -571,5 +572,5 @@ pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
 void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
 				  pte_t old_pte, pte_t pte)
 {
-	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+	set_huge_pte_at(vma, addr, ptep, pte);
 }
-- 
2.25.1

