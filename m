Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21BF7652FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjG0L5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjG0L46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:56:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD122D4E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:56:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RBTgD4yQxzNmV5;
        Thu, 27 Jul 2023 19:53:28 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 19:56:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 4/4] mm: memory-failure: add PageOffline() check
Date:   Thu, 27 Jul 2023 19:56:43 +0800
Message-ID: <20230727115643.639741-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230727115643.639741-1-linmiaohe@huawei.com>
References: <20230727115643.639741-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory failure is not interested in logically offlined page. Skip this
type of pages.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d975a6b224f7..e4c4b9dc852f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1561,7 +1561,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * Here we are interested only in user-mapped pages, so skip any
 	 * other types of pages.
 	 */
-	if (PageReserved(p) || PageSlab(p) || PageTable(p))
+	if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
 		return true;
 	if (!(PageLRU(hpage) || PageHuge(p)))
 		return true;
@@ -2535,7 +2535,8 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
+	if (folio_test_slab(folio) || PageTable(&folio->page) ||
+	    folio_test_reserved(folio) || PageOffline(&folio->page))
 		goto unlock_mutex;
 
 	/*
-- 
2.33.0

