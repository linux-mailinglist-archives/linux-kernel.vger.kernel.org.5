Return-Path: <linux-kernel+bounces-81610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2368586784F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1AB1F28A22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF012C55D;
	Mon, 26 Feb 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQTiLaoe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E512C520;
	Mon, 26 Feb 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957533; cv=none; b=JDAkomHfYAt8PRvO8rbmdfM9apEyewJthJ93KSrhgYF7R6m+Ydfa9sbhOjDbaDe3Gz2jdX+jqvZXF1gWFRw0OZrcikwMDOUYd4eKWKHAZWLuRmX1xpINdWcwTtxtC57eaMK+UnPAPrx7LMrqKBTab5sGx0DiojT11oCYrUOwwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957533; c=relaxed/simple;
	bh=KeTPJX3iP5rGOV/714NN6qjfj4XXg/FxlTFlGOhpEw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNpuD+DpCvowYAY8rToedrwFcpd5MncvFIEu/w7e0yyKyom4ZJxj55s5ptTph7+bsNw/51+gFzT3SYa7aM67/PhovIdj7lPd4sMqsa2kLRbPeqOjSOIE8EC0KMo9tkMr9+8PHKtfhUpIJ2fn/TDUkBAbCUTs3hPRkVSw8sBNeCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQTiLaoe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957532; x=1740493532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KeTPJX3iP5rGOV/714NN6qjfj4XXg/FxlTFlGOhpEw4=;
  b=DQTiLaoeTKT0FbAK12eCszOivW0fPVVrp9xFjaxBHZdeFu2EWExeVBeF
   WLM8L1DvTRbJjP4T14AzOB5aa0RL6TI/9d5m9kdI1jHUOof5pP/QivYeL
   rvZmvQhmu0GgEKEzGclhZr+4t+k+hiLcHNtWZHklWFIGl/IpEDTFzXThV
   0Ops4Q4Aaiz2PPVzSOaqbydXV29F5Yhv8yssgdoqlfxfNMowLwFRByc6k
   fX+7cxBSF7muUdzCHcZfvMZegm3kSUhXQFB3B9RncfoHLa2vyZQU2W8IO
   Btwvi3t0uOcGtI8jIJB4vdzkj6vngS8PtN/RnjZaTuUu+yWwu0X/MAqBg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3375197"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3375197"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937030146"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937030146"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 06:25:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 753049AB; Mon, 26 Feb 2024 16:25:16 +0200 (EET)
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
Subject: [PATCH v2 09/14] serial: 8250_lpc18xx: Switch to use uart_read_port_properties()
Date: Mon, 26 Feb 2024 16:19:25 +0200
Message-ID: <20240226142514.1485246-10-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_lpc18xx.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 8d728a6a5991..e4a6b7b4caf2 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -92,11 +92,7 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 	struct lpc18xx_uart_data *data;
 	struct uart_8250_port uart;
 	struct resource *res;
-	int irq, ret;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -139,19 +135,12 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 		goto dis_clk_reg;
 	}
 
-	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret >= 0)
-		uart.port.line = ret;
-
 	data->dma.rx_param = data;
 	data->dma.tx_param = data;
 
 	spin_lock_init(&uart.port.lock);
 	uart.port.dev = &pdev->dev;
-	uart.port.irq = irq;
-	uart.port.iotype = UPIO_MEM32;
 	uart.port.mapbase = res->start;
-	uart.port.regshift = 2;
 	uart.port.type = PORT_16550A;
 	uart.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST;
 	uart.port.uartclk = clk_get_rate(data->clk_uart);
@@ -160,6 +149,13 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 	uart.port.rs485_supported = lpc18xx_rs485_supported;
 	uart.port.serial_out = lpc18xx_uart_serial_out;
 
+	ret = uart_read_port_properties(&uart.port, true);
+	if (ret)
+		return ret;
+
+	uart.port.iotype = UPIO_MEM32;
+	uart.port.regshift = 2;
+
 	uart.dma = &data->dma;
 	uart.dma->rxconf.src_maxburst = 1;
 	uart.dma->txconf.dst_maxburst = 1;
-- 
2.43.0.rc1.1.gbec44491f096


