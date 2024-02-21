Return-Path: <linux-kernel+bounces-75315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF6985E66D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B51A1F26B86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65955129A80;
	Wed, 21 Feb 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMPVGEHn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D31272DB;
	Wed, 21 Feb 2024 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540512; cv=none; b=LV5Nk0whmWVRktIXQ0kwlpq2CyUyHotFNyC9ep+DmqY/tAlgrJGi7fHE52pPehBXXPv02OnqrwU8t/jqxhSES9stZCEExHAk0YAW44V+0OBXOgzbHygaFBQV44ZAY6i1Qf22Dg+JgrQ652WRGvsgduEiB47sRmbiGPYD8Av47DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540512; c=relaxed/simple;
	bh=I4Dp8lscp5MpgtPKkZb6GpVT2AnT2N5Frc+xmVMhCuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6h118kh1n1cO8cl0adoj5qqH53WnRi98Ytk5JlrKAGL9LuIR76amlqfj5rg5YsMpa/ZcoAbbybvJzyISJWmtFrfMZWOoaWYEHc+C5yNKmjggntzqRqCNm4I2oMUhYs7q/pHvAzFtTe4EbBdga2kMxxklsnXK6xYxaJQ/mHABzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMPVGEHn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540510; x=1740076510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I4Dp8lscp5MpgtPKkZb6GpVT2AnT2N5Frc+xmVMhCuw=;
  b=WMPVGEHnWIo36Pt/iYw5+3zdJAS0FNTDuGp/7MNa8RntnkrRmRy7XcIm
   gvO2G3HKzE3P90E361GY+OiFLDlcOvoTucs+18lsKFMnivujfMidLdDCl
   Veal/BkeeJU1Gfu6aeDcGMAXlzLg24IgH/+cWvc0PQ7lF0PRWV/LuQS42
   2+RrbGZ4hM4XoWQoFs6I+08I3jZEXLcf3UvUpyFrpg2Jv8mi9Zg/MxmJW
   t1qoRuZelwp0W07yFtou9xHIXATK0g0AR9qO7zRVJ8yMAleIltS6382PP
   aort0U1NZAcgbGFOBCMI+KQtGAs1lx2OHyeEMk4sswJSvwyEBxvF7/coo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164890"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164890"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684760"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684760"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 79F8C8D2; Wed, 21 Feb 2024 20:34:47 +0200 (EET)
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
Subject: [PATCH v1 13/14] serial: 8250_tegra: Switch to use uart_read_port_properties()
Date: Wed, 21 Feb 2024 20:31:29 +0200
Message-ID: <20240221183442.4124354-14-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_tegra.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index ba352262df75..ce48d02dfa0d 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -57,25 +57,11 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	port = &port8250.port;
 	spin_lock_init(&port->lock);
 
-	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
-		      UPF_FIXED_TYPE;
-	port->iotype = UPIO_MEM32;
-	port->regshift = 2;
+	port->flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	port->type = PORT_TEGRA;
-	port->irqflags |= IRQF_SHARED;
 	port->dev = &pdev->dev;
 	port->handle_break = tegra_uart_handle_break;
 
-	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret >= 0)
-		port->line = ret;
-
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
-
-	port->irq = ret;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
@@ -88,12 +74,18 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	port->mapbase = res->start;
 	port->mapsize = resource_size(res);
 
+	ret = uart_read_port_properties(port, true);
+	if (ret)
+		return ret;
+
+	port->iotype = UPIO_MEM32;
+	port->regshift = 2;
+
 	uart->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(uart->rst))
 		return PTR_ERR(uart->rst);
 
-	if (device_property_read_u32(&pdev->dev, "clock-frequency",
-				     &port->uartclk)) {
+	if (!port->uartclk) {
 		uart->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(uart->clk)) {
 			dev_err(&pdev->dev, "failed to get clock!\n");
-- 
2.43.0.rc1.1.gbec44491f096


