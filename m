Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922B575AF06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjGTNC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGTNCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:02:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A0269F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:02:20 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6CSG5GfNztRdc;
        Thu, 20 Jul 2023 20:59:10 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 21:02:17 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <hch@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v3 05/10] mm/page_io: use a folio in __end_swap_bio_read()
Date:   Thu, 20 Jul 2023 21:01:42 +0800
Message-ID: <20230720130147.4071649-6-zhangpeng362@huawei.com>
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

Saves one implicit call to compound_head().

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/page_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index d9f5fa5b7281..3b97289153f9 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -57,16 +57,16 @@ static void end_swap_bio_write(struct bio *bio)
 
 static void __end_swap_bio_read(struct bio *bio)
 {
-	struct page *page = bio_first_page_all(bio);
+	struct folio *folio = bio_first_folio_all(bio);
 
 	if (bio->bi_status) {
 		pr_alert_ratelimited("Read-error on swap-device (%u:%u:%llu)\n",
 				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
 				     (unsigned long long)bio->bi_iter.bi_sector);
 	} else {
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 }
 
 static void end_swap_bio_read(struct bio *bio)
-- 
2.25.1

