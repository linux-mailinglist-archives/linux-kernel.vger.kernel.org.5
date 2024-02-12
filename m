Return-Path: <linux-kernel+bounces-61500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F02468512F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C532839AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B063A8DC;
	Mon, 12 Feb 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TCqu/fIn"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762C3A8D0;
	Mon, 12 Feb 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739259; cv=none; b=INSAPP9tGy5n4EgL3zUzKSxbvS7zDxln3hOUba5JlI4UOZ5vemoQQxXS94j8JUNt00gAd37mEDI3896VKZ80PJ+/VSf/ffgGPPk1mj5rsxNhddQO9DlqCrvOWY9hhDD+LibuUGyC5ymneAcXQNkkrZsZ7R5fEtBx8Frc5Z2o/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739259; c=relaxed/simple;
	bh=fBPh4u4tVAxhauhC0Yb1yVeuyaYm5kQBQbtRTvlFcHY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DvBvTQ8efGS1j4qEDo5Lj7djAJ25bjbTbLAQExC1t8DYBnbGmI672iengDhpGQRjXMlpmL+yFitWvJGkMFaeTap1JXGJXmMInr5gEkFRNRWN5McyO7vW534whphazldVnpoYNkeiVriyjwrvQoe1dDbfgQYVQZYeZGk6mVPSePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TCqu/fIn; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CC0qJ0001008;
	Mon, 12 Feb 2024 06:00:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707739252;
	bh=LqDoE8mxdm+tXcZyOrm6S/Dp6GDW7NfOGTIPDKoBP1g=;
	h=From:To:CC:Subject:Date;
	b=TCqu/fInad3ktQ/jbpPrex28hra+apckaU7CThjbxeap5hNMZDMzkEj2ycUNG1PSi
	 GF+/aHAukY4ao5i4gci4rOXqrJF7PLTOcPGPc7GQKgjS+3G4A2qMk94MuuksUsfGj/
	 BgqKDnxY0XOupvKsJbGHcprNyaItzwE5PNkjCbNo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CC0qKU016119
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 06:00:52 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 06:00:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 06:00:52 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CC0nw1082905;
	Mon, 12 Feb 2024 06:00:50 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH] spi: omap2-mcspi: Revert FIFO support without DMA
Date: Mon, 12 Feb 2024 17:30:49 +0530
Message-ID: <20240212120049.438495-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

MCSPI controller have few limitations regarding the transaction
size when the FIFO buffer is enabled and the WCNT feature is used
to find the end of word, in this case if WCNT is not a multiple of
the FIFO Almost Empty Level (AEL), then the FIFO empty event is not
generated correctly. In addition to this limitation, few other unknown
sequence of events that causes the FIFO empty status to not reflect the
exact status were found when FIFO is being used without DMA enabled
during extended testing in AM65x platform. Till the exact root cause
is found and fixed, revert the FIFO support without DMA.

See J721E Technical Reference Manual (SPRUI1C), section 12.1.5
for further details: http://www.ti.com/lit/pdf/spruil1

This reverts commit 75223bbea840e125359fc63942b5f93462b474c6.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 137 ++--------------------------------
 1 file changed, 8 insertions(+), 129 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a0c9fea908f5..ddf1c684bcc7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -53,8 +53,6 @@
 
 /* per-register bitmasks: */
 #define OMAP2_MCSPI_IRQSTATUS_EOW	BIT(17)
-#define OMAP2_MCSPI_IRQSTATUS_TX0_EMPTY    BIT(0)
-#define OMAP2_MCSPI_IRQSTATUS_RX0_FULL    BIT(2)
 
 #define OMAP2_MCSPI_MODULCTRL_SINGLE	BIT(0)
 #define OMAP2_MCSPI_MODULCTRL_MS	BIT(2)
@@ -293,7 +291,7 @@ static void omap2_mcspi_set_mode(struct spi_controller *ctlr)
 }
 
 static void omap2_mcspi_set_fifo(const struct spi_device *spi,
-				struct spi_transfer *t, int enable, int dma_enabled)
+				struct spi_transfer *t, int enable)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct omap2_mcspi_cs *cs = spi->controller_state;
@@ -314,28 +312,20 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH / 2;
 		else
 			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH;
-		if (dma_enabled)
-			wcnt = t->len / bytes_per_word;
-		else
-			wcnt = 0;
+
+		wcnt = t->len / bytes_per_word;
 		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
 			goto disable_fifo;
 
 		xferlevel = wcnt << 16;
 		if (t->rx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFER;
-			if (dma_enabled)
-				xferlevel |= (bytes_per_word - 1) << 8;
-			else
-				xferlevel |= (max_fifo_depth - 1) << 8;
+			xferlevel |= (bytes_per_word - 1) << 8;
 		}
 
 		if (t->tx_buf != NULL) {
 			chconf |= OMAP2_MCSPI_CHCONF_FFET;
-			if (dma_enabled)
-				xferlevel |= bytes_per_word - 1;
-			else
-				xferlevel |= (max_fifo_depth - 1);
+			xferlevel |= bytes_per_word - 1;
 		}
 
 		mcspi_write_reg(ctlr, OMAP2_MCSPI_XFERLEVEL, xferlevel);
@@ -892,113 +882,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	return count - c;
 }
 
-static unsigned
-omap2_mcspi_txrx_piofifo(struct spi_device *spi, struct spi_transfer *xfer)
-{
-	struct omap2_mcspi_cs	*cs = spi->controller_state;
-	struct omap2_mcspi    *mcspi;
-	unsigned int		count, c;
-	unsigned int		iter, cwc;
-	int last_request;
-	void __iomem		*base = cs->base;
-	void __iomem		*tx_reg;
-	void __iomem		*rx_reg;
-	void __iomem		*chstat_reg;
-	void __iomem        *irqstat_reg;
-	int			word_len, bytes_per_word;
-	u8		*rx;
-	const u8	*tx;
-
-	mcspi = spi_controller_get_devdata(spi->controller);
-	count = xfer->len;
-	c = count;
-	word_len = cs->word_len;
-	bytes_per_word = mcspi_bytes_per_word(word_len);
-
-	/*
-	 * We store the pre-calculated register addresses on stack to speed
-	 * up the transfer loop.
-	 */
-	tx_reg		= base + OMAP2_MCSPI_TX0;
-	rx_reg		= base + OMAP2_MCSPI_RX0;
-	chstat_reg	= base + OMAP2_MCSPI_CHSTAT0;
-	irqstat_reg    = base + OMAP2_MCSPI_IRQSTATUS;
-
-	if (c < (word_len >> 3))
-		return 0;
-
-	rx = xfer->rx_buf;
-	tx = xfer->tx_buf;
-
-	do {
-		/* calculate number of words in current iteration */
-		cwc = min((unsigned int)mcspi->fifo_depth / bytes_per_word,
-			  c / bytes_per_word);
-		last_request = cwc != (mcspi->fifo_depth / bytes_per_word);
-		if (tx) {
-			if (mcspi_wait_for_reg_bit(irqstat_reg,
-						   OMAP2_MCSPI_IRQSTATUS_TX0_EMPTY) < 0) {
-				dev_err(&spi->dev, "TX Empty timed out\n");
-				goto out;
-			}
-			writel_relaxed(OMAP2_MCSPI_IRQSTATUS_TX0_EMPTY, irqstat_reg);
-
-			for (iter = 0; iter < cwc; iter++, tx += bytes_per_word) {
-				if (bytes_per_word == 1)
-					writel_relaxed(*tx, tx_reg);
-				else if (bytes_per_word == 2)
-					writel_relaxed(*((u16 *)tx), tx_reg);
-				else if (bytes_per_word == 4)
-					writel_relaxed(*((u32 *)tx), tx_reg);
-			}
-		}
-
-		if (rx) {
-			if (!last_request &&
-			    mcspi_wait_for_reg_bit(irqstat_reg,
-						   OMAP2_MCSPI_IRQSTATUS_RX0_FULL) < 0) {
-				dev_err(&spi->dev, "RX_FULL timed out\n");
-				goto out;
-			}
-			writel_relaxed(OMAP2_MCSPI_IRQSTATUS_RX0_FULL, irqstat_reg);
-
-			for (iter = 0; iter < cwc; iter++, rx += bytes_per_word) {
-				if (last_request &&
-				    mcspi_wait_for_reg_bit(chstat_reg,
-							   OMAP2_MCSPI_CHSTAT_RXS) < 0) {
-					dev_err(&spi->dev, "RXS timed out\n");
-					goto out;
-				}
-				if (bytes_per_word == 1)
-					*rx = readl_relaxed(rx_reg);
-				else if (bytes_per_word == 2)
-					*((u16 *)rx) = readl_relaxed(rx_reg);
-				else if (bytes_per_word == 4)
-					*((u32 *)rx) = readl_relaxed(rx_reg);
-			}
-		}
-
-		if (last_request) {
-			if (mcspi_wait_for_reg_bit(chstat_reg,
-						   OMAP2_MCSPI_CHSTAT_EOT) < 0) {
-				dev_err(&spi->dev, "EOT timed out\n");
-				goto out;
-			}
-			if (mcspi_wait_for_reg_bit(chstat_reg,
-						   OMAP2_MCSPI_CHSTAT_TXFFE) < 0) {
-				dev_err(&spi->dev, "TXFFE timed out\n");
-				goto out;
-			}
-			omap2_mcspi_set_enable(spi, 0);
-		}
-		c -= cwc * bytes_per_word;
-	} while (c >= bytes_per_word);
-
-out:
-	omap2_mcspi_set_enable(spi, 1);
-	return count - c;
-}
-
 static u32 omap2_mcspi_calc_divisor(u32 speed_hz, u32 ref_clk_hz)
 {
 	u32 div;
@@ -1323,9 +1206,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
 		    ctlr->cur_msg_mapped &&
 		    ctlr->can_dma(ctlr, spi, t))
-			omap2_mcspi_set_fifo(spi, t, 1, 1);
-		else if (t->len > OMAP2_MCSPI_MAX_FIFODEPTH)
-			omap2_mcspi_set_fifo(spi, t, 1, 0);
+			omap2_mcspi_set_fifo(spi, t, 1);
 
 		omap2_mcspi_set_enable(spi, 1);
 
@@ -1338,8 +1219,6 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		    ctlr->cur_msg_mapped &&
 		    ctlr->can_dma(ctlr, spi, t))
 			count = omap2_mcspi_txrx_dma(spi, t);
-		else if (mcspi->fifo_depth > 0)
-			count = omap2_mcspi_txrx_piofifo(spi, t);
 		else
 			count = omap2_mcspi_txrx_pio(spi, t);
 
@@ -1352,7 +1231,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 	omap2_mcspi_set_enable(spi, 0);
 
 	if (mcspi->fifo_depth > 0)
-		omap2_mcspi_set_fifo(spi, t, 0, 0);
+		omap2_mcspi_set_fifo(spi, t, 0);
 
 out:
 	/* Restore defaults if they were overriden */
@@ -1375,7 +1254,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		omap2_mcspi_set_cs(spi, !(spi->mode & SPI_CS_HIGH));
 
 	if (mcspi->fifo_depth > 0 && t)
-		omap2_mcspi_set_fifo(spi, t, 0, 0);
+		omap2_mcspi_set_fifo(spi, t, 0);
 
 	return status;
 }
-- 
2.34.1


