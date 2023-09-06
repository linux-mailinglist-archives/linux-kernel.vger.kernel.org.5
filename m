Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740B2793625
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjIFHYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjIFHX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:23:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF43E43;
        Wed,  6 Sep 2023 00:23:55 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RgYhD60qrzTlkL;
        Wed,  6 Sep 2023 15:21:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 15:23:53 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/7] net: hns3: fix tx timeout issue
Date:   Wed, 6 Sep 2023 15:20:12 +0800
Message-ID: <20230906072018.3020671-2-shaojijie@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

Currently, the driver knocks the ring doorbell before updating
the ring->last_to_use in tx flow. if the hardware transmiting
packet and napi poll scheduling are fast enough, it may get
the old ring->last_to_use in drivers' napi poll.
In this case, the driver will think the tx is not completed, and
return directly without clear the flag __QUEUE_STATE_STACK_XOFF,
which may cause tx timeout.

Fixes: 20d06ca2679c ("net: hns3: optimize the tx clean process")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index eac2d0573241..81947c4e5100 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2103,8 +2103,12 @@ static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,
 	 */
 	if (test_bit(HNS3_NIC_STATE_TX_PUSH_ENABLE, &priv->state) && num &&
 	    !ring->pending_buf && num <= HNS3_MAX_PUSH_BD_NUM && doorbell) {
+		/* This smp_store_release() pairs with smp_load_aquire() in
+		 * hns3_nic_reclaim_desc(). Ensure that the BD valid bit
+		 * is updated.
+		 */
+		smp_store_release(&ring->last_to_use, ring->next_to_use);
 		hns3_tx_push_bd(ring, num);
-		WRITE_ONCE(ring->last_to_use, ring->next_to_use);
 		return;
 	}
 
@@ -2115,6 +2119,11 @@ static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,
 		return;
 	}
 
+	/* This smp_store_release() pairs with smp_load_aquire() in
+	 * hns3_nic_reclaim_desc(). Ensure that the BD valid bit is updated.
+	 */
+	smp_store_release(&ring->last_to_use, ring->next_to_use);
+
 	if (ring->tqp->mem_base)
 		hns3_tx_mem_doorbell(ring);
 	else
@@ -2122,7 +2131,6 @@ static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,
 		       ring->tqp->io_base + HNS3_RING_TX_RING_TAIL_REG);
 
 	ring->pending_buf = 0;
-	WRITE_ONCE(ring->last_to_use, ring->next_to_use);
 }
 
 static void hns3_tsyn(struct net_device *netdev, struct sk_buff *skb,
@@ -3563,9 +3571,8 @@ static void hns3_reuse_buffer(struct hns3_enet_ring *ring, int i)
 static bool hns3_nic_reclaim_desc(struct hns3_enet_ring *ring,
 				  int *bytes, int *pkts, int budget)
 {
-	/* pair with ring->last_to_use update in hns3_tx_doorbell(),
-	 * smp_store_release() is not used in hns3_tx_doorbell() because
-	 * the doorbell operation already have the needed barrier operation.
+	/* This smp_load_acquire() pairs with smp_store_release() in
+	 * hns3_tx_doorbell().
 	 */
 	int ltu = smp_load_acquire(&ring->last_to_use);
 	int ntc = ring->next_to_clean;
-- 
2.30.0

