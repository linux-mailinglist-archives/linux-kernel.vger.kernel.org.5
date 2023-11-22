Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290907F4FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbjKVSe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKVSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:34:56 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB41B3;
        Wed, 22 Nov 2023 10:34:52 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMIU3jT010198;
        Wed, 22 Nov 2023 10:34:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=Ad5Pfud6yw74v4+PGflZFf1MJQXBE8TwlIsl0hXwWQw=;
 b=ZZ2iV9+9eBOfR4W1C3ORmgoxq161jiqlSTbm8PmSlQqFAVYN0BW7NVshiZNpHBARDmLW
 06ZYrTmXyrBcnVF2D4LPpH49X/b8FDYpZgubSgLVt1rZnmwKB8SV10bWF0R49m6MMUWC
 PGKPbe9io3ukVOIZn1PnADnQVT4zOLf9p4t7Se5YkRtUZFhnp+uRmumoF2HEOJxDPels
 kf4GPrAYLgzlMl/Xgfr69KiOQhYSK4pQNz1+0k5uJs2l8/lKKQZ3FXtgVn+SyMO1wYTD
 z2ly/IPXYHSkZxfcXDm35hAojPLrB4NbDec/q+Qeg/Yon2c3mZyHeMu+2dHtcM0vFiBm Jg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uh1jbcs7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 10:34:45 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 22 Nov
 2023 10:34:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 22 Nov 2023 10:34:43 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 9AF8F3F7040;
        Wed, 22 Nov 2023 10:34:43 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, <jesse.brandeburg@intel.com>,
        <sumang@marvell.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v2 2/2] octeon_ep: get max rx packet length from firmware
Date:   Wed, 22 Nov 2023 10:34:35 -0800
Message-ID: <20231122183435.2510656-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122183435.2510656-1-srasheed@marvell.com>
References: <20231122183435.2510656-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sS0qxrASVjdDszlCOTrR99-JjLFL4uCp
X-Proofpoint-GUID: sS0qxrASVjdDszlCOTrR99-JjLFL4uCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_13,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max receive packet length can vary across SoCs, so
this needs to be queried from respective firmware and
filled by driver. A control net get mtu api should be
implemented to do the same.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Removed OCTEP_MAX_MTU macro as it is redundant.

V1: https://lore.kernel.org/all/20231121191224.2489474-1-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_config.h  |  2 --
 .../marvell/octeon_ep/octep_ctrl_net.c         | 18 ++++++++++++++++++
 .../marvell/octeon_ep/octep_ctrl_net.h         | 10 ++++++++++
 .../ethernet/marvell/octeon_ep/octep_main.c    | 10 +++++++++-
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
index 91cfa19c65b9..4c937ba5589f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
@@ -45,8 +45,6 @@
 
 /* Minimum MTU supported by Octeon network interface */
 #define OCTEP_MIN_MTU        ETH_MIN_MTU
-/* Maximum MTU supported by Octeon interface*/
-#define OCTEP_MAX_MTU        (10000 - (ETH_HLEN + ETH_FCS_LEN))
 /* Default MTU */
 #define OCTEP_DEFAULT_MTU    1500
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 2eeeaa7188b1..5fa596c674da 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -198,6 +198,24 @@ int octep_ctrl_net_set_mac_addr(struct octep_device *oct, int vfid, u8 *addr,
 	return octep_send_mbox_req(oct, &d, wait_for_response);
 }
 
+int octep_ctrl_net_get_mtu(struct octep_device *oct, int vfid)
+{
+	struct octep_ctrl_net_wait_data d = {};
+	struct octep_ctrl_net_h2f_req *req;
+	int err;
+
+	req = &d.data.req;
+	init_send_req(&d.msg, req, mtu_sz, vfid);
+	req->hdr.s.cmd = OCTEP_CTRL_NET_H2F_CMD_MTU;
+	req->mtu.cmd = OCTEP_CTRL_NET_CMD_GET;
+
+	err = octep_send_mbox_req(oct, &d, true);
+	if (err < 0)
+		return err;
+
+	return d.data.resp.mtu.val;
+}
+
 int octep_ctrl_net_set_mtu(struct octep_device *oct, int vfid, int mtu,
 			   bool wait_for_response)
 {
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
index 02b8fcf890d0..a2463b460ad9 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
@@ -287,6 +287,16 @@ int octep_ctrl_net_get_mac_addr(struct octep_device *oct, int vfid, u8 *addr);
 int octep_ctrl_net_set_mac_addr(struct octep_device *oct, int vfid, u8 *addr,
 				bool wait_for_response);
 
+/**
+ * octep_ctrl_net_get_mtu() - Get max MTU from firmware.
+ *
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ *
+ * return value: mtu on success, -errno on failure.
+ */
+int octep_ctrl_net_get_mtu(struct octep_device *oct, int vfid);
+
 /** 
  * octep_ctrl_net_set_mtu() - Set mtu in firmware.
  *
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 2da00a701df2..423eec5ff3ad 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1307,6 +1307,7 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct octep_device *octep_dev = NULL;
 	struct net_device *netdev;
+	int max_rx_pktlen;
 	int err;
 
 	err = pci_enable_device(pdev);
@@ -1377,8 +1378,15 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netdev->hw_features = NETIF_F_SG;
 	netdev->features |= netdev->hw_features;
+
+	max_rx_pktlen = octep_ctrl_net_get_mtu(octep_dev, OCTEP_CTRL_NET_INVALID_VFID);
+	if (max_rx_pktlen < 0) {
+		dev_err(&octep_dev->pdev->dev,
+			"Failed to get max receive packet size; err = %d\n", max_rx_pktlen);
+		goto register_dev_err;
+	}
 	netdev->min_mtu = OCTEP_MIN_MTU;
-	netdev->max_mtu = OCTEP_MAX_MTU;
+	netdev->max_mtu = max_rx_pktlen - (ETH_HLEN + ETH_FCS_LEN);
 	netdev->mtu = OCTEP_DEFAULT_MTU;
 
 	err = octep_ctrl_net_get_mac_addr(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
-- 
2.25.1

