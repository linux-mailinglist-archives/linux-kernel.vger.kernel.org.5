Return-Path: <linux-kernel+bounces-49426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE045846A41
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8040E282742
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D96482CA;
	Fri,  2 Feb 2024 08:09:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE53481DC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861348; cv=none; b=U0yzrCvd6HZp4T9z16yOVKyGrF/2cHzy55Mpn9Q+ctSyYHxXU8Pp9nGDDlg7QljqX5hLNp1mnaNdUS9XRnANFcya9hhQymIP51xAMSJPMC5ca9WafDaIeuLv3+1F/69OjxFAtXqHNQhJ9qYfHG4VadIjR9PvZcAxm7BSPe+6LE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861348; c=relaxed/simple;
	bh=AG3StyilrRM5xxbk53S/sAlOGN0ZJ67ygxAh0JhYtFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyCpJ/bFCCGmtIgLfz70ognDK3WFEZLkjY4Rfns3VNETZYQi5KT1kKe0HFfwdWydig9gdbpHBIz6M1Uu+ouYBs2OuyACO6yMG1uNTzbs/hBJtL9uxWMJa3df7dXDG3qbR2zHBpUABn5nbCYqRxrAUqeCcyBrIIcaeH9cPMraSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 426DA1AC1;
	Fri,  2 Feb 2024 00:09:48 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570433F5A1;
	Fri,  2 Feb 2024 00:09:02 -0800 (PST)
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
Subject: [PATCH v5 13/25] arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bit
Date: Fri,  2 Feb 2024 08:07:44 +0000
Message-Id: <20240202080756.1453939-14-ryan.roberts@arm.com>
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
 arch/arm64/include/asm/pgtable.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5f560326116e..77a8b100e1cd 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -899,8 +899,9 @@ static inline bool pud_user_accessible_page(pud_t pud)
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
 
@@ -915,18 +916,11 @@ static inline int __ptep_test_and_clear_young(pte_t *ptep)
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
@@ -949,7 +943,7 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
 					    pmd_t *pmdp)
 {
-	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
+	return __ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -1142,6 +1136,8 @@ void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
 #define pte_clear				__pte_clear
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear			__ptep_get_and_clear
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+#define ptep_test_and_clear_young		__ptep_test_and_clear_young
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.25.1


