Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B83A7E9A86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjKMKpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKMKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:45:50 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E210CE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:45:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VwJPEby_1699872343;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VwJPEby_1699872343)
          by smtp.aliyun-inc.com;
          Mon, 13 Nov 2023 18:45:44 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, ying.huang@intel.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: support large folio numa balancing
Date:   Mon, 13 Nov 2023 18:45:31 +0800
Message-Id: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the file pages already support large folio, and supporting for
anonymous pages is also under discussion[1]. Moreover, the numa balancing
code are converted to use a folio by previous thread[2], and the migrate_pages
function also already supports the large folio migration.

So now I did not see any reason to continue restricting NUMA balancing for
large folio.

[1] https://lkml.org/lkml/2023/9/29/342
[2] https://lore.kernel.org/all/20230921074417.24004-4-wangkefeng.wang@huawei.com/T/#md9d10fe34587229a72801f0d731f7457ab3f4a6e
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c32954e16b28..8ca21eff294c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4804,7 +4804,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	int last_cpupid;
 	int target_nid;
 	pte_t pte, old_pte;
-	int flags = 0;
+	int flags = 0, nr_pages = 0;
 
 	/*
 	 * The "pte" at this point cannot be used safely without
@@ -4834,10 +4834,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
-	/* TODO: handle PTE-mapped THP */
-	if (folio_test_large(folio))
-		goto out_map;
-
 	/*
 	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
 	 * much anyway since they can be in shared cache state. This misses
@@ -4857,6 +4853,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_SHARED;
 
 	nid = folio_nid(folio);
+	nr_pages = folio_nr_pages(folio);
 	/*
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
@@ -4893,7 +4890,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 out:
 	if (nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, 1, flags);
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
 	return 0;
 out_map:
 	/*
-- 
2.39.3

