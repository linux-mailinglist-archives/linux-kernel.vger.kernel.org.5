Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D67980BEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjLKCMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjLKCMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:12:33 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B1F1;
        Sun, 10 Dec 2023 18:12:39 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SpQHh4tbGz14M0Z;
        Mon, 11 Dec 2023 10:12:32 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
        by mail.maildlp.com (Postfix) with ESMTPS id 9D0DB140136;
        Mon, 11 Dec 2023 10:12:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:12:37 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/6] net: hns3: add support for page_pool_get_stats
Date:   Mon, 11 Dec 2023 10:08:11 +0800
Message-ID: <20231211020816.69434-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231211020816.69434-1-shaojijie@huawei.com>
References: <20231211020816.69434-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

Add support for page_pool_get_stats, then the hns3 driver
can get page pool statistics by ethtool.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  5 +++
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  1 +
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 38 ++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b618797a7e8d..94b27332cc3f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4959,6 +4959,11 @@ static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
 	}
 }
 
+bool hns3_is_page_pool_enabled(void)
+{
+	return page_pool_enabled;
+}
+
 static int hns3_alloc_ring_memory(struct hns3_enet_ring *ring)
 {
 	int ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index acd756b0c7c9..75fd3638d724 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -754,4 +754,5 @@ void hns3_cq_period_mode_init(struct hns3_nic_priv *priv,
 
 void hns3_external_lb_prepare(struct net_device *ndev, bool if_running);
 void hns3_external_lb_restore(struct net_device *ndev, bool if_running);
+bool hns3_is_page_pool_enabled(void);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 682239f33082..38e796f61475 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -5,6 +5,7 @@
 #include <linux/string.h>
 #include <linux/phy.h>
 #include <linux/sfp.h>
+#include <net/page_pool/helpers.h>
 
 #include "hns3_enet.h"
 #include "hns3_ethtool.h"
@@ -474,14 +475,19 @@ static int hns3_get_sset_count(struct net_device *netdev, int stringset)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops = h->ae_algo->ops;
+	int pp_stats_count = 0;
 
 	if (!ops->get_sset_count)
 		return -EOPNOTSUPP;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
+#ifdef CONFIG_PAGE_POOL_STATS
+		if (hns3_is_page_pool_enabled())
+			pp_stats_count = page_pool_ethtool_stats_get_count();
+#endif
 		return ((HNS3_TQP_STATS_COUNT * h->kinfo.num_tqps) +
-			ops->get_sset_count(h, stringset));
+			ops->get_sset_count(h, stringset) + pp_stats_count);
 
 	case ETH_SS_TEST:
 		return ops->get_sset_count(h, stringset);
@@ -549,6 +555,10 @@ static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
+#ifdef CONFIG_PAGE_POOL_STATS
+		if (hns3_is_page_pool_enabled())
+			buff = page_pool_ethtool_stats_get_strings(buff);
+#endif
 		buff = hns3_get_strings_tqps(h, buff);
 		ops->get_strings(h, stringset, (u8 *)buff);
 		break;
@@ -596,6 +606,28 @@ static u64 *hns3_get_stats_tqps(struct hnae3_handle *handle, u64 *data)
 	return data;
 }
 
+#ifdef CONFIG_PAGE_POOL_STATS
+static u64 *hns3_ethtool_pp_stats(struct hnae3_handle *handle, u64 *data)
+{
+	struct hns3_nic_priv *priv = handle->priv;
+	int ring_num = handle->kinfo.num_tqps;
+	struct page_pool_stats stats = {0};
+	struct page_pool *page_pool;
+	int i;
+
+	if (!hns3_is_page_pool_enabled())
+		return data;
+
+	for (i = 0; i < ring_num; i++) {
+		page_pool = priv->ring[i + ring_num].page_pool;
+		if (page_pool)
+			page_pool_get_stats(page_pool, &stats);
+	}
+
+	return page_pool_ethtool_stats_get(data, &stats);
+}
+#endif
+
 /* hns3_get_stats - get detail statistics.
  * @netdev: net device
  * @stats: statistics info.
@@ -617,6 +649,10 @@ static void hns3_get_stats(struct net_device *netdev,
 		return;
 	}
 
+#ifdef CONFIG_PAGE_POOL_STATS
+	p = hns3_ethtool_pp_stats(h, p);
+#endif
+
 	h->ae_algo->ops->update_stats(h);
 
 	/* get per-queue stats */
-- 
2.30.0

