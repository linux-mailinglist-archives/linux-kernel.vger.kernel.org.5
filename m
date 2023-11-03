Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD87DFE45
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 04:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjKCDPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 23:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKCDPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 23:15:11 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C274D19E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 20:15:07 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="117279388"
X-IronPort-AV: E=Sophos;i="6.03,273,1694703600"; 
   d="scan'208";a="117279388"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 12:15:05 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 40F6CD4F5B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:15:03 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7FF6CCF7DA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:15:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 07A50200501BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:15:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 16C431A0071;
        Fri,  3 Nov 2023 11:15:00 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-mm@kvack.org
Cc:     ying.huang@intel.com, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] mm/vmstat: Move pgdemote_* to per-node stats
Date:   Fri,  3 Nov 2023 11:14:50 +0800
Message-Id: <20231103031450.1456523-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27974.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27974.004
X-TMASE-Result: 10--10.827300-10.000000
X-TMASE-MatchedRID: xt1fvVgCaAxeJRw5hj8/hKEtILqFekmXN/BTU5ZfZRLL/AT90ZKK1/+E
        Jgno/UyCSpLsaBDNZu/6/M7RNQTVFxRHYhNSCATTa87CDXaKRVIYQYFQ2+HwYGO0yVK/5LmcJrq
        OKTQyDL6gvsHUO6oCqMz43V5/DvDfKd6blBoO65y5x7uAXGEprcE5XPQnBzGXq8KsbROd9VQRbq
        eAiDR9yQ2RSLvCi3WqSV0yV+LvIB/5TMpCPkA1z54CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gK
        q42LRYknP7hJyr6BRTsPSCeQ5fhxHByY+xbtD7YpBPVKrePf6R+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demotion will migrate pages across nodes. Previously, only the global
demotion statistics were accounted for. Changed them to per-node
statistics, making it easier to observe where demotion occurs on each
node.

This will help to identify which nodes are under pressure.

This patch also make pgdemote_* behind CONFIG_NUMA_BALANCING, since
demotion is not available for !CONFIG_NUMA_BALANCING

With this patch, here is a sample where node0 node1 are DRAM,
node3 is PMEM:
Global stats:
$ grep demote /proc/vmstat
pgdemote_kswapd 254288
pgdemote_direct 113497
pgdemote_khugepaged 0

Per-node stats:
$ grep demote /sys/devices/system/node/node0/vmstat # demotion source
pgdemote_kswapd 68454
pgdemote_direct 83431
pgdemote_khugepaged 0
$ grep demote /sys/devices/system/node/node1/vmstat # demotion source
pgdemote_kswapd 185834
pgdemote_direct 30066
pgdemote_khugepaged 0
$ grep demote /sys/devices/system/node/node3/vmstat # demotion target
pgdemote_kswapd 0
pgdemote_direct 0
pgdemote_khugepaged 0

Reported-by: kernel test robot <lkp@intel.com> # compling errors
Closes: https://lore.kernel.org/oe-kbuild-all/202311030137.Vu2ki6zm-lkp@intel.com/
Acked-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

---
V2: split it as a separate patch from previous patch set.
    account them to the source node instead destination and add Acked-by # Huang, Ying
---
 include/linux/mmzone.h        |  4 ++++
 include/linux/vm_event_item.h |  3 ---
 mm/vmscan.c                   | 12 ++++++++----
 mm/vmstat.c                   |  6 +++---
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..ad0309eea850 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -206,6 +206,10 @@ enum node_stat_item {
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
+	/* PGDEMOTE_*: pages demoted */
+	PGDEMOTE_KSWAPD,
+	PGDEMOTE_DIRECT,
+	PGDEMOTE_KHUGEPAGED,
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 8abfa1240040..d1b847502f09 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -41,9 +41,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGSTEAL_KSWAPD,
 		PGSTEAL_DIRECT,
 		PGSTEAL_KHUGEPAGED,
-		PGDEMOTE_KSWAPD,
-		PGDEMOTE_DIRECT,
-		PGDEMOTE_KHUGEPAGED,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_KHUGEPAGED,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..cc70dcefc60a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1110,12 +1110,14 @@ void drop_slab(void)
 
 static int reclaimer_offset(void)
 {
+#ifdef CONFIG_NUMA_BALANCING
 	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
 			PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD);
-	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
-			PGSCAN_DIRECT - PGSCAN_KSWAPD);
 	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
 			PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD);
+#endif
+	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
+			PGSCAN_DIRECT - PGSCAN_KSWAPD);
 	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
 			PGSCAN_KHUGEPAGED - PGSCAN_KSWAPD);
 
@@ -1677,8 +1679,10 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	migrate_pages(demote_folios, alloc_demote_folio, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
-
-	__count_vm_events(PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
+#ifdef CONFIG_NUMA_BALANCING
+	mod_node_page_state(pgdat, PGDEMOTE_KSWAPD + reclaimer_offset(),
+			    nr_succeeded);
+#endif
 
 	return nr_succeeded;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 00e81e99c6ee..f141c48c39e4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1244,6 +1244,9 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_success",
 	"pgpromote_candidate",
+	"pgdemote_kswapd",
+	"pgdemote_direct",
+	"pgdemote_khugepaged",
 #endif
 
 	/* enum writeback_stat_item counters */
@@ -1275,9 +1278,6 @@ const char * const vmstat_text[] = {
 	"pgsteal_kswapd",
 	"pgsteal_direct",
 	"pgsteal_khugepaged",
-	"pgdemote_kswapd",
-	"pgdemote_direct",
-	"pgdemote_khugepaged",
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_khugepaged",
-- 
2.29.2

