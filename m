Return-Path: <linux-kernel+bounces-75309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D9B85E64F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A8E1C244FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821938562A;
	Wed, 21 Feb 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZRtpxBX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD185276;
	Wed, 21 Feb 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540505; cv=none; b=JBqvfjmOF//NnsEdQD8tIYC9lgNVqBqWxZXqcUYpzTcUgsf1R7V0SIYudRitlvB/wVovGpmfdKe6X0HlnpCUz4z2lcLIn/Nc5iPF/LwutRGnsIraH74SrLCyou9BEjTSi7VOrni0Y8rN58HfzeMLx9la2B4oRRjpk+2EyoE/xoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540505; c=relaxed/simple;
	bh=n8M+Zxd5EsI5el7vSlKXZtzNU2WwNtafBo9TBX3vAmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgA1bbVqlAJy0l73cWWib5Hp189AQ3Dlud0RmwaWQ1NTxXE6MOD/PrY/UUkA8UMQSt7KDdANZty+um4xuYJO5OzJ6uJU/TC2O5upIMINOM5jkG3wKRWpHKLvpjsDc0NYUkzF/+YvGugN7oeIhRWmxiHUycM9kYivwW93LGjSH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZRtpxBX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540504; x=1740076504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8M+Zxd5EsI5el7vSlKXZtzNU2WwNtafBo9TBX3vAmw=;
  b=nZRtpxBX3eh0mu+f/Izy1Eh7lS8FUlYtam4g9S7iDeZndZC9VS5yisTA
   KftP1ZCA8Cc/a5u3g1R8vBpKlfHMPAbbJwjsUT7U53H+BTAbOL51/2c1j
   iJQO6ocSsCx7sbZDhJVzR4zm+fLYNMxJN4O4CTmOICSxKq1xZp/xwfQcm
   3xQVcNSG+P7nQi6OOS7gWrEOg+1R5LBS6FrEiGmXJ3VQpcRehr7wfqcdI
   2t3lfUV1KQ+lAjUGiqVlyrHE2h1qV7rKUdaDOdW/O6qqgwwKg0gwv+asa
   bSBxFkhGgXmIPmEg1NQka3M+HeEdQMG0bQklxjrirfY4AyPYeSh6KwD6V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164772"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164772"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:35:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684752"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684752"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2890D4A5; Wed, 21 Feb 2024 20:34:47 +0200 (EET)
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v1 07/14] serial: 8250_dw: Switch to use uart_read_port_properties()
Date: Wed, 21 Feb 2024 20:31:23 +0200
Message-ID: <20240221183442.4124354-8-andriy.shevchenko@linux.intel.com>
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

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 67 +++++++++++++------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 2d1f350a4bea..a1825e83231f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -17,7 +17,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -449,12 +448,7 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 
 	if (np) {
 		unsigned int quirks = data->pdata->quirks;
-		int id;
 
-		/* get index of serial line, if found in DT aliases */
-		id = of_alias_get_id(np, "serial");
-		if (id >= 0)
-			p->line = id;
 #ifdef CONFIG_64BIT
 		if (quirks & DW_UART_QUIRK_OCTEON) {
 			p->serial_in = dw8250_serial_inq;
@@ -465,12 +459,6 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		}
 #endif
 
-		if (of_device_is_big_endian(np)) {
-			p->iotype = UPIO_MEM32BE;
-			p->serial_in = dw8250_serial_in32be;
-			p->serial_out = dw8250_serial_out32be;
-		}
-
 		if (quirks & DW_UART_QUIRK_ARMADA_38X)
 			p->serial_out = dw8250_serial_out38x;
 		if (quirks & DW_UART_QUIRK_SKIP_SET_RATE)
@@ -510,39 +498,21 @@ static int dw8250_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dw8250_data *data;
 	struct resource *regs;
-	int irq;
 	int err;
-	u32 val;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
 		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
-	irq = platform_get_irq_optional(pdev, 0);
-	/* no interrupt -> fall back to polling */
-	if (irq == -ENXIO)
-		irq = 0;
-	if (irq < 0)
-		return irq;
-
 	spin_lock_init(&p->lock);
-	p->mapbase	= regs->start;
-	p->irq		= irq;
 	p->handle_irq	= dw8250_handle_irq;
 	p->pm		= dw8250_do_pm;
 	p->type		= PORT_8250;
-	p->flags	= UPF_SHARE_IRQ | UPF_FIXED_PORT;
+	p->flags	= UPF_FIXED_PORT;
 	p->dev		= dev;
-	p->iotype	= UPIO_MEM;
-	p->serial_in	= dw8250_serial_in;
-	p->serial_out	= dw8250_serial_out;
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
 
-	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
-	if (!p->membase)
-		return -ENOMEM;
-
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -554,15 +524,35 @@ static int dw8250_probe(struct platform_device *pdev)
 	data->uart_16550_compatible = device_property_read_bool(dev,
 						"snps,uart-16550-compatible");
 
-	err = device_property_read_u32(dev, "reg-shift", &val);
-	if (!err)
-		p->regshift = val;
+	p->mapbase = regs->start;
+	p->mapsize = resource_size(regs);
 
-	err = device_property_read_u32(dev, "reg-io-width", &val);
-	if (!err && val == 4) {
-		p->iotype = UPIO_MEM32;
+	p->membase = devm_ioremap(dev, p->mapbase, p->mapsize);
+	if (!p->membase)
+		return -ENOMEM;
+
+	err = uart_read_port_properties(p, true);
+	/* no interrupt -> fall back to polling */
+	if (err == -ENXIO)
+		err = 0;
+	if (err)
+		return err;
+
+	switch (p->iotype) {
+	case UPIO_MEM:
+		p->serial_in = dw8250_serial_in;
+		p->serial_out = dw8250_serial_out;
+		break;
+	case UPIO_MEM32:
 		p->serial_in = dw8250_serial_in32;
 		p->serial_out = dw8250_serial_out32;
+		break;
+	case UPIO_MEM32BE:
+		p->serial_in = dw8250_serial_in32be;
+		p->serial_out = dw8250_serial_out32be;
+		break;
+	default:
+		return -ENODEV;
 	}
 
 	if (device_property_read_bool(dev, "dcd-override")) {
@@ -589,9 +579,6 @@ static int dw8250_probe(struct platform_device *pdev)
 		data->msr_mask_off |= UART_MSR_TERI;
 	}
 
-	/* Always ask for fixed clock rate from a property. */
-	device_property_read_u32(dev, "clock-frequency", &p->uartclk);
-
 	/* If there is separate baudclk, get the rate from it. */
 	data->clk = devm_clk_get_optional_enabled(dev, "baudclk");
 	if (data->clk == NULL)
-- 
2.43.0.rc1.1.gbec44491f096


