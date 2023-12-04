Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B214803BC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjLDRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjLDRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:35:08 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCB1D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:35:14 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d8d28e4bbeso1175985a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711314; x=1702316114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vE/Lazu2cf7B6o5i/hH3jypTqxe96xetp8QoO+SVLg=;
        b=ajV2BD1J/1CO3IP+n6TS34r5UbBoG50J9ZMMYgOmG320efWcd7mb1WM9Qwf8wc6Dt7
         zEp3PQmVBD8T1H72lZtn0IwWIHZZKjGjWU1h+GUj9LNHmXv0wLSIVrLMhlTPpBD+T5Ay
         D6kiEzVKA9w6yd+qIY57Fo64JUqkIIW2xFxmiH+4FagfSI4Fz6a0dIhXcCayd7xnHzv8
         FQScbKw6q7FNYX6AiH3EiLtomSnDJfjNLb3ik7DC8t+77yAJ3O7nC6ICm/HHSaNe+MZs
         v5r01R1UKQDSd7zxi111kvLzh6AIj9gnhHjkxs6dwqXApi2qpbxRKGFuJlPsQFiAz/rw
         EVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711314; x=1702316114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vE/Lazu2cf7B6o5i/hH3jypTqxe96xetp8QoO+SVLg=;
        b=n/2dQQEPNbmT5nvYG2m1I8EFu8dnXOous5BK8EPjNdS4l1Nvcj7NL3HswfmhZBQdHC
         kuiTKf/hEifT9W1ha5G4LAk7Ka9ZQVQ2WbH/7JIq1426TCVhyw+4bxe2WA+qvQTtZKzA
         A0cqngAwgTK2dNEbX96Nf9YSX6fhM0BjO/dTF4BIX4jV9Y8vSrqsji7b8gb18uIEoFcs
         zYgoHCTrchTwPgu3y/MySpuB//GNn/GIIBXUrZWS//Yofe0Uv3rLwDFwI6qohKApv0m6
         qQXrOKVU5JhYHZhgukyg7hOnf4A3HTNHdVcApwIjg97XsPRWXioxwxxY4rjduk63Vnwi
         sjHQ==
X-Gm-Message-State: AOJu0Yy0RQ8ACsOPCAgF8CWnSsd+dryoiJHwUko7eTTBJRK6RiQv9RMt
        fFGjSVzY9/5V58uxR9OO/MbeEvs3HXzgqxOc7CM=
X-Google-Smtp-Source: AGHT+IEJDbU4/GFS0r8bfZ90Qi/bwXcMtxkv0WvUFlfaUtDNJ+ir6BlFpRM7qCksKlWxLLK8oUOm1Q==
X-Received: by 2002:a9d:4b1a:0:b0:6d9:76cd:d6b8 with SMTP id q26-20020a9d4b1a000000b006d976cdd6b8mr2118498otf.68.1701711314085;
        Mon, 04 Dec 2023 09:35:14 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:13 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] spi: axi-spi-engine: fix sleep ticks calculation
Date:   Mon,  4 Dec 2023 11:33:30 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-4-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
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

This fixes the sleep ticks calculation when generating sleep
instructions in the AXI SPI Engine driver. The previous calculation
was ignoring delays less than one microsecond and missed a microsecond
to second conversion factor.

This fixes the first issue by not rounding to microseconds. Now that
xfer->effective_speed_hz is guaranteed to be set correctly, we can use
that to simplify the calculation. This new calculation replaces the old
incorrect math.

Also add unit suffix to the delay variable for clarity while we are
touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index fa2264d630c3..b3e72308fcc5 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -168,22 +168,17 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
-	struct spi_engine *spi_engine, unsigned int clk_div,
 	struct spi_transfer *xfer)
 {
-	unsigned int spi_clk = clk_get_rate(spi_engine->ref_clk);
 	unsigned int t;
-	int delay;
+	int delay_ns;
 
-	delay = spi_delay_to_ns(&xfer->delay, xfer);
-	if (delay < 0)
+	delay_ns = spi_delay_to_ns(&xfer->delay, xfer);
+	if (delay_ns <= 0)
 		return;
-	delay /= 1000;
 
-	if (delay == 0)
-		return;
-
-	t = DIV_ROUND_UP(delay * spi_clk, (clk_div + 1) * 2);
+	/* rounding down since executing the instruction adds a couple of ticks delay */
+	t = DIV_ROUND_DOWN_ULL((u64)delay_ns * xfer->effective_speed_hz, NSEC_PER_SEC);
 	while (t) {
 		unsigned int n = min(t, 256U);
 
@@ -224,8 +219,8 @@ static void spi_engine_precompile_message(struct spi_message *msg)
 	}
 }
 
-static void spi_engine_compile_message(struct spi_engine *spi_engine,
-	struct spi_message *msg, bool dry, struct spi_engine_program *p)
+static void spi_engine_compile_message(struct spi_message *msg, bool dry,
+				       struct spi_engine_program *p)
 {
 	struct spi_device *spi = msg->spi;
 	struct spi_controller *host = spi->controller;
@@ -261,7 +256,7 @@ static void spi_engine_compile_message(struct spi_engine *spi_engine,
 		}
 
 		spi_engine_gen_xfer(p, dry, xfer);
-		spi_engine_gen_sleep(p, dry, spi_engine, clk_div - 1, xfer);
+		spi_engine_gen_sleep(p, dry, xfer);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {
@@ -515,7 +510,7 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 	spi_engine_precompile_message(msg);
 
 	p_dry.length = 0;
-	spi_engine_compile_message(spi_engine, msg, true, &p_dry);
+	spi_engine_compile_message(msg, true, &p_dry);
 
 	size = sizeof(*p->instructions) * (p_dry.length + 1);
 	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
@@ -533,7 +528,7 @@ static int spi_engine_prepare_message(struct spi_controller *host,
 
 	st->sync_id = ret;
 
-	spi_engine_compile_message(spi_engine, msg, false, p);
+	spi_engine_compile_message(msg, false, p);
 
 	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st->sync_id));
 

-- 
2.43.0

