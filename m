Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5674276E914
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjHCNDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjHCNDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:03:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358134224;
        Thu,  3 Aug 2023 06:03:15 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 373A01eb010084;
        Thu, 3 Aug 2023 15:03:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=K5Mf4K28dVqGgOXG/25wlgXtHIWlnOLbNeyiTKRCs58=; b=R8
        R90cjj8Imj+mZ5r3PGH6ve6znkyb7J9I/7mzr5gacwarmUe7Nb7+EWJpTNqAPjFe
        +NRAsMxWPu2YJjHGQ2jBm9IqyNuIyX5rxZ/+fo0R80nggyqgLATDYB/2aZGUsCiq
        nGjXrr0SwXd8i+wyIUNFnqfhqmOFYiObHP2mGPGtB+kC9vV/3oOarybnIWpaV6tN
        FyxTO3+zvHMnMxjSUjp7WCj3YCTjSydaGJhMJm0vQsoxvQ++ztPtHbXTmxuz4Mza
        uuX8b1yHxanLsTRQujyeboNgC5WWgKmR2Bk4Vo12YkQf6hTkTJDeh+cURE8Z5FTj
        HU3CUBHyKhPF1w6Vau4w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s8a3qh1tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 15:03:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 706F6100089;
        Thu,  3 Aug 2023 15:03:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 68CF82207B9;
        Thu,  3 Aug 2023 15:03:01 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 3 Aug
 2023 15:03:01 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 5/6] serial: stm32: replace access to DMAR bit by dmaengine_pause/resume
Date:   Thu, 3 Aug 2023 15:01:33 +0200
Message-ID: <20230803130134.155355-6-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803130134.155355-1-valentin.caron@foss.st.com>
References: <20230803130134.155355-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's rather advised to rely on DMA pause / resume instead of
clearing/setting DMA request enable bit for the same purpose. Some DMA
request/acknowledge race may encountered by doing so. We prefer to use
dmaengine_pause and resume instead to pause a dma transfer when it is
necessary.

Create two new functions (stm32_usart_rx_dma_pause, stm32_usart_rx_dma
_resume) to handle dma error when pausing/resuming.

And rename stm32_usart_start_rx_dma_cyclic() to
stm32_usart_rx_dma_start_or_resume() and use this function to resume an
rx dma transfer. If resume fail, stm32_usart_rx_dma_start_or_resume can
create a new transfer to continue.

It is also safer to close DMA before reset DMAR in stm32_usart_shutdown.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 200 ++++++++++++++++---------------
 1 file changed, 106 insertions(+), 94 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0dae05a7abe6..8fc0526be898 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -326,6 +326,22 @@ static int stm32_usart_dma_pause_resume(struct stm32_port *stm32_port,
 	return ret;
 }
 
+static int stm32_usart_rx_dma_pause(struct stm32_port *stm32_port)
+{
+	return stm32_usart_dma_pause_resume(stm32_port, stm32_port->rx_ch,
+					    DMA_IN_PROGRESS, dmaengine_pause,
+					    stm32_usart_rx_dma_started,
+					    stm32_usart_rx_dma_terminate);
+}
+
+static int stm32_usart_rx_dma_resume(struct stm32_port *stm32_port)
+{
+	return stm32_usart_dma_pause_resume(stm32_port, stm32_port->rx_ch,
+					    DMA_PAUSED, dmaengine_resume,
+					    stm32_usart_rx_dma_started,
+					    stm32_usart_rx_dma_terminate);
+}
+
 /* Return true when data is pending (in pio mode), and false when no data is pending. */
 static bool stm32_usart_pending_rx_pio(struct uart_port *port, u32 *sr)
 {
@@ -485,7 +501,8 @@ static unsigned int stm32_usart_receive_chars(struct uart_port *port, bool force
 		rx_dma_status = dmaengine_tx_status(stm32_port->rx_ch,
 						    stm32_port->rx_ch->cookie,
 						    &stm32_port->rx_dma_state);
-		if (rx_dma_status == DMA_IN_PROGRESS) {
+		if (rx_dma_status == DMA_IN_PROGRESS ||
+		    rx_dma_status == DMA_PAUSED) {
 			/* Empty DMA buffer */
 			size = stm32_usart_receive_chars_dma(port);
 			sr = readl_relaxed(port->membase + ofs->isr);
@@ -502,7 +519,6 @@ static unsigned int stm32_usart_receive_chars(struct uart_port *port, bool force
 		} else {
 			/* Disable RX DMA */
 			stm32_usart_rx_dma_terminate(stm32_port);
-			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 			/* Fall back to interrupt mode */
 			dev_dbg(port->dev, "DMA error, fallback to irq mode\n");
 			size = stm32_usart_receive_chars_pio(port);
@@ -514,6 +530,76 @@ static unsigned int stm32_usart_receive_chars(struct uart_port *port, bool force
 	return size;
 }
 
+static void stm32_usart_rx_dma_complete(void *arg)
+{
+	struct uart_port *port = arg;
+	struct tty_port *tport = &port->state->port;
+	unsigned int size;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	size = stm32_usart_receive_chars(port, false);
+	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+	if (size)
+		tty_flip_buffer_push(tport);
+}
+
+static int stm32_usart_rx_dma_start_or_resume(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct dma_async_tx_descriptor *desc;
+	enum dma_status rx_dma_status;
+	int ret;
+
+	if (stm32_port->throttled)
+		return 0;
+
+	if (stm32_port->rx_dma_busy) {
+		rx_dma_status = dmaengine_tx_status(stm32_port->rx_ch,
+						    stm32_port->rx_ch->cookie,
+						    NULL);
+		if (rx_dma_status == DMA_IN_PROGRESS)
+			return 0;
+
+		if (rx_dma_status == DMA_PAUSED && !stm32_usart_rx_dma_resume(stm32_port))
+			return 0;
+
+		dev_err(port->dev, "DMA failed : status error.\n");
+		stm32_usart_rx_dma_terminate(stm32_port);
+	}
+
+	stm32_port->rx_dma_busy = true;
+
+	stm32_port->last_res = RX_BUF_L;
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(stm32_port->rx_ch,
+					 stm32_port->rx_dma_buf,
+					 RX_BUF_L, RX_BUF_P,
+					 DMA_DEV_TO_MEM,
+					 DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(port->dev, "rx dma prep cyclic failed\n");
+		stm32_port->rx_dma_busy = false;
+		return -ENODEV;
+	}
+
+	desc->callback = stm32_usart_rx_dma_complete;
+	desc->callback_param = port;
+
+	/* Push current DMA transaction in the pending queue */
+	ret = dma_submit_error(dmaengine_submit(desc));
+	if (ret) {
+		dmaengine_terminate_sync(stm32_port->rx_ch);
+		stm32_port->rx_dma_busy = false;
+		return ret;
+	}
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(stm32_port->rx_ch);
+
+	return 0;
+}
+
 static void stm32_usart_tx_dma_terminate(struct stm32_port *stm32_port)
 {
 	dmaengine_terminate_async(stm32_port->tx_ch);
@@ -585,20 +671,6 @@ static void stm32_usart_tc_interrupt_enable(struct uart_port *port)
 	stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TCIE);
 }
 
-static void stm32_usart_rx_dma_complete(void *arg)
-{
-	struct uart_port *port = arg;
-	struct tty_port *tport = &port->state->port;
-	unsigned int size;
-	unsigned long flags;
-
-	spin_lock_irqsave(&port->lock, flags);
-	size = stm32_usart_receive_chars(port, false);
-	uart_unlock_and_check_sysrq_irqrestore(port, flags);
-	if (size)
-		tty_flip_buffer_push(tport);
-}
-
 static void stm32_usart_tx_interrupt_disable(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -924,11 +996,10 @@ static void stm32_usart_throttle(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 
 	/*
-	 * Disable DMA request line if enabled, so the RX data gets queued into the FIFO.
+	 * Pause DMA transfer, so the RX data gets queued into the FIFO.
 	 * Hardware flow control is triggered when RX FIFO is full.
 	 */
-	if (stm32_usart_rx_dma_started(stm32_port))
-		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+	stm32_usart_rx_dma_pause(stm32_port);
 
 	stm32_usart_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
 	if (stm32_port->cr3_irq)
@@ -950,14 +1021,15 @@ static void stm32_usart_unthrottle(struct uart_port *port)
 	if (stm32_port->cr3_irq)
 		stm32_usart_set_bits(port, ofs->cr3, stm32_port->cr3_irq);
 
+	stm32_port->throttled = false;
+
 	/*
-	 * Switch back to DMA mode (re-enable DMA request line).
+	 * Switch back to DMA mode (resume DMA).
 	 * Hardware flow control is stopped when FIFO is not full any more.
 	 */
 	if (stm32_port->rx_ch)
-		stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAR);
+		stm32_usart_rx_dma_start_or_resume(port);
 
-	stm32_port->throttled = false;
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -968,8 +1040,7 @@ static void stm32_usart_stop_rx(struct uart_port *port)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	/* Disable DMA request line. */
-	if (stm32_port->rx_ch)
-		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+	stm32_usart_rx_dma_pause(stm32_port);
 
 	stm32_usart_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
 	if (stm32_port->cr3_irq)
@@ -981,64 +1052,6 @@ static void stm32_usart_break_ctl(struct uart_port *port, int break_state)
 {
 }
 
-static int stm32_usart_start_rx_dma_cyclic(struct uart_port *port)
-{
-	struct stm32_port *stm32_port = to_stm32_port(port);
-	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct dma_async_tx_descriptor *desc;
-	enum dma_status rx_dma_status;
-	int ret;
-
-	if (stm32_port->rx_dma_busy) {
-		rx_dma_status = dmaengine_tx_status(stm32_port->rx_ch,
-						    stm32_port->rx_ch->cookie,
-						    NULL);
-		if (rx_dma_status == DMA_IN_PROGRESS)
-			return 0;
-
-		dev_err(port->dev, "DMA failed : status error.\n");
-		stm32_usart_rx_dma_terminate(stm32_port);
-	}
-
-	stm32_port->rx_dma_busy = true;
-
-	stm32_port->last_res = RX_BUF_L;
-	/* Prepare a DMA cyclic transaction */
-	desc = dmaengine_prep_dma_cyclic(stm32_port->rx_ch,
-					 stm32_port->rx_dma_buf,
-					 RX_BUF_L, RX_BUF_P,
-					 DMA_DEV_TO_MEM,
-					 DMA_PREP_INTERRUPT);
-	if (!desc) {
-		dev_err(port->dev, "rx dma prep cyclic failed\n");
-		stm32_port->rx_dma_busy = false;
-		return -ENODEV;
-	}
-
-	desc->callback = stm32_usart_rx_dma_complete;
-	desc->callback_param = port;
-
-	/* Push current DMA transaction in the pending queue */
-	ret = dma_submit_error(dmaengine_submit(desc));
-	if (ret) {
-		dmaengine_terminate_sync(stm32_port->rx_ch);
-		stm32_port->rx_dma_busy = false;
-		return ret;
-	}
-
-	/* Issue pending DMA requests */
-	dma_async_issue_pending(stm32_port->rx_ch);
-
-	/*
-	 * DMA request line not re-enabled at resume when port is throttled.
-	 * It will be re-enabled by unthrottle ops.
-	 */
-	if (!stm32_port->throttled)
-		stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAR);
-
-	return 0;
-}
-
 static int stm32_usart_startup(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -1064,7 +1077,7 @@ static int stm32_usart_startup(struct uart_port *port)
 		writel_relaxed(USART_RQR_RXFRQ, port->membase + ofs->rqr);
 
 	if (stm32_port->rx_ch) {
-		ret = stm32_usart_start_rx_dma_cyclic(port);
+		ret = stm32_usart_rx_dma_start_or_resume(port);
 		if (ret) {
 			free_irq(port->irq, port);
 			return ret;
@@ -1811,11 +1824,6 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 
 	stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_PEIE);
-	cr3 = readl_relaxed(port->membase + ofs->cr3);
-	cr3 &= ~USART_CR3_EIE;
-	cr3 &= ~USART_CR3_DMAR;
-	cr3 &= ~USART_CR3_DDRE;
-	writel_relaxed(cr3, port->membase + ofs->cr3);
 
 	if (stm32_port->tx_ch) {
 		stm32_usart_of_dma_tx_remove(stm32_port, pdev);
@@ -1827,7 +1835,12 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 		dma_release_channel(stm32_port->rx_ch);
 	}
 
-	stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
+	cr3 = readl_relaxed(port->membase + ofs->cr3);
+	cr3 &= ~USART_CR3_EIE;
+	cr3 &= ~USART_CR3_DMAR;
+	cr3 &= ~USART_CR3_DMAT;
+	cr3 &= ~USART_CR3_DDRE;
+	writel_relaxed(cr3, port->membase + ofs->cr3);
 
 	if (stm32_port->wakeup_src) {
 		dev_pm_clear_wake_irq(&pdev->dev);
@@ -1999,7 +2012,7 @@ static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct tty_port *tport = &port->state->port;
 	int ret;
-	unsigned int size;
+	unsigned int size = 0;
 	unsigned long flags;
 
 	if (!stm32_port->wakeup_src || !tty_port_initialized(tport))
@@ -2021,10 +2034,9 @@ static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 		 */
 		if (stm32_port->rx_ch) {
 			spin_lock_irqsave(&port->lock, flags);
-			/* Avoid race with RX IRQ when DMAR is cleared */
-			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 			/* Poll data from DMA RX buffer if any */
-			size = stm32_usart_receive_chars(port, true);
+			if (!stm32_usart_rx_dma_pause(stm32_port))
+				size += stm32_usart_receive_chars(port, true);
 			stm32_usart_rx_dma_terminate(stm32_port);
 			uart_unlock_and_check_sysrq_irqrestore(port, flags);
 			if (size)
@@ -2035,7 +2047,7 @@ static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 		stm32_usart_receive_chars(port, false);
 	} else {
 		if (stm32_port->rx_ch) {
-			ret = stm32_usart_start_rx_dma_cyclic(port);
+			ret = stm32_usart_rx_dma_start_or_resume(port);
 			if (ret)
 				return ret;
 		}
-- 
2.25.1

