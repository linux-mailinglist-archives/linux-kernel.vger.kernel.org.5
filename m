Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9839D7FA642
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjK0QWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjK0QWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:22:08 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F475CE;
        Mon, 27 Nov 2023 08:22:14 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR9KK9Q019284;
        Mon, 27 Nov 2023 08:22:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=JAUDcv4VDo0xvJS6AezwUUOpI6SIUT4nFGCzu3rflmA=;
 b=SZE0xwCrV2SPruFvXl5ID4WnE83XBhXoxyaRZpBtJOKZE2OLB0qdyYv0Go6T3MN3t4TO
 aq3APWBY/L05BRf/BGEYMCSBt/H4tt0cTj+mZXa+GBkMDSILd/A2T08NVv+gCJzKMao0
 +bBOVhUXd/+gDGm2lvN4koE3S93vdWIXaSOlXG9ilH0TbjhwAOcumFSWZeqMGGnTPNAb
 MUtHV0fOOR+IFx28696h/PFpK1+SJk4LeoXXt+QrBmXvY3vlAZPzpACBp91PG2Ie38qr
 cDUll7KpcLLe8VmIK+c8b4Wbskk2SFE7A1iBQCZsTs8LatZr/TeSG0/juGxeplUyvzRs eQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3umrcu99s3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 08:21:51 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 27 Nov
 2023 08:21:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 27 Nov 2023 08:21:44 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id AD6D73F7057;
        Mon, 27 Nov 2023 08:21:44 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>
Subject: [PATCH net-next v1 2/2] octeon_ep: support OCTEON CN98 devices
Date:   Mon, 27 Nov 2023 08:21:35 -0800
Message-ID: <20231127162135.2529363-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127162135.2529363-1-srasheed@marvell.com>
References: <20231127162135.2529363-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3RmG_6v_C-bj018YO_8XiWH3winv3Ovu
X-Proofpoint-ORIG-GUID: 3RmG_6v_C-bj018YO_8XiWH3winv3Ovu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_14,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI Endpoint NIC support for Octeon CN98 devices.
CN98 devices are part of Octeon 9 family products with
similar PCI NIC characteristics to CN93, already supported
driver.

Add CN98 card to the device id table, as well
as support differences in the register fields and
certain usage scenarios such as unload.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../ethernet/marvell/octeon_ep.rst            |  1 +
 .../marvell/octeon_ep/octep_cn9k_pf.c         | 24 +++++++++++++++----
 .../ethernet/marvell/octeon_ep/octep_main.c   |  4 ++++
 .../ethernet/marvell/octeon_ep/octep_main.h   |  1 +
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |  4 ++++
 5 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeon_ep.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeon_ep.rst
index 613a818d5db6..c96d262b30be 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeon_ep.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeon_ep.rst
@@ -22,6 +22,7 @@ EndPoint NIC.
 Supported Devices
 =================
 Currently, this driver support following devices:
+ * Network controller: Cavium, Inc. Device b100
  * Network controller: Cavium, Inc. Device b200
  * Network controller: Cavium, Inc. Device b400
  * Network controller: Cavium, Inc. Device b900
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index d4ee2454675b..8baabd07e91f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -216,9 +216,15 @@ static void octep_init_config_cn93_pf(struct octep_device *oct)
 	conf->sriov_cfg.vf_srn = CN93_SDP_EPF_RINFO_SRN(val);
 
 	val = octep_read_csr64(oct, CN93_SDP_MAC_PF_RING_CTL(oct->pcie_port));
-	conf->pf_ring_cfg.srn =  CN93_SDP_MAC_PF_RING_CTL_SRN(val);
-	conf->pf_ring_cfg.max_io_rings = CN93_SDP_MAC_PF_RING_CTL_RPPF(val);
-	conf->pf_ring_cfg.active_io_rings = conf->pf_ring_cfg.max_io_rings;
+	if (oct->chip_id == OCTEP_PCI_DEVICE_ID_CN98_PF) {
+		conf->pf_ring_cfg.srn =  CN98_SDP_MAC_PF_RING_CTL_SRN(val);
+		conf->pf_ring_cfg.max_io_rings = CN98_SDP_MAC_PF_RING_CTL_RPPF(val);
+		conf->pf_ring_cfg.active_io_rings = conf->pf_ring_cfg.max_io_rings;
+	} else {
+		conf->pf_ring_cfg.srn =  CN93_SDP_MAC_PF_RING_CTL_SRN(val);
+		conf->pf_ring_cfg.max_io_rings = CN93_SDP_MAC_PF_RING_CTL_RPPF(val);
+		conf->pf_ring_cfg.active_io_rings = conf->pf_ring_cfg.max_io_rings;
+	}
 	dev_info(&pdev->dev, "pf_srn=%u rpvf=%u nvfs=%u rppf=%u\n",
 		 conf->pf_ring_cfg.srn, conf->sriov_cfg.active_rings_per_vf,
 		 conf->sriov_cfg.active_vfs, conf->pf_ring_cfg.active_io_rings);
@@ -578,6 +584,13 @@ static irqreturn_t octep_ioq_intr_handler_cn93_pf(void *data)
 	return IRQ_HANDLED;
 }
 
+/* soft reset of 98xx */
+static int octep_soft_reset_cn98_pf(struct octep_device *oct)
+{
+	dev_info(&oct->pdev->dev, "CN98XX: skip soft reset\n");
+	return 0;
+}
+
 /* soft reset of 93xx */
 static int octep_soft_reset_cn93_pf(struct octep_device *oct)
 {
@@ -806,7 +819,10 @@ void octep_device_setup_cn93_pf(struct octep_device *oct)
 	oct->hw_ops.misc_intr_handler = octep_misc_intr_handler_cn93_pf;
 	oct->hw_ops.rsvd_intr_handler = octep_rsvd_intr_handler_cn93_pf;
 	oct->hw_ops.ioq_intr_handler = octep_ioq_intr_handler_cn93_pf;
-	oct->hw_ops.soft_reset = octep_soft_reset_cn93_pf;
+	if (oct->chip_id == OCTEP_PCI_DEVICE_ID_CN98_PF)
+		oct->hw_ops.soft_reset = octep_soft_reset_cn98_pf;
+	else
+		oct->hw_ops.soft_reset = octep_soft_reset_cn93_pf;
 	oct->hw_ops.reinit_regs = octep_reinit_regs_cn93_pf;
 
 	oct->hw_ops.enable_interrupts = octep_enable_interrupts_cn93_pf;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 423eec5ff3ad..1a24b3d3cce6 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -22,6 +22,7 @@ struct workqueue_struct *octep_wq;
 
 /* Supported Devices */
 static const struct pci_device_id octep_pci_id_tbl[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN98_PF)},
 	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN93_PF)},
 	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CNF95N_PF)},
 	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN10KA_PF)},
@@ -1147,6 +1148,8 @@ static void octep_ctrl_mbox_task(struct work_struct *work)
 static const char *octep_devid_to_str(struct octep_device *oct)
 {
 	switch (oct->chip_id) {
+	case OCTEP_PCI_DEVICE_ID_CN98_PF:
+		return "CN98XX";
 	case OCTEP_PCI_DEVICE_ID_CN93_PF:
 		return "CN93XX";
 	case OCTEP_PCI_DEVICE_ID_CNF95N_PF:
@@ -1197,6 +1200,7 @@ int octep_device_setup(struct octep_device *oct)
 	dev_info(&pdev->dev, "chip_id = 0x%x\n", pdev->device);
 
 	switch (oct->chip_id) {
+	case OCTEP_PCI_DEVICE_ID_CN98_PF:
 	case OCTEP_PCI_DEVICE_ID_CN93_PF:
 	case OCTEP_PCI_DEVICE_ID_CNF95N_PF:
 		dev_info(&pdev->dev, "Setting up OCTEON %s PF PASS%d.%d\n",
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index e2fe8b28eb0e..e1b4b2af618e 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -18,6 +18,7 @@
 #define  OCTEP_PCIID_CN93_PF  0xB200177d
 #define  OCTEP_PCIID_CN93_VF  0xB203177d
 
+#define  OCTEP_PCI_DEVICE_ID_CN98_PF 0xB100
 #define  OCTEP_PCI_DEVICE_ID_CN93_PF 0xB200
 #define  OCTEP_PCI_DEVICE_ID_CN93_VF 0xB203
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
index 0a43983e9101..2e20a39d89af 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -362,6 +362,10 @@
 #define    CN93_SDP_MAC_PF_RING_CTL_SRN(val)   (((val) >> 8) & 0xFF)
 #define    CN93_SDP_MAC_PF_RING_CTL_RPPF(val)  (((val) >> 16) & 0x3F)
 
+#define    CN98_SDP_MAC_PF_RING_CTL_NPFS(val)  (((val) >> 48) & 0xF)
+#define    CN98_SDP_MAC_PF_RING_CTL_SRN(val)   ((val) & 0xFF)
+#define    CN98_SDP_MAC_PF_RING_CTL_RPPF(val)  (((val) >> 32) & 0x3F)
+
 /* Number of non-queue interrupts in CN93xx */
 #define    CN93_NUM_NON_IOQ_INTR    16
 
-- 
2.25.1

