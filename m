Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CBE75BCE2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjGUDpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGUDpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:45:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB32729
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:45:11 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R6b5g0PLYz18MC2;
        Fri, 21 Jul 2023 11:44:23 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 11:45:08 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <hch@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v4 01/10] mm/page_io: remove unneeded ClearPageUptodate()
Date:   Fri, 21 Jul 2023 11:44:42 +0800
Message-ID: <20230721034451.16412-2-zhangpeng362@huawei.com>
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

The VM_BUG_ON_FOLIO in swap_readpage() ensures that the page is already
!uptodate in __end_swap_bio_read() and sio_read_complete().
Just remove unneeded ClearPageUptodate().

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/page_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 8741d3a0d48a..3087a69a014b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -62,7 +62,6 @@ static void __end_swap_bio_read(struct bio *bio)
 
 	if (bio->bi_status) {
 		SetPageError(page);
-		ClearPageUptodate(page);
 		pr_alert_ratelimited("Read-error on swap-device (%u:%u:%llu)\n",
 				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
 				     (unsigned long long)bio->bi_iter.bi_sector);
@@ -417,7 +416,6 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 			struct page *page = sio->bvec[p].bv_page;
 
 			SetPageError(page);
-			ClearPageUptodate(page);
 			unlock_page(page);
 		}
 		pr_alert_ratelimited("Read-error on swap-device\n");
-- 
2.25.1

