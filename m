Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6CD7BF348
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442316AbjJJGrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442242AbjJJGrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:47:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91819D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:47:07 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4RDZ0Y2gzNnmZ;
        Tue, 10 Oct 2023 14:43:10 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 14:47:05 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 1/7] mm_types: add _last_cpupid into folio
Date:   Tue, 10 Oct 2023 14:45:38 +0800
Message-ID: <20231010064544.4162286-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

At present, only arc/sparc/m68k define WANT_PAGE_VIRTUAL, both of
them don't support numa balancing, and the page struct is aligned
to _struct_page_alignment, it is safe to move _last_cpupid before
'virtual' in page, meanwhile, add it into folio, which make us to
use folio->_last_cpupid directly.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm_types.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..32af41160109 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -183,6 +183,9 @@ struct page {
 #ifdef CONFIG_MEMCG
 	unsigned long memcg_data;
 #endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+	int _last_cpupid;
+#endif
 
 	/*
 	 * On machines where all RAM is mapped into kernel address space,
@@ -210,10 +213,6 @@ struct page {
 	struct page *kmsan_shadow;
 	struct page *kmsan_origin;
 #endif
-
-#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
-	int _last_cpupid;
-#endif
 } _struct_page_alignment;
 
 /*
@@ -317,6 +316,9 @@ struct folio {
 			atomic_t _refcount;
 #ifdef CONFIG_MEMCG
 			unsigned long memcg_data;
+#endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+			int _last_cpupid;
 #endif
 	/* private: the union with struct page is transitional */
 		};
@@ -373,6 +375,9 @@ FOLIO_MATCH(_refcount, _refcount);
 #ifdef CONFIG_MEMCG
 FOLIO_MATCH(memcg_data, memcg_data);
 #endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+FOLIO_MATCH(_last_cpupid, _last_cpupid);
+#endif
 #undef FOLIO_MATCH
 #define FOLIO_MATCH(pg, fl)						\
 	static_assert(offsetof(struct folio, fl) ==			\
-- 
2.27.0

