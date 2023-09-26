Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C39C7AE319
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjIZAxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjIZAxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:53:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18705109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:53:14 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvh2C6FzGztT3x;
        Tue, 26 Sep 2023 08:48:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 08:53:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 8/9] mm: page_alloc: use a folio in free_pages_prepare()
Date:   Tue, 26 Sep 2023 08:52:53 +0800
Message-ID: <20230926005254.2861577-9-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
References: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page should not a tail page in free_pages_prepare(), let's use
a folio in free_pages_prepare() to save several compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/page_alloc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 06be8821d833..a888b9d57751 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1070,6 +1070,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			unsigned int order, fpi_t fpi_flags)
 {
 	int bad = 0;
+	struct folio *folio = page_folio(page);
 	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
 	bool init = want_init_on_free();
 
@@ -1078,12 +1079,12 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
-	if (unlikely(PageHWPoison(page)) && !order) {
+	if (unlikely(folio_test_hwpoison(folio)) && !order) {
 		/*
 		 * Do not let hwpoison pages hit pcplists/buddy
 		 * Untie memcg state and reset page's owner
 		 */
-		if (memcg_kmem_online() && PageMemcgKmem(page))
+		if (memcg_kmem_online() && folio_memcg_kmem(folio))
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
@@ -1095,10 +1096,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	 * avoid checking PageCompound for order-0 pages.
 	 */
 	if (unlikely(order)) {
-		bool compound = PageCompound(page);
+		bool compound = folio_test_large(folio);
 		int i;
 
-		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
+		VM_BUG_ON_FOLIO(compound && folio_order(folio) != order, folio);
 
 		if (compound)
 			page[1].flags &= ~PAGE_FLAGS_SECOND;
@@ -1114,9 +1115,9 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 		}
 	}
-	if (PageMappingFlags(page))
+	if (folio_mapping_flags(folio))
 		page->mapping = NULL;
-	if (memcg_kmem_online() && PageMemcgKmem(page))
+	if (memcg_kmem_online() && folio_memcg_kmem(folio))
 		__memcg_kmem_uncharge_page(page, order);
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
@@ -1130,7 +1131,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
 
-	if (!PageHighMem(page)) {
+	if (!folio_test_highmem(folio)) {
 		debug_check_no_locks_freed(page_address(page),
 					   PAGE_SIZE << order);
 		debug_check_no_obj_freed(page_address(page),
-- 
2.27.0

