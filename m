Return-Path: <linux-kernel+bounces-2126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C783481582D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039C81C24998
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390DD18EC1;
	Sat, 16 Dec 2023 07:05:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDDA18C08;
	Sat, 16 Dec 2023 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SscXS4Fx6zMnqF;
	Sat, 16 Dec 2023 15:04:40 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DBC9140415;
	Sat, 16 Dec 2023 15:04:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 16 Dec 2023 15:04:50 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <lanhao@huawei.com>, <wangpeiyang1@huawei.com>,
	<shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net-next 3/4] net: hns3: support dump pfc frame statistics in tx timeout log
Date: Sat, 16 Dec 2023 15:00:17 +0800
Message-ID: <20231216070018.222798-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231216070018.222798-1-shaojijie@huawei.com>
References: <20231216070018.222798-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Continuous pfc frames may cause tx timeout.
Therefore, pfc frame statistics are added to logs.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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
index cf85ef55a0f4..f70a1159de40 100644
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


