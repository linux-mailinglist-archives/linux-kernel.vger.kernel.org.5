Return-Path: <linux-kernel+bounces-81608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD6867847
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4631F25E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E0912A14B;
	Mon, 26 Feb 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhyazrkp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10D12BEB6;
	Mon, 26 Feb 2024 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957531; cv=none; b=om4zSJLfmiaIHfgC/vkqOjeuSKPW/Cuz+8wCkZzHkTtYTuUfmAFfy2vnkFxFCFeYTPT7LMulumKQuQ1C5ZOjyWvkqV/J1dzTlG3JCNWshzRu+XbDaWpGOq9TxwxS7FznpHrmIaf2n5RNcQEWiU3m8SEIbo04TP+p9fHmOjOS+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957531; c=relaxed/simple;
	bh=hEPEnqkJOil/jP3cx9hGmK0SGdKV4rkaOxGN34xAwEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ97SljbJaMQ9qgjRW7DsOVgeSumgG4Fq0aRLVj5VxxsDI3xCsG/CXr2TfwYO1FeIqLBJvXDub7V+YS8Oj/H+NjkOK9Ipcdz/qDwxL3FemlLq5riKO4EDBNV6Y26DXWZNTNSTYdklsyfBFQayJc5w5ZLd1sPdBkd0FJzQ++NVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhyazrkp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957530; x=1740493530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hEPEnqkJOil/jP3cx9hGmK0SGdKV4rkaOxGN34xAwEM=;
  b=bhyazrkpRk0MJTAgJoxSrU4K3lrfPZSJUXKVumFeuXASHMpwl6z/vLgB
   TQe+JvXGvy8ATM+1DnteGgOQ8hYI2NFKa+71U1RQsFvVCpvxaiJZVee7/
   MhYrE/iZl28vqM7q4f6dn+nHu8WwXLKnEhQDU415JVCBx2ZZaFFqNd8eR
   TgtsK7LG/Er9B72wit8KhbfqXltkGXbOZN0wavtxg8eCIwYc9CYwQO0lR
   URB78Kosae0BnocluZX3OpeCtTUOB/15vNPr9t0oV4mx4YoC34IcNu7gF
   OsXdnp7O6EnuxEhoSqkDm59OO/phtHZPIPf3zqbfPGOKwkQ+0Py562xJD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3375162"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3375162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937030143"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937030143"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 06:25:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4E49F4D7; Mon, 26 Feb 2024 16:25:16 +0200 (EET)
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
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 06/14] serial: 8250_bcm7271: Switch to use uart_read_port_properties()
Date: Mon, 26 Feb 2024 16:19:22 +0200
Message-ID: <20240226142514.1485246-7-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 56 +++++++++-----------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 1532fa2e8ec4..83ecf18fcf3e 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -935,17 +935,14 @@ static void brcmuart_init_debugfs(struct brcmuart_priv *priv,
 static int brcmuart_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
-	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id = NULL;
 	struct uart_8250_port *new_port;
 	struct device *dev = &pdev->dev;
 	struct brcmuart_priv *priv;
 	struct clk *baud_mux_clk;
 	struct uart_8250_port up;
-	int irq;
 	void __iomem *membase = NULL;
 	resource_size_t mapbase = 0;
-	u32 clk_rate = 0;
 	int ret;
 	int x;
 	int dma_irq;
@@ -953,15 +950,12 @@ static int brcmuart_probe(struct platform_device *pdev)
 		"uart", "dma_rx", "dma_tx", "dma_intr2", "dma_arb"
 	};
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
 	priv = devm_kzalloc(dev, sizeof(struct brcmuart_priv),
 			GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	of_id = of_match_node(brcmuart_dt_ids, np);
+	of_id = of_match_node(brcmuart_dt_ids, dev->of_node);
 	if (!of_id || !of_id->data)
 		priv->rate_table = brcmstb_rate_table;
 	else
@@ -1011,7 +1005,23 @@ static int brcmuart_probe(struct platform_device *pdev)
 		}
 	}
 
-	of_property_read_u32(np, "clock-frequency", &clk_rate);
+	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
+
+	memset(&up, 0, sizeof(up));
+	up.port.type = PORT_BCM7271;
+	up.port.dev = dev;
+	up.port.mapbase = mapbase;
+	up.port.membase = membase;
+	up.port.handle_irq = brcmuart_handle_irq;
+	up.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	up.port.private_data = priv;
+
+	ret = uart_read_port_properties(&up.port, true);
+	if (ret)
+		goto release_dma;
+
+	up.port.regshift = 2;
+	up.port.iotype = device_is_big_endian(dev) ? UPIO_MEM32BE : UPIO_MEM32;
 
 	/* See if a Baud clock has been specified */
 	baud_mux_clk = devm_clk_get_optional_enabled(dev, "sw_baud");
@@ -1023,39 +1033,11 @@ static int brcmuart_probe(struct platform_device *pdev)
 
 		priv->baud_mux_clk = baud_mux_clk;
 		init_real_clk_rates(dev, priv);
-		clk_rate = priv->default_mux_rate;
+		up.port.uartclk = priv->default_mux_rate;
 	} else {
 		dev_dbg(dev, "BAUD MUX clock not specified\n");
 	}
 
-	if (clk_rate == 0) {
-		ret = dev_err_probe(dev, -EINVAL, "clock-frequency or clk not defined\n");
-		goto release_dma;
-	}
-
-	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
-
-	memset(&up, 0, sizeof(up));
-	up.port.type = PORT_BCM7271;
-	up.port.uartclk = clk_rate;
-	up.port.dev = dev;
-	up.port.mapbase = mapbase;
-	up.port.membase = membase;
-	up.port.irq = irq;
-	up.port.handle_irq = brcmuart_handle_irq;
-	up.port.regshift = 2;
-	up.port.iotype = of_device_is_big_endian(np) ?
-		UPIO_MEM32BE : UPIO_MEM32;
-	up.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
-		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
-	up.port.dev = dev;
-	up.port.private_data = priv;
-
-	/* Check for a fixed line number */
-	ret = of_alias_get_id(np, "serial");
-	if (ret >= 0)
-		up.port.line = ret;
-
 	/* setup HR timer */
 	hrtimer_init(&priv->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	priv->hrt.function = brcmuart_hrtimer_func;
-- 
2.43.0.rc1.1.gbec44491f096


