Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E10774741
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjHHTMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjHHTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:12:08 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E4E33B3B;
        Tue,  8 Aug 2023 09:34:10 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378Co66x027258;
        Tue, 8 Aug 2023 18:19:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=dhCwEHX0DJwZiRNK4fFfUdVG5e5HKjrWxTyeEHdpYQ0=; b=tk
        qcWJqgkcRx9YVxoTUtlxWsUZoJOIZX+PlKop0U4pAaNbPp7qa67js8T8BnqXlP1W
        Q+Vm2Wgrz4Gm8E/9S9/griN3OikMYbXJ6dT7SB7figxBBXN6Cix7AzE8FBbdcPvc
        LubWnmHmEC8BJuyXOtS+5VnTZNZa5qHdJNG/ayNrY3WEltJRL0MkwQkeRJrqBiOD
        8T+k5IEczpa1JULWZ0PeyygadBg+lpw12kYOigE03e7VrK50uO1pokNw0fr+7TQ/
        /F04/9HRj+FcJn4PVzrZyi32Lvp5F19LoG3EZ6/WJ2vUJEc7/2WjKz1I1fY9Rq1x
        NauNonA8Dnyou8ZYWJKQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sbp2d958h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:19:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 72F77100062;
        Tue,  8 Aug 2023 18:19:38 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 698BB235F32;
        Tue,  8 Aug 2023 18:19:38 +0200 (CEST)
Received: from localhost (10.201.20.168) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 8 Aug
 2023 18:19:38 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 1/6] serial: stm32: avoid clearing DMAT bit during transfer
Date:   Tue, 8 Aug 2023 18:19:01 +0200
Message-ID: <20230808161906.178996-2-valentin.caron@foss.st.com>
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

It's rather advised to rely on DMA pause / resume instead of
clearing/setting DMA request enable bit for the same purpose. Some DMA
request/acknowledge race may encountered by doing so. We prefer to use
dmaengine_pause and resume instead to pause a dma transfer when it is
necessary.

It is also safer to close DMA before reset DMAT in stm32_usart_shutdown.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 76 ++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index be47cd343cf6..2f9672ba4ed3 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -506,13 +506,6 @@ static bool stm32_usart_tx_dma_started(struct stm32_port *stm32_port)
 	return stm32_port->tx_dma_busy;
 }
 
-static bool stm32_usart_tx_dma_enabled(struct stm32_port *stm32_port)
-{
-	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-
-	return !!(readl_relaxed(stm32_port->port.membase + ofs->cr3) & USART_CR3_DMAT);
-}
-
 static void stm32_usart_tx_dma_complete(void *arg)
 {
 	struct uart_port *port = arg;
@@ -591,9 +584,6 @@ static void stm32_usart_transmit_chars_pio(struct uart_port *port)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 
-	if (stm32_usart_tx_dma_enabled(stm32_port))
-		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
-
 	while (!uart_circ_empty(xmit)) {
 		/* Check that TDR is empty before filling FIFO */
 		if (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
@@ -616,10 +606,16 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_async_tx_descriptor *desc = NULL;
 	unsigned int count;
+	int ret;
 
 	if (stm32_usart_tx_dma_started(stm32port)) {
-		if (!stm32_usart_tx_dma_enabled(stm32port))
-			stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAT);
+		if (dmaengine_tx_status(stm32port->tx_ch,
+					stm32port->tx_ch->cookie,
+					NULL) == DMA_PAUSED) {
+			ret = dmaengine_resume(stm32port->tx_ch);
+			if (ret < 0)
+				goto dma_err;
+		}
 		return;
 	}
 
@@ -664,11 +660,9 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 	desc->callback_param = port;
 
 	/* Push current DMA TX transaction in the pending queue */
-	if (dma_submit_error(dmaengine_submit(desc))) {
-		/* dma no yet started, safe to free resources */
-		stm32_usart_tx_dma_terminate(stm32port);
-		goto fallback_err;
-	}
+	/* DMA no yet started, safe to free resources */
+	if (dma_submit_error(dmaengine_submit(desc)))
+		goto dma_err;
 
 	/* Issue pending DMA TX requests */
 	dma_async_issue_pending(stm32port->tx_ch);
@@ -679,6 +673,10 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 
 	return;
 
+dma_err:
+	dev_err(port->dev, "DMA failed with error code: %d\n", ret);
+	stm32_usart_tx_dma_terminate(stm32port);
+
 fallback_err:
 	stm32_usart_transmit_chars_pio(port);
 }
@@ -701,9 +699,15 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
 
 	if (port->x_char) {
 		if (stm32_usart_tx_dma_started(stm32_port) &&
-		    stm32_usart_tx_dma_enabled(stm32_port))
-			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
-
+		    dmaengine_tx_status(stm32_port->tx_ch,
+					stm32_port->tx_ch->cookie,
+					NULL) == DMA_IN_PROGRESS) {
+			ret = dmaengine_pause(stm32_port->tx_ch);
+			if (ret < 0) {
+				dev_err(port->dev, "DMA failed with error code: %d\n", ret);
+				stm32_usart_tx_dma_terminate(stm32_port);
+			}
+		}
 		/* Check that TDR is empty before filling FIFO */
 		ret =
 		readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
@@ -716,8 +720,14 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
 		writel_relaxed(port->x_char, port->membase + ofs->tdr);
 		port->x_char = 0;
 		port->icount.tx++;
-		if (stm32_usart_tx_dma_started(stm32_port))
-			stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAT);
+
+		if (stm32_usart_tx_dma_started(stm32_port)) {
+			ret = dmaengine_resume(stm32_port->tx_ch);
+			if (ret < 0) {
+				dev_err(port->dev, "DMA failed with error code: %d\n", ret);
+				stm32_usart_tx_dma_terminate(stm32_port);
+			}
+		}
 		return;
 	}
 
@@ -850,11 +860,16 @@ static void stm32_usart_disable_ms(struct uart_port *port)
 static void stm32_usart_stop_tx(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	int ret;
 
 	stm32_usart_tx_interrupt_disable(port);
-	if (stm32_usart_tx_dma_started(stm32_port) && stm32_usart_tx_dma_enabled(stm32_port))
-		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
+	if (stm32_usart_tx_dma_started(stm32_port)) {
+		ret = dmaengine_pause(stm32_port->tx_ch);
+		if (ret < 0) {
+			dev_err(port->dev, "DMA failed with error code: %d\n", ret);
+			stm32_usart_tx_dma_terminate(stm32_port);
+		}
+	}
 
 	stm32_usart_rs485_rts_disable(port);
 }
@@ -878,12 +893,9 @@ static void stm32_usart_start_tx(struct uart_port *port)
 static void stm32_usart_flush_buffer(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
-	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
-	if (stm32_port->tx_ch) {
+	if (stm32_port->tx_ch)
 		stm32_usart_tx_dma_terminate(stm32_port);
-		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
-	}
 }
 
 /* Throttle the remote when input buffer is about to overflow. */
@@ -1042,12 +1054,12 @@ static void stm32_usart_shutdown(struct uart_port *port)
 	u32 val, isr;
 	int ret;
 
-	if (stm32_usart_tx_dma_enabled(stm32_port))
-		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
-
 	if (stm32_usart_tx_dma_started(stm32_port))
 		stm32_usart_tx_dma_terminate(stm32_port);
 
+	if (stm32_port->tx_ch)
+		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
+
 	/* Disable modem control interrupts */
 	stm32_usart_disable_ms(port);
 
-- 
2.25.1

