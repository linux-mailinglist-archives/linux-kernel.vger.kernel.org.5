Return-Path: <linux-kernel+bounces-107349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBC687FB50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD5F280CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2B811EB;
	Tue, 19 Mar 2024 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGcwQxif"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557480C0C;
	Tue, 19 Mar 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842047; cv=none; b=erouGJl/73rsKfxIpGrzmXVaTC9UOcll4lK0nyYR6Clgb01hbqbJp0jWmCVxtzeIIysDnly9PAA+94mY3SN8MfSm3zKHeWliL+oWE2JtDGpqFLEF67HsYXs1i6T2ua6YDz6yhN8qFgBWP7Om6cAOsxJ4+mTr1j3V0UYY0MlKOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842047; c=relaxed/simple;
	bh=/FjnStB/yZtMO26TOxQ+YsIrQb3A2biwdW2z1LAyxHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOv/rUa0OiUblKgJVLvfzfHS0lhGlwMxaWZ867UE8Nx1lKUyZ95ig+ClffSy2fOc9mM+//Ilqq2F7Nih9aBgp8zxt+Izo6BGFzNuaNg+6OmvUsMKvA02mnzlEP7sTmwLXvXo98TrwdbnBryDV40AlDKwlQ6LF/ETrSw9dur6TbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGcwQxif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E15C433C7;
	Tue, 19 Mar 2024 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842047;
	bh=/FjnStB/yZtMO26TOxQ+YsIrQb3A2biwdW2z1LAyxHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGcwQxif/Uo4JmAEV3r1g+301UQrm/6b1v5bCFfOPrrHiWif6tJLub83A0a9Wln2l
	 dVGZ2PuzwFC+tNfo3TQEDLJmW2L6fy3X92MeiWSbqXJ42eNev4VW4uIm8j+dab9sod
	 RgCbnoBTmrT/cglZKV3HbFNYaN6nUMtdxrXINQlgXYa1uX+cIWdg+rxuCvxf9MGAo4
	 dbIf0XPxiI/MoIk9dEMhBx6jU+BDEtb1WS6eVDMLitX4t+11+mPC4/fT3/TRNfLZqa
	 SugaYa2Lv/ul16syZdCW1Hu0b7HpFMGP0bNllTLAnApQ+n4WmLCaWS7vIXmIkOJfaG
	 nE8/3/k9jPFEg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Genoud <richard.genoud@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFT 15/15] tty: atmel_serial: use single DMA mapping for RX
Date: Tue, 19 Mar 2024 10:53:15 +0100
Message-ID: <20240319095315.27624-17-jirislaby@kernel.org>
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


