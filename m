Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99F27E0105
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbjKCH3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbjKCH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:29:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C7C1A8;
        Fri,  3 Nov 2023 00:29:16 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMC6W1mdSzvQJd;
        Fri,  3 Nov 2023 15:29:07 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 15:29:10 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 4/5] fs/proc/page: use a folio in stable_page_flags()
Date:   Fri, 3 Nov 2023 15:29:05 +0800
Message-ID: <20231103072906.2000381-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
References: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace ten compound_head() calls with one page_folio().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/proc/page.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 195b077c0fac..94ab0ba13b16 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -109,6 +109,7 @@ static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
 
 u64 stable_page_flags(struct page *page)
 {
+	struct folio *folio;
 	u64 k;
 	u64 u;
 
@@ -119,6 +120,7 @@ u64 stable_page_flags(struct page *page)
 	if (!page)
 		return 1 << KPF_NOPAGE;
 
+	folio = page_folio(page);
 	k = page->flags;
 	u = 0;
 
@@ -128,11 +130,11 @@ u64 stable_page_flags(struct page *page)
 	 * Note that page->_mapcount is overloaded in SLAB, so the
 	 * simple test in page_mapped() is not enough.
 	 */
-	if (!PageSlab(page) && page_mapped(page))
+	if (!folio_test_slab(folio) && folio_mapped(folio))
 		u |= 1 << KPF_MMAP;
-	if (PageAnon(page))
+	if (folio_test_anon(folio))
 		u |= 1 << KPF_ANON;
-	if (PageKsm(page))
+	if (folio_test_ksm(folio))
 		u |= 1 << KPF_KSM;
 
 	/*
@@ -152,11 +154,9 @@ u64 stable_page_flags(struct page *page)
 	 * to make sure a given page is a thp, not a non-huge compound page.
 	 */
 	else if (PageTransCompound(page)) {
-		struct page *head = compound_head(page);
-
-		if (PageLRU(head) || PageAnon(head))
+		if (folio_test_lru(folio) || folio_test_anon(folio))
 			u |= 1 << KPF_THP;
-		else if (is_huge_zero_page(head)) {
+		else if (is_huge_zero_page(&folio->page)) {
 			u |= 1 << KPF_ZERO_PAGE;
 			u |= 1 << KPF_THP;
 		}
@@ -170,7 +170,7 @@ u64 stable_page_flags(struct page *page)
 	 */
 	if (PageBuddy(page))
 		u |= 1 << KPF_BUDDY;
-	else if (page_count(page) == 0 && is_free_buddy_page(page))
+	else if (folio_ref_count(folio) == 0 && is_free_buddy_page(page))
 		u |= 1 << KPF_BUDDY;
 
 	if (PageOffline(page))
@@ -178,13 +178,13 @@ u64 stable_page_flags(struct page *page)
 	if (PageTable(page))
 		u |= 1 << KPF_PGTABLE;
 
-	if (page_is_idle(page))
+	if (folio_test_idle(folio))
 		u |= 1 << KPF_IDLE;
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
 
 	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
-	if (PageTail(page) && PageSlab(page))
+	if (PageTail(page) && folio_test_slab(folio))
 		u |= 1 << KPF_SLAB;
 
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
@@ -197,7 +197,7 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_ACTIVE,	PG_active);
 	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
 
-	if (PageSwapCache(page))
+	if (folio_test_swapcache(folio))
 		u |= 1 << KPF_SWAPCACHE;
 	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
 
-- 
2.27.0

