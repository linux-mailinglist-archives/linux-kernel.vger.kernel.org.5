Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E17E0446
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377855AbjKCOEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377762AbjKCODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:03:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3251AD59;
        Fri,  3 Nov 2023 07:03:47 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SMMsm0SKlzVkhg;
        Fri,  3 Nov 2023 22:03:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 22:03:44 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 05/18] mm: swap: introduce pfn_swap_entry_to_folio()
Date:   Fri, 3 Nov 2023 22:01:06 +0800
Message-ID: <20231103140119.2306578-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231103140119.2306578-1-wangkefeng.wang@huawei.com>
References: <20231103140119.2306578-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)
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

Introduce a new pfn_swap_entry_to_folio(), it is similar to
pfn_swap_entry_to_page(), but return a folio, which allow us
to completely replace the struct page variables with struct
folio variables.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/swapops.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index bff1e8d97de0..85cb84e4be95 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -468,6 +468,19 @@ static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 	return p;
 }
 
+static inline struct folio *pfn_swap_entry_to_folio(swp_entry_t entry)
+{
+	struct folio *folio = pfn_folio(swp_offset_pfn(entry));
+
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding folio is locked
+	 */
+	BUG_ON(is_migration_entry(entry) && !folio_test_locked(folio));
+
+	return folio;
+}
+
 /*
  * A pfn swap entry is a special type of swap entry that always has a pfn stored
  * in the swap offset. They are used to represent unaddressable device memory
-- 
2.27.0

