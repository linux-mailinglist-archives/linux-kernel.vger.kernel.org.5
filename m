Return-Path: <linux-kernel+bounces-81613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C6686785B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7520BB2501D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC55B12CDA3;
	Mon, 26 Feb 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVEan7FK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442012C54B;
	Mon, 26 Feb 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957534; cv=none; b=tq89XixmFl3nBfcieJlj79mRi7zqGWgLPNgZYeKKMWQI3ZXm2zo/8X74+CAHNZJ1aVrtKdVZbBo+qTcHRiyBBnnQqlv7HN3jn4JwMvvnDXbqbAHqtPBCJqpB7LKbX8q8yOqWOcguc6d6+TaLsJi0tPYr2A9nW4zjf4iLj6WrOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957534; c=relaxed/simple;
	bh=x0OGDwF7erFFwXirCEnUP9h+wCzGSEhdgN5rCP6VdCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD9DT4VKXXzPDh6mLcxajuXoE3hMOBhg4hfGvQVShvHsDR9Gk+Xl/HMewSWTUaaC/BxgxxvK+VwS0fQnEUmKVo2DFXRNdRGJBLbgfLsND22tBuOR6asaN7VYxxkNTRr7290bljePDkwIOIxskDGmeVBUuZMxQwT8HBQDLZTtEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVEan7FK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957534; x=1740493534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0OGDwF7erFFwXirCEnUP9h+wCzGSEhdgN5rCP6VdCA=;
  b=mVEan7FKIoMWMSREmnExAweA6eMFFgS2+3eooxvv5dYDhgQ0TeTV1weM
   SUiYkNoZqwt8DDW2NnQ+b4Wn72fOcVMTy5oh+ZaLYWT4KHGAMnv6iSjL3
   wSmkz3n8m9Xh0tClfEPnSXWx+RjVjv0UqPtGJRZAQRn0VYsA0OaiBeNQ0
   Tk30R/xTvFjIOJL6lur1+DCCnj7zeTkRmhE8Ih1xYMFBpjj6GLu6O0Hwr
   ijgTqckXMPAowS1aIYQzlf75LwV4tL3VD2CkNbMVIyyUHIjldr6oOZOpT
   Ryf9itWHuY/w88oK3wMoPdL+d938Xed++BI4rKsgE+YSYBuuJvCgb5Nhi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3375270"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3375270"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:25:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937030148"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937030148"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 06:25:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8A0AA9DB; Mon, 26 Feb 2024 16:25:16 +0200 (EET)
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
Subject: [PATCH v2 11/14] serial: 8250_omap: Switch to use uart_read_port_properties()
Date: Mon, 26 Feb 2024 16:19:27 +0200
Message-ID: <20240226142514.1485246-12-andriy.shevchenko@linux.intel.com>
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


