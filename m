Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D876B7C8201
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjJMJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjJMJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:26:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA36E7;
        Fri, 13 Oct 2023 02:26:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39D9QVwt061818;
        Fri, 13 Oct 2023 04:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697189191;
        bh=e66WxoyS1yIYxWQWBazzHelMukzQTaQYtgyFnNmtDwU=;
        h=From:To:CC:Subject:Date;
        b=XRtOGMrnSb0pjV3xIaBL3Uv+BmJUq7nCIX2CqSH9SdypU15xeJuyvhvVouhT0gAgE
         1+2FqX2gj3/vm5kQZOth7+TWW0UVaElkK6ti+3RcnidV92Mpy/i7vEyvig6cba8/ln
         bantla4Fi6Hyz60QXCgC4Up5TDDqLRSWgKK4tebA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39D9QVfQ015418
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Oct 2023 04:26:31 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 04:26:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 04:26:31 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39D9QU2s014156;
        Fri, 13 Oct 2023 04:26:30 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH] spi: omap2-mcspi: Add FIFO support without DMA
Date:   Fri, 13 Oct 2023 14:56:29 +0530
Message-ID: <20231013092629.19005-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the built-in 64-byte FIFO on the MCSPI controller is not
enabled in PIO mode and is used only when DMA is enabled. Enable the
FIFO in PIO mode by default for transactions larger than the FIFO depth
and fallback only if FIFO is not available. When DMA is not enabled,
it is efficient to enable the RX FIFO almost full and TX FIFO almost
empty events after each FIFO fill instead of each word.

Update omap2_mcspi_set_fifo() to enable the events accordingly and
also rely on OMAP2_MCSPI_CHSTAT_RXS for the last transfer instead of the
FIFO events to handle the case when the transfer size is not a multiple
of FIFO depth.

See J721E Technical Reference Manual (SPRUI1C), section 12.1.5
for further details: http://www.ti.com/lit/pdf/spruil1

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

Tested on J721E SK for Master mode loopback for various transaction
size, BPW and clock:
https://gist.github.com/vaishnavachath/8374ff364f9b530d9b38035baf37a342
Tested on J7200 in Master-Slave loopback mode:
https://gist.github.com/vaishnavachath/0ecf790bbeccf802bda5ebaf16ebc4fe

 drivers/spi/spi-omap2-mcspi.c | 137 ++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index ddf1c684bcc7..a0c9fea908f5 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -53,6 +53,8 @@
 
 /* per-register bitmasks: */
 #define OMAP2_MCSPI_IRQSTATUS_EOW	BIT(17)
+#define OMAP2_MCSPI_IRQSTATUS_TX0_EMPTY    BIT(0)
+#define OMAP2_MCSPI_IRQSTATUS_RX0_FULL    BIT(2)
 
 #define OMAP2_MCSPI_MODULCTRL_SINGLE	BIT(0)
 #define OMAP2_MCSPI_MODULCTRL_MS	BIT(2)
@@ -291,7 +293,7 @@ static void omap2_mcspi_set_mode(struct spi_controller *ctlr)
 }
 
 static void omap2_mcspi_set_fifo(const struct spi_device *spi,
-				struct spi_transfer *t, int enable)
+				struct spi_transfer *t, int enable, int dma_enabled)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct omap2_mcspi_cs *cs = spi->controller_state;
@@ -312,20 +314,28 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH / 2;
 		else
 			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH;
-
-		wcnt = t->len / bytes_per_word;
+		if (dma_enabled)
+			wcnt = t->len / bytes_per_word;
+		else
+			wcnt = 0;
 		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
 			goto disable_fifo;
 
 		xferlevel = wcnt << 16;
 		if (t->rx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFER;
-			xferlevel |= (bytes_per_word - 1) << 8;
+			if (dma_enabled)
+				xferlevel |= (bytes_per_word - 1) << 8;
+			else
+				xferlevel |= (max_fifo_depth - 1) << 8;
 		}
 
 		if (t->tx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFET;
-			xferlevel |= bytes_per_word - 1;
+			if (dma_enabled)
+				xferlevel |= bytes_per_word - 1;
+			else
+				xferlevel |= (max_fifo_depth - 1);
 		}
 
 		mcspi_write_reg(ctlr, OMAP2_MCSPI_XFERLEVEL, xferlevel);
@@ -882,6 +892,113 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	return count - c;
 }
 
+static unsigned
+omap2_mcspi_txrx_piofifo(struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct omap2_mcspi_cs	*cs = spi->controller_state;
+	struct omap2_mcspi    *mcspi;
+	unsigned int		count, c;
+	unsigned int		iter, cwc;
+	int last_request;
+	void __iomem		*base = cs->base;
+	void __iomem		*tx_reg;
+	void __iomem		*rx_reg;
+	void __iomem		*chstat_reg;
+	void __iomem        *irqstat_reg;
+	int			word_len, bytes_per_word;
+	u8		*rx;
+	const u8	*tx;
+
+	mcspi = spi_controller_get_devdata(spi->controller);
+	count = xfer->len;
+	c = count;
+	word_len = cs->word_len;
+	bytes_per_word = mcspi_bytes_per_word(word_len);
+
+	/*
+	 * We store the pre-calculated register addresses on stack to speed
+	 * up the transfer loop.
+	 */
+	tx_reg		= base + OMAP2_MCSPI_TX0;
+	rx_reg		= base + OMAP2_MCSPI_RX0;
+	chstat_reg	= base + OMAP2_MCSPI_CHSTAT0;
+	irqstat_reg    = base + OMAP2_MCSPI_IRQSTATUS;
+
+	if (c < (word_len >> 3))
+		return 0;
+
+	rx = xfer->rx_buf;
+	tx = xfer->tx_buf;
+
+	do {
+		/* calculate number of words in current iteration */
+		cwc = min((unsigned int)mcspi->fifo_depth / bytes_per_word,
+			  c / bytes_per_word);
+		last_request = cwc != (mcspi->fifo_depth / bytes_per_word);
+		if (tx) {
+			if (mcspi_wait_for_reg_bit(irqstat_reg,
+						   OMAP2_MCSPI_IRQSTATUS_TX0_EMPTY) < 0) {
+				dev_err(&spi->dev, "TX Empty timed out\n");
+				goto out;
+			}
+			writel_relaxed(OMAP2_MCSPI_IRQSTATUS_TX0_EMPTY, irqstat_reg);
+
+			for (iter = 0; iter < cwc; iter++, tx += bytes_per_word) {
+				if (bytes_per_word == 1)
+					writel_relaxed(*tx, tx_reg);
+				else if (bytes_per_word == 2)
+					writel_relaxed(*((u16 *)tx), tx_reg);
+				else if (bytes_per_word == 4)
+					writel_relaxed(*((u32 *)tx), tx_reg);
+			}
+		}
+
+		if (rx) {
+			if (!last_request &&
+			    mcspi_wait_for_reg_bit(irqstat_reg,
+						   OMAP2_MCSPI_IRQSTATUS_RX0_FULL) < 0) {
+				dev_err(&spi->dev, "RX_FULL timed out\n");
+				goto out;
+			}
+			writel_relaxed(OMAP2_MCSPI_IRQSTATUS_RX0_FULL, irqstat_reg);
+
+			for (iter = 0; iter < cwc; iter++, rx += bytes_per_word) {
+				if (last_request &&
+				    mcspi_wait_for_reg_bit(chstat_reg,
+							   OMAP2_MCSPI_CHSTAT_RXS) < 0) {
+					dev_err(&spi->dev, "RXS timed out\n");
+					goto out;
+				}
+				if (bytes_per_word == 1)
+					*rx = readl_relaxed(rx_reg);
+				else if (bytes_per_word == 2)
+					*((u16 *)rx) = readl_relaxed(rx_reg);
+				else if (bytes_per_word == 4)
+					*((u32 *)rx) = readl_relaxed(rx_reg);
+			}
+		}
+
+		if (last_request) {
+			if (mcspi_wait_for_reg_bit(chstat_reg,
+						   OMAP2_MCSPI_CHSTAT_EOT) < 0) {
+				dev_err(&spi->dev, "EOT timed out\n");
+				goto out;
+			}
+			if (mcspi_wait_for_reg_bit(chstat_reg,
+						   OMAP2_MCSPI_CHSTAT_TXFFE) < 0) {
+				dev_err(&spi->dev, "TXFFE timed out\n");
+				goto out;
+			}
+			omap2_mcspi_set_enable(spi, 0);
+		}
+		c -= cwc * bytes_per_word;
+	} while (c >= bytes_per_word);
+
+out:
+	omap2_mcspi_set_enable(spi, 1);
+	return count - c;
+}
+
 static u32 omap2_mcspi_calc_divisor(u32 speed_hz, u32 ref_clk_hz)
 {
 	u32 div;
@@ -1206,7 +1323,9 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
 		    ctlr->cur_msg_mapped &&
 		    ctlr->can_dma(ctlr, spi, t))
-			omap2_mcspi_set_fifo(spi, t, 1);
+			omap2_mcspi_set_fifo(spi, t, 1, 1);
+		else if (t->len > OMAP2_MCSPI_MAX_FIFODEPTH)
+			omap2_mcspi_set_fifo(spi, t, 1, 0);
 
 		omap2_mcspi_set_enable(spi, 1);
 
@@ -1219,6 +1338,8 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		    ctlr->cur_msg_mapped &&
 		    ctlr->can_dma(ctlr, spi, t))
 			count = omap2_mcspi_txrx_dma(spi, t);
+		else if (mcspi->fifo_depth > 0)
+			count = omap2_mcspi_txrx_piofifo(spi, t);
 		else
 			count = omap2_mcspi_txrx_pio(spi, t);
 
@@ -1231,7 +1352,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 	omap2_mcspi_set_enable(spi, 0);
 
 	if (mcspi->fifo_depth > 0)
-		omap2_mcspi_set_fifo(spi, t, 0);
+		omap2_mcspi_set_fifo(spi, t, 0, 0);
 
 out:
 	/* Restore defaults if they were overriden */
@@ -1254,7 +1375,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		omap2_mcspi_set_cs(spi, !(spi->mode & SPI_CS_HIGH));
 
 	if (mcspi->fifo_depth > 0 && t)
-		omap2_mcspi_set_fifo(spi, t, 0);
+		omap2_mcspi_set_fifo(spi, t, 0, 0);
 
 	return status;
 }
-- 
2.17.1

