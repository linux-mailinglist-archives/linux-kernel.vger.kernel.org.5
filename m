Return-Path: <linux-kernel+bounces-121876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8121C88EEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F5429AAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D314F9FF;
	Wed, 27 Mar 2024 19:07:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2A149DE0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566463; cv=none; b=CVaKiBlXkhDl0pEEeL2Lc1bnvJ7VfiBWuGbKA398BMLZAhdDBrZ7zvw/JhIlvjrC6R8d1FEL3Hm6aT/WF6I92DeJbyOZkPw+Ct2f3ndsbaNGPhzL8M49UEmQnuFypzaGWw8WohobtMCTuNMJfmJNmL4gIAjihQpszaTjtDxXqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566463; c=relaxed/simple;
	bh=RMXDDjZrf8/faa23V77RsUn8dZUjE2GprXeV9v/wvbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EK504K9y9UJY01eHN3c+6GBSmvLXmr8n/xsDepKukcls4JudwpGNQuDRBPLK0k8jZHDf/g52gxGivkS2kkeRhLjRehjvg/XFveXUgKykaBrAjPUwtgNWGnPZa6XdljXoWf3vWOW+jBsfe4+ljgL1pRbKRY9kLLCcm/AkR6fSQ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D45C2F4;
	Wed, 27 Mar 2024 12:08:12 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1BA63F694;
	Wed, 27 Mar 2024 12:07:36 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: mm: Batch dsb and isb when populating pgtables
Date: Wed, 27 Mar 2024 19:07:23 +0000
Message-Id: <20240327190723.185232-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326101448.3453626-1-ryan.roberts@arm.com>
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After removing uneccessary TLBIs, the next bottleneck when creating the
page tables for the linear map is DSB and ISB, which were previously
issued per-pte in __set_pte(). Since we are writing multiple ptes in a
given pte table, we can elide these barriers and insert them once we
have finished writing to the table.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h |  7 ++++++-
 arch/arm64/mm/mmu.c              | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index bd5d02f3f0a3..81e427b23b3f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -271,9 +271,14 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
 }

-static inline void __set_pte(pte_t *ptep, pte_t pte)
+static inline void ___set_pte(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
+}
+
+static inline void __set_pte(pte_t *ptep, pte_t pte)
+{
+	___set_pte(ptep, pte);

 	/*
 	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1b2a2a2d09b7..c6d5a76732d4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -301,7 +301,11 @@ static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 	do {
 		pte_t old_pte = __ptep_get(ptep);

-		__set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
+		/*
+		 * Required barriers to make this visible to the table walker
+		 * are deferred to the end of alloc_init_cont_pte().
+		 */
+		___set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));

 		/*
 		 * After the PTE entry has been populated once, we
@@ -358,6 +362,13 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	} while (addr = next, addr != end);

 	ops->unmap(TYPE_PTE);
+
+	/*
+	 * Ensure all previous pgtable writes are visible to the table walker.
+	 * See init_pte().
+	 */
+	dsb(ishst);
+	isb();
 }

 static pmd_t *init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
--
2.25.1


