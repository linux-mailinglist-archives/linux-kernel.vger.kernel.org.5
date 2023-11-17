Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524F97EF861
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbjKQUO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346191AbjKQUOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:14:07 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF4CD6D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:14:00 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2df2fb611so1609925b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252039; x=1700856839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3x/o+ZhKJLhCZxPJDvSVJn2SYXdsZyrTC3illb8aSGE=;
        b=CwKoOETZGqRe5UOqmT1L2acNwFT+sCm90z6Wce9bLIOiYNpu/NIa1HtvwKYSaZiosg
         CUxX+YsEjzHJKPMfFL/itqTlHCgyxQgMoTsEx+2ELphA+EAjxkoo7kUlquYWYRuLxlR8
         ST1uNo5tL5iLc9bBnTV6vJSF0Y1HVASK2OkTP3jMKCKupM/YLkIMNzSNrk4ZWT7v/1hz
         ssMBdM/fDX7YTxgu7Vq199CLU1bF0Y10A07bFl9/SqstvjvtTKwzkPxrJ4Oy+6YbGoci
         wXmTeMrOk/eI9tuE5MqIqQ1NTp/m2CMe7bRSUPg+F1MbGpxC8coWdqbcsYdg4t96uB/w
         IxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252039; x=1700856839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3x/o+ZhKJLhCZxPJDvSVJn2SYXdsZyrTC3illb8aSGE=;
        b=JP17il+EYXhoeJu0VVZ4wg9tmjMusmvcWFAE3s1hlevm0mGRUv313CyMP0345wQ30m
         vNniMq3R+s4gztVFEc2FIqnTptdBJgem8mFBUFuYbP+QaQcyrZaP+B+7qiiYslpMOSa5
         he5zT6ocvFupb/YIbJL8LT2k1xQX4ef2Sm7nNAkUi2ALSZ7uSr+3z1Ihlg6aM4/6pMcG
         sBU/t3J08566ai49FTgNeXTDFjulhe9l3wtsbC+LfU4a4fMMuhssIirLTfEUOjsr3/GE
         8cCWepSmpdCgr82Uk6TwjOnKbp0ROhYSuD5iXVkLnPPw2mdFpAhXUB2V5tv911c1wg/j
         HSJw==
X-Gm-Message-State: AOJu0Yx4BvANI0hxc7G2Cw/HQnXQAteodupnr5o54gg9zxceeInk+ifm
        Lt05/9bYHSJri8n/ABitdkdgbw==
X-Google-Smtp-Source: AGHT+IEbin8UNO6r4Ykm5emy9h67aMHC8MsdLHv1PzpTun13feE0DMgvGrPV0W2CxfD98j+AiJB+qg==
X-Received: by 2002:a05:6808:15a8:b0:3b6:3d44:4d75 with SMTP id t40-20020a05680815a800b003b63d444d75mr576150oiw.22.1700252039458;
        Fri, 17 Nov 2023 12:13:59 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:59 -0800 (PST)
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
Subject: [PATCH 10/14] spi: axi-spi-engine: use message_prepare/unprepare
Date:   Fri, 17 Nov 2023 14:13:01 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-10-cc59db999b87@baylibre.com>
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

This modifies the AXI SPI Engine driver to make use of the
message_prepare and message_unprepare callbacks. This separates
the concerns of allocating and freeing the message state from the
transfer_one_message callback.

The main benfit of this is so that future callers of
spi_finalize_current_message() will not have to do manual cleanup
of the state.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 46 +++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 745000a9b2c7..210bea23f433 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -412,11 +412,7 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 
 		if (spi_engine->completed_id == st->sync_id) {
 			struct spi_message *msg = spi_engine->msg;
-			struct spi_engine_message_state *st = msg->state;
 
-			ida_free(&spi_engine->sync_ida, st->sync_id);
-			kfree(st->p);
-			kfree(st);
 			msg->status = 0;
 			msg->actual_length = msg->frame_length;
 			spi_engine->msg = NULL;
@@ -436,14 +432,12 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int spi_engine_transfer_one_message(struct spi_controller *host,
-	struct spi_message *msg)
+static int spi_engine_prepare_message(struct spi_controller *host,
+				      struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	struct spi_engine_message_state *st;
-	unsigned int int_enable = 0;
-	unsigned long flags;
 	size_t size;
 	int ret;
 
@@ -472,15 +466,41 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 
 	spi_engine_compile_message(spi_engine, msg, false, p);
 
-	spin_lock_irqsave(&spi_engine->lock, flags);
 	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st->sync_id));
 
-	msg->state = st;
-	spi_engine->msg = msg;
 	st->p = p;
-
 	st->cmd_buf = p->instructions;
 	st->cmd_length = p->length;
+	msg->state = st;
+
+	return 0;
+}
+
+static int spi_engine_unprepare_message(struct spi_controller *host,
+					struct spi_message *msg)
+{
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_message_state *st = msg->state;
+
+	ida_free(&spi_engine->sync_ida, st->sync_id);
+	kfree(st->p);
+	kfree(st);
+
+	return 0;
+}
+
+static int spi_engine_transfer_one_message(struct spi_controller *host,
+	struct spi_message *msg)
+{
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_message_state *st = msg->state;
+	unsigned int int_enable = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&spi_engine->lock, flags);
+
+	spi_engine->msg = msg;
+
 	if (spi_engine_write_cmd_fifo(spi_engine))
 		int_enable |= SPI_ENGINE_INT_CMD_ALMOST_EMPTY;
 
@@ -572,6 +592,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
 	host->transfer_one_message = spi_engine_transfer_one_message;
+	host->prepare_message = spi_engine_prepare_message;
+	host->unprepare_message = spi_engine_unprepare_message;
 	host->num_chipselect = 8;
 
 	if (host->max_speed_hz == 0)

-- 
2.42.0

