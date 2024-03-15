Return-Path: <linux-kernel+bounces-104244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBCE87CB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D77B22B79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4E1862E;
	Fri, 15 Mar 2024 10:12:22 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F571802B;
	Fri, 15 Mar 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497541; cv=none; b=YsSFbLwTKBr1OEr62/SZvS32Tx9b/YSxXopeLZWYQHIZcK3ElWk7qFxleZGd+huXFDiCdx8UV/2KnPQruztfCnlSfFBwLacp02RRDDsx4l+sLSHAmysIRb8dNuFxrMo13S2Skz7l8M9Wn3jBD+4JYAj3JYmFG6NQwEzDQOUnVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497541; c=relaxed/simple;
	bh=Zs3BVy+twntMcaI6AglsmtqGXgNtbwnO03F1CgRE0Y4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNsiBoeGMrzzP6nyiTnxEOdmz/gzF84/ztpJsHNjFtX6JWVbs4CUB5r9s7S1SesR+I3QR5SHneBya7t+WWjUAyXuam7DejlcCB9mKTF4/k/q11OTKtzQvj5zYzwjA2qjyLEYCtfbMYbbTVkUUab9//038XyNSdme60wykKpfuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tx0R270Dxz1FM38;
	Fri, 15 Mar 2024 18:11:58 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id C47FF140124;
	Fri, 15 Mar 2024 18:12:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 18:12:16 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 3/3] net: hns3: mark unexcuted loopback test result as UNEXECUTED
Date: Fri, 15 Mar 2024 18:07:48 +0800
Message-ID: <20240315100748.2913882-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240315100748.2913882-1-shaojijie@huawei.com>
References: <20240315100748.2913882-1-shaojijie@huawei.com>
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

Currently, loopback test maybe skipped when resetting, but the test
result will still show as 'PASS', because the driver doesn't set
ETH_TEST_FL_FAILED flag. Fixes it by set the flag and initialize the
value to be UNEXECUTED.

Fixes: 4c8dab1c709c ("net: hns3: reconstruct function hns3_self_test")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_ethtool.c   | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 999a0ee162a6..6804ac5725d4 100644
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
@@ -418,18 +421,29 @@ static void hns3_do_external_lb(struct net_device *ndev,
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
+	/* initialize the loopback test result, avoiding mark unexcuted loopback
+	 * test as PASS.
+	 */
+	for (i = 0; i < cnt; i++)
+		data[i] = HNS3_NIC_LB_TEST_UNEXECUTED;
 
 	if (hns3_nic_resetting(ndev)) {
 		netdev_err(ndev, "dev resetting!");
+		eth_test->flags |= ETH_TEST_FL_FAILED;
 		return;
 	}
 
-	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE))
+	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE)) {
+		eth_test->flags |= ETH_TEST_FL_FAILED;
 		return;
+	}
 
 	if (netif_msg_ifdown(h))
 		netdev_info(ndev, "self test start\n");
-- 
2.30.0


