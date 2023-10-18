Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D477CDE70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbjJROJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbjJROJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA4109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:09:11 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S9XhJ6mgGz15NX0;
        Wed, 18 Oct 2023 22:06:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 22:09:07 +0800
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
Subject: [PATCH v3 14/19] mm: migrate: use folio_xchg_last_cpupid() in folio_migrate_flags()
Date:   Wed, 18 Oct 2023 22:08:01 +0800
Message-ID: <20231018140806.2783514-15-wangkefeng.wang@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use folio_xchg_last_cpupid() in folio_migrate_flags(), also
directly use folio_nid() instead of page_to_nid(&folio->page).

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5348827bd958..821c42d61ed0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -588,20 +588,20 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	 * Copy NUMA information to the new page, to prevent over-eager
 	 * future migrations of this same page.
 	 */
-	cpupid = page_cpupid_xchg_last(&folio->page, -1);
+	cpupid = folio_xchg_last_cpupid(folio, -1);
 	/*
 	 * For memory tiering mode, when migrate between slow and fast
 	 * memory node, reset cpupid, because that is used to record
 	 * page access time in slow memory node.
 	 */
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) {
-		bool f_toptier = node_is_toptier(page_to_nid(&folio->page));
-		bool t_toptier = node_is_toptier(page_to_nid(&newfolio->page));
+		bool f_toptier = node_is_toptier(folio_nid(folio));
+		bool t_toptier = node_is_toptier(folio_nid(newfolio));
 
 		if (f_toptier != t_toptier)
 			cpupid = -1;
 	}
-	page_cpupid_xchg_last(&newfolio->page, cpupid);
+	folio_xchg_last_cpupid(newfolio, cpupid);
 
 	folio_migrate_ksm(newfolio, folio);
 	/*
-- 
2.27.0

