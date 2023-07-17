Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D287564E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjGQN1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjGQN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:27:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076322117
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:26:40 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R4NB24P85zrRlt;
        Mon, 17 Jul 2023 21:25:30 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 21:26:11 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <willy@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH 5/6] mm/page_io: convert count_swpout_vm_event() to take in a folio
Date:   Mon, 17 Jul 2023 21:26:01 +0800
Message-ID: <20230717132602.2202147-6-zhangpeng362@huawei.com>
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

Convert count_swpout_vm_event() to take in a folio. We can remove five
implicit calls to compound_head() by taking in a folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/page_io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 84cc9e652451..66e8403bf96e 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -208,13 +208,13 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 }
 
-static inline void count_swpout_vm_event(struct page *page)
+static inline void count_swpout_vm_event(struct folio *folio)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (unlikely(PageTransHuge(page)))
+	if (unlikely(folio_test_large(folio)))
 		count_vm_event(THP_SWPOUT);
 #endif
-	count_vm_events(PSWPOUT, thp_nr_pages(page));
+	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
@@ -283,7 +283,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 		}
 	} else {
 		for (p = 0; p < sio->pages; p++)
-			count_swpout_vm_event(sio->bvec[p].bv_page);
+			count_swpout_vm_event(page_folio(sio->bvec[p].bv_page));
 	}
 
 	for (p = 0; p < sio->pages; p++)
@@ -342,7 +342,7 @@ static void swap_writepage_bdev_sync(struct page *page,
 	__bio_add_page(&bio, page, thp_size(page), 0);
 
 	bio_associate_blkg_from_page(&bio, page);
-	count_swpout_vm_event(page);
+	count_swpout_vm_event(folio);
 
 	folio_start_writeback(folio);
 	folio_unlock(folio);
@@ -365,7 +365,7 @@ static void swap_writepage_bdev_async(struct page *page,
 	__bio_add_page(bio, page, thp_size(page), 0);
 
 	bio_associate_blkg_from_page(bio, page);
-	count_swpout_vm_event(page);
+	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
 	folio_unlock(folio);
 	submit_bio(bio);
-- 
2.25.1

