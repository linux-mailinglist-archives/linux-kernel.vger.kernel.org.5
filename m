Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1206D79842D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbjIHIhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbjIHIhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:37:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7CF1BEE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:37:08 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RhqDh2qY6z1M9Cr;
        Fri,  8 Sep 2023 16:35:16 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 8 Sep
 2023 16:37:05 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Sachin Sant <sachinp@linux.ibm.com>,
        Michael Ellerman <michaele@au1.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] mm: vmscan: fix NULL pointer dereference in can_reclaim_anon_pages
Date:   Fri, 8 Sep 2023 17:31:03 +0800
Message-ID: <20230908093103.2620512-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable sc is NULL pointer in can_reclaim_anon_pages() when called
from zone_reclaimable_pages(). Check it before setting swapcache_only.

Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Link: https://lore.kernel.org/linux-mm/F00144DE-2A3F-4463-8203-45E0D57E313E@linux.ibm.com/T/
Fixes: 92039ae85e8d("mm: vmscan: try to reclaim swapcache pages if no swap space")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f1dc0dbf1cdb..5eb85ddf403f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -617,7 +617,7 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 		if (get_nr_swap_pages() > 0)
 			return true;
 		/* Is there any swapcache pages to reclaim? */
-		if (total_swapcache_pages() > 0) {
+		if (sc && total_swapcache_pages() > 0) {
 			sc->swapcache_only = 1;
 			return true;
 		}
@@ -626,7 +626,7 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
 			return true;
 		/* Is there any swapcache pages in memcg to reclaim? */
-		if (mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
+		if (sc && mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
 			sc->swapcache_only = 1;
 			return true;
 		}
-- 
2.25.1

