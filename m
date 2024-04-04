Return-Path: <linux-kernel+bounces-131513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350E8988E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9C21F22C25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E212839D;
	Thu,  4 Apr 2024 13:37:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE912838A;
	Thu,  4 Apr 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237836; cv=none; b=nIlFPX6+zDmL0vQ3yIkfRvoU0mV6ilC5Ka1Ph1PIqcMJw1GHcZ2b7uIv1H6UK63ZShWGSI3TTZc6pYuptQYBrvD4m83j8IJOcRvkHr/6bzHviqVawHdmD0ELDUyCpPy0jP6IUtfadNH49tiMklLtnLNopSGL0VLFeG1jh0Od5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237836; c=relaxed/simple;
	bh=ddqupzXUZSofI+WMDJou/va1wQCQQkBHUreBxZzCrko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m310uWQaTpqffO5D981dgI2oMILqTDwgSxn3sJfovLpLiJKwIu/KyjyWE8wsKFW1pms5E7D5hCwbtC/yIkEV9cVvut2nWfVc17t0ljEvL0/0U3rhBpiL1YaEJLleO0HaLgRxHb47Q8Z3WXv53gkMUgQQ8hhgiCoVnjgXC/Z6yOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3756EC433C7;
	Thu,  4 Apr 2024 13:37:13 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-mm@kvack.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 2/3] LoongArch: Make {virt, phys, page, pfn} translation work with KFENCE
Date: Thu,  4 Apr 2024 21:36:35 +0800
Message-ID: <20240404133642.971583-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404133642.971583-1-chenhuacai@loongson.cn>
References: <20240404133642.971583-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KFENCE changes virt_to_page() to be able to translate tlb mapped virtual
addresses, but forget to change virt_to_phys()/phys_to_virt() and other
translation functions as well. This patch fix it, otherwise some drivers
(such as nvme and virtio-blk) cannot work with KFENCE.

All {virt, phys, page, pfn} translation functions are updated:
1, virt_to_pfn()/pfn_to_virt();
2, virt_to_page()/page_to_virt();
3, virt_to_phys()/phys_to_virt().

DMW/TLB mapped addresses are distinguished by comparing the vaddress
with vm_map_base in virt_to_xyz(), and we define WANT_PAGE_VIRTUAL in
the KFENCE case for the reverse translations, xyz_to_virt().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/io.h     | 20 +++++++++++++++-----
 arch/loongarch/include/asm/kfence.h |  9 +++++++++
 arch/loongarch/include/asm/page.h   | 26 +++++++++++++++++++++++++-
 arch/loongarch/mm/pgtable.c         |  4 ++--
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 4a8adcca329b..c2f9979b2979 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -14,11 +14,6 @@
 #include <asm/pgtable-bits.h>
 #include <asm/string.h>
 
-/*
- * Change "struct page" to physical address.
- */
-#define page_to_phys(page)	((phys_addr_t)page_to_pfn(page) << PAGE_SHIFT)
-
 extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size);
 extern void __init early_iounmap(void __iomem *addr, unsigned long size);
 
@@ -73,6 +68,21 @@ extern void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t
 
 #define __io_aw() mmiowb()
 
+#ifdef CONFIG_KFENCE
+#define virt_to_phys(kaddr)								\
+({											\
+	(likely((unsigned long)kaddr < vm_map_base)) ? __pa((unsigned long)kaddr) :	\
+	page_to_phys(tlb_virt_to_page((unsigned long)kaddr)) + offset_in_page((unsigned long)kaddr);\
+})
+
+#define phys_to_virt(paddr)								\
+({											\
+	extern char *__kfence_pool;							\
+	(unlikely(__kfence_pool == NULL)) ? __va((unsigned long)paddr) :		\
+	page_address(phys_to_page((unsigned long)paddr)) + offset_in_page((unsigned long)paddr);\
+})
+#endif
+
 #include <asm-generic/io.h>
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
diff --git a/arch/loongarch/include/asm/kfence.h b/arch/loongarch/include/asm/kfence.h
index 6c82aea1c993..a6a5760da3a3 100644
--- a/arch/loongarch/include/asm/kfence.h
+++ b/arch/loongarch/include/asm/kfence.h
@@ -16,6 +16,7 @@
 static inline bool arch_kfence_init_pool(void)
 {
 	int err;
+	char *kaddr, *vaddr;
 	char *kfence_pool = __kfence_pool;
 	struct vm_struct *area;
 
@@ -35,6 +36,14 @@ static inline bool arch_kfence_init_pool(void)
 		return false;
 	}
 
+	kaddr = kfence_pool;
+	vaddr = __kfence_pool;
+	while (kaddr < kfence_pool + KFENCE_POOL_SIZE) {
+		set_page_address(virt_to_page(kaddr), vaddr);
+		kaddr += PAGE_SIZE;
+		vaddr += PAGE_SIZE;
+	}
+
 	return true;
 }
 
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index 44027060c54a..e85df33f11c7 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -78,7 +78,26 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 struct page *dmw_virt_to_page(unsigned long kaddr);
 struct page *tlb_virt_to_page(unsigned long kaddr);
 
-#define virt_to_pfn(kaddr)	PFN_DOWN(PHYSADDR(kaddr))
+#define pfn_to_phys(pfn)	__pfn_to_phys(pfn)
+#define phys_to_pfn(paddr)	__phys_to_pfn(paddr)
+
+#define page_to_phys(page)	pfn_to_phys(page_to_pfn(page))
+#define phys_to_page(paddr)	pfn_to_page(phys_to_pfn(paddr))
+
+#ifndef CONFIG_KFENCE
+
+#define page_to_virt(page)	__va(page_to_phys(page))
+#define virt_to_page(kaddr)	phys_to_page(__pa(kaddr))
+
+#else
+
+#define WANT_PAGE_VIRTUAL
+
+#define page_to_virt(page)								\
+({											\
+	extern char *__kfence_pool;							\
+	(__kfence_pool == NULL) ? __va(page_to_phys(page)) : page_address(page);	\
+})
 
 #define virt_to_page(kaddr)								\
 ({											\
@@ -86,6 +105,11 @@ struct page *tlb_virt_to_page(unsigned long kaddr);
 	dmw_virt_to_page((unsigned long)kaddr) : tlb_virt_to_page((unsigned long)kaddr);\
 })
 
+#endif
+
+#define pfn_to_virt(pfn)	page_to_virt(pfn_to_page(pfn))
+#define virt_to_pfn(kaddr)	page_to_pfn(virt_to_page(kaddr))
+
 extern int __virt_addr_valid(volatile void *kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((volatile void *)(kaddr))
 
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 2aae72e63871..bda018150000 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -11,13 +11,13 @@
 
 struct page *dmw_virt_to_page(unsigned long kaddr)
 {
-	return pfn_to_page(virt_to_pfn(kaddr));
+	return phys_to_page(__pa(kaddr));
 }
 EXPORT_SYMBOL(dmw_virt_to_page);
 
 struct page *tlb_virt_to_page(unsigned long kaddr)
 {
-	return pfn_to_page(pte_pfn(*virt_to_kpte(kaddr)));
+	return phys_to_page(pfn_to_phys(pte_pfn(*virt_to_kpte(kaddr))));
 }
 EXPORT_SYMBOL(tlb_virt_to_page);
 
-- 
2.43.0


