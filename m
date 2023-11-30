Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550107FFAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346818AbjK3TK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjK3TKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:10:52 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B498210DF;
        Thu, 30 Nov 2023 11:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=sf/+tsRuKLsDDbGlmeVGJcieRbgKthsotmSW2vG3wDg=; b=jfyPKYM2uxBgo2F7jDs5J/G1HK
        G6hRJ9yepRYeD4OnsNHs9eIWBAupcduf1Vf/nETSdFqnVOn++bXOYOHZFG51HuN/O/Wsduqv5obcp
        itG7MfzI9adnCzqel6eaZUFqUoUTYWVmhmqjuRJ+cSt4w/8dojkfBEyhoAZGJ+IEouRE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48272 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r8mR5-0003sb-Q2; Thu, 30 Nov 2023 14:10:56 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        hugo@hugovil.com, stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Nov 2023 14:10:44 -0500
Message-Id: <20231130191050.3165862-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130191050.3165862-1-hugo@hugovil.com>
References: <20231130191050.3165862-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH 2/7] serial: sc16is7xx: remove global regmap from struct sc16is7xx_port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Remove global struct regmap so that it is more obvious that this
regmap is to be used only in the probe function.

Also add a comment to that effect in probe function.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc: stable@vger.kernel.org
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8e5baf2f6ec6..23dbf77633aa 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -334,7 +334,6 @@ struct sc16is7xx_one {
 
 struct sc16is7xx_port {
 	const struct sc16is7xx_devtype	*devtype;
-	struct regmap			*regmap;
 	struct clk			*clk;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip		gpio;
@@ -1422,7 +1421,8 @@ static void sc16is7xx_setup_irda_ports(struct sc16is7xx_port *s)
 /*
  * Configure ports designated to operate as modem control lines.
  */
-static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
+static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
+				       struct regmap *regmap)
 {
 	int i;
 	int ret;
@@ -1451,7 +1451,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
 
 	if (s->mctrl_mask)
 		regmap_update_bits(
-			s->regmap,
+			regmap,
 			SC16IS7XX_IOCONTROL_REG,
 			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
 			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
@@ -1483,6 +1483,10 @@ static int sc16is7xx_probe(struct device *dev,
 	 * This device does not have an identification register that would
 	 * tell us if we are really connected to the correct device.
 	 * The best we can do is to check if communication is at all possible.
+	 *
+	 * Note: regmap[0] is used in the probe function to access registers
+	 * common to all channels/ports, as it is guaranteed to be present on
+	 * all variants.
 	 */
 	ret = regmap_read(regmaps[0], SC16IS7XX_LSR_REG, &val);
 	if (ret < 0)
@@ -1518,7 +1522,6 @@ static int sc16is7xx_probe(struct device *dev,
 			return -EINVAL;
 	}
 
-	s->regmap = regmaps[0];
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 	mutex_init(&s->efr_lock);
@@ -1533,7 +1536,7 @@ static int sc16is7xx_probe(struct device *dev,
 	sched_set_fifo(s->kworker_task);
 
 	/* reset device, purging any pending irq / data */
-	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG,
+	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
@@ -1604,7 +1607,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 	sc16is7xx_setup_irda_ports(s);
 
-	ret = sc16is7xx_setup_mctrl_ports(s);
+	ret = sc16is7xx_setup_mctrl_ports(s, regmaps[0]);
 	if (ret)
 		goto out_ports;
 
-- 
2.39.2

