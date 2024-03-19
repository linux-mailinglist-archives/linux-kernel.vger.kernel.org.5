Return-Path: <linux-kernel+bounces-107346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1EC87FB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24AC1F22766
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCD7E11E;
	Tue, 19 Mar 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+qwvN0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5A7D414;
	Tue, 19 Mar 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842043; cv=none; b=W0bszxTrxM1KtGYS7SaT3xHbl/CVhrAbGOHbmWAbZplmmhk2A9GcucsZ5u+LCSRSm700Tba47BBCbST9hOdNvGaka+kKEf+2qwveCxn1TliHvJZS+S1NCbapw8S4yifwP6Uj2ADYWWDvySIcBI2Jq16lzQHPUXqcieL/61S3KiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842043; c=relaxed/simple;
	bh=KVsipsYsYMv/yG54CaStidUVpSv0BOqzJ7Q6MUmF5/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Od8rfYa60LosbQLupyZVCRFtbB8CydI2/UfHVyQ2yaoJvxkLqBipW017PNXoAQ6n9hhmZ60PHJsTZ166yIeUFltT9wXR/dV3ZrNjy5knXm5V+YY6oJanDABpyW67E5tcXAxOFLh4K5PVmDZh89nM10j5RDvApQan4rl1rt+57QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+qwvN0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEABC43601;
	Tue, 19 Mar 2024 09:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842042;
	bh=KVsipsYsYMv/yG54CaStidUVpSv0BOqzJ7Q6MUmF5/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+qwvN0dgxcQyA6bJGG66rqN3tQzUNPZSEiqs3uoamxXDksjF2tHATKVvAA+BbFka
	 DpWYKg6rbdYoTTv/6x9bVkkaHKxAwTubIVUmWjlpMd56NDyoeBJmSsUX+mVAb8dCBC
	 ijmhPlTdjA2mVS18wri5El2cYvuL52fsZFe6bun7UDOptay9Ia+lUcKOu2MTMoGxfZ
	 pZGwY3PGsxXqSSfS+TjYqAFlOeK9tNVU60AjlNnL4SGfJ2P+vP4UHV3y7WkiLwny4u
	 ZlVyH8RadcLEG6aj+piE10IkMR6qHVKyuF6k67Ov5BMMOFbqs5r+mKM/rCbXyPOfFT
	 Zl7Xr6hQ/DYfA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Genoud <richard.genoud@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFT 13/15] tty: atmel_serial: use single DMA mapping for TX
Date: Tue, 19 Mar 2024 10:53:13 +0100
Message-ID: <20240319095315.27624-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_map_single() provides much easier interface for simple mappings as
used for TX in atmel_serial. So switch to that, removing all the s-g
unnecessary handling.

Note that it is not easy (maybe impossible) to use kfifo_dma_* API for
atmel's serial purposes. It handles DMA very specially.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/atmel_serial.c | 35 +++++++++++++------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5bb5e4303754..69ec80ffc97b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -132,7 +132,7 @@ struct atmel_uart_port {
 	struct dma_async_tx_descriptor	*desc_rx;
 	dma_cookie_t			cookie_tx;
 	dma_cookie_t			cookie_rx;
-	struct scatterlist		sg_tx;
+	dma_addr_t			tx_phys;
 	struct scatterlist		sg_rx;
 	struct tasklet_struct	tasklet_rx;
 	struct tasklet_struct	tasklet_tx;
@@ -904,8 +904,8 @@ static void atmel_release_tx_dma(struct uart_port *port)
 	if (chan) {
 		dmaengine_terminate_all(chan);
 		dma_release_channel(chan);
-		dma_unmap_sg(port->dev, &atmel_port->sg_tx, 1,
-				DMA_TO_DEVICE);
+		dma_unmap_single(port->dev, atmel_port->tx_phys,
+				 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	}
 
 	atmel_port->desc_tx = NULL;
@@ -922,7 +922,7 @@ static void atmel_tx_dma(struct uart_port *port)
 	struct tty_port *tport = &port->state->port;
 	struct dma_chan *chan = atmel_port->chan_tx;
 	struct dma_async_tx_descriptor *desc;
-	struct scatterlist sgl[2], *sg, *sg_tx = &atmel_port->sg_tx;
+	struct scatterlist sgl[2], *sg;
 	unsigned int tx_len, tail, part1_len, part2_len, sg_len;
 	dma_addr_t phys_addr;
 
@@ -955,7 +955,7 @@ static void atmel_tx_dma(struct uart_port *port)
 
 		sg_init_table(sgl, 2);
 		sg_len = 0;
-		phys_addr = sg_dma_address(sg_tx) + tail;
+		phys_addr = atmel_port->tx_phys + tail;
 		if (part1_len) {
 			sg = &sgl[sg_len++];
 			sg_dma_address(sg) = phys_addr;
@@ -987,7 +987,8 @@ static void atmel_tx_dma(struct uart_port *port)
 			return;
 		}
 
-		dma_sync_sg_for_device(port->dev, sg_tx, 1, DMA_TO_DEVICE);
+		dma_sync_single_for_device(port->dev, atmel_port->tx_phys,
+					   UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 		atmel_port->desc_tx = desc;
 		desc->callback = atmel_complete_tx_dma;
@@ -1014,7 +1015,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	dma_cap_mask_t		mask;
 	struct dma_slave_config config;
 	struct dma_chan *chan;
-	int ret, nent;
+	int ret;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -1029,26 +1030,18 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 		dma_chan_name(atmel_port->chan_tx));
 
 	spin_lock_init(&atmel_port->lock_tx);
-	sg_init_table(&atmel_port->sg_tx, 1);
 	/* UART circular tx buffer is an aligned page. */
 	BUG_ON(!PAGE_ALIGNED(tport->xmit_buf));
-	sg_set_page(&atmel_port->sg_tx,
-			virt_to_page(tport->xmit_buf),
-			UART_XMIT_SIZE,
-			offset_in_page(tport->xmit_buf));
-	nent = dma_map_sg(port->dev,
-				&atmel_port->sg_tx,
-				1,
-				DMA_TO_DEVICE);
+	atmel_port->tx_phys = dma_map_single(port->dev, tport->xmit_buf,
+					     UART_XMIT_SIZE, DMA_TO_DEVICE);
 
-	if (!nent) {
+	if (dma_mapping_error(port->dev, atmel_port->tx_phys)) {
 		dev_dbg(port->dev, "need to release resource of dma\n");
 		goto chan_err;
 	} else {
-		dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n", __func__,
-			sg_dma_len(&atmel_port->sg_tx),
-			tport->xmit_buf,
-			&sg_dma_address(&atmel_port->sg_tx));
+		dev_dbg(port->dev, "%s: mapped %lu@%p to %pad\n", __func__,
+			UART_XMIT_SIZE, tport->xmit_buf,
+			&atmel_port->tx_phys);
 	}
 
 	/* Configure the slave DMA */
-- 
2.44.0


