Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23E77427B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjHHRp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjHHRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:28 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8154925B17;
        Tue,  8 Aug 2023 09:20:37 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378CoZak028518;
        Tue, 8 Aug 2023 18:19:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=sDVdmzlOw9KaqcJOaAInkeyF4AR3n6Sh8qLWXt91jcU=; b=Zn
        cD3kgVI3oJN3ROHLERcUt5Pqn2nleCWuBIwXRsv7g5CjLAYrnhwcP/kxVSeC+MsE
        3PzmdkdgRZ77LGngR/Iv1CHjNpYy7q+73yl/7NJ2b5s/iADuRmLs9XLuRNaHMogx
        DMfd7SmQe8B+ufpAxKp87/3xUyHEwE3Dm/PoHMG4AMuav0sS9eUOp90EJQHU/vbd
        HJ401+gK7n/e3ZXg9JlKBLjEkpSnsJUSbo1AdNI13DypFVRdbjYfH6A7XULaLouz
        c4R5ZXo3mfdUAfaECdp4LtTnzll6P4r5jAUR7cMvQoz7zwAKCE2xeWr8hB5suKfR
        3RkYUPaI8TxAW1WOQS5w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sbp2d958k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:19:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 197D9100061;
        Tue,  8 Aug 2023 18:19:40 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0BE98235F2C;
        Tue,  8 Aug 2023 18:19:40 +0200 (CEST)
Received: from localhost (10.201.20.168) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 8 Aug
 2023 18:19:39 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 3/6] serial: stm32: modify parameter and rename stm32_usart_rx_dma_enabled
Date:   Tue, 8 Aug 2023 18:19:03 +0200
Message-ID: <20230808161906.178996-4-valentin.caron@foss.st.com>
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

Rename stm32_usart_rx_dma_enabled to stm32_usart_rx_dma_started in order
to match with stm32_usart_tx_dma_started.

Modify argument of stm32_usart_rx_dma_started from uart_port structure to
stm32_port structure to match with stm32_usart_tx_dma_started.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index a1585aa1ceb0..3471e23bb02f 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -289,9 +289,9 @@ static int stm32_usart_init_rs485(struct uart_port *port,
 	return uart_get_rs485_mode(port);
 }
 
-static bool stm32_usart_rx_dma_enabled(struct uart_port *port)
+static bool stm32_usart_rx_dma_started(struct stm32_port *stm32_port)
 {
-	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct uart_port *port = &stm32_port->port;
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 
 	if (!stm32_port->rx_ch)
@@ -310,7 +310,7 @@ static bool stm32_usart_pending_rx_pio(struct uart_port *port, u32 *sr)
 	/* Get pending characters in RDR or FIFO */
 	if (*sr & USART_SR_RXNE) {
 		/* Get all pending characters from the RDR or the FIFO when using interrupts */
-		if (!stm32_usart_rx_dma_enabled(port))
+		if (!stm32_usart_rx_dma_started(stm32_port))
 			return true;
 
 		/* Handle only RX data errors when using DMA */
@@ -455,7 +455,7 @@ static unsigned int stm32_usart_receive_chars(struct uart_port *port, bool force
 	u32 sr;
 	unsigned int size = 0;
 
-	if (stm32_usart_rx_dma_enabled(port) || force_dma_flush) {
+	if (stm32_usart_rx_dma_started(stm32_port) || force_dma_flush) {
 		rx_dma_status = dmaengine_tx_status(stm32_port->rx_ch,
 						    stm32_port->rx_ch->cookie,
 						    &stm32_port->rx_dma_state);
@@ -789,8 +789,8 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	 * line has been masked by HW and rx data are stacking in FIFO.
 	 */
 	if (!stm32_port->throttled) {
-		if (((sr & USART_SR_RXNE) && !stm32_usart_rx_dma_enabled(port)) ||
-		    ((sr & USART_SR_ERR_MASK) && stm32_usart_rx_dma_enabled(port))) {
+		if (((sr & USART_SR_RXNE) && !stm32_usart_rx_dma_started(stm32_port)) ||
+		    ((sr & USART_SR_ERR_MASK) && stm32_usart_rx_dma_started(stm32_port))) {
 			spin_lock(&port->lock);
 			size = stm32_usart_receive_chars(port, false);
 			uart_unlock_and_check_sysrq(port);
@@ -806,7 +806,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	}
 
 	/* Receiver timeout irq for DMA RX */
-	if (stm32_usart_rx_dma_enabled(port) && !stm32_port->throttled) {
+	if (stm32_usart_rx_dma_started(stm32_port) && !stm32_port->throttled) {
 		spin_lock(&port->lock);
 		size = stm32_usart_receive_chars(port, false);
 		uart_unlock_and_check_sysrq(port);
@@ -906,7 +906,7 @@ static void stm32_usart_throttle(struct uart_port *port)
 	 * Disable DMA request line if enabled, so the RX data gets queued into the FIFO.
 	 * Hardware flow control is triggered when RX FIFO is full.
 	 */
-	if (stm32_usart_rx_dma_enabled(port))
+	if (stm32_usart_rx_dma_started(stm32_port))
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
 	stm32_usart_clr_bits(port, ofs->cr1, stm32_port->cr1_irq);
-- 
2.25.1

