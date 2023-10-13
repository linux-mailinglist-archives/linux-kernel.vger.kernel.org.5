Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0C7C8134
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjJMI6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjJMI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:58:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B54B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:58:26 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S6L2D0JD9zrTQV;
        Fri, 13 Oct 2023 16:55:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 13 Oct 2023 16:58:24 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next v2 06/19] mm: remove page_cpupid_last()
Date:   Fri, 13 Oct 2023 16:55:50 +0800
Message-ID: <20231013085603.1227349-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231013085603.1227349-1-wangkefeng.wang@huawei.com>
References: <20231013085603.1227349-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all calls use folio_last_cpupid(), remove page_cpupid_last().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1c393a72037b..1d56a818b212 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1700,18 +1700,18 @@ static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 	return xchg(&page->_last_cpupid, cpupid & LAST_CPUPID_MASK);
 }
 
-static inline int page_cpupid_last(struct page *page)
+static inline int folio_last_cpupid(struct folio *folio)
 {
-	return page->_last_cpupid;
+	return folio->_last_cpupid;
 }
 static inline void page_cpupid_reset_last(struct page *page)
 {
 	page->_last_cpupid = -1 & LAST_CPUPID_MASK;
 }
 #else
-static inline int page_cpupid_last(struct page *page)
+static inline int folio_last_cpupid(struct folio *folio)
 {
-	return (page->flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
+	return (folio->flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
 }
 
 extern int page_cpupid_xchg_last(struct page *page, int cpupid);
@@ -1750,9 +1750,9 @@ static inline int xchg_page_access_time(struct page *page, int time)
 	return 0;
 }
 
-static inline int page_cpupid_last(struct page *page)
+static inline int folio_last_cpupid(struct folio *folio)
 {
-	return page_to_nid(page); /* XXX */
+	return folio_nid(folio); /* XXX */
 }
 
 static inline int cpupid_to_nid(int cpupid)
@@ -1794,11 +1794,6 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-static inline int folio_last_cpupid(struct folio *folio)
-{
-	return page_cpupid_last(&folio->page);
-}
-
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 
 /*
-- 
2.27.0

