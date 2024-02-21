Return-Path: <linux-kernel+bounces-75316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5187285E66E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031591F26CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA27812A16C;
	Wed, 21 Feb 2024 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="it1Z93eI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31215127B64;
	Wed, 21 Feb 2024 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540513; cv=none; b=iXMOKHbPLiDfbI/elNdX39Mhd1Yw+vC0M2EOvLiY0N4mecgn1f07KOFyA0I/WHSAbEdds68KTbdgVB6E4fbhNLHmu0fmIzULEZ3HR8EUgDY9PU4DuDiyx0Ojazp+LJerSX44DWgqNLziD8rfoEgB5Usq//7GO6BLGNGWRl8OtdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540513; c=relaxed/simple;
	bh=KeTPJX3iP5rGOV/714NN6qjfj4XXg/FxlTFlGOhpEw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwdpV7F5VY8yfvGnnzLpmv00r1tea6uBjRWqaPckuat8R1zDQ2Gv7mEdpAk+v6ryeMQd4KYzY0W+Z7yZIAsxLRnuOwfTXYxIlHkZ6HwPdNFmzF2M06N7fvhg0Hbqc2paA+0QHr5chntgVbxW9iapAG9lw3LD5eNzse5E9DfAWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=it1Z93eI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540511; x=1740076511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KeTPJX3iP5rGOV/714NN6qjfj4XXg/FxlTFlGOhpEw4=;
  b=it1Z93eInyys6gDKjfkhsKwZ+FKyTK6lrJXKnU1wnBflF2j0rqFVm79y
   d9RrIRYZ2Sk7XbMk8xg6o87lDj1IMzA0fPIr7oVC8/qRofI24NxxlMtZf
   T/WRfJuXgm7tIDh1cIk0PRTJv191GXSAJhqhXrDD2XtH5UPP8dzDcymSV
   9dGwICa6YaecPr57NFN5LBvhjuR4aic49TRfPkWVEz2qQFrBn4qynSzFH
   IAS4r9S4e0eFtrr9Hc6ISalAlDgRB0+pEDlf4dNDn7IPz6+RNapGoUYem
   LQ6FJFB6UFZEfhUH+QKPOW7+jgktZsLlIkXkfpcsuvAftBiSTyZDvlRvL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164878"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164878"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684755"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684755"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 43015570; Wed, 21 Feb 2024 20:34:47 +0200 (EET)
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
Subject: [PATCH v1 09/14] serial: 8250_lpc18xx: Switch to use uart_read_port_properties()
Date: Wed, 21 Feb 2024 20:31:25 +0200
Message-ID: <20240221183442.4124354-10-andriy.shevchenko@linux.intel.com>
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


