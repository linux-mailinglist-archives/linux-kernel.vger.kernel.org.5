Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC78C7E291C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjKFPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjKFPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:50:07 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF7118;
        Mon,  6 Nov 2023 07:50:04 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SPFzz4mWdzMmWr;
        Mon,  6 Nov 2023 23:45:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 23:50:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 07/10] mm: memory: use a folio in do_set_pmd()
Date:   Mon, 6 Nov 2023 23:49:47 +0800
Message-ID: <20231106154950.3399469-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231106154950.3399469-1-wangkefeng.wang@huawei.com>
References: <20231106154950.3399469-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Use a folio in do_set_pmd(), which is a preparetion for
converting mm counter functions to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 669f167f45cd..fbed32a09fec 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4322,12 +4322,13 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t entry;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
+	struct folio *folio;
 
 	if (!transhuge_vma_suitable(vma, haddr))
 		return ret;
 
-	page = compound_head(page);
-	if (compound_order(page) != HPAGE_PMD_ORDER)
+	folio = page_folio(page);
+	if (folio_order(folio) != HPAGE_PMD_ORDER)
 		return ret;
 
 	/*
-- 
2.27.0

