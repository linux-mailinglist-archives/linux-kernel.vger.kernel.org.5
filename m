Return-Path: <linux-kernel+bounces-90569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE5870162
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000D3B23377
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B83EA77;
	Mon,  4 Mar 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hofyveDH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF23D572;
	Mon,  4 Mar 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555451; cv=none; b=GoUwdBujqfcu5rZ8jUKdZ7Ini0B7BZDlsqxUzVTCoNhsktO7lJIQx2sV2T1skRMMG8aP5sq1YSyxF24Ib6aHJo5J/3FKHfrHMBDVwdz7Qs531GIcg418VRilP+ITFFsCw3gSWIVIloPhSpVyth7U6pHIwpYsboBIM0dx7PA4Jj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555451; c=relaxed/simple;
	bh=VQzYesoWaSGdzPXgo5CExyTjqg7vEOXbasHg+xkm+2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdgmiQyHDDY++DDVnap8vki2wygfijCvVB4h+fAhI/bjGp8DvJFZLIeoVIMJaj972dM9yaWINZ4NazFONTgld/DfjQQG6ddv7/mmByUi+3hFfStL/bFjnTRi5RFcWiSgY1ji0aUs3CdaoJCKyiofTJ2IMUj63n0z0YdhZZ84Wlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hofyveDH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555449; x=1741091449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VQzYesoWaSGdzPXgo5CExyTjqg7vEOXbasHg+xkm+2w=;
  b=hofyveDHIqKQuX1KvwYi3H2OCTxs6pmyCqNrNzp1BI2YlCg5wc7s882I
   MYbYVxvYd4PMXJxwpX+tyaxVdGH2go8CsBx3nOfWPiE0ZtwASLqlum8mM
   m4o3aC0B3KYX7xtnmUvbyJ4MHmWzmkoWXuEVJj8qkaIOckwe6guyeWzIn
   0yoHtLEI5bKMjsGrlSGyuk6n4E9M+iLusCVtk6A/TbNlSwVxgsiSE5uDK
   iJO6lSDhyYpSb3KeO+Ck+KGvtaEXwVZ0UqiiKplQU9aCyuD6IHmo5/X5u
   cHLg1NCcTWmQr5pDyoSnCzi2UCghy0jQlkSH2QACAel/iyrinC5KML+i9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815086"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815086"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040425"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040425"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 686C35BB; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v3 04/14] serial: 8250_aspeed_vuart: Switch to use uart_read_port_properties()
Date: Mon,  4 Mar 2024 14:27:05 +0200
Message-ID: <20240304123035.758700-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
References: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 50 +++++++--------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 8c2aaf7af7b7..53d8eee9b1c8 100644
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
+	rc = uart_read_port_properties(&port.port);
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


