Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DF57E9FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjKMPWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjKMPWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:22:34 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1EED69
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:22:31 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4STY4J2R6pz1P88S;
        Mon, 13 Nov 2023 23:19:12 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 23:22:29 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/6] mm: memory: use a folio in validate_page_before_insert()
Date:   Mon, 13 Nov 2023 23:22:18 +0800
Message-ID: <20231113152222.3495908-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231113152222.3495908-1-wangkefeng.wang@huawei.com>
References: <20231113152222.3495908-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Use a folio in validate_page_before_insert() to save two
compound_head() calls.

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c32954e16b28..379354b35891 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1841,9 +1841,12 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 
 static int validate_page_before_insert(struct page *page)
 {
-	if (PageAnon(page) || PageSlab(page) || page_has_type(page))
+	struct folio *folio = page_folio(page);
+
+	if (folio_test_anon(folio) || folio_test_slab(folio) ||
+	    page_has_type(page))
 		return -EINVAL;
-	flush_dcache_page(page);
+	flush_dcache_folio(folio);
 	return 0;
 }
 
-- 
2.27.0

