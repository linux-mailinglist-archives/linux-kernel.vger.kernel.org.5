Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905187CE775
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJRTNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjJRTNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:13:01 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82034109;
        Wed, 18 Oct 2023 12:12:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so3946062a12.0;
        Wed, 18 Oct 2023 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697656379; x=1698261179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJuZrcynRmqe1xNXly1uRSDUH55ExZngYdQ7/gKKmDc=;
        b=cpYH3k4EIlbM0PpNL2JhhMa+V+9hAg3Kqxilj1NZQws4Q1K7kx/PBeysGEUGDPf6kP
         p6s5olqd/DEgQzrivGYYWWPb9rKmoubcx+2gGPT8JJlzy8Zmmnu76HsXU2cYqYZCHyu1
         9ZpFsxzyR8nmbeHTCr7XX4yLOsoS+W8Acig1Gl1Dz6ppNWj1TH4ZLKtpRFab6OGv2lG4
         5K+WmLOsu+cuEYWT59a7AkXpvGjSXCleT8aj+nNLnB1suf4ZIvQ4WWwgj9MP9eCtW62x
         wlwBdp2WSf6+T2aeLqVlc8O987PXc1L2Cr5DIRkoQG+sC03XnDCOamFwLOt370Y972QX
         L0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656379; x=1698261179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJuZrcynRmqe1xNXly1uRSDUH55ExZngYdQ7/gKKmDc=;
        b=punvf+T/DVaB+pcYeX6VjJ0pOARMiJ16CxrY/Aik+KlFz38VYINOORUsoPVzNYjG91
         yvqeeBGVllQRu8eMzu8sMCOrov1HzH/U/+4NtA5EzIWjeXTPfsSEdghmN8elyP7hr5GI
         OGhfoxcIFGSqrTRhQvVCA3dfdUJrnH5VYUsYUGTnDI9p+XLL0x0EI7vJFQgggeknF+rJ
         C1s3FmL2h/KMC6BInDAR7YPO55GYadWAtkyOLRqAejTL9cxrK0KHRIvxMVJenU01A7zo
         QdC2QMiIgZ9uQOAg/MuNaYIk8OoZdKOtWbgFaOXOiE36zRZLTWTvPTu8fUz2wU8xrxtL
         C7uQ==
X-Gm-Message-State: AOJu0Ywg0F44AFYlhxejbQnI0sTlYyKd2/Rq8J1qcscjntofHubXUzfe
        tpnm0aPYBZXgZSEf6M2IydGvYpCxUQY=
X-Google-Smtp-Source: AGHT+IECkP5YSe+hHkztyn5J3q9v7uiTC0Q3kNnHmY8blqtBuDdnTHo1VkUMs7AGU+SJnde1EDNA3Q==
X-Received: by 2002:a17:90a:3dc7:b0:27d:5174:442f with SMTP id i65-20020a17090a3dc700b0027d5174442fmr56581pjc.6.1697656378580;
        Wed, 18 Oct 2023 12:12:58 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:5cbe:af5b:db1d:d789])
        by smtp.gmail.com with ESMTPSA id n6-20020a654886000000b005781e026905sm1797358pgs.56.2023.10.18.12.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:12:58 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] serial/esp32_uart: use prescaler when available
Date:   Wed, 18 Oct 2023 12:12:52 -0700
Message-Id: <20231018191252.1551972-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

esp32s3 variant of the esp32 UART has limited baudrate divisor range
that does not allow it to use 9600 and lower rates with 40MHz input
clock. Use clock prescaler present in this UART variant to help with
that.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/tty/serial/esp32_uart.c | 49 +++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 82033470db44..85c9c5ad7cc5 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -67,6 +67,26 @@
 #define ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT	10
 #define ESP32_UART_RX_FLOW_EN			BIT(23)
 #define ESP32S3_UART_RX_FLOW_EN			BIT(22)
+#define ESP32S3_UART_CLK_CONF_REG	0x78
+#define ESP32S3_UART_SCLK_DIV_B			GENMASK(5, 0)
+#define ESP32S3_UART_SCLK_DIV_A			GENMASK(11, 6)
+#define ESP32S3_UART_SCLK_DIV_NUM		GENMASK(19, 12)
+#define ESP32S3_UART_SCLK_SEL			GENMASK(21, 20)
+#define APB_CLK					1
+#define RC_FAST_CLK				2
+#define XTAL_CLK				3
+#define ESP32S3_UART_SCLK_EN			BIT(22)
+#define ESP32S3_UART_RST_CORE			BIT(23)
+#define ESP32S3_UART_TX_SCLK_EN			BIT(24)
+#define ESP32S3_UART_RX_SCLK_EN			BIT(25)
+#define ESP32S3_UART_TX_RST_CORE		BIT(26)
+#define ESP32S3_UART_RX_RST_CORE		BIT(27)
+
+#define ESP32S3_UART_CLK_CONF_DEFAULT \
+	(ESP32S3_UART_RX_SCLK_EN | \
+	 ESP32S3_UART_TX_SCLK_EN | \
+	 ESP32S3_UART_SCLK_EN | \
+	 FIELD_PREP(ESP32S3_UART_SCLK_SEL, XTAL_CLK))
 
 struct esp32_port {
 	struct uart_port port;
@@ -80,6 +100,7 @@ struct esp32_uart_variant {
 	u32 txfifo_empty_thrhd_shift;
 	u32 rx_flow_en;
 	const char *type;
+	bool has_clkconf;
 };
 
 static const struct esp32_uart_variant esp32_variant = {
@@ -98,6 +119,7 @@ static const struct esp32_uart_variant esp32s3_variant = {
 	.txfifo_empty_thrhd_shift = ESP32S3_UART_TXFIFO_EMPTY_THRHD_SHIFT,
 	.rx_flow_en = ESP32S3_UART_RX_FLOW_EN,
 	.type = "ESP32S3 UART",
+	.has_clkconf = true,
 };
 
 static const struct of_device_id esp32_uart_dt_ids[] = {
@@ -314,6 +336,9 @@ static int esp32_uart_startup(struct uart_port *port)
 	}
 
 	spin_lock_irqsave(&port->lock, flags);
+	if (port_variant(port)->has_clkconf)
+		esp32_uart_write(port, ESP32S3_UART_CLK_CONF_REG,
+				 ESP32S3_UART_CLK_CONF_DEFAULT);
 	esp32_uart_write(port, UART_CONF1_REG,
 			 (1 << UART_RXFIFO_FULL_THRHD_SHIFT) |
 			 (1 << port_variant(port)->txfifo_empty_thrhd_shift));
@@ -335,10 +360,24 @@ static void esp32_uart_shutdown(struct uart_port *port)
 
 static bool esp32_uart_set_baud(struct uart_port *port, u32 baud)
 {
-	u32 div = port->uartclk / baud;
-	u32 frag = (port->uartclk * 16) / baud - div * 16;
+	u32 sclk = port->uartclk;
+	u32 div = sclk / baud;
+
+	if (port_variant(port)->has_clkconf) {
+		u32 sclk_div = div / port_variant(port)->clkdiv_mask;
+
+		if (div > port_variant(port)->clkdiv_mask) {
+			sclk /= (sclk_div + 1);
+			div = sclk / baud;
+		}
+		esp32_uart_write(port, ESP32S3_UART_CLK_CONF_REG,
+				 FIELD_PREP(ESP32S3_UART_SCLK_DIV_NUM, sclk_div) |
+				 ESP32S3_UART_CLK_CONF_DEFAULT);
+	}
 
 	if (div <= port_variant(port)->clkdiv_mask) {
+		u32 frag = (sclk * 16) / baud - div * 16;
+
 		esp32_uart_write(port, UART_CLKDIV_REG,
 				 div | FIELD_PREP(UART_CLKDIV_FRAG, frag));
 		return true;
@@ -355,11 +394,15 @@ static void esp32_uart_set_termios(struct uart_port *port,
 	u32 conf0, conf1;
 	u32 baud;
 	const u32 rx_flow_en = port_variant(port)->rx_flow_en;
+	u32 max_div = port_variant(port)->clkdiv_mask;
 
 	termios->c_cflag &= ~CMSPAR;
 
+	if (port_variant(port)->has_clkconf)
+		max_div *= FIELD_MAX(ESP32S3_UART_SCLK_DIV_NUM);
+
 	baud = uart_get_baud_rate(port, termios, old,
-				  port->uartclk / port_variant(port)->clkdiv_mask,
+				  port->uartclk / max_div,
 				  port->uartclk / 16);
 
 	spin_lock_irqsave(&port->lock, flags);
-- 
2.30.2

