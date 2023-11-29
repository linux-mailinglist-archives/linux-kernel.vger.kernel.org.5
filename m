Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8E77FD82B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjK2NcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjK2NcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:32:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E9A8;
        Wed, 29 Nov 2023 05:32:28 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701264747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFBYXKut7TNseCcM7GDNiKC6SHR9T9wHwrIA5vtpJjg=;
        b=ZpaFf3hs/iZM03CjEZSZ14Qea/ldIIY6SDQ7fmKZ/IWruqM9DbCo6N1xV4QTKzhrAPtY1T
        OfsCh+Wim99YpeCUxCy9ImCKSQbNs1SrtY7pQ+72AwOZ4iaXDPPrxFbT+7k+SDrDT2TXJO
        8LfksjtDeCJrCTNKMjKmV13o1qDutmAGcm241I03+yX+4OOJ37/LvMzCrSl1UV7v+8hcOe
        2ylk7ihWH4e6X4UoMV8R1GyiaGwpAZMyEczpfngg6MhUcn0DMeN6wxC4sJEdL8RPZyGGmQ
        Jgw+peafL8p/PaWBLRgQGUo81U88QYPad7bykBsqh0e/XZRBIBvB4JRduHZZKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701264747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFBYXKut7TNseCcM7GDNiKC6SHR9T9wHwrIA5vtpJjg=;
        b=VrbbZZOOYfLT/6J7wiPZIBF+kUiihUTBV3M2v3gQKRiqTFzswjuxZ0bw8Jlg5lZ62qq8Q+
        UB18DcT5J6sp2pCA==
To:     linus.walleij@linaro.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/2] spi: spl022: switch to use default spi_transfer_one_message()
Date:   Wed, 29 Nov 2023 14:32:19 +0100
Message-Id: <4a0aa2f626f5f6e5509f9d0d64345fc8fe3b34d9.1701264413.git.namcao@linutronix.de>
In-Reply-To: <cover.1701264413.git.namcao@linutronix.de>
References: <cover.1701264413.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except for polling mode, this driver's transfer_one_message() makes use
of interrupt handler and tasklet. This is problematic because
spi_transfer_delay_exec(), who may sleep, is called in interrupt handler
and tasklet. This causes the following warning:
BUG: sleeping function called from invalid context at drivers/spi/spi.c:1428

Switch to use the default spi_transfer_one_message() instead, which
calls spi_transfer_delay_exec() appropriately.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Tested with polling mode and interrupt mode, NOT with DMA mode.
Support with testing very appreciated!

 drivers/spi/spi-pl022.c | 372 +++++++---------------------------------
 1 file changed, 66 insertions(+), 306 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index d1b6110b38fc..1e3bd6f3303a 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -338,7 +338,6 @@ struct vendor_data {
  * @clk: outgoing clock "SPICLK" for the SPI bus
  * @host: SPI framework hookup
  * @host_info: controller-specific data from machine setup
- * @pump_transfers: Tasklet used in Interrupt Transfer mode
  * @cur_msg: Pointer to current spi_message being processed
  * @cur_transfer: Pointer to current spi_transfer
  * @cur_chip: pointer to current clients chip(assigned from controller_sta=
te)
@@ -372,9 +371,6 @@ struct pl022 {
 	struct clk			*clk;
 	struct spi_controller		*host;
 	struct pl022_ssp_controller	*host_info;
-	/* Message per-transfer pump */
-	struct tasklet_struct		pump_transfers;
-	struct spi_message		*cur_msg;
 	struct spi_transfer		*cur_transfer;
 	struct chip_data		*cur_chip;
 	bool				next_msg_cs_active;
@@ -437,93 +433,23 @@ struct chip_data {
  * (vendor extension). Each of the 5 LSB in the register controls one chip
  * select signal.
  */
-static void internal_cs_control(struct pl022 *pl022, u32 command)
+static void internal_cs_control(struct pl022 *pl022, bool enable)
 {
 	u32 tmp;
=20
 	tmp =3D readw(SSP_CSR(pl022->virtbase));
-	if (command =3D=3D SSP_CHIP_SELECT)
+	if (enable)
 		tmp &=3D ~BIT(pl022->cur_cs);
 	else
 		tmp |=3D BIT(pl022->cur_cs);
 	writew(tmp, SSP_CSR(pl022->virtbase));
 }
=20
-static void pl022_cs_control(struct pl022 *pl022, u32 command)
+static void pl022_cs_control(struct spi_device *spi, bool enable)
 {
+	struct pl022 *pl022 =3D spi_controller_get_devdata(spi->controller);
 	if (pl022->vendor->internal_cs_ctrl)
-		internal_cs_control(pl022, command);
-	else if (pl022->cur_gpiod)
-		/*
-		 * This needs to be inverted since with GPIOLIB in
-		 * control, the inversion will be handled by
-		 * GPIOLIB's active low handling. The "command"
-		 * passed into this function will be SSP_CHIP_SELECT
-		 * which is enum:ed to 0, so we need the inverse
-		 * (1) to activate chip select.
-		 */
-		gpiod_set_value(pl022->cur_gpiod, !command);
-}
-
-/**
- * giveback - current spi_message is over, schedule next message and call
- * callback of this message. Assumes that caller already
- * set message->status; dma and pio irqs are blocked
- * @pl022: SSP driver private data structure
- */
-static void giveback(struct pl022 *pl022)
-{
-	struct spi_transfer *last_transfer;
-	pl022->next_msg_cs_active =3D false;
-
-	last_transfer =3D list_last_entry(&pl022->cur_msg->transfers,
-					struct spi_transfer, transfer_list);
-
-	/* Delay if requested before any change in chip select */
-	/*
-	 * FIXME: This runs in interrupt context.
-	 * Is this really smart?
-	 */
-	spi_transfer_delay_exec(last_transfer);
-
-	if (!last_transfer->cs_change) {
-		struct spi_message *next_msg;
-
-		/*
-		 * cs_change was not set. We can keep the chip select
-		 * enabled if there is message in the queue and it is
-		 * for the same spi device.
-		 *
-		 * We cannot postpone this until pump_messages, because
-		 * after calling msg->complete (below) the driver that
-		 * sent the current message could be unloaded, which
-		 * could invalidate the cs_control() callback...
-		 */
-		/* get a pointer to the next message, if any */
-		next_msg =3D spi_get_next_queued_message(pl022->host);
-
-		/*
-		 * see if the next and current messages point
-		 * to the same spi device.
-		 */
-		if (next_msg && next_msg->spi !=3D pl022->cur_msg->spi)
-			next_msg =3D NULL;
-		if (!next_msg || pl022->cur_msg->state =3D=3D STATE_ERROR)
-			pl022_cs_control(pl022, SSP_CHIP_DESELECT);
-		else
-			pl022->next_msg_cs_active =3D true;
-
-	}
-
-	pl022->cur_msg =3D NULL;
-	pl022->cur_transfer =3D NULL;
-	pl022->cur_chip =3D NULL;
-
-	/* disable the SPI/SSP operation */
-	writew((readw(SSP_CR1(pl022->virtbase)) &
-		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
-
-	spi_finalize_current_message(pl022->host);
+		internal_cs_control(pl022, enable);
 }
=20
 /**
@@ -757,30 +683,6 @@ static void readwriter(struct pl022 *pl022)
 	 */
 }
=20
-/**
- * next_transfer - Move to the Next transfer in the current spi message
- * @pl022: SSP driver private data structure
- *
- * This function moves though the linked list of spi transfers in the
- * current spi message and returns with the state of current spi
- * message i.e whether its last transfer is done(STATE_DONE) or
- * Next transfer is ready(STATE_RUNNING)
- */
-static void *next_transfer(struct pl022 *pl022)
-{
-	struct spi_message *msg =3D pl022->cur_msg;
-	struct spi_transfer *trans =3D pl022->cur_transfer;
-
-	/* Move to next transfer */
-	if (trans->transfer_list.next !=3D &msg->transfers) {
-		pl022->cur_transfer =3D
-		    list_entry(trans->transfer_list.next,
-			       struct spi_transfer, transfer_list);
-		return STATE_RUNNING;
-	}
-	return STATE_DONE;
-}
-
 /*
  * This DMA functionality is only compiled in if we have
  * access to the generic DMA devices/DMA engine.
@@ -800,7 +702,6 @@ static void unmap_free_dma_scatter(struct pl022 *pl022)
 static void dma_callback(void *data)
 {
 	struct pl022 *pl022 =3D data;
-	struct spi_message *msg =3D pl022->cur_msg;
=20
 	BUG_ON(!pl022->sgt_rx.sgl);
=20
@@ -845,13 +746,7 @@ static void dma_callback(void *data)
=20
 	unmap_free_dma_scatter(pl022);
=20
-	/* Update total bytes transferred */
-	msg->actual_length +=3D pl022->cur_transfer->len;
-	/* Move to next transfer */
-	msg->state =3D next_transfer(pl022);
-	if (msg->state !=3D STATE_DONE && pl022->cur_transfer->cs_change)
-		pl022_cs_control(pl022, SSP_CHIP_DESELECT);
-	tasklet_schedule(&pl022->pump_transfers);
+	spi_finalize_current_transfer(pl022->host);
 }
=20
 static void setup_dma_scatter(struct pl022 *pl022,
@@ -1189,6 +1084,9 @@ static int pl022_dma_autoprobe(struct pl022 *pl022)
=20
 static void terminate_dma(struct pl022 *pl022)
 {
+	if (!pl022->dma_running)
+		return;
+
 	struct dma_chan *rxchan =3D pl022->dma_rx_channel;
 	struct dma_chan *txchan =3D pl022->dma_tx_channel;
=20
@@ -1200,8 +1098,7 @@ static void terminate_dma(struct pl022 *pl022)
=20
 static void pl022_dma_remove(struct pl022 *pl022)
 {
-	if (pl022->dma_running)
-		terminate_dma(pl022);
+	terminate_dma(pl022);
 	if (pl022->dma_tx_channel)
 		dma_release_channel(pl022->dma_tx_channel);
 	if (pl022->dma_rx_channel)
@@ -1225,6 +1122,10 @@ static inline int pl022_dma_probe(struct pl022 *pl02=
2)
 	return 0;
 }
=20
+static inline void terminate_dma(struct pl022 *pl022)
+{
+}
+
 static inline void pl022_dma_remove(struct pl022 *pl022)
 {
 }
@@ -1246,16 +1147,7 @@ static inline void pl022_dma_remove(struct pl022 *pl=
022)
 static irqreturn_t pl022_interrupt_handler(int irq, void *dev_id)
 {
 	struct pl022 *pl022 =3D dev_id;
-	struct spi_message *msg =3D pl022->cur_msg;
 	u16 irq_status =3D 0;
-
-	if (unlikely(!msg)) {
-		dev_err(&pl022->adev->dev,
-			"bad message state in interrupt handler");
-		/* Never fail */
-		return IRQ_HANDLED;
-	}
-
 	/* Read the Interrupt Status Register */
 	irq_status =3D readw(SSP_MIS(pl022->virtbase));
=20
@@ -1287,10 +1179,8 @@ static irqreturn_t pl022_interrupt_handler(int irq, =
void *dev_id)
 		writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl022->virtbase));
 		writew((readw(SSP_CR1(pl022->virtbase)) &
 			(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
-		msg->state =3D STATE_ERROR;
-
-		/* Schedule message queue handler */
-		tasklet_schedule(&pl022->pump_transfers);
+		pl022->cur_transfer->error |=3D SPI_TRANS_FAIL_IO;
+		spi_finalize_current_transfer(pl022->host);
 		return IRQ_HANDLED;
 	}
=20
@@ -1318,13 +1208,7 @@ static irqreturn_t pl022_interrupt_handler(int irq, =
void *dev_id)
 				 "number of bytes on a 16bit bus?)\n",
 				 (u32) (pl022->rx - pl022->rx_end));
 		}
-		/* Update total bytes transferred */
-		msg->actual_length +=3D pl022->cur_transfer->len;
-		/* Move to next transfer */
-		msg->state =3D next_transfer(pl022);
-		if (msg->state !=3D STATE_DONE && pl022->cur_transfer->cs_change)
-			pl022_cs_control(pl022, SSP_CHIP_DESELECT);
-		tasklet_schedule(&pl022->pump_transfers);
+		spi_finalize_current_transfer(pl022->host);
 		return IRQ_HANDLED;
 	}
=20
@@ -1361,98 +1245,20 @@ static int set_up_next_transfer(struct pl022 *pl022,
 	return 0;
 }
=20
-/**
- * pump_transfers - Tasklet function which schedules next transfer
- * when running in interrupt or DMA transfer mode.
- * @data: SSP driver private data structure
- *
- */
-static void pump_transfers(unsigned long data)
+static int do_interrupt_dma_transfer(struct pl022 *pl022)
 {
-	struct pl022 *pl022 =3D (struct pl022 *) data;
-	struct spi_message *message =3D NULL;
-	struct spi_transfer *transfer =3D NULL;
-	struct spi_transfer *previous =3D NULL;
-
-	/* Get current state information */
-	message =3D pl022->cur_msg;
-	transfer =3D pl022->cur_transfer;
-
-	/* Handle for abort */
-	if (message->state =3D=3D STATE_ERROR) {
-		message->status =3D -EIO;
-		giveback(pl022);
-		return;
-	}
-
-	/* Handle end of message */
-	if (message->state =3D=3D STATE_DONE) {
-		message->status =3D 0;
-		giveback(pl022);
-		return;
-	}
-
-	/* Delay if requested at end of transfer before CS change */
-	if (message->state =3D=3D STATE_RUNNING) {
-		previous =3D list_entry(transfer->transfer_list.prev,
-					struct spi_transfer,
-					transfer_list);
-		/*
-		 * FIXME: This runs in interrupt context.
-		 * Is this really smart?
-		 */
-		spi_transfer_delay_exec(previous);
-
-		/* Reselect chip select only if cs_change was requested */
-		if (previous->cs_change)
-			pl022_cs_control(pl022, SSP_CHIP_SELECT);
-	} else {
-		/* STATE_START */
-		message->state =3D STATE_RUNNING;
-	}
-
-	if (set_up_next_transfer(pl022, transfer)) {
-		message->state =3D STATE_ERROR;
-		message->status =3D -EIO;
-		giveback(pl022);
-		return;
-	}
-	/* Flush the FIFOs and let's go! */
-	flush(pl022);
-
-	if (pl022->cur_chip->enable_dma) {
-		if (configure_dma(pl022)) {
-			dev_dbg(&pl022->adev->dev,
-				"configuration of DMA failed, fall back to interrupt mode\n");
-			goto err_config_dma;
-		}
-		return;
-	}
-
-err_config_dma:
-	/* enable all interrupts except RX */
-	writew(ENABLE_ALL_INTERRUPTS & ~SSP_IMSC_MASK_RXIM, SSP_IMSC(pl022->virtb=
ase));
-}
+	int ret;
=20
-static void do_interrupt_dma_transfer(struct pl022 *pl022)
-{
 	/*
 	 * Default is to enable all interrupts except RX -
 	 * this will be enabled once TX is complete
 	 */
 	u32 irqflags =3D (u32)(ENABLE_ALL_INTERRUPTS & ~SSP_IMSC_MASK_RXIM);
=20
-	/* Enable target chip, if not already active */
-	if (!pl022->next_msg_cs_active)
-		pl022_cs_control(pl022, SSP_CHIP_SELECT);
+	ret =3D set_up_next_transfer(pl022, pl022->cur_transfer);
+	if (ret)
+		return ret;
=20
-	if (set_up_next_transfer(pl022, pl022->cur_transfer)) {
-		/* Error path */
-		pl022->cur_msg->state =3D STATE_ERROR;
-		pl022->cur_msg->status =3D -EIO;
-		giveback(pl022);
-		return;
-	}
 	/* If we're using DMA, set up DMA here */
 	if (pl022->cur_chip->enable_dma) {
 		/* Configure DMA transfer */
@@ -1469,6 +1275,7 @@ static void do_interrupt_dma_transfer(struct pl022 *p=
l022)
 	writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
 	       SSP_CR1(pl022->virtbase));
 	writew(irqflags, SSP_IMSC(pl022->virtbase));
+	return 1;
 }
=20
 static void print_current_status(struct pl022 *pl022)
@@ -1495,111 +1302,67 @@ static void print_current_status(struct pl022 *pl0=
22)
=20
 }
=20
-static void do_polling_transfer(struct pl022 *pl022)
+static int do_polling_transfer(struct pl022 *pl022)
 {
-	struct spi_message *message =3D NULL;
-	struct spi_transfer *transfer =3D NULL;
-	struct spi_transfer *previous =3D NULL;
+	int ret;
 	unsigned long time, timeout;
=20
-	message =3D pl022->cur_msg;
-
-	while (message->state !=3D STATE_DONE) {
-		/* Handle for abort */
-		if (message->state =3D=3D STATE_ERROR)
-			break;
-		transfer =3D pl022->cur_transfer;
-
-		/* Delay if requested at end of transfer */
-		if (message->state =3D=3D STATE_RUNNING) {
-			previous =3D
-			    list_entry(transfer->transfer_list.prev,
-				       struct spi_transfer, transfer_list);
-			spi_transfer_delay_exec(previous);
-			if (previous->cs_change)
-				pl022_cs_control(pl022, SSP_CHIP_SELECT);
-		} else {
-			/* STATE_START */
-			message->state =3D STATE_RUNNING;
-			if (!pl022->next_msg_cs_active)
-				pl022_cs_control(pl022, SSP_CHIP_SELECT);
-		}
-
-		/* Configuration Changing Per Transfer */
-		if (set_up_next_transfer(pl022, transfer)) {
-			/* Error path */
-			message->state =3D STATE_ERROR;
-			break;
-		}
-		/* Flush FIFOs and enable SSP */
-		flush(pl022);
-		writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
-		       SSP_CR1(pl022->virtbase));
-
-		dev_dbg(&pl022->adev->dev, "polling transfer ongoing ...\n");
-
-		timeout =3D jiffies + msecs_to_jiffies(SPI_POLLING_TIMEOUT);
-		while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end) {
-			time =3D jiffies;
-			readwriter(pl022);
-			if (time_after(time, timeout)) {
-				dev_warn(&pl022->adev->dev,
-				"%s: timeout!\n", __func__);
-				message->state =3D STATE_TIMEOUT;
-				print_current_status(pl022);
-				goto out;
-			}
-			cpu_relax();
+	/* Configuration Changing Per Transfer */
+	ret =3D set_up_next_transfer(pl022, pl022->cur_transfer);
+	if (ret)
+		return ret;
+	/* Flush FIFOs and enable SSP */
+	flush(pl022);
+	writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
+		SSP_CR1(pl022->virtbase));
+
+	dev_dbg(&pl022->adev->dev, "polling transfer ongoing ...\n");
+
+	timeout =3D jiffies + msecs_to_jiffies(SPI_POLLING_TIMEOUT);
+	while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end) {
+		time =3D jiffies;
+		readwriter(pl022);
+		if (time_after(time, timeout)) {
+			dev_warn(&pl022->adev->dev,
+			"%s: timeout!\n", __func__);
+			print_current_status(pl022);
+			return -ETIMEDOUT;
 		}
-
-		/* Update total byte transferred */
-		message->actual_length +=3D pl022->cur_transfer->len;
-		/* Move to next transfer */
-		message->state =3D next_transfer(pl022);
-		if (message->state !=3D STATE_DONE
-		    && pl022->cur_transfer->cs_change)
-			pl022_cs_control(pl022, SSP_CHIP_DESELECT);
+		cpu_relax();
 	}
-out:
-	/* Handle end of message */
-	if (message->state =3D=3D STATE_DONE)
-		message->status =3D 0;
-	else if (message->state =3D=3D STATE_TIMEOUT)
-		message->status =3D -EAGAIN;
-	else
-		message->status =3D -EIO;
=20
-	giveback(pl022);
-	return;
+	return 0;
 }
=20
-static int pl022_transfer_one_message(struct spi_controller *host,
-				      struct spi_message *msg)
+static int pl022_transfer_one(struct spi_controller *host, struct spi_devi=
ce *spi,
+			      struct spi_transfer *transfer)
 {
 	struct pl022 *pl022 =3D spi_controller_get_devdata(host);
=20
-	/* Initial message state */
-	pl022->cur_msg =3D msg;
-	msg->state =3D STATE_START;
-
-	pl022->cur_transfer =3D list_entry(msg->transfers.next,
-					 struct spi_transfer, transfer_list);
+	pl022->cur_transfer =3D transfer;
=20
 	/* Setup the SPI using the per chip configuration */
-	pl022->cur_chip =3D spi_get_ctldata(msg->spi);
-	pl022->cur_cs =3D spi_get_chipselect(msg->spi, 0);
+	pl022->cur_chip =3D spi_get_ctldata(spi);
+	pl022->cur_cs =3D spi_get_chipselect(spi, 0);
 	/* This is always available but may be set to -ENOENT */
-	pl022->cur_gpiod =3D spi_get_csgpiod(msg->spi, 0);
+	pl022->cur_gpiod =3D spi_get_csgpiod(spi, 0);
=20
 	restore_state(pl022);
 	flush(pl022);
=20
 	if (pl022->cur_chip->xfer_type =3D=3D POLLING_TRANSFER)
-		do_polling_transfer(pl022);
+		return do_polling_transfer(pl022);
 	else
-		do_interrupt_dma_transfer(pl022);
+		return do_interrupt_dma_transfer(pl022);
+}
=20
-	return 0;
+static void pl022_handle_err(struct spi_controller *ctlr, struct spi_messa=
ge *message)
+{
+	struct pl022 *pl022 =3D spi_controller_get_devdata(ctlr);
+
+	terminate_dma(pl022);
+	writew(DISABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase));
+	writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl022->virtbase));
 }
=20
 static int pl022_unprepare_transfer_hardware(struct spi_controller *host)
@@ -2138,7 +1901,9 @@ static int pl022_probe(struct amba_device *adev, cons=
t struct amba_id *id)
 	host->cleanup =3D pl022_cleanup;
 	host->setup =3D pl022_setup;
 	host->auto_runtime_pm =3D true;
-	host->transfer_one_message =3D pl022_transfer_one_message;
+	host->transfer_one =3D pl022_transfer_one;
+	host->set_cs =3D pl022_cs_control;
+	host->handle_err =3D pl022_handle_err;
 	host->unprepare_transfer_hardware =3D pl022_unprepare_transfer_hardware;
 	host->rt =3D platform_info->rt;
 	host->dev.of_node =3D dev->of_node;
@@ -2175,10 +1940,6 @@ static int pl022_probe(struct amba_device *adev, con=
st struct amba_id *id)
 		goto err_no_clk;
 	}
=20
-	/* Initialize transfer pump */
-	tasklet_init(&pl022->pump_transfers, pump_transfers,
-		     (unsigned long)pl022);
-
 	/* Disable SSP */
 	writew((readw(SSP_CR1(pl022->virtbase)) & (~SSP_CR1_MASK_SSE)),
 	       SSP_CR1(pl022->virtbase));
@@ -2261,7 +2022,6 @@ pl022_remove(struct amba_device *adev)
 		pl022_dma_remove(pl022);
=20
 	amba_release_regions(adev);
-	tasklet_disable(&pl022->pump_transfers);
 }
=20
 #ifdef CONFIG_PM_SLEEP
--=20
2.39.2

