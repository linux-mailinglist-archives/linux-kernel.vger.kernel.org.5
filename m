Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D57EF0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbjKQKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345915AbjKQKip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:38:45 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E9B9;
        Fri, 17 Nov 2023 02:38:37 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHAAGPl026675;
        Fri, 17 Nov 2023 02:38:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=NHeFh6V67ZXCM2lbKSUIaWJfvGxoNe+pKAuXRJcerSU=;
 b=P923eN2BgFDZx89A5XXsE0hR0m+u9QeBRcjSGdDCuyYydlwzGFY6O2qSaNts3y5xw/Ww
 UNbQwdCZS7VJAdrtOyeLsvJUVPB8OvTUHd4UkL7x03q75+ffiyP0OHKxcVV/IWa7CfDP
 daWvIVU1Mndiytguzll/XHZUrYc8pfz9cU2ssHm/9c+e5z4txJKA//DuD0sIJx645cr2
 uKMpaA8mRMoqJoeIeRixKIlGerHviSlai3xMoIoJsEuUcxlumOgJxn8nBV8y0zZK/Eof
 gGm2lLGCZ7kA7keSR/2wlcs3gHUcUqu8K9ydUAXaAeBqcVZ+KxzOr30MqqMmGd1dPMKD jg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ue0des2g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 02:38:26 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 17 Nov
 2023 02:38:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 17 Nov 2023 02:38:23 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 788783F708C;
        Fri, 17 Nov 2023 02:38:23 -0800 (PST)
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
Subject: [PATCH net-next v1] octeon_ep: support Octeon CN10K devices
Date:   Fri, 17 Nov 2023 02:38:10 -0800
Message-ID: <20231117103817.2468176-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ul3EgTgt1PzfFZIOgadMqWxG2GICccxP
X-Proofpoint-ORIG-GUID: Ul3EgTgt1PzfFZIOgadMqWxG2GICccxP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_09,2023-11-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI Endpoint NIC support for Octeon CN10K devices.
CN10K devices are part of Octeon 10 family products with
similar PCI NIC characteristics. These include:
- CN10KA
- CNF10KA
- CNF10KB
- CN10KB

Update supported device list in Documentation

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../ethernet/marvell/octeon_ep.rst            |   4 +
 .../net/ethernet/marvell/octeon_ep/Makefile   |   3 +-
 .../marvell/octeon_ep/octep_cnxk_pf.c         | 886 ++++++++++++++++++
 .../ethernet/marvell/octeon_ep/octep_main.c   |  20 +
 .../ethernet/marvell/octeon_ep/octep_main.h   |   6 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    | 400 ++++++++
 6 files changed, 1318 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeon_ep.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeon_ep.rst
index cad96c8d1f97..613a818d5db6 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeon_ep.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeon_ep.rst
@@ -24,6 +24,10 @@ Supported Devices
 Currently, this driver support following devices:
  * Network controller: Cavium, Inc. Device b200
  * Network controller: Cavium, Inc. Device b400
+ * Network controller: Cavium, Inc. Device b900
+ * Network controller: Cavium, Inc. Device ba00
+ * Network controller: Cavium, Inc. Device bc00
+ * Network controller: Cavium, Inc. Device bd00
 
 Interface Control
 =================
diff --git a/drivers/net/ethernet/marvell/octeon_ep/Makefile b/drivers/net/ethernet/marvell/octeon_ep/Makefile
index 2026c8118158..02a4a21bc298 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/Makefile
+++ b/drivers/net/ethernet/marvell/octeon_ep/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_OCTEON_EP) += octeon_ep.o
 
 octeon_ep-y := octep_main.o octep_cn9k_pf.o octep_tx.o octep_rx.o \
-	       octep_ethtool.o octep_ctrl_mbox.o octep_ctrl_net.o
+	       octep_ethtool.o octep_ctrl_mbox.o octep_ctrl_net.o \
+	       octep_cnxk_pf.o
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
new file mode 100644
index 000000000000..abb03e9119e7
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -0,0 +1,886 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell Octeon EP (EndPoint) Ethernet Driver
+ *
+ * Copyright (C) 2020 Marvell.
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+
+#include "octep_config.h"
+#include "octep_main.h"
+#include "octep_regs_cnxk_pf.h"
+
+/* We will support 128 pf's in control mbox */
+#define CTRL_MBOX_MAX_PF	128
+#define CTRL_MBOX_SZ		((size_t)(0x400000 / CTRL_MBOX_MAX_PF))
+
+/* Names of Hardware non-queue generic interrupts */
+static char *cnxk_non_ioq_msix_names[] = {
+	"epf_ire_rint",
+	"epf_ore_rint",
+	"epf_vfire_rint",
+	"epf_rsvd0",
+	"epf_vfore_rint",
+	"epf_rsvd1",
+	"epf_mbox_rint",
+	"epf_rsvd2_0",
+	"epf_rsvd2_1",
+	"epf_dma_rint",
+	"epf_dma_vf_rint",
+	"epf_rsvd3",
+	"epf_pp_vf_rint",
+	"epf_rsvd3",
+	"epf_misc_rint",
+	"epf_rsvd5",
+	/* Next 16 are for OEI_RINT */
+	"epf_oei_rint0",
+	"epf_oei_rint1",
+	"epf_oei_rint2",
+	"epf_oei_rint3",
+	"epf_oei_rint4",
+	"epf_oei_rint5",
+	"epf_oei_rint6",
+	"epf_oei_rint7",
+	"epf_oei_rint8",
+	"epf_oei_rint9",
+	"epf_oei_rint10",
+	"epf_oei_rint11",
+	"epf_oei_rint12",
+	"epf_oei_rint13",
+	"epf_oei_rint14",
+	"epf_oei_rint15",
+	/* IOQ interrupt */
+	"octeon_ep"
+};
+
+/* Dump useful hardware CSRs for debug purpose */
+static void cnxk_dump_regs(struct octep_device *oct, int qno)
+{
+	struct device *dev = &oct->pdev->dev;
+
+	dev_info(dev, "IQ-%d register dump\n", qno);
+	dev_info(dev, "R[%d]_IN_INSTR_DBELL[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_IN_INSTR_DBELL(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_IN_INSTR_DBELL(qno)));
+	dev_info(dev, "R[%d]_IN_CONTROL[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_IN_CONTROL(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_IN_CONTROL(qno)));
+	dev_info(dev, "R[%d]_IN_ENABLE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_IN_ENABLE(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_IN_ENABLE(qno)));
+	dev_info(dev, "R[%d]_IN_INSTR_BADDR[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_IN_INSTR_BADDR(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_IN_INSTR_BADDR(qno)));
+	dev_info(dev, "R[%d]_IN_INSTR_RSIZE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_IN_INSTR_RSIZE(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_IN_INSTR_RSIZE(qno)));
+	dev_info(dev, "R[%d]_IN_CNTS[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_IN_CNTS(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_IN_CNTS(qno)));
+	dev_info(dev, "R[%d]_IN_INT_LEVELS[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_IN_INT_LEVELS(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_IN_INT_LEVELS(qno)));
+	dev_info(dev, "R[%d]_IN_PKT_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_IN_PKT_CNT(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_IN_PKT_CNT(qno)));
+	dev_info(dev, "R[%d]_IN_BYTE_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_IN_BYTE_CNT(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_IN_BYTE_CNT(qno)));
+
+	dev_info(dev, "OQ-%d register dump\n", qno);
+	dev_info(dev, "R[%d]_OUT_SLIST_DBELL[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_OUT_SLIST_DBELL(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_DBELL(qno)));
+	dev_info(dev, "R[%d]_OUT_CONTROL[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_OUT_CONTROL(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(qno)));
+	dev_info(dev, "R[%d]_OUT_ENABLE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_OUT_ENABLE(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_OUT_ENABLE(qno)));
+	dev_info(dev, "R[%d]_OUT_SLIST_BADDR[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_OUT_SLIST_BADDR(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(qno)));
+	dev_info(dev, "R[%d]_OUT_SLIST_RSIZE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_OUT_SLIST_RSIZE(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(qno)));
+	dev_info(dev, "R[%d]_OUT_CNTS[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_OUT_CNTS(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_OUT_CNTS(qno)));
+	dev_info(dev, "R[%d]_OUT_INT_LEVELS[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_OUT_INT_LEVELS(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_OUT_INT_LEVELS(qno)));
+	dev_info(dev, "R[%d]_OUT_PKT_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_OUT_PKT_CNT(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_OUT_PKT_CNT(qno)));
+	dev_info(dev, "R[%d]_OUT_BYTE_CNT[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_OUT_BYTE_CNT(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_OUT_BYTE_CNT(qno)));
+	dev_info(dev, "R[%d]_ERR_TYPE[0x%llx]: 0x%016llx\n",
+		 qno, CNXK_SDP_R_ERR_TYPE(qno),
+		 octep_read_csr64(oct, CNXK_SDP_R_ERR_TYPE(qno)));
+}
+
+/* Reset Hardware Tx queue */
+static int cnxk_reset_iq(struct octep_device *oct, int q_no)
+{
+	struct octep_config *conf = oct->conf;
+	u64 val = 0ULL;
+
+	dev_dbg(&oct->pdev->dev, "Reset PF IQ-%d\n", q_no);
+
+	/* Get absolute queue number */
+	q_no += conf->pf_ring_cfg.srn;
+
+	/* Disable the Tx/Instruction Ring */
+	octep_write_csr64(oct, CNXK_SDP_R_IN_ENABLE(q_no), val);
+
+	/* clear the Instruction Ring packet/byte counts and doorbell CSRs */
+	octep_write_csr64(oct, CNXK_SDP_R_IN_CNTS(q_no), val);
+	octep_write_csr64(oct, CNXK_SDP_R_IN_INT_LEVELS(q_no), val);
+	octep_write_csr64(oct, CNXK_SDP_R_IN_PKT_CNT(q_no), val);
+	octep_write_csr64(oct, CNXK_SDP_R_IN_BYTE_CNT(q_no), val);
+	octep_write_csr64(oct, CNXK_SDP_R_IN_INSTR_BADDR(q_no), val);
+	octep_write_csr64(oct, CNXK_SDP_R_IN_INSTR_RSIZE(q_no), val);
+
+	val = 0xFFFFFFFF;
+	octep_write_csr64(oct, CNXK_SDP_R_IN_INSTR_DBELL(q_no), val);
+
+	return 0;
+}
+
+/* Reset Hardware Rx queue */
+static void cnxk_reset_oq(struct octep_device *oct, int q_no)
+{
+	u64 val = 0ULL;
+
+	q_no += CFG_GET_PORTS_PF_SRN(oct->conf);
+
+	/* Disable Output (Rx) Ring */
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_ENABLE(q_no), val);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(q_no), val);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(q_no), val);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_INT_LEVELS(q_no), val);
+
+	/* Clear count CSRs */
+	val = octep_read_csr(oct, CNXK_SDP_R_OUT_CNTS(q_no));
+	octep_write_csr(oct, CNXK_SDP_R_OUT_CNTS(q_no), val);
+
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_PKT_CNT(q_no), 0xFFFFFFFFFULL);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_DBELL(q_no), 0xFFFFFFFF);
+}
+
+/* Reset all hardware Tx/Rx queues */
+static void octep_reset_io_queues_cnxk_pf(struct octep_device *oct)
+{
+	struct pci_dev *pdev = oct->pdev;
+	int q;
+
+	dev_dbg(&pdev->dev, "Reset OCTEP_CNXK PF IO Queues\n");
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) {
+		cnxk_reset_iq(oct, q);
+		cnxk_reset_oq(oct, q);
+	}
+}
+
+/* Initialize windowed addresses to access some hardware registers */
+static void octep_setup_pci_window_regs_cnxk_pf(struct octep_device *oct)
+{
+	u8 __iomem *bar0_pciaddr = oct->mmio[0].hw_addr;
+
+	oct->pci_win_regs.pci_win_wr_addr = (u8 __iomem *)(bar0_pciaddr + CNXK_SDP_WIN_WR_ADDR64);
+	oct->pci_win_regs.pci_win_rd_addr = (u8 __iomem *)(bar0_pciaddr + CNXK_SDP_WIN_RD_ADDR64);
+	oct->pci_win_regs.pci_win_wr_data = (u8 __iomem *)(bar0_pciaddr + CNXK_SDP_WIN_WR_DATA64);
+	oct->pci_win_regs.pci_win_rd_data = (u8 __iomem *)(bar0_pciaddr + CNXK_SDP_WIN_RD_DATA64);
+}
+
+/* Configure Hardware mapping: inform hardware which rings belong to PF. */
+static void octep_configure_ring_mapping_cnxk_pf(struct octep_device *oct)
+{
+	struct octep_config *conf = oct->conf;
+	struct pci_dev *pdev = oct->pdev;
+	u64 pf_srn = CFG_GET_PORTS_PF_SRN(oct->conf);
+	int q;
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(conf); q++) {
+		u64 regval = 0;
+
+		if (oct->pcie_port)
+			regval = 8 << CNXK_SDP_FUNC_SEL_EPF_BIT_POS;
+
+		octep_write_csr64(oct, CNXK_SDP_EPVF_RING(pf_srn + q), regval);
+
+		regval = octep_read_csr64(oct, CNXK_SDP_EPVF_RING(pf_srn + q));
+		dev_dbg(&pdev->dev, "Write SDP_EPVF_RING[0x%llx] = 0x%llx\n",
+			CNXK_SDP_EPVF_RING(pf_srn + q), regval);
+	}
+}
+
+/* Initialize configuration limits and initial active config */
+static void octep_init_config_cnxk_pf(struct octep_device *oct)
+{
+	struct octep_config *conf = oct->conf;
+	struct pci_dev *pdev = oct->pdev;
+	u8 link = 0;
+	u64 val;
+	int pos;
+
+	/* Read ring configuration:
+	 * PF ring count, number of VFs and rings per VF supported
+	 */
+	val = octep_read_csr64(oct, CNXK_SDP_EPF_RINFO);
+	dev_info(&pdev->dev, "SDP_EPF_RINFO[0x%x]:0x%llx\n", CNXK_SDP_EPF_RINFO, val);
+	conf->sriov_cfg.max_rings_per_vf = CNXK_SDP_EPF_RINFO_RPVF(val);
+	conf->sriov_cfg.active_rings_per_vf = conf->sriov_cfg.max_rings_per_vf;
+	conf->sriov_cfg.max_vfs = CNXK_SDP_EPF_RINFO_NVFS(val);
+	conf->sriov_cfg.active_vfs = conf->sriov_cfg.max_vfs;
+	conf->sriov_cfg.vf_srn = CNXK_SDP_EPF_RINFO_SRN(val);
+
+	val = octep_read_csr64(oct, CNXK_SDP_MAC_PF_RING_CTL(oct->pcie_port));
+	dev_info(&pdev->dev, "SDP_MAC_PF_RING_CTL[%d]:0x%llx\n", oct->pcie_port, val);
+	conf->pf_ring_cfg.srn =  CNXK_SDP_MAC_PF_RING_CTL_SRN(val);
+	conf->pf_ring_cfg.max_io_rings = CNXK_SDP_MAC_PF_RING_CTL_RPPF(val);
+	conf->pf_ring_cfg.active_io_rings = conf->pf_ring_cfg.max_io_rings;
+	dev_info(&pdev->dev, "pf_srn=%u rpvf=%u nvfs=%u rppf=%u\n",
+		 conf->pf_ring_cfg.srn, conf->sriov_cfg.active_rings_per_vf,
+		 conf->sriov_cfg.active_vfs, conf->pf_ring_cfg.active_io_rings);
+
+	conf->iq.num_descs = OCTEP_IQ_MAX_DESCRIPTORS;
+	conf->iq.instr_type = OCTEP_64BYTE_INSTR;
+	conf->iq.db_min = OCTEP_DB_MIN;
+	conf->iq.intr_threshold = OCTEP_IQ_INTR_THRESHOLD;
+
+	conf->oq.num_descs = OCTEP_OQ_MAX_DESCRIPTORS;
+	conf->oq.buf_size = OCTEP_OQ_BUF_SIZE;
+	conf->oq.refill_threshold = OCTEP_OQ_REFILL_THRESHOLD;
+	conf->oq.oq_intr_pkt = OCTEP_OQ_INTR_PKT_THRESHOLD;
+	conf->oq.oq_intr_time = OCTEP_OQ_INTR_TIME_THRESHOLD;
+
+	conf->msix_cfg.non_ioq_msix = CNXK_NUM_NON_IOQ_INTR;
+	conf->msix_cfg.ioq_msix = conf->pf_ring_cfg.active_io_rings;
+	conf->msix_cfg.non_ioq_msix_names = cnxk_non_ioq_msix_names;
+
+	pos = pci_find_ext_capability(oct->pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (pos) {
+		pci_read_config_byte(oct->pdev,
+				     pos + PCI_SRIOV_FUNC_LINK,
+				     &link);
+		link = PCI_DEVFN(PCI_SLOT(oct->pdev->devfn), link);
+	}
+	conf->ctrl_mbox_cfg.barmem_addr = (void __iomem *)oct->mmio[2].hw_addr +
+					   CNXK_PEM_BAR4_INDEX_OFFSET +
+					   (link * CTRL_MBOX_SZ);
+
+	conf->fw_info.hb_interval = OCTEP_DEFAULT_FW_HB_INTERVAL;
+	conf->fw_info.hb_miss_count = OCTEP_DEFAULT_FW_HB_MISS_COUNT;
+}
+
+/* Setup registers for a hardware Tx Queue  */
+static void octep_setup_iq_regs_cnxk_pf(struct octep_device *oct, int iq_no)
+{
+	struct octep_iq *iq = oct->iq[iq_no];
+	u32 reset_instr_cnt;
+	u64 reg_val;
+
+	iq_no += CFG_GET_PORTS_PF_SRN(oct->conf);
+	reg_val = octep_read_csr64(oct, CNXK_SDP_R_IN_CONTROL(iq_no));
+
+	/* wait for IDLE to set to 1 */
+	if (!(reg_val & CNXK_R_IN_CTL_IDLE)) {
+		do {
+			reg_val = octep_read_csr64(oct, CNXK_SDP_R_IN_CONTROL(iq_no));
+		} while (!(reg_val & CNXK_R_IN_CTL_IDLE));
+	}
+
+	reg_val |= CNXK_R_IN_CTL_RDSIZE;
+	reg_val |= CNXK_R_IN_CTL_IS_64B;
+	reg_val |= CNXK_R_IN_CTL_ESR;
+	octep_write_csr64(oct, CNXK_SDP_R_IN_CONTROL(iq_no), reg_val);
+
+	/* Write the start of the input queue's ring and its size  */
+	octep_write_csr64(oct, CNXK_SDP_R_IN_INSTR_BADDR(iq_no),
+			  iq->desc_ring_dma);
+	octep_write_csr64(oct, CNXK_SDP_R_IN_INSTR_RSIZE(iq_no),
+			  iq->max_count);
+
+	/* Remember the doorbell & instruction count register addr
+	 * for this queue
+	 */
+	iq->doorbell_reg = oct->mmio[0].hw_addr +
+			   CNXK_SDP_R_IN_INSTR_DBELL(iq_no);
+	iq->inst_cnt_reg = oct->mmio[0].hw_addr +
+			   CNXK_SDP_R_IN_CNTS(iq_no);
+	iq->intr_lvl_reg = oct->mmio[0].hw_addr +
+			   CNXK_SDP_R_IN_INT_LEVELS(iq_no);
+
+	/* Store the current instruction counter (used in flush_iq calculation) */
+	reset_instr_cnt = readl(iq->inst_cnt_reg);
+	writel(reset_instr_cnt, iq->inst_cnt_reg);
+
+	/* INTR_THRESHOLD is set to max(FFFFFFFF) to disable the INTR */
+	reg_val = CFG_GET_IQ_INTR_THRESHOLD(oct->conf) & 0xffffffff;
+	octep_write_csr64(oct, CNXK_SDP_R_IN_INT_LEVELS(iq_no), reg_val);
+}
+
+/* Setup registers for a hardware Rx Queue  */
+static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
+{
+	u64 reg_val;
+	u64 oq_ctl = 0ULL;
+	u32 time_threshold = 0;
+	struct octep_oq *oq = oct->oq[oq_no];
+
+	oq_no += CFG_GET_PORTS_PF_SRN(oct->conf);
+	reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
+
+	/* wait for IDLE to set to 1 */
+	if (!(reg_val & CNXK_R_OUT_CTL_IDLE)) {
+		do {
+			reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
+		} while (!(reg_val & CNXK_R_OUT_CTL_IDLE));
+	}
+
+	reg_val &= ~(CNXK_R_OUT_CTL_IMODE);
+	reg_val &= ~(CNXK_R_OUT_CTL_ROR_P);
+	reg_val &= ~(CNXK_R_OUT_CTL_NSR_P);
+	reg_val &= ~(CNXK_R_OUT_CTL_ROR_I);
+	reg_val &= ~(CNXK_R_OUT_CTL_NSR_I);
+	reg_val &= ~(CNXK_R_OUT_CTL_ES_I);
+	reg_val &= ~(CNXK_R_OUT_CTL_ROR_D);
+	reg_val &= ~(CNXK_R_OUT_CTL_NSR_D);
+	reg_val &= ~(CNXK_R_OUT_CTL_ES_D);
+	reg_val |= (CNXK_R_OUT_CTL_ES_P);
+
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no), reg_val);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
+			  oq->desc_ring_dma);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
+			  oq->max_count);
+
+	oq_ctl = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
+
+	/* Clear the ISIZE and BSIZE (22-0) */
+	oq_ctl &= ~0x7fffffULL;
+
+	/* Populate the BSIZE (15-0) */
+	oq_ctl |= (oq->buffer_size & 0xffff);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no), oq_ctl);
+
+	/* Get the mapped address of the pkt_sent and pkts_credit regs */
+	oq->pkts_sent_reg = oct->mmio[0].hw_addr + CNXK_SDP_R_OUT_CNTS(oq_no);
+	oq->pkts_credit_reg = oct->mmio[0].hw_addr +
+			      CNXK_SDP_R_OUT_SLIST_DBELL(oq_no);
+
+	time_threshold = CFG_GET_OQ_INTR_TIME(oct->conf);
+	reg_val = ((u64)time_threshold << 32) |
+		  CFG_GET_OQ_INTR_PKT(oct->conf);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+}
+
+/* Setup registers for a PF mailbox */
+static void octep_setup_mbox_regs_cnxk_pf(struct octep_device *oct, int q_no)
+{
+	struct octep_mbox *mbox = oct->mbox[q_no];
+
+	mbox->q_no = q_no;
+
+	/* PF mbox interrupt reg */
+	mbox->mbox_int_reg = oct->mmio[0].hw_addr + CNXK_SDP_EPF_MBOX_RINT(0);
+
+	/* PF to VF DATA reg. PF writes into this reg */
+	mbox->mbox_write_reg = oct->mmio[0].hw_addr + CNXK_SDP_R_MBOX_PF_VF_DATA(q_no);
+
+	/* VF to PF DATA reg. PF reads from this reg */
+	mbox->mbox_read_reg = oct->mmio[0].hw_addr + CNXK_SDP_R_MBOX_VF_PF_DATA(q_no);
+}
+
+/* Poll OEI events like heartbeat */
+static void octep_poll_oei_cnxk_pf(struct octep_device *oct)
+{
+	u64 reg0;
+
+	/* Check for OEI INTR */
+	reg0 = octep_read_csr64(oct, CNXK_SDP_EPF_OEI_RINT);
+	if (reg0) {
+		octep_write_csr64(oct, CNXK_SDP_EPF_OEI_RINT, reg0);
+		if (reg0 & CNXK_SDP_EPF_OEI_RINT_DATA_BIT_MBOX)
+			queue_work(octep_wq, &oct->ctrl_mbox_task);
+		if (reg0 & CNXK_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT)
+			atomic_set(&oct->hb_miss_cnt, 0);
+	}
+}
+
+/* OEI interrupt handler */
+static irqreturn_t octep_oei_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+
+	octep_poll_oei_cnxk_pf(oct);
+	return IRQ_HANDLED;
+}
+
+/* Process non-ioq interrupts required to keep pf interface running.
+ * OEI_RINT is needed for control mailbox
+ * MBOX_RINT is needed for pfvf mailbox
+ */
+static void octep_poll_non_ioq_interrupts_cnxk_pf(struct octep_device *oct)
+{
+	octep_poll_oei_cnxk_pf(oct);
+}
+
+/* Interrupt handler for input ring error interrupts. */
+static irqreturn_t octep_ire_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
+	int i = 0;
+
+	/* Check for IRERR INTR */
+	reg_val = octep_read_csr64(oct, CNXK_SDP_EPF_IRERR_RINT);
+	if (reg_val) {
+		dev_info(&pdev->dev,
+			 "received IRERR_RINT intr: 0x%llx\n", reg_val);
+		octep_write_csr64(oct, CNXK_SDP_EPF_IRERR_RINT, reg_val);
+
+		for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++) {
+			reg_val = octep_read_csr64(oct,
+						   CNXK_SDP_R_ERR_TYPE(i));
+			if (reg_val) {
+				dev_info(&pdev->dev,
+					 "Received err type on IQ-%d: 0x%llx\n",
+					 i, reg_val);
+				octep_write_csr64(oct, CNXK_SDP_R_ERR_TYPE(i),
+						  reg_val);
+			}
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for output ring error interrupts. */
+static irqreturn_t octep_ore_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
+	int i = 0;
+
+	/* Check for ORERR INTR */
+	reg_val = octep_read_csr64(oct, CNXK_SDP_EPF_ORERR_RINT);
+	if (reg_val) {
+		dev_info(&pdev->dev,
+			 "Received ORERR_RINT intr: 0x%llx\n", reg_val);
+		octep_write_csr64(oct, CNXK_SDP_EPF_ORERR_RINT, reg_val);
+		for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++) {
+			reg_val = octep_read_csr64(oct, CNXK_SDP_R_ERR_TYPE(i));
+			if (reg_val) {
+				dev_info(&pdev->dev,
+					 "Received err type on OQ-%d: 0x%llx\n",
+					 i, reg_val);
+				octep_write_csr64(oct, CNXK_SDP_R_ERR_TYPE(i),
+						  reg_val);
+			}
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for vf input ring error interrupts. */
+static irqreturn_t octep_vfire_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
+
+	/* Check for VFIRE INTR */
+	reg_val = octep_read_csr64(oct, CNXK_SDP_EPF_VFIRE_RINT(0));
+	if (reg_val) {
+		dev_info(&pdev->dev,
+			 "Received VFIRE_RINT intr: 0x%llx\n", reg_val);
+		octep_write_csr64(oct, CNXK_SDP_EPF_VFIRE_RINT(0), reg_val);
+	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for vf output ring error interrupts. */
+static irqreturn_t octep_vfore_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
+
+	/* Check for VFORE INTR */
+	reg_val = octep_read_csr64(oct, CNXK_SDP_EPF_VFORE_RINT(0));
+	if (reg_val) {
+		dev_info(&pdev->dev,
+			 "Received VFORE_RINT intr: 0x%llx\n", reg_val);
+		octep_write_csr64(oct, CNXK_SDP_EPF_VFORE_RINT(0), reg_val);
+	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for dpi dma related interrupts. */
+static irqreturn_t octep_dma_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	u64 reg_val = 0;
+
+	/* Check for DMA INTR */
+	reg_val = octep_read_csr64(oct, CNXK_SDP_EPF_DMA_RINT);
+	if (reg_val)
+		octep_write_csr64(oct, CNXK_SDP_EPF_DMA_RINT, reg_val);
+
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for dpi dma transaction error interrupts for VFs  */
+static irqreturn_t octep_dma_vf_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
+
+	/* Check for DMA VF INTR */
+	reg_val = octep_read_csr64(oct, CNXK_SDP_EPF_DMA_VF_RINT(0));
+	if (reg_val) {
+		dev_info(&pdev->dev,
+			 "Received DMA_VF_RINT intr: 0x%llx\n", reg_val);
+		octep_write_csr64(oct, CNXK_SDP_EPF_DMA_VF_RINT(0), reg_val);
+	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for pp transaction error interrupts for VFs  */
+static irqreturn_t octep_pp_vf_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
+
+	/* Check for PPVF INTR */
+	reg_val = octep_read_csr64(oct, CNXK_SDP_EPF_PP_VF_RINT(0));
+	if (reg_val) {
+		dev_info(&pdev->dev,
+			 "Received PP_VF_RINT intr: 0x%llx\n", reg_val);
+		octep_write_csr64(oct, CNXK_SDP_EPF_PP_VF_RINT(0), reg_val);
+	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for mac related interrupts. */
+static irqreturn_t octep_misc_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
+
+	/* Check for MISC INTR */
+	reg_val = octep_read_csr64(oct, CNXK_SDP_EPF_MISC_RINT);
+	if (reg_val) {
+		dev_info(&pdev->dev,
+			 "Received MISC_RINT intr: 0x%llx\n", reg_val);
+		octep_write_csr64(oct, CNXK_SDP_EPF_MISC_RINT, reg_val);
+	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupts handler for all reserved interrupts. */
+static irqreturn_t octep_rsvd_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+
+	dev_info(&pdev->dev, "Reserved interrupts raised; Ignore\n");
+	return IRQ_HANDLED;
+}
+
+/* Tx/Rx queue interrupt handler */
+static irqreturn_t octep_ioq_intr_handler_cnxk_pf(void *data)
+{
+	struct octep_ioq_vector *vector = (struct octep_ioq_vector *)data;
+	struct octep_oq *oq = vector->oq;
+
+	napi_schedule_irqoff(oq->napi);
+	return IRQ_HANDLED;
+}
+
+/* soft reset */
+static int octep_soft_reset_cnxk_pf(struct octep_device *oct)
+{
+	dev_info(&oct->pdev->dev, "CNXKXX: Doing soft reset\n");
+
+	octep_write_csr64(oct, CNXK_SDP_WIN_WR_MASK_REG, 0xFF);
+
+	/* Firmware status CSR is supposed to be cleared by
+	 * core domain reset, but due to a hw bug, it is not.
+	 * Set it to RUNNING right before reset so that it is not
+	 * left in READY (1) state after a reset.  This is required
+	 * in addition to the early setting to handle the case where
+	 * the OcteonTX is unexpectedly reset, reboots, and then
+	 * the module is removed.
+	 */
+	OCTEP_PCI_WIN_WRITE(oct, CNXK_PEMX_PFX_CSX_PFCFGX(0, 0, CNXK_PCIEEP_VSECST_CTL),
+			    FW_STATUS_RUNNING);
+
+	/* Set chip domain reset bit */
+	OCTEP_PCI_WIN_WRITE(oct, CNXK_RST_CHIP_DOMAIN_W1S, 1);
+	/* Wait till Octeon resets. */
+	mdelay(10);
+	/* restore the  reset value */
+	octep_write_csr64(oct, CNXK_SDP_WIN_WR_MASK_REG, 0xFF);
+
+	return 0;
+}
+
+/* Re-initialize Octeon hardware registers */
+static void octep_reinit_regs_cnxk_pf(struct octep_device *oct)
+{
+	u32 i;
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
+		oct->hw_ops.setup_iq_regs(oct, i);
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
+		oct->hw_ops.setup_oq_regs(oct, i);
+
+	oct->hw_ops.enable_interrupts(oct);
+	oct->hw_ops.enable_io_queues(oct);
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++)
+		writel(oct->oq[i]->max_count, oct->oq[i]->pkts_credit_reg);
+}
+
+/* Enable all interrupts */
+static void octep_enable_interrupts_cnxk_pf(struct octep_device *oct)
+{
+	u64 intr_mask = 0ULL;
+	int srn, num_rings, i;
+
+	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
+	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+
+	for (i = 0; i < num_rings; i++)
+		intr_mask |= (0x1ULL << (srn + i));
+
+	octep_write_csr64(oct, CNXK_SDP_EPF_IRERR_RINT_ENA_W1S, intr_mask);
+	octep_write_csr64(oct, CNXK_SDP_EPF_ORERR_RINT_ENA_W1S, intr_mask);
+	octep_write_csr64(oct, CNXK_SDP_EPF_OEI_RINT_ENA_W1S, -1ULL);
+
+	octep_write_csr64(oct, CNXK_SDP_EPF_VFIRE_RINT_ENA_W1S(0), -1ULL);
+	octep_write_csr64(oct, CNXK_SDP_EPF_VFORE_RINT_ENA_W1S(0), -1ULL);
+
+	octep_write_csr64(oct, CNXK_SDP_EPF_MISC_RINT_ENA_W1S, intr_mask);
+	octep_write_csr64(oct, CNXK_SDP_EPF_DMA_RINT_ENA_W1S, intr_mask);
+
+	octep_write_csr64(oct, CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1S(0), -1ULL);
+	octep_write_csr64(oct, CNXK_SDP_EPF_PP_VF_RINT_ENA_W1S(0), -1ULL);
+}
+
+/* Disable all interrupts */
+static void octep_disable_interrupts_cnxk_pf(struct octep_device *oct)
+{
+	u64 intr_mask = 0ULL;
+	int srn, num_rings, i;
+
+	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
+	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+
+	for (i = 0; i < num_rings; i++)
+		intr_mask |= (0x1ULL << (srn + i));
+
+	octep_write_csr64(oct, CNXK_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
+	octep_write_csr64(oct, CNXK_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
+	octep_write_csr64(oct, CNXK_SDP_EPF_OEI_RINT_ENA_W1C, -1ULL);
+
+	octep_write_csr64(oct, CNXK_SDP_EPF_VFIRE_RINT_ENA_W1C(0), -1ULL);
+	octep_write_csr64(oct, CNXK_SDP_EPF_VFORE_RINT_ENA_W1C(0), -1ULL);
+
+	octep_write_csr64(oct, CNXK_SDP_EPF_MISC_RINT_ENA_W1C, intr_mask);
+	octep_write_csr64(oct, CNXK_SDP_EPF_DMA_RINT_ENA_W1C, intr_mask);
+
+	octep_write_csr64(oct, CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1C(0), -1ULL);
+	octep_write_csr64(oct, CNXK_SDP_EPF_PP_VF_RINT_ENA_W1C(0), -1ULL);
+}
+
+/* Get new Octeon Read Index: index of descriptor that Octeon reads next. */
+static u32 octep_update_iq_read_index_cnxk_pf(struct octep_iq *iq)
+{
+	u32 pkt_in_done = readl(iq->inst_cnt_reg);
+	u32 last_done, new_idx;
+
+	last_done = pkt_in_done - iq->pkt_in_done;
+	iq->pkt_in_done = pkt_in_done;
+
+	new_idx = (iq->octep_read_index + last_done) % iq->max_count;
+
+	return new_idx;
+}
+
+/* Enable a hardware Tx Queue */
+static void octep_enable_iq_cnxk_pf(struct octep_device *oct, int iq_no)
+{
+	u64 loop = HZ;
+	u64 reg_val;
+
+	iq_no += CFG_GET_PORTS_PF_SRN(oct->conf);
+
+	octep_write_csr64(oct, CNXK_SDP_R_IN_INSTR_DBELL(iq_no), 0xFFFFFFFF);
+
+	while (octep_read_csr64(oct, CNXK_SDP_R_IN_INSTR_DBELL(iq_no)) &&
+	       loop--) {
+		schedule_timeout_interruptible(1);
+	}
+
+	reg_val = octep_read_csr64(oct,  CNXK_SDP_R_IN_INT_LEVELS(iq_no));
+	reg_val |= (0x1ULL << 62);
+	octep_write_csr64(oct, CNXK_SDP_R_IN_INT_LEVELS(iq_no), reg_val);
+
+	reg_val = octep_read_csr64(oct, CNXK_SDP_R_IN_ENABLE(iq_no));
+	reg_val |= 0x1ULL;
+	octep_write_csr64(oct, CNXK_SDP_R_IN_ENABLE(iq_no), reg_val);
+}
+
+/* Enable a hardware Rx Queue */
+static void octep_enable_oq_cnxk_pf(struct octep_device *oct, int oq_no)
+{
+	u64 reg_val = 0ULL;
+
+	oq_no += CFG_GET_PORTS_PF_SRN(oct->conf);
+
+	reg_val = octep_read_csr64(oct,  CNXK_SDP_R_OUT_INT_LEVELS(oq_no));
+	reg_val |= (0x1ULL << 62);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_DBELL(oq_no), 0xFFFFFFFF);
+
+	reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_ENABLE(oq_no));
+	reg_val |= 0x1ULL;
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_ENABLE(oq_no), reg_val);
+}
+
+/* Enable all hardware Tx/Rx Queues assined to PF */
+static void octep_enable_io_queues_cnxk_pf(struct octep_device *oct)
+{
+	u8 q;
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) {
+		octep_enable_iq_cnxk_pf(oct, q);
+		octep_enable_oq_cnxk_pf(oct, q);
+	}
+}
+
+/* Disable a hardware Tx Queue assined to PF */
+static void octep_disable_iq_cnxk_pf(struct octep_device *oct, int iq_no)
+{
+	u64 reg_val = 0ULL;
+
+	iq_no += CFG_GET_PORTS_PF_SRN(oct->conf);
+
+	reg_val = octep_read_csr64(oct, CNXK_SDP_R_IN_ENABLE(iq_no));
+	reg_val &= ~0x1ULL;
+	octep_write_csr64(oct, CNXK_SDP_R_IN_ENABLE(iq_no), reg_val);
+}
+
+/* Disable a hardware Rx Queue assined to PF */
+static void octep_disable_oq_cnxk_pf(struct octep_device *oct, int oq_no)
+{
+	u64 reg_val = 0ULL;
+
+	oq_no += CFG_GET_PORTS_PF_SRN(oct->conf);
+	reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_ENABLE(oq_no));
+	reg_val &= ~0x1ULL;
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_ENABLE(oq_no), reg_val);
+}
+
+/* Disable all hardware Tx/Rx Queues assined to PF */
+static void octep_disable_io_queues_cnxk_pf(struct octep_device *oct)
+{
+	int q = 0;
+
+	for (q = 0; q < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); q++) {
+		octep_disable_iq_cnxk_pf(oct, q);
+		octep_disable_oq_cnxk_pf(oct, q);
+	}
+}
+
+/* Dump hardware registers (including Tx/Rx queues) for debugging. */
+static void octep_dump_registers_cnxk_pf(struct octep_device *oct)
+{
+	u8 srn, num_rings, q;
+
+	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
+	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+
+	for (q = srn; q < srn + num_rings; q++)
+		cnxk_dump_regs(oct, q);
+}
+
+/**
+ * octep_device_setup_cnxk_pf() - Setup Octeon device.
+ *
+ * @oct: Octeon device private data structure.
+ *
+ * - initialize hardware operations.
+ * - get target side pcie port number for the device.
+ * - setup window access to hardware registers.
+ * - set initial configuration and max limits.
+ * - setup hardware mapping of rings to the PF device.
+ */
+void octep_device_setup_cnxk_pf(struct octep_device *oct)
+{
+	oct->hw_ops.setup_iq_regs = octep_setup_iq_regs_cnxk_pf;
+	oct->hw_ops.setup_oq_regs = octep_setup_oq_regs_cnxk_pf;
+	oct->hw_ops.setup_mbox_regs = octep_setup_mbox_regs_cnxk_pf;
+
+	oct->hw_ops.oei_intr_handler = octep_oei_intr_handler_cnxk_pf;
+	oct->hw_ops.ire_intr_handler = octep_ire_intr_handler_cnxk_pf;
+	oct->hw_ops.ore_intr_handler = octep_ore_intr_handler_cnxk_pf;
+	oct->hw_ops.vfire_intr_handler = octep_vfire_intr_handler_cnxk_pf;
+	oct->hw_ops.vfore_intr_handler = octep_vfore_intr_handler_cnxk_pf;
+	oct->hw_ops.dma_intr_handler = octep_dma_intr_handler_cnxk_pf;
+	oct->hw_ops.dma_vf_intr_handler = octep_dma_vf_intr_handler_cnxk_pf;
+	oct->hw_ops.pp_vf_intr_handler = octep_pp_vf_intr_handler_cnxk_pf;
+	oct->hw_ops.misc_intr_handler = octep_misc_intr_handler_cnxk_pf;
+	oct->hw_ops.rsvd_intr_handler = octep_rsvd_intr_handler_cnxk_pf;
+	oct->hw_ops.ioq_intr_handler = octep_ioq_intr_handler_cnxk_pf;
+	oct->hw_ops.soft_reset = octep_soft_reset_cnxk_pf;
+	oct->hw_ops.reinit_regs = octep_reinit_regs_cnxk_pf;
+
+	oct->hw_ops.enable_interrupts = octep_enable_interrupts_cnxk_pf;
+	oct->hw_ops.disable_interrupts = octep_disable_interrupts_cnxk_pf;
+	oct->hw_ops.poll_non_ioq_interrupts = octep_poll_non_ioq_interrupts_cnxk_pf;
+
+	oct->hw_ops.update_iq_read_idx = octep_update_iq_read_index_cnxk_pf;
+
+	oct->hw_ops.enable_iq = octep_enable_iq_cnxk_pf;
+	oct->hw_ops.enable_oq = octep_enable_oq_cnxk_pf;
+	oct->hw_ops.enable_io_queues = octep_enable_io_queues_cnxk_pf;
+
+	oct->hw_ops.disable_iq = octep_disable_iq_cnxk_pf;
+	oct->hw_ops.disable_oq = octep_disable_oq_cnxk_pf;
+	oct->hw_ops.disable_io_queues = octep_disable_io_queues_cnxk_pf;
+	oct->hw_ops.reset_io_queues = octep_reset_io_queues_cnxk_pf;
+
+	oct->hw_ops.dump_registers = octep_dump_registers_cnxk_pf;
+
+	octep_setup_pci_window_regs_cnxk_pf(oct);
+
+	oct->pcie_port = octep_read_csr64(oct, CNXK_SDP_MAC_NUMBER) & 0xff;
+	dev_info(&oct->pdev->dev,
+		 "Octeon device using PCIE Port %d\n", oct->pcie_port);
+
+	octep_init_config_cnxk_pf(oct);
+	octep_configure_ring_mapping_cnxk_pf(oct);
+
+	/* Firmware status CSR is supposed to be cleared by
+	 * core domain reset, but due to IPBUPEM-38842, it is not.
+	 * Set it to RUNNING early in boot, so that unexpected resets
+	 * leave it in a state that is not READY (1).
+	 */
+	OCTEP_PCI_WIN_WRITE(oct, CNXK_PEMX_PFX_CSX_PFCFGX(0, 0, CNXK_PCIEEP_VSECST_CTL),
+			    FW_STATUS_RUNNING);
+}
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 974a34be9ffa..2da00a701df2 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -24,6 +24,10 @@ struct workqueue_struct *octep_wq;
 static const struct pci_device_id octep_pci_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN93_PF)},
 	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CNF95N_PF)},
+	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN10KA_PF)},
+	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CNF10KA_PF)},
+	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CNF10KB_PF)},
+	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN10KB_PF)},
 	{0, },
 };
 MODULE_DEVICE_TABLE(pci, octep_pci_id_tbl);
@@ -1147,6 +1151,14 @@ static const char *octep_devid_to_str(struct octep_device *oct)
 		return "CN93XX";
 	case OCTEP_PCI_DEVICE_ID_CNF95N_PF:
 		return "CNF95N";
+	case OCTEP_PCI_DEVICE_ID_CN10KA_PF:
+		return "CN10KA";
+	case OCTEP_PCI_DEVICE_ID_CNF10KA_PF:
+		return "CNF10KA";
+	case OCTEP_PCI_DEVICE_ID_CNF10KB_PF:
+		return "CNF10KB";
+	case OCTEP_PCI_DEVICE_ID_CN10KB_PF:
+		return "CN10KB";
 	default:
 		return "Unsupported";
 	}
@@ -1192,6 +1204,14 @@ int octep_device_setup(struct octep_device *oct)
 			 OCTEP_MINOR_REV(oct));
 		octep_device_setup_cn93_pf(oct);
 		break;
+	case OCTEP_PCI_DEVICE_ID_CNF10KA_PF:
+	case OCTEP_PCI_DEVICE_ID_CN10KA_PF:
+	case OCTEP_PCI_DEVICE_ID_CNF10KB_PF:
+	case OCTEP_PCI_DEVICE_ID_CN10KB_PF:
+		dev_info(&pdev->dev, "Setting up OCTEON %s PF PASS%d.%d\n",
+			 octep_devid_to_str(oct), OCTEP_MAJOR_REV(oct), OCTEP_MINOR_REV(oct));
+		octep_device_setup_cnxk_pf(oct);
+		break;
 	default:
 		dev_err(&pdev->dev,
 			"%s: unsupported device\n", __func__);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index c33e046b69a4..e2fe8b28eb0e 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -23,6 +23,11 @@
 
 #define  OCTEP_PCI_DEVICE_ID_CNF95N_PF 0xB400    //95N PF
 
+#define  OCTEP_PCI_DEVICE_ID_CN10KA_PF  0xB900   //CN10KA PF
+#define  OCTEP_PCI_DEVICE_ID_CNF10KA_PF 0xBA00   //CNF10KA PF
+#define  OCTEP_PCI_DEVICE_ID_CNF10KB_PF 0xBC00   //CNF10KB PF
+#define  OCTEP_PCI_DEVICE_ID_CN10KB_PF  0xBD00   //CN10KB PF
+
 #define  OCTEP_MAX_QUEUES   63
 #define  OCTEP_MAX_IQ       OCTEP_MAX_QUEUES
 #define  OCTEP_MAX_OQ       OCTEP_MAX_QUEUES
@@ -386,6 +391,7 @@ int octep_setup_oqs(struct octep_device *oct);
 void octep_free_oqs(struct octep_device *oct);
 void octep_oq_dbell_init(struct octep_device *oct);
 void octep_device_setup_cn93_pf(struct octep_device *oct);
+void octep_device_setup_cnxk_pf(struct octep_device *oct);
 int octep_iq_process_completions(struct octep_iq *iq, u16 budget);
 int octep_oq_process_rx(struct octep_oq *oq, int budget);
 void octep_set_ethtool_ops(struct net_device *netdev);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
new file mode 100644
index 000000000000..abe02df8af11
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
@@ -0,0 +1,400 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell Octeon EP (EndPoint) Ethernet Driver
+ *
+ * Copyright (C) 2020 Marvell.
+ *
+ */
+
+#ifndef _OCTEP_REGS_CNXK_PF_H_
+#define _OCTEP_REGS_CNXK_PF_H_
+
+/* ############################ RST ######################### */
+#define    CNXK_RST_BOOT               0x000087E006001600ULL
+#define    CNXK_RST_CHIP_DOMAIN_W1S    0x000087E006001810ULL
+#define    CNXK_RST_CORE_DOMAIN_W1S    0x000087E006001820ULL
+#define    CNXK_RST_CORE_DOMAIN_W1C    0x000087E006001828ULL
+
+#define     CNXK_CONFIG_XPANSION_BAR             0x38
+#define     CNXK_CONFIG_PCIE_CAP                 0x70
+#define     CNXK_CONFIG_PCIE_DEVCAP              0x74
+#define     CNXK_CONFIG_PCIE_DEVCTL              0x78
+#define     CNXK_CONFIG_PCIE_LINKCAP             0x7C
+#define     CNXK_CONFIG_PCIE_LINKCTL             0x80
+#define     CNXK_CONFIG_PCIE_SLOTCAP             0x84
+#define     CNXK_CONFIG_PCIE_SLOTCTL             0x88
+
+#define     CNXK_PCIE_SRIOV_FDL                  0x188      /* 0x98 */
+#define     CNXK_PCIE_SRIOV_FDL_BIT_POS          0x10
+#define     CNXK_PCIE_SRIOV_FDL_MASK             0xFF
+
+#define     CNXK_CONFIG_PCIE_FLTMSK              0x720
+
+/* ################# Offsets of RING, EPF, MAC ######################### */
+#define    CNXK_RING_OFFSET                      (0x1ULL << 17)
+#define    CNXK_EPF_OFFSET                       (0x1ULL << 25)
+#define    CNXK_MAC_OFFSET                       (0x1ULL << 4)
+#define    CNXK_BIT_ARRAY_OFFSET                 (0x1ULL << 4)
+#define    CNXK_EPVF_RING_OFFSET                 (0x1ULL << 4)
+
+/* ################# Scratch Registers ######################### */
+#define    CNXK_SDP_EPF_SCRATCH                  0x209E0
+
+/* ################# Window Registers ######################### */
+#define    CNXK_SDP_WIN_WR_ADDR64                0x20000
+#define    CNXK_SDP_WIN_RD_ADDR64                0x20010
+#define    CNXK_SDP_WIN_WR_DATA64                0x20020
+#define    CNXK_SDP_WIN_WR_MASK_REG              0x20030
+#define    CNXK_SDP_WIN_RD_DATA64                0x20040
+
+#define    CNXK_SDP_MAC_NUMBER                   0x2C100
+
+/* ################# Global Previliged registers ######################### */
+#define    CNXK_SDP_EPF_RINFO                    0x209F0
+
+#define    CNXK_SDP_EPF_RINFO_SRN(val)           ((val) & 0x7F)
+#define    CNXK_SDP_EPF_RINFO_RPVF(val)          (((val) >> 32) & 0xF)
+#define    CNXK_SDP_EPF_RINFO_NVFS(val)          (((val) >> 48) & 0x7F)
+
+/* SDP Function select */
+#define    CNXK_SDP_FUNC_SEL_EPF_BIT_POS         7
+#define    CNXK_SDP_FUNC_SEL_FUNC_BIT_POS        0
+
+/* ##### RING IN (Into device from PCI: Tx Ring) REGISTERS #### */
+#define    CNXK_SDP_R_IN_CONTROL_START           0x10000
+#define    CNXK_SDP_R_IN_ENABLE_START            0x10010
+#define    CNXK_SDP_R_IN_INSTR_BADDR_START       0x10020
+#define    CNXK_SDP_R_IN_INSTR_RSIZE_START       0x10030
+#define    CNXK_SDP_R_IN_INSTR_DBELL_START       0x10040
+#define    CNXK_SDP_R_IN_CNTS_START              0x10050
+#define    CNXK_SDP_R_IN_INT_LEVELS_START        0x10060
+#define    CNXK_SDP_R_IN_PKT_CNT_START           0x10080
+#define    CNXK_SDP_R_IN_BYTE_CNT_START          0x10090
+
+#define    CNXK_SDP_R_IN_CONTROL(ring)		\
+	(CNXK_SDP_R_IN_CONTROL_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_ENABLE(ring)		\
+	(CNXK_SDP_R_IN_ENABLE_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_INSTR_BADDR(ring)	\
+	(CNXK_SDP_R_IN_INSTR_BADDR_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_INSTR_RSIZE(ring)	\
+	(CNXK_SDP_R_IN_INSTR_RSIZE_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_INSTR_DBELL(ring)	\
+	(CNXK_SDP_R_IN_INSTR_DBELL_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_CNTS(ring)		\
+	(CNXK_SDP_R_IN_CNTS_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_INT_LEVELS(ring)	\
+	(CNXK_SDP_R_IN_INT_LEVELS_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_PKT_CNT(ring)		\
+	(CNXK_SDP_R_IN_PKT_CNT_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_BYTE_CNT(ring)		\
+	(CNXK_SDP_R_IN_BYTE_CNT_START + ((ring) * CNXK_RING_OFFSET))
+
+/* Rings per Virtual Function */
+#define    CNXK_R_IN_CTL_RPVF_MASK	(0xF)
+#define    CNXK_R_IN_CTL_RPVF_POS	(48)
+
+/* Number of instructions to be read in one MAC read request.
+ * setting to Max value(4)
+ */
+#define    CNXK_R_IN_CTL_IDLE                    (0x1ULL << 28)
+#define    CNXK_R_IN_CTL_RDSIZE                  (0x3ULL << 25)
+#define    CNXK_R_IN_CTL_IS_64B                  (0x1ULL << 24)
+#define    CNXK_R_IN_CTL_D_NSR                   (0x1ULL << 8)
+#define    CNXK_R_IN_CTL_D_ESR                   (0x1ULL << 6)
+#define    CNXK_R_IN_CTL_D_ROR                   (0x1ULL << 5)
+#define    CNXK_R_IN_CTL_NSR                     (0x1ULL << 3)
+#define    CNXK_R_IN_CTL_ESR                     (0x1ULL << 1)
+#define    CNXK_R_IN_CTL_ROR                     (0x1ULL << 0)
+
+#define    CNXK_R_IN_CTL_MASK  (CNXK_R_IN_CTL_RDSIZE | CNXK_R_IN_CTL_IS_64B)
+
+/* ##### RING OUT (out from device to PCI host: Rx Ring) REGISTERS #### */
+#define    CNXK_SDP_R_OUT_CNTS_START              0x10100
+#define    CNXK_SDP_R_OUT_INT_LEVELS_START        0x10110
+#define    CNXK_SDP_R_OUT_SLIST_BADDR_START       0x10120
+#define    CNXK_SDP_R_OUT_SLIST_RSIZE_START       0x10130
+#define    CNXK_SDP_R_OUT_SLIST_DBELL_START       0x10140
+#define    CNXK_SDP_R_OUT_CONTROL_START           0x10150
+#define    CNXK_SDP_R_OUT_WMARK_START             0x10160
+#define    CNXK_SDP_R_OUT_ENABLE_START            0x10170
+#define    CNXK_SDP_R_OUT_PKT_CNT_START           0x10180
+#define    CNXK_SDP_R_OUT_BYTE_CNT_START          0x10190
+
+#define    CNXK_SDP_R_OUT_CONTROL(ring)          \
+	(CNXK_SDP_R_OUT_CONTROL_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_ENABLE(ring)          \
+	(CNXK_SDP_R_OUT_ENABLE_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_SLIST_BADDR(ring)          \
+	(CNXK_SDP_R_OUT_SLIST_BADDR_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_SLIST_RSIZE(ring)          \
+	(CNXK_SDP_R_OUT_SLIST_RSIZE_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_SLIST_DBELL(ring)          \
+	(CNXK_SDP_R_OUT_SLIST_DBELL_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_CNTS(ring)          \
+	(CNXK_SDP_R_OUT_CNTS_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_INT_LEVELS(ring)          \
+	(CNXK_SDP_R_OUT_INT_LEVELS_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_PKT_CNT(ring)          \
+	(CNXK_SDP_R_OUT_PKT_CNT_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_BYTE_CNT(ring)          \
+	(CNXK_SDP_R_OUT_BYTE_CNT_START + ((ring) * CNXK_RING_OFFSET))
+
+/*------------------ R_OUT Masks ----------------*/
+#define    CNXK_R_OUT_INT_LEVELS_BMODE            BIT_ULL(63)
+#define    CNXK_R_OUT_INT_LEVELS_TIMET            (32)
+
+#define    CNXK_R_OUT_CTL_IDLE                    BIT_ULL(40)
+#define    CNXK_R_OUT_CTL_ES_I                    BIT_ULL(34)
+#define    CNXK_R_OUT_CTL_NSR_I                   BIT_ULL(33)
+#define    CNXK_R_OUT_CTL_ROR_I                   BIT_ULL(32)
+#define    CNXK_R_OUT_CTL_ES_D                    BIT_ULL(30)
+#define    CNXK_R_OUT_CTL_NSR_D                   BIT_ULL(29)
+#define    CNXK_R_OUT_CTL_ROR_D                   BIT_ULL(28)
+#define    CNXK_R_OUT_CTL_ES_P                    BIT_ULL(26)
+#define    CNXK_R_OUT_CTL_NSR_P                   BIT_ULL(25)
+#define    CNXK_R_OUT_CTL_ROR_P                   BIT_ULL(24)
+#define    CNXK_R_OUT_CTL_IMODE                   BIT_ULL(23)
+
+/* ############### Interrupt Moderation Registers ############### */
+#define CNXK_SDP_R_IN_INT_MDRT_CTL0_START         0x10280
+#define CNXK_SDP_R_IN_INT_MDRT_CTL1_START         0x102A0
+#define CNXK_SDP_R_IN_INT_MDRT_DBG_START          0x102C0
+
+#define CNXK_SDP_R_OUT_INT_MDRT_CTL0_START        0x10380
+#define CNXK_SDP_R_OUT_INT_MDRT_CTL1_START        0x103A0
+#define CNXK_SDP_R_OUT_INT_MDRT_DBG_START         0x103C0
+
+#define CNXK_SDP_R_OUT_CNTS_ISM_START             0x10510
+#define CNXK_SDP_R_IN_CNTS_ISM_START              0x10520
+
+#define    CNXK_SDP_R_IN_INT_MDRT_CTL0(ring)		\
+	(CNXK_SDP_R_IN_INT_MDRT_CTL0_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_INT_MDRT_CTL1(ring)		\
+	(CNXK_SDP_R_IN_INT_MDRT_CTL1_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_INT_MDRT_DBG(ring)		\
+	(CNXK_SDP_R_IN_INT_MDRT_DBG_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_INT_MDRT_CTL0(ring)		\
+	(CNXK_SDP_R_OUT_INT_MDRT_CTL0_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_INT_MDRT_CTL1(ring)		\
+	(CNXK_SDP_R_OUT_INT_MDRT_CTL1_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_INT_MDRT_DBG(ring)		\
+	(CNXK_SDP_R_OUT_INT_MDRT_DBG_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_CNTS_ISM(ring)          \
+	(CNXK_SDP_R_OUT_CNTS_ISM_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_CNTS_ISM(ring)          \
+	(CNXK_SDP_R_IN_CNTS_ISM_START + ((ring) * CNXK_RING_OFFSET))
+
+/* ##################### Mail Box Registers ########################## */
+/* INT register for VF. when a MBOX write from PF happed to a VF,
+ * corresponding bit will be set in this register as well as in
+ * PF_VF_INT register.
+ *
+ * This is a RO register, the int can be cleared by writing 1 to PF_VF_INT
+ */
+/* Basically first 3 are from PF to VF. The last one is data from VF to PF */
+#define    CNXK_SDP_R_MBOX_PF_VF_DATA_START       0x10210
+#define    CNXK_SDP_R_MBOX_PF_VF_INT_START        0x10220
+#define    CNXK_SDP_R_MBOX_VF_PF_DATA_START       0x10230
+
+#define    CNXK_SDP_R_MBOX_PF_VF_DATA(ring)		\
+	(CNXK_SDP_R_MBOX_PF_VF_DATA_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_MBOX_PF_VF_INT(ring)		\
+	(CNXK_SDP_R_MBOX_PF_VF_INT_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_MBOX_VF_PF_DATA(ring)		\
+	(CNXK_SDP_R_MBOX_VF_PF_DATA_START + ((ring) * CNXK_RING_OFFSET))
+
+/* ##################### Interrupt Registers ########################## */
+#define	   CNXK_SDP_R_ERR_TYPE_START	          0x10400
+
+#define    CNXK_SDP_R_ERR_TYPE(ring)		\
+	(CNXK_SDP_R_ERR_TYPE_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_MBOX_ISM_START              0x10500
+#define    CNXK_SDP_R_OUT_CNTS_ISM_START          0x10510
+#define    CNXK_SDP_R_IN_CNTS_ISM_START           0x10520
+
+#define    CNXK_SDP_R_MBOX_ISM(ring)		\
+	(CNXK_SDP_R_MBOX_ISM_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_OUT_CNTS_ISM(ring)	\
+	(CNXK_SDP_R_OUT_CNTS_ISM_START + ((ring) * CNXK_RING_OFFSET))
+
+#define    CNXK_SDP_R_IN_CNTS_ISM(ring)		\
+	(CNXK_SDP_R_IN_CNTS_ISM_START + ((ring) * CNXK_RING_OFFSET))
+
+#define	   CNXK_SDP_EPF_MBOX_RINT_START	          0x20100
+#define	   CNXK_SDP_EPF_MBOX_RINT_W1S_START	  0x20120
+#define	   CNXK_SDP_EPF_MBOX_RINT_ENA_W1C_START   0x20140
+#define	   CNXK_SDP_EPF_MBOX_RINT_ENA_W1S_START   0x20160
+
+#define	   CNXK_SDP_EPF_VFIRE_RINT_START          0x20180
+#define	   CNXK_SDP_EPF_VFIRE_RINT_W1S_START      0x201A0
+#define	   CNXK_SDP_EPF_VFIRE_RINT_ENA_W1C_START  0x201C0
+#define	   CNXK_SDP_EPF_VFIRE_RINT_ENA_W1S_START  0x201E0
+
+#define	   CNXK_SDP_EPF_IRERR_RINT                0x20200
+#define	   CNXK_SDP_EPF_IRERR_RINT_W1S            0x20210
+#define	   CNXK_SDP_EPF_IRERR_RINT_ENA_W1C        0x20220
+#define	   CNXK_SDP_EPF_IRERR_RINT_ENA_W1S        0x20230
+
+#define	   CNXK_SDP_EPF_VFORE_RINT_START          0x20240
+#define	   CNXK_SDP_EPF_VFORE_RINT_W1S_START      0x20260
+#define	   CNXK_SDP_EPF_VFORE_RINT_ENA_W1C_START  0x20280
+#define	   CNXK_SDP_EPF_VFORE_RINT_ENA_W1S_START  0x202A0
+
+#define	   CNXK_SDP_EPF_ORERR_RINT                0x20320
+#define	   CNXK_SDP_EPF_ORERR_RINT_W1S            0x20330
+#define	   CNXK_SDP_EPF_ORERR_RINT_ENA_W1C        0x20340
+#define	   CNXK_SDP_EPF_ORERR_RINT_ENA_W1S        0x20350
+
+#define	   CNXK_SDP_EPF_OEI_RINT                  0x20400
+#define	   CNXK_SDP_EPF_OEI_RINT_W1S              0x20500
+#define	   CNXK_SDP_EPF_OEI_RINT_ENA_W1C          0x20600
+#define	   CNXK_SDP_EPF_OEI_RINT_ENA_W1S          0x20700
+
+#define	   CNXK_SDP_EPF_DMA_RINT                  0x20800
+#define	   CNXK_SDP_EPF_DMA_RINT_W1S              0x20810
+#define	   CNXK_SDP_EPF_DMA_RINT_ENA_W1C          0x20820
+#define	   CNXK_SDP_EPF_DMA_RINT_ENA_W1S          0x20830
+
+#define	   CNXK_SDP_EPF_DMA_INT_LEVEL_START	    0x20840
+#define	   CNXK_SDP_EPF_DMA_CNT_START	            0x20860
+#define	   CNXK_SDP_EPF_DMA_TIM_START	            0x20880
+
+#define	   CNXK_SDP_EPF_MISC_RINT                 0x208A0
+#define	   CNXK_SDP_EPF_MISC_RINT_W1S	            0x208B0
+#define	   CNXK_SDP_EPF_MISC_RINT_ENA_W1C         0x208C0
+#define	   CNXK_SDP_EPF_MISC_RINT_ENA_W1S         0x208D0
+
+#define	   CNXK_SDP_EPF_DMA_VF_RINT_START           0x208E0
+#define	   CNXK_SDP_EPF_DMA_VF_RINT_W1S_START       0x20900
+#define	   CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1C_START   0x20920
+#define	   CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1S_START   0x20940
+
+#define	   CNXK_SDP_EPF_PP_VF_RINT_START            0x20960
+#define	   CNXK_SDP_EPF_PP_VF_RINT_W1S_START        0x20980
+#define	   CNXK_SDP_EPF_PP_VF_RINT_ENA_W1C_START    0x209A0
+#define	   CNXK_SDP_EPF_PP_VF_RINT_ENA_W1S_START    0x209C0
+
+#define	   CNXK_SDP_EPF_MBOX_RINT(index)		\
+		(CNXK_SDP_EPF_MBOX_RINT_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_MBOX_RINT_W1S(index)		\
+		(CNXK_SDP_EPF_MBOX_RINT_W1S_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_MBOX_RINT_ENA_W1C(index)	\
+		(CNXK_SDP_EPF_MBOX_RINT_ENA_W1C_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_MBOX_RINT_ENA_W1S(index)	\
+		(CNXK_SDP_EPF_MBOX_RINT_ENA_W1S_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+
+#define	   CNXK_SDP_EPF_VFIRE_RINT(index)		\
+		(CNXK_SDP_EPF_VFIRE_RINT_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_VFIRE_RINT_W1S(index)		\
+		(CNXK_SDP_EPF_VFIRE_RINT_W1S_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_VFIRE_RINT_ENA_W1C(index)	\
+		(CNXK_SDP_EPF_VFIRE_RINT_ENA_W1C_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_VFIRE_RINT_ENA_W1S(index)	\
+		(CNXK_SDP_EPF_VFIRE_RINT_ENA_W1S_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+
+#define	   CNXK_SDP_EPF_VFORE_RINT(index)		\
+		(CNXK_SDP_EPF_VFORE_RINT_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_VFORE_RINT_W1S(index)		\
+		(CNXK_SDP_EPF_VFORE_RINT_W1S_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_VFORE_RINT_ENA_W1C(index)	\
+		(CNXK_SDP_EPF_VFORE_RINT_ENA_W1C_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_VFORE_RINT_ENA_W1S(index)	\
+		(CNXK_SDP_EPF_VFORE_RINT_ENA_W1S_START + ((index) * CNXK_BIT_ARRAY_OFFSET))
+
+#define	   CNXK_SDP_EPF_DMA_VF_RINT(index)		\
+		(CNXK_SDP_EPF_DMA_VF_RINT_START + ((index) + CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_DMA_VF_RINT_W1S(index)		\
+		(CNXK_SDP_EPF_DMA_VF_RINT_W1S_START + ((index) + CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1C(index)	\
+		(CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1C_START + ((index) + CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1S(index)	\
+		(CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1S_START + ((index) + CNXK_BIT_ARRAY_OFFSET))
+
+#define	   CNXK_SDP_EPF_PP_VF_RINT(index)		\
+		(CNXK_SDP_EPF_PP_VF_RINT_START + ((index) + CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_PP_VF_RINT_W1S(index)		\
+		(CNXK_SDP_EPF_PP_VF_RINT_W1S_START + ((index) + CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_PP_VF_RINT_ENA_W1C(index)	\
+		(CNXK_SDP_EPF_PP_VF_RINT_ENA_W1C_START + ((index) + CNXK_BIT_ARRAY_OFFSET))
+#define	   CNXK_SDP_EPF_PP_VF_RINT_ENA_W1S(index)	\
+		(CNXK_SDP_EPF_PP_VF_RINT_ENA_W1S_START + ((index) + CNXK_BIT_ARRAY_OFFSET))
+
+/*------------------ Interrupt Masks ----------------*/
+#define	   CNXK_INTR_R_SEND_ISM       BIT_ULL(63)
+#define	   CNXK_INTR_R_OUT_INT        BIT_ULL(62)
+#define    CNXK_INTR_R_IN_INT         BIT_ULL(61)
+#define    CNXK_INTR_R_MBOX_INT       BIT_ULL(60)
+#define    CNXK_INTR_R_RESEND         BIT_ULL(59)
+#define    CNXK_INTR_R_CLR_TIM        BIT_ULL(58)
+
+/* ####################### Ring Mapping Registers ################################## */
+#define    CNXK_SDP_EPVF_RING_START          0x26000
+#define    CNXK_SDP_IN_RING_TB_MAP_START     0x28000
+#define    CNXK_SDP_IN_RATE_LIMIT_START      0x2A000
+#define    CNXK_SDP_MAC_PF_RING_CTL_START    0x2C000
+
+#define	   CNXK_SDP_EPVF_RING(ring)		\
+		(CNXK_SDP_EPVF_RING_START + ((ring) * CNXK_EPVF_RING_OFFSET))
+#define	   CNXK_SDP_IN_RING_TB_MAP(ring)	\
+		(CNXK_SDP_N_RING_TB_MAP_START + ((ring) * CNXK_EPVF_RING_OFFSET))
+#define	   CNXK_SDP_IN_RATE_LIMIT(ring)		\
+		(CNXK_SDP_IN_RATE_LIMIT_START + ((ring) * CNXK_EPVF_RING_OFFSET))
+#define	   CNXK_SDP_MAC_PF_RING_CTL(mac)	\
+		(CNXK_SDP_MAC_PF_RING_CTL_START + ((mac) * CNXK_MAC_OFFSET))
+
+#define    CNXK_SDP_MAC_PF_RING_CTL_NPFS(val)  ((val) & 0x3)
+#define    CNXK_SDP_MAC_PF_RING_CTL_SRN(val)   (((val) >> 8) & 0x7F)
+#define    CNXK_SDP_MAC_PF_RING_CTL_RPPF(val)  (((val) >> 16) & 0x3F)
+
+/* Number of non-queue interrupts in CNXKxx */
+#define    CNXK_NUM_NON_IOQ_INTR    32
+
+/* bit 0 for control mbox interrupt */
+#define CNXK_SDP_EPF_OEI_RINT_DATA_BIT_MBOX	BIT_ULL(0)
+/* bit 1 for firmware heartbeat interrupt */
+#define CNXK_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT	BIT_ULL(1)
+#define FW_STATUS_RUNNING      2ULL
+#define CNXK_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)      ({ typeof(offset) _off = (offset); \
+							  ((0x8e0000008000 | \
+							    (uint64_t)(pem) << 36 \
+							    | (pf) << 18 \
+							    | ((_off >> 16) & 1) << 16 \
+							    | (_off >> 3) << 3) \
+							   + (((_off >> 2) & 1) << 2)); \
+							})
+
+/* Register defines for use with CNXK_PEMX_PFX_CSX_PFCFGX */
+#define CNXK_PCIEEP_VSECST_CTL  0x418
+
+#define CNXK_PEM_BAR4_INDEX		7
+#define CNXK_PEM_BAR4_INDEX_SIZE	0x400000ULL
+#define CNXK_PEM_BAR4_INDEX_OFFSET	(CNXK_PEM_BAR4_INDEX * CNXK_PEM_BAR4_INDEX_SIZE)
+
+#endif /* _OCTEP_REGS_CNXK_PF_H_ */
-- 
2.25.1

