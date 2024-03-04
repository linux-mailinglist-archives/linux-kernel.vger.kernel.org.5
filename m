Return-Path: <linux-kernel+bounces-90573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3126F870176
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8D91F24D2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8413FE2A;
	Mon,  4 Mar 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+UHVpva"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507DC3EA89;
	Mon,  4 Mar 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555454; cv=none; b=bZTHYSijHxsj60Uv53U/LXnEJrwMLH2PkS0fZUMNwpOibOa+Vomt2WRKpEz2RKPbq8+TgxB3BD3gUTmtCdX6StqM09jvUH5Myc8OOvWjKjzND8tHvNo+qJ2g6JG+r481GYmCq+MdmtgAldqabR50N/gN2g6OQFE7RS5aYujbXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555454; c=relaxed/simple;
	bh=ubZP60m5zbrISe9NE/s8BejqJy/fQG65jZvjehiHGZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2vZeaQxSLLKLnfd3ZYLn3VP/hQGTjS/zju602CeSw7iXPXrUrmk8tnCHUbcG5YGvpET0o5jhKVhbVgRq0qO3gG9pXo8ZjhOvrVK+9Df2ABcD3Qsju5hxFxR9qwUPuHn+3loFpXMp2JAAnIIHiKC++ENfvIYBFv8uJqdvXgO0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+UHVpva; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555452; x=1741091452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ubZP60m5zbrISe9NE/s8BejqJy/fQG65jZvjehiHGZw=;
  b=R+UHVpvaT+VpcQchsUXe2HoLL8R3IcSUK6W08vWIUnYkVoERku5wORe3
   KbmS9a/FnyJy4sEzgOJ629KdLIK3zeg/Xqe+ZcrMQdvIOqbEAJwv1EB30
   +UzZcPB8SyU2MOIfM9IhjqyapHqtQLjqUf/b2OFi/Pxca4l+e5JuImRTm
   oahf+H5O7ImJLziaG0a+lOnccTPvO7caO6OF1F3jKFmoANZR8xhPdsF29
   0XWp+M7zD9gghyHbiDYHiJFzTUX/RKEzX62E+5RY86AKi6fOC35AYMsCC
   mnq5DtUfy2i0Dfs1Yos2j75HDsuSHoW/JQNGgi5yn+zZnFFPOxc8DWDXN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815132"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815132"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040430"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040430"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A1B997AF; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
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
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 09/14] serial: 8250_lpc18xx: Switch to use uart_read_port_properties()
Date: Mon,  4 Mar 2024 14:27:10 +0200
Message-ID: <20240304123035.758700-10-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpc18xx.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 8d728a6a5991..7984ee05af1d 100644
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
 
+	ret = uart_read_port_properties(&uart.port);
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


