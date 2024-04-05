Return-Path: <linux-kernel+bounces-132449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F48C899507
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D32825B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D922574B;
	Fri,  5 Apr 2024 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekMXKAld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D68249FA;
	Fri,  5 Apr 2024 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297353; cv=none; b=lNmPFJCkBSR5X8ni21vcphERah9aJbGPkAsRQ2Hl+TUEm5Oxw59izKXCrjcSXjJRqUy12R5N5/PESxS0zGSD4x6X+J9i5zTOOKY3SLvTcrXO9DXBm2wLp7R2ebIaAaAShQqGb7myF0/R2i/vHaGz5h/dHVCEITlzy1C0weGbCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297353; c=relaxed/simple;
	bh=KVsipsYsYMv/yG54CaStidUVpSv0BOqzJ7Q6MUmF5/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVQS7sJ2DzmYcJfzI+JAotXc/ZImN3mpc7k/c5xq62y+QsuGMcbMZwGvaorJwK7VPA/aiE0LYxw+3T1+uTLiLVm32C3bfI+E5bc7CvxzamqsKNjVqTuYP3gvOU+4miSUmqwpISFByDl7KKBQu/RIBOZplpgpJGOZ9asc5408BAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekMXKAld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEA9C43601;
	Fri,  5 Apr 2024 06:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297352;
	bh=KVsipsYsYMv/yG54CaStidUVpSv0BOqzJ7Q6MUmF5/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekMXKAldDk5A0/hhar1jOHHOX2Q5+uattPl9QYCAt6X9v1wnsFeNGA1JosAZ/es0X
	 Tiv9Q7/ymF1zFeZK9G2HdhWRr/TJV+uklFxWM84Wfg7IhH7YNmqv6izFsp7pLjCcaS
	 Rs2fYi35XmLWrR1l31E9Q+PVEjdJxhqzlrYUjIhJywMzefdHXaGf188SisQHImiei7
	 1amEhnFN4i+aa5BPaH5qv4CFUSnoJtveexr2aIp1C/ugP6OBhcgDT8WjJLJcBNVQRM
	 36p6EhJNL1HkZOoKC5fkGjeH4CVtZY3jbuW3dHjT+F4rCvlZ3j8F4+LyXnd088JGIW
	 eOUjnglwhNl3A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Genoud <richard.genoud@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/15] tty: atmel_serial: use single DMA mapping for TX
Date: Fri,  5 Apr 2024 08:08:24 +0200
Message-ID: <20240405060826.2521-14-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405060826.2521-1-jirislaby@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
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


