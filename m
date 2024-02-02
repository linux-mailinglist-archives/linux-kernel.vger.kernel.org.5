Return-Path: <linux-kernel+bounces-49427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E2D846A43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279151F22B61
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39FB482F5;
	Fri,  2 Feb 2024 08:09:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8BF482ED
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861352; cv=none; b=eWeByGqNjktAyzvQqmDVjlcihPuEDV/HJChDHa0MQzmEa/gEBv/mA4dhf46px8lB5Pz6Nm6+O6S+RIM96ma3WTrLA+XFsURHTvBLcfkOeceZ1396RHjGgSlJ8YUo32c5toixrzUo4fAQM7ReA96J7vd34gFXvpTrAmf/VTlroHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861352; c=relaxed/simple;
	bh=DISFiz7x8niwaKKZXO9emIBlhJg2MSwu1nX86NpwteE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIElL5Xg2CsPOrvKzB5SQxad+8AH/0EPqdZOIwRNmvw59dRPZsB1sQI3B2vQW53Zq5aLSbhBGSOdXphprBS7eSVcfQ9D/yJOjOGyZDsviVOWn4g4/azPH+j9ftXEl0OK6A10HaI2Z0jbgaXwRGY9xNQqyWcMwn6vKlu6t8O2z8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 159451A00;
	Fri,  2 Feb 2024 00:09:52 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29E883F5A1;
	Fri,  2 Feb 2024 00:09:06 -0800 (PST)
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
Subject: [PATCH v5 14/25] arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
Date: Fri,  2 Feb 2024 08:07:45 +0000
Message-Id: <20240202080756.1453939-15-ryan.roberts@arm.com>
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
 arch/arm64/include/asm/pgtable.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 77a8b100e1cd..2870bc12f288 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -138,7 +138,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
  * so that we don't erroneously return false for pages that have been
  * remapped as PROT_NONE but are yet to be flushed from the TLB.
  * Note that we can't make any assumptions based on the state of the access
- * flag, since ptep_clear_flush_young() elides a DSB when invalidating the
+ * flag, since __ptep_clear_flush_young() elides a DSB when invalidating the
  * TLB.
  */
 #define pte_accessible(mm, pte)	\
@@ -916,8 +916,7 @@ static inline int __ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return pte_young(pte);
 }
 
-#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+static inline int __ptep_clear_flush_young(struct vm_area_struct *vma,
 					 unsigned long address, pte_t *ptep)
 {
 	int young = __ptep_test_and_clear_young(vma, address, ptep);
@@ -1138,6 +1137,8 @@ void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
 #define ptep_get_and_clear			__ptep_get_and_clear
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define ptep_test_and_clear_young		__ptep_test_and_clear_young
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+#define ptep_clear_flush_young			__ptep_clear_flush_young
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.25.1


