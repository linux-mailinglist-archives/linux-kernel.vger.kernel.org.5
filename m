Return-Path: <linux-kernel+bounces-75313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69085E666
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34330287432
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136112880B;
	Wed, 21 Feb 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kw0c2dqu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4F126F29;
	Wed, 21 Feb 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540509; cv=none; b=Zxj3eacP6JjE/RG65ReMvoafJ2f8efVnSOrp8KBPxARLy73iMxK+2pM4GDB8iPdZ8ZNQXT0uKtqFEPPbPQUJmDav8X7no5NTc54EnGNMrj23XyfdiEgDrJBUdUbkZrbodut4zc9mTKHaUQvUt68imkjA8/5++yymGrj8FB9X3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540509; c=relaxed/simple;
	bh=x0OGDwF7erFFwXirCEnUP9h+wCzGSEhdgN5rCP6VdCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOZow7K87avdTOj4KtN14BQoBwEQ1gQPsAXX4yhAAhRTkJfwLzvmn+UCcK6S/5lier+agjmwlS3tuCbz1M5Yhb7dHjj0w9HW3y/nDRQd+fwEP7j41l+nq0R44nmrqiHxbmIu/sh3htdPgtE0e7Ufx8Pn7bedZcycQAp+LG/5UZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kw0c2dqu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540507; x=1740076507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0OGDwF7erFFwXirCEnUP9h+wCzGSEhdgN5rCP6VdCA=;
  b=kw0c2dqujQ3wAj5d7+KryV+29oVyQDHUq5jWgKdBs5BpBQ92zVV/xFpy
   AxcwlRxA+RO+pNNuWCHGhRqcFUZOoERm0x0eD3JGHsEaz5rY79S0ok8gI
   LOCqmQSK+3cRwv1AfNH02WB7TV9YHXHKWTrZDVfLrd9RvhtpsxcTlB7lq
   aBrQJWq2CVmih8H54aKAqnIr3hJoRi7p5m4C/s35Gcm4uuZUcYH234/w9
   I1fnoAhu3QunZoCvQgN21H8cnVhvkI06R/rCgw7ahdkcMyoXI4Zl4ZOg7
   c0PX+zOjt93nr6ybCMqjZW1svAYM8hzz4ebIH7cH4ApjdN9ZHbFaDVb2n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164874"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164874"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684756"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684756"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5F21880C; Wed, 21 Feb 2024 20:34:47 +0200 (EET)
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
Subject: [PATCH v1 11/14] serial: 8250_omap: Switch to use uart_read_port_properties()
Date: Wed, 21 Feb 2024 20:31:27 +0200
Message-ID: <20240221183442.4124354-12-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_omap.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6942990a333c..173af575a43e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1394,11 +1394,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	struct uart_8250_port up;
 	struct resource *regs;
 	void __iomem *membase;
-	int irq, ret;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	int ret;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -1419,7 +1415,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.dev = &pdev->dev;
 	up.port.mapbase = regs->start;
 	up.port.membase = membase;
-	up.port.irq = irq;
 	/*
 	 * It claims to be 16C750 compatible however it is a little different.
 	 * It has EFR and has no FCR7_64byte bit. The AFE (which it claims to
@@ -1429,13 +1424,9 @@ static int omap8250_probe(struct platform_device *pdev)
 	 * or pm callback.
 	 */
 	up.port.type = PORT_8250;
-	up.port.iotype = UPIO_MEM;
-	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SOFT_FLOW |
-		UPF_HARD_FLOW;
+	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SOFT_FLOW | UPF_HARD_FLOW;
 	up.port.private_data = priv;
 
-	up.port.regshift = OMAP_UART_REGSHIFT;
-	up.port.fifosize = 64;
 	up.tx_loadsz = 64;
 	up.capabilities = UART_CAP_FIFO;
 #ifdef CONFIG_PM
@@ -1461,14 +1452,14 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.rs485_stop_tx = serial8250_em485_stop_tx;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
-	ret = of_alias_get_id(np, "serial");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get alias\n");
+	ret = uart_read_port_properties(&up.port, true);
+	if (ret)
 		return ret;
-	}
-	up.port.line = ret;
 
-	if (of_property_read_u32(np, "clock-frequency", &up.port.uartclk)) {
+	up.port.regshift = OMAP_UART_REGSHIFT;
+	up.port.fifosize = 64;
+
+	if (!up.port.uartclk) {
 		struct clk *clk;
 
 		clk = devm_clk_get(&pdev->dev, NULL);
@@ -1560,8 +1551,8 @@ static int omap8250_probe(struct platform_device *pdev)
 	}
 #endif
 
-	irq_set_status_flags(irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(&pdev->dev, irq, omap8250_irq, 0,
+	irq_set_status_flags(up.port.irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(&pdev->dev, up.port.irq, omap8250_irq, 0,
 			       dev_name(&pdev->dev), priv);
 	if (ret < 0)
 		return ret;
-- 
2.43.0.rc1.1.gbec44491f096


