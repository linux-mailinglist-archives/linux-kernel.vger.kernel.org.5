Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80679362C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjIFHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjIFHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:24:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4621CFF;
        Wed,  6 Sep 2023 00:23:58 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RgYfj3zXrzhZFp;
        Wed,  6 Sep 2023 15:19:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 15:23:56 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net 7/7] net: hns3: remove GSO partial feature bit
Date:   Wed, 6 Sep 2023 15:20:18 +0800
Message-ID: <20230906072018.3020671-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230906072018.3020671-1-shaojijie@huawei.com>
References: <20230906072018.3020671-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jie Wang <wangjie125@huawei.com>

HNS3 NIC does not support GSO partial packets segmentation. Actually tunnel
packets for example NvGRE packets segment offload and checksum offload is
already supported. There is no need to keep gso partial feature bit. So
this patch removes it.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 81947c4e5100..b4895c7b3efd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3316,8 +3316,6 @@ static void hns3_set_default_feature(struct net_device *netdev)
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
-	netdev->gso_partial_features |= NETIF_F_GSO_GRE_CSUM;
-
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
 		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 		NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_GSO |
-- 
2.30.0

