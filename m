Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC6807144
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378641AbjLFNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378633AbjLFNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:52:34 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B547F12B;
        Wed,  6 Dec 2023 05:52:40 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6DYq3f021830;
        Wed, 6 Dec 2023 05:52:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=mf2VUIogGD9WROPqEUdLuGXNPzy/Kl00mkGnzkqjjJk=;
 b=Odkcvdrpa5R3KLnIZsIfqy5/fWAxonkNDoG32NPqYTX1MMVlwd0p57ZQABHS0Epi1nQF
 44SaGquiDlM4CNBIxnXKaKFge/VZgrDqUNBV6jbmbOoVuF9QqLJoHIVw3CLnkCe1k6KZ
 8jE2QLViWxEonNKzeuwy2X/OuLqpC8PpP2HHzpLd3LTiIqCP3tScdORqfYTuDZMTTNwq
 /zlwVKMQGQvXJTQYX7ijzt8YmECDO1mBWd1ExABb1fw6HDA17ncFb0lS35v4nSezuxPd
 vvk5QR80PuXQAAPmFE1w+oM9fDHF9IV4Hwbokf8WTBbq2zjJtXtAw1/JK7Y5Jv/XF4qK eQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3utd0pae8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 05:52:32 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Dec
 2023 05:52:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 6 Dec 2023 05:52:30 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id ECBCD3F70A0;
        Wed,  6 Dec 2023 05:52:29 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net v3] octeon_ep: initialise control mbox tasks before using APIs
Date:   Wed, 6 Dec 2023 05:52:27 -0800
Message-ID: <20231206135228.2591659-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: n6LfMkp4Wfy_1ZovDgVfQ6r1PH1seTSe
X-Proofpoint-ORIG-GUID: n6LfMkp4Wfy_1ZovDgVfQ6r1PH1seTSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_11,2023-12-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise various workqueue tasks and queue interrupt poll task
before the first invocation of any control net APIs. Since
octep_ctrl_net_get_info was called before the control net receive
work task was initialised or even the interrupt poll task was
queued, the function call wasn't returning actual firmware
info queried from Octeon.

Fixes: 8d6198a14e2b ("octeon_ep: support to fetch firmware info")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Included Fixes line in commit log.
  - Corrected typo in print statement.

V2: https://lore.kernel.org/all/20231205130625.2586755-1-srasheed@marvell.com/
  - Updated changelog.
  - Handled error return for octep_ctrl_net_get_info

V1: https://lore.kernel.org/all/20231202150807.2571103-1-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_main.c   | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index b8ae269f6f97..dbab878b4d76 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1193,6 +1193,13 @@ int octep_device_setup(struct octep_device *oct)
 	if (ret)
 		return ret;
 
+	INIT_WORK(&oct->tx_timeout_task, octep_tx_timeout_task);
+	INIT_WORK(&oct->ctrl_mbox_task, octep_ctrl_mbox_task);
+	INIT_DELAYED_WORK(&oct->intr_poll_task, octep_intr_poll_task);
+	oct->poll_non_ioq_intr = true;
+	queue_delayed_work(octep_wq, &oct->intr_poll_task,
+			   msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS));
+
 	atomic_set(&oct->hb_miss_cnt, 0);
 	INIT_DELAYED_WORK(&oct->hb_task, octep_hb_timeout_task);
 
@@ -1326,21 +1333,18 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_octep_config;
 	}
 
-	octep_ctrl_net_get_info(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
-				&octep_dev->conf->fw_info);
+	err = octep_ctrl_net_get_info(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
+				      &octep_dev->conf->fw_info);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get firmware info\n");
+		goto register_dev_err;
+	}
 	dev_info(&octep_dev->pdev->dev, "Heartbeat interval %u msecs Heartbeat miss count %u\n",
 		 octep_dev->conf->fw_info.hb_interval,
 		 octep_dev->conf->fw_info.hb_miss_count);
 	queue_delayed_work(octep_wq, &octep_dev->hb_task,
 			   msecs_to_jiffies(octep_dev->conf->fw_info.hb_interval));
 
-	INIT_WORK(&octep_dev->tx_timeout_task, octep_tx_timeout_task);
-	INIT_WORK(&octep_dev->ctrl_mbox_task, octep_ctrl_mbox_task);
-	INIT_DELAYED_WORK(&octep_dev->intr_poll_task, octep_intr_poll_task);
-	octep_dev->poll_non_ioq_intr = true;
-	queue_delayed_work(octep_wq, &octep_dev->intr_poll_task,
-			   msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS));
-
 	netdev->netdev_ops = &octep_netdev_ops;
 	octep_set_ethtool_ops(netdev);
 	netif_carrier_off(netdev);
-- 
2.25.1

