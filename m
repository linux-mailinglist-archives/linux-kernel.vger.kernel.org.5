Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F442756D40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGQTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjGQTaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC18E1;
        Mon, 17 Jul 2023 12:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9E86122B;
        Mon, 17 Jul 2023 19:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282DCC433C8;
        Mon, 17 Jul 2023 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689622219;
        bh=B3lKcl6AG4VzLC8vKc3oOwsXsHm9qE0hLnyJCufjkwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZBQ0hW12YiHopMYlgU/iscjagmj++kFnsMTRjCXXss4RiQSZmC+t1AoqGLtwSH/Q
         ApRemcZP1v8V0m6UAxS1FT0C/s3o6IyBBx980E6uz1JTeeg30qeLdFNpeh9eiAS9UO
         ypGzf+fanyWIUa5996eXCNxKos8nrQJD3hXn+b51BlcSEZIg2QtnqOntZITca/GM3F
         rWSt60S2igAtbmHSzNBLFkG3/oW96LvlEHPby+FkCu4ayFcG44Y4eOBUCl49O4AGum
         zt7XLhr0V/n4IPtlkN1uJL/Pb9V6soEQ9Rdl6aqDNqN/1So3uIzt8vuoZTSC0w4ClN
         Q5VPS8kggiT0Q==
From:   SeongJae Park <sj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     ryan.roberts@arm.com, akpm@linux-foundation.org, hch@lst.de,
        kirill.shutemov@linux.intel.com, lstoakes@gmail.com,
        rppt@kernel.org, sj@kernel.org, stable@vger.kernel.org,
        urezki@gmail.com, willy@infradead.org, yuzhao@google.com,
        ziy@nvidia.com, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] mm/damon/ops-common: atomically test and clear young on ptes and pmds
Date:   Mon, 17 Jul 2023 19:30:08 +0000
Message-Id: <20230717193008.122040-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023071613-reminder-relapse-b922@gregkh>
References: <2023071613-reminder-relapse-b922@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Roberts <ryan.roberts@arm.com>

commit c11d34fa139e4b0fb4249a30f37b178353533fa1 upstream.

It is racy to non-atomically read a pte, then clear the young bit, then
write it back as this could discard dirty information.  Further, it is bad
practice to directly set a pte entry within a table.  Instead clearing
young must go through the arch-provided helper,
ptep_test_and_clear_young() to ensure it is modified atomically and to
give the arch code visibility and allow it to check (and potentially
modify) the operation.

Link: https://lkml.kernel.org/r/20230602092949.545577-3-ryan.roberts@arm.com
Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces").
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
This is a manual backport of the commit, which cannot cleanly
cherry-picked on 5.15.y[1], on 5.15.y, specifically 5.15.120.

[1] https://lore.kernel.org/stable/2023071613-reminder-relapse-b922@gregkh/

 mm/damon/vaddr.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1945196fd743..6ad96da15081 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -393,7 +393,7 @@ static struct page *damon_get_page(unsigned long pfn)
 	return page;
 }
 
-static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
+static void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma,
 			     unsigned long addr)
 {
 	bool referenced = false;
@@ -402,13 +402,11 @@ static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
 	if (!page)
 		return;
 
-	if (pte_young(*pte)) {
+	if (ptep_test_and_clear_young(vma, addr, pte))
 		referenced = true;
-		*pte = pte_mkold(*pte);
-	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
+	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
 
@@ -419,7 +417,7 @@ static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
 	put_page(page);
 }
 
-static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
+static void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma,
 			     unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -429,13 +427,11 @@ static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
 	if (!page)
 		return;
 
-	if (pmd_young(*pmd)) {
+	if (pmdp_test_and_clear_young(vma, addr, pmd))
 		referenced = true;
-		*pmd = pmd_mkold(*pmd);
-	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr,
+	if (mmu_notifier_clear_young(vma->vm_mm, addr,
 				addr + ((1UL) << HPAGE_PMD_SHIFT)))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
@@ -462,7 +458,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		}
 
 		if (pmd_huge(*pmd)) {
-			damon_pmdp_mkold(pmd, walk->mm, addr);
+			damon_pmdp_mkold(pmd, walk->vma, addr);
 			spin_unlock(ptl);
 			return 0;
 		}
@@ -474,7 +470,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte_present(*pte))
 		goto out;
-	damon_ptep_mkold(pte, walk->mm, addr);
+	damon_ptep_mkold(pte, walk->vma, addr);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;
-- 
2.25.1

