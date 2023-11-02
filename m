Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67237DEB0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348199AbjKBC5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347138AbjKBC5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:57:03 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA76B101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:57:00 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="138343933"
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; 
   d="scan'208";a="138343933"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:56:58 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4C75CE0400
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:55 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 75202D3F3A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0CC96E5E27
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:54 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 7F4361A0072;
        Thu,  2 Nov 2023 10:56:53 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-mm@kvack.org
Cc:     ying.huang@intel.com, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys infterface
Date:   Thu,  2 Nov 2023 10:56:45 +0800
Message-Id: <20231102025648.1285477-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231102025648.1285477-1-lizhijian@fujitsu.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27972.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27972.004
X-TMASE-Result: 10--14.336100-10.000000
X-TMASE-MatchedRID: SzbEz7SZt2vZZREXUuleLioiRKlBVkYIfb+ZO7kHlEgpzVB/joYk/NBK
        hYxPftuoV6Ny+iZr9hdg3t1DWHRjJ3jXR2Tx0VSFpSXVpBS+ilYCtGYG0znilDoUdFbHYUawvwU
        evDt+uW5/XjpbSJS7awAWmAcUEPw5C8OYzF1BQS4ZgmFGHqyx6xgff28UuvITx8BJ7uScK21J2n
        edCULoK/ivPJqimipv4QeSIpZv9OkfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPAARPH/Z7Dn2zo9f
        1+qs3ML8eQMN6SWv/KHJHsBzrGMm1Se7XPfCxbq
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It shows the demotion target nodes of a node. Export this information to
user directly.

Below is an example where node0 node1 are DRAM, node3 is a PMEM node.
- Before PMEM is online, no demotion_nodes for node0 and node1.
$ cat /sys/devices/system/node/node0/demotion_nodes
 <show nothing>
- After node3 is online as kmem
$ daxctl reconfigure-device --mode=system-ram --no-online dax0.0 && daxctl online-memory dax0.0
[
  {
    "chardev":"dax0.0",
    "size":1054867456,
    "target_node":3,
    "align":2097152,
    "mode":"system-ram",
    "online_memblocks":0,
    "total_memblocks":7
  }
]
$ cat /sys/devices/system/node/node0/demotion_nodes
3
$ cat /sys/devices/system/node/node1/demotion_nodes
3
$ cat /sys/devices/system/node/node3/demotion_nodes
 <show nothing>

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/base/node.c          | 13 +++++++++++++
 include/linux/memory-tiers.h |  6 ++++++
 mm/memory-tiers.c            |  8 ++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..27e8502548a7 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
+#include <linux/memory-tiers.h>
 #include <linux/vmstat.h>
 #include <linux/notifier.h>
 #include <linux/node.h>
@@ -569,11 +570,23 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+static ssize_t demotion_nodes_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	int ret;
+	nodemask_t nmask = next_demotion_nodes(dev->id);
+
+	ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
+	return ret;
+}
+static DEVICE_ATTR_RO(demotion_nodes);
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_demotion_nodes.attr,
 	NULL
 };
 
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 437441cdf78f..8eb04923f965 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -38,6 +38,7 @@ void init_node_memory_type(int node, struct memory_dev_type *default_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
+nodemask_t next_demotion_nodes(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 bool node_is_toptier(int node);
 #else
@@ -46,6 +47,11 @@ static inline int next_demotion_node(int node)
 	return NUMA_NO_NODE;
 }
 
+static inline next_demotion_nodes next_demotion_nodes(int node)
+{
+	return NODE_MASK_NONE;
+}
+
 static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 {
 	*targets = NODE_MASK_NONE;
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 37a4f59d9585..90047f37d98a 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -282,6 +282,14 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 	rcu_read_unlock();
 }
 
+nodemask_t next_demotion_nodes(int node)
+{
+	if (!node_demotion)
+		return NODE_MASK_NONE;
+
+	return node_demotion[node].preferred;
+}
+
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
-- 
2.29.2

