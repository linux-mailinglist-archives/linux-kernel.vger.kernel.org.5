Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC18035E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjLDOE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjLDOEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:04:24 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A481E119;
        Mon,  4 Dec 2023 06:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1701698644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfTyNXzfHCBEsP75+j9tuzi+q9BjmgIsVWTMiU/h6PU=;
        b=uv1YE4Hx6lw5Y0EUgsnkEY/KkEVonGO7+iy5yXFAX/UB9a5hEJa7B1Rs+brPp3UJDOSNaF
        BecYdGbtg518Qfw8gOYH0nXm2+g8ctEi1wwMM6KaZqzpBcc2+7z4efCIP6nU3RX4sGQuLV
        +BANWnvn9zIAw4MIJUo5PVQAGrsgxNw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] dmaengine: axi-dmac: Add support for scatter-gather transfers
Date:   Mon,  4 Dec 2023 15:03:51 +0100
Message-ID: <20231204140352.30420-4-paul@crapouillou.net>
In-Reply-To: <20231204140352.30420-1-paul@crapouillou.net>
References: <20231204140352.30420-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for scatter-gather transfers. Build a chain of
hardware descriptors, each one corresponding to a segment of the
transfer, and linked to the next one. The hardware will transfer the
chain and only fire interrupts when the whole chain has been
transferred.

Support for scatter-gather is automatically enabled when the driver
detects that the hardware supports it, by writing then reading the
AXI_DMAC_REG_SG_ADDRESS register. If not available, the driver will fall
back to standard DMA transfers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-axi-dmac.c | 135 +++++++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 185230a769b9..5109530b66de 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -81,9 +81,13 @@
 #define AXI_DMAC_REG_CURRENT_DEST_ADDR	0x438
 #define AXI_DMAC_REG_PARTIAL_XFER_LEN	0x44c
 #define AXI_DMAC_REG_PARTIAL_XFER_ID	0x450
+#define AXI_DMAC_REG_CURRENT_SG_ID	0x454
+#define AXI_DMAC_REG_SG_ADDRESS		0x47c
+#define AXI_DMAC_REG_SG_ADDRESS_HIGH	0x4bc
 
 #define AXI_DMAC_CTRL_ENABLE		BIT(0)
 #define AXI_DMAC_CTRL_PAUSE		BIT(1)
+#define AXI_DMAC_CTRL_ENABLE_SG		BIT(2)
 
 #define AXI_DMAC_IRQ_SOT		BIT(0)
 #define AXI_DMAC_IRQ_EOT		BIT(1)
@@ -97,12 +101,16 @@
 /* The maximum ID allocated by the hardware is 31 */
 #define AXI_DMAC_SG_UNUSED 32U
 
+/* Flags for axi_dmac_hw_desc.flags */
+#define AXI_DMAC_HW_FLAG_LAST		BIT(0)
+#define AXI_DMAC_HW_FLAG_IRQ		BIT(1)
+
 struct axi_dmac_hw_desc {
 	u32 flags;
 	u32 id;
 	u64 dest_addr;
 	u64 src_addr;
-	u64 __unused;
+	u64 next_sg_addr;
 	u32 y_len;
 	u32 x_len;
 	u32 src_stride;
@@ -150,6 +158,7 @@ struct axi_dmac_chan {
 	bool hw_partial_xfer;
 	bool hw_cyclic;
 	bool hw_2d;
+	bool hw_sg;
 };
 
 struct axi_dmac {
@@ -224,9 +233,11 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	unsigned int flags = 0;
 	unsigned int val;
 
-	val = axi_dmac_read(dmac, AXI_DMAC_REG_START_TRANSFER);
-	if (val) /* Queue is full, wait for the next SOT IRQ */
-		return;
+	if (!chan->hw_sg) {
+		val = axi_dmac_read(dmac, AXI_DMAC_REG_START_TRANSFER);
+		if (val) /* Queue is full, wait for the next SOT IRQ */
+			return;
+	}
 
 	desc = chan->next_desc;
 
@@ -245,9 +256,10 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 		return;
 	}
 
-	desc->num_submitted++;
-	if (desc->num_submitted == desc->num_sgs ||
-	    desc->have_partial_xfer) {
+	if (chan->hw_sg) {
+		chan->next_desc = NULL;
+	} else if (++desc->num_submitted == desc->num_sgs ||
+		   desc->have_partial_xfer) {
 		if (desc->cyclic)
 			desc->num_submitted = 0; /* Start again */
 		else
@@ -259,14 +271,16 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 
 	sg->hw->id = axi_dmac_read(dmac, AXI_DMAC_REG_TRANSFER_ID);
 
-	if (axi_dmac_dest_is_mem(chan)) {
-		axi_dmac_write(dmac, AXI_DMAC_REG_DEST_ADDRESS, sg->hw->dest_addr);
-		axi_dmac_write(dmac, AXI_DMAC_REG_DEST_STRIDE, sg->hw->dst_stride);
-	}
+	if (!chan->hw_sg) {
+		if (axi_dmac_dest_is_mem(chan)) {
+			axi_dmac_write(dmac, AXI_DMAC_REG_DEST_ADDRESS, sg->hw->dest_addr);
+			axi_dmac_write(dmac, AXI_DMAC_REG_DEST_STRIDE, sg->hw->dst_stride);
+		}
 
-	if (axi_dmac_src_is_mem(chan)) {
-		axi_dmac_write(dmac, AXI_DMAC_REG_SRC_ADDRESS, sg->hw->src_addr);
-		axi_dmac_write(dmac, AXI_DMAC_REG_SRC_STRIDE, sg->hw->src_stride);
+		if (axi_dmac_src_is_mem(chan)) {
+			axi_dmac_write(dmac, AXI_DMAC_REG_SRC_ADDRESS, sg->hw->src_addr);
+			axi_dmac_write(dmac, AXI_DMAC_REG_SRC_STRIDE, sg->hw->src_stride);
+		}
 	}
 
 	/*
@@ -281,8 +295,14 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	if (chan->hw_partial_xfer)
 		flags |= AXI_DMAC_FLAG_PARTIAL_REPORT;
 
-	axi_dmac_write(dmac, AXI_DMAC_REG_X_LENGTH, sg->hw->x_len);
-	axi_dmac_write(dmac, AXI_DMAC_REG_Y_LENGTH, sg->hw->y_len);
+	if (chan->hw_sg) {
+		axi_dmac_write(dmac, AXI_DMAC_REG_SG_ADDRESS, (u32)sg->hw_phys);
+		axi_dmac_write(dmac, AXI_DMAC_REG_SG_ADDRESS_HIGH,
+			       (u64)sg->hw_phys >> 32);
+	} else {
+		axi_dmac_write(dmac, AXI_DMAC_REG_X_LENGTH, sg->hw->x_len);
+		axi_dmac_write(dmac, AXI_DMAC_REG_Y_LENGTH, sg->hw->y_len);
+	}
 	axi_dmac_write(dmac, AXI_DMAC_REG_FLAGS, flags);
 	axi_dmac_write(dmac, AXI_DMAC_REG_START_TRANSFER, 1);
 }
@@ -359,6 +379,9 @@ static void axi_dmac_compute_residue(struct axi_dmac_chan *chan,
 	rslt->result = DMA_TRANS_NOERROR;
 	rslt->residue = 0;
 
+	if (chan->hw_sg)
+		return;
+
 	/*
 	 * We get here if the last completed segment is partial, which
 	 * means we can compute the residue from that segment onwards
@@ -385,36 +408,46 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 	    (completed_transfers & AXI_DMAC_FLAG_PARTIAL_XFER_DONE))
 		axi_dmac_dequeue_partial_xfers(chan);
 
-	do {
-		sg = &active->sg[active->num_completed];
-		if (sg->hw->id == AXI_DMAC_SG_UNUSED) /* Not yet submitted */
-			break;
-		if (!(BIT(sg->hw->id) & completed_transfers))
-			break;
-		active->num_completed++;
-		sg->hw->id = AXI_DMAC_SG_UNUSED;
-		if (sg->schedule_when_free) {
-			sg->schedule_when_free = false;
-			start_next = true;
+	if (chan->hw_sg) {
+		if (active->cyclic) {
+			vchan_cyclic_callback(&active->vdesc);
+		} else {
+			list_del(&active->vdesc.node);
+			vchan_cookie_complete(&active->vdesc);
+			active = axi_dmac_active_desc(chan);
 		}
+	} else {
+		do {
+			sg = &active->sg[active->num_completed];
+			if (sg->hw->id == AXI_DMAC_SG_UNUSED) /* Not yet submitted */
+				break;
+			if (!(BIT(sg->hw->id) & completed_transfers))
+				break;
+			active->num_completed++;
+			sg->hw->id = AXI_DMAC_SG_UNUSED;
+			if (sg->schedule_when_free) {
+				sg->schedule_when_free = false;
+				start_next = true;
+			}
 
-		if (sg->partial_len)
-			axi_dmac_compute_residue(chan, active);
+			if (sg->partial_len)
+				axi_dmac_compute_residue(chan, active);
 
-		if (active->cyclic)
-			vchan_cyclic_callback(&active->vdesc);
+			if (active->cyclic)
+				vchan_cyclic_callback(&active->vdesc);
 
-		if (active->num_completed == active->num_sgs ||
-		    sg->partial_len) {
-			if (active->cyclic) {
-				active->num_completed = 0; /* wrap around */
-			} else {
-				list_del(&active->vdesc.node);
-				vchan_cookie_complete(&active->vdesc);
-				active = axi_dmac_active_desc(chan);
+			if (active->num_completed == active->num_sgs ||
+			    sg->partial_len) {
+				if (active->cyclic) {
+					active->num_completed = 0; /* wrap around */
+				} else {
+					list_del(&active->vdesc.node);
+					vchan_cookie_complete(&active->vdesc);
+					active = axi_dmac_active_desc(chan);
+				}
 			}
-		}
-	} while (active);
+		} while (active);
+	}
 
 	return start_next;
 }
@@ -478,8 +511,12 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
 	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
 	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
 	unsigned long flags;
+	u32 ctrl = AXI_DMAC_CTRL_ENABLE;
+
+	if (chan->hw_sg)
+		ctrl |= AXI_DMAC_CTRL_ENABLE_SG;
 
-	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, AXI_DMAC_CTRL_ENABLE);
+	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, ctrl);
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 	if (vchan_issue_pending(&chan->vchan))
@@ -516,8 +553,14 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 
 		hws[i].id = AXI_DMAC_SG_UNUSED;
 		hws[i].flags = 0;
+
+		/* Link hardware descriptors */
+		hws[i].next_sg_addr = hw_phys + (i + 1) * sizeof(*hws);
 	}
 
+	/* The last hardware descriptor will trigger an interrupt */
+	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
+
 	return desc;
 }
 
@@ -753,6 +796,9 @@ static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
 	case AXI_DMAC_REG_CURRENT_DEST_ADDR:
 	case AXI_DMAC_REG_PARTIAL_XFER_LEN:
 	case AXI_DMAC_REG_PARTIAL_XFER_ID:
+	case AXI_DMAC_REG_CURRENT_SG_ID:
+	case AXI_DMAC_REG_SG_ADDRESS:
+	case AXI_DMAC_REG_SG_ADDRESS_HIGH:
 		return true;
 	default:
 		return false;
@@ -905,6 +951,10 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 	if (axi_dmac_read(dmac, AXI_DMAC_REG_FLAGS) == AXI_DMAC_FLAG_CYCLIC)
 		chan->hw_cyclic = true;
 
+	axi_dmac_write(dmac, AXI_DMAC_REG_SG_ADDRESS, 0xffffffff);
+	if (axi_dmac_read(dmac, AXI_DMAC_REG_SG_ADDRESS))
+		chan->hw_sg = true;
+
 	axi_dmac_write(dmac, AXI_DMAC_REG_Y_LENGTH, 1);
 	if (axi_dmac_read(dmac, AXI_DMAC_REG_Y_LENGTH) == 1)
 		chan->hw_2d = true;
@@ -1005,6 +1055,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
 	INIT_LIST_HEAD(&dma_dev->channels);
 
 	dmac->chan.vchan.desc_free = axi_dmac_desc_free;
-- 
2.42.0

