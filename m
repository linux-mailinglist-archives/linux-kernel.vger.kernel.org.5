Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A435D7F58B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbjKWG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjKWG5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:57:25 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D82C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:31 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b84402923fso329218b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700722651; x=1701327451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WCHkg8EwYgV8K7NhoHBdWRiWjVGGiMNhMP8Dvq/T3c=;
        b=IZ1oQT7rlVxuJ3/nFJrqcLkeNP0MNSZWN10NcvwoOrBiKjtTZcpGfzcxMj4yIn+UCi
         ylnoQDiFfw45PHuu9SNmF02NP/ZwoAvruEj7hXjQtJtHlkpfkohGPdDqBTUUHL9j5HdL
         xzORU0lNsNM1xDCLFyn9bUm19f4aYyi4+TGsp7aQcc51OyqoqWlCm2y/TzOvK8f1+qMr
         r+tYAk4+zOXTlxsDWausQnwuFyjEqz65zhIQr61hTiQtIdomxbkmhyZOG19gWl/P2r4v
         6XArHvmB149aU7Rrm2Y+ObUMnMqGucCpd2zmQ02COz9yXmM/SW8fIRbuB7H70uTB4zyF
         7OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722651; x=1701327451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WCHkg8EwYgV8K7NhoHBdWRiWjVGGiMNhMP8Dvq/T3c=;
        b=un5G1hDrM5kW/3HJ2o5OXl8i5maQmnUJDvc3A6sTyGjJQhu0wPwJg9zX/xSuppsvRX
         Lr6aJap/1Ca50byMmqWH6SmpfHLJy+pDmaZSCB+3td/WSES/b3xcX/jLkPvpi4PERJ2X
         C9MMTHZeiy4PwzoJUWMOiyG8k9RRAQIJUy1lIVxbvII1yuHE2q0UX7tHAlbzf7upr1Md
         qKqUMJk6+VAO+w98U3GvIHTDRCJuQ+U2Q3xhWXergTNKAun1un1UTvtBXbEQlDKmSkGv
         Jt95t2DG7GNUgr75GnMKx0EtvGITyksDlDj3pHktrOqileV6Con04NuR+PrQrAzt7USZ
         dQ/g==
X-Gm-Message-State: AOJu0YxUo+Zw7b7fCZRrup+hGv85nKijQZocXzECBB4FvXcY7iyenx+S
        c8YAIyazYa41dymIBOcXuCAHtg==
X-Google-Smtp-Source: AGHT+IF+JUV2qs3GxZcMJ8mDN8tfMhVpkCkyXhPxn9II1VI5nQr9SgqkEEhOwu5qk/0BmZa46AiHEg==
X-Received: by 2002:a05:6808:2096:b0:3b2:e461:bcfc with SMTP id s22-20020a056808209600b003b2e461bcfcmr5671424oiw.20.1700722651004;
        Wed, 22 Nov 2023 22:57:31 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id w37-20020a634765000000b005bd2b3a03eesm615437pgk.6.2023.11.22.22.57.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Nov 2023 22:57:30 -0800 (PST)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, songmuchun@bytedance.com,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH V1 01/11] mm: Fix misused APIs on huge pte
Date:   Thu, 23 Nov 2023 14:56:58 +0800
Message-Id: <20231123065708.91345-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231123065708.91345-1-luxu.kernel@bytedance.com>
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exist some paths that try to get value of huge pte via normal
pte API ptep_get instead of huge pte API huge_ptep_get. This commit
corrects these misused APIs.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/mm/hugetlbpage.c   |  2 +-
 fs/proc/task_mmu.c            |  2 +-
 include/asm-generic/hugetlb.h |  7 +++++++
 mm/hugetlb.c                  |  2 +-
 mm/migrate.c                  |  5 ++++-
 mm/mprotect.c                 |  2 +-
 mm/rmap.c                     | 10 ++++++++--
 mm/vmalloc.c                  |  3 ++-
 8 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index b52f0210481f..d7cf8e2d3c5b 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -74,7 +74,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 
 out:
 	if (pte) {
-		pte_t pteval = ptep_get_lockless(pte);
+		pte_t pteval = huge_ptep_get_lockless(pte);
 
 		WARN_ON_ONCE(pte_present(pteval) && !pte_huge(pteval));
 	}
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ef2eb12906da..0fe9d23aa062 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -726,7 +726,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	struct page *page = NULL;
-	pte_t ptent = ptep_get(pte);
+	pte_t ptent = huge_ptep_get(pte);
 
 	if (pte_present(ptent)) {
 		page = vm_normal_page(vma, addr, ptent);
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 6dcf4d576970..52c299db971a 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -150,6 +150,13 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
 }
 #endif
 
+#ifndef __HAVE_ARCH_HUGE_PTEP_GET_LOCKLESS
+static inline pte_t huge_ptep_get_lockless(pte_t *ptep)
+{
+	return huge_ptep_get(ptep);
+}
+#endif
+
 #ifndef __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
 static inline bool gigantic_page_runtime_supported(void)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1169ef2f2176..9f773eb95b3b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7406,7 +7406,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	if (pte) {
-		pte_t pteval = ptep_get_lockless(pte);
+		pte_t pteval = huge_ptep_get_lockless(pte);
 
 		BUG_ON(pte_present(pteval) && !pte_huge(pteval));
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 35a88334bb3c..d0daf58e486e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -210,7 +210,10 @@ static bool remove_migration_pte(struct folio *folio,
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
-		old_pte = ptep_get(pvmw.pte);
+		if (folio_test_hugetlb(folio))
+			old_pte = huge_ptep_get(pvmw.pte);
+		else
+			old_pte = ptep_get(pvmw.pte);
 		if (pte_swp_soft_dirty(old_pte))
 			pte = pte_mksoft_dirty(pte);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 81991102f785..b9129c03f451 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -555,7 +555,7 @@ static int prot_none_hugetlb_entry(pte_t *pte, unsigned long hmask,
 				   unsigned long addr, unsigned long next,
 				   struct mm_walk *walk)
 {
-	return pfn_modify_allowed(pte_pfn(ptep_get(pte)),
+	return pfn_modify_allowed(pte_pfn(huge_ptep_get(pte)),
 				  *(pgprot_t *)(walk->private)) ?
 		0 : -EACCES;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..d93c6dabbdf4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1577,7 +1577,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			break;
 		}
 
-		pfn = pte_pfn(ptep_get(pvmw.pte));
+		if (folio_test_hugetlb(folio))
+			pfn = pte_pfn(huge_ptep_get(pvmw.pte));
+		else
+			pfn = pte_pfn(ptep_get(pvmw.pte));
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
@@ -1931,7 +1934,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		pfn = pte_pfn(ptep_get(pvmw.pte));
+		if (folio_test_hugetlb(folio))
+			pfn = pte_pfn(huge_ptep_get(pvmw.pte));
+		else
+			pfn = pte_pfn(ptep_get(pvmw.pte));
 
 		if (folio_is_zone_device(folio)) {
 			/*
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..1a451b82a7ac 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -103,7 +103,6 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (!pte)
 		return -ENOMEM;
 	do {
-		BUG_ON(!pte_none(ptep_get(pte)));
 
 #ifdef CONFIG_HUGETLB_PAGE
 		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
@@ -111,11 +110,13 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			pte_t entry = pfn_pte(pfn, prot);
 
 			entry = arch_make_huge_pte(entry, ilog2(size), 0);
+			BUG_ON(!pte_none(huge_ptep_get(pte)));
 			set_huge_pte_at(&init_mm, addr, pte, entry, size);
 			pfn += PFN_DOWN(size);
 			continue;
 		}
 #endif
+		BUG_ON(!pte_none(ptep_get(pte)));
 		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte += PFN_DOWN(size), addr += size, addr != end);
-- 
2.20.1

