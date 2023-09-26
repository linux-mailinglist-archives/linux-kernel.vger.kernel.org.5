Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0759B7AE31C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjIZAx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjIZAxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:53:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00C9109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:53:10 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rvh3Z2N7HzVlCM;
        Tue, 26 Sep 2023 08:50:02 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 08:53:08 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 1/9] mm_types: add _last_cpupid into folio
Date:   Tue, 26 Sep 2023 08:52:46 +0800
Message-ID: <20230926005254.2861577-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
References: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
index 5a995089cbf5..2fdfddd8264a 100644
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
@@ -328,6 +327,9 @@ struct folio {
 			atomic_t _refcount;
 #ifdef CONFIG_MEMCG
 			unsigned long memcg_data;
+#endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+			int _last_cpupid;
 #endif
 	/* private: the union with struct page is transitional */
 		};
@@ -384,6 +386,9 @@ FOLIO_MATCH(_refcount, _refcount);
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

