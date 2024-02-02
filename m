Return-Path: <linux-kernel+bounces-49428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84079846A45
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3A21C2A70B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13CA4879C;
	Fri,  2 Feb 2024 08:09:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1394878F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861356; cv=none; b=fBynZ4Zml/IsL/fML4K3oqjT0EmDKrkmo80Tp2kiVOdMX4YoFTe5LIsIMz5X1E6hIgVdonufVp/mKYVa/7sEc0Jga1PTM6dbJJLMz61vwlDsgHfQjAweuBQ15wtZaJmTtBTa2RtNf+DePcX1Z42hiDVtq0fOZ+d7lapesTdaiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861356; c=relaxed/simple;
	bh=L8OR5Yo+BhLvUxEQHYat8c5+gAgt6YHYoztuuBWx1DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POyAwqEo1g4bBaX88mD32J8g01gXZb3kHycetOst8S27OEWDYANRc3QkU/vcfmVE//cfTkFwqatnvVluXyt58bRPtWZspP+2RGLByPQtoTiwxF//VWSwcsP1Zb9HO7m8Fbsv7lR6O39fXawgUklBOjsWs2QPERwWBy8GS6+ZVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB9861AED;
	Fri,  2 Feb 2024 00:09:55 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFF383F5A1;
	Fri,  2 Feb 2024 00:09:09 -0800 (PST)
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
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
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
Subject: [PATCH v5 15/25] arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
Date: Fri,  2 Feb 2024 08:07:46 +0000
Message-Id: <20240202080756.1453939-16-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202080756.1453939-1-ryan.roberts@arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
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
 arch/arm64/include/asm/pgtable.h | 10 ++++++----
 arch/arm64/mm/hugetlbpage.c      |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2870bc12f288..4c2d6c483390 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -970,11 +970,11 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
- * ptep_set_wrprotect - mark read-only while trasferring potential hardware
+ * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
  * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
  */
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
+static inline void __ptep_set_wrprotect(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep)
 {
 	pte_t old_pte, pte;
 
@@ -992,7 +992,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pmd_t *pmdp)
 {
-	ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
+	__ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
 }
 
 #define pmdp_establish pmdp_establish
@@ -1139,6 +1139,8 @@ void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
 #define ptep_test_and_clear_young		__ptep_test_and_clear_young
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young			__ptep_clear_flush_young
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+#define ptep_set_wrprotect			__ptep_set_wrprotect
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 7e74e7b67107..f6612f3e1c07 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -493,7 +493,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte_t pte;
 
 	if (!pte_cont(READ_ONCE(*ptep))) {
-		ptep_set_wrprotect(mm, addr, ptep);
+		__ptep_set_wrprotect(mm, addr, ptep);
 		return;
 	}
 
-- 
2.25.1


