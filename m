Return-Path: <linux-kernel+bounces-131623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F0C898A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E7B276E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681911D54F;
	Thu,  4 Apr 2024 14:33:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690AE1B964
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241204; cv=none; b=ccdPs2rHiGLQr24/jLmWR7TSC50KAaynoflYh0poPJpW0qLjj1Gm+YeHhQ2FTx3amhIHPnphZav2Z9oEWZln1o0ytC1XHwIU+q7GSJ+wtqNG1Q3AHKjY6/VIhlDlvKkCQnRm4jkRkfbRojG0t5zbq+eAmCyLYuIiwiI1pHtTUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241204; c=relaxed/simple;
	bh=SYO4oFNDFkL0s+N/cJYfdC8JBBGNx9XmnIIAMpjkrAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lF4UFIHerTdbQfQaPGlx/WoOg3Rn7l/pZ7tv02GaF2oBQREvKifFcG1ZTaB7vUaY+DbdTsCvUCD2ZKky9lygbdDBsXOPGWdNL60fLUQu+gBXEm7ztkC7YT3UzalGL6nr5AwMyP86LpNj9TWueIwUNpm/z7hBjGRV/UE15vswonk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B87C1150C;
	Thu,  4 Apr 2024 07:33:52 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94D6A3F64C;
	Thu,  4 Apr 2024 07:33:20 -0700 (PDT)
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
Subject: [PATCH v2 2/4] arm64: mm: Batch dsb and isb when populating pgtables
Date: Thu,  4 Apr 2024 15:33:06 +0100
Message-Id: <20240404143308.2224141-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404143308.2224141-1-ryan.roberts@arm.com>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
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
before         |   77   (0%) |  431   (0%) | 1727   (0%) |  3796   (0%)
after          |   13 (-84%) |  162 (-62%) |  655 (-62%) |  1656 (-56%)

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Tested-by: Eric Chanudet <echanude@redhat.com>
---
 arch/arm64/include/asm/pgtable.h |  7 ++++++-
 arch/arm64/mm/mmu.c              | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

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
index fd91b5bdb514..dc86dceb0efe 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -178,7 +178,11 @@ static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
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
@@ -234,6 +238,13 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	} while (addr = next, addr != end);
 
 	pte_clear_fixmap();
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


