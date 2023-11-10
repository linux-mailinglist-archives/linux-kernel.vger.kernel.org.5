Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F537E780C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjKJDeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345807AbjKJDdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:33:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADA64681
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:33:52 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SRPV46ygbzmXKT;
        Fri, 10 Nov 2023 11:30:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 11:33:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 5/7] mm: task_mmu: use a folio in smaps_account()
Date:   Fri, 10 Nov 2023 11:33:22 +0800
Message-ID: <20231110033324.2455523-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace seven implicit calls to compound_head() with one page_folio().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/proc/task_mmu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 51e0ec658457..fe15f99a4908 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -445,23 +445,25 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 {
 	int i, nr = compound ? compound_nr(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
+	struct folio *folio = page_folio(page);
 
 	/*
 	 * First accumulate quantities that depend only on |size| and the type
 	 * of the compound page.
 	 */
-	if (PageAnon(page)) {
+	if (folio_test_anon(folio)) {
 		mss->anonymous += size;
-		if (!PageSwapBacked(page) && !dirty && !PageDirty(page))
+		if (!folio_test_swapbacked(folio) && !dirty &&
+		    !folio_test_dirty(folio))
 			mss->lazyfree += size;
 	}
 
-	if (PageKsm(page))
+	if (folio_test_ksm(folio))
 		mss->ksm += size;
 
 	mss->resident += size;
 	/* Accumulate the size in pages that have been accessed. */
-	if (young || page_is_young(page) || PageReferenced(page))
+	if (young || folio_test_young(folio) || folio_test_referenced(folio))
 		mss->referenced += size;
 
 	/*
@@ -479,7 +481,7 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	 * especially for migration entries.  Treat regular migration entries
 	 * as mapcount == 1.
 	 */
-	if ((page_count(page) == 1) || migration) {
+	if ((folio_ref_count(folio) == 1) || migration) {
 		smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
 			locked, true);
 		return;
-- 
2.27.0

