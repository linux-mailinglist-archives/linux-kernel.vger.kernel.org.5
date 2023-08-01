Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D6B76B4DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjHAMhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjHAMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:37:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F91FC6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:37:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RFZLk2jjKzLnyG;
        Tue,  1 Aug 2023 20:34:54 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 20:37:35 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/page_alloc: avoid unneeded alike_pages calculation
Date:   Tue, 1 Aug 2023 20:37:23 +0800
Message-ID: <20230801123723.2225543-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When free_pages is 0, alike_pages is not used. So alike_pages calculation
can be avoided by checking free_pages early to save cpu cycles. Also fix
typo 'comparable'. It should be 'compatible' here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_alloc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8fe9ff917850..d7a357cb21ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1833,6 +1833,10 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 
 	free_pages = move_freepages_block(zone, page, start_type,
 						&movable_pages);
+	/* moving whole block can fail due to zone boundary conditions */
+	if (!free_pages)
+		goto single_page;
+
 	/*
 	 * Determine how many pages are compatible with our allocation.
 	 * For movable allocation, it's the number of movable pages which
@@ -1854,14 +1858,9 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 		else
 			alike_pages = 0;
 	}
-
-	/* moving whole block can fail due to zone boundary conditions */
-	if (!free_pages)
-		goto single_page;
-
 	/*
 	 * If a sufficient number of pages in the block are either free or of
-	 * comparable migratability as our allocation, claim the whole block.
+	 * compatible migratability as our allocation, claim the whole block.
 	 */
 	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
 			page_group_by_mobility_disabled)
-- 
2.33.0

