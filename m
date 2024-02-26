Return-Path: <linux-kernel+bounces-81616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8CC867868
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F931C2A11F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B412EBC4;
	Mon, 26 Feb 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNsp2WpB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA512C537;
	Mon, 26 Feb 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957536; cv=none; b=rb2kZtbkNJ5XnX9DBq0ugu3rj5OGH4tnWFTSqHx1/6QEiVUSGTq8M3L8fOeJB1X9lpbMsOfyGuHYFOGD+v23l9KkDRbpGruG5MIu/IOpe4nCYar4u/hzif3EO9Bc/IBUKtLoJJ5L4HLZCxzLTYi1GZo/7lgR5YH0OAwtCLO3rUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957536; c=relaxed/simple;
	bh=IYoY9YglSHFf69pZg59ideH+3au8X4iy+Kx6zcfcQbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3+H4baI0mub0MSp0pjMtaOeRqEMC1C369lVq01PeT3vlp3lIu+rP4kSAjejTjMSH6m2hQ08rESBCd8raSSufs57L/9DqMSvQWNr4pHiFeRbAI8SnW9HJt7qfqqF5ouGEnsThOVPXfB2y29EBtS02BKE92hp6WOSsIQzFNfqN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNsp2WpB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957535; x=1740493535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IYoY9YglSHFf69pZg59ideH+3au8X4iy+Kx6zcfcQbU=;
  b=fNsp2WpB3A3+TQNDmotj4YsVIQOWiO8RPT4pLYeB4YSFrBfxPBvFsfHH
   5eP9PoG0lMpBBera/U1MLcg3nuFRWyNWJHXB/cfg5av1UmBFgKIDnhZmi
   p/nMMLaIVAlNMefHdnPj39fjbqvt4fhWuGkOLt6YKcnCpxd1B+HUt2Xtv
   GbFTICiwmA3XT3CaXjiiRBfjuAu4H/LtYc7vOrgL2krlMO3w1V4szvE62
   YHVcs1Az7/2Y1sbCYRXCjdQ1fGrzwz6pPFNJqbRsWKqTzMsJ1vWk3mIDO
   Ww0U5p2rXlyNBQgkLO3NbAxhflsFx0bJ9tXjpVjQTTHdBkv+S/QAnjkke
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3375294"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3375294"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:25:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937030147"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937030147"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 06:25:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7FFC29AD; Mon, 26 Feb 2024 16:25:16 +0200 (EET)
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
Subject: [PATCH v2 10/14] serial: 8250_of: Switch to use uart_read_port_properties()
Date: Mon, 26 Feb 2024 16:19:26 +0200
Message-ID: <20240226142514.1485246-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_of.c | 105 +++++++-----------------------
 1 file changed, 22 insertions(+), 83 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 9dcc17e33269..1a699ce2e812 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -69,37 +69,22 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = dev->of_node;
 	struct uart_port *port = &up->port;
-	u32 clk, spd, prop;
-	int ret, irq;
+	u32 spd;
+	int ret;
 
 	memset(port, 0, sizeof *port);
 
 	pm_runtime_enable(&ofdev->dev);
 	pm_runtime_get_sync(&ofdev->dev);
 
-	if (of_property_read_u32(np, "clock-frequency", &clk)) {
-
-		/* Get clk rate through clk driver if present */
-		info->clk = devm_clk_get_enabled(dev, NULL);
-		if (IS_ERR(info->clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
-			goto err_pmruntime;
-		}
-
-		clk = clk_get_rate(info->clk);
-	}
-	/* If current-speed was set, then try not to change it. */
-	if (of_property_read_u32(np, "current-speed", &spd) == 0)
-		port->custom_divisor = clk / (16 * spd);
-
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_err_probe(dev, ret, "invalid address\n");
 		goto err_pmruntime;
 	}
 
-	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
-				  UPF_FIXED_TYPE;
+	port->dev = &ofdev->dev;
+	port->flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	spin_lock_init(&port->lock);
 
 	if (resource_type(&resource) == IORESOURCE_IO) {
@@ -108,70 +93,31 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	} else {
 		port->mapbase = resource.start;
 		port->mapsize = resource_size(&resource);
-
-		/* Check for shifted address mapping */
-		if (of_property_read_u32(np, "reg-offset", &prop) == 0) {
-			if (prop >= port->mapsize) {
-				ret = dev_err_probe(dev, -EINVAL, "reg-offset %u exceeds region size %pa\n",
-						    prop, &port->mapsize);
-				goto err_pmruntime;
-			}
-
-			port->mapbase += prop;
-			port->mapsize -= prop;
-		}
-
-		port->iotype = UPIO_MEM;
-		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
-			switch (prop) {
-			case 1:
-				port->iotype = UPIO_MEM;
-				break;
-			case 2:
-				port->iotype = UPIO_MEM16;
-				break;
-			case 4:
-				port->iotype = of_device_is_big_endian(np) ?
-					       UPIO_MEM32BE : UPIO_MEM32;
-				break;
-			default:
-				ret = dev_err_probe(dev, -EINVAL, "unsupported reg-io-width (%u)\n",
-						    prop);
-				goto err_pmruntime;
-			}
-		}
 		port->flags |= UPF_IOREMAP;
 	}
 
+	ret = uart_read_port_properties(port, false);
+	if (ret)
+		goto err_pmruntime;
+
+	/* Get clk rate through clk driver if present */
+	if (!port->uartclk) {
+		info->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(info->clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
+			goto err_pmruntime;
+		}
+
+		port->uartclk = clk_get_rate(info->clk);
+	}
+	/* If current-speed was set, then try not to change it. */
+	if (of_property_read_u32(np, "current-speed", &spd) == 0)
+		port->custom_divisor = port->uartclk / (16 * spd);
+
 	/* Compatibility with the deprecated pxa driver and 8250_pxa drivers. */
 	if (of_device_is_compatible(np, "mrvl,mmp-uart"))
 		port->regshift = 2;
 
-	/* Check for registers offset within the devices address range */
-	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
-		port->regshift = prop;
-
-	/* Check for fifo size */
-	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
-		port->fifosize = prop;
-
-	/* Check for a fixed line number */
-	ret = of_alias_get_id(np, "serial");
-	if (ret >= 0)
-		port->line = ret;
-
-	irq = of_irq_get(np, 0);
-	if (irq < 0) {
-		if (irq == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto err_pmruntime;
-		}
-		/* IRQ support not mandatory */
-		irq = 0;
-	}
-
-	port->irq = irq;
-
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst)) {
 		ret = PTR_ERR(info->rst);
@@ -183,12 +129,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		goto err_pmruntime;
 
 	port->type = type;
-	port->uartclk = clk;
-
-	if (of_property_read_bool(np, "no-loopback-test"))
-		port->flags |= UPF_SKIP_TEST;
-
-	port->dev = &ofdev->dev;
 	port->rs485_config = serial8250_em485_config;
 	port->rs485_supported = serial8250_em485_supported;
 	up->rs485_start_tx = serial8250_em485_start_tx;
@@ -280,7 +220,6 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	platform_set_drvdata(ofdev, info);
 	return 0;
 err_dispose:
-	irq_dispose_mapping(port8250.port.irq);
 	pm_runtime_put_sync(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
 err_free:
-- 
2.43.0.rc1.1.gbec44491f096


