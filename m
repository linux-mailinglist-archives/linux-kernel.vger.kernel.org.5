Return-Path: <linux-kernel+bounces-132455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5524F899512
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A3E1F219EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E6258103;
	Fri,  5 Apr 2024 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptB122nd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612052F6E;
	Fri,  5 Apr 2024 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297357; cv=none; b=ZzMq6IebqPa/U0i0pHUnkhjnMKjZPPsKkCWLFR4/9G7lC7txNqbz+Iecqd6gK/+YmMUwhyJ2dj5pfIxvaIfvY4qAzBWr0J0VVJsIOCT+GrXqqY6/fMJgmkc0VqazKEtrmaF6Ws2Xuixeb1DjOvXGD1lk7YG0ShE71fqPrk1ytqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297357; c=relaxed/simple;
	bh=/FjnStB/yZtMO26TOxQ+YsIrQb3A2biwdW2z1LAyxHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1uyPC9f1eYYZNWgwQZZvMoeOH1nowtGTQNR611RrXRyeiUD5EmDK0Q7aQAnOIGc7gozYMzF4qt1DJ180kIbBDM35+J3CFZPV02OykdsEiPh4eJqlrso2iGsqT+89hAX+ZuITXxGBns+KojDtFzVY8lKbQA0fdweax4R+/XpSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptB122nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89087C43399;
	Fri,  5 Apr 2024 06:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297357;
	bh=/FjnStB/yZtMO26TOxQ+YsIrQb3A2biwdW2z1LAyxHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptB122ndmL1qOaMN542Suz/jgypKSfUMNgqcdTXrsSn8apL2DaRjXXfT+dKuf0e8U
	 SknJ8928wFdXrmjaj2C3cPBnAxiUTRaNNlQPfKysbWnfkZ7D6hnXJOr32nok4IO9it
	 DmHPD8j2GOHHP4ApHNCKCL4Pvw6zQzn7BXR2gCrlfcXKGTSuzANT09FYhDS/fEglOc
	 Qn0+77Zr8CZo0rvKjRvNOlB1k5QMmpp8z6PWXkqwLHMyE2KIdaen7UihL634guJEqU
	 3UIoABuJy0/Ov20Q9qUEqUmVauGtkJkSnlYiS9WKGEeMVspbtd9uNhewpMEOWpPqnc
	 81aQ4aUasR7NA==
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
Subject: [PATCH 15/15] tty: atmel_serial: use single DMA mapping for RX
Date: Fri,  5 Apr 2024 08:08:26 +0200
Message-ID: <20240405060826.2521-16-jirislaby@kernel.org>
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
used for RX in atmel_serial. So switch to that, removing all the s-g
unnecessary handling.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/atmel_serial.c | 56 ++++++++++++-------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5cde5077c429..0a90964d6d10 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -135,7 +135,7 @@ struct atmel_uart_port {
 	dma_cookie_t			cookie_tx;
 	dma_cookie_t			cookie_rx;
 	dma_addr_t			tx_phys;
-	struct scatterlist		sg_rx;
+	dma_addr_t			rx_phys;
 	struct tasklet_struct	tasklet_rx;
 	struct tasklet_struct	tasklet_tx;
 	atomic_t		tasklet_shutdown;
@@ -1088,8 +1088,8 @@ static void atmel_release_rx_dma(struct uart_port *port)
 	if (chan) {
 		dmaengine_terminate_all(chan);
 		dma_release_channel(chan);
-		dma_unmap_sg(port->dev, &atmel_port->sg_rx, 1,
-				DMA_FROM_DEVICE);
+		dma_unmap_single(port->dev, atmel_port->rx_phys,
+				 ATMEL_SERIAL_RX_SIZE, DMA_FROM_DEVICE);
 	}
 
 	atmel_port->desc_rx = NULL;
@@ -1122,10 +1122,8 @@ static void atmel_rx_from_dma(struct uart_port *port)
 	}
 
 	/* CPU claims ownership of RX DMA buffer */
-	dma_sync_sg_for_cpu(port->dev,
-			    &atmel_port->sg_rx,
-			    1,
-			    DMA_FROM_DEVICE);
+	dma_sync_single_for_cpu(port->dev, atmel_port->rx_phys,
+				ATMEL_SERIAL_RX_SIZE, DMA_FROM_DEVICE);
 
 	/*
 	 * ring->head points to the end of data already written by the DMA.
@@ -1134,8 +1132,8 @@ static void atmel_rx_from_dma(struct uart_port *port)
 	 * The current transfer size should not be larger than the dma buffer
 	 * length.
 	 */
-	ring->head = sg_dma_len(&atmel_port->sg_rx) - state.residue;
-	BUG_ON(ring->head > sg_dma_len(&atmel_port->sg_rx));
+	ring->head = ATMEL_SERIAL_RX_SIZE - state.residue;
+	BUG_ON(ring->head > ATMEL_SERIAL_RX_SIZE);
 	/*
 	 * At this point ring->head may point to the first byte right after the
 	 * last byte of the dma buffer:
@@ -1149,7 +1147,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 	 * tail to the end of the buffer then reset tail.
 	 */
 	if (ring->head < ring->tail) {
-		count = sg_dma_len(&atmel_port->sg_rx) - ring->tail;
+		count = ATMEL_SERIAL_RX_SIZE - ring->tail;
 
 		tty_insert_flip_string(tport, ring->buf + ring->tail, count);
 		ring->tail = 0;
@@ -1162,17 +1160,15 @@ static void atmel_rx_from_dma(struct uart_port *port)
 
 		tty_insert_flip_string(tport, ring->buf + ring->tail, count);
 		/* Wrap ring->head if needed */
-		if (ring->head >= sg_dma_len(&atmel_port->sg_rx))
+		if (ring->head >= ATMEL_SERIAL_RX_SIZE)
 			ring->head = 0;
 		ring->tail = ring->head;
 		port->icount.rx += count;
 	}
 
 	/* USART retreives ownership of RX DMA buffer */
-	dma_sync_sg_for_device(port->dev,
-			       &atmel_port->sg_rx,
-			       1,
-			       DMA_FROM_DEVICE);
+	dma_sync_single_for_device(port->dev, atmel_port->rx_phys,
+				   ATMEL_SERIAL_RX_SIZE, DMA_FROM_DEVICE);
 
 	tty_flip_buffer_push(tport);
 
@@ -1188,7 +1184,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	struct dma_slave_config config;
 	struct circ_buf		*ring;
 	struct dma_chan *chan;
-	int ret, nent;
+	int ret;
 
 	ring = &atmel_port->rx_ring;
 
@@ -1205,26 +1201,18 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 		dma_chan_name(atmel_port->chan_rx));
 
 	spin_lock_init(&atmel_port->lock_rx);
-	sg_init_table(&atmel_port->sg_rx, 1);
 	/* UART circular rx buffer is an aligned page. */
 	BUG_ON(!PAGE_ALIGNED(ring->buf));
-	sg_set_page(&atmel_port->sg_rx,
-		    virt_to_page(ring->buf),
-		    ATMEL_SERIAL_RX_SIZE,
-		    offset_in_page(ring->buf));
-	nent = dma_map_sg(port->dev,
-			  &atmel_port->sg_rx,
-			  1,
-			  DMA_FROM_DEVICE);
-
-	if (!nent) {
+	atmel_port->rx_phys = dma_map_single(port->dev, ring->buf,
+					     ATMEL_SERIAL_RX_SIZE,
+					     DMA_FROM_DEVICE);
+
+	if (dma_mapping_error(port->dev, atmel_port->rx_phys)) {
 		dev_dbg(port->dev, "need to release resource of dma\n");
 		goto chan_err;
 	} else {
-		dev_dbg(port->dev, "%s: mapped %d@%p to %pad\n", __func__,
-			sg_dma_len(&atmel_port->sg_rx),
-			ring->buf,
-			&sg_dma_address(&atmel_port->sg_rx));
+		dev_dbg(port->dev, "%s: mapped %zu@%p to %pad\n", __func__,
+			ATMEL_SERIAL_RX_SIZE, ring->buf, &atmel_port->rx_phys);
 	}
 
 	/* Configure the slave DMA */
@@ -1245,9 +1233,9 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	 * each one is half ring buffer size
 	 */
 	desc = dmaengine_prep_dma_cyclic(atmel_port->chan_rx,
-					 sg_dma_address(&atmel_port->sg_rx),
-					 sg_dma_len(&atmel_port->sg_rx),
-					 sg_dma_len(&atmel_port->sg_rx)/2,
+					 atmel_port->rx_phys,
+					 ATMEL_SERIAL_RX_SIZE,
+					 ATMEL_SERIAL_RX_SIZE / 2,
 					 DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT);
 	if (!desc) {
-- 
2.44.0


