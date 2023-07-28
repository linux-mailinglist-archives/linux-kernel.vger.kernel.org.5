Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7225766647
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjG1IEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjG1IDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:03:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D630E0;
        Fri, 28 Jul 2023 01:01:53 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC0Pb6MhmzNm62;
        Fri, 28 Jul 2023 15:58:27 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:01:50 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
        <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 6/6] net: hns3: fix deadlock issue when externel_lb and reset are executed together
Date:   Fri, 28 Jul 2023 15:58:40 +0800
Message-ID: <20230728075840.4022760-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230728075840.4022760-1-shaojijie@huawei.com>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

When externel_lb and reset are executed together, a deadlock may
occur:
[ 3147.217009] INFO: task kworker/u321:0:7 blocked for more than 120 seconds.
[ 3147.230483] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3147.238999] task:kworker/u321:0  state:D stack:    0 pid:    7 ppid:     2 flags:0x00000008
[ 3147.248045] Workqueue: hclge hclge_service_task [hclge]
[ 3147.253957] Call trace:
[ 3147.257093]  __switch_to+0x7c/0xbc
[ 3147.261183]  __schedule+0x338/0x6f0
[ 3147.265357]  schedule+0x50/0xe0
[ 3147.269185]  schedule_preempt_disabled+0x18/0x24
[ 3147.274488]  __mutex_lock.constprop.0+0x1d4/0x5dc
[ 3147.279880]  __mutex_lock_slowpath+0x1c/0x30
[ 3147.284839]  mutex_lock+0x50/0x60
[ 3147.288841]  rtnl_lock+0x20/0x2c
[ 3147.292759]  hclge_reset_prepare+0x68/0x90 [hclge]
[ 3147.298239]  hclge_reset_subtask+0x88/0xe0 [hclge]
[ 3147.303718]  hclge_reset_service_task+0x84/0x120 [hclge]
[ 3147.309718]  hclge_service_task+0x2c/0x70 [hclge]
[ 3147.315109]  process_one_work+0x1d0/0x490
[ 3147.319805]  worker_thread+0x158/0x3d0
[ 3147.324240]  kthread+0x108/0x13c
[ 3147.328154]  ret_from_fork+0x10/0x18

In externel_lb process, the hns3 driver call napi_disable()
first, then the reset happen, then the restore process of the
externel_lb will fail, and will not call napi_enable(). When
doing externel_lb again, napi_disable() will be double call,
cause a deadlock of rtnl_lock().

This patch use the HNS3_NIC_STATE_DOWN state to protect the
calling of napi_disable() and napi_enable() in externel_lb
process, just as the usage in ndo_stop() and ndo_start().

Fixes: 04b6ba143521 ("net: hns3: add support for external loopback test")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 823e6d2e85f5..7da54a5b81d1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5855,6 +5855,9 @@ void hns3_external_lb_prepare(struct net_device *ndev, bool if_running)
 	if (!if_running)
 		return;
 
+	if (test_and_set_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		return;
+
 	netif_carrier_off(ndev);
 	netif_tx_disable(ndev);
 
@@ -5883,7 +5886,16 @@ void hns3_external_lb_restore(struct net_device *ndev, bool if_running)
 	if (!if_running)
 		return;
 
-	hns3_nic_reset_all_ring(priv->ae_handle);
+	if (hns3_nic_resetting(ndev))
+		return;
+
+	if (!test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		return;
+
+	if (hns3_nic_reset_all_ring(priv->ae_handle))
+		return;
+
+	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
 	for (i = 0; i < priv->vector_num; i++)
 		hns3_vector_enable(&priv->tqp_vector[i]);
-- 
2.30.0

