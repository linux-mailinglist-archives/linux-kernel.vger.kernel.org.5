Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479487EF85E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjKQUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346189AbjKQUOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:14:07 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51110EC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:59 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2ec9a79bdso1596279b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252038; x=1700856838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RuICcIcIl3AaiTh6lEHwrcRrEfhi3pyQa5k6SJhLUA=;
        b=z3zTquZ/PPv2BrCckuX+EitkYM/I38XDoZFzCE5W1EYWyPeOUTI1YkuhNWWKqolK82
         hTf+jkNQhB/Ys074Zs0o8ZMqISyPVChgSffD7nOBLS3AHrZM9aRz/ebbzYCn1AylZusF
         MMWn7u6sUqQxS25amZGsnVyt3VCeTit36BoxR1LBjQk8vUD9IrIEaXSXL25p/a5qac2r
         x9tAde+rnFSdIJA4HzMtxk+gDiZoTmIUrzLZJqU57x4sJ07QMJtN8WVl0Sd/PG1JkC22
         jjNbpNQJDxOURyZ+09RaVPGg/DD8WS2b7qzeeTRiHIwY1A3jht6ddO1g2P2CztvvAwP3
         sNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252038; x=1700856838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RuICcIcIl3AaiTh6lEHwrcRrEfhi3pyQa5k6SJhLUA=;
        b=BlLBkFOBGp0DAjYSXl9FsyR3Fjoz3Ip7ILJS+PSb7VC9h3nut+BsJzd70WlnlsoAY2
         WjG1u2GJd7+bxAvQ3Jf0Ugd/NEUPTfHmBVaungMPe3YnkuGQpMRioNmq9Eh0jUSpzdAj
         aVx1K+zNFdLybRUMbuL7QTosq2qxX7rr8coMNfPeBbFGOabJYCTaDxvbY5RFvkb7auJz
         uV8KnJSU6LtwH3AE4fRN1aXmDHHQHwoHzvfM2CnkkUgSwSUDAe2tjj+grEY4SSXvBS46
         m2I1PvW5i9krRINl5M4dAA0KzB28+fhTTW5kvwnxJ02z2cBPeIcFfIrbXmRWlwH69c2N
         9KxA==
X-Gm-Message-State: AOJu0YyPwnamvaLZyKeMucIwJmvkEL7ZuhyaSSTINAY0JdCvR2N5tETY
        +HiCMVO6zIk81bQkrhJovih+hQ==
X-Google-Smtp-Source: AGHT+IHNjNba+w42QRjeuUJ5nb+6+heLtiYkGLBV0Zfw34pSh8V5KqYbKqfblYnfTX57gEZCbO4BZA==
X-Received: by 2002:a05:6808:1a0e:b0:3b2:e624:43a0 with SMTP id bk14-20020a0568081a0e00b003b2e62443a0mr530324oib.15.1700252038650;
        Fri, 17 Nov 2023 12:13:58 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:58 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] spi: axi-spi-engine: move msg state to new struct
Date:   Fri, 17 Nov 2023 14:13:00 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-9-cc59db999b87@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the message state in the AXI SPI Engine driver to a new
struct spi_engine_msg_state.

Previously, the driver state contained various pointers that pointed
to memory owned by a struct spi_message. However, it did not set any of
these pointers to NULL when a message was completed. This could lead to
use after free bugs.

Example of how this could happen:
1. SPI core calls into spi_engine_transfer_one_message() with msg1.
2. Assume something was misconfigured and spi_engine_tx_next() is not
   called enough times in interrupt callbacks for msg1 such that
   spi_engine->tx_xfer is never set to NULL before the msg1 completes.
3. SYNC interrupt is received and spi_finalize_current_message() is
   called for msg1. spi_engine->msg is set to NULL but no other
   message-specific state is reset.
4. Caller that sent msg1 is notified of the completion and frees msg1
   and the associated xfers and tx/rx buffers.
4. SPI core calls into spi_engine_transfer_one_message() with msg2.
5. When spi_engine_tx_next() is called for msg2, spi_engine->tx_xfer is
   still be pointing to an xfer from msg1, which was already freed.
   spi_engine_xfer_next() tries to access xfer->transfer_list of one
   of the freed xfers and we get a segfault or undefined behavior.

To avoid issues like this, instead of putting per-message state in the
driver state struct, we can make use of the struct spi_message::state
field to store a pointer to a new struct spi_engine_msg_state. This way,
all of the state that belongs to specific message stays with that
message and we don't have to remember to manually reset all aspects of
the message state when a message is completed. Rather, a new state is
allocated for each message.

Most of the changes are just renames where the state is accessed. One
place where this wasn't straightforward was the sync_id member. This
has been changed to use ida_alloc_range() since we needed to separate
the per-message sync_id from the per-controller next available sync_id.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 150 +++++++++++++++++++++++++--------------
 1 file changed, 96 insertions(+), 54 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 8a6fbb3bb3f1..745000a9b2c7 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -78,28 +79,42 @@ struct spi_engine_program {
 	uint16_t instructions[];
 };
 
-struct spi_engine {
-	struct clk *clk;
-	struct clk *ref_clk;
-
-	spinlock_t lock;
-
-	void __iomem *base;
-
-	struct spi_message *msg;
+/**
+ * struct spi_engine_message_state - SPI engine per-message state
+ */
+struct spi_engine_message_state {
+	/** Instructions for executing this message. */
 	struct spi_engine_program *p;
+	/** Number of elements in cmd_buf array. */
 	unsigned cmd_length;
+	/** Array of commands not yet written to CMD FIFO. */
 	const uint16_t *cmd_buf;
-
+	/** Next xfer with tx_buf not yet fully written to TX FIFO. */
 	struct spi_transfer *tx_xfer;
+	/** Size of tx_buf in bytes. */
 	unsigned int tx_length;
+	/** Bytes not yet written to TX FIFO. */
 	const uint8_t *tx_buf;
-
+	/** Next xfer with rx_buf not yet fully written to RX FIFO. */
 	struct spi_transfer *rx_xfer;
+	/** Size of tx_buf in bytes. */
 	unsigned int rx_length;
+	/** Bytes not yet written to the RX FIFO. */
 	uint8_t *rx_buf;
+	/** ID to correlate SYNC interrupts with this message. */
+	u8 sync_id;
+};
+
+struct spi_engine {
+	struct clk *clk;
+	struct clk *ref_clk;
 
-	unsigned int sync_id;
+	spinlock_t lock;
+
+	void __iomem *base;
+
+	struct spi_message *msg;
+	struct ida sync_ida;
 	unsigned int completed_id;
 
 	unsigned int int_enable;
@@ -258,100 +273,105 @@ static void spi_engine_xfer_next(struct spi_engine *spi_engine,
 
 static void spi_engine_tx_next(struct spi_engine *spi_engine)
 {
-	struct spi_transfer *xfer = spi_engine->tx_xfer;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_transfer *xfer = st->tx_xfer;
 
 	do {
 		spi_engine_xfer_next(spi_engine, &xfer);
 	} while (xfer && !xfer->tx_buf);
 
-	spi_engine->tx_xfer = xfer;
+	st->tx_xfer = xfer;
 	if (xfer) {
-		spi_engine->tx_length = xfer->len;
-		spi_engine->tx_buf = xfer->tx_buf;
+		st->tx_length = xfer->len;
+		st->tx_buf = xfer->tx_buf;
 	} else {
-		spi_engine->tx_buf = NULL;
+		st->tx_buf = NULL;
 	}
 }
 
 static void spi_engine_rx_next(struct spi_engine *spi_engine)
 {
-	struct spi_transfer *xfer = spi_engine->rx_xfer;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_transfer *xfer = st->rx_xfer;
 
 	do {
 		spi_engine_xfer_next(spi_engine, &xfer);
 	} while (xfer && !xfer->rx_buf);
 
-	spi_engine->rx_xfer = xfer;
+	st->rx_xfer = xfer;
 	if (xfer) {
-		spi_engine->rx_length = xfer->len;
-		spi_engine->rx_buf = xfer->rx_buf;
+		st->rx_length = xfer->len;
+		st->rx_buf = xfer->rx_buf;
 	} else {
-		spi_engine->rx_buf = NULL;
+		st->rx_buf = NULL;
 	}
 }
 
 static bool spi_engine_write_cmd_fifo(struct spi_engine *spi_engine)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_CMD_FIFO;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
 	unsigned int n, m, i;
 	const uint16_t *buf;
 
 	n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_CMD_FIFO_ROOM);
-	while (n && spi_engine->cmd_length) {
-		m = min(n, spi_engine->cmd_length);
-		buf = spi_engine->cmd_buf;
+	while (n && st->cmd_length) {
+		m = min(n, st->cmd_length);
+		buf = st->cmd_buf;
 		for (i = 0; i < m; i++)
 			writel_relaxed(buf[i], addr);
-		spi_engine->cmd_buf += m;
-		spi_engine->cmd_length -= m;
+		st->cmd_buf += m;
+		st->cmd_length -= m;
 		n -= m;
 	}
 
-	return spi_engine->cmd_length != 0;
+	return st->cmd_length != 0;
 }
 
 static bool spi_engine_write_tx_fifo(struct spi_engine *spi_engine)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_SDO_DATA_FIFO;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
 	unsigned int n, m, i;
 	const uint8_t *buf;
 
 	n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_SDO_FIFO_ROOM);
-	while (n && spi_engine->tx_length) {
-		m = min(n, spi_engine->tx_length);
-		buf = spi_engine->tx_buf;
+	while (n && st->tx_length) {
+		m = min(n, st->tx_length);
+		buf = st->tx_buf;
 		for (i = 0; i < m; i++)
 			writel_relaxed(buf[i], addr);
-		spi_engine->tx_buf += m;
-		spi_engine->tx_length -= m;
+		st->tx_buf += m;
+		st->tx_length -= m;
 		n -= m;
-		if (spi_engine->tx_length == 0)
+		if (st->tx_length == 0)
 			spi_engine_tx_next(spi_engine);
 	}
 
-	return spi_engine->tx_length != 0;
+	return st->tx_length != 0;
 }
 
 static bool spi_engine_read_rx_fifo(struct spi_engine *spi_engine)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_SDI_DATA_FIFO;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
 	unsigned int n, m, i;
 	uint8_t *buf;
 
 	n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_SDI_FIFO_LEVEL);
-	while (n && spi_engine->rx_length) {
-		m = min(n, spi_engine->rx_length);
-		buf = spi_engine->rx_buf;
+	while (n && st->rx_length) {
+		m = min(n, st->rx_length);
+		buf = st->rx_buf;
 		for (i = 0; i < m; i++)
 			buf[i] = readl_relaxed(addr);
-		spi_engine->rx_buf += m;
-		spi_engine->rx_length -= m;
+		st->rx_buf += m;
+		st->rx_length -= m;
 		n -= m;
-		if (spi_engine->rx_length == 0)
+		if (st->rx_length == 0)
 			spi_engine_rx_next(spi_engine);
 	}
 
-	return spi_engine->rx_length != 0;
+	return st->rx_length != 0;
 }
 
 static irqreturn_t spi_engine_irq(int irq, void *devid)
@@ -387,12 +407,16 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 			disable_int |= SPI_ENGINE_INT_SDI_ALMOST_FULL;
 	}
 
-	if (pending & SPI_ENGINE_INT_SYNC) {
-		if (spi_engine->msg &&
-		    spi_engine->completed_id == spi_engine->sync_id) {
+	if (pending & SPI_ENGINE_INT_SYNC && spi_engine->msg) {
+		struct spi_engine_message_state *st = spi_engine->msg->state;
+
+		if (spi_engine->completed_id == st->sync_id) {
 			struct spi_message *msg = spi_engine->msg;
+			struct spi_engine_message_state *st = msg->state;
 
-			kfree(spi_engine->p);
+			ida_free(&spi_engine->sync_ida, st->sync_id);
+			kfree(st->p);
+			kfree(st);
 			msg->status = 0;
 			msg->actual_length = msg->frame_length;
 			spi_engine->msg = NULL;
@@ -417,29 +441,46 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 {
 	struct spi_engine_program p_dry, *p;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_message_state *st;
 	unsigned int int_enable = 0;
 	unsigned long flags;
 	size_t size;
+	int ret;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
 
 	p_dry.length = 0;
 	spi_engine_compile_message(spi_engine, msg, true, &p_dry);
 
 	size = sizeof(*p->instructions) * (p_dry.length + 1);
 	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
-	if (!p)
+	if (!p) {
+		kfree(st);
 		return -ENOMEM;
+	}
+
+	ret = ida_alloc_range(&spi_engine->sync_ida, 0, U8_MAX, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(p);
+		kfree(st);
+		return ret;
+	}
+
+	st->sync_id = ret;
+
 	spi_engine_compile_message(spi_engine, msg, false, p);
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
-	spi_engine->sync_id = (spi_engine->sync_id + 1) & 0xff;
-	spi_engine_program_add_cmd(p, false,
-		SPI_ENGINE_CMD_SYNC(spi_engine->sync_id));
+	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st->sync_id));
 
+	msg->state = st;
 	spi_engine->msg = msg;
-	spi_engine->p = p;
+	st->p = p;
 
-	spi_engine->cmd_buf = p->instructions;
-	spi_engine->cmd_length = p->length;
+	st->cmd_buf = p->instructions;
+	st->cmd_length = p->length;
 	if (spi_engine_write_cmd_fifo(spi_engine))
 		int_enable |= SPI_ENGINE_INT_CMD_ALMOST_EMPTY;
 
@@ -448,7 +489,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		int_enable |= SPI_ENGINE_INT_SDO_ALMOST_EMPTY;
 
 	spi_engine_rx_next(spi_engine);
-	if (spi_engine->rx_length != 0)
+	if (st->rx_length != 0)
 		int_enable |= SPI_ENGINE_INT_SDI_ALMOST_FULL;
 
 	int_enable |= SPI_ENGINE_INT_SYNC;
@@ -489,6 +530,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spi_engine = spi_controller_get_devdata(host);
 
 	spin_lock_init(&spi_engine->lock);
+	ida_init(&spi_engine->sync_ida);
 
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk))

-- 
2.42.0

