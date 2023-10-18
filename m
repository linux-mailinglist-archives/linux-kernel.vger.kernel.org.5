Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8397CD9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjJRKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRKzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:55:25 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA83AEA;
        Wed, 18 Oct 2023 03:55:21 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-407da05f05aso12426155e9.3;
        Wed, 18 Oct 2023 03:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697626520; x=1698231320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rs9LevmP9tka/XKvdemB1cXwK7JUBe4mAxtgJ4jhXQs=;
        b=SSJGC80ny3PUUBbQCGC1pQFZm07ohO8UkWIJwuTzdDxKJgp5k1PioSEsjjI9ulmcLa
         9iIlMiez7sgTcbHmXRJzlOL0DUGph0t0Pliqp43n+98XCwsRV/aSAtznaEz8fwpUWQY1
         eQnlG/tpMeax6jj6J38WibXNDP9YjOf6jAHKTkqySGZEJQErsjp5+rvfIFqDySRIQBFP
         nVP0q9UmePMyEl7h7hRoa7334dNTeQW+yD4qekEALj3gB+R+/6em5zEmAXK2GtFzpYSr
         Ng+Ibn4foq7r6WsupyRA5kcab9/KuZOD+ilcy8k0o9QzQd6NIXAK3irAyu7O989T/+OU
         wy7Q==
X-Gm-Message-State: AOJu0YwdwgS+yjkMS+BFWxg1V9e9M/FbZqeAwspJb9opixsc7fwq87g1
        zDgaaJoVE4fWvIHw9XJQ6g9nYAXTXwV5fUrM
X-Google-Smtp-Source: AGHT+IEDc0yLySq1GGICz5oXgWSJXPi85MBgBwuCoh4eNVzLkUZNzn+GehG6KoZtTKGkg+SUolDtnA==
X-Received: by 2002:a05:600c:4fd2:b0:407:3b6d:b561 with SMTP id o18-20020a05600c4fd200b004073b6db561mr3649087wmq.9.1697626519887;
        Wed, 18 Oct 2023 03:55:19 -0700 (PDT)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id o36-20020a05600c512400b00405959469afsm1374498wms.3.2023.10.18.03.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:55:19 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH] tty: serial: samsung_tty: remove dead code
Date:   Wed, 18 Oct 2023 11:54:54 +0100
Message-Id: <20231018105454.3911161-1-git@andred.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: André Draszik <andre.draszik@linaro.org>

When support for various old platforms was removed in commit
1ea35b355722, s3c24xx_serial_ops also became unused here because
nothing sets port type TYPE_S3C24XX anymore.

Remove s3c24xx_serial_ops and all the code that's unreachable now.

Fixes: 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 105 -------------------------------
 1 file changed, 105 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 07fb8a9dac63..6b8d4b4402e9 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -64,7 +64,6 @@
 #define RXSTAT_DUMMY_READ (0x10000000)
 
 enum s3c24xx_port_type {
-	TYPE_S3C24XX,
 	TYPE_S3C6400,
 	TYPE_APPLE_S5L,
 };
@@ -128,8 +127,6 @@ struct s3c24xx_uart_dma {
 };
 
 struct s3c24xx_uart_port {
-	unsigned char			rx_claimed;
-	unsigned char			tx_claimed;
 	unsigned char			rx_enabled;
 	unsigned char			tx_enabled;
 	unsigned int			pm_level;
@@ -1166,29 +1163,6 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 	}
 }
 
-static void s3c24xx_serial_shutdown(struct uart_port *port)
-{
-	struct s3c24xx_uart_port *ourport = to_ourport(port);
-
-	if (ourport->tx_claimed) {
-		free_irq(ourport->tx_irq, ourport);
-		ourport->tx_enabled = 0;
-		ourport->tx_claimed = 0;
-		ourport->tx_mode = 0;
-	}
-
-	if (ourport->rx_claimed) {
-		free_irq(ourport->rx_irq, ourport);
-		ourport->rx_claimed = 0;
-		ourport->rx_enabled = 0;
-	}
-
-	if (ourport->dma)
-		s3c24xx_serial_release_dma(ourport);
-
-	ourport->tx_in_progress = 0;
-}
-
 static void s3c64xx_serial_shutdown(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
@@ -1234,48 +1208,6 @@ static void apple_s5l_serial_shutdown(struct uart_port *port)
 	ourport->tx_in_progress = 0;
 }
 
-static int s3c24xx_serial_startup(struct uart_port *port)
-{
-	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	int ret;
-
-	ourport->rx_enabled = 1;
-
-	ret = request_irq(ourport->rx_irq, s3c24xx_serial_rx_irq, 0,
-			  s3c24xx_serial_portname(port), ourport);
-
-	if (ret != 0) {
-		dev_err(port->dev, "cannot get irq %d\n", ourport->rx_irq);
-		return ret;
-	}
-
-	ourport->rx_claimed = 1;
-
-	dev_dbg(port->dev, "requesting tx irq...\n");
-
-	ourport->tx_enabled = 1;
-
-	ret = request_irq(ourport->tx_irq, s3c24xx_serial_tx_irq, 0,
-			  s3c24xx_serial_portname(port), ourport);
-
-	if (ret) {
-		dev_err(port->dev, "cannot get irq %d\n", ourport->tx_irq);
-		goto err;
-	}
-
-	ourport->tx_claimed = 1;
-
-	/* the port reset code should have done the correct
-	 * register setup for the port controls
-	 */
-
-	return ret;
-
-err:
-	s3c24xx_serial_shutdown(port);
-	return ret;
-}
-
 static int s3c64xx_serial_startup(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
@@ -1692,8 +1624,6 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
 	const struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	switch (ourport->info->type) {
-	case TYPE_S3C24XX:
-		return "S3C24XX";
 	case TYPE_S3C6400:
 		return "S3C6400/10";
 	case TYPE_APPLE_S5L:
@@ -1753,27 +1683,6 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 			 unsigned char c);
 #endif
 
-static const struct uart_ops s3c24xx_serial_ops = {
-	.pm		= s3c24xx_serial_pm,
-	.tx_empty	= s3c24xx_serial_tx_empty,
-	.get_mctrl	= s3c24xx_serial_get_mctrl,
-	.set_mctrl	= s3c24xx_serial_set_mctrl,
-	.stop_tx	= s3c24xx_serial_stop_tx,
-	.start_tx	= s3c24xx_serial_start_tx,
-	.stop_rx	= s3c24xx_serial_stop_rx,
-	.break_ctl	= s3c24xx_serial_break_ctl,
-	.startup	= s3c24xx_serial_startup,
-	.shutdown	= s3c24xx_serial_shutdown,
-	.set_termios	= s3c24xx_serial_set_termios,
-	.type		= s3c24xx_serial_type,
-	.config_port	= s3c24xx_serial_config_port,
-	.verify_port	= s3c24xx_serial_verify_port,
-#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
-	.poll_get_char = s3c24xx_serial_get_poll_char,
-	.poll_put_char = s3c24xx_serial_put_poll_char,
-#endif
-};
-
 static const struct uart_ops s3c64xx_serial_ops = {
 	.pm		= s3c24xx_serial_pm,
 	.tx_empty	= s3c24xx_serial_tx_empty,
@@ -1836,7 +1745,6 @@ static void s3c24xx_serial_init_port_default(int index) {
 	port->iotype = UPIO_MEM;
 	port->uartclk = 0;
 	port->fifosize = 16;
-	port->ops = &s3c24xx_serial_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->line = index;
 }
@@ -1954,16 +1862,6 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		ourport->tx_irq = ret + 1;
 	}
 
-	switch (ourport->info->type) {
-	case TYPE_S3C24XX:
-		ret = platform_get_irq(platdev, 1);
-		if (ret > 0)
-			ourport->tx_irq = ret;
-		break;
-	default:
-		break;
-	}
-
 	/*
 	 * DMA is currently supported only on DT platforms, if DMA properties
 	 * are specified.
@@ -2083,9 +1981,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 			&ourport->drv_data->def_cfg;
 
 	switch (ourport->info->type) {
-	case TYPE_S3C24XX:
-		ourport->port.ops = &s3c24xx_serial_ops;
-		break;
 	case TYPE_S3C6400:
 		ourport->port.ops = &s3c64xx_serial_ops;
 		break;
-- 
2.40.1

