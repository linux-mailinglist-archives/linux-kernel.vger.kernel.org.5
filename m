Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACDD7A1BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjIOKH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjIOKH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:07:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731263C19
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:05:29 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rn8pg1m0hzNnfy;
        Fri, 15 Sep 2023 18:01:15 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 18:04:58 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 2/2] memcg: remove unused do_memsw_account in memcg1_stat_format
Date:   Fri, 15 Sep 2023 18:58:45 +0800
Message-ID: <20230915105845.3199656-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915105845.3199656-1-liushixin2@huawei.com>
References: <20230915105845.3199656-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b25806dcd3d5("mm: memcontrol: deprecate swapaccounting=0 mode")
do_memsw_account() is synonymous with !cgroup_subsys_on_dfl(memory_cgrp_subsys),
It always equals true in memcg1_stat_format(). Remove the unused code.

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/memcontrol.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 78ea10c5a636..bb9a617be046 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4112,8 +4112,6 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
 
-		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
-			continue;
 		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
 		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i],
 			   nr * memcg_page_state_unit(memcg1_stats[i]));
@@ -4136,15 +4134,12 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	}
 	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
 		       (u64)memory * PAGE_SIZE);
-	if (do_memsw_account())
-		seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
-			       (u64)memsw * PAGE_SIZE);
+	seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
+		       (u64)memsw * PAGE_SIZE);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
 
-		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
-			continue;
 		nr = memcg_page_state(memcg, memcg1_stats[i]);
 		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
 			   (u64)nr * memcg_page_state_unit(memcg1_stats[i]));
-- 
2.25.1

