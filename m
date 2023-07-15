Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1480B75467B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGODRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGODRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:17:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D32D51
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:17:22 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R2tjk2f2VztRB3;
        Sat, 15 Jul 2023 11:14:18 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 15 Jul
 2023 11:17:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <shy828301@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 2/4] mm: memory-failure: fix potential unexpected return value from unpoison_memory()
Date:   Sat, 15 Jul 2023 11:17:27 +0800
Message-ID: <20230715031729.2420338-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230715031729.2420338-1-linmiaohe@huawei.com>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
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

If unpoison_memory() fails to clear page hwpoisoned flag, return value
ret is expected to be -EBUSY. But when get_hwpoison_page() returns 1
and fails to clear page hwpoisoned flag due to races, return value will
be unexpected 1 leading to users being confused.

Fixes: bf181c582588 ("mm/hwpoison: fix unpoison_memory()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9ab97016877e..ac074f82f5b3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2546,11 +2546,11 @@ int unpoison_memory(unsigned long pfn)
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
 					 pfn, &unpoison_rs);
 	} else {
+		ret = -EBUSY;
 		if (PageHuge(p)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
 			if (count == 0) {
-				ret = -EBUSY;
 				folio_put(folio);
 				goto unlock_mutex;
 			}
-- 
2.33.0

