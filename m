Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C597564EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjGQN1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjGQN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:27:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A330619B2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:26:40 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R4NB406HGz18Lnb;
        Mon, 17 Jul 2023 21:25:31 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 21:26:12 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <willy@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH 6/6] mm/page_io: convert bio_associate_blkg_from_page() to take in a folio
Date:   Mon, 17 Jul 2023 21:26:02 +0800
Message-ID: <20230717132602.2202147-7-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717132602.2202147-1-zhangpeng362@huawei.com>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
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

From: ZhangPeng <zhangpeng362@huawei.com>

Convert bio_associate_blkg_from_page() to take in a folio. We can remove
two implicit calls to compound_head() by taking in a folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/page_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 66e8403bf96e..3c1fede46bd9 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -218,12 +218,12 @@ static inline void count_swpout_vm_event(struct folio *folio)
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
 
@@ -233,7 +233,7 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 	rcu_read_unlock();
 }
 #else
-#define bio_associate_blkg_from_page(bio, page)		do { } while (0)
+#define bio_associate_blkg_from_page(bio, folio)		do { } while (0)
 #endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
 
 struct swap_iocb {
@@ -341,7 +341,7 @@ static void swap_writepage_bdev_sync(struct page *page,
 	bio.bi_iter.bi_sector = swap_page_sector(page);
 	__bio_add_page(&bio, page, thp_size(page), 0);
 
-	bio_associate_blkg_from_page(&bio, page);
+	bio_associate_blkg_from_page(&bio, folio);
 	count_swpout_vm_event(folio);
 
 	folio_start_writeback(folio);
@@ -364,7 +364,7 @@ static void swap_writepage_bdev_async(struct page *page,
 	bio->bi_end_io = end_swap_bio_write;
 	__bio_add_page(bio, page, thp_size(page), 0);
 
-	bio_associate_blkg_from_page(bio, page);
+	bio_associate_blkg_from_page(bio, folio);
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
 	folio_unlock(folio);
-- 
2.25.1

