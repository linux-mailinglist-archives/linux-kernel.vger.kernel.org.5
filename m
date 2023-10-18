Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99917CDE60
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbjJROJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjJROJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E14C106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:09:04 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9Xh93L0qzrTNS;
        Wed, 18 Oct 2023 22:06:17 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 22:09:00 +0800
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
Subject: [PATCH v3 03/19] mm: memory: use folio_last_cpupid() in do_numa_page()
Date:   Wed, 18 Oct 2023 22:07:50 +0800
Message-ID: <20231018140806.2783514-4-wangkefeng.wang@huawei.com>
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

Convert to use folio_last_cpupid() in do_numa_page().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c4b4aa4c1180..a1cf25a3ff16 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4861,7 +4861,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	    !node_is_toptier(nid))
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
-		last_cpupid = page_cpupid_last(&folio->page);
+		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vma, vmf->address, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		folio_put(folio);
-- 
2.27.0

