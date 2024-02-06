Return-Path: <linux-kernel+bounces-55602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCAF84BEBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597121F25F52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8E1B953;
	Tue,  6 Feb 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EkY94yBQ"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465371B7FC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251609; cv=none; b=k5vuOseXovWqeth1LIqxRv/9r4hHYdXSZwxJwpNCSyXvo+lzkj4B/HSlt42neUwWoR7B67vobxNbLCItfzyP9R9/J78hg8G3cs3l+SfsERQw7YK01uBVLBrXqCbIdd9pg8K23yjVF7izGBaZOXkWbniaYfDIzhf1eJ3zupRh6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251609; c=relaxed/simple;
	bh=ItgJhdHJeveOYLjbW9w4wvk7BQRF9mDexdoZH4wLRiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoOMNix3MA1W49CsEEwDK9M6WjqOU11FcmLt1ZTTaOUtyPBXSrDZBkigYU629Kk5TAAiLIG7m4QODVHtmVGPobSQ284YaZTEA+DUOi9swJNrWFXUW5VixCM4TnLuIYGzt2+vL34IL+qYRqc4Qu+odoA1T4J9Ivp8LwQkPS6W1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EkY94yBQ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e1352dd653so3843362a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707251605; x=1707856405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToIrT2LNCFz2XCRg0eJnPnbG0vGfFWVjjayhGrOFDO8=;
        b=EkY94yBQ/17WV9SnAFRzkkvIpo8WHX1S5qZkzMnoMoU9lx4C10t5JVowDN+y7bHu8s
         y1WPYfbqZExXJTYae1zc+0inCLg1FC+FTlr5DhFTsL1BwbJIeEIUipWUuXJgoaC9Qnqm
         4cB1iD/YwkCqE+PCNeRID8TOXvnO4RYs2WJwR07c54ATxbJE+WPv34erwtK8+PpwMQ4E
         vSacuhGir3GrRcSVaU0Ay6qjQiK52obiUF5IVUMKa3UA4cZfBAUuYwSazmMmUKfbC8VK
         ZV8FeHyLKEXsEo/Lzh2KWyPpeAQ/oOPyYzLFVBD/4EOPXbOCMvd7uy1d0JBRM9Q8Mxp9
         U4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707251605; x=1707856405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToIrT2LNCFz2XCRg0eJnPnbG0vGfFWVjjayhGrOFDO8=;
        b=m2LuVTaIQBXGclu3LMbGqfaqbd0Az/XwqVOGKs12A8ZuXuQ28SVASxk6sQ3drK2QkP
         FEGIAy0oU1eZFVqvFMW6+Bmh1OSavP358FRo5YDkbjo6hEicW/93g2L2vyBy7TriI0KB
         rNPeFa3AOvAeQZTAb7qi8NEw7KHrAOcWZaTNG/MJRDXle73xkaUNVqsMosZATuWA6EuI
         Zqnq+qa42tx/WDvwwIyPlU6xj8SW8UoTzYSrVBf9UfWRJwlGyKFfu8z2Qa1z417yFZCV
         zMGONRbC6PW0PhpXSgFj3OUEpgZsTwZnHbmG3mMLQC+RIjr1fY2r6SHKpkIyE3xnrT6M
         8Ohg==
X-Gm-Message-State: AOJu0YxlU4akos0uXTGZGH6pmrcCxjnVUzYgTxeEeNfIKNhAHqGHSlQR
	yJCp45k+UTM+UQyHl5BlvmL5omQRKHOPwQI4LIoye69J8gIRE4vbOyCh37gO7ns=
X-Google-Smtp-Source: AGHT+IFli3eoQbHi8ljIWhZSIhdzq2pphZL0q4BfQax91TId9zYgDzcFdhIPC9yjPkCChc1bG+2VYQ==
X-Received: by 2002:a9d:75d1:0:b0:6e1:79a:fc8f with SMTP id c17-20020a9d75d1000000b006e1079afc8fmr4035185otl.35.1707251605352;
        Tue, 06 Feb 2024 12:33:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXNlKm8D9l7Atw2xTjsWSlxzc4CW5q/sF3Sc0WcWd9MNNvdSayLRhUki4yL1j3jMhNYqsUErjPlP/RWPygkggOk03aoCptb8LSZT3aBgAkviZNgzaAGhcjj/3SAgT53BknQH1Lu5jNredg6lEp+zedcP7dctbrCR2loSthQAta/H3NAXn0lbBjwMQQYRYTpczKJOw==
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l2-20020a05683016c200b006e11d93ff09sm429581otr.72.2024.02.06.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:33:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: axi-spi-engine: remove use of ida for sync id
Date: Tue,  6 Feb 2024 14:31:27 -0600
Message-ID: <20240206-axi-spi-engine-round-2-1-v1-1-ea6eeb60f4fb@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
References: <20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Profiling has shown that ida_alloc_range() accounts for about 10% of the
time spent in spi_sync() when using the AXI SPI Engine controller. This
call is used to create a unique id for each SPI message to match to an
IRQ when the message is complete.

Since the core SPI code serializes messages in a message queue, we can
only have one message in flight at a time, namely host->cur_msg. This
means that we can use a fixed value instead of a unique id for each
message since there can never be more than one message pending at a
time.

This patch removes the use of ida for the sync id and replaces it with a
constant value. This simplifies the driver and improves performance.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 6b0c72bf3395..9cc602075c17 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -57,6 +57,9 @@
 #define SPI_ENGINE_TRANSFER_WRITE		0x1
 #define SPI_ENGINE_TRANSFER_READ		0x2
 
+/* Arbitrary sync ID for use by host->cur_msg */
+#define AXI_SPI_ENGINE_CUR_MSG_SYNC_ID		0x1
+
 #define SPI_ENGINE_CMD(inst, arg1, arg2) \
 	(((inst) << 12) | ((arg1) << 8) | (arg2))
 
@@ -98,8 +101,6 @@ struct spi_engine_message_state {
 	unsigned int rx_length;
 	/** @rx_buf: Bytes not yet written to the RX FIFO. */
 	uint8_t *rx_buf;
-	/** @sync_id: ID to correlate SYNC interrupts with this message. */
-	u8 sync_id;
 };
 
 struct spi_engine {
@@ -109,7 +110,6 @@ struct spi_engine {
 	spinlock_t lock;
 
 	void __iomem *base;
-	struct ida sync_ida;
 	struct timer_list watchdog_timer;
 	struct spi_controller *controller;
 
@@ -483,9 +483,7 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	}
 
 	if (pending & SPI_ENGINE_INT_SYNC && msg) {
-		struct spi_engine_message_state *st = msg->state;
-
-		if (completed_id == st->sync_id) {
+		if (completed_id == AXI_SPI_ENGINE_CUR_MSG_SYNC_ID) {
 			if (timer_delete_sync(&spi_engine->watchdog_timer)) {
 				msg->status = 0;
 				msg->actual_length = msg->frame_length;
@@ -510,10 +508,8 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 				      struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
-	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	struct spi_engine_message_state *st;
 	size_t size;
-	int ret;
 
 	st = kzalloc(sizeof(*st), GFP_KERNEL);
 	if (!st)
@@ -531,18 +527,10 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 		return -ENOMEM;
 	}
 
-	ret = ida_alloc_range(&spi_engine->sync_ida, 0, U8_MAX, GFP_KERNEL);
-	if (ret < 0) {
-		kfree(p);
-		kfree(st);
-		return ret;
-	}
-
-	st->sync_id = ret;
-
 	spi_engine_compile_message(msg, false, p);
 
-	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st->sync_id));
+	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
+						AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
 
 	st->p = p;
 	st->cmd_buf = p->instructions;
@@ -555,10 +543,8 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 static int spi_engine_unprepare_message(struct spi_controller *host,
 					struct spi_message *msg)
 {
-	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	struct spi_engine_message_state *st = msg->state;
 
-	ida_free(&spi_engine->sync_ida, st->sync_id);
 	kfree(st->p);
 	kfree(st);
 
@@ -640,7 +626,6 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spi_engine = spi_controller_get_devdata(host);
 
 	spin_lock_init(&spi_engine->lock);
-	ida_init(&spi_engine->sync_ida);
 	timer_setup(&spi_engine->watchdog_timer, spi_engine_timeout, TIMER_IRQSAFE);
 	spi_engine->controller = host;
 

-- 
2.43.0


