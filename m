Return-Path: <linux-kernel+bounces-142714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FFF8A2F40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E83B218AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694AA83CB4;
	Fri, 12 Apr 2024 13:19:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7C824A3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927964; cv=none; b=K3C311ImXdhtEmMphDz1Fa5MeGIHPkMl25H51ww8Wj//4wTJcSjlGfLh2mum3mjYyz7HeLo0SEPAmS37BEGBYcb/xufiOEFaqrpa+DN9xlYdVWXCfBGHOzj2NjkBppSEskacurZrVRL+XPR4EA23I+OG2al+q2m635fR1g8cmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927964; c=relaxed/simple;
	bh=rTIiiTX/0GDPQFzvBo0C+aUzO0YBV2V1wPty4ExbMiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zjn1tYl5M8ik9Y+6DEKfY4VlNnK+QPMxXQVNoqgEXCdQ2JWZtosGr7ep6IqGlwaLu2t/kwl/a0AHZjIYnAIF1FmjVt3mlYq9jAJ25a1RbxlqQ8pdIEgIkjFPVi8I4shX5kLr4QXL9z4kxbNCcKehxwuD3/dytJ19VrnB5B5RR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2A111474;
	Fri, 12 Apr 2024 06:19:50 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 602A43F766;
	Fri, 12 Apr 2024 06:19:20 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: [PATCH v3 2/3] arm64: mm: Batch dsb and isb when populating pgtables
Date: Fri, 12 Apr 2024 14:19:07 +0100
Message-Id: <20240412131908.433043-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412131908.433043-1-ryan.roberts@arm.com>
References: <20240412131908.433043-1-ryan.roberts@arm.com>
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

Execution time of map_mem(), which creates the kernel linear map page
tables, was measured on different machines with different RAM configs:

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
before         |   78   (0%) |  435   (0%) | 1723   (0%) |  3779   (0%)
after          |   11 (-86%) |  161 (-63%) |  656 (-62%) |  1654 (-56%)

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Tested-by: Eric Chanudet <echanude@redhat.com>
---
 arch/arm64/include/asm/pgtable.h |  7 ++++++-
 arch/arm64/mm/mmu.c              | 11 ++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index afdd56d26ad7..105a95a8845c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -271,9 +271,14 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
 }
 
-static inline void __set_pte(pte_t *ptep, pte_t pte)
+static inline void __set_pte_nosync(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
+}
+
+static inline void __set_pte(pte_t *ptep, pte_t pte)
+{
+	__set_pte_nosync(ptep, pte);
 
 	/*
 	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9f1d69b7b494..ac88b89770a6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -178,7 +178,11 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 	do {
 		pte_t old_pte = __ptep_get(ptep);
 
-		__set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
+		/*
+		 * Required barriers to make this visible to the table walker
+		 * are deferred to the end of alloc_init_cont_pte().
+		 */
+		__set_pte_nosync(ptep, pfn_pte(__phys_to_pfn(phys), prot));
 
 		/*
 		 * After the PTE entry has been populated once, we
@@ -232,6 +236,11 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 		phys += next - addr;
 	} while (addr = next, addr != end);
 
+	/*
+	 * Note: barriers and maintenance necessary to clear the fixmap slot
+	 * ensure that all previous pgtable writes are visible to the table
+	 * walker.
+	 */
 	pte_clear_fixmap();
 }
 
-- 
2.25.1


