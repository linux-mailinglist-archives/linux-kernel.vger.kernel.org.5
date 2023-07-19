Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42586759229
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjGSJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGSJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:58:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FDE10D4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:58:57 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R5WQv5t2TzNmPb;
        Wed, 19 Jul 2023 17:55:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:58:54 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 2/9] mm/page_io: remove unneeded SetPageError()
Date:   Wed, 19 Jul 2023 17:58:41 +0800
Message-ID: <20230719095848.3422629-3-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719095848.3422629-1-zhangpeng362@huawei.com>
References: <20230719095848.3422629-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Nobody checks the PageError()/folio_test_error() for the page/folio in
__end_swap_bio_read/write() and sio_write_complete(). Therefore, we
don't need to set the error flag. Just drop it.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/page_io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 3087a69a014b..5ddb5d9c5013 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -32,7 +32,6 @@ static void __end_swap_bio_write(struct bio *bio)
 	struct page *page = bio_first_page_all(bio);
 
 	if (bio->bi_status) {
-		SetPageError(page);
 		/*
 		 * We failed to write the page out to swap-space.
 		 * Re-dirty the page in order to avoid it being reclaimed.
@@ -61,7 +60,6 @@ static void __end_swap_bio_read(struct bio *bio)
 	struct page *page = bio_first_page_all(bio);
 
 	if (bio->bi_status) {
-		SetPageError(page);
 		pr_alert_ratelimited("Read-error on swap-device (%u:%u:%llu)\n",
 				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
 				     (unsigned long long)bio->bi_iter.bi_sector);
@@ -415,7 +413,6 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 		for (p = 0; p < sio->pages; p++) {
 			struct page *page = sio->bvec[p].bv_page;
 
-			SetPageError(page);
 			unlock_page(page);
 		}
 		pr_alert_ratelimited("Read-error on swap-device\n");
-- 
2.25.1

