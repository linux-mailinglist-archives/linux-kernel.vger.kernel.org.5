Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9CD7DEB0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbjKBC5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347165AbjKBC5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:57:03 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5AB10C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:57:00 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="117737907"
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; 
   d="scan'208";a="117737907"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:56:58 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 50649C2138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:56 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 83FDED5D36
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 199C1200649E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:55 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 966A41A0071;
        Thu,  2 Nov 2023 10:56:54 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-mm@kvack.org
Cc:     ying.huang@intel.com, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC 4/4] drivers/base/node: add demote_src and demote_dst to numastat
Date:   Thu,  2 Nov 2023 10:56:48 +0800
Message-Id: <20231102025648.1285477-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231102025648.1285477-1-lizhijian@fujitsu.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27972.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27972.004
X-TMASE-Result: 10--2.607700-10.000000
X-TMASE-MatchedRID: RtHHqK+8YWMx3g1BjbXsyArcxrzwsv5u5bMmdOYs/G/rix/QSCPuKr8F
        Hrw7frluf146W0iUu2tDc4lSgrowpdTgNUieJDkRSs47mbT7SARSuvtBzlaEqE+la3/T6ykP3YW
        HdXsKykrMyBGHVXFUDoAy6p60ZV62fJ5/bZ6npdjGVuWouVipcljVOVbGM+bZD1Vdt6kw28OKCz
        o1BkkvYAIiqmLQ6JLHOV0z0B/FQt8PnX3Fui/kjKo9VQLNxdGdSpvPBwsoXEYd/XNGPTZXaRFlt
        GxCTkwFQHVA+r1vGdZmQDEDCMiuswfP8fSSIvISoYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

node0 and node1 is DRAM node, node3 is a PMEM node.

$ cat /sys/devices/system/node/node1/numastat
numa_hit 646590
numa_miss 3963
numa_foreign 30651
interleave_hit 416
local_node 645252
other_node 5301
demote_src 200478
demote_dst 0

Of cousre, the userspace numastat will be extened to support these 2
new fields in the future like:
$ numastat
                           node0           node1           node3
numa_hit                  741793          702460          364154
numa_miss                   1759            8104           28893
numa_foreign                8105           30651               0
interleave_hit               653             416               0
local_node                741762          701115               0
other_node                  1790            9449          393047
demote_src                163612          203828               0
demote_dst                     0               0          367440

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/base/node.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 27e8502548a7..d3fc70599b6a 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -496,20 +496,32 @@ static DEVICE_ATTR(meminfo, 0444, node_read_meminfo, NULL);
 static ssize_t node_read_numastat(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
+	struct pglist_data *pgdat = NODE_DATA(dev->id);
+	unsigned long demote_src, demote_dst;
+
 	fold_vm_numa_events();
+	demote_src = node_page_state_pages(pgdat, PGDEMOTE_SRC_KSWAPD) +
+		     node_page_state_pages(pgdat, PGDEMOTE_SRC_DIRECT) +
+		     node_page_state_pages(pgdat, PGDEMOTE_SRC_KHUGEPAGED);
+	demote_dst = node_page_state_pages(pgdat, PGDEMOTE_DST_KSWAPD) +
+		     node_page_state_pages(pgdat, PGDEMOTE_DST_DIRECT) +
+		     node_page_state_pages(pgdat, PGDEMOTE_DST_KHUGEPAGED);
 	return sysfs_emit(buf,
 			  "numa_hit %lu\n"
 			  "numa_miss %lu\n"
 			  "numa_foreign %lu\n"
 			  "interleave_hit %lu\n"
 			  "local_node %lu\n"
-			  "other_node %lu\n",
+			  "other_node %lu\n"
+			  "demote_src %lu\n"
+			  "demote_dst %lu\n",
 			  sum_zone_numa_event_state(dev->id, NUMA_HIT),
 			  sum_zone_numa_event_state(dev->id, NUMA_MISS),
 			  sum_zone_numa_event_state(dev->id, NUMA_FOREIGN),
 			  sum_zone_numa_event_state(dev->id, NUMA_INTERLEAVE_HIT),
 			  sum_zone_numa_event_state(dev->id, NUMA_LOCAL),
-			  sum_zone_numa_event_state(dev->id, NUMA_OTHER));
+			  sum_zone_numa_event_state(dev->id, NUMA_OTHER),
+			  demote_src, demote_dst);
 }
 static DEVICE_ATTR(numastat, 0444, node_read_numastat, NULL);
 
-- 
2.29.2

