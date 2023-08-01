Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF176B32B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjHALZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjHALZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:25:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5941FCB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:25:12 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RFXkh1rJPzLnyG
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:22:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 19:24:45 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2] octeontx2: Remove unnecessary ternary operators
Date:   Tue, 1 Aug 2023 19:24:09 +0800
Message-ID: <20230801112409.304564-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a little ternary operators, the true or false judgement
of which is unnecessary in C language semantics. So remove it
to clean Code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
- Fix the subject prefix and commit message issue.
---
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c      | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index 0ee420a489fc..c55c2c441a1a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -61,12 +61,12 @@ static const struct pci_device_id ptp_id_table[];
 
 static bool is_ptp_dev_cnf10kb(struct ptp *ptp)
 {
-	return (ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B_PTP) ? true : false;
+	return ptp->pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B_PTP;
 }
 
 static bool is_ptp_dev_cn10k(struct ptp *ptp)
 {
-	return (ptp->pdev->device == PCI_DEVID_CN10K_PTP) ? true : false;
+	return ptp->pdev->device == PCI_DEVID_CN10K_PTP;
 }
 
 static bool cn10k_ptp_errata(struct ptp *ptp)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 9551b422622a..61f62a6ec662 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2027,7 +2027,7 @@ u16 otx2_select_queue(struct net_device *netdev, struct sk_buff *skb,
 #endif
 	int txq;
 
-	qos_enabled = (netdev->real_num_tx_queues > pf->hw.tx_queues) ? true : false;
+	qos_enabled = netdev->real_num_tx_queues > pf->hw.tx_queues;
 	if (unlikely(qos_enabled)) {
 		/* This smp_load_acquire() pairs with smp_store_release() in
 		 * otx2_qos_root_add() called from htb offload root creation
-- 
2.34.1

