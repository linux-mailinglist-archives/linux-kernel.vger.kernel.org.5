Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7AF75CE73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjGUQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjGUQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:20:17 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9353C0E;
        Fri, 21 Jul 2023 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eY2wZ9vhu1FfoaXy9aP9IFu/H9QUJ71zX/Q2ydr3vEg=; b=SYrrevZ9txg+HUIOOn/FHXgp3v
        3MOk0wxzcts+zylqfTZzTDvkUpzBy4hzSoVBxXwNclTDQ7tKNG0TKQA8fa3ipqNOTu8HnbQU0bMDQ
        FB5kK8byg58lzJW8+ITmqLItIqtX5uuLFFvTPmx5Jn50GsAXt2fMnZigx2j8pL9w4w14=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:50368 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qMsqD-0003IO-4v; Fri, 21 Jul 2023 12:18:53 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Date:   Fri, 21 Jul 2023 12:18:34 -0400
Message-Id: <20230721161840.1393996-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230721161840.1393996-1-hugo@hugovil.com>
References: <20230721161840.1393996-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [RESEND PATCH v8 04/10] serial: sc16is7xx: refactor GPIO controller registration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

In preparation for upcoming patch "fix regression with GPIO
configuration". To facilitate review and make code more modular.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 32d43d00a583..5b0aeef9d534 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -332,6 +332,7 @@ struct sc16is7xx_one {
 
 struct sc16is7xx_port {
 	const struct sc16is7xx_devtype	*devtype;
+	struct device			*dev;
 	struct regmap			*regmap;
 	struct clk			*clk;
 #ifdef CONFIG_GPIOLIB
@@ -1349,6 +1350,25 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 
 	return 0;
 }
+
+static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
+{
+	if (!s->devtype->nr_gpio)
+		return 0;
+
+	s->gpio.owner		 = THIS_MODULE;
+	s->gpio.parent		 = s->dev;
+	s->gpio.label		 = dev_name(s->dev);
+	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
+	s->gpio.get		 = sc16is7xx_gpio_get;
+	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
+	s->gpio.set		 = sc16is7xx_gpio_set;
+	s->gpio.base		 = -1;
+	s->gpio.ngpio		 = s->devtype->nr_gpio;
+	s->gpio.can_sleep	 = 1;
+
+	return gpiochip_add_data(&s->gpio, s);
+}
 #endif
 
 static const struct serial_rs485 sc16is7xx_rs485_supported = {
@@ -1412,6 +1432,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 	s->regmap = regmap;
 	s->devtype = devtype;
+	s->dev = dev;
 	dev_set_drvdata(dev, s);
 	mutex_init(&s->efr_lock);
 
@@ -1502,22 +1523,9 @@ static int sc16is7xx_probe(struct device *dev,
 	}
 
 #ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio) {
-		/* Setup GPIO cotroller */
-		s->gpio.owner		 = THIS_MODULE;
-		s->gpio.parent		 = dev;
-		s->gpio.label		 = dev_name(dev);
-		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
-		s->gpio.get		 = sc16is7xx_gpio_get;
-		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
-		s->gpio.set		 = sc16is7xx_gpio_set;
-		s->gpio.base		 = -1;
-		s->gpio.ngpio		 = devtype->nr_gpio;
-		s->gpio.can_sleep	 = 1;
-		ret = gpiochip_add_data(&s->gpio, s);
-		if (ret)
-			goto out_ports;
-	}
+	ret = sc16is7xx_setup_gpio_chip(s);
+	if (ret)
+		goto out_ports;
 #endif
 
 	/*
-- 
2.30.2

