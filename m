Return-Path: <linux-kernel+bounces-86962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3653A86CD9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4561C20FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3CF15AAAA;
	Thu, 29 Feb 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPQ3oin0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D71586FF;
	Thu, 29 Feb 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221758; cv=none; b=IpZNJ9ZzGmHOv1lQsWzauV3LsXYxBc8r6x0je2C9O+kbp4Jvfl4glEevRjzuTDRIwgRtIVVkYaA+d5+iSMmW9xjDySvAhkegnMVWeWBDxjkpmJZYdVwdDBloPxNdAWrEot7QeGrPH8BU6Av4cp7Frt6AAF6RAvGRs+7kYZy/Y6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221758; c=relaxed/simple;
	bh=X8xi5ulVDvWHEFyQpajeeYb0ov7OAfdj5YDVFw630mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rj/UzDG2fJEW+iD/hb+Nl0eXKclQPkPchZOCcrPr/BUUN0SLABth+9PVujzwEnaXbBS85ukp5cH4troo4ogpjA2p0FFTcNQAjf2SO2rRlQQZjL/0rSydbQ4uGoKAw/o6741Ucy8I/sD9Ko3vLAdEiHhAK/lKDDZKbJFnGHJLb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPQ3oin0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1F8C43399;
	Thu, 29 Feb 2024 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221758;
	bh=X8xi5ulVDvWHEFyQpajeeYb0ov7OAfdj5YDVFw630mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPQ3oin0tN9+zZ4cpWYnBwCRzMwr+VmTP1unhK0J+Ryq4+SnXhaklzEH+0v1KNWZB
	 N+ZgxwsE14xt2vaJ2Uk+V9rT/ojK+gXzqvih5J+AQOp4juQvzRTCIkgWaXVeQ3x2oJ
	 T6aaVBjipKpuxZ9pfZ7qSolZN5R3VBgot81BayhwvPsOz727Y0loC4h2P9p7JxY6k4
	 O5VZ2Mq1W5Cuz6oy1zYcPJWLf9Rc3XdcK8NJo/HAMHYeyqAevMoXR439SWkXM4Tri9
	 9FamUrx1nqRzzGYQOQlQIXafqrpYx9JqJQMSu9x3F4unt+OVjQr8I0N670qzNyNA4j
	 ymgb63mkW5aCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vaishnav Achath <vaishnav.a@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 14/26] spi: omap2-mcspi: Revert FIFO support without DMA
Date: Thu, 29 Feb 2024 10:48:33 -0500
Message-ID: <20240229154851.2849367-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
Content-Transfer-Encoding: 8bit

From: Vaishnav Achath <vaishnav.a@ti.com>

[ Upstream commit e56c671c2272d939d48a66be7e73b92b74c560c2 ]

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

This reverts commit 75223bbea840e ("spi: omap2-mcspi: Add FIFO support
without DMA")

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Link: https://msgid.link/r/20240212120049.438495-1-vaishnav.a@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 137 ++--------------------------------
 1 file changed, 8 insertions(+), 129 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a0c9fea908f55..ddf1c684bcc7d 100644
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
2.43.0


