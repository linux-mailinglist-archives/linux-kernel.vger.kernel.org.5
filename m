Return-Path: <linux-kernel+bounces-132447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08B899503
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3AF1C222CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406323769;
	Fri,  5 Apr 2024 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZI6FW2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F00523763;
	Fri,  5 Apr 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297339; cv=none; b=Xk3T+7llwgUH/l4vVxpLUlflUmEf29C2X9Iq6259XoyF3MpyxLOR1FXJhwkFkzIeY91RofJcPBUjYMEl3H6flmF9twmL0YZVX0rvUee7O6q/qfSAOxoiWW+QjrJYxR+yVkVx8jjGjUJ3yTqvUqxTSHWNrsBPgPp2OH61RpriutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297339; c=relaxed/simple;
	bh=QLNqWoy3pX+584nLy4eOQPQmLYN+Qw4MFScVuiXPd70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXDVSeL+I5BVH8RFVzJT+Mc9m5nty59ryiOawfdRVfe3DmKj3F/F9co2Its74SDpn6BpgTmrPdNVkLpnI/bWUIRJ/26HlYrgDjCLxu06wdQYlwXuAf21EU8+pu6/MG52dG6BLMLjf5q7KUrX0zJLncfJrIf+r/km9NytbWLv7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZI6FW2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907E5C43399;
	Fri,  5 Apr 2024 06:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297339;
	bh=QLNqWoy3pX+584nLy4eOQPQmLYN+Qw4MFScVuiXPd70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZI6FW2AfLLcFlOMlNHDdWQcIhyLEUZZOcAvKkKkBmcwuF+XWbmkyUCWl/CHimPy8
	 tAtqYvUHIZweOvONS3FoxTj6ImecOtomkZA9SrQLmCKHCEUcSEAVoTfmj2pG7wagJj
	 XGVegQwi8Xf+GHWLL6/Vk1LsInHNzA54GzCzHXdxQzQwV2qvr2x3UELb1o7ncS+lE3
	 9DJNkYW6xsR+srRN5D5KpA4CxOlNhF+zYRuGCSP6q8GLT3FiS3PPwpF0aIT7lMZhxE
	 DH0cLaSy3ZXnNlrbEN4ho1hYG3Al8dxYnLseGRdXY01f44w/+lLHlLVrENanFFgRLl
	 6gItD13JGIdnw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 11/15] tty: msm_serial: use dmaengine_prep_slave_sg()
Date: Fri,  5 Apr 2024 08:08:22 +0200
Message-ID: <20240405060826.2521-12-jirislaby@kernel.org>
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

This is a preparatory for the serial-to-kfifo switch. kfifo understands
only scatter-gatter approach, so switch to that.

No functional change intended, it's just dmaengine_prep_slave_single()
inline expanded.

And in this case, switch from dma_map_single() to dma_map_sg() too. This
needs struct msm_dma changes. I split the rx and tx parts into an union.
TX is now struct scatterlist, RX remains the old good phys-virt-count
triple.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/tty/serial/msm_serial.c | 86 +++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index d27c4c8c84e1..7bf30e632313 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -161,11 +161,16 @@ enum {
 struct msm_dma {
 	struct dma_chan		*chan;
 	enum dma_data_direction dir;
-	dma_addr_t		phys;
-	unsigned char		*virt;
+	union {
+		struct {
+			dma_addr_t		phys;
+			unsigned char		*virt;
+			unsigned int		count;
+		} rx;
+		struct scatterlist tx_sg;
+	};
 	dma_cookie_t		cookie;
 	u32			enable_bit;
-	unsigned int		count;
 	struct dma_async_tx_descriptor	*desc;
 };
 
@@ -249,8 +254,12 @@ static void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
 	unsigned int mapped;
 	u32 val;
 
-	mapped = dma->count;
-	dma->count = 0;
+	if (dma->dir == DMA_TO_DEVICE) {
+		mapped = sg_dma_len(&dma->tx_sg);
+	} else {
+		mapped = dma->rx.count;
+		dma->rx.count = 0;
+	}
 
 	dmaengine_terminate_all(dma->chan);
 
@@ -265,8 +274,13 @@ static void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
 	val &= ~dma->enable_bit;
 	msm_write(port, val, UARTDM_DMEN);
 
-	if (mapped)
-		dma_unmap_single(dev, dma->phys, mapped, dma->dir);
+	if (mapped) {
+		if (dma->dir == DMA_TO_DEVICE) {
+			dma_unmap_sg(dev, &dma->tx_sg, 1, dma->dir);
+			sg_init_table(&dma->tx_sg, 1);
+		} else
+			dma_unmap_single(dev, dma->rx.phys, mapped, dma->dir);
+	}
 }
 
 static void msm_release_dma(struct msm_port *msm_port)
@@ -285,7 +299,7 @@ static void msm_release_dma(struct msm_port *msm_port)
 	if (dma->chan) {
 		msm_stop_dma(&msm_port->uart, dma);
 		dma_release_channel(dma->chan);
-		kfree(dma->virt);
+		kfree(dma->rx.virt);
 	}
 
 	memset(dma, 0, sizeof(*dma));
@@ -357,8 +371,8 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
 
 	of_property_read_u32(dev->of_node, "qcom,rx-crci", &crci);
 
-	dma->virt = kzalloc(UARTDM_RX_SIZE, GFP_KERNEL);
-	if (!dma->virt)
+	dma->rx.virt = kzalloc(UARTDM_RX_SIZE, GFP_KERNEL);
+	if (!dma->rx.virt)
 		goto rel_rx;
 
 	memset(&conf, 0, sizeof(conf));
@@ -385,7 +399,7 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
 
 	return;
 err:
-	kfree(dma->virt);
+	kfree(dma->rx.virt);
 rel_rx:
 	dma_release_channel(dma->chan);
 no_rx:
@@ -420,7 +434,7 @@ static void msm_start_tx(struct uart_port *port)
 	struct msm_dma *dma = &msm_port->tx_dma;
 
 	/* Already started in DMA mode */
-	if (dma->count)
+	if (sg_dma_len(&dma->tx_sg))
 		return;
 
 	msm_port->imr |= MSM_UART_IMR_TXLEV;
@@ -448,12 +462,12 @@ static void msm_complete_tx_dma(void *args)
 	uart_port_lock_irqsave(port, &flags);
 
 	/* Already stopped */
-	if (!dma->count)
+	if (!sg_dma_len(&dma->tx_sg))
 		goto done;
 
 	dmaengine_tx_status(dma->chan, dma->cookie, &state);
 
-	dma_unmap_single(port->dev, dma->phys, dma->count, dma->dir);
+	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
 
 	val = msm_read(port, UARTDM_DMEN);
 	val &= ~dma->enable_bit;
@@ -464,9 +478,9 @@ static void msm_complete_tx_dma(void *args)
 		msm_write(port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
 	}
 
-	count = dma->count - state.residue;
+	count = sg_dma_len(&dma->tx_sg) - state.residue;
 	uart_xmit_advance(port, count);
-	dma->count = 0;
+	sg_init_table(&dma->tx_sg, 1);
 
 	/* Restore "Tx FIFO below watermark" interrupt */
 	msm_port->imr |= MSM_UART_IMR_TXLEV;
@@ -485,19 +499,18 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 	struct circ_buf *xmit = &msm_port->uart.state->xmit;
 	struct uart_port *port = &msm_port->uart;
 	struct msm_dma *dma = &msm_port->tx_dma;
-	void *cpu_addr;
 	int ret;
 	u32 val;
 
-	cpu_addr = &xmit->buf[xmit->tail];
+	sg_init_table(&dma->tx_sg, 1);
+	sg_set_buf(&dma->tx_sg, &xmit->buf[xmit->tail], count);
 
-	dma->phys = dma_map_single(port->dev, cpu_addr, count, dma->dir);
-	ret = dma_mapping_error(port->dev, dma->phys);
+	ret = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
 	if (ret)
 		return ret;
 
-	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->phys,
-						count, DMA_MEM_TO_DEV,
+	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->tx_sg, 1,
+						DMA_MEM_TO_DEV,
 						DMA_PREP_INTERRUPT |
 						DMA_PREP_FENCE);
 	if (!dma->desc) {
@@ -520,8 +533,6 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 	msm_port->imr &= ~MSM_UART_IMR_TXLEV;
 	msm_write(port, msm_port->imr, MSM_UART_IMR);
 
-	dma->count = count;
-
 	val = msm_read(port, UARTDM_DMEN);
 	val |= dma->enable_bit;
 
@@ -536,7 +547,8 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 	dma_async_issue_pending(dma->chan);
 	return 0;
 unmap:
-	dma_unmap_single(port->dev, dma->phys, count, dma->dir);
+	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
+	sg_init_table(&dma->tx_sg, 1);
 	return ret;
 }
 
@@ -553,7 +565,7 @@ static void msm_complete_rx_dma(void *args)
 	uart_port_lock_irqsave(port, &flags);
 
 	/* Already stopped */
-	if (!dma->count)
+	if (!dma->rx.count)
 		goto done;
 
 	val = msm_read(port, UARTDM_DMEN);
@@ -570,14 +582,14 @@ static void msm_complete_rx_dma(void *args)
 
 	port->icount.rx += count;
 
-	dma->count = 0;
+	dma->rx.count = 0;
 
-	dma_unmap_single(port->dev, dma->phys, UARTDM_RX_SIZE, dma->dir);
+	dma_unmap_single(port->dev, dma->rx.phys, UARTDM_RX_SIZE, dma->dir);
 
 	for (i = 0; i < count; i++) {
 		char flag = TTY_NORMAL;
 
-		if (msm_port->break_detected && dma->virt[i] == 0) {
+		if (msm_port->break_detected && dma->rx.virt[i] == 0) {
 			port->icount.brk++;
 			flag = TTY_BREAK;
 			msm_port->break_detected = false;
@@ -588,9 +600,9 @@ static void msm_complete_rx_dma(void *args)
 		if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
 			flag = TTY_NORMAL;
 
-		sysrq = uart_prepare_sysrq_char(port, dma->virt[i]);
+		sysrq = uart_prepare_sysrq_char(port, dma->rx.virt[i]);
 		if (!sysrq)
-			tty_insert_flip_char(tport, dma->virt[i], flag);
+			tty_insert_flip_char(tport, dma->rx.virt[i], flag);
 	}
 
 	msm_start_rx_dma(msm_port);
@@ -614,13 +626,13 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 	if (!dma->chan)
 		return;
 
-	dma->phys = dma_map_single(uart->dev, dma->virt,
+	dma->rx.phys = dma_map_single(uart->dev, dma->rx.virt,
 				   UARTDM_RX_SIZE, dma->dir);
-	ret = dma_mapping_error(uart->dev, dma->phys);
+	ret = dma_mapping_error(uart->dev, dma->rx.phys);
 	if (ret)
 		goto sw_mode;
 
-	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->phys,
+	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->rx.phys,
 						UARTDM_RX_SIZE, DMA_DEV_TO_MEM,
 						DMA_PREP_INTERRUPT);
 	if (!dma->desc)
@@ -648,7 +660,7 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 
 	msm_write(uart, msm_port->imr, MSM_UART_IMR);
 
-	dma->count = UARTDM_RX_SIZE;
+	dma->rx.count = UARTDM_RX_SIZE;
 
 	dma_async_issue_pending(dma->chan);
 
@@ -668,7 +680,7 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 
 	return;
 unmap:
-	dma_unmap_single(uart->dev, dma->phys, UARTDM_RX_SIZE, dma->dir);
+	dma_unmap_single(uart->dev, dma->rx.phys, UARTDM_RX_SIZE, dma->dir);
 
 sw_mode:
 	/*
@@ -955,7 +967,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 	}
 
 	if (misr & (MSM_UART_IMR_RXLEV | MSM_UART_IMR_RXSTALE)) {
-		if (dma->count) {
+		if (dma->rx.count) {
 			val = MSM_UART_CR_CMD_STALE_EVENT_DISABLE;
 			msm_write(port, val, MSM_UART_CR);
 			val = MSM_UART_CR_CMD_RESET_STALE_INT;
-- 
2.44.0


