Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B97651E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjG0LDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjG0LCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:02:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5871330CF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:02:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96136D75;
        Thu, 27 Jul 2023 04:03:16 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAFA03F5A1;
        Thu, 27 Jul 2023 04:02:31 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1] mm: Fix use-after-free for MMU_GATHER_NO_GATHER
Date:   Thu, 27 Jul 2023 12:02:24 +0100
Message-Id: <20230727110224.3333682-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change to batch-zap anonymous ptes did not take into account
that for platforms where MMU_GATHER_NO_GATHER is enabled (e.g. s390),
__tlb_remove_page() drops a reference to the page. This means that the
folio reference count can drop to zero while still in use (i.e. before
folio_remove_rmap_range() is called). This does not happen on other
platforms because the actual page freeing is deferred.

Solve this by appropriately getting/putting the folio to guarrantee it
does not get freed early.

Given the new need to get/put the folio in the batch path, let's stick
to the non-batched path if the folio is not large. In this case batching
is not helpful since the batch size is 1.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Fixes: 904d9713b3b0 ("mm: batch-zap large anonymous folio PTE mappings")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/linux-mm/20230726161942.GA1123863@dev-arch.thelio-3990X/
---

Hi Andrew,

This fixes patch 3 in the series at [1], which is currently in mm-unstable. I'm
not sure whether you want to take the fix or whether I should re-post the entire
series?

Thanks,
Ryan


 mm/memory.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2130bad76eb1..808f6408a570 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1456,6 +1456,9 @@ static unsigned long try_zap_anon_pte_range(struct mmu_gather *tlb,
 	bool full;
 	int i;

+	/* __tlb_remove_page drops a ref; prevent it going to 0 while in use. */
+	folio_get(folio);
+
 	for (i = 0; i < nr_pages;) {
 		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
 		tlb_remove_tlb_entry(tlb, pte, addr);
@@ -1476,6 +1479,8 @@ static unsigned long try_zap_anon_pte_range(struct mmu_gather *tlb,

 	folio_remove_rmap_range(folio, page - i, i, vma);

+	folio_put(folio);
+
 	return i;
 }

@@ -1526,26 +1531,33 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			 */
 			if (page && PageAnon(page)) {
 				struct folio *folio = page_folio(page);
-				int nr_pages_req, nr_pages;

-				nr_pages_req = folio_nr_pages_cont_mapped(
-						folio, page, pte, addr, end);
+				if (folio_test_large(folio)) {
+					int nr_pages_req, nr_pages;
+					int counter = mm_counter(page);

-				nr_pages = try_zap_anon_pte_range(tlb, vma,
-						folio, page, pte, addr,
-						nr_pages_req, details);
+					nr_pages_req = folio_nr_pages_cont_mapped(
+							folio, page, pte, addr,
+							end);

-				rss[mm_counter(page)] -= nr_pages;
-				nr_pages--;
-				pte += nr_pages;
-				addr += nr_pages << PAGE_SHIFT;
+					/* folio may be freed on return. */
+					nr_pages = try_zap_anon_pte_range(
+							tlb, vma, folio, page,
+							pte, addr, nr_pages_req,
+							details);

-				if (unlikely(nr_pages < nr_pages_req)) {
-					force_flush = 1;
-					addr += PAGE_SIZE;
-					break;
+					rss[counter] -= nr_pages;
+					nr_pages--;
+					pte += nr_pages;
+					addr += nr_pages << PAGE_SHIFT;
+
+					if (unlikely(nr_pages < nr_pages_req)) {
+						force_flush = 1;
+						addr += PAGE_SIZE;
+						break;
+					}
+					continue;
 				}
-				continue;
 			}

 			ptent = ptep_get_and_clear_full(mm, addr, pte,
--
2.25.1

