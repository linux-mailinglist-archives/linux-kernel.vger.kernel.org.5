Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6C7A41A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbjIRG5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbjIRG4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:56:54 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C274CF3;
        Sun, 17 Sep 2023 23:56:45 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38HKojnL017399;
        Sun, 17 Sep 2023 23:56:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=UavUc7EBDQW0GY8qK45FlFNxEWqTQSrJt24guv4TGT8=;
 b=EPx1XmIn6K5Oehg6BVhIRzvOJ9sVWYiQeGlyWxTw5LpJEJdktm9qAMxeAMQDh8jNYsg7
 6wJ5Zn9joE5YzmBGaU7ykkoLBPBYSna9z1c4IBZxHsHD6EPMcmMxoGM3CHwCM/JmsCNI
 kb7GKEamEVFA1cMZoLGxXZIaYXnvBQX5+n1bXlCari3rBx+pmvZlaIPaQ50KzChRvK0x
 aLr2DmoPLOGeo+1DFpV+/gAOeDzsydaBqs2DOKeptKR7hmkgu6lf7YFDkKYzD4wBvTAj
 vF1I+FDk33HUd6eYGP7HkppzSreUXt32K4jnhDgWyQRwxld8MboAzj8/DapuSehIms39 KQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3t5bvkk6pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 17 Sep 2023 23:56:31 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Sep
 2023 23:56:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 17 Sep 2023 23:56:29 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 5D80F5B6921;
        Sun, 17 Sep 2023 23:56:28 -0700 (PDT)
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
Subject: [net-next PATCH] octeon_ep: restructured interrupt handlers
Date:   Sun, 17 Sep 2023 23:56:21 -0700
Message-ID: <20230918065621.2165449-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: B4COJaObnB-pQPLbDBkJ_2MeFL_mXCNJ
X-Proofpoint-ORIG-GUID: B4COJaObnB-pQPLbDBkJ_2MeFL_mXCNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separated queue specific interrupts to register to individual msix-vectors
instead of using a single generic interrupt handler on a single
msix-vector.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../marvell/octeon_ep/octep_cn9k_pf.c         | 158 ++++++++++----
 .../ethernet/marvell/octeon_ep/octep_main.c   | 197 +++++++++++++++++-
 .../ethernet/marvell/octeon_ep/octep_main.h   |  13 +-
 3 files changed, 323 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index f282cd5b29ea..d4ee2454675b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -369,34 +369,40 @@ static void octep_setup_mbox_regs_cn93_pf(struct octep_device *oct, int q_no)
 	mbox->mbox_read_reg = oct->mmio[0].hw_addr + CN93_SDP_R_MBOX_VF_PF_DATA(q_no);
 }
 
-/* Process non-ioq interrupts required to keep pf interface running.
- * OEI_RINT is needed for control mailbox
- */
-static bool octep_poll_non_ioq_interrupts_cn93_pf(struct octep_device *oct)
-{
-	bool handled = false;
-	u64 reg0;
-
-	/* Check for OEI INTR */
-	reg0 = octep_read_csr64(oct, CN93_SDP_EPF_OEI_RINT);
-	if (reg0) {
-		dev_info(&oct->pdev->dev,
-			 "Received OEI_RINT intr: 0x%llx\n",
-			 reg0);
-		octep_write_csr64(oct, CN93_SDP_EPF_OEI_RINT, reg0);
-		if (reg0 & CN93_SDP_EPF_OEI_RINT_DATA_BIT_MBOX)
+/* Poll OEI events like heartbeat */
+static void octep_poll_oei_cn93_pf(struct octep_device *oct)
+{
+	u64 reg;
+
+	reg = octep_read_csr64(oct, CN93_SDP_EPF_OEI_RINT);
+	if (reg) {
+		octep_write_csr64(oct, CN93_SDP_EPF_OEI_RINT, reg);
+		if (reg & CN93_SDP_EPF_OEI_RINT_DATA_BIT_MBOX)
 			queue_work(octep_wq, &oct->ctrl_mbox_task);
-		else if (reg0 & CN93_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT)
+		else if (reg & CN93_SDP_EPF_OEI_RINT_DATA_BIT_HBEAT)
 			atomic_set(&oct->hb_miss_cnt, 0);
-
-		handled = true;
 	}
+}
+
+/* OEI interrupt handler */
+static irqreturn_t octep_oei_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
 
-	return handled;
+	octep_poll_oei_cn93_pf(oct);
+	return IRQ_HANDLED;
+}
+
+/* Process non-ioq interrupts required to keep pf interface running.
+ * OEI_RINT is needed for control mailbox
+ */
+static void octep_poll_non_ioq_interrupts_cn93_pf(struct octep_device *oct)
+{
+	octep_poll_oei_cn93_pf(oct);
 }
 
-/* Interrupts handler for all non-queue generic interrupts. */
-static irqreturn_t octep_non_ioq_intr_handler_cn93_pf(void *dev)
+/* Interrupt handler for input ring error interrupts. */
+static irqreturn_t octep_ire_intr_handler_cn93_pf(void *dev)
 {
 	struct octep_device *oct = (struct octep_device *)dev;
 	struct pci_dev *pdev = oct->pdev;
@@ -421,8 +427,17 @@ static irqreturn_t octep_non_ioq_intr_handler_cn93_pf(void *dev)
 						  reg_val);
 			}
 		}
-		goto irq_handled;
 	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for output ring error interrupts. */
+static irqreturn_t octep_ore_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
+	int i = 0;
 
 	/* Check for ORERR INTR */
 	reg_val = octep_read_csr64(oct, CN93_SDP_EPF_ORERR_RINT);
@@ -440,9 +455,16 @@ static irqreturn_t octep_non_ioq_intr_handler_cn93_pf(void *dev)
 						  reg_val);
 			}
 		}
-
-		goto irq_handled;
 	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for vf input ring error interrupts. */
+static irqreturn_t octep_vfire_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
 
 	/* Check for VFIRE INTR */
 	reg_val = octep_read_csr64(oct, CN93_SDP_EPF_VFIRE_RINT(0));
@@ -450,8 +472,16 @@ static irqreturn_t octep_non_ioq_intr_handler_cn93_pf(void *dev)
 		dev_info(&pdev->dev,
 			 "Received VFIRE_RINT intr: 0x%llx\n", reg_val);
 		octep_write_csr64(oct, CN93_SDP_EPF_VFIRE_RINT(0), reg_val);
-		goto irq_handled;
 	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for vf output ring error interrupts. */
+static irqreturn_t octep_vfore_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
 
 	/* Check for VFORE INTR */
 	reg_val = octep_read_csr64(oct, CN93_SDP_EPF_VFORE_RINT(0));
@@ -459,19 +489,30 @@ static irqreturn_t octep_non_ioq_intr_handler_cn93_pf(void *dev)
 		dev_info(&pdev->dev,
 			 "Received VFORE_RINT intr: 0x%llx\n", reg_val);
 		octep_write_csr64(oct, CN93_SDP_EPF_VFORE_RINT(0), reg_val);
-		goto irq_handled;
 	}
+	return IRQ_HANDLED;
+}
 
-	/* Check for MBOX INTR and OEI INTR */
-	if (octep_poll_non_ioq_interrupts_cn93_pf(oct))
-		goto irq_handled;
+/* Interrupt handler for dpi dma related interrupts. */
+static irqreturn_t octep_dma_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	u64 reg_val = 0;
 
 	/* Check for DMA INTR */
 	reg_val = octep_read_csr64(oct, CN93_SDP_EPF_DMA_RINT);
 	if (reg_val) {
 		octep_write_csr64(oct, CN93_SDP_EPF_DMA_RINT, reg_val);
-		goto irq_handled;
 	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for dpi dma transaction error interrupts for VFs  */
+static irqreturn_t octep_dma_vf_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
 
 	/* Check for DMA VF INTR */
 	reg_val = octep_read_csr64(oct, CN93_SDP_EPF_DMA_VF_RINT(0));
@@ -479,8 +520,16 @@ static irqreturn_t octep_non_ioq_intr_handler_cn93_pf(void *dev)
 		dev_info(&pdev->dev,
 			 "Received DMA_VF_RINT intr: 0x%llx\n", reg_val);
 		octep_write_csr64(oct, CN93_SDP_EPF_DMA_VF_RINT(0), reg_val);
-		goto irq_handled;
 	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for pp transaction error interrupts for VFs  */
+static irqreturn_t octep_pp_vf_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
 
 	/* Check for PPVF INTR */
 	reg_val = octep_read_csr64(oct, CN93_SDP_EPF_PP_VF_RINT(0));
@@ -488,8 +537,16 @@ static irqreturn_t octep_non_ioq_intr_handler_cn93_pf(void *dev)
 		dev_info(&pdev->dev,
 			 "Received PP_VF_RINT intr: 0x%llx\n", reg_val);
 		octep_write_csr64(oct, CN93_SDP_EPF_PP_VF_RINT(0), reg_val);
-		goto irq_handled;
 	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupt handler for mac related interrupts. */
+static irqreturn_t octep_misc_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
+	u64 reg_val = 0;
 
 	/* Check for MISC INTR */
 	reg_val = octep_read_csr64(oct, CN93_SDP_EPF_MISC_RINT);
@@ -497,11 +554,17 @@ static irqreturn_t octep_non_ioq_intr_handler_cn93_pf(void *dev)
 		dev_info(&pdev->dev,
 			 "Received MISC_RINT intr: 0x%llx\n", reg_val);
 		octep_write_csr64(oct, CN93_SDP_EPF_MISC_RINT, reg_val);
-		goto irq_handled;
 	}
+	return IRQ_HANDLED;
+}
+
+/* Interrupts handler for all reserved interrupts. */
+static irqreturn_t octep_rsvd_intr_handler_cn93_pf(void *dev)
+{
+	struct octep_device *oct = (struct octep_device *)dev;
+	struct pci_dev *pdev = oct->pdev;
 
 	dev_info(&pdev->dev, "Reserved interrupts raised; Ignore\n");
-irq_handled:
 	return IRQ_HANDLED;
 }
 
@@ -565,8 +628,15 @@ static void octep_enable_interrupts_cn93_pf(struct octep_device *oct)
 	octep_write_csr64(oct, CN93_SDP_EPF_IRERR_RINT_ENA_W1S, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_ORERR_RINT_ENA_W1S, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_OEI_RINT_ENA_W1S, -1ULL);
+
+	octep_write_csr64(oct, CN93_SDP_EPF_VFIRE_RINT_ENA_W1S(0), -1ULL);
+	octep_write_csr64(oct, CN93_SDP_EPF_VFORE_RINT_ENA_W1S(0), -1ULL);
+
 	octep_write_csr64(oct, CN93_SDP_EPF_MISC_RINT_ENA_W1S, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_DMA_RINT_ENA_W1S, intr_mask);
+
+	octep_write_csr64(oct, CN93_SDP_EPF_DMA_VF_RINT_ENA_W1S(0), -1ULL);
+	octep_write_csr64(oct, CN93_SDP_EPF_PP_VF_RINT_ENA_W1S(0), -1ULL);
 }
 
 /* Disable all interrupts */
@@ -584,8 +654,15 @@ static void octep_disable_interrupts_cn93_pf(struct octep_device *oct)
 	octep_write_csr64(oct, CN93_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_OEI_RINT_ENA_W1C, -1ULL);
+
+	octep_write_csr64(oct, CN93_SDP_EPF_VFIRE_RINT_ENA_W1C(0), -1ULL);
+	octep_write_csr64(oct, CN93_SDP_EPF_VFORE_RINT_ENA_W1C(0), -1ULL);
+
 	octep_write_csr64(oct, CN93_SDP_EPF_MISC_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_DMA_RINT_ENA_W1C, intr_mask);
+
+	octep_write_csr64(oct, CN93_SDP_EPF_DMA_VF_RINT_ENA_W1C(0), -1ULL);
+	octep_write_csr64(oct, CN93_SDP_EPF_PP_VF_RINT_ENA_W1C(0), -1ULL);
 }
 
 /* Get new Octeon Read Index: index of descriptor that Octeon reads next. */
@@ -718,7 +795,16 @@ void octep_device_setup_cn93_pf(struct octep_device *oct)
 	oct->hw_ops.setup_oq_regs = octep_setup_oq_regs_cn93_pf;
 	oct->hw_ops.setup_mbox_regs = octep_setup_mbox_regs_cn93_pf;
 
-	oct->hw_ops.non_ioq_intr_handler = octep_non_ioq_intr_handler_cn93_pf;
+	oct->hw_ops.oei_intr_handler = octep_oei_intr_handler_cn93_pf;
+	oct->hw_ops.ire_intr_handler = octep_ire_intr_handler_cn93_pf;
+	oct->hw_ops.ore_intr_handler = octep_ore_intr_handler_cn93_pf;
+	oct->hw_ops.vfire_intr_handler = octep_vfire_intr_handler_cn93_pf;
+	oct->hw_ops.vfore_intr_handler = octep_vfore_intr_handler_cn93_pf;
+	oct->hw_ops.dma_intr_handler = octep_dma_intr_handler_cn93_pf;
+	oct->hw_ops.dma_vf_intr_handler = octep_dma_vf_intr_handler_cn93_pf;
+	oct->hw_ops.pp_vf_intr_handler = octep_pp_vf_intr_handler_cn93_pf;
+	oct->hw_ops.misc_intr_handler = octep_misc_intr_handler_cn93_pf;
+	oct->hw_ops.rsvd_intr_handler = octep_rsvd_intr_handler_cn93_pf;
 	oct->hw_ops.ioq_intr_handler = octep_ioq_intr_handler_cn93_pf;
 	oct->hw_ops.soft_reset = octep_soft_reset_cn93_pf;
 	oct->hw_ops.reinit_regs = octep_reinit_regs_cn93_pf;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index ec3fd7ca3125..a78fa864d053 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -155,18 +155,153 @@ static void octep_disable_msix(struct octep_device *oct)
 }
 
 /**
- * octep_non_ioq_intr_handler() - common handler for all generic interrupts.
+ * octep_oei_intr_handler() - common handler for output endpoint interrupts.
  *
  * @irq: Interrupt number.
  * @data: interrupt data.
  *
- * this is common handler for all non-queue (generic) interrupts.
+ * this is common handler for all output endpoint interrupts.
+ */
+static irqreturn_t octep_oei_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.oei_intr_handler(oct);
+}
+
+/**
+ * octep_ire_intr_handler() - common handler for input ring error interrupts.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for input ring error interrupts.
+ */
+static irqreturn_t octep_ire_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.ire_intr_handler(oct);
+}
+
+/**
+ * octep_ore_intr_handler() - common handler for output ring error interrupts.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for output ring error interrupts.
+ */
+static irqreturn_t octep_ore_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.ore_intr_handler(oct);
+}
+
+/**
+ * octep_vfire_intr_handler() - common handler for vf input ring error interrupts.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for vf input ring error interrupts.
+ */
+static irqreturn_t octep_vfire_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.vfire_intr_handler(oct);
+}
+
+/**
+ * octep_vfore_intr_handler() - common handler for vf output ring error interrupts.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for vf output ring error interrupts.
  */
-static irqreturn_t octep_non_ioq_intr_handler(int irq, void *data)
+static irqreturn_t octep_vfore_intr_handler(int irq, void *data)
 {
 	struct octep_device *oct = data;
 
-	return oct->hw_ops.non_ioq_intr_handler(oct);
+	return oct->hw_ops.vfore_intr_handler(oct);
+}
+
+/**
+ * octep_dma_intr_handler() - common handler for dpi dma related interrupts.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for dpi dma related interrupts.
+ */
+static irqreturn_t octep_dma_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.dma_intr_handler(oct);
+}
+
+/**
+ * octep_dma_vf_intr_handler() - common handler for dpi dma transaction error interrupts for VFs.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for dpi dma transaction error interrupts for VFs.
+ */
+static irqreturn_t octep_dma_vf_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.dma_vf_intr_handler(oct);
+}
+
+/**
+ * octep_pp_vf_intr_handler() - common handler for pp transaction error interrupts for VFs.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for pp transaction error interrupts for VFs.
+ */
+static irqreturn_t octep_pp_vf_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.pp_vf_intr_handler(oct);
+}
+
+/**
+ * octep_misc_intr_handler() - common handler for mac related interrupts.
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for mac related interrupts.
+ */
+static irqreturn_t octep_misc_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.misc_intr_handler(oct);
+}
+
+/**
+ * octep_rsvd_intr_handler() - common handler for reserved interrupts (future use).
+ *
+ * @irq: Interrupt number.
+ * @data: interrupt data.
+ *
+ * this is common handler for all reserved interrupts.
+ */
+static irqreturn_t octep_rsvd_intr_handler(int irq, void *data)
+{
+	struct octep_device *oct = data;
+
+	return oct->hw_ops.rsvd_intr_handler(oct);
 }
 
 /**
@@ -222,9 +357,57 @@ static int octep_request_irqs(struct octep_device *oct)
 
 		snprintf(irq_name, OCTEP_MSIX_NAME_SIZE,
 			 "%s-%s", netdev->name, non_ioq_msix_names[i]);
-		ret = request_irq(msix_entry->vector,
-				  octep_non_ioq_intr_handler, 0,
-				  irq_name, oct);
+		if (!strncmp(non_ioq_msix_names[i], "epf_oei_rint",
+			     strlen("epf_oei_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_oei_intr_handler, 0,
+					  irq_name, oct);
+		} else if (!strncmp(non_ioq_msix_names[i], "epf_ire_rint",
+			   strlen("epf_ire_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_ire_intr_handler, 0,
+					  irq_name, oct);
+		} else if (!strncmp(non_ioq_msix_names[i], "epf_ore_rint",
+			   strlen("epf_ore_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_ore_intr_handler, 0,
+					  irq_name, oct);
+		} else if (!strncmp(non_ioq_msix_names[i], "epf_vfire_rint",
+			   strlen("epf_vfire_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_vfire_intr_handler, 0,
+					  irq_name, oct);
+		} else if (!strncmp(non_ioq_msix_names[i], "epf_vfore_rint",
+			   strlen("epf_vfore_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_vfore_intr_handler, 0,
+					  irq_name, oct);
+		} else if (!strncmp(non_ioq_msix_names[i], "epf_dma_rint",
+			   strlen("epf_dma_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_dma_intr_handler, 0,
+					  irq_name, oct);
+		} else if (!strncmp(non_ioq_msix_names[i], "epf_dma_vf_rint",
+			   strlen("epf_dma_vf_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_dma_vf_intr_handler, 0,
+					  irq_name, oct);
+		} else if (!strncmp(non_ioq_msix_names[i], "epf_pp_vf_rint",
+			   strlen("epf_pp_vf_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_pp_vf_intr_handler, 0,
+					  irq_name, oct);
+		} else if (!strncmp(non_ioq_msix_names[i], "epf_misc_rint",
+			   strlen("epf_misc_rint"))) {
+			ret = request_irq(msix_entry->vector,
+					  octep_misc_intr_handler, 0,
+					  irq_name, oct);
+		} else {
+			ret = request_irq(msix_entry->vector,
+					  octep_rsvd_intr_handler, 0,
+					  irq_name, oct);
+		}
+
 		if (ret) {
 			netdev_err(netdev,
 				   "request_irq failed for %s; err=%d",
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index e0907a719133..6df902ebb7f3 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -65,7 +65,16 @@ struct octep_hw_ops {
 	void (*setup_oq_regs)(struct octep_device *oct, int q);
 	void (*setup_mbox_regs)(struct octep_device *oct, int mbox);
 
-	irqreturn_t (*non_ioq_intr_handler)(void *ioq_vector);
+	irqreturn_t (*oei_intr_handler)(void *ioq_vector);
+	irqreturn_t (*ire_intr_handler)(void *ioq_vector);
+	irqreturn_t (*ore_intr_handler)(void *ioq_vector);
+	irqreturn_t (*vfire_intr_handler)(void *ioq_vector);
+	irqreturn_t (*vfore_intr_handler)(void *ioq_vector);
+	irqreturn_t (*dma_intr_handler)(void *ioq_vector);
+	irqreturn_t (*dma_vf_intr_handler)(void *ioq_vector);
+	irqreturn_t (*pp_vf_intr_handler)(void *ioq_vector);
+	irqreturn_t (*misc_intr_handler)(void *ioq_vector);
+	irqreturn_t (*rsvd_intr_handler)(void *ioq_vector);
 	irqreturn_t (*ioq_intr_handler)(void *ioq_vector);
 	int (*soft_reset)(struct octep_device *oct);
 	void (*reinit_regs)(struct octep_device *oct);
@@ -73,7 +82,7 @@ struct octep_hw_ops {
 
 	void (*enable_interrupts)(struct octep_device *oct);
 	void (*disable_interrupts)(struct octep_device *oct);
-	bool (*poll_non_ioq_interrupts)(struct octep_device *oct);
+	void (*poll_non_ioq_interrupts)(struct octep_device *oct);
 
 	void (*enable_io_queues)(struct octep_device *oct);
 	void (*disable_io_queues)(struct octep_device *oct);
-- 
2.25.1

