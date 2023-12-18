Return-Path: <linux-kernel+bounces-3377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B89B816B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AF31F234F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4D20B17;
	Mon, 18 Dec 2023 10:51:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A864208B8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E02011FB;
	Mon, 18 Dec 2023 02:52:31 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12C8F3F738;
	Mon, 18 Dec 2023 02:51:43 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
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
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/16] arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bit
Date: Mon, 18 Dec 2023 10:50:52 +0000
Message-Id: <20231218105100.172635-9-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218105100.172635-1-ryan.roberts@arm.com>
References: <20231218105100.172635-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 994597a0bb0f..9b4a9909fd5b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -887,8 +887,9 @@ static inline bool pud_user_accessible_page(pud_t pud)
 /*
  * Atomic pte/pmd modifications.
  */
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int __ptep_test_and_clear_young(pte_t *ptep)
+static inline int __ptep_test_and_clear_young(struct vm_area_struct *vma,
+					      unsigned long address,
+					      pte_t *ptep)
 {
 	pte_t old_pte, pte;
 
@@ -903,18 +904,11 @@ static inline int __ptep_test_and_clear_young(pte_t *ptep)
 	return pte_young(pte);
 }
 
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
-					    unsigned long address,
-					    pte_t *ptep)
-{
-	return __ptep_test_and_clear_young(ptep);
-}
-
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 					 unsigned long address, pte_t *ptep)
 {
-	int young = ptep_test_and_clear_young(vma, address, ptep);
+	int young = __ptep_test_and_clear_young(vma, address, ptep);
 
 	if (young) {
 		/*
@@ -937,7 +931,7 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
 					    pmd_t *pmdp)
 {
-	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
+	return __ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -1123,6 +1117,8 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 #define pte_clear				__pte_clear
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear			__ptep_get_and_clear
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+#define ptep_test_and_clear_young		__ptep_test_and_clear_young
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.25.1


