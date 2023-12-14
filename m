Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B078132BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573426AbjLNOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjLNOQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:16:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE9115;
        Thu, 14 Dec 2023 06:16:09 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SrZC73RXgzZdKL;
        Thu, 14 Dec 2023 22:16:03 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
        by mail.maildlp.com (Postfix) with ESMTPS id 09EB8140486;
        Thu, 14 Dec 2023 22:16:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 22:16:07 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <lanhao@huawei.com>,
        <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net-next 3/3] net: hns3: support dump pfc frame statistics in tx timeout log
Date:   Thu, 14 Dec 2023 22:11:35 +0800
Message-ID: <20231214141135.613485-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231214141135.613485-1-shaojijie@huawei.com>
References: <20231214141135.613485-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continuous pfc frames may cause tx timeout.
Therefore, pfc frame statistics are added to logs.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 6 ++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index ff475b0eac22..bf1e386617bc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -209,6 +209,8 @@ struct hnae3_queue {
 struct hns3_mac_stats {
 	u64 tx_pause_cnt;
 	u64 rx_pause_cnt;
+	u64 tx_pfc_cnt;
+	u64 rx_pfc_cnt;
 };
 
 /* hnae3 loop mode */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b618797a7e8d..8e237f0f4fc9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2871,8 +2871,10 @@ static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
 		struct hns3_mac_stats mac_stats;
 
 		h->ae_algo->ops->get_mac_stats(h, &mac_stats);
-		netdev_info(ndev, "tx_pause_cnt: %llu, rx_pause_cnt: %llu\n",
-			    mac_stats.tx_pause_cnt, mac_stats.rx_pause_cnt);
+		netdev_info(ndev,
+			    "tx_pause_cnt: %llu, rx_pause_cnt: %llu, tx_pfc_cnt: %llu, rx_pfc_cnt: %llu\n",
+			    mac_stats.tx_pause_cnt, mac_stats.rx_pause_cnt,
+			    mac_stats.tx_pfc_cnt, mac_stats.rx_pfc_cnt);
 	}
 
 	hns3_dump_queue_reg(ndev, tx_ring);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 8c2562ae3c69..999a8ca205a2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -775,6 +775,8 @@ static void hclge_get_mac_stat(struct hnae3_handle *handle,
 
 	mac_stats->tx_pause_cnt = hdev->mac_stats.mac_tx_mac_pause_num;
 	mac_stats->rx_pause_cnt = hdev->mac_stats.mac_rx_mac_pause_num;
+	mac_stats->tx_pfc_cnt = hdev->mac_stats.mac_tx_pfc_pause_pkt_num;
+	mac_stats->rx_pfc_cnt = hdev->mac_stats.mac_rx_pfc_pause_pkt_num;
 }
 
 static int hclge_parse_func_status(struct hclge_dev *hdev,
-- 
2.30.0

