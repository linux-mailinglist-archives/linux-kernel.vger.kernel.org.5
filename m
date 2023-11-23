Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C447F609C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345644AbjKWNnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345565AbjKWNmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:42:43 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8631A1B6;
        Thu, 23 Nov 2023 05:42:47 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 787CF20011;
        Thu, 23 Nov 2023 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700746966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IT1PcfUa22MBQ1p+BY7LwIRGBeFmRjn+EU4L2rx/jDU=;
        b=PTFb0uJnuyCvR9oSkLUcrn57C5SUoUuu4PZouVVwBf750ny+fFjabOU7Da2FT0lZ/JbGho
        IVQHXPplK3lqQENhpV7xcms0UIctM5dBjlj/OHklady82K2vchzmjqAut2QJz/wnoCC3zV
        JmlfcuSmECN9p3mzspxC2nPLu1NYl51/Gzk2o+rgFln3TWEt3mPeY6+KzaSBhve3olHFKw
        11PuJ+1ZzJQ7bfj9uYKhXKGSRMcVkgttHdV/sMWFQBpKv3VXK0PVdrBGp2e3XUdCrbgUYr
        KJ7PgHtZq2QEbLA1O5IU6JQ5/rHcLn5SbWa3Y7HV+t8CFk6z1mjy8FUH0Eruqg==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 23 Nov 2023 14:42:41 +0100
Subject: [PATCH v4 3/6] tty: serial: amba-pl011: cleanup driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-mbly-uart-v4-3-7f913a74ff89@bootlin.com>
References: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
In-Reply-To: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow recommandations from:

    $ ./scripts/checkpatch.pl --strict --file \
            drivers/tty/serial/amba-pl011.c

It does NOT fix alerts relative to TIOCMBIT which will be dealt with in
another patch. Fixes following alerts:

    CHECK: Alignment should match open parenthesis
    CHECK: Blank lines aren't necessary after an open brace '{'
    CHECK: Comparison to NULL could be written [...]
    CHECK: Lines should not end with a '('
    CHECK: Please don't use multiple blank lines
    CHECK: Please use a blank line after function/struct/union/enum declarations
    CHECK: Prefer using the BIT macro
    CHECK: Unbalanced braces around else statement
    CHECK: Unnecessary parentheses around [...]
    CHECK: braces {} should be used on all arms of this statement
    CHECK: spaces preferred around that '/' (ctx:VxV)
    CHECK: spaces preferred around that '|' (ctx:VxV)
    ERROR: do not initialise statics to false
    WARNING: Comparisons should place the constant on the right side of the test
    WARNING: Possible unnecessary 'out of memory' message
    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
    WARNING: quoted string split across lines

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 147 +++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 76 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3dc9b0fcab1c..3beac358909f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -50,8 +50,8 @@
 
 #define AMBA_ISR_PASS_LIMIT	256
 
-#define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
-#define UART_DUMMY_DR_RX	(1 << 16)
+#define UART_DR_ERROR		(UART011_DR_OE | UART011_DR_BE | UART011_DR_PE | UART011_DR_FE)
+#define UART_DUMMY_DR_RX	BIT(16)
 
 enum {
 	REG_DR,
@@ -125,7 +125,7 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
 
 static struct vendor_data vendor_arm = {
 	.reg_offset		= pl011_std_offsets,
-	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
+	.ifls			= UART011_IFLS_RX4_8 | UART011_IFLS_TX4_8,
 	.fr_busy		= UART01x_FR_BUSY,
 	.fr_dsr			= UART01x_FR_DSR,
 	.fr_cts			= UART01x_FR_CTS,
@@ -203,7 +203,7 @@ static unsigned int get_fifosize_st(struct amba_device *dev)
 
 static struct vendor_data vendor_st = {
 	.reg_offset		= pl011_st_offsets,
-	.ifls			= UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
+	.ifls			= UART011_IFLS_RX_HALF | UART011_IFLS_TX_HALF,
 	.fr_busy		= UART01x_FR_BUSY,
 	.fr_dsr			= UART01x_FR_DSR,
 	.fr_cts			= UART01x_FR_CTS,
@@ -275,13 +275,13 @@ struct uart_amba_port {
 static unsigned int pl011_tx_empty(struct uart_port *port);
 
 static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
-	unsigned int reg)
+					unsigned int reg)
 {
 	return uap->reg_offset[reg];
 }
 
 static unsigned int pl011_read(const struct uart_amba_port *uap,
-	unsigned int reg)
+			       unsigned int reg)
 {
 	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
 
@@ -290,7 +290,7 @@ static unsigned int pl011_read(const struct uart_amba_port *uap,
 }
 
 static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
-	unsigned int reg)
+			unsigned int reg)
 {
 	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
 
@@ -328,10 +328,12 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 				uap->port.icount.brk++;
 				if (uart_handle_break(&uap->port))
 					continue;
-			} else if (ch & UART011_DR_PE)
+			} else if (ch & UART011_DR_PE) {
 				uap->port.icount.parity++;
-			else if (ch & UART011_DR_FE)
+			} else if (ch & UART011_DR_FE) {
 				uap->port.icount.frame++;
+			}
+
 			if (ch & UART011_DR_OE)
 				uap->port.icount.overrun++;
 
@@ -356,7 +358,6 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 	return fifotaken;
 }
 
-
 /*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
@@ -367,18 +368,18 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 #define PL011_DMA_BUFFER_SIZE PAGE_SIZE
 
 static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
-	enum dma_data_direction dir)
+			    enum dma_data_direction dir)
 {
 	dma_addr_t dma_addr;
 
 	sg->buf = dma_alloc_coherent(chan->device->dev,
-		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
+				     PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
 	if (!sg->buf)
 		return -ENOMEM;
 
 	sg_init_table(&sg->sg, 1);
 	sg_set_page(&sg->sg, phys_to_page(dma_addr),
-		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
+		    PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
 	sg_dma_address(&sg->sg) = dma_addr;
 	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
 
@@ -386,12 +387,11 @@ static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
 }
 
 static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
-	enum dma_data_direction dir)
+			     enum dma_data_direction dir)
 {
 	if (sg->buf) {
-		dma_free_coherent(chan->device->dev,
-			PL011_DMA_BUFFER_SIZE, sg->buf,
-			sg_dma_address(&sg->sg));
+		dma_free_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
+				  sg->buf, sg_dma_address(&sg->sg));
 	}
 }
 
@@ -430,7 +430,7 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 		dma_cap_set(DMA_SLAVE, mask);
 
 		chan = dma_request_channel(mask, plat->dma_filter,
-						plat->dma_tx_param);
+					   plat->dma_tx_param);
 		if (!chan) {
 			dev_err(uap->port.dev, "no TX DMA channel!\n");
 			return;
@@ -471,12 +471,12 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 		 * If the controller does, check for suitable residue processing
 		 * otherwise assime all is well.
 		 */
-		if (0 == dma_get_slave_caps(chan, &caps)) {
+		if (dma_get_slave_caps(chan, &caps) == 0) {
 			if (caps.residue_granularity ==
 					DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
 				dma_release_channel(chan);
 				dev_info(uap->port.dev,
-					"RX DMA disabled - no residue processing\n");
+					 "RX DMA disabled - no residue processing\n");
 				return;
 			}
 		}
@@ -505,18 +505,16 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 			else
 				uap->dmarx.poll_timeout = 3000;
 		} else if (!plat && dev->of_node) {
-			uap->dmarx.auto_poll_rate = of_property_read_bool(
-						dev->of_node, "auto-poll");
+			uap->dmarx.auto_poll_rate =
+				of_property_read_bool(dev->of_node, "auto-poll");
 			if (uap->dmarx.auto_poll_rate) {
 				u32 x;
 
-				if (0 == of_property_read_u32(dev->of_node,
-						"poll-rate-ms", &x))
+				if (of_property_read_u32(dev->of_node, "poll-rate-ms", &x) == 0)
 					uap->dmarx.poll_rate = x;
 				else
 					uap->dmarx.poll_rate = 100;
-				if (0 == of_property_read_u32(dev->of_node,
-						"poll-timeout-ms", &x))
+				if (of_property_read_u32(dev->of_node, "poll-timeout-ms", &x) == 0)
 					uap->dmarx.poll_timeout = x;
 				else
 					uap->dmarx.poll_timeout = 3000;
@@ -624,9 +622,9 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	if (count > PL011_DMA_BUFFER_SIZE)
 		count = PL011_DMA_BUFFER_SIZE;
 
-	if (xmit->tail < xmit->head)
+	if (xmit->tail < xmit->head) {
 		memcpy(&dmatx->buf[0], &xmit->buf[xmit->tail], count);
-	else {
+	} else {
 		size_t first = UART_XMIT_SIZE - xmit->tail;
 		size_t second;
 
@@ -648,7 +646,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	}
 
 	desc = dmaengine_prep_slave_sg(chan, &dmatx->sg, 1, DMA_MEM_TO_DEV,
-					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
 		dma_unmap_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
@@ -759,8 +757,9 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 			if (pl011_dma_tx_refill(uap) > 0) {
 				uap->im &= ~UART011_TXIM;
 				pl011_write(uap->im, uap, REG_IMSC);
-			} else
+			} else {
 				ret = false;
+			}
 		} else if (!(uap->dmacr & UART011_TXDMAE)) {
 			uap->dmacr |= UART011_TXDMAE;
 			pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -836,9 +835,8 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	/* Start the RX DMA job */
 	sgbuf = uap->dmarx.use_buf_b ?
 		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
-	desc = dmaengine_prep_slave_sg(rxchan, &sgbuf->sg, 1,
-					DMA_DEV_TO_MEM,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc = dmaengine_prep_slave_sg(rxchan, &sgbuf->sg, 1, DMA_DEV_TO_MEM,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	/*
 	 * If the DMA engine is busy and cannot prepare a
 	 * channel, no big deal, the driver will fall back
@@ -894,14 +892,13 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	/* Pick the remain data from the DMA */
 	if (pending) {
-
 		/*
 		 * First take all chars in the DMA pipe, then look in the FIFO.
 		 * Note that tty_insert_flip_buf() tries to take as many chars
 		 * as it can.
 		 */
 		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
-				pending);
+						   pending);
 
 		uap->port.icount.rx += dma_count;
 		if (dma_count < pending)
@@ -983,8 +980,8 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	/* Switch buffer & re-trigger DMA job */
 	dmarx->use_buf_b = !dmarx->use_buf_b;
 	if (pl011_dma_rx_trigger_dma(uap)) {
-		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
-			"fall back to interrupt mode\n");
+		dev_dbg(uap->port.dev,
+			"could not retrigger RX DMA job fall back to interrupt mode\n");
 		uap->im |= UART011_RXIM;
 		pl011_write(uap->im, uap, REG_IMSC);
 	}
@@ -1031,8 +1028,8 @@ static void pl011_dma_rx_callback(void *data)
 	 * get some IRQ immediately from RX.
 	 */
 	if (ret) {
-		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
-			"fall back to interrupt mode\n");
+		dev_dbg(uap->port.dev,
+			"could not retrigger RX DMA job fall back to interrupt mode\n");
 		uap->im |= UART011_RXIM;
 		pl011_write(uap->im, uap, REG_IMSC);
 	}
@@ -1077,7 +1074,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 		dmataken = sgbuf->sg.length - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
 		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
-				size);
+						   size);
 		if (dma_count == size)
 			dmarx->last_residue =  state.residue;
 		dmarx->last_jiffies = jiffies;
@@ -1090,7 +1087,6 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	 */
 	if (jiffies_to_msecs(jiffies - dmarx->last_jiffies)
 			> uap->dmarx.poll_timeout) {
-
 		spin_lock_irqsave(&uap->port.lock, flags);
 		pl011_dma_rx_stop(uap);
 		uap->im |= UART011_RXIM;
@@ -1102,7 +1098,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 		del_timer(&uap->dmarx.timer);
 	} else {
 		mod_timer(&uap->dmarx.timer,
-			jiffies + msecs_to_jiffies(uap->dmarx.poll_rate));
+			  jiffies + msecs_to_jiffies(uap->dmarx.poll_rate));
 	}
 }
 
@@ -1118,7 +1114,6 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 
 	uap->dmatx.buf = kmalloc(PL011_DMA_BUFFER_SIZE, GFP_KERNEL | __GFP_DMA);
 	if (!uap->dmatx.buf) {
-		dev_err(uap->port.dev, "no memory for DMA TX buffer\n");
 		uap->port.fifosize = uap->fifosize;
 		return;
 	}
@@ -1169,13 +1164,12 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 
 	if (uap->using_rx_dma) {
 		if (pl011_dma_rx_trigger_dma(uap))
-			dev_dbg(uap->port.dev, "could not trigger initial "
-				"RX DMA job, fall back to interrupt mode\n");
+			dev_dbg(uap->port.dev,
+				"could not trigger initial RX DMA job, fall back to interrupt mode\n");
 		if (uap->dmarx.poll_rate) {
 			timer_setup(&uap->dmarx.timer, pl011_dma_rx_poll, 0);
 			mod_timer(&uap->dmarx.timer,
-				jiffies +
-				msecs_to_jiffies(uap->dmarx.poll_rate));
+				  jiffies + msecs_to_jiffies(uap->dmarx.poll_rate));
 			uap->dmarx.last_residue = PL011_DMA_BUFFER_SIZE;
 			uap->dmarx.last_jiffies = jiffies;
 		}
@@ -1363,8 +1357,8 @@ static void pl011_stop_rx(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	uap->im &= ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
-		     UART011_PEIM|UART011_BEIM|UART011_OEIM);
+	uap->im &= ~(UART011_RXIM | UART011_RTIM | UART011_FEIM |
+		     UART011_PEIM | UART011_BEIM | UART011_OEIM);
 	pl011_write(uap->im, uap, REG_IMSC);
 
 	pl011_dma_rx_stop(uap);
@@ -1384,7 +1378,7 @@ static void pl011_enable_ms(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	uap->im |= UART011_RIMIM|UART011_CTSMIM|UART011_DCDMIM|UART011_DSRMIM;
+	uap->im |= UART011_RIMIM | UART011_CTSMIM | UART011_DCDMIM | UART011_DSRMIM;
 	pl011_write(uap->im, uap, REG_IMSC);
 }
 
@@ -1402,8 +1396,8 @@ __acquires(&uap->port.lock)
 	 */
 	if (pl011_dma_rx_available(uap)) {
 		if (pl011_dma_rx_trigger_dma(uap)) {
-			dev_dbg(uap->port.dev, "could not trigger RX DMA job "
-				"fall back to interrupt mode again\n");
+			dev_dbg(uap->port.dev,
+				"could not trigger RX DMA job fall back to interrupt mode again\n");
 			uap->im |= UART011_RXIM;
 			pl011_write(uap->im, uap, REG_IMSC);
 		} else {
@@ -1413,8 +1407,7 @@ __acquires(&uap->port.lock)
 				uap->dmarx.last_jiffies = jiffies;
 				uap->dmarx.last_residue	= PL011_DMA_BUFFER_SIZE;
 				mod_timer(&uap->dmarx.timer,
-					jiffies +
-					msecs_to_jiffies(uap->dmarx.poll_rate));
+					  jiffies + msecs_to_jiffies(uap->dmarx.poll_rate));
 			}
 #endif
 		}
@@ -1561,18 +1554,17 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 		do {
 			check_apply_cts_event_workaround(uap);
 
-			pl011_write(status & ~(UART011_TXIS|UART011_RTIS|
-					       UART011_RXIS),
+			pl011_write(status & ~(UART011_TXIS | UART011_RTIS | UART011_RXIS),
 				    uap, REG_ICR);
 
-			if (status & (UART011_RTIS|UART011_RXIS)) {
+			if (status & (UART011_RTIS | UART011_RXIS)) {
 				if (pl011_dma_rx_running(uap))
 					pl011_dma_rx_irq(uap);
 				else
 					pl011_rx_chars(uap);
 			}
-			if (status & (UART011_DSRMIS|UART011_DCDMIS|
-				      UART011_CTSMIS|UART011_RIMIS))
+			if (status & (UART011_DSRMIS | UART011_DCDMIS |
+				      UART011_CTSMIS | UART011_RIMIS))
 				pl011_modem_status(uap);
 			if (status & UART011_TXIS)
 				pl011_tx_chars(uap, true);
@@ -1712,7 +1704,7 @@ static int pl011_get_poll_char(struct uart_port *port)
 }
 
 static void pl011_put_poll_char(struct uart_port *port,
-			 unsigned char ch)
+				unsigned char ch)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
@@ -1914,13 +1906,13 @@ static int sbsa_uart_startup(struct uart_port *port)
 }
 
 static void pl011_shutdown_channel(struct uart_amba_port *uap,
-					unsigned int lcrh)
+				   unsigned int lcrh)
 {
-      unsigned long val;
+	unsigned long val;
 
-      val = pl011_read(uap, lcrh);
-      val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
-      pl011_write(val, uap, lcrh);
+	val = pl011_read(uap, lcrh);
+	val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
+	pl011_write(val, uap, lcrh);
 }
 
 /*
@@ -2069,7 +2061,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		uap->dmarx.poll_rate = DIV_ROUND_UP(10000000, baud);
 #endif
 
-	if (baud > port->uartclk/16)
+	if (baud > port->uartclk / 16)
 		quot = DIV_ROUND_CLOSEST(port->uartclk * 8, baud);
 	else
 		quot = DIV_ROUND_CLOSEST(port->uartclk * 4, baud);
@@ -2151,9 +2143,9 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * else we see data corruption.
 	 */
 	if (uap->vendor->oversampling) {
-		if ((baud >= 3000000) && (baud < 3250000) && (quot > 1))
+		if (baud >= 3000000 && baud < 3250000 && quot > 1)
 			quot -= 1;
-		else if ((baud > 3250000) && (quot > 2))
+		else if (baud > 3250000 && quot > 2)
 			quot -= 2;
 	}
 	/* Set baud rate */
@@ -2222,13 +2214,14 @@ static void pl011_config_port(struct uart_port *port, int flags)
 static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	int ret = 0;
+
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_AMBA)
 		ret = -EINVAL;
 	if (ser->irq < 0 || ser->irq >= nr_irqs)
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;
-	if (port->mapbase != (unsigned long) ser->iomem_base)
+	if (port->mapbase != (unsigned long)ser->iomem_base)
 		ret = -EINVAL;
 	return ret;
 }
@@ -2537,7 +2530,7 @@ static void qdf2400_e44_putc(struct uart_port *port, unsigned char c)
 		cpu_relax();
 }
 
-static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned n)
+static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
@@ -2556,7 +2549,7 @@ static void pl011_putc(struct uart_port *port, unsigned char c)
 		cpu_relax();
 }
 
-static void pl011_early_write(struct console *con, const char *s, unsigned n)
+static void pl011_early_write(struct console *con, const char *s, unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
@@ -2617,6 +2610,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 
 	return 0;
 }
+
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
 OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
 
@@ -2640,6 +2634,7 @@ qdf2400_e44_early_console_setup(struct earlycon_device *device,
 	device->con->write = qdf2400_e44_early_write;
 	return 0;
 }
+
 EARLYCON_DECLARE(qdf2400_e44, qdf2400_e44_early_console_setup);
 
 #else
@@ -2659,8 +2654,8 @@ static struct uart_driver amba_reg = {
 static int pl011_probe_dt_alias(int index, struct device *dev)
 {
 	struct device_node *np;
-	static bool seen_dev_with_alias = false;
-	static bool seen_dev_without_alias = false;
+	static bool seen_dev_with_alias;
+	static bool seen_dev_without_alias;
 	int ret = index;
 
 	if (!IS_ENABLED(CONFIG_OF))
@@ -2676,7 +2671,7 @@ static int pl011_probe_dt_alias(int index, struct device *dev)
 		ret = index;
 	} else {
 		seen_dev_with_alias = true;
-		if (ret >= ARRAY_SIZE(amba_ports) || amba_ports[ret] != NULL) {
+		if (ret >= ARRAY_SIZE(amba_ports) || amba_ports[ret]) {
 			dev_warn(dev, "requested serial port %d  not available.\n", ret);
 			ret = index;
 		}
@@ -2710,7 +2705,7 @@ static int pl011_find_free_port(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
-		if (amba_ports[i] == NULL)
+		if (!amba_ports[i])
 			return i;
 
 	return -EBUSY;
@@ -3002,7 +2997,7 @@ static struct amba_driver pl011_driver = {
 
 static int __init pl011_init(void)
 {
-	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
+	pr_info("Serial: AMBA PL011 UART driver\n");
 
 	if (platform_driver_register(&arm_sbsa_uart_platform_driver))
 		pr_warn("could not register SBSA UART platform driver\n");

-- 
2.42.0

