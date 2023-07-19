Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E631759235
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjGSJ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGSJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:59:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898911715
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:58:59 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R5WRC0MkCztQlV;
        Wed, 19 Jul 2023 17:55:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:58:57 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 5/9] mm/page_io: use a folio in sio_read_complete()
Date:   Wed, 19 Jul 2023 17:58:44 +0800
Message-ID: <20230719095848.3422629-6-zhangpeng362@huawei.com>
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

Saves one implicit call to compound_head().

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/page_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 6520687bd282..92f21f380ee8 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -403,17 +403,17 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 
 	if (ret == sio->len) {
 		for (p = 0; p < sio->pages; p++) {
-			struct page *page = sio->bvec[p].bv_page;
+			struct folio *folio = page_folio(sio->bvec[p].bv_page);
 
-			SetPageUptodate(page);
-			unlock_page(page);
+			folio_mark_uptodate(folio);
+			folio_unlock(folio);
 		}
 		count_vm_events(PSWPIN, sio->pages);
 	} else {
 		for (p = 0; p < sio->pages; p++) {
-			struct page *page = sio->bvec[p].bv_page;
+			struct folio *folio = page_folio(sio->bvec[p].bv_page);
 
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 		pr_alert_ratelimited("Read-error on swap-device\n");
 	}
-- 
2.25.1

