Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0A773622
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHHB67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjHHB66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:58:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9A10FF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:58:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKbtJ6BypzrRh6;
        Tue,  8 Aug 2023 09:57:44 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 09:58:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: remove unneeded __meminit annotation
Date:   Tue, 8 Aug 2023 09:58:31 +0800
Message-ID: <20230808015831.608454-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kswapd_stop() and kcompactd_stop() are only called when MEMORY_HOTREMOVE
is enabled. So wrap them under CONFIG_MEMORY_HOTREMOVE and further remove
__meminit annotation. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/compaction.h | 2 +-
 include/linux/swap.h       | 2 +-
 mm/compaction.c            | 4 +++-
 mm/vmscan.c                | 4 +++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index e94776496049..3dbb7eea96eb 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -99,7 +99,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 					int alloc_flags);
 
 extern void __meminit kcompactd_run(int nid);
-extern void __meminit kcompactd_stop(int nid);
+extern void kcompactd_stop(int nid);
 extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
 
 #else
diff --git a/include/linux/swap.h b/include/linux/swap.h
index bb5adc604144..c102587b3a86 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -437,7 +437,7 @@ static inline bool node_reclaim_enabled(void)
 void check_move_unevictable_folios(struct folio_batch *fbatch);
 
 extern void __meminit kswapd_run(int nid);
-extern void __meminit kswapd_stop(int nid);
+extern void kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
diff --git a/mm/compaction.c b/mm/compaction.c
index ea61922a1619..c59244d2ed5a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3132,11 +3132,12 @@ void __meminit kcompactd_run(int nid)
 	}
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
 /*
  * Called by memory hotplug when all memory in a node is offlined. Caller must
  * be holding mem_hotplug_begin/done().
  */
-void __meminit kcompactd_stop(int nid)
+void kcompactd_stop(int nid)
 {
 	struct task_struct *kcompactd = NODE_DATA(nid)->kcompactd;
 
@@ -3145,6 +3146,7 @@ void __meminit kcompactd_stop(int nid)
 		NODE_DATA(nid)->kcompactd = NULL;
 	}
 }
+#endif
 
 /*
  * It's optimal to keep kcompactd on the same CPUs as their memory, but
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 80e9a222e522..eb4db273bf7e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7897,11 +7897,12 @@ void __meminit kswapd_run(int nid)
 	pgdat_kswapd_unlock(pgdat);
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
 /*
  * Called by memory hotplug when all memory in a node is offlined.  Caller must
  * be holding mem_hotplug_begin/done().
  */
-void __meminit kswapd_stop(int nid)
+void kswapd_stop(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 	struct task_struct *kswapd;
@@ -7914,6 +7915,7 @@ void __meminit kswapd_stop(int nid)
 	}
 	pgdat_kswapd_unlock(pgdat);
 }
+#endif
 
 static int __init kswapd_init(void)
 {
-- 
2.33.0

