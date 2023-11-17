Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC37EF863
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbjKQUOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346235AbjKQUOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:14:20 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53211732
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:14:01 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b56b618217so1447177b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252041; x=1700856841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja9GtlZjFcJxKQ+nfaNBwXl6V3JiSfQSXjsqjsMOXR4=;
        b=qeHkjhHMpbe+odDvMjcQssxmn9Jowjsrg73ntJ+RtcqkYbOiVvW5PZhwUrE4EK/xCh
         1UDziF6/w3MfjL88xjkyZ3J5yLtUKySnM+qRrvzH759BslAaVqwVrf4bA+fLv1PlLESn
         ayjRjGQAZpwhXLGHM+OLdddEOL0xDC6gb6mZiGevesvubH2tm1CrFOvGgWefZHL906E2
         yFEY1FhhH2QYdyiDUdspgMiwd9dixwAfbcsScBQmh1LBI6lfEC99UC8YHOdDUS1Tdh2A
         ktVLlKVKV4XQjg8Y17nkCpCHLXEb0NPON6TXTe/ao7zz7kq7TJm/OUnUGzkDtCuKOz6I
         zmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252041; x=1700856841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja9GtlZjFcJxKQ+nfaNBwXl6V3JiSfQSXjsqjsMOXR4=;
        b=JjhX9y79BE83wJtZLBDOJAGQqP1eI8nm262J4Jn0fgdJ6g5IrKIFycFbq0OP8OgVAX
         OLtS2OVXNRow4vtQI4FqdslYCE+Vk0EBAEP9X7iia7GTSjN/nq+G6OndppYq2PtCBTrV
         yevJgcfGyMjEcsECDWJ8UG4QF86NXfRzDPgHuy/a59eCLVLP3DyXOVRMBg76Ly3LXm7L
         vtnurSUChd5+AnTxZ2cBOkjYZooVL2zJ5+Qzq3tS9dcCSUEdM212Cmx65t8Rr6gJ9pCv
         KY+AqBMi14H5qV1n7CLdnw9vWBDCPI5G3gwl1qEXpMkscQA4Z1BlMk2AXDuJhwxRLmlJ
         5mXw==
X-Gm-Message-State: AOJu0Yxfntfp6ptOMFdkI+ybLk7oxBMVLquN8+taTseWJ6yjwXoJ45KZ
        UgcWB04NovuZpnsEyFzm59h5jg==
X-Google-Smtp-Source: AGHT+IEDfybKnOu/GGZq916PIuwCUX/WXL1yy1MdxiH5bac/b8Q9vM1y0sN41DdLNS8Rd6WpsgoCyg==
X-Received: by 2002:a05:6808:1315:b0:3b5:6462:3191 with SMTP id y21-20020a056808131500b003b564623191mr555089oiv.48.1700252041296;
        Fri, 17 Nov 2023 12:14:01 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:14:00 -0800 (PST)
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
Subject: [PATCH 12/14] spi: axi-spi-engine: remove struct spi_engine::msg
Date:   Fri, 17 Nov 2023 14:13:03 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-12-cc59db999b87@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the AXI SPI Engine driver, the struct spi_engine::msg member was used
to keep track of the current message being processed. The SPI core is
already keeping track of this, so we don't need to duplicate the effort.

In most cases, we already have a pointer to the current message, so we
can pass it directly to the functions that need it. In the one case
where we don't have a pointer to the current message, we can get it
from struct spi_controller::cur_msg.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 60 +++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 120001dbc4dc..c39f478f34a7 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -112,8 +112,6 @@ struct spi_engine {
 	spinlock_t lock;
 
 	void __iomem *base;
-
-	struct spi_message *msg;
 	struct ida sync_ida;
 
 	unsigned int int_enable;
@@ -252,10 +250,9 @@ static int spi_engine_compile_message(struct spi_engine *spi_engine,
 	return 0;
 }
 
-static void spi_engine_xfer_next(struct spi_engine *spi_engine,
+static void spi_engine_xfer_next(struct spi_message *msg,
 	struct spi_transfer **_xfer)
 {
-	struct spi_message *msg = spi_engine->msg;
 	struct spi_transfer *xfer = *_xfer;
 
 	if (!xfer) {
@@ -270,13 +267,13 @@ static void spi_engine_xfer_next(struct spi_engine *spi_engine,
 	*_xfer = xfer;
 }
 
-static void spi_engine_tx_next(struct spi_engine *spi_engine)
+static void spi_engine_tx_next(struct spi_message *msg)
 {
-	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_engine_message_state *st = msg->state;
 	struct spi_transfer *xfer = st->tx_xfer;
 
 	do {
-		spi_engine_xfer_next(spi_engine, &xfer);
+		spi_engine_xfer_next(msg, &xfer);
 	} while (xfer && !xfer->tx_buf);
 
 	st->tx_xfer = xfer;
@@ -288,13 +285,13 @@ static void spi_engine_tx_next(struct spi_engine *spi_engine)
 	}
 }
 
-static void spi_engine_rx_next(struct spi_engine *spi_engine)
+static void spi_engine_rx_next(struct spi_message *msg)
 {
-	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_engine_message_state *st = msg->state;
 	struct spi_transfer *xfer = st->rx_xfer;
 
 	do {
-		spi_engine_xfer_next(spi_engine, &xfer);
+		spi_engine_xfer_next(msg, &xfer);
 	} while (xfer && !xfer->rx_buf);
 
 	st->rx_xfer = xfer;
@@ -306,10 +303,11 @@ static void spi_engine_rx_next(struct spi_engine *spi_engine)
 	}
 }
 
-static bool spi_engine_write_cmd_fifo(struct spi_engine *spi_engine)
+static bool spi_engine_write_cmd_fifo(struct spi_engine *spi_engine,
+				      struct spi_message *msg)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_CMD_FIFO;
-	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_engine_message_state *st = msg->state;
 	unsigned int n, m, i;
 	const uint16_t *buf;
 
@@ -327,10 +325,11 @@ static bool spi_engine_write_cmd_fifo(struct spi_engine *spi_engine)
 	return st->cmd_length != 0;
 }
 
-static bool spi_engine_write_tx_fifo(struct spi_engine *spi_engine)
+static bool spi_engine_write_tx_fifo(struct spi_engine *spi_engine,
+				     struct spi_message *msg)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_SDO_DATA_FIFO;
-	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_engine_message_state *st = msg->state;
 	unsigned int n, m, i;
 	const uint8_t *buf;
 
@@ -344,16 +343,17 @@ static bool spi_engine_write_tx_fifo(struct spi_engine *spi_engine)
 		st->tx_length -= m;
 		n -= m;
 		if (st->tx_length == 0)
-			spi_engine_tx_next(spi_engine);
+			spi_engine_tx_next(msg);
 	}
 
 	return st->tx_length != 0;
 }
 
-static bool spi_engine_read_rx_fifo(struct spi_engine *spi_engine)
+static bool spi_engine_read_rx_fifo(struct spi_engine *spi_engine,
+				    struct spi_message *msg)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_SDI_DATA_FIFO;
-	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_engine_message_state *st = msg->state;
 	unsigned int n, m, i;
 	uint8_t *buf;
 
@@ -367,7 +367,7 @@ static bool spi_engine_read_rx_fifo(struct spi_engine *spi_engine)
 		st->rx_length -= m;
 		n -= m;
 		if (st->rx_length == 0)
-			spi_engine_rx_next(spi_engine);
+			spi_engine_rx_next(msg);
 	}
 
 	return st->rx_length != 0;
@@ -376,6 +376,7 @@ static bool spi_engine_read_rx_fifo(struct spi_engine *spi_engine)
 static irqreturn_t spi_engine_irq(int irq, void *devid)
 {
 	struct spi_controller *host = devid;
+	struct spi_message *msg = host->cur_msg;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	unsigned int disable_int = 0;
 	unsigned int pending;
@@ -393,29 +394,26 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	spin_lock(&spi_engine->lock);
 
 	if (pending & SPI_ENGINE_INT_CMD_ALMOST_EMPTY) {
-		if (!spi_engine_write_cmd_fifo(spi_engine))
+		if (!spi_engine_write_cmd_fifo(spi_engine, msg))
 			disable_int |= SPI_ENGINE_INT_CMD_ALMOST_EMPTY;
 	}
 
 	if (pending & SPI_ENGINE_INT_SDO_ALMOST_EMPTY) {
-		if (!spi_engine_write_tx_fifo(spi_engine))
+		if (!spi_engine_write_tx_fifo(spi_engine, msg))
 			disable_int |= SPI_ENGINE_INT_SDO_ALMOST_EMPTY;
 	}
 
 	if (pending & (SPI_ENGINE_INT_SDI_ALMOST_FULL | SPI_ENGINE_INT_SYNC)) {
-		if (!spi_engine_read_rx_fifo(spi_engine))
+		if (!spi_engine_read_rx_fifo(spi_engine, msg))
 			disable_int |= SPI_ENGINE_INT_SDI_ALMOST_FULL;
 	}
 
-	if (pending & SPI_ENGINE_INT_SYNC && spi_engine->msg) {
-		struct spi_engine_message_state *st = spi_engine->msg->state;
+	if (pending & SPI_ENGINE_INT_SYNC && msg) {
+		struct spi_engine_message_state *st = msg->state;
 
 		if (completed_id == st->sync_id) {
-			struct spi_message *msg = spi_engine->msg;
-
 			msg->status = 0;
 			msg->actual_length = msg->frame_length;
-			spi_engine->msg = NULL;
 			spi_finalize_current_message(host);
 			disable_int |= SPI_ENGINE_INT_SYNC;
 		}
@@ -499,16 +497,14 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
 
-	spi_engine->msg = msg;
-
-	if (spi_engine_write_cmd_fifo(spi_engine))
+	if (spi_engine_write_cmd_fifo(spi_engine, msg))
 		int_enable |= SPI_ENGINE_INT_CMD_ALMOST_EMPTY;
 
-	spi_engine_tx_next(spi_engine);
-	if (spi_engine_write_tx_fifo(spi_engine))
+	spi_engine_tx_next(msg);
+	if (spi_engine_write_tx_fifo(spi_engine, msg))
 		int_enable |= SPI_ENGINE_INT_SDO_ALMOST_EMPTY;
 
-	spi_engine_rx_next(spi_engine);
+	spi_engine_rx_next(msg);
 	if (st->rx_length != 0)
 		int_enable |= SPI_ENGINE_INT_SDI_ALMOST_FULL;
 

-- 
2.42.0

