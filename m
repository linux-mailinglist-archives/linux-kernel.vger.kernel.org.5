Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EF47E780B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbjKJDeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbjKJDdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:33:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB8744BD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:33:52 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SRPV55pKYzmXKR;
        Fri, 10 Nov 2023 11:30:37 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 11:33:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 7/7] page_idle: kill page idle and young wrapper
Date:   Fri, 10 Nov 2023 11:33:24 +0800
Message-ID: <20231110033324.2455523-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all the calls of page idle and young functions are gone,
let's remove all the wrapper.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/page_idle.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
index d8f344840643..1168d5f58ff2 100644
--- a/include/linux/page_idle.h
+++ b/include/linux/page_idle.h
@@ -119,29 +119,4 @@ static inline void folio_clear_idle(struct folio *folio)
 }
 
 #endif /* CONFIG_PAGE_IDLE_FLAG */
-
-static inline bool page_is_young(struct page *page)
-{
-	return folio_test_young(page_folio(page));
-}
-
-static inline void set_page_young(struct page *page)
-{
-	folio_set_young(page_folio(page));
-}
-
-static inline bool test_and_clear_page_young(struct page *page)
-{
-	return folio_test_clear_young(page_folio(page));
-}
-
-static inline bool page_is_idle(struct page *page)
-{
-	return folio_test_idle(page_folio(page));
-}
-
-static inline void set_page_idle(struct page *page)
-{
-	folio_set_idle(page_folio(page));
-}
 #endif /* _LINUX_MM_PAGE_IDLE_H */
-- 
2.27.0

