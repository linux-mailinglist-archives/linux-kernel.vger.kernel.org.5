Return-Path: <linux-kernel+bounces-162411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9278B5AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255D8B232A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D67D089;
	Mon, 29 Apr 2024 14:02:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB09E7BB1B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399346; cv=none; b=i5567kxiz2+QmcVKmS8+d186492D4Cy0Cqr7iLr8oX/7SFl3zvWa4YLcWP0xRIq12TaxNby8T3na6zpKfn+1uRLxGs7ys3hWbFhylDoZL7oSJOfscViK6QDbL2RhR05pzfWW/MVPbEMwZLJxaPpLhbliE235piVYjwmRCSRp55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399346; c=relaxed/simple;
	bh=r9IDjDap4u+9qS/WYmIDbHz9I+cFSGPxoF+il2kITJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDgcmO/MFHGTZo4ojVB+bFca0+JOl0YzB+mvZYbl0E3yKlAWesl+Q+FHkQPXV3PrGyqBviOPdn47ks/bBpfRVxAiV9vkSfAzRP1u7WgdwodhIqWuPShBq3u3EHXf163FLPBR4zBAQkHsqTe4o3Rkiza702D8iO0YzoyaqSeLfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18CE11007;
	Mon, 29 Apr 2024 07:02:51 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE6213F793;
	Mon, 29 Apr 2024 07:02:22 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64/mm: Add uffd write-protect support
Date: Mon, 29 Apr 2024 15:02:07 +0100
Message-Id: <20240429140208.238056-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429140208.238056-1-ryan.roberts@arm.com>
References: <20240429140208.238056-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's use the newly-free PTE SW bit (58) to add support for uffd-wp.

The standard handlers are implemented for set/test/clear for both pte
and pmd. Additionally we must also track the uffd-wp state as a pte swp
bit, so use a free swap pte bit (3).

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/pgtable-prot.h |  8 +++++
 arch/arm64/include/asm/pgtable.h      | 44 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..763e221f2169 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -255,6 +255,7 @@ config ARM64
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
+	select HAVE_ARCH_USERFAULTFD_WP if USERFAULTFD
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index ddf55895c9c2..a5e7dd37bb0a 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -20,6 +20,14 @@
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_INVALID		(PTE_NS)		 /* only when !PTE_VALID */
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+#define PTE_UFFD_WP		(_AT(pteval_t, 1) << 58) /* uffd-wp tracking */
+#define PTE_SWP_UFFD_WP		(_AT(pteval_t, 1) << 3)	 /* only for swp ptes */
+#else
+#define PTE_UFFD_WP		(_AT(pteval_t, 0))
+#define PTE_SWP_UFFD_WP		(_AT(pteval_t, 0))
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d966d2ee1097..759ba8c32a58 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -279,6 +279,23 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
 }
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+static inline int pte_uffd_wp(pte_t pte)
+{
+	return !!(pte_val(pte) & PTE_UFFD_WP);
+}
+
+static inline pte_t pte_mkuffd_wp(pte_t pte)
+{
+	return pte_wrprotect(set_pte_bit(pte, __pgprot(PTE_UFFD_WP)));
+}
+
+static inline pte_t pte_clear_uffd_wp(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_UFFD_WP));
+}
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 static inline void __set_pte(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
@@ -471,6 +488,23 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return clear_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
 }
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+static inline pte_t pte_swp_mkuffd_wp(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_SWP_UFFD_WP));
+}
+
+static inline int pte_swp_uffd_wp(pte_t pte)
+{
+	return !!(pte_val(pte) & PTE_SWP_UFFD_WP);
+}
+
+static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_SWP_UFFD_WP));
+}
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/linux/pgtable.h
@@ -512,6 +546,15 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mkinvalid(pmd)	pte_pmd(pte_mkinvalid(pmd_pte(pmd)))
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+#define pmd_uffd_wp(pmd)	pte_uffd_wp(pmd_pte(pmd))
+#define pmd_mkuffd_wp(pmd)	pte_pmd(pte_mkuffd_wp(pmd_pte(pmd)))
+#define pmd_clear_uffd_wp(pmd)	pte_pmd(pte_clear_uffd_wp(pmd_pte(pmd)))
+#define pmd_swp_uffd_wp(pmd)	pte_swp_uffd_wp(pmd_pte(pmd))
+#define pmd_swp_mkuffd_wp(pmd)	pte_pmd(pte_swp_mkuffd_wp(pmd_pte(pmd)))
+#define pmd_swp_clear_uffd_wp(pmd) \
+				pte_pmd(pte_swp_clear_uffd_wp(pmd_pte(pmd)))
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
 
@@ -1244,6 +1287,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
  *	bits 2:		remember PG_anon_exclusive
+ *	bit  3:		remember uffd-wp state
  *	bit  5:		PTE_INVALID (must be zero)
  *	bits 6-10:	swap type
  *	bits 11-60:	swap offset
-- 
2.25.1


