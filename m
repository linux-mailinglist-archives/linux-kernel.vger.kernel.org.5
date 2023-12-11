Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E5580C161
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjLKGeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjLKGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:34:07 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94729CD;
        Sun, 10 Dec 2023 22:34:11 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BAMu06o008719;
        Sun, 10 Dec 2023 22:34:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        pfpt0220; bh=jS8Qj+djVaM2sOZZffO3dGjD/okfa25mqnSO3U73pRE=; b=Tkw
        mU0sj9TrJPFRYCQf09uh09mdMFT5iJY++S8pTzmk6GJvEhp/NsDO0mJPgFID6f4l
        D33+4aUkjWcCq9m7uOlLz1SgnpnoC4rAIWXbEyoXODD24pybCMsmBDiraNyWpMcM
        SDye3gac58WVZTXBnRoIZWdmU/oAjeBdPiS4vZ7AJB39KSPftFPB5zOi2ROYxtr9
        sz5PWlzShOigi/RbP5JbGRvFImevS9szpj6YB8kSjGRXL6IjivnzatU0tlExDmhQ
        kRnQg5jPpFtvKQkU93x/pBs5/o5F0iMCw2zOZw2/Mhf5WKSnb3swP3rKLEidbt4m
        NHn3NbVRK3+1fg9sT3Q==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uw8xqa5ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 10 Dec 2023 22:34:03 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Dec
 2023 22:34:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 10 Dec 2023 22:34:01 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 903383F7096;
        Sun, 10 Dec 2023 22:34:01 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "Sathesh Edara" <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v3] octeon_ep: add PF-VF mailbox communication
Date:   Sun, 10 Dec 2023 22:33:52 -0800
Message-ID: <20231211063355.2630028-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211063355.2630028-1-srasheed@marvell.com>
References: <20231211063355.2630028-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lBfF6XgyswvUsMEUu5DAAYGQXNJ88hrf
X-Proofpoint-ORIG-GUID: lBfF6XgyswvUsMEUu5DAAYGQXNJ88hrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement mailbox communication between PF and VFs.
PF-VF mailbox is used for all control commands from VF to PF and
asynchronous notification messages from PF to VF.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Corrected error cleanup logic for PF-VF mbox setup
  - Removed double inclusion of types.h header file in octep_pfvf_mbox.c

V2: https://lore.kernel.org/all/20231209081450.2613561-2-srasheed@marvell.com/
  - Remove unused variable

V1: https://lore.kernel.org/all/20231208070352.2606192-2-srasheed@marvell.com/

 .../net/ethernet/marvell/octeon_ep/Makefile   |   2 +-
 .../marvell/octeon_ep/octep_cn9k_pf.c         |  59 ++-
 .../marvell/octeon_ep/octep_cnxk_pf.c         |  46 ++-
 .../marvell/octeon_ep/octep_ctrl_mbox.h       |   4 +-
 .../ethernet/marvell/octeon_ep/octep_main.c   |  83 ++++-
 .../ethernet/marvell/octeon_ep/octep_main.h   |  45 ++-
 .../marvell/octeon_ep/octep_pfvf_mbox.c       | 335 ++++++++++++++++++
 .../marvell/octeon_ep/octep_pfvf_mbox.h       | 143 ++++++++
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |   9 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  13 +
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  24 +-
 11 files changed, 714 insertions(+), 49 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h

diff --git a/drivers/net/ethernet/marvell/octeon_ep/Makefile b/drivers/net/ethernet/marvell/octeon_ep/Makefile
index 02a4a21bc298..62162ed63f34 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/Makefile
+++ b/drivers/net/ethernet/marvell/octeon_ep/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_OCTEON_EP) += octeon_ep.o
 
 octeon_ep-y := octep_main.o octep_cn9k_pf.o octep_tx.o octep_rx.o \
 	       octep_ethtool.o octep_ctrl_mbox.o octep_ctrl_net.o \
-	       octep_cnxk_pf.o
+	       octep_pfvf_mbox.o octep_cnxk_pf.o
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index 9209f1ec1b52..b5805969404f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -362,16 +362,55 @@ static void octep_setup_mbox_regs_cn93_pf(struct octep_device *oct, int q_no)
 {
 	struct octep_mbox *mbox = oct->mbox[q_no];
 
-	mbox->q_no = q_no;
-
-	/* PF mbox interrupt reg */
-	mbox->mbox_int_reg = oct->mmio[0].hw_addr + CN93_SDP_EPF_MBOX_RINT(0);
-
 	/* PF to VF DATA reg. PF writes into this reg */
-	mbox->mbox_write_reg = oct->mmio[0].hw_addr + CN93_SDP_R_MBOX_PF_VF_DATA(q_no);
+	mbox->pf_vf_data_reg = oct->mmio[0].hw_addr + CN93_SDP_MBOX_PF_VF_DATA(q_no);
 
 	/* VF to PF DATA reg. PF reads from this reg */
-	mbox->mbox_read_reg = oct->mmio[0].hw_addr + CN93_SDP_R_MBOX_VF_PF_DATA(q_no);
+	mbox->vf_pf_data_reg = oct->mmio[0].hw_addr + CN93_SDP_MBOX_VF_PF_DATA(q_no);
+}
+
+/* Poll for mailbox messages from VF */
+static void octep_poll_pfvf_mailbox(struct octep_device *oct)
+{
+	u32 vf, active_vfs, active_rings_per_vf, vf_mbox_queue;
+	u64 reg0, reg1;
+
+	reg0 = octep_read_csr64(oct, CN93_SDP_EPF_MBOX_RINT(0));
+	reg1 = octep_read_csr64(oct, CN93_SDP_EPF_MBOX_RINT(1));
+	if (reg0 || reg1) {
+		active_vfs = CFG_GET_ACTIVE_VFS(oct->conf);
+		active_rings_per_vf = CFG_GET_ACTIVE_RPVF(oct->conf);
+		for (vf = 0; vf < active_vfs; vf++) {
+			vf_mbox_queue = vf * active_rings_per_vf;
+
+			if (vf_mbox_queue < 64) {
+				if (!(reg0 & (0x1UL << vf_mbox_queue)))
+					continue;
+			} else {
+				if (!(reg1 & (0x1UL << (vf_mbox_queue - 64))))
+					continue;
+			}
+
+			if (!oct->mbox[vf_mbox_queue]) {
+				dev_err(&oct->pdev->dev, "bad mbox vf %d\n", vf);
+				continue;
+			}
+			schedule_work(&oct->mbox[vf_mbox_queue]->wk.work);
+		}
+		if (reg0)
+			octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT(0), reg0);
+		if (reg1)
+			octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT(1), reg1);
+	}
+}
+
+/* PF-VF mailbox interrupt handler */
+static irqreturn_t octep_pfvf_mbox_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+
+	octep_poll_pfvf_mailbox(oct);
+	return IRQ_HANDLED;
 }
 
 /* Poll OEI events like heartbeat */
@@ -403,6 +442,7 @@ static irqreturn_t octep_oei_intr_handler_cn93_pf(void *dev)
  */
 static void octep_poll_non_ioq_interrupts_cn93_pf(struct octep_device *oct)
 {
+	octep_poll_pfvf_mailbox(oct);
 	octep_poll_oei_cn93_pf(oct);
 }
 
@@ -646,6 +686,8 @@ static void octep_enable_interrupts_cn93_pf(struct octep_device *oct)
 
 	octep_write_csr64(oct, CN93_SDP_EPF_MISC_RINT_ENA_W1S, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_DMA_RINT_ENA_W1S, intr_mask);
+	octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT_ENA_W1S(0), -1ULL);
+	octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT_ENA_W1S(1), -1ULL);
 
 	octep_write_csr64(oct, CN93_SDP_EPF_DMA_VF_RINT_ENA_W1S(0), -1ULL);
 	octep_write_csr64(oct, CN93_SDP_EPF_PP_VF_RINT_ENA_W1S(0), -1ULL);
@@ -672,6 +714,8 @@ static void octep_disable_interrupts_cn93_pf(struct octep_device *oct)
 
 	octep_write_csr64(oct, CN93_SDP_EPF_MISC_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_DMA_RINT_ENA_W1C, intr_mask);
+	octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT_ENA_W1C(0), -1ULL);
+	octep_write_csr64(oct, CN93_SDP_EPF_MBOX_RINT_ENA_W1C(1), -1ULL);
 
 	octep_write_csr64(oct, CN93_SDP_EPF_DMA_VF_RINT_ENA_W1C(0), -1ULL);
 	octep_write_csr64(oct, CN93_SDP_EPF_PP_VF_RINT_ENA_W1C(0), -1ULL);
@@ -807,6 +851,7 @@ void octep_device_setup_cn93_pf(struct octep_device *oct)
 	oct->hw_ops.setup_oq_regs = octep_setup_oq_regs_cn93_pf;
 	oct->hw_ops.setup_mbox_regs = octep_setup_mbox_regs_cn93_pf;
 
+	oct->hw_ops.mbox_intr_handler = octep_pfvf_mbox_intr_handler_cn93_pf;
 	oct->hw_ops.oei_intr_handler = octep_oei_intr_handler_cn93_pf;
 	oct->hw_ops.ire_intr_handler = octep_ire_intr_handler_cn93_pf;
 	oct->hw_ops.ore_intr_handler = octep_ore_intr_handler_cn93_pf;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 098a0c5c4d1c..5de0b5ecbc5f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -392,16 +392,44 @@ static void octep_setup_mbox_regs_cnxk_pf(struct octep_device *oct, int q_no)
 {
 	struct octep_mbox *mbox = oct->mbox[q_no];
 
-	mbox->q_no = q_no;
-
-	/* PF mbox interrupt reg */
-	mbox->mbox_int_reg = oct->mmio[0].hw_addr + CNXK_SDP_EPF_MBOX_RINT(0);
-
 	/* PF to VF DATA reg. PF writes into this reg */
-	mbox->mbox_write_reg = oct->mmio[0].hw_addr + CNXK_SDP_R_MBOX_PF_VF_DATA(q_no);
+	mbox->pf_vf_data_reg = oct->mmio[0].hw_addr + CNXK_SDP_MBOX_PF_VF_DATA(q_no);
 
 	/* VF to PF DATA reg. PF reads from this reg */
-	mbox->mbox_read_reg = oct->mmio[0].hw_addr + CNXK_SDP_R_MBOX_VF_PF_DATA(q_no);
+	mbox->vf_pf_data_reg = oct->mmio[0].hw_addr + CNXK_SDP_MBOX_VF_PF_DATA(q_no);
+}
+
+static void octep_poll_pfvf_mailbox_cnxk_pf(struct octep_device *oct)
+{
+	u32 vf, active_vfs, active_rings_per_vf, vf_mbox_queue;
+	u64 reg0;
+
+	reg0 = octep_read_csr64(oct, CNXK_SDP_EPF_MBOX_RINT(0));
+	if (reg0) {
+		active_vfs = CFG_GET_ACTIVE_VFS(oct->conf);
+		active_rings_per_vf = CFG_GET_ACTIVE_RPVF(oct->conf);
+		for (vf = 0; vf < active_vfs; vf++) {
+			vf_mbox_queue = vf * active_rings_per_vf;
+			if (!(reg0 & (0x1UL << vf_mbox_queue)))
+				continue;
+
+			if (!oct->mbox[vf_mbox_queue]) {
+				dev_err(&oct->pdev->dev, "bad mbox vf %d\n", vf);
+				continue;
+			}
+			schedule_work(&oct->mbox[vf_mbox_queue]->wk.work);
+		}
+		if (reg0)
+			octep_write_csr64(oct, CNXK_SDP_EPF_MBOX_RINT(0), reg0);
+	}
+}
+
+static irqreturn_t octep_pfvf_mbox_intr_handler_cnxk_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+
+	octep_poll_pfvf_mailbox_cnxk_pf(oct);
+	return IRQ_HANDLED;
 }
 
 /* Poll OEI events like heartbeat */
@@ -435,6 +463,7 @@ static irqreturn_t octep_oei_intr_handler_cnxk_pf(void *dev)
  */
 static void octep_poll_non_ioq_interrupts_cnxk_pf(struct octep_device *oct)
 {
+	octep_poll_pfvf_mailbox_cnxk_pf(oct);
 	octep_poll_oei_cnxk_pf(oct);
 }
 
@@ -682,6 +711,7 @@ static void octep_enable_interrupts_cnxk_pf(struct octep_device *oct)
 
 	octep_write_csr64(oct, CNXK_SDP_EPF_MISC_RINT_ENA_W1S, intr_mask);
 	octep_write_csr64(oct, CNXK_SDP_EPF_DMA_RINT_ENA_W1S, intr_mask);
+	octep_write_csr64(oct, CNXK_SDP_EPF_MBOX_RINT_ENA_W1S(0), -1ULL);
 
 	octep_write_csr64(oct, CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1S(0), -1ULL);
 	octep_write_csr64(oct, CNXK_SDP_EPF_PP_VF_RINT_ENA_W1S(0), -1ULL);
@@ -708,6 +738,7 @@ static void octep_disable_interrupts_cnxk_pf(struct octep_device *oct)
 
 	octep_write_csr64(oct, CNXK_SDP_EPF_MISC_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CNXK_SDP_EPF_DMA_RINT_ENA_W1C, intr_mask);
+	octep_write_csr64(oct, CNXK_SDP_EPF_MBOX_RINT_ENA_W1C(0), -1ULL);
 
 	octep_write_csr64(oct, CNXK_SDP_EPF_DMA_VF_RINT_ENA_W1C(0), -1ULL);
 	octep_write_csr64(oct, CNXK_SDP_EPF_PP_VF_RINT_ENA_W1C(0), -1ULL);
@@ -843,6 +874,7 @@ void octep_device_setup_cnxk_pf(struct octep_device *oct)
 	oct->hw_ops.setup_oq_regs = octep_setup_oq_regs_cnxk_pf;
 	oct->hw_ops.setup_mbox_regs = octep_setup_mbox_regs_cnxk_pf;
 
+	oct->hw_ops.mbox_intr_handler = octep_pfvf_mbox_intr_handler_cnxk_pf;
 	oct->hw_ops.oei_intr_handler = octep_oei_intr_handler_cnxk_pf;
 	oct->hw_ops.ire_intr_handler = octep_ire_intr_handler_cnxk_pf;
 	oct->hw_ops.ore_intr_handler = octep_ore_intr_handler_cnxk_pf;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.h
index 7f8135788efc..6da32d40f926 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_mbox.h
@@ -16,10 +16,12 @@
  * |reserved (4 bytes)                         |
  * |-------------------------------------------|
  * |host version (8 bytes)                     |
+ * |    low 32 bits                            |
  * |host status (8 bytes)                      |
  * |host reserved (104 bytes)                  |
  * |-------------------------------------------|
- * |fw version (8 bytes)                       |
+ * |fw version's (8 bytes)                     |
+ * |    min=high 32 bits, max=low 32 bits      |
  * |fw status (8 bytes)                        |
  * |fw reserved (104 bytes)                    |
  * |===========================================|
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index bbfc06581e77..4ebf4b68d629 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -16,6 +16,7 @@
 #include "octep_config.h"
 #include "octep_main.h"
 #include "octep_ctrl_net.h"
+#include "octep_pfvf_mbox.h"
 
 #define OCTEP_INTR_POLL_TIME_MSECS    100
 struct workqueue_struct *octep_wq;
@@ -159,6 +160,21 @@ static void octep_disable_msix(struct octep_device *oct)
 	dev_info(&oct->pdev->dev, "Disabled MSI-X\n");
 }
 
+/**
+ * octep_mbox_intr_handler() - common handler for pfvf mbox interrupts.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for pfvf mbox interrupts.
+ */
+static irqreturn_t octep_mbox_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.mbox_intr_handler(oct);
+}
+
 /**
  * octep_oei_intr_handler() - common handler for output endpoint interrupts.
  *
@@ -362,8 +378,12 @@ static int octep_request_irqs(struct octep_device *oct)
 
 		snprintf(irq_name, OCTEP_MSIX_NAME_SIZE,
 			 "%s-%s", netdev->name, non_ioq_msix_names[i]);
-		if (!strncmp(non_ioq_msix_names[i], "epf_oei_rint",
-			     strlen("epf_oei_rint"))) {
+		if (!strncmp(non_ioq_msix_names[i], "epf_mbox_rint", strlen("epf_mbox_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_mbox_intr_handler, 0,
+					  irq_name, oct);
+		} else if (!strncmp(non_ioq_msix_names[i], "epf_oei_rint",
+			   strlen("epf_oei_rint"))) {
 			ret = request_irq(msix_entry->vector,
 					  octep_oei_intr_handler, 0,
 					  irq_name, oct);
@@ -1315,6 +1335,7 @@ static void octep_device_cleanup(struct octep_device *oct)
 		oct->mbox[i] = NULL;
 	}
 
+	octep_delete_pfvf_mbox(oct);
 	octep_ctrl_net_uninit(oct);
 	cancel_delayed_work_sync(&oct->hb_task);
 
@@ -1411,6 +1432,12 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_octep_config;
 	}
 
+	err = octep_setup_pfvf_mbox(octep_dev);
+	if (err) {
+		dev_err(&pdev->dev, "PF-VF mailbox setup failed\n");
+		goto register_dev_err;
+	}
+
 	octep_ctrl_net_get_info(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
 				&octep_dev->conf->fw_info);
 	dev_info(&octep_dev->pdev->dev, "Heartbeat interval %u msecs Heartbeat miss count %u\n",
@@ -1482,6 +1509,21 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return err;
 }
 
+static int octep_sriov_disable(struct octep_device *oct)
+{
+	struct pci_dev *pdev = oct->pdev;
+
+	if (pci_vfs_assigned(oct->pdev)) {
+		dev_warn(&pdev->dev, "Can't disable SRIOV while VFs are assigned\n");
+		return -EPERM;
+	}
+
+	pci_disable_sriov(pdev);
+	CFG_GET_ACTIVE_VFS(oct->conf) = 0;
+
+	return 0;
+}
+
 /**
  * octep_remove() - Remove Octeon PCI device from driver control.
  *
@@ -1499,6 +1541,7 @@ static void octep_remove(struct pci_dev *pdev)
 		return;
 
 	netdev = oct->netdev;
+	octep_sriov_disable(oct);
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
 
@@ -1509,11 +1552,47 @@ static void octep_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static int octep_sriov_enable(struct octep_device *oct, int num_vfs)
+{
+	struct pci_dev *pdev = oct->pdev;
+	int err;
+
+	CFG_GET_ACTIVE_VFS(oct->conf) = num_vfs;
+	err = pci_enable_sriov(pdev, num_vfs);
+	if (err) {
+		dev_warn(&pdev->dev, "Failed to enable SRIOV err=%d\n", err);
+		CFG_GET_ACTIVE_VFS(oct->conf) = 0;
+		return err;
+	}
+
+	return num_vfs;
+}
+
+static int octep_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct octep_device *oct = pci_get_drvdata(pdev);
+	int max_nvfs;
+
+	if (num_vfs == 0)
+		return octep_sriov_disable(oct);
+
+	max_nvfs = CFG_GET_MAX_VFS(oct->conf);
+
+	if (num_vfs > max_nvfs) {
+		dev_err(&pdev->dev, "Invalid VF count Max supported VFs = %d\n",
+			max_nvfs);
+		return -EINVAL;
+	}
+
+	return octep_sriov_enable(oct, num_vfs);
+}
+
 static struct pci_driver octep_driver = {
 	.name = OCTEP_DRV_NAME,
 	.id_table = octep_pci_id_tbl,
 	.probe = octep_probe,
 	.remove = octep_remove,
+	.sriov_configure = octep_sriov_configure,
 };
 
 /**
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index 2cb93d425744..3223bb6f95ea 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -80,6 +80,7 @@ struct octep_hw_ops {
 	void (*setup_oq_regs)(struct octep_device *oct, int q);
 	void (*setup_mbox_regs)(struct octep_device *oct, int mbox);
 
+	irqreturn_t (*mbox_intr_handler)(void *ioq_vector);
 	irqreturn_t (*oei_intr_handler)(void *ioq_vector);
 	irqreturn_t (*ire_intr_handler)(void *ioq_vector);
 	irqreturn_t (*ore_intr_handler)(void *ioq_vector);
@@ -118,28 +119,27 @@ struct octep_mbox_data {
 	u64 *data;
 };
 
+#define MAX_VF_PF_MBOX_DATA_SIZE 384
+/* wrappers around work structs */
+struct octep_pfvf_mbox_wk {
+	struct work_struct work;
+	void *ctxptr;
+	u64 ctxul;
+};
+
 /* Octeon device mailbox */
 struct octep_mbox {
-	/* A spinlock to protect access to this q_mbox. */
-	spinlock_t lock;
-
-	u32 q_no;
-	u32 state;
-
-	/* SLI_MAC_PF_MBOX_INT for PF, SLI_PKT_MBOX_INT for VF. */
-	u8 __iomem *mbox_int_reg;
-
-	/* SLI_PKT_PF_VF_MBOX_SIG(0) for PF,
-	 * SLI_PKT_PF_VF_MBOX_SIG(1) for VF.
-	 */
-	u8 __iomem *mbox_write_reg;
-
-	/* SLI_PKT_PF_VF_MBOX_SIG(1) for PF,
-	 * SLI_PKT_PF_VF_MBOX_SIG(0) for VF.
-	 */
-	u8 __iomem *mbox_read_reg;
-
+	/* A mutex to protect access to this q_mbox. */
+	struct mutex lock;
+	u32 vf_id;
+	u32 config_data_index;
+	u32 message_len;
+	u8 __iomem *pf_vf_data_reg;
+	u8 __iomem *vf_pf_data_reg;
+	struct octep_pfvf_mbox_wk wk;
+	struct octep_device *oct;
 	struct octep_mbox_data mbox_data;
+	u8 config_data[MAX_VF_PF_MBOX_DATA_SIZE];
 };
 
 /* Tx/Rx queue vector per interrupt. */
@@ -217,6 +217,11 @@ struct octep_iface_link_info {
 	u8  oper_up;
 };
 
+/* The Octeon VF device specific info data structure.*/
+struct octep_pfvf_info {
+	u8 mac_addr[ETH_ALEN];
+};
+
 /* The Octeon device specific private data structure.
  * Each Octeon device has this structure to represent all its components.
  */
@@ -282,6 +287,8 @@ struct octep_device {
 
 	/* Mailbox to talk to VFs */
 	struct octep_mbox *mbox[OCTEP_MAX_VF];
+	/* VFs info */
+	struct octep_pfvf_info vf_info[OCTEP_MAX_VF];
 
 	/* Work entry to handle Tx timeout */
 	struct work_struct tx_timeout_task;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
new file mode 100644
index 000000000000..0557c138060f
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell Octeon EP (EndPoint) Ethernet Driver
+ *
+ * Copyright (C) 2020 Marvell.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mutex.h>
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/etherdevice.h>
+
+#include "octep_config.h"
+#include "octep_main.h"
+#include "octep_pfvf_mbox.h"
+#include "octep_ctrl_net.h"
+
+static void octep_pfvf_validate_version(struct octep_device *oct,  u32 vf_id,
+					union octep_pfvf_mbox_word cmd,
+					union octep_pfvf_mbox_word *rsp)
+{
+	u32 vf_version = (u32)cmd.s_version.version;
+
+	if (vf_version <= OCTEP_PFVF_MBOX_VERSION_V1)
+		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+	else
+		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+}
+
+static void octep_pfvf_get_link_status(struct octep_device *oct, u32 vf_id,
+				       union octep_pfvf_mbox_word cmd,
+				       union octep_pfvf_mbox_word *rsp)
+{
+	int status;
+
+	status = octep_ctrl_net_get_link_status(oct, vf_id);
+	if (status < 0) {
+		rsp->s_link_status.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		dev_err(&oct->pdev->dev, "Get VF link status failed via host control Mbox\n");
+		return;
+	}
+	rsp->s_link_status.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+	rsp->s_link_status.status = status;
+}
+
+static void octep_pfvf_set_link_status(struct octep_device *oct, u32 vf_id,
+				       union octep_pfvf_mbox_word cmd,
+				       union octep_pfvf_mbox_word *rsp)
+{
+	int err;
+
+	err = octep_ctrl_net_set_link_status(oct, vf_id, cmd.s_link_status.status, true);
+	if (err) {
+		rsp->s_link_status.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		dev_err(&oct->pdev->dev, "Set VF link status failed via host control Mbox\n");
+		return;
+	}
+	rsp->s_link_status.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+}
+
+static void octep_pfvf_set_rx_state(struct octep_device *oct, u32 vf_id,
+				    union octep_pfvf_mbox_word cmd,
+				    union octep_pfvf_mbox_word *rsp)
+{
+	int err;
+
+	err = octep_ctrl_net_set_rx_state(oct, vf_id, cmd.s_link_state.state, true);
+	if (err) {
+		rsp->s_link_state.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		dev_err(&oct->pdev->dev, "Set VF Rx link state failed via host control Mbox\n");
+		return;
+	}
+	rsp->s_link_state.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+}
+
+static void octep_pfvf_set_mtu(struct octep_device *oct, u32 vf_id,
+			       union octep_pfvf_mbox_word cmd,
+			       union octep_pfvf_mbox_word *rsp)
+{
+	int err;
+
+	err = octep_ctrl_net_set_mtu(oct, vf_id, cmd.s_set_mtu.mtu, true);
+	if (err) {
+		rsp->s_set_mtu.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		dev_err(&oct->pdev->dev, "Set VF MTU failed via host control Mbox\n");
+		return;
+	}
+	rsp->s_set_mtu.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+}
+
+static void octep_pfvf_get_mtu(struct octep_device *oct, u32 vf_id,
+			       union octep_pfvf_mbox_word cmd,
+			       union octep_pfvf_mbox_word *rsp)
+{
+	int max_rx_pktlen = oct->netdev->max_mtu + (ETH_HLEN + ETH_FCS_LEN);
+
+	rsp->s_set_mtu.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+	rsp->s_get_mtu.mtu = max_rx_pktlen;
+}
+
+static void octep_pfvf_set_mac_addr(struct octep_device *oct,  u32 vf_id,
+				    union octep_pfvf_mbox_word cmd,
+				    union octep_pfvf_mbox_word *rsp)
+{
+	int err;
+
+	err = octep_ctrl_net_set_mac_addr(oct, vf_id, cmd.s_set_mac.mac_addr, true);
+	if (err) {
+		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		dev_err(&oct->pdev->dev, "Set VF MAC address failed via host control Mbox\n");
+		return;
+	}
+	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+}
+
+static void octep_pfvf_get_mac_addr(struct octep_device *oct,  u32 vf_id,
+				    union octep_pfvf_mbox_word cmd,
+				    union octep_pfvf_mbox_word *rsp)
+{
+	int err;
+
+	err = octep_ctrl_net_get_mac_addr(oct, vf_id, rsp->s_set_mac.mac_addr);
+	if (err) {
+		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		dev_err(&oct->pdev->dev, "Get VF MAC address failed via host control Mbox\n");
+		return;
+	}
+	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+}
+
+static void octep_pfvf_dev_remove(struct octep_device *oct,  u32 vf_id,
+				  union octep_pfvf_mbox_word cmd,
+				  union octep_pfvf_mbox_word *rsp)
+{
+	int err;
+
+	err = octep_ctrl_net_dev_remove(oct, vf_id);
+	if (err) {
+		rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		dev_err(&oct->pdev->dev, "Failed to acknowledge fw of vf %d removal\n",
+			vf_id);
+		return;
+	}
+	rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+}
+
+int octep_setup_pfvf_mbox(struct octep_device *oct)
+{
+	int i = 0, num_vfs = 0, rings_per_vf = 0;
+	int ring = 0;
+
+	num_vfs = oct->conf->sriov_cfg.active_vfs;
+	rings_per_vf = oct->conf->sriov_cfg.max_rings_per_vf;
+
+	for (i = 0; i < num_vfs; i++) {
+		ring  = rings_per_vf * i;
+		oct->mbox[ring] = vzalloc(sizeof(*oct->mbox[ring]));
+
+		if (!oct->mbox[ring])
+			goto free_mbox;
+
+		memset(oct->mbox[ring], 0, sizeof(struct octep_mbox));
+		mutex_init(&oct->mbox[ring]->lock);
+		INIT_WORK(&oct->mbox[ring]->wk.work, octep_pfvf_mbox_work);
+		oct->mbox[ring]->wk.ctxptr = oct->mbox[ring];
+		oct->mbox[ring]->oct = oct;
+		oct->mbox[ring]->vf_id = i;
+		oct->hw_ops.setup_mbox_regs(oct, ring);
+	}
+	return 0;
+
+free_mbox:
+	while (i) {
+		i--;
+		ring  = rings_per_vf * i;
+		cancel_work_sync(&oct->mbox[ring]->wk.work);
+		mutex_destroy(&oct->mbox[ring]->lock);
+		vfree(oct->mbox[ring]);
+		oct->mbox[ring] = NULL;
+	}
+	return -ENOMEM;
+}
+
+void octep_delete_pfvf_mbox(struct octep_device *oct)
+{
+	int rings_per_vf = oct->conf->sriov_cfg.max_rings_per_vf;
+	int num_vfs = oct->conf->sriov_cfg.active_vfs;
+	int i = 0, ring = 0, vf_srn = 0;
+
+	for (i = 0; i < num_vfs; i++) {
+		ring  = vf_srn + rings_per_vf * i;
+		if (!oct->mbox[ring])
+			continue;
+
+		if (work_pending(&oct->mbox[ring]->wk.work))
+			cancel_work_sync(&oct->mbox[ring]->wk.work);
+
+		mutex_destroy(&oct->mbox[ring]->lock);
+		vfree(oct->mbox[ring]);
+		oct->mbox[ring] = NULL;
+	}
+}
+
+static void octep_pfvf_pf_get_data(struct octep_device *oct,
+				   struct octep_mbox *mbox, int vf_id,
+				   union octep_pfvf_mbox_word cmd,
+				   union octep_pfvf_mbox_word *rsp)
+{
+	int length = 0;
+	int i = 0;
+	int err;
+	struct octep_iface_link_info link_info;
+	struct octep_iface_rx_stats rx_stats;
+	struct octep_iface_tx_stats tx_stats;
+
+	rsp->s_data.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
+
+	if (cmd.s_data.frag != OCTEP_PFVF_MBOX_MORE_FRAG_FLAG) {
+		mbox->config_data_index = 0;
+		memset(mbox->config_data, 0, MAX_VF_PF_MBOX_DATA_SIZE);
+		/* Based on the OPCODE CMD the PF driver
+		 * specific API should be called to fetch
+		 * the requested data
+		 */
+		switch (cmd.s.opcode) {
+		case OCTEP_PFVF_MBOX_CMD_GET_LINK_INFO:
+			memset(&link_info, 0, sizeof(link_info));
+			err = octep_ctrl_net_get_link_info(oct, vf_id, &link_info);
+			if (!err) {
+				mbox->message_len = sizeof(link_info);
+				*((int32_t *)rsp->s_data.data) = mbox->message_len;
+				memcpy(mbox->config_data, (u8 *)&link_info, sizeof(link_info));
+			} else {
+				rsp->s_data.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+				return;
+			}
+			break;
+		case OCTEP_PFVF_MBOX_CMD_GET_STATS:
+			memset(&rx_stats, 0, sizeof(rx_stats));
+			memset(&tx_stats, 0, sizeof(tx_stats));
+			err = octep_ctrl_net_get_if_stats(oct, vf_id, &rx_stats, &tx_stats);
+			if (!err) {
+				mbox->message_len = sizeof(rx_stats) + sizeof(tx_stats);
+				*((int32_t *)rsp->s_data.data) = mbox->message_len;
+				memcpy(mbox->config_data, (u8 *)&rx_stats, sizeof(rx_stats));
+				memcpy(mbox->config_data + sizeof(rx_stats), (u8 *)&tx_stats,
+				       sizeof(tx_stats));
+
+			} else {
+				rsp->s_data.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+				return;
+			}
+			break;
+		}
+		*((int32_t *)rsp->s_data.data) = mbox->message_len;
+		return;
+	}
+
+	if (mbox->message_len > OCTEP_PFVF_MBOX_MAX_DATA_SIZE)
+		length = OCTEP_PFVF_MBOX_MAX_DATA_SIZE;
+	else
+		length = mbox->message_len;
+
+	mbox->message_len -= length;
+
+	for (i = 0; i < length; i++) {
+		rsp->s_data.data[i] =
+			mbox->config_data[mbox->config_data_index];
+		mbox->config_data_index++;
+	}
+}
+
+void octep_pfvf_mbox_work(struct work_struct *work)
+{
+	struct octep_pfvf_mbox_wk *wk = container_of(work, struct octep_pfvf_mbox_wk, work);
+	union octep_pfvf_mbox_word cmd = { 0 };
+	union octep_pfvf_mbox_word rsp = { 0 };
+	struct octep_mbox *mbox = NULL;
+	struct octep_device *oct = NULL;
+	int vf_id;
+
+	mbox = (struct octep_mbox *)wk->ctxptr;
+	oct = (struct octep_device *)mbox->oct;
+	vf_id = mbox->vf_id;
+
+	mutex_lock(&mbox->lock);
+	cmd.u64 = readq(mbox->vf_pf_data_reg);
+	rsp.u64 = 0;
+
+	switch (cmd.s.opcode) {
+	case OCTEP_PFVF_MBOX_CMD_VERSION:
+		octep_pfvf_validate_version(oct, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_GET_LINK_STATUS:
+		octep_pfvf_get_link_status(oct, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_SET_LINK_STATUS:
+		octep_pfvf_set_link_status(oct, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_SET_RX_STATE:
+		octep_pfvf_set_rx_state(oct, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_SET_MTU:
+		octep_pfvf_set_mtu(oct, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_SET_MAC_ADDR:
+		octep_pfvf_set_mac_addr(oct, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_GET_MAC_ADDR:
+		octep_pfvf_get_mac_addr(oct, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_GET_LINK_INFO:
+	case OCTEP_PFVF_MBOX_CMD_GET_STATS:
+		octep_pfvf_pf_get_data(oct, mbox, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_GET_MTU:
+		octep_pfvf_get_mtu(oct, vf_id, cmd, &rsp);
+		break;
+	case OCTEP_PFVF_MBOX_CMD_DEV_REMOVE:
+		octep_pfvf_dev_remove(oct, vf_id, cmd, &rsp);
+		break;
+	default:
+		dev_err(&oct->pdev->dev, "PF-VF mailbox: invalid opcode %d\n", cmd.s.opcode);
+		rsp.s.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
+		break;
+	}
+	writeq(rsp.u64, mbox->vf_pf_data_reg);
+	mutex_unlock(&mbox->lock);
+}
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
new file mode 100644
index 000000000000..34feeb559b0d
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell Octeon EP (EndPoint) Ethernet Driver
+ *
+ * Copyright (C) 2020 Marvell.
+ *
+ */
+
+#ifndef _OCTEP_PFVF_MBOX_H_
+#define _OCTEP_PFVF_MBOX_H_
+
+/* VF flags */
+#define OCTEON_PFVF_FLAG_MAC_SET_BY_PF  BIT_ULL(0) /* PF has set VF MAC address */
+#define OCTEON_SDP_16K_HW_FRS  16380UL
+#define OCTEON_SDP_64K_HW_FRS  65531UL
+
+enum octep_pfvf_mbox_version {
+	OCTEP_PFVF_MBOX_VERSION_V0,
+	OCTEP_PFVF_MBOX_VERSION_V1,
+};
+
+enum octep_pfvf_mbox_opcode {
+	OCTEP_PFVF_MBOX_CMD_VERSION,
+	OCTEP_PFVF_MBOX_CMD_SET_MTU,
+	OCTEP_PFVF_MBOX_CMD_SET_MAC_ADDR,
+	OCTEP_PFVF_MBOX_CMD_GET_MAC_ADDR,
+	OCTEP_PFVF_MBOX_CMD_GET_LINK_INFO,
+	OCTEP_PFVF_MBOX_CMD_GET_STATS,
+	OCTEP_PFVF_MBOX_CMD_SET_RX_STATE,
+	OCTEP_PFVF_MBOX_CMD_SET_LINK_STATUS,
+	OCTEP_PFVF_MBOX_CMD_GET_LINK_STATUS,
+	OCTEP_PFVF_MBOX_CMD_GET_MTU,
+	OCTEP_PFVF_MBOX_CMD_DEV_REMOVE,
+	OCTEP_PFVF_MBOX_CMD_LAST,
+};
+
+enum octep_pfvf_mbox_word_type {
+	OCTEP_PFVF_MBOX_TYPE_CMD,
+	OCTEP_PFVF_MBOX_TYPE_RSP_ACK,
+	OCTEP_PFVF_MBOX_TYPE_RSP_NACK,
+};
+
+enum octep_pfvf_mbox_cmd_status {
+	OCTEP_PFVF_MBOX_CMD_STATUS_NOT_SETUP = 1,
+	OCTEP_PFVF_MBOX_CMD_STATUS_TIMEDOUT = 2,
+	OCTEP_PFVF_MBOX_CMD_STATUS_NACK = 3,
+	OCTEP_PFVF_MBOX_CMD_STATUS_BUSY = 4
+};
+
+enum octep_pfvf_mbox_state {
+	OCTEP_PFVF_MBOX_STATE_IDLE = 0,
+	OCTEP_PFVF_MBOX_STATE_BUSY = 1,
+};
+
+enum octep_pfvf_link_status {
+	OCTEP_PFVF_LINK_STATUS_DOWN,
+	OCTEP_PFVF_LINK_STATUS_UP,
+};
+
+enum octep_pfvf_link_speed {
+	OCTEP_PFVF_LINK_SPEED_NONE,
+	OCTEP_PFVF_LINK_SPEED_1000,
+	OCTEP_PFVF_LINK_SPEED_10000,
+	OCTEP_PFVF_LINK_SPEED_25000,
+	OCTEP_PFVF_LINK_SPEED_40000,
+	OCTEP_PFVF_LINK_SPEED_50000,
+	OCTEP_PFVF_LINK_SPEED_100000,
+	OCTEP_PFVF_LINK_SPEED_LAST,
+};
+
+enum octep_pfvf_link_duplex {
+	OCTEP_PFVF_LINK_HALF_DUPLEX,
+	OCTEP_PFVF_LINK_FULL_DUPLEX,
+};
+
+enum octep_pfvf_link_autoneg {
+	OCTEP_PFVF_LINK_AUTONEG,
+	OCTEP_PFVF_LINK_FIXED,
+};
+
+#define OCTEP_PFVF_MBOX_TIMEOUT_MS     500
+#define OCTEP_PFVF_MBOX_MAX_RETRIES    2
+#define OCTEP_PFVF_MBOX_VERSION        0
+#define OCTEP_PFVF_MBOX_MAX_DATA_SIZE  6
+#define OCTEP_PFVF_MBOX_MORE_FRAG_FLAG 1
+#define OCTEP_PFVF_MBOX_WRITE_WAIT_TIME msecs_to_jiffies(1)
+
+union octep_pfvf_mbox_word {
+	u64 u64;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:6;
+		u64 data:48;
+	} s;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 frag:1;
+		u64 rsvd:5;
+		u8 data[6];
+	} s_data;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:6;
+		u64 version:48;
+	} s_version;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:6;
+		u8 mac_addr[6];
+	} s_set_mac;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:6;
+		u64 mtu:48;
+	} s_set_mtu;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:6;
+		u64 mtu:48;
+	} s_get_mtu;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 state:1;
+		u64 rsvd:53;
+	} s_link_state;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 status:1;
+		u64 rsvd:53;
+	} s_link_status;
+} __packed;
+
+void octep_pfvf_mbox_work(struct work_struct *work);
+int octep_setup_pfvf_mbox(struct octep_device *oct);
+void octep_delete_pfvf_mbox(struct octep_device *oct);
+#endif
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
index 2e20a39d89af..ca473502d7a0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -208,6 +208,9 @@
 #define    CN93_SDP_R_MBOX_PF_VF_INT_START        0x10220
 #define    CN93_SDP_R_MBOX_VF_PF_DATA_START       0x10230
 
+#define    CN93_SDP_MBOX_VF_PF_DATA_START       0x24000
+#define    CN93_SDP_MBOX_PF_VF_DATA_START       0x22000
+
 #define    CN93_SDP_R_MBOX_PF_VF_DATA(ring)		\
 	(CN93_SDP_R_MBOX_PF_VF_DATA_START + ((ring) * CN93_RING_OFFSET))
 
@@ -217,6 +220,12 @@
 #define    CN93_SDP_R_MBOX_VF_PF_DATA(ring)		\
 	(CN93_SDP_R_MBOX_VF_PF_DATA_START + ((ring) * CN93_RING_OFFSET))
 
+#define    CN93_SDP_MBOX_VF_PF_DATA(ring)          \
+	(CN93_SDP_MBOX_VF_PF_DATA_START + ((ring) * CN93_EPVF_RING_OFFSET))
+
+#define    CN93_SDP_MBOX_PF_VF_DATA(ring)      \
+	(CN93_SDP_MBOX_PF_VF_DATA_START + ((ring) * CN93_EPVF_RING_OFFSET))
+
 /* ##################### Interrupt Registers ########################## */
 #define	   CN93_SDP_R_ERR_TYPE_START	          0x10400
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
index ea677f760ef0..e637d7c8224d 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
@@ -183,6 +183,7 @@
 #define CNXK_SDP_R_OUT_INT_MDRT_CTL1_START        0x103A0
 #define CNXK_SDP_R_OUT_INT_MDRT_DBG_START         0x103C0
 
+#define CNXK_SDP_R_MBOX_ISM_START                 0x10500
 #define CNXK_SDP_R_OUT_CNTS_ISM_START             0x10510
 #define CNXK_SDP_R_IN_CNTS_ISM_START              0x10520
 
@@ -204,6 +205,9 @@
 #define    CNXK_SDP_R_OUT_INT_MDRT_DBG(ring)		\
 	(CNXK_SDP_R_OUT_INT_MDRT_DBG_START + ((ring) * CNXK_RING_OFFSET))
 
+#define    CNXK_SDP_R_MBOX_ISM(ring)          \
+	(CNXK_SDP_R_MBOX_ISM_START + ((ring) * CNXK_RING_OFFSET))
+
 #define    CNXK_SDP_R_OUT_CNTS_ISM(ring)          \
 	(CNXK_SDP_R_OUT_CNTS_ISM_START + ((ring) * CNXK_RING_OFFSET))
 
@@ -222,6 +226,9 @@
 #define    CNXK_SDP_R_MBOX_PF_VF_INT_START        0x10220
 #define    CNXK_SDP_R_MBOX_VF_PF_DATA_START       0x10230
 
+#define    CNXK_SDP_MBOX_VF_PF_DATA_START       0x24000
+#define    CNXK_SDP_MBOX_PF_VF_DATA_START       0x22000
+
 #define    CNXK_SDP_R_MBOX_PF_VF_DATA(ring)		\
 	(CNXK_SDP_R_MBOX_PF_VF_DATA_START + ((ring) * CNXK_RING_OFFSET))
 
@@ -231,6 +238,12 @@
 #define    CNXK_SDP_R_MBOX_VF_PF_DATA(ring)		\
 	(CNXK_SDP_R_MBOX_VF_PF_DATA_START + ((ring) * CNXK_RING_OFFSET))
 
+#define    CNXK_SDP_MBOX_VF_PF_DATA(ring)          \
+	(CNXK_SDP_MBOX_VF_PF_DATA_START + ((ring) * CNXK_EPVF_RING_OFFSET))
+
+#define    CNXK_SDP_MBOX_PF_VF_DATA(ring)      \
+	(CNXK_SDP_MBOX_PF_VF_DATA_START + ((ring) * CNXK_EPVF_RING_OFFSET))
+
 /* ##################### Interrupt Registers ########################## */
 #define	   CNXK_SDP_R_ERR_TYPE_START	          0x10400
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 059fa921069f..875a2c34091f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -61,6 +61,18 @@ struct octep_tx_buffer {
 
 /* Hardware interface Tx statistics */
 struct octep_iface_tx_stats {
+	/* Total frames sent on the interface */
+	u64 pkts;
+
+	/* Total octets sent on the interface */
+	u64 octs;
+
+	/* Packets sent to a broadcast DMAC */
+	u64 bcst;
+
+	/* Packets sent to the multicast DMAC */
+	u64 mcst;
+
 	/* Packets dropped due to excessive collisions */
 	u64 xscol;
 
@@ -77,12 +89,6 @@ struct octep_iface_tx_stats {
 	 */
 	u64 scol;
 
-	/* Total octets sent on the interface */
-	u64 octs;
-
-	/* Total frames sent on the interface */
-	u64 pkts;
-
 	/* Packets sent with an octet count < 64 */
 	u64 hist_lt64;
 
@@ -107,12 +113,6 @@ struct octep_iface_tx_stats {
 	/* Packets sent with an octet count of > 1518 */
 	u64 hist_gt1518;
 
-	/* Packets sent to a broadcast DMAC */
-	u64 bcst;
-
-	/* Packets sent to the multicast DMAC */
-	u64 mcst;
-
 	/* Packets sent that experienced a transmit underflow and were
 	 * truncated
 	 */
-- 
2.25.1

