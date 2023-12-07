Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4881B808DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjLGQ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjLGQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:26:36 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10512D;
        Thu,  7 Dec 2023 08:26:42 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f5da5df68eso730575fac.2;
        Thu, 07 Dec 2023 08:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966401; x=1702571201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrIilKopCy+JlhjKJ757AT5TowHvKtEtJSE0B1E87zw=;
        b=Wyh8DiYYuwiHoQduTHsez1N3CuY3h5RCHvQSV5/7bgH4l/UlK8zRO90nxxS9pVfV4X
         gW0iViKI0vhjFNLM8QU6UOZnPuqXwJ2Fi1gTbNXTsJCwIHGPNWHy40FnTUMFhYQs5/d9
         YKZWpdIcMHuPtYYKRIPjDuyw+y6LhD5DeItYqIYJNGiobhfrQ8hIEDdYLmch1hGPBl1h
         o1zpLCcBYyx+Ar5Rocfqmcw4nMm/+4YzHl0o2jTDR2xR4wPz4UCU/AcNTxOTTk3WdCLC
         +JQavcMqozm2jcCWuUV1unX+0QvM39mbk1sAVN1Q3cpL55zHpUkPIfKzSmbdjBfVvyua
         B0Uw==
X-Gm-Message-State: AOJu0YzJXTFavB375NNHGxT1upLXQwuZevuXMHlt6OB8ENe/1uAJkIzZ
        2kJ43OKRoUw66tZrUtUB5412bMP60A==
X-Google-Smtp-Source: AGHT+IE6+NezKaYvdw+o/oi4OrqQ8qwfYR0izhNlIVeKAUJXNXWpC45tUStqHm/WBLKctyT+TB7Kzg==
X-Received: by 2002:a05:6871:2b29:b0:1fa:d948:5992 with SMTP id dr41-20020a0568712b2900b001fad9485992mr2835849oac.54.1701966401694;
        Thu, 07 Dec 2023 08:26:41 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id my14-20020a056870698e00b001fb044ebdfdsm26453oab.13.2023.12.07.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:26:39 -0800 (PST)
Received: (nullmailer pid 2651545 invoked by uid 1000);
        Thu, 07 Dec 2023 16:26:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/2] serial: esp32_uart: Use device_get_match_data()
Date:   Thu,  7 Dec 2023 10:26:31 -0600
Message-ID: <20231207162632.2650356-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207162632.2650356-1-robh@kernel.org>
References: <20231207162632.2650356-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Error checking for matching was not necessary as matching is always
successful if we're already in probe and the match tables always have data
pointers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/esp32_uart.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 6e12955d1315..6fc61f323355 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -9,7 +9,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/tty_flip.h>
@@ -678,16 +679,11 @@ static struct uart_driver esp32_uart_reg = {
 static int esp32_uart_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	static const struct of_device_id *match;
 	struct uart_port *port;
 	struct esp32_port *sport;
 	struct resource *res;
 	int ret;
 
-	match = of_match_device(esp32_uart_dt_ids, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
 		return -ENOMEM;
@@ -728,7 +724,7 @@ static int esp32_uart_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->has_sysrq = 1;
 	port->fifosize = ESP32_UART_TX_FIFO_SIZE;
-	port->private_data = (void *)match->data;
+	port->private_data = (void *)device_get_match_data(&pdev->dev);
 
 	esp32_uart_ports[port->line] = sport;
 
-- 
2.42.0

