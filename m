Return-Path: <linux-kernel+bounces-75308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0B985E64A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE501F25FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A486AEE;
	Wed, 21 Feb 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPIScU2W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B48663E;
	Wed, 21 Feb 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540504; cv=none; b=nODZbHfXbOjlM/NHWJPXOKADqTFZuExM8RvTZ7Kipz5Pmc+vCoT8qphoHVgauqv9bduXFGtc9iImLhOEOzQ41Vq/F1f+h/80h7PJTYJhgWeyCBe7lV24EUG+aqisvbA14RwC/MqxSE9kJTq09M4/Xul8HqMmGop2kxQXLHvGovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540504; c=relaxed/simple;
	bh=4UcL4BkrrA48FaRG5BWoOyofknmODC7RJONPDVqFX3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2k5LKO0fk5A5Ym2C6WCGIrhnQCzbhbCp9OvmhFA2iJsZg/DszxKu2QCv1zVVzcVXfWwf1A/5o8GQRqO9dvPYq9vd4/gDkOK5M8G9yubJ0NEbttkBQhIlnihjcVAIS6x4UwaC+oF/jLqwJWNg2cqOmMxpJis4PTnewKOZcx+xes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPIScU2W; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540503; x=1740076503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4UcL4BkrrA48FaRG5BWoOyofknmODC7RJONPDVqFX3k=;
  b=MPIScU2Wd1m1pcRA1qVMqcAAkPqf3uaCq3jNCigHuMngwCl8lqtkSUGT
   JJKgp1VKzaivbxKvRGR6C7nf7B3318Lt+LsFgH6ZcEH2QWAHtWoN6KmiL
   SFotq72eJdvPVxjJq6TJlF5kZ8/RurS462HuZunyzPl+IMNkixifhx1eZ
   I4iZ6MrbXiy0NGNs21ZGXQ2JHOd+82lMZfaVxOgo0Z3YmdYSGU11VhF4n
   TzKo15Cq036j+2ijU1E9MA+Xpwp2Iy1xavMoVxPTJtixoa/umX2LIVjZe
   66EOKYvoyzYayb5i/l82oi3B+PXDt5SzlVt4eFczjOnIfFpueAnRVISZz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164755"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:35:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684750"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684750"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1A0CF49C; Wed, 21 Feb 2024 20:34:47 +0200 (EET)
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
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v1 06/14] serial: 8250_bcm7271: Switch to use uart_read_port_properties()
Date: Wed, 21 Feb 2024 20:31:22 +0200
Message-ID: <20240221183442.4124354-7-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 53 +++++++++-----------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 1532fa2e8ec4..5a25e78857f7 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -942,10 +942,8 @@ static int brcmuart_probe(struct platform_device *pdev)
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
@@ -953,9 +951,6 @@ static int brcmuart_probe(struct platform_device *pdev)
 		"uart", "dma_rx", "dma_tx", "dma_intr2", "dma_arb"
 	};
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
 	priv = devm_kzalloc(dev, sizeof(struct brcmuart_priv),
 			GFP_KERNEL);
 	if (!priv)
@@ -1011,7 +1006,23 @@ static int brcmuart_probe(struct platform_device *pdev)
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
@@ -1023,39 +1034,11 @@ static int brcmuart_probe(struct platform_device *pdev)
 
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


