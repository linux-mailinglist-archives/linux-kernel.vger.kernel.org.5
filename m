Return-Path: <linux-kernel+bounces-117300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099B088A9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7742340FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1F16F83F;
	Mon, 25 Mar 2024 14:56:27 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9B16F29A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378587; cv=none; b=ga2QchMlnicDxdTtcgoWzWSqtqkTuI2LwnJKDB6wKpJWLBohJYps2jrhO7wMfDytUi3s8XYYkjsYfFWV+fjIKrqAz314sbbMA7yhvMC6ck3p7ksvE1fZrL9x9GZwFvkYljBqgGLWtcM83XIY04LM+0XOpt/m5JPQHF+TJV3uBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378587; c=relaxed/simple;
	bh=G0Wo+zSPvm0zKcYamX7mo4IBjfP690rcbl767tVRdqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0BRH17LT/qHKVn7W174w3ilbkiqD0eNrMhonqsoSE7F4fH7lKegGt7k9S5S0s1U2WJ5nzG9yeHJZ1juORUuZdIU/H/iDKiNvSv8lbuOY6H3keA9BDtuEKsoV6yVTaFuqxJO4yOZNRU+K2RaEBAcigO0jjSywhg+v5wwh8sJKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4V3GGN4Xwnz9sqS;
	Mon, 25 Mar 2024 15:56:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dh3jRGrDMhrs; Mon, 25 Mar 2024 15:56:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4V3GGK2Nmzz9sHR;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4EBDB8B765;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id A_57aGmhzA1A; Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2208C8B76E;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 2/8] mm: Provide page size to pte_alloc_huge()
Date: Mon, 25 Mar 2024 15:55:55 +0100
Message-ID: <32f0c0802a202cc738f3f21682f53d76f01fc70e.1711377230.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711377230.git.christophe.leroy@csgroup.eu>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711378567; l=4165; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=G0Wo+zSPvm0zKcYamX7mo4IBjfP690rcbl767tVRdqk=; b=FskSsaG4xsnz5gHg1RDzdpAAKIx/z4JVr9MAnODJ+e8Ywfb4R16JcI9JRXe2WOfUslhVdSRvk VwbcylHgRCdB6arpi04zDdwNgCSdflFTtov6OEfbi3s3u+96ivxekvC
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In order to be able to flag the PMD entry with _PMD_HUGE_8M on
powerpc 8xx, provide page size to pte_alloc_huge() and use it
through the newly introduced pte_alloc_size().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/arm64/mm/hugetlbpage.c   | 2 +-
 arch/parisc/mm/hugetlbpage.c  | 2 +-
 arch/powerpc/mm/hugetlbpage.c | 2 +-
 arch/riscv/mm/hugetlbpage.c   | 2 +-
 arch/sh/mm/hugetlbpage.c      | 2 +-
 arch/sparc/mm/hugetlbpage.c   | 2 +-
 include/linux/hugetlb.h       | 4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0f0e10bb0a95..71161c655fd6 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -289,7 +289,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			return NULL;
 
 		WARN_ON(addr & (sz - 1));
-		ptep = pte_alloc_huge(mm, pmdp, addr);
+		ptep = pte_alloc_huge(mm, pmdp, addr, sz);
 	} else if (sz == PMD_SIZE) {
 		if (want_pmd_share(vma, addr) && pud_none(READ_ONCE(*pudp)))
 			ptep = huge_pmd_share(mm, vma, addr, pudp);
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index a9f7e21f6656..2f4c6b440710 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -66,7 +66,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (pud) {
 		pmd = pmd_alloc(mm, pud, addr);
 		if (pmd)
-			pte = pte_alloc_huge(mm, pmd, addr);
+			pte = pte_alloc_huge(mm, pmd, addr, sz);
 	}
 	return pte;
 }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 594a4b7b2ca2..66ac56b26007 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -183,7 +183,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		return NULL;
 
 	if (IS_ENABLED(CONFIG_PPC_8xx) && pshift < PMD_SHIFT)
-		return pte_alloc_huge(mm, (pmd_t *)hpdp, addr);
+		return pte_alloc_huge(mm, (pmd_t *)hpdp, addr, sz);
 
 	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
 
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 5ef2a6891158..dc77a58c6321 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -67,7 +67,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 
 	for_each_napot_order(order) {
 		if (napot_cont_size(order) == sz) {
-			pte = pte_alloc_huge(mm, pmd, addr & napot_cont_mask(order));
+			pte = pte_alloc_huge(mm, pmd, addr & napot_cont_mask(order), sz);
 			break;
 		}
 	}
diff --git a/arch/sh/mm/hugetlbpage.c b/arch/sh/mm/hugetlbpage.c
index 6cb0ad73dbb9..26579429e5ed 100644
--- a/arch/sh/mm/hugetlbpage.c
+++ b/arch/sh/mm/hugetlbpage.c
@@ -38,7 +38,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (pud) {
 				pmd = pmd_alloc(mm, pud, addr);
 				if (pmd)
-					pte = pte_alloc_huge(mm, pmd, addr);
+					pte = pte_alloc_huge(mm, pmd, addr, sz);
 			}
 		}
 	}
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index b432500c13a5..5a342199e837 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -298,7 +298,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		return NULL;
 	if (sz >= PMD_SIZE)
 		return (pte_t *)pmd;
-	return pte_alloc_huge(mm, pmd, addr);
+	return pte_alloc_huge(mm, pmd, addr, sz);
 }
 
 pte_t *huge_pte_offset(struct mm_struct *mm,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 77b30a8c6076..d9c5d9daadc5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -193,9 +193,9 @@ static inline pte_t *pte_offset_huge(pmd_t *pmd, unsigned long address)
 	return pte_offset_kernel(pmd, address);
 }
 static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
-				    unsigned long address)
+				    unsigned long address, unsigned long sz)
 {
-	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
+	return pte_alloc_size(mm, pmd, sz) ? NULL : pte_offset_huge(pmd, address);
 }
 #endif
 
-- 
2.43.0


