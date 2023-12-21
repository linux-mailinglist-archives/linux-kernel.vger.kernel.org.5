Return-Path: <linux-kernel+bounces-9158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D0A81C1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02ECB1F22B27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEEE79948;
	Thu, 21 Dec 2023 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ZgEVfGWd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8F78E9D;
	Thu, 21 Dec 2023 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=9vLSuwSuinaGR58m/VQBBtnfS0zJHnLEOqbKnjl2e+8=; b=ZgEVfGWdU24hPBZ+fO6NHWHieT
	XR4mtREvX2wJSgur4UyWZ+FFq73SyAPse3C83iW8UrJd1WUebwKpg1FvxB7hbXty516y3s4EvdOvP
	KEgHVISHsGrI6LAVcxGmxx4GHar12ASqI7O68PpFBZurzwD4PIsruIIZWWyXPibxhlUY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52484 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGSJQ-00025W-5C; Thu, 21 Dec 2023 18:18:44 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kubakici@wp.pl,
	indrakanti_ram@hotmail.com,
	phil@raspberrypi.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:17 -0500
Message-Id: <20231221231823.2327894-11-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221231823.2327894-1-hugo@hugovil.com>
References: <20231221231823.2327894-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v2 10/16] serial: sc16is7xx: add macro for max number of UART ports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add macro to hold the maximum number of UART ports per IC/device.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index b73fac209f1e..6181cc6f934b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -29,6 +29,7 @@
 
 #define SC16IS7XX_NAME			"sc16is7xx"
 #define SC16IS7XX_MAX_DEVS		8
+#define SC16IS7XX_MAX_PORTS		2 /* Maximum number of UART ports per IC. */
 
 /* SC16IS7XX register definitions */
 #define SC16IS7XX_RHR_REG		(0x00) /* RX FIFO */
@@ -1398,7 +1399,7 @@ static void sc16is7xx_setup_irda_ports(struct sc16is7xx_port *s)
 	int i;
 	int ret;
 	int count;
-	u32 irda_port[2];
+	u32 irda_port[SC16IS7XX_MAX_PORTS];
 	struct device *dev = s->p[0].port.dev;
 
 	count = device_property_count_u32(dev, "irda-mode-ports");
@@ -1425,7 +1426,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
 	int i;
 	int ret;
 	int count;
-	u32 mctrl_port[2];
+	u32 mctrl_port[SC16IS7XX_MAX_PORTS];
 	struct device *dev = s->p[0].port.dev;
 
 	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
@@ -1727,7 +1728,7 @@ static unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id)
 static int sc16is7xx_spi_probe(struct spi_device *spi)
 {
 	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmaps[2];
+	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
 	unsigned int i;
 	int ret;
 
@@ -1798,7 +1799,7 @@ MODULE_ALIAS("spi:sc16is7xx");
 static int sc16is7xx_i2c_probe(struct i2c_client *i2c)
 {
 	const struct sc16is7xx_devtype *devtype;
-	struct regmap *regmaps[2];
+	struct regmap *regmaps[SC16IS7XX_MAX_PORTS];
 	unsigned int i;
 
 	devtype = i2c_get_match_data(i2c);
-- 
2.39.2


