Return-Path: <linux-kernel+bounces-871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F0481474A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D101C2327A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8B2C865;
	Fri, 15 Dec 2023 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hlWVnDA6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC232556B;
	Fri, 15 Dec 2023 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702641029; x=1734177029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+c81t6P+VrINi52C/mrkf7kTMz9CCpU+nj9sKXqCplI=;
  b=hlWVnDA67ouRf7ETxRCJZ2wnIQoMPbzgIoK/CjYa4ZincobVA4YKemCI
   Me8phZapwCqB/G/j46xN4zfDYimbMmrq+Tmqf+hBth8ztdje2/kJM15qA
   oJ7EqtzPSDEd5FXS5CUatS/MqMDnJiPjsCLdyz+V1RtvgQW9IWNNcico4
   y5mtW/biaYqC3/e8rdR+x9iFEk5biR95n2nA+eDvF6NxdUpvquIBClB13
   tmH+8LnQAYn/42TYa1R+y9+6BHiUMsn/5tyrL7SsucS3kkKE3b/WzM/0M
   /Ze+Yg7Vl1I8ePnBdeqicrHIx3X5nfCUq1mv8VAlhEAhBdRP+X7rUIb6I
   g==;
X-CSE-ConnectionGUID: LGva2yzVSgmRfFnu4BtIaw==
X-CSE-MsgGUID: +5RO2q1pS+ydHvkV8he07w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="14317231"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2023 04:50:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 04:50:14 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 04:50:11 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Tharunkumar.Pasumarthi@microchip.com>,
	<Kumaravel.Thiagarajan@microchip.com>, <Arun.Ramadoss@microchip.com>,
	<Ronnie.Kunin@microchip.com>, <jegadheesan.gopalmanoharan@microchip.com>
Subject: [PATCH SPI for-next 3/3] spi: mchp-pci1xxxx: DMA Write Support for copying data from SPI Buf
Date: Fri, 15 Dec 2023 17:17:48 +0530
Message-ID: <20231215114748.152319-4-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215114748.152319-1-thangaraj.s@microchip.com>
References: <20231215114748.152319-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

DMA Write setup is done in pci1xxxx_spi_transfer_with_dma, before
initiating the transaction. Once the SPI transaction complete interrupt
is received, doorbell is written to initiate DMA Write. DMA Write operation
copies the data from SPI RX buffer to CPU buffer.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 93 +++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 824885ada9b6..5dcb63c367b9 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -57,8 +57,13 @@
 /* DMA Related Registers */
 #define SPI_DMA_ADDR_BASE		(0x1000)
 #define SPI_DMA_GLOBAL_WR_ENGINE_EN	(SPI_DMA_ADDR_BASE + 0x0C)
+#define SPI_DMA_WR_DOORBELL_REG		(SPI_DMA_ADDR_BASE + 0x10)
 #define SPI_DMA_GLOBAL_RD_ENGINE_EN	(SPI_DMA_ADDR_BASE + 0x2C)
 #define SPI_DMA_RD_DOORBELL_REG		(SPI_DMA_ADDR_BASE + 0x30)
+#define SPI_DMA_INTR_WR_STS		(SPI_DMA_ADDR_BASE + 0x4C)
+#define SPI_DMA_WR_INT_MASK		(SPI_DMA_ADDR_BASE + 0x54)
+#define SPI_DMA_INTR_WR_CLR		(SPI_DMA_ADDR_BASE + 0x58)
+#define SPI_DMA_ERR_WR_STS		(SPI_DMA_ADDR_BASE + 0x5C)
 #define SPI_DMA_INTR_IMWR_WDONE_LOW	(SPI_DMA_ADDR_BASE + 0x60)
 #define SPI_DMA_INTR_IMWR_WDONE_HIGH	(SPI_DMA_ADDR_BASE + 0x64)
 #define SPI_DMA_INTR_IMWR_WABORT_LOW	(SPI_DMA_ADDR_BASE + 0x68)
@@ -74,7 +79,9 @@
 #define SPI_DMA_INTR_IMWR_RABORT_HIGH	(SPI_DMA_ADDR_BASE + 0xD8)
 #define SPI_DMA_INTR_RD_IMWR_DATA	(SPI_DMA_ADDR_BASE + 0xDC)
 
+#define SPI_DMA_CH0_WR_BASE		(SPI_DMA_ADDR_BASE + 0x200)
 #define SPI_DMA_CH0_RD_BASE		(SPI_DMA_ADDR_BASE + 0x300)
+#define SPI_DMA_CH1_WR_BASE		(SPI_DMA_ADDR_BASE + 0x400)
 #define SPI_DMA_CH1_RD_BASE		(SPI_DMA_ADDR_BASE + 0x500)
 
 #define SPI_DMA_CH_CTL1_OFFSET		(0x00)
@@ -126,7 +133,9 @@
 struct pci1xxxx_spi_internal {
 	u8 hw_inst;
 	bool spi_xfer_in_progress;
+	void *rx_buf;
 	bool dma_aborted_rd;
+	bool dma_aborted_wr;
 	int irq;
 	struct completion spi_xfer_done;
 	struct spi_controller *spi_host;
@@ -333,6 +342,26 @@ static void pci1xxxx_spi_setup_dma_read(struct pci1xxxx_spi_internal *p,
 	       base + SPI_DMA_CH_DAR_HI_OFFSET);
 }
 
+static void pci1xxxx_spi_setup_dma_write(struct pci1xxxx_spi_internal *p,
+					 dma_addr_t dma_addr, u32 len)
+{
+	void *base;
+
+	if (!p->hw_inst)
+		base = p->parent->dma_offset_bar + SPI_DMA_CH0_WR_BASE;
+	else
+		base = p->parent->dma_offset_bar + SPI_DMA_CH1_WR_BASE;
+
+	writel(DMA_INTR_EN, base + SPI_DMA_CH_CTL1_OFFSET);
+	writel(len, base + SPI_DMA_CH_XFER_LEN_OFFSET);
+	writel(lower_32_bits(dma_addr), base + SPI_DMA_CH_DAR_LO_OFFSET);
+	writel(upper_32_bits(dma_addr), base + SPI_DMA_CH_DAR_HI_OFFSET);
+	writel(lower_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_RSP_BUF_OFFSET(p->hw_inst)),
+	       base + SPI_DMA_CH_SAR_LO_OFFSET);
+	writel(upper_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_RSP_BUF_OFFSET(p->hw_inst)),
+	       base + SPI_DMA_CH_SAR_HI_OFFSET);
+}
+
 static void pci1xxxx_spi_setup(struct pci1xxxx_spi *par, u8 hw_inst, u32 mode,
 			       u8 clkdiv, u32 len)
 {
@@ -427,9 +456,9 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi_ctlr);
 	struct pci1xxxx_spi *par = p->parent;
 	struct device *dev = &par->dev->dev;
+	dma_addr_t rx_dma_addr = 0;
 	dma_addr_t tx_dma_addr = 0;
 	u64 bytes_transfered = 0;
-	u64 bytes_recvd = 0;
 	int loop_count;
 	int ret = 0;
 	u32 regval;
@@ -439,6 +468,7 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 	u32 i;
 
 	p->spi_xfer_in_progress = true;
+	p->rx_buf = xfer->rx_buf;
 	clkdiv = pci1xxxx_get_clock_div(xfer->speed_hz);
 	rx_buf = xfer->rx_buf;
 	regval = readl(par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
@@ -456,6 +486,15 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 		goto error;
 	}
 
+	if (xfer->rx_buf) {
+		rx_dma_addr = dma_map_single(dev, (void *)xfer->rx_buf, xfer->len, DMA_FROM_DEVICE);
+		if (dma_mapping_error(NULL, rx_dma_addr)) {
+			rx_dma_addr = 0;
+			ret = -ENOMEM;
+			goto error;
+		}
+	}
+
 	loop_count = DIV_ROUND_UP(xfer->len, SPI_MAX_DATA_LEN);
 	len = SPI_MAX_DATA_LEN;
 	pci1xxxx_spi_setup(par, p->hw_inst, spi->mode, clkdiv, len);
@@ -466,6 +505,8 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 		}
 
 		pci1xxxx_spi_setup_dma_read(p, (tx_dma_addr + bytes_transfered), len);
+		if (rx_dma_addr)
+			pci1xxxx_spi_setup_dma_write(p, (rx_dma_addr + bytes_transfered), len);
 
 		writel(p->hw_inst, par->dma_offset_bar + SPI_DMA_RD_DOORBELL_REG);
 
@@ -495,14 +536,31 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 				p->dma_aborted_rd = false;
 				ret = -ECANCELED;
 			}
+			if (p->dma_aborted_wr) {
+				writel(SPI_DMA_ENGINE_DIS,
+				       par->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
+
+				/*
+				 * DMA ENGINE reset takes time if any TLP
+				 * completeion in progress, should wait
+				 * till DMA Engine reset is completed.
+				 */
+				ret = readl_poll_timeout(par->dma_offset_bar +
+							 SPI_DMA_GLOBAL_WR_ENGINE_EN, regval,
+							 (regval == 0x0), 0, USEC_PER_MSEC);
+				if (ret) {
+					ret = -ECANCELED;
+					goto error;
+				}
+
+				writel(SPI_DMA_ENGINE_EN,
+				       par->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
+				p->dma_aborted_wr = false;
+				ret = -ECANCELED;
+			}
 			goto error;
 		}
 		bytes_transfered += len;
-		if (rx_buf) {
-			memcpy_fromio(&rx_buf[bytes_recvd], par->reg_base +
-				      SPI_MST_RSP_BUF_OFFSET(p->hw_inst), len);
-			bytes_recvd += len;
-		}
 		ret = 0;
 	}
 
@@ -510,6 +568,8 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 	p->spi_xfer_in_progress = false;
 	if (tx_dma_addr)
 		dma_unmap_single(dev, tx_dma_addr, xfer->len, DMA_TO_DEVICE);
+	if (rx_dma_addr)
+		dma_unmap_single(dev, rx_dma_addr, xfer->len, DMA_FROM_DEVICE);
 
 	return ret;
 }
@@ -525,7 +585,11 @@ static irqreturn_t pci1xxxx_spi_isr(int irq, void *dev)
 	regval = readl(p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	if (regval & SPI_INTR) {
 		/* Clear xfer_done */
-		complete(&p->spi_xfer_done);
+		if (p->parent->can_dma && p->rx_buf)
+			writel(p->hw_inst, p->parent->dma_offset_bar +
+			       SPI_DMA_WR_DOORBELL_REG);
+		else
+			complete(&p->parent->spi_int[p->hw_inst]->spi_xfer_done);
 		spi_int_fired = IRQ_HANDLED;
 	}
 
@@ -549,6 +613,21 @@ static irqreturn_t pci1xxxx_spi_isr(int irq, void *dev)
 		spi_int_fired = IRQ_HANDLED;
 	}
 	writel(regval, p->parent->dma_offset_bar + SPI_DMA_INTR_RD_CLR);
+
+	/* Clear the DMA WR INT */
+	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_WR_STS);
+	if (regval & SPI_DMA_DONE_INT_MASK) {
+		if (regval & SPI_DMA_CH0_DONE_INT)
+			complete(&p->parent->spi_int[SPI0]->spi_xfer_done);
+		if (regval & SPI_DMA_CH1_DONE_INT)
+			complete(&p->parent->spi_int[SPI1]->spi_xfer_done);
+		spi_int_fired = IRQ_HANDLED;
+	}
+	if (regval & SPI_DMA_ABORT_INT_MASK) {
+		p->dma_aborted_wr = true;
+		spi_int_fired = IRQ_HANDLED;
+	}
+	writel(regval, p->parent->dma_offset_bar + SPI_DMA_INTR_WR_CLR);
 	spin_unlock_irqrestore(&p->parent->dma_reg_lock, flags);
 
 	return spi_int_fired;
-- 
2.25.1


