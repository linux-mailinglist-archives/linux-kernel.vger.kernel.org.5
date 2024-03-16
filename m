Return-Path: <linux-kernel+bounces-105164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF08487D9E5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506731F21B16
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19D1B94F;
	Sat, 16 Mar 2024 11:16:08 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC499182B5;
	Sat, 16 Mar 2024 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587767; cv=none; b=OPucvEk/uNp0NIbBWKq0AI2HGCp2X0q731x/CDP+sPpGyFmU4WeE68UjDwdOgMU9KBgFaJUdmbUCIw8GF6QtZ0YNWtrz2wti5KsQdKsMy3sTP3J23Xd66suv4/ZXP+2BqK/jbAKwxI6XHBvKQFnNkQB5YeZv0R9XToVFs4Hwy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587767; c=relaxed/simple;
	bh=HQuG/dTUKUH3xhtdG0QeihBZTQ3pbDtmf87DVi7E7MQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idVKxkzm0K0NS1kUzDdwx2UDB0XDSB6DIknzN5c9zZr2nKGUoC7VM1dOsMItd1j9cYTjyXRTkVDwRdvFz0pSiCAt0xlXY3xfc1CIT88spyM/G3GF4EA5q4xHGtULD2BIMSs4+O4dYSHHnwCy9wcmRDc6Dp/0lu7415EjXIkh6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TxdlW5MqFz2BgMP;
	Sat, 16 Mar 2024 19:13:27 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id A4BDA140384;
	Sat, 16 Mar 2024 19:15:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 16 Mar 2024 19:15:56 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <michal.kubiak@intel.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 3/3] net: hns3: mark unexcuted loopback test result as UNEXECUTED
Date: Sat, 16 Mar 2024 19:10:57 +0800
Message-ID: <20240316111057.277591-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240316111057.277591-1-shaojijie@huawei.com>
References: <20240316111057.277591-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Jian Shen <shenjian15@huawei.com>

Currently, loopback test may be skipped when resetting, but the test
result will still show as 'PASS', because the driver doesn't set
ETH_TEST_FL_FAILED flag. Fix it by setting the flag and
initializating the value to UNEXECUTED.

Fixes: 4c8dab1c709c ("net: hns3: reconstruct function hns3_self_test")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 999a0ee162a6..941cb529d671 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -78,6 +78,9 @@ static const struct hns3_stats hns3_rxq_stats[] = {
 #define HNS3_NIC_LB_TEST_NO_MEM_ERR	1
 #define HNS3_NIC_LB_TEST_TX_CNT_ERR	2
 #define HNS3_NIC_LB_TEST_RX_CNT_ERR	3
+#define HNS3_NIC_LB_TEST_UNEXECUTED	4
+
+static int hns3_get_sset_count(struct net_device *netdev, int stringset);
 
 static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 {
@@ -418,18 +421,26 @@ static void hns3_do_external_lb(struct net_device *ndev,
 static void hns3_self_test(struct net_device *ndev,
 			   struct ethtool_test *eth_test, u64 *data)
 {
+	int cnt = hns3_get_sset_count(ndev, ETH_SS_TEST);
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = priv->ae_handle;
 	int st_param[HNAE3_LOOP_NONE][2];
 	bool if_running = netif_running(ndev);
+	int i;
+
+	/* initialize the loopback test result, avoid marking an unexcuted
+	 * loopback test as PASS.
+	 */
+	for (i = 0; i < cnt; i++)
+		data[i] = HNS3_NIC_LB_TEST_UNEXECUTED;
 
 	if (hns3_nic_resetting(ndev)) {
 		netdev_err(ndev, "dev resetting!");
-		return;
+		goto failure;
 	}
 
 	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE))
-		return;
+		goto failure;
 
 	if (netif_msg_ifdown(h))
 		netdev_info(ndev, "self test start\n");
@@ -451,6 +462,10 @@ static void hns3_self_test(struct net_device *ndev,
 
 	if (netif_msg_ifdown(h))
 		netdev_info(ndev, "self test end\n");
+	return;
+
+failure:
+	eth_test->flags |= ETH_TEST_FL_FAILED;
 }
 
 static void hns3_update_limit_promisc_mode(struct net_device *netdev,
-- 
2.30.0


