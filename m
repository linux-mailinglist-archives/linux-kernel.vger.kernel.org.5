Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B071782826
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjHULpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjHULps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:45:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C8EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:45:37 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTrDT6tzyzNnKL;
        Mon, 21 Aug 2023 19:42:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 19:45:35 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 5/8] mm: migrate: use __folio_test_movable()
Date:   Mon, 21 Aug 2023 19:56:21 +0800
Message-ID: <20230821115624.158759-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Use __folio_test_movable(), no need to convert from folio to page again.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index fc728f9a383f..b715cd59bdec 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -157,8 +157,8 @@ void putback_movable_pages(struct list_head *l)
 		list_del(&folio->lru);
 		/*
 		 * We isolated non-lru movable folio so here we can use
-		 * __PageMovable because LRU folio's mapping cannot have
-		 * PAGE_MAPPING_MOVABLE.
+		 * __folio_test_movable because LRU folio's mapping cannot
+		 * have PAGE_MAPPING_MOVABLE.
 		 */
 		if (unlikely(__folio_test_movable(folio))) {
 			VM_BUG_ON_FOLIO(!folio_test_isolated(folio), folio);
@@ -943,7 +943,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
 {
 	int rc = -EAGAIN;
-	bool is_lru = !__PageMovable(&src->page);
+	bool is_lru = !__folio_test_movable(src);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
 	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
@@ -990,7 +990,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 	 * src is freed; but stats require that PageAnon be left as PageAnon.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		if (__PageMovable(&src->page)) {
+		if (__folio_test_movable(src)) {
 			VM_BUG_ON_FOLIO(!folio_test_isolated(src), src);
 
 			/*
@@ -1082,7 +1082,7 @@ static void migrate_folio_done(struct folio *src,
 	/*
 	 * Compaction can migrate also non-LRU pages which are
 	 * not accounted to NR_ISOLATED_*. They can be recognized
-	 * as __PageMovable
+	 * as __folio_test_movable
 	 */
 	if (likely(!__folio_test_movable(src)))
 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
@@ -1103,7 +1103,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	int rc = -EAGAIN;
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
-	bool is_lru = !__PageMovable(&src->page);
+	bool is_lru = !__folio_test_movable(src);
 	bool locked = false;
 	bool dst_locked = false;
 
@@ -1261,7 +1261,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	int rc;
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
-	bool is_lru = !__PageMovable(&src->page);
+	bool is_lru = !__folio_test_movable(src);
 	struct list_head *prev;
 
 	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
-- 
2.41.0

