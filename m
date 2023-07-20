Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50B175AF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGTNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGTNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:02:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A1C269F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:02:25 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6CW44vcBzrRqs;
        Thu, 20 Jul 2023 21:01:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 21:02:21 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <hch@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v3 10/10] mm/page_io: convert bio_associate_blkg_from_page() to take in a folio
Date:   Thu, 20 Jul 2023 21:01:47 +0800
Message-ID: <20230720130147.4071649-11-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720130147.4071649-1-zhangpeng362@huawei.com>
References: <20230720130147.4071649-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
index da3f38404585..cc2503bd511a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -213,12 +213,12 @@ static inline void count_swpout_vm_event(struct folio *folio)
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
 
@@ -228,7 +228,7 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 	rcu_read_unlock();
 }
 #else
-#define bio_associate_blkg_from_page(bio, page)		do { } while (0)
+#define bio_associate_blkg_from_page(bio, folio)		do { } while (0)
 #endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
 
 struct swap_iocb {
@@ -336,7 +336,7 @@ static void swap_writepage_bdev_sync(struct page *page,
 	bio.bi_iter.bi_sector = swap_page_sector(page);
 	__bio_add_page(&bio, page, thp_size(page), 0);
 
-	bio_associate_blkg_from_page(&bio, page);
+	bio_associate_blkg_from_page(&bio, folio);
 	count_swpout_vm_event(folio);
 
 	folio_start_writeback(folio);
@@ -359,7 +359,7 @@ static void swap_writepage_bdev_async(struct page *page,
 	bio->bi_end_io = end_swap_bio_write;
 	__bio_add_page(bio, page, thp_size(page), 0);
 
-	bio_associate_blkg_from_page(bio, page);
+	bio_associate_blkg_from_page(bio, folio);
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
 	folio_unlock(folio);
-- 
2.25.1

