Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253C87B09C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjI0QPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjI0QPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:15:06 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98713DE;
        Wed, 27 Sep 2023 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=4cDaJORQqzyKHAyA2iGq/8fh2mCcULmschKPUjYldMA=; b=U9Wi/8v/cYxNUFukrzHejf7iR7
        Ed2IZpGNlTQ5Dvq5Jb9oB9YbJ2hh73HZLGu8Ee3JCc3FG09UG1z9XGvVJgcGvHihsxzRdDoITyh+K
        5cpTMW7ldrpj5bctXPua4gI5iITPr6nvPbN1jLtFpsq/GV/3dFRAfeXbO8zUXn4STUhM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:44078 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qlXBl-0000D9-GY; Wed, 27 Sep 2023 12:15:02 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, hugo@hugovil.com
Date:   Wed, 27 Sep 2023 12:01:52 -0400
Message-Id: <20230927160153.2717788-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230927160153.2717788-1-hugo@hugovil.com>
References: <20230927160153.2717788-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 1/2] serial: sc16is7xx: use device_property APIs when configuring irda mode
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Convert driver to be property provider agnostic and allow it to be
used on non-OF platforms.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 1fe2c3e08a35..db2bb1c0d36c 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1408,6 +1408,29 @@ static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
 }
 #endif
 
+static void sc16is7xx_setup_irda_ports(struct sc16is7xx_port *s)
+{
+	int i;
+	int ret;
+	int count;
+	u32 irda_port[2];
+	struct device *dev = s->p[0].port.dev;
+
+	count = device_property_count_u32(dev, "irda-mode-ports");
+	if (count < 0 || count > ARRAY_SIZE(irda_port))
+		return;
+
+	ret = device_property_read_u32_array(dev, "irda-mode-ports",
+					     irda_port, count);
+	if (ret)
+		return;
+
+	for (i = 0; i < count; i++) {
+		if (irda_port[i] < s->devtype->nr_uart)
+			s->p[irda_port[i]].irda_mode = true;
+	}
+}
+
 /*
  * Configure ports designated to operate as modem control lines.
  */
@@ -1590,16 +1613,7 @@ static int sc16is7xx_probe(struct device *dev,
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
 
-	if (dev->of_node) {
-		struct property *prop;
-		const __be32 *p;
-		u32 u;
-
-		of_property_for_each_u32(dev->of_node, "irda-mode-ports",
-					 prop, p, u)
-			if (u < devtype->nr_uart)
-				s->p[u].irda_mode = true;
-	}
+	sc16is7xx_setup_irda_ports(s);
 
 	ret = sc16is7xx_setup_mctrl_ports(s);
 	if (ret)
-- 
2.30.2

