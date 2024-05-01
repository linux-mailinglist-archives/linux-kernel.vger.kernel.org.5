Return-Path: <linux-kernel+bounces-165395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CBC8B8C2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5606F1C21D87
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605412FB0B;
	Wed,  1 May 2024 14:54:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196A312DD83
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575275; cv=none; b=kA8DWR4TFyBSgeEZOvpBK1taA+Yqu6ekx9XM3lMJpVr+cWwa5pINnYfH1DouYHlZffHpiY0aWSZekHgvndLElnc6Cp+DGg5SEMz9Gte2RkqdSXuUx/g9DXaiBfSw4gwha+/Sct5a7IU3aggwCW0etmZvyK6BNXuzXyl5gciWK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575275; c=relaxed/simple;
	bh=S9VnJBcOFejZA/kSoEhkdab+gdGBB6gqpnezTmhsNQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZTbycJRZeLEbhPvvjMHwZ6zDV/RwGgaMK7LIB4a2HjrIZDQBW0xbB5lfljmOar5BURMCy260G4WSPD9W5lEHhnV8UcdA7/HWVhImzlv7MrD5y7orrQ+WbNwsOzXxpnvslb6p64rhqoCsQiBI0A9zleJyCY2NhNqlUNe95HOnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95D6EDA7;
	Wed,  1 May 2024 07:54:59 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D910A3F793;
	Wed,  1 May 2024 07:54:31 -0700 (PDT)
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
Subject: [PATCH v3 3/3] arm64/mm: Add uffd write-protect support
Date: Wed,  1 May 2024 15:54:19 +0100
Message-Id: <20240501145419.1390363-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240501145419.1390363-1-ryan.roberts@arm.com>
References: <20240501145419.1390363-1-ryan.roberts@arm.com>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
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
index 3047d10987fd..ef51aed39765 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -20,6 +20,14 @@
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_PRESENT_INVALID	(PTE_NG)		 /* only when !PTE_VALID */
 
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
index 7f1ff59c43ed..2dcf582981ae 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -280,6 +280,23 @@ static inline pte_t pte_mkdevmap(pte_t pte)
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
@@ -472,6 +489,23 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
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
@@ -522,6 +556,15 @@ static inline int pmd_trans_huge(pmd_t pmd)
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
 
@@ -1254,6 +1297,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
  *	bits 2:		remember PG_anon_exclusive
+ *	bit  3:		remember uffd-wp state
  *	bits 6-10:	swap type
  *	bit  11:	PTE_PRESENT_INVALID (must be zero)
  *	bits 12-61:	swap offset
-- 
2.25.1


