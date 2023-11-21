Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B736F7F36AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjKUTNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUTNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:13:09 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C9991;
        Tue, 21 Nov 2023 11:13:02 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALI8HKM008875;
        Tue, 21 Nov 2023 11:12:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=AWKC+GczEkhuiGyImuPiTHSlgjHzmEvA5QGEFZps9BA=;
 b=cXZ1D/3h4P93mDyunsMEDn2UiRv5CkosraWU9trNJw3gWMnbsZ/pTR/4gMw1/+BIiMRl
 GaFYTwrFbzYnVz4qo631F5+URpNeqw3hgul8hu9Vlv3nT6WlaMCIhnNDvasojhPT+Q5n
 XmOhjQTY2Nv01enj+nm6WOn6LXowdmcY3VQCWof3oYp7kRa60EjDjuvYrxA8O+bie/yM
 ruhL10ckUBCP60kJ5jh+b0zUoj7H7auUCMxwEk19WLrpQHHa+tJSMQA/UqAzgrH3vgOy
 i/xXM/ZkT8o2ABwMhM1+rZmjfA/PHOpPFT+sXfxIb8fdDsuoHvNZJ36cbzweHL9fmXB/ SA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uh1jb87a8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:12:55 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 21 Nov
 2023 11:12:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 21 Nov 2023 11:12:54 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 226395B6922;
        Tue, 21 Nov 2023 11:12:54 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v1] octeon_ep: get max rx packet length from firmware
Date:   Tue, 21 Nov 2023 11:12:23 -0800
Message-ID: <20231121191224.2489474-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eTbUaV7jKAe1Ld-2L-H9UrIGKwgh5hvy
X-Proofpoint-GUID: eTbUaV7jKAe1Ld-2L-H9UrIGKwgh5hvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill max rx packet length value from firmware.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../marvell/octeon_ep/octep_ctrl_net.c         | 18 ++++++++++++++++++
 .../marvell/octeon_ep/octep_ctrl_net.h         |  9 +++++++++
 .../ethernet/marvell/octeon_ep/octep_main.c    | 10 +++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 6dd3d03c1c0f..c9fcebb9bd9b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -198,6 +198,24 @@ int octep_ctrl_net_set_mac_addr(struct octep_device *oct, int vfid, u8 *addr,
 	return octep_send_mbox_req(oct, &d, wait_for_response);
 }
 
+int octep_ctrl_net_get_mtu(struct octep_device *oct, int vfid)
+{
+	struct octep_ctrl_net_wait_data d = {0};
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
index 4bb97ad1f1c6..46ddaa5c64d1 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
@@ -282,6 +282,15 @@ int octep_ctrl_net_get_mac_addr(struct octep_device *oct, int vfid, u8 *addr);
 int octep_ctrl_net_set_mac_addr(struct octep_device *oct, int vfid, u8 *addr,
 				bool wait_for_response);
 
+/** Get max MTU from firmware.
+ *
+ * @param oct: non-null pointer to struct octep_device.
+ * @param vfid: Index of virtual function.
+ *
+ * return value: mtu on success, -errno on failure.
+ */
+int octep_ctrl_net_get_mtu(struct octep_device *oct, int vfid);
+
 /** Set mtu in firmware.
  *
  * @param oct: non-null pointer to struct octep_device.
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 3cee69b3ac38..f9c539178114 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1276,6 +1276,7 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct octep_device *octep_dev = NULL;
 	struct net_device *netdev;
+	int max_rx_pktlen;
 	int err;
 
 	err = pci_enable_device(pdev);
@@ -1346,8 +1347,15 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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

