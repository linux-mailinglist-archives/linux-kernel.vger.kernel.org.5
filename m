Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9E7A1BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjIOKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjIOKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:07:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55707269D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:05:00 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rn8p91XdYztSSb;
        Fri, 15 Sep 2023 18:00:49 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 18:04:57 +0800
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
Subject: [PATCH v2 1/2] memcg: expose swapcache stat for memcg v1
Date:   Fri, 15 Sep 2023 18:58:44 +0800
Message-ID: <20230915105845.3199656-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915105845.3199656-1-liushixin2@huawei.com>
References: <20230915105845.3199656-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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

Since commit b6038942480e ("mm: memcg: add swapcache stat for memcg v2")
adds swapcache stat for the cgroup v2, it seems there is no reason to
hide it in memcg v1. Conversely, with swapcached it is more accurate to
evaluate the available memory for memcg.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 1 +
 mm/memcontrol.c                                | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index fabaad3fd9c2..fb4abe0dc228 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -546,6 +546,7 @@ memory.stat file includes following statistics:
                     event happens each time a page is unaccounted from the
                     cgroup.
     swap            # of bytes of swap usage
+    swapcached      # of bytes of swap cached in memory
     dirty           # of bytes that are waiting to get written back to the disk.
     writeback       # of bytes of file/anon cache that are queued for syncing to
                     disk.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c465829db92b..78ea10c5a636 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4067,7 +4067,10 @@ static const unsigned int memcg1_stats[] = {
 	NR_WRITEBACK,
 	WORKINGSET_REFAULT_ANON,
 	WORKINGSET_REFAULT_FILE,
+#ifdef CONFIG_SWAP
 	MEMCG_SWAP,
+	NR_SWAPCACHE,
+#endif
 };
 
 static const char *const memcg1_stat_names[] = {
@@ -4082,7 +4085,10 @@ static const char *const memcg1_stat_names[] = {
 	"writeback",
 	"workingset_refault_anon",
 	"workingset_refault_file",
+#ifdef CONFIG_SWAP
 	"swap",
+	"swapcached",
+#endif
 };
 
 /* Universal VM events cgroup1 shows, original sort order */
-- 
2.25.1

