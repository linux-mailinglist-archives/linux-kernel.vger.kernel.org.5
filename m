Return-Path: <linux-kernel+bounces-91674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A988714DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A891C23273
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AEA7BAFE;
	Tue,  5 Mar 2024 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFar6blm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A967D3F6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613550; cv=none; b=oSkPOOQ8PxwKt9wyf9LLhVmqquCiL/chO3zeDcqlXtwYyoR1ZJXq6DHwGcnmQfUD0Bgo6jMJXSa9+jMCrT6cvIUZuFoBnCYxtTM1XRv0tzhyf1Fm7zbxY6Sd1YFCTlZ9OSFdIkjNSazq2OP1nR+Vu+f5ZFErPMUm1YcaXD5LlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613550; c=relaxed/simple;
	bh=/Htr6zBaLhtRV87GPe6KqitAPP4J2jTb1G89+HHbuc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKKQ+6xOo4GFPD7fotM5cvcnG2xcPM5R+vH8AoGJyOZJPiM3bUSLQv1h/qqb1BOvjy2qXkZembHft1D6pLGeyrBMEdxXrRrgOWm7sXrkwADZl2LXqQXCgo/0+B5v2Yd6hguQFAt2tNflIzt56EcGlhBqYT/Yr06+mSr6PGSM0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFar6blm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709613547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAeWAhjzW3K6lhEDi8mkQkKHrGA5E3IpN3cjurs4px4=;
	b=jFar6blmHypNvcPoIK6fw42GELiG0BTgqzdbLI7503NG4D6SJcnREFmArqqeVWqw8MmCe9
	nm/J6fAicoYtwp68kkjopGBHTvZRnRT7xD3ON87PFq8tyqgcKRHrAruT6WaGm9C4XPSjho
	8J+ncfim2cUQMXrMWheB826VeACLrq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-ZvG4wdy4OXKeu567-9MEbA-1; Mon, 04 Mar 2024 23:39:00 -0500
X-MC-Unique: ZvG4wdy4OXKeu567-9MEbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C324410189AB;
	Tue,  5 Mar 2024 04:38:59 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 57089C1F086;
	Tue,  5 Mar 2024 04:38:53 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v3 08/10] mm/treewide: Replace pud_large() with pud_leaf()
Date: Tue,  5 Mar 2024 12:37:48 +0800
Message-ID: <20240305043750.93762-9-peterx@redhat.com>
In-Reply-To: <20240305043750.93762-1-peterx@redhat.com>
References: <20240305043750.93762-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Peter Xu <peterx@redhat.com>

pud_large() is always defined as pud_leaf().  Merge their usages.  Chose
pud_leaf() because pud_leaf() is a global API, while pud_large() is not.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/mm/book3s64/pgtable.c | 2 +-
 arch/s390/boot/vmem.c              | 2 +-
 arch/s390/include/asm/pgtable.h    | 4 ++--
 arch/s390/mm/gmap.c                | 2 +-
 arch/s390/mm/hugetlbpage.c         | 4 ++--
 arch/s390/mm/pageattr.c            | 2 +-
 arch/s390/mm/pgtable.c             | 2 +-
 arch/s390/mm/vmem.c                | 6 +++---
 arch/sparc/mm/init_64.c            | 2 +-
 arch/x86/kvm/mmu/mmu.c             | 2 +-
 arch/x86/mm/fault.c                | 4 ++--
 arch/x86/mm/ident_map.c            | 2 +-
 arch/x86/mm/init_64.c              | 4 ++--
 arch/x86/mm/kasan_init_64.c        | 2 +-
 arch/x86/mm/mem_encrypt_identity.c | 2 +-
 arch/x86/mm/pat/set_memory.c       | 6 +++---
 arch/x86/mm/pgtable.c              | 2 +-
 arch/x86/mm/pti.c                  | 2 +-
 arch/x86/power/hibernate.c         | 2 +-
 arch/x86/xen/mmu_pv.c              | 4 ++--
 20 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 45f526547b27..83823db3488b 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -130,7 +130,7 @@ void set_pud_at(struct mm_struct *mm, unsigned long addr,
 
 	WARN_ON(pte_hw_valid(pud_pte(*pudp)));
 	assert_spin_locked(pud_lockptr(mm, pudp));
-	WARN_ON(!(pud_large(pud)));
+	WARN_ON(!(pud_leaf(pud)));
 #endif
 	trace_hugepage_set_pud(addr, pud_val(pud));
 	return set_pte_at(mm, addr, pudp_ptep(pudp), pud_pte(pud));
diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index 348ab02b1028..09b10bb6e4d0 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -366,7 +366,7 @@ static void pgtable_pud_populate(p4d_t *p4d, unsigned long addr, unsigned long e
 			}
 			pmd = boot_crst_alloc(_SEGMENT_ENTRY_EMPTY);
 			pud_populate(&init_mm, pud, pmd);
-		} else if (pud_large(*pud)) {
+		} else if (pud_leaf(*pud)) {
 			continue;
 		}
 		pgtable_pmd_populate(pud, addr, next, mode);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 431d03d5116b..a5f16a244a64 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -730,7 +730,7 @@ static inline int pud_bad(pud_t pud)
 {
 	unsigned long type = pud_val(pud) & _REGION_ENTRY_TYPE_MASK;
 
-	if (type > _REGION_ENTRY_TYPE_R3 || pud_large(pud))
+	if (type > _REGION_ENTRY_TYPE_R3 || pud_leaf(pud))
 		return 1;
 	if (type < _REGION_ENTRY_TYPE_R3)
 		return 0;
@@ -1400,7 +1400,7 @@ static inline unsigned long pud_deref(pud_t pud)
 	unsigned long origin_mask;
 
 	origin_mask = _REGION_ENTRY_ORIGIN;
-	if (pud_large(pud))
+	if (pud_leaf(pud))
 		origin_mask = _REGION3_ENTRY_ORIGIN_LARGE;
 	return (unsigned long)__va(pud_val(pud) & origin_mask);
 }
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index b78ded9d3bf7..ac28a042d101 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -598,7 +598,7 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	pud = pud_offset(p4d, vmaddr);
 	VM_BUG_ON(pud_none(*pud));
 	/* large puds cannot yet be handled */
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return -EFAULT;
 	pmd = pmd_offset(pud, vmaddr);
 	VM_BUG_ON(pmd_none(*pmd));
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 1ccb5b40fe92..c2e8242bd15d 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -224,7 +224,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		if (p4d_present(*p4dp)) {
 			pudp = pud_offset(p4dp, addr);
 			if (pud_present(*pudp)) {
-				if (pud_large(*pudp))
+				if (pud_leaf(*pudp))
 					return (pte_t *) pudp;
 				pmdp = pmd_offset(pudp, addr);
 			}
@@ -240,7 +240,7 @@ int pmd_huge(pmd_t pmd)
 
 int pud_huge(pud_t pud)
 {
-	return pud_large(pud);
+	return pud_leaf(pud);
 }
 
 bool __init arch_hugetlb_valid_size(unsigned long size)
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 9f55d5a3210c..01bc8fad64d6 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -274,7 +274,7 @@ static int walk_pud_level(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (pud_none(*pudp))
 			return -EINVAL;
 		next = pud_addr_end(addr, end);
-		if (pud_large(*pudp)) {
+		if (pud_leaf(*pudp)) {
 			need_split  = !!(flags & SET_MEMORY_4K);
 			need_split |= !!(addr & ~PUD_MASK);
 			need_split |= !!(addr + PUD_SIZE > next);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 9ac66304d776..2c944bafb030 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -470,7 +470,7 @@ static int pmd_lookup(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
 		return -ENOENT;
 
 	/* Large PUDs are not supported yet. */
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return -EFAULT;
 
 	*pmdp = pmd_offset(pud, addr);
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index afe5edf2a604..85cddf904cb2 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -329,7 +329,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (!add) {
 			if (pud_none(*pud))
 				continue;
-			if (pud_large(*pud)) {
+			if (pud_leaf(*pud)) {
 				if (IS_ALIGNED(addr, PUD_SIZE) &&
 				    IS_ALIGNED(next, PUD_SIZE)) {
 					pud_clear(pud);
@@ -350,7 +350,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 			if (!pmd)
 				goto out;
 			pud_populate(&init_mm, pud, pmd);
-		} else if (pud_large(*pud)) {
+		} else if (pud_leaf(*pud)) {
 			continue;
 		}
 		ret = modify_pmd_table(pud, addr, next, add, direct, altmap);
@@ -599,7 +599,7 @@ pte_t *vmem_get_alloc_pte(unsigned long addr, bool alloc)
 		if (!pmd)
 			goto out;
 		pud_populate(&init_mm, pud, pmd);
-	} else if (WARN_ON_ONCE(pud_large(*pud))) {
+	} else if (WARN_ON_ONCE(pud_leaf(*pud))) {
 		goto out;
 	}
 	pmd = pmd_offset(pud, addr);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 5e067b6a4464..1ca9054d9b97 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1665,7 +1665,7 @@ bool kern_addr_valid(unsigned long addr)
 	if (pud_none(*pud))
 		return false;
 
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return pfn_valid(pud_pfn(*pud));
 
 	pmd = pmd_offset(pud, addr);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c15123248c52..5cb5bc4a72c4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3126,7 +3126,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	if (pud_none(pud) || !pud_present(pud))
 		goto out;
 
-	if (pud_large(pud)) {
+	if (pud_leaf(pud)) {
 		level = PG_LEVEL_1G;
 		goto out;
 	}
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 09417f950343..2cc6fa5dc561 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -376,7 +376,7 @@ static void dump_pagetable(unsigned long address)
 		goto bad;
 
 	pr_cont("PUD %lx ", pud_val(*pud));
-	if (!pud_present(*pud) || pud_large(*pud))
+	if (!pud_present(*pud) || pud_leaf(*pud))
 		goto out;
 
 	pmd = pmd_offset(pud, address);
@@ -1046,7 +1046,7 @@ spurious_kernel_fault(unsigned long error_code, unsigned long address)
 	if (!pud_present(*pud))
 		return 0;
 
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return spurious_kernel_fault_check(error_code, (pte_t *) pud);
 
 	pmd = pmd_offset(pud, address);
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index f50cc210a981..a204a332c71f 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -33,7 +33,7 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 			next = end;
 
 		/* if this is already a gbpage, this portion is already mapped */
-		if (pud_large(*pud))
+		if (pud_leaf(*pud))
 			continue;
 
 		/* Is using a gbpage allowed? */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 2c5490e58f41..7e177856ee4f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -617,7 +617,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		}
 
 		if (!pud_none(*pud)) {
-			if (!pud_large(*pud)) {
+			if (!pud_leaf(*pud)) {
 				pmd = pmd_offset(pud, 0);
 				paddr_last = phys_pmd_init(pmd, paddr,
 							   paddr_end,
@@ -1163,7 +1163,7 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 		if (!pud_present(*pud))
 			continue;
 
-		if (pud_large(*pud) &&
+		if (pud_leaf(*pud) &&
 		    IS_ALIGNED(addr, PUD_SIZE) &&
 		    IS_ALIGNED(next, PUD_SIZE)) {
 			spin_lock(&init_mm.page_table_lock);
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index f41d26bc9161..9dddf19a5571 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -115,7 +115,7 @@ static void __init kasan_populate_p4d(p4d_t *p4d, unsigned long addr,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (!pud_large(*pud))
+		if (!pud_leaf(*pud))
 			kasan_populate_pud(pud, addr, next, nid);
 	} while (pud++, addr = next, addr != end);
 }
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index bca4fea80579..7dd30e16294d 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -145,7 +145,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 		set_pud(pud, __pud(PUD_FLAGS | __pa(pmd)));
 	}
 
-	if (pud_large(*pud))
+	if (pud_leaf(*pud))
 		return NULL;
 
 	return pud;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4037fe08eed..e3a26f2c7781 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -684,7 +684,7 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 		return NULL;
 
 	*level = PG_LEVEL_1G;
-	if (pud_large(*pud) || !pud_present(*pud))
+	if (pud_leaf(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
 	pmd = pmd_offset(pud, address);
@@ -743,7 +743,7 @@ pmd_t *lookup_pmd_address(unsigned long address)
 		return NULL;
 
 	pud = pud_offset(p4d, address);
-	if (pud_none(*pud) || pud_large(*pud) || !pud_present(*pud))
+	if (pud_none(*pud) || pud_leaf(*pud) || !pud_present(*pud))
 		return NULL;
 
 	return pmd_offset(pud, address);
@@ -1274,7 +1274,7 @@ static void unmap_pud_range(p4d_t *p4d, unsigned long start, unsigned long end)
 	 */
 	while (end - start >= PUD_SIZE) {
 
-		if (pud_large(*pud))
+		if (pud_leaf(*pud))
 			pud_clear(pud);
 		else
 			unmap_pmd_range(pud, start, start + PUD_SIZE);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index d05dd86ceb41..ff690ddc2334 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -777,7 +777,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
  */
 int pud_clear_huge(pud_t *pud)
 {
-	if (pud_large(*pud)) {
+	if (pud_leaf(*pud)) {
 		pud_clear(pud);
 		return 1;
 	}
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 0442e8f479a6..2e69abf4f852 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -217,7 +217,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 
 	pud = pud_offset(p4d, address);
 	/* The user page tables do not use large mappings: */
-	if (pud_large(*pud)) {
+	if (pud_leaf(*pud)) {
 		WARN_ON(1);
 		return NULL;
 	}
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 277eaf610e0e..5b81d19cd114 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -170,7 +170,7 @@ int relocate_restore_code(void)
 		goto out;
 	}
 	pud = pud_offset(p4d, relocated_restore_code);
-	if (pud_large(*pud)) {
+	if (pud_leaf(*pud)) {
 		set_pud(pud, __pud(pud_val(*pud) & ~_PAGE_NX));
 		goto out;
 	}
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index dde551bbd231..54e0d311dcc9 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1082,7 +1082,7 @@ static void __init xen_cleanmfnmap_pud(pud_t *pud, bool unpin)
 	pmd_t *pmd_tbl;
 	int i;
 
-	if (pud_large(*pud)) {
+	if (pud_leaf(*pud)) {
 		pa = pud_val(*pud) & PHYSICAL_PAGE_MASK;
 		xen_free_ro_pages(pa, PUD_SIZE);
 		return;
@@ -1863,7 +1863,7 @@ static phys_addr_t __init xen_early_virt_to_phys(unsigned long vaddr)
 	if (!pud_present(pud))
 		return 0;
 	pa = pud_val(pud) & PTE_PFN_MASK;
-	if (pud_large(pud))
+	if (pud_leaf(pud))
 		return pa + (vaddr & ~PUD_MASK);
 
 	pmd = native_make_pmd(xen_read_phys_ulong(pa + pmd_index(vaddr) *
-- 
2.44.0


