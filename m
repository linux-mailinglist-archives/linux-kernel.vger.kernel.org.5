Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370E67DEB0D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348183AbjKBC5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBC5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:57:03 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604CDC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:57:00 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="138483393"
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; 
   d="scan'208";a="138483393"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:56:57 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8FE64E0400
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:55 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id C8524D3F36
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5C2E6E5E27
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:54 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id D80EF1A0071;
        Thu,  2 Nov 2023 10:56:53 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-mm@kvack.org
Cc:     ying.huang@intel.com, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC 2/4] mm/vmstat: Move pgdemote_* to per-node stats
Date:   Thu,  2 Nov 2023 10:56:46 +0800
Message-Id: <20231102025648.1285477-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231102025648.1285477-1-lizhijian@fujitsu.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27972.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27972.004
X-TMASE-Result: 10--0.846700-10.000000
X-TMASE-MatchedRID: 5rkJ48FE5MzOAp9H1IibggihQ5NZCXsS/OuUJVcMZhs6FHRWx2FGsL8F
        Hrw7frluf146W0iUu2vXgVbKoEEGVoYXQ9brtx4rngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIcSq
        bxBgG0w5WoX0SFtPDB2Ve53KQDkILphM7H89s7DKCcrz/r6s9wQi97CyytPpdWBbwXBagd4Bbqn
        8KVqy/D6rems9Kg9kizvTBn3+4zZZbjBuldNvkMkoq97WSHdFjfupJaud1uZCfRs6uIbkFVw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a prepare to improve the demotion profiling in the later
patches.

Per-node demotion stats help users to quickly identify which
node is in hige stree, and take some special operations if needed.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 include/linux/mmzone.h        | 4 ++++
 include/linux/vm_event_item.h | 3 ---
 mm/vmscan.c                   | 3 ++-
 mm/vmstat.c                   | 6 +++---
 4 files changed, 9 insertions(+), 7 deletions(-)

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
index 6f13394b112e..2f1fb4ec3235 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1678,7 +1678,8 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
-	__count_vm_events(PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
+	mod_node_page_state(NODE_DATA(target_nid),
+		    PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
 
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

