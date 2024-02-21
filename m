Return-Path: <linux-kernel+bounces-75304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F8D85E62D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7769A2851E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9084C8593D;
	Wed, 21 Feb 2024 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcD9DmB1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1D3C068;
	Wed, 21 Feb 2024 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540498; cv=none; b=qsAHKL6RKLeOHWn6fBbMLygjp+UGoEzJ9CrGAUtBXBd6s7WrltbkrzRlY0xBRJb6zwBfqnLHc+bnPYttmaTkD9cGMp1SWSwBzUgjKabsU1Y2OQoLU9t7XGfceMuno6NXTijjViB+5acEzgph1NczUCqGJtK1Df3lDSG9rBMf1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540498; c=relaxed/simple;
	bh=dYynpd7BpWY3yNBCHCGwe1IyzPj618I/HKzMJe4rUOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyLqaob4/sKrWy0fiBfA5SZvDPrzPVy702x0vPPc+SN6X8PNF30I2LxEdTgWawUAKnC48M4Aa9W0Pwj8OJOz1WOoCmh5utjS+i48P6WJCTbOAOapALRsfbWm9SMRx0K8aLFF6nMyWAaGfDlAxEY2vtZsjz3WOfWUdUdCnEuejMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcD9DmB1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540497; x=1740076497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dYynpd7BpWY3yNBCHCGwe1IyzPj618I/HKzMJe4rUOU=;
  b=OcD9DmB124M9oL1YfCGGLodiTjgpKO/k+aDAEgp6EZEeXilz9LEpMECC
   K3cAn4+oqecQ3G67GsY/Eop5aUNDsAShIZQ+GIR0VSgwN384Xmp4x4eTM
   SUwF9vZCuosgRZfMDZ7FJr3UAFQsEhJam7svu70JW51XVNy7eNjBXAul6
   cAbP5HT24K6TzgIW/SB3HBKmgK0XxolU/HsYKunwMetyOSkxnDzfls9Xg
   LNb4hAR7bGPzoYbV/1vijsY7bmn/MPi9DYlP/Snh8YvtXQvPDR3/mkQzy
   kz08H6Fy4aX0yxnTG2BlafhmJC+mqaFoO8Rk+PfQc0d5lrBrOqx7sCbNG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164688"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164688"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:34:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684740"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684740"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EA46D3F4; Wed, 21 Feb 2024 20:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v1 04/14] serial: 8250_aspeed_vuart: Switch to use uart_read_port_properties()
Date: Wed, 21 Feb 2024 20:31:20 +0200
Message-ID: <20240221183442.4124354-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 50 +++++++--------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 8c2aaf7af7b7..2a4bc39b11af 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -419,8 +419,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	struct aspeed_vuart *vuart;
 	struct device_node *np;
 	struct resource *res;
-	u32 clk, prop, sirq[2];
 	int rc, sirq_polarity;
+	u32 prop, sirq[2];
 	struct clk *vclk;
 
 	np = pdev->dev.of_node;
@@ -447,53 +447,35 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	port.port.status = UPSTAT_SYNC_FIFO;
 	port.port.dev = &pdev->dev;
 	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+	port.port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE |
+			  UPF_NO_THRE_TEST;
 	port.bugs |= UART_BUG_TXRACE;
 
 	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	if (rc < 0)
 		return rc;
 
-	if (of_property_read_u32(np, "clock-frequency", &clk)) {
+	rc = uart_read_port_properties(&port.port, true);
+	if (rc)
+		goto err_sysfs_remove;
+
+	/* Get clk rate through clk driver if present */
+	if (!port.port.uartclk) {
 		vclk = devm_clk_get_enabled(dev, NULL);
 		if (IS_ERR(vclk)) {
 			rc = dev_err_probe(dev, PTR_ERR(vclk), "clk or clock-frequency not defined\n");
 			goto err_sysfs_remove;
 		}
 
-		clk = clk_get_rate(vclk);
+		port.port.uartclk = clk_get_rate(vclk);
 	}
 
 	/* If current-speed was set, then try not to change it. */
 	if (of_property_read_u32(np, "current-speed", &prop) == 0)
-		port.port.custom_divisor = clk / (16 * prop);
+		port.port.custom_divisor = port.port.uartclk / (16 * prop);
 
-	/* Check for shifted address mapping */
-	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
-		port.port.mapbase += prop;
-
-	/* Check for registers offset within the devices address range */
-	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
-		port.port.regshift = prop;
-
-	/* Check for fifo size */
-	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
-		port.port.fifosize = prop;
-
-	/* Check for a fixed line number */
-	rc = of_alias_get_id(np, "serial");
-	if (rc >= 0)
-		port.port.line = rc;
-
-	port.port.irq = irq_of_parse_and_map(np, 0);
 	port.port.handle_irq = aspeed_vuart_handle_irq;
-	port.port.iotype = UPIO_MEM;
 	port.port.type = PORT_ASPEED_VUART;
-	port.port.uartclk = clk;
-	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
-		| UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
-
-	if (of_property_read_bool(np, "no-loopback-test"))
-		port.port.flags |= UPF_SKIP_TEST;
 
 	if (port.port.fifosize)
 		port.capabilities = UART_CAP_FIFO;
@@ -503,7 +485,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	rc = serial8250_register_8250_port(&port);
 	if (rc < 0)
-		goto err_clk_disable;
+		goto err_sysfs_remove;
 
 	vuart->line = rc;
 	vuart->port = serial8250_get_port(vuart->line);
@@ -529,7 +511,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	rc = aspeed_vuart_set_lpc_address(vuart, prop);
 	if (rc < 0) {
 		dev_err_probe(dev, rc, "invalid value in aspeed,lpc-io-reg property\n");
-		goto err_clk_disable;
+		goto err_sysfs_remove;
 	}
 
 	rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", sirq, 2);
@@ -541,14 +523,14 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	rc = aspeed_vuart_set_sirq(vuart, sirq[0]);
 	if (rc < 0) {
 		dev_err_probe(dev, rc, "invalid sirq number in aspeed,lpc-interrupts property\n");
-		goto err_clk_disable;
+		goto err_sysfs_remove;
 	}
 
 	sirq_polarity = aspeed_vuart_map_irq_polarity(sirq[1]);
 	if (sirq_polarity < 0) {
 		rc = dev_err_probe(dev, sirq_polarity,
 				   "invalid sirq polarity in aspeed,lpc-interrupts property\n");
-		goto err_clk_disable;
+		goto err_sysfs_remove;
 	}
 
 	aspeed_vuart_set_sirq_polarity(vuart, sirq_polarity);
@@ -559,8 +541,6 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_clk_disable:
-	irq_dispose_mapping(port.port.irq);
 err_sysfs_remove:
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	return rc;
-- 
2.43.0.rc1.1.gbec44491f096


