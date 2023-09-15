Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5589D7A1883
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjIOIVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjIOIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:21:44 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C31B2710;
        Fri, 15 Sep 2023 01:19:27 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F5l7wq031886;
        Fri, 15 Sep 2023 01:16:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=VrbC/opRa3bowTi+jCvbDXGelqHejkboudyRrfjNUGg=;
 b=Oefx0vveY/TVlfpV9cEKJC4o0p+9y5uB7LPLqC4yd0vX7Lxdz2dwTnxJdpkB2cSDswJE
 GfPRNbwMce/szrxdRDwkfOxKx9t/8h+CCmWX+5S/UNMgjSovNeJmqOAp4WmvWCH5nNKj
 QgSsLzJdkU711KHw7mINnHZUgjkzvwnnEOMbfCoqiQU+IV/HBkXoKv1QagD47cryjDPB
 eBZP8ef7Cjfv2IfNuDDxns89N+AH+5RaBmXbgxiOMa9h1u6ujV+ujmGFH3/EvVqK5+Ws
 r/HDWqaZDRf95fIPVeWcBQzeYavmSU9e5Jf02uadlQuEDctXIJm8boUaZWuWBu7WdVEN eQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3t4gnd0hxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 01:16:21 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Sep
 2023 01:16:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 15 Sep 2023 01:16:19 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 2A8D85B6932;
        Fri, 15 Sep 2023 01:16:18 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hgani@marvell.com>
CC:     <egallen@redhat.com>, <mschmidt@redhat.com>,
        <vimleshk@marvell.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [net-next PATCH] octeon_ep: support to fetch firmware info
Date:   Fri, 15 Sep 2023 01:16:07 -0700
Message-ID: <20230915081608.2155837-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L9E9cJZoaB3971lDCONrr1yMGxDWKGPO
X-Proofpoint-ORIG-GUID: L9E9cJZoaB3971lDCONrr1yMGxDWKGPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to fetch firmware info such as heartbeat miss count,
heartbeat interval. This shall be used for heartbeat monitor.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../marvell/octeon_ep/octep_cn9k_pf.c         | 10 +++-----
 .../ethernet/marvell/octeon_ep/octep_config.h | 22 +++++++++++++----
 .../marvell/octeon_ep/octep_ctrl_net.c        | 24 ++++++++++++++++++-
 .../marvell/octeon_ep/octep_ctrl_net.h        | 18 ++++++++++++++
 .../ethernet/marvell/octeon_ep/octep_main.c   | 16 +++++++++----
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |  4 ++++
 6 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index 90c3a419932d..f282cd5b29ea 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -16,9 +16,6 @@
 #define CTRL_MBOX_MAX_PF	128
 #define CTRL_MBOX_SZ		((size_t)(0x400000 / CTRL_MBOX_MAX_PF))
 
-#define FW_HB_INTERVAL_IN_SECS		1
-#define FW_HB_MISS_COUNT		10
-
 /* Names of Hardware non-queue generic interrupts */
 static char *cn93_non_ioq_msix_names[] = {
 	"epf_ire_rint",
@@ -250,12 +247,11 @@ static void octep_init_config_cn93_pf(struct octep_device *oct)
 		link = PCI_DEVFN(PCI_SLOT(oct->pdev->devfn), link);
 	}
 	conf->ctrl_mbox_cfg.barmem_addr = (void __iomem *)oct->mmio[2].hw_addr +
-					   (0x400000ull * 7) +
+					   CN93_PEM_BAR4_INDEX_OFFSET +
 					   (link * CTRL_MBOX_SZ);
 
-	conf->hb_interval = FW_HB_INTERVAL_IN_SECS;
-	conf->max_hb_miss_cnt = FW_HB_MISS_COUNT;
-
+	conf->fw_info.hb_interval = OCTEP_DEFAULT_FW_HB_INTERVAL;
+	conf->fw_info.hb_miss_count = OCTEP_DEFAULT_FW_HB_MISS_COUNT;
 }
 
 /* Setup registers for a hardware Tx Queue  */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
index df7cd39d9fce..1622a6ebf036 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
@@ -49,6 +49,11 @@
 /* Default MTU */
 #define OCTEP_DEFAULT_MTU    1500
 
+/* pf heartbeat interval in milliseconds */
+#define OCTEP_DEFAULT_FW_HB_INTERVAL           1000
+/* pf heartbeat miss count */
+#define OCTEP_DEFAULT_FW_HB_MISS_COUNT         20
+
 /* Macros to get octeon config params */
 #define CFG_GET_IQ_CFG(cfg)             ((cfg)->iq)
 #define CFG_GET_IQ_NUM_DESC(cfg)        ((cfg)->iq.num_descs)
@@ -181,6 +186,16 @@ struct octep_ctrl_mbox_config {
 	void __iomem *barmem_addr;
 };
 
+/* Info from firmware */
+struct octep_fw_info {
+	/* interface pkind */
+	u16 pkind;
+	/* heartbeat interval in milliseconds */
+	u16 hb_interval;
+	/* heartbeat miss count */
+	u16 hb_miss_count;
+};
+
 /* Data Structure to hold configuration limits and active config */
 struct octep_config {
 	/* Input Queue attributes. */
@@ -201,10 +216,7 @@ struct octep_config {
 	/* ctrl mbox config */
 	struct octep_ctrl_mbox_config ctrl_mbox_cfg;
 
-	/* Configured maximum heartbeat miss count */
-	u32 max_hb_miss_cnt;
-
-	/* Configured firmware heartbeat interval in secs */
-	u32 hb_interval;
+	/* fw info */
+	struct octep_fw_info fw_info;
 };
 #endif /* _OCTEP_CONFIG_H_ */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 4c6d91a8c83e..5b5343fd2771 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -26,7 +26,7 @@ static atomic_t ctrl_net_msg_id;
 
 /* Control plane version in which OCTEP_CTRL_NET_H2F_CMD was added */
 static const u32 octep_ctrl_net_h2f_cmd_versions[OCTEP_CTRL_NET_H2F_CMD_MAX] = {
-	[OCTEP_CTRL_NET_H2F_CMD_INVALID ... OCTEP_CTRL_NET_H2F_CMD_LINK_INFO] =
+	[OCTEP_CTRL_NET_H2F_CMD_INVALID ... OCTEP_CTRL_NET_H2F_CMD_GET_INFO] =
 	 OCTEP_CP_VERSION(1, 0, 0)
 };
 
@@ -353,6 +353,28 @@ void octep_ctrl_net_recv_fw_messages(struct octep_device *oct)
 	}
 }
 
+int octep_ctrl_net_get_info(struct octep_device *oct, int vfid,
+			    struct octep_fw_info *info)
+{
+	struct octep_ctrl_net_wait_data d = {0};
+	struct octep_ctrl_net_h2f_resp *resp;
+	struct octep_ctrl_net_h2f_req *req;
+	int err;
+
+	req = &d.data.req;
+	init_send_req(&d.msg, req, 0, vfid);
+	req->hdr.s.cmd = OCTEP_CTRL_NET_H2F_CMD_GET_INFO;
+	req->link_info.cmd = OCTEP_CTRL_NET_CMD_GET;
+	err = octep_send_mbox_req(oct, &d, true);
+	if (err < 0)
+		return err;
+
+	resp = &d.data.resp;
+	memcpy(info, &resp->info.fw_info, sizeof(struct octep_fw_info));
+
+	return 0;
+}
+
 int octep_ctrl_net_uninit(struct octep_device *oct)
 {
 	struct octep_ctrl_net_wait_data *pos, *n;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
index 1c2ef4ee31d9..b330f370131b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
@@ -41,6 +41,7 @@ enum octep_ctrl_net_h2f_cmd {
 	OCTEP_CTRL_NET_H2F_CMD_LINK_STATUS,
 	OCTEP_CTRL_NET_H2F_CMD_RX_STATE,
 	OCTEP_CTRL_NET_H2F_CMD_LINK_INFO,
+	OCTEP_CTRL_NET_H2F_CMD_GET_INFO,
 	OCTEP_CTRL_NET_H2F_CMD_MAX
 };
 
@@ -161,6 +162,11 @@ struct octep_ctrl_net_h2f_resp_cmd_state {
 	u16 state;
 };
 
+/* get info request */
+struct octep_ctrl_net_h2f_resp_cmd_get_info {
+	struct octep_fw_info fw_info;
+};
+
 /* Host to fw response data */
 struct octep_ctrl_net_h2f_resp {
 	union octep_ctrl_net_resp_hdr hdr;
@@ -171,6 +177,7 @@ struct octep_ctrl_net_h2f_resp {
 		struct octep_ctrl_net_h2f_resp_cmd_state link;
 		struct octep_ctrl_net_h2f_resp_cmd_state rx;
 		struct octep_ctrl_net_link_info link_info;
+		struct octep_ctrl_net_h2f_resp_cmd_get_info info;
 	};
 } __packed;
 
@@ -330,6 +337,17 @@ int octep_ctrl_net_set_link_info(struct octep_device *oct,
  */
 void octep_ctrl_net_recv_fw_messages(struct octep_device *oct);
 
+/** Get info from firmware.
+ *
+ * @param oct: non-null pointer to struct octep_device.
+ * @param vfid: Index of virtual function.
+ * @param info: non-null pointer to struct octep_fw_info.
+ *
+ * return value: 0 on success, -errno on failure.
+ */
+int octep_ctrl_net_get_info(struct octep_device *oct, int vfid,
+			    struct octep_fw_info *info);
+
 /** Uninitialize data for ctrl net.
  *
  * @param oct: non-null pointer to struct octep_device.
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 43eb6e871351..ec3fd7ca3125 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -918,9 +918,9 @@ static void octep_hb_timeout_task(struct work_struct *work)
 	int miss_cnt;
 
 	miss_cnt = atomic_inc_return(&oct->hb_miss_cnt);
-	if (miss_cnt < oct->conf->max_hb_miss_cnt) {
+	if (miss_cnt < oct->conf->fw_info.hb_miss_count) {
 		queue_delayed_work(octep_wq, &oct->hb_task,
-				   msecs_to_jiffies(oct->conf->hb_interval * 1000));
+				   msecs_to_jiffies(oct->conf->fw_info.hb_interval));
 		return;
 	}
 
@@ -1013,8 +1013,7 @@ int octep_device_setup(struct octep_device *oct)
 
 	atomic_set(&oct->hb_miss_cnt, 0);
 	INIT_DELAYED_WORK(&oct->hb_task, octep_hb_timeout_task);
-	queue_delayed_work(octep_wq, &oct->hb_task,
-			   msecs_to_jiffies(oct->conf->hb_interval * 1000));
+
 	return 0;
 
 unsupported_dev:
@@ -1139,6 +1138,15 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(&pdev->dev, "Device setup failed\n");
 		goto err_octep_config;
 	}
+
+	octep_ctrl_net_get_info(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
+				&octep_dev->conf->fw_info);
+	dev_info(&octep_dev->pdev->dev, "Heartbeat interval %u msecs Heartbeat miss count %u\n",
+		 octep_dev->conf->fw_info.hb_interval,
+		 octep_dev->conf->fw_info.hb_miss_count);
+	queue_delayed_work(octep_wq, &octep_dev->hb_task,
+			   msecs_to_jiffies(octep_dev->conf->fw_info.hb_interval));
+
 	INIT_WORK(&octep_dev->tx_timeout_task, octep_tx_timeout_task);
 	INIT_WORK(&octep_dev->ctrl_mbox_task, octep_ctrl_mbox_task);
 	INIT_DELAYED_WORK(&octep_dev->intr_poll_task, octep_intr_poll_task);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
index b25c3093dc7b..0a43983e9101 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -370,4 +370,8 @@
 /* bit 1 for firmware heartbeat interrupt */
 #define CN93_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
 
+#define CN93_PEM_BAR4_INDEX            7
+#define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
+#define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)
+
 #endif /* _OCTEP_REGS_CN9K_PF_H_ */
-- 
2.25.1

