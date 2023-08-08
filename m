Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF0F77427A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHHRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHHRpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:25 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C73AA175;
        Tue,  8 Aug 2023 09:20:34 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DGYwo008039;
        Tue, 8 Aug 2023 18:19:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=7WIfw0irEIV+Oza8xiL4BFzi+kqQJHgoFXmjppWCvUw=; b=Za
        EXOyUHG8REtpvrjvIwktCNvsbiQHSkHwxuJWC+dKUoeamnRaZQVKwoH1QWYm5FUt
        p13cAj0hXiLqShN1TlgjUE5TpImqoZa6uUbbAHf/BXDZcqRBx7KzQKTzeJIlfiwJ
        a8XCaVO6Y9i/PgzkIZG0HE1f+qg1LV5YrWvSiRE6vlhyg42B/gEGrLaC8pW7CSLp
        5+ts0B3UhdJs+cdLDh3mQ7Ud0SChQt4u0YAGX1eWYzrzSUWoX/ryLsReyFOZZKqV
        e7ujsA76M1x9gn/AEXKSxH4FQ/Ob0O2Z423Odkekhy9VAzfB2R1rg7VCPqtqff/j
        nKu/0DEj8bzAT7tAmDbA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sbjfn2n4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:19:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E01D4100062;
        Tue,  8 Aug 2023 18:19:40 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D551C235F32;
        Tue,  8 Aug 2023 18:19:40 +0200 (CEST)
Received: from localhost (10.201.20.168) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 8 Aug
 2023 18:19:40 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 4/6] serial: stm32: group dma pause/resume error handling into single function
Date:   Tue, 8 Aug 2023 18:19:04 +0200
Message-ID: <20230808161906.178996-5-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808161906.178996-1-valentin.caron@foss.st.com>
References: <20230808161906.178996-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_15,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new function "stm32_usart_dma_pause_resume" that called dmaengine_
pause/resume and in case of error, terminate dma transaction.

Two other functions are created to facilitate the use of stm32_usart_dma
_pause_resume : stm32_usart_tx_dma_pause, stm32_usart_tx_dma_resume.
Equivalent functions for rx will be added in future patch.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 127 ++++++++++++++++++++-----------
 drivers/tty/serial/stm32-usart.h |   1 +
 2 files changed, 83 insertions(+), 45 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 3471e23bb02f..0dae05a7abe6 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -290,14 +290,40 @@ static int stm32_usart_init_rs485(struct uart_port *port,
 }
 
 static bool stm32_usart_rx_dma_started(struct stm32_port *stm32_port)
+{
+	return stm32_port->rx_ch ? stm32_port->rx_dma_busy : false;
+}
+
+static void stm32_usart_rx_dma_terminate(struct stm32_port *stm32_port)
+{
+	dmaengine_terminate_async(stm32_port->rx_ch);
+	stm32_port->rx_dma_busy = false;
+}
+
+static int stm32_usart_dma_pause_resume(struct stm32_port *stm32_port,
+					struct dma_chan *chan,
+					enum dma_status expected_status,
+					int dmaengine_pause_or_resume(struct dma_chan *),
+					bool stm32_usart_xx_dma_started(struct stm32_port *),
+					void stm32_usart_xx_dma_terminate(struct stm32_port *))
 {
 	struct uart_port *port = &stm32_port->port;
-	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	enum dma_status dma_status;
+	int ret;
+
+	if (!stm32_usart_xx_dma_started(stm32_port))
+		return -EPERM;
 
-	if (!stm32_port->rx_ch)
-		return false;
+	dma_status = dmaengine_tx_status(chan, chan->cookie, NULL);
+	if (dma_status != expected_status)
+		return -EAGAIN;
 
-	return !!(readl_relaxed(port->membase + ofs->cr3) & USART_CR3_DMAR);
+	ret = dmaengine_pause_or_resume(chan);
+	if (ret) {
+		dev_err(port->dev, "DMA failed with error code: %d\n", ret);
+		stm32_usart_xx_dma_terminate(stm32_port);
+	}
+	return ret;
 }
 
 /* Return true when data is pending (in pio mode), and false when no data is pending. */
@@ -475,7 +501,7 @@ static unsigned int stm32_usart_receive_chars(struct uart_port *port, bool force
 			}
 		} else {
 			/* Disable RX DMA */
-			dmaengine_terminate_async(stm32_port->rx_ch);
+			stm32_usart_rx_dma_terminate(stm32_port);
 			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 			/* Fall back to interrupt mode */
 			dev_dbg(port->dev, "DMA error, fallback to irq mode\n");
@@ -506,6 +532,22 @@ static bool stm32_usart_tx_dma_started(struct stm32_port *stm32_port)
 	return stm32_port->tx_dma_busy;
 }
 
+static int stm32_usart_tx_dma_pause(struct stm32_port *stm32_port)
+{
+	return stm32_usart_dma_pause_resume(stm32_port, stm32_port->tx_ch,
+					    DMA_IN_PROGRESS, dmaengine_pause,
+					    stm32_usart_tx_dma_started,
+					    stm32_usart_tx_dma_terminate);
+}
+
+static int stm32_usart_tx_dma_resume(struct stm32_port *stm32_port)
+{
+	return stm32_usart_dma_pause_resume(stm32_port, stm32_port->tx_ch,
+					    DMA_PAUSED, dmaengine_resume,
+					    stm32_usart_tx_dma_started,
+					    stm32_usart_tx_dma_terminate);
+}
+
 static void stm32_usart_tx_dma_complete(void *arg)
 {
 	struct uart_port *port = arg;
@@ -606,13 +648,9 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 	int ret;
 
 	if (stm32_usart_tx_dma_started(stm32port)) {
-		if (dmaengine_tx_status(stm32port->tx_ch,
-					stm32port->tx_ch->cookie,
-					NULL) == DMA_PAUSED) {
-			ret = dmaengine_resume(stm32port->tx_ch);
-			if (ret < 0)
-				goto dma_err;
-		}
+		ret = stm32_usart_tx_dma_resume(stm32port);
+		if (ret < 0 && ret != -EAGAIN)
+			goto fallback_err;
 		return;
 	}
 
@@ -658,8 +696,12 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 
 	/* Push current DMA TX transaction in the pending queue */
 	/* DMA no yet started, safe to free resources */
-	if (dma_submit_error(dmaengine_submit(desc)))
-		goto dma_err;
+	ret = dma_submit_error(dmaengine_submit(desc));
+	if (ret) {
+		dev_err(port->dev, "DMA failed with error code: %d\n", ret);
+		stm32_usart_tx_dma_terminate(stm32port);
+		goto fallback_err;
+	}
 
 	/* Issue pending DMA TX requests */
 	dma_async_issue_pending(stm32port->tx_ch);
@@ -668,10 +710,6 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 
 	return;
 
-dma_err:
-	dev_err(port->dev, "DMA failed with error code: %d\n", ret);
-	stm32_usart_tx_dma_terminate(stm32port);
-
 fallback_err:
 	stm32_usart_transmit_chars_pio(port);
 }
@@ -693,16 +731,9 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
 	}
 
 	if (port->x_char) {
-		if (stm32_usart_tx_dma_started(stm32_port) &&
-		    dmaengine_tx_status(stm32_port->tx_ch,
-					stm32_port->tx_ch->cookie,
-					NULL) == DMA_IN_PROGRESS) {
-			ret = dmaengine_pause(stm32_port->tx_ch);
-			if (ret < 0) {
-				dev_err(port->dev, "DMA failed with error code: %d\n", ret);
-				stm32_usart_tx_dma_terminate(stm32_port);
-			}
-		}
+		/* dma terminate may have been called in case of dma pause failure */
+		stm32_usart_tx_dma_pause(stm32_port);
+
 		/* Check that TDR is empty before filling FIFO */
 		ret =
 		readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
@@ -716,13 +747,8 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
 		port->x_char = 0;
 		port->icount.tx++;
 
-		if (stm32_usart_tx_dma_started(stm32_port)) {
-			ret = dmaengine_resume(stm32_port->tx_ch);
-			if (ret < 0) {
-				dev_err(port->dev, "DMA failed with error code: %d\n", ret);
-				stm32_usart_tx_dma_terminate(stm32_port);
-			}
-		}
+		/* dma terminate may have been called in case of dma resume failure */
+		stm32_usart_tx_dma_resume(stm32_port);
 		return;
 	}
 
@@ -855,16 +881,11 @@ static void stm32_usart_disable_ms(struct uart_port *port)
 static void stm32_usart_stop_tx(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	int ret;
 
 	stm32_usart_tx_interrupt_disable(port);
-	if (stm32_usart_tx_dma_started(stm32_port)) {
-		ret = dmaengine_pause(stm32_port->tx_ch);
-		if (ret < 0) {
-			dev_err(port->dev, "DMA failed with error code: %d\n", ret);
-			stm32_usart_tx_dma_terminate(stm32_port);
-		}
-	}
+
+	/* dma terminate may have been called in case of dma pause failure */
+	stm32_usart_tx_dma_pause(stm32_port);
 
 	stm32_usart_rs485_rts_disable(port);
 }
@@ -965,8 +986,22 @@ static int stm32_usart_start_rx_dma_cyclic(struct uart_port *port)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct dma_async_tx_descriptor *desc;
+	enum dma_status rx_dma_status;
 	int ret;
 
+	if (stm32_port->rx_dma_busy) {
+		rx_dma_status = dmaengine_tx_status(stm32_port->rx_ch,
+						    stm32_port->rx_ch->cookie,
+						    NULL);
+		if (rx_dma_status == DMA_IN_PROGRESS)
+			return 0;
+
+		dev_err(port->dev, "DMA failed : status error.\n");
+		stm32_usart_rx_dma_terminate(stm32_port);
+	}
+
+	stm32_port->rx_dma_busy = true;
+
 	stm32_port->last_res = RX_BUF_L;
 	/* Prepare a DMA cyclic transaction */
 	desc = dmaengine_prep_dma_cyclic(stm32_port->rx_ch,
@@ -976,6 +1011,7 @@ static int stm32_usart_start_rx_dma_cyclic(struct uart_port *port)
 					 DMA_PREP_INTERRUPT);
 	if (!desc) {
 		dev_err(port->dev, "rx dma prep cyclic failed\n");
+		stm32_port->rx_dma_busy = false;
 		return -ENODEV;
 	}
 
@@ -986,6 +1022,7 @@ static int stm32_usart_start_rx_dma_cyclic(struct uart_port *port)
 	ret = dma_submit_error(dmaengine_submit(desc));
 	if (ret) {
 		dmaengine_terminate_sync(stm32_port->rx_ch);
+		stm32_port->rx_dma_busy = false;
 		return ret;
 	}
 
@@ -1074,7 +1111,7 @@ static void stm32_usart_shutdown(struct uart_port *port)
 
 	/* Disable RX DMA. */
 	if (stm32_port->rx_ch)
-		dmaengine_terminate_async(stm32_port->rx_ch);
+		stm32_usart_rx_dma_terminate(stm32_port);
 
 	/* flush RX & TX FIFO */
 	if (ofs->rqr != UNDEF_REG)
@@ -1988,7 +2025,7 @@ static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 			/* Poll data from DMA RX buffer if any */
 			size = stm32_usart_receive_chars(port, true);
-			dmaengine_terminate_async(stm32_port->rx_ch);
+			stm32_usart_rx_dma_terminate(stm32_port);
 			uart_unlock_and_check_sysrq_irqrestore(port, flags);
 			if (size)
 				tty_flip_buffer_push(tport);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 903285b5aea7..f59f831b2a10 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -199,6 +199,7 @@ struct stm32_port {
 	u32 cr3_irq;		 /* USART_CR3_RXFTIE */
 	int last_res;
 	bool tx_dma_busy;	 /* dma tx transaction in progress */
+	bool rx_dma_busy;	 /* dma rx transaction in progress */
 	bool throttled;		 /* port throttled            */
 	bool hw_flow_control;
 	bool swap;		 /* swap RX & TX pins */
-- 
2.25.1

