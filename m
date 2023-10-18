Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A527CDE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbjJROJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344828AbjJROJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421110D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:09:04 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9Xh81z84zrTMP;
        Wed, 18 Oct 2023 22:06:16 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 22:08:59 +0800
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
Subject: [PATCH v3 01/19] mm_types: add virtual and _last_cpupid into struct folio
Date:   Wed, 18 Oct 2023 22:07:48 +0800
Message-ID: <20231018140806.2783514-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
References: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If WANT_PAGE_VIRTUAL and LAST_CPUPID_NOT_IN_PAGE_FLAGS defined,
the 'virtual' and '_last_cpupid' are in struct page, and since
_last_cpupid is used by numa balancing feature, it is better to
move it before KMSAN metadata from struct page, also add them
into struct folio to make us to access them from folio directly.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm_types.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cc8bb767c003..34466be945a9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -199,6 +199,10 @@ struct page {
 					   not kmapped, ie. highmem) */
 #endif /* WANT_PAGE_VIRTUAL */
 
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+	int _last_cpupid;
+#endif
+
 #ifdef CONFIG_KMSAN
 	/*
 	 * KMSAN metadata for this page:
@@ -210,10 +214,6 @@ struct page {
 	struct page *kmsan_shadow;
 	struct page *kmsan_origin;
 #endif
-
-#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
-	int _last_cpupid;
-#endif
 } _struct_page_alignment;
 
 /*
@@ -272,6 +272,8 @@ typedef struct {
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
+ * @virtual: Virtual address in the kernel direct map.
+ * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
  * @_nr_pages_mapped: Do not use directly, call folio_mapcount().
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
@@ -317,6 +319,12 @@ struct folio {
 			atomic_t _refcount;
 #ifdef CONFIG_MEMCG
 			unsigned long memcg_data;
+#endif
+#if defined(WANT_PAGE_VIRTUAL)
+			void *virtual;
+#endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+			int _last_cpupid;
 #endif
 	/* private: the union with struct page is transitional */
 		};
@@ -373,6 +381,12 @@ FOLIO_MATCH(_refcount, _refcount);
 #ifdef CONFIG_MEMCG
 FOLIO_MATCH(memcg_data, memcg_data);
 #endif
+#if defined(WANT_PAGE_VIRTUAL)
+FOLIO_MATCH(virtual, virtual);
+#endif
+#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+FOLIO_MATCH(_last_cpupid, _last_cpupid);
+#endif
 #undef FOLIO_MATCH
 #define FOLIO_MATCH(pg, fl)						\
 	static_assert(offsetof(struct folio, fl) ==			\
-- 
2.27.0

