Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DB675467E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGODRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGODRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:17:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1BD3A82
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:17:22 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R2tll6TXPzVjRT;
        Sat, 15 Jul 2023 11:16:03 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 15 Jul
 2023 11:17:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <shy828301@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 3/4] mm: memory-failure: avoid false hwpoison page mapped error info
Date:   Sat, 15 Jul 2023 11:17:28 +0800
Message-ID: <20230715031729.2420338-4-linmiaohe@huawei.com>
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

folio->_mapcount is overloaded in SLAB, so folio_mapped() has to be done
after folio_test_slab() is checked. Otherwise slab folio might be treated
as a mapped folio leading to false 'Someone maps the hwpoison page' error
info.

Fixes: 230ac719c500 ("mm/hwpoison: don't try to unpoison containment-failed pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ac074f82f5b3..42e63b0ab5f7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2513,6 +2513,13 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
+	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
+		goto unlock_mutex;
+
+	/*
+	 * Note that folio->_mapcount is overloaded in SLAB, so the simple test
+	 * in folio_mapped() has to be done after folio_test_slab() is checked.
+	 */
 	if (folio_mapped(folio)) {
 		unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
@@ -2525,9 +2532,6 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
-		goto unlock_mutex;
-
 	ret = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ret) {
 		if (PageHuge(p)) {
-- 
2.33.0

