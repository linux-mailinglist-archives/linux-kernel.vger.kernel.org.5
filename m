Return-Path: <linux-kernel+bounces-117053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359188A675
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DFE1F6218B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00026FE35;
	Mon, 25 Mar 2024 12:47:52 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655B6FE2A;
	Mon, 25 Mar 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370872; cv=none; b=UbiuykEt0Yttuh4PVwZ8RVMWjO9dVdxf3ERC8+r/qTwbHijMW2bzb3rYKeT5DpuEfjl2EAzOpp1mhGN0RAtd3Wggy486UCdiuAnIaKqT7O0EPN8jK2r79KMp0X0N5OPHt9lIlLVYjoX+9ZHxsOKhF68kv9jaUGs/zl/Gwaz1dPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370872; c=relaxed/simple;
	bh=weEGLfrC0dBCeeuWFqlulNWwF9wRSmztM843FJPtY5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGBHXr87jr+xhDyPvqT88znlNhbHpEWt79rgHEpxYY3hUkZ/imWkhq1K5KtA4cNQCXfwsJG9Asp/7vuoFVnu8jYIcG5350Aa6kFRbA/haDrOkGeJnN4/JKgbnpfQQwJ4/SYJWRFH0MU+HUIRbf6rp4Ywc3Zv1XNJxOwRonYkWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V3CMS54t6ztQcM;
	Mon, 25 Mar 2024 20:45:24 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 799EE14011D;
	Mon, 25 Mar 2024 20:47:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 20:47:46 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.kubiak@intel.com>, <rkannoth@marvell.com>,
	<jiri@resnulli.us>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V4 net 3/3] net: hns3: mark unexcuted loopback test result as UNEXECUTED
Date: Mon, 25 Mar 2024 20:43:11 +0800
Message-ID: <20240325124311.1866197-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240325124311.1866197-1-shaojijie@huawei.com>
References: <20240325124311.1866197-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Jian Shen <shenjian15@huawei.com>

Currently, loopback test may be skipped when resetting, but the test
result will still show as 'PASS', because the driver doesn't set
ETH_TEST_FL_FAILED flag. Fix it by setting the flag and
initializating the value to UNEXECUTED.

Fixes: 4c8dab1c709c ("net: hns3: reconstruct function hns3_self_test")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
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


