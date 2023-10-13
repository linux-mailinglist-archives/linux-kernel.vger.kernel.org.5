Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BBF7C8130
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjJMI7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjJMI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:58:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BCDCE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:58:30 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S6Kzx4wvpzvQ2w;
        Fri, 13 Oct 2023 16:53:49 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 13 Oct 2023 16:58:25 +0800
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
Subject: [PATCH -next v2 08/19] sched/fair: use folio_xchg_access_time() in numa_hint_fault_latency()
Date:   Fri, 13 Oct 2023 16:55:52 +0800
Message-ID: <20231013085603.1227349-9-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231013085603.1227349-1-wangkefeng.wang@huawei.com>
References: <20231013085603.1227349-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Convert to use folio_xchg_access_time() in numa_hint_fault_latency().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 78ad23fcb7f9..bc07f29a4a42 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1766,7 +1766,7 @@ static int numa_hint_fault_latency(struct folio *folio)
 	int last_time, time;
 
 	time = jiffies_to_msecs(jiffies);
-	last_time = xchg_page_access_time(&folio->page, time);
+	last_time = folio_xchg_access_time(folio, time);
 
 	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
 }
-- 
2.27.0

