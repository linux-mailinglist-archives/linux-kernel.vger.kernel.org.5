Return-Path: <linux-kernel+bounces-90580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEFE870191
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F8C1C234B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314CB481B3;
	Mon,  4 Mar 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btgO66SW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134D1DFD6;
	Mon,  4 Mar 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555458; cv=none; b=LknKZl/w9JmrTm3TJEAM9vsg4rNym1NZFeEC6FWIyByrCcajq4lNHamVh4pvrhFB9W7AhXpaKLeYzBii4kPiQ63kWjp5x4tmdJbl/eYRiqrMI2PZfj5G1u7uPYwbT7Tq+0NlxHx1+EjpfaMjcZay7L6X63jPBJy0taYJaxMgVdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555458; c=relaxed/simple;
	bh=Ug0+1cJK1qABFIX1u2vFwuq1+scRl5b911mXi0OiA6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1Q8dKir6+je1iSxv815rMCxrshct+Pna4xj0o2TnAmYfh/URnJyw0adVvUQVwJUjKJMhB7Xjlz5iUEGWtoejKczZiT2hVaSkDzUmpcBLaLjWIvZwqZkgYKH8UJVjCNawE1mn7GkVMS/E5ZXrhExE4iTXq6txn0EFPeWdMFriGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btgO66SW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555457; x=1741091457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ug0+1cJK1qABFIX1u2vFwuq1+scRl5b911mXi0OiA6E=;
  b=btgO66SWU7R75f1NA6Np7PWHbaWPwPj4LHe6t4MSURWSRWVWbX2bvS+5
   8LBqpsBTIRZW2PY1PZqsOV4Gvyky6BIVbVlXykOeGFY/9IjtV+XsPdBcc
   jOVAxuQLHOxn4nTbtHGdxNW2QQ2IXZsFX+7XnMnvO/qllvCz+NuL+hXz3
   R0QqWRgTm8nqx/wc36VttavsdSna+M1PFHkerd7m+9lfDzJaIqQTVd9t5
   x4jw21dtzanKluXWnxuC60ezPBUWarM20bjYM8sQYZVhFYVNIwpsKsVyU
   eFdP1ZY4si+ti4LPk1/2aNZS2HvdT6gXvg+BOHHxCTyMl1XfuFIMYRF6Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815203"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815203"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040433"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040433"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BF01A8F6; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
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
Subject: [PATCH v3 11/14] serial: 8250_omap: Switch to use uart_read_port_properties()
Date: Mon,  4 Mar 2024 14:27:12 +0200
Message-ID: <20240304123035.758700-12-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_omap.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6942990a333c..66901d93089a 100644
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
+	ret = uart_read_port_properties(&up.port);
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


