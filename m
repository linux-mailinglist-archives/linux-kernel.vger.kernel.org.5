Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3875BCEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGUDpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjGUDpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:45:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F1272D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:45:17 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6b5m5KpQzrRqj;
        Fri, 21 Jul 2023 11:44:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 11:45:14 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <hch@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v4 10/10] mm/page_io: convert bio_associate_blkg_from_page() to take in a folio
Date:   Fri, 21 Jul 2023 11:44:51 +0800
Message-ID: <20230721034451.16412-11-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721034451.16412-1-zhangpeng362@huawei.com>
References: <20230721034451.16412-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Convert bio_associate_blkg_from_page() to take in a folio. We can remove
two implicit calls to compound_head() by taking in a folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index f575c0bf545e..fe4c21af23f2 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -215,12 +215,12 @@ static inline void count_swpout_vm_event(struct folio *folio)
 }
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
+static void bio_associate_blkg_from_page(struct bio *bio, struct folio *folio)
 {
 	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg;
 
-	memcg = page_memcg(page);
+	memcg = folio_memcg(folio);
 	if (!memcg)
 		return;
 
@@ -230,7 +230,7 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 	rcu_read_unlock();
 }
 #else
-#define bio_associate_blkg_from_page(bio, page)		do { } while (0)
+#define bio_associate_blkg_from_page(bio, folio)		do { } while (0)
 #endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
 
 struct swap_iocb {
@@ -338,7 +338,7 @@ static void swap_writepage_bdev_sync(struct page *page,
 	bio.bi_iter.bi_sector = swap_page_sector(page);
 	__bio_add_page(&bio, page, thp_size(page), 0);
 
-	bio_associate_blkg_from_page(&bio, page);
+	bio_associate_blkg_from_page(&bio, folio);
 	count_swpout_vm_event(folio);
 
 	folio_start_writeback(folio);
@@ -361,7 +361,7 @@ static void swap_writepage_bdev_async(struct page *page,
 	bio->bi_end_io = end_swap_bio_write;
 	__bio_add_page(bio, page, thp_size(page), 0);
 
-	bio_associate_blkg_from_page(bio, page);
+	bio_associate_blkg_from_page(bio, folio);
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
 	folio_unlock(folio);
-- 
2.25.1

