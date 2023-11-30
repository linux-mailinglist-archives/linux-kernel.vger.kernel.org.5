Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF187FFAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbjK3TLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346816AbjK3TK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:10:56 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492EF10DE;
        Thu, 30 Nov 2023 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=Cfw2qQFHxR7Ac5K0XfN6TaUdPVSzYZ0pF9vaoSYN+c0=; b=OSgonvXY6ptb+8x3AvPn2XyfCw
        /SAEZzT+wMAWMXKdfeJwMX1G0369OV23NMBvcP2pPx9EeW2r7/O1TgcFZ1FGBurQKpunn/AMAlz4J
        /EW2QUVzkjYHkPGI5OjAY50/tcknJUAXSCoFmwtf/UnY6fquvtiAIZWCwJ01hc+gAubk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48272 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r8mRA-0003sb-Jn; Thu, 30 Nov 2023 14:11:01 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        hugo@hugovil.com
Date:   Thu, 30 Nov 2023 14:10:49 -0500
Message-Id: <20231130191050.3165862-8-hugo@hugovil.com>
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
Subject: [PATCH 7/7] serial: max310x: use separate regmap name for each port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Use a separate regmap name for each port so that each port can have its own
debugfs entry, allowing to access each port registers independently.

For example, a four channels/ports device like the MAX14830 will have four
entries in its regmap debugfs:

$ find /sys/kernel/debug/regmap -type d | grep spi0.0
/sys/kernel/debug/regmap/spi0.0-port0
/sys/kernel/debug/regmap/spi0.0-port1
/sys/kernel/debug/regmap/spi0.0-port2
/sys/kernel/debug/regmap/spi0.0-port3

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 58dd5cc62014..d2eca05a6966 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 
 #define MAX310X_NAME			"max310x"
+#define MAX310X_PORT_NAME_SUFFIX	"port"
 #define MAX310X_MAJOR			204
 #define MAX310X_MINOR			209
 #define MAX310X_UART_NRMAX		16
@@ -1486,6 +1487,15 @@ static struct regmap_config regcfg = {
 	.max_raw_write = MAX310X_FIFO_SIZE,
 };
 
+static const char *max310x_regmap_name(unsigned int port_id)
+{
+	static char buf[sizeof(MAX310X_PORT_NAME_SUFFIX __stringify(MAX310X_MAX_PORTS))];
+
+	snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
+
+	return buf;
+}
+
 #ifdef CONFIG_SPI_MASTER
 static int max310x_spi_extended_reg_enable(struct device *dev, bool enable)
 {
@@ -1521,6 +1531,8 @@ static int max310x_spi_probe(struct spi_device *spi)
 
 	for (i = 0; i < devtype->nr; i++) {
 		u8 port_mask = i * 0x20;
+
+		regcfg.name = max310x_regmap_name(i);
 		regcfg.read_flag_mask = port_mask;
 		regcfg.write_flag_mask = port_mask | MAX310X_WRITE_BIT;
 		regmaps[i] = devm_regmap_init_spi(spi, &regcfg);
@@ -1617,6 +1629,7 @@ static int max310x_i2c_probe(struct i2c_client *client)
 				     client->addr, devtype->slave_addr.min,
 				     devtype->slave_addr.max);
 
+	regcfg_i2c.name = max310x_regmap_name(0);
 	regmaps[0] = devm_regmap_init_i2c(client, &regcfg_i2c);
 
 	for (i = 1; i < devtype->nr; i++) {
@@ -1625,6 +1638,7 @@ static int max310x_i2c_probe(struct i2c_client *client)
 							client->adapter,
 							port_addr);
 
+		regcfg_i2c.name = max310x_regmap_name(i);
 		regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
 	}
 
-- 
2.39.2

