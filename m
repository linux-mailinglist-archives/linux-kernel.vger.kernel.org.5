Return-Path: <linux-kernel+bounces-90576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31199870184
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8D2288DC3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC9045C08;
	Mon,  4 Mar 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDO8QnqF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474083D0C2;
	Mon,  4 Mar 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555456; cv=none; b=gxtrL896bJynmffFpEvVjfbheZECqGUpSut7W5j+hs0KIHZGo66wwNrpT+XPpUYE3esF8VO0Ahs7pdOtBblQQSDyllI2FaM8/DzHF3wAQ9igzdgplR/ACab4R9wXmP+GxS2M/Sojy9xy7NyW34eLDF05ei4Lbw1h8/sv7qXos8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555456; c=relaxed/simple;
	bh=Vh79SKc7Xot2gwdWX8j3CI/Ule7vHc6mMwS3nDowqaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he0v4pAOjD4JWWyZNWfu2jV6ZPQhuQ/sCGIPY6lgTj1gGx8ygiULbTms+hhX2dVZO2Nmvv6CH66gSxbqbpY4NvYq9EJKVZqQxURMdkf5jgQW0zGqi9tND/Wj5Bb6WH6jOqIK7ESPc5sLK+RBgYbgdHmisRl2DosxJ5tOYMj3M8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDO8QnqF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555454; x=1741091454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vh79SKc7Xot2gwdWX8j3CI/Ule7vHc6mMwS3nDowqaI=;
  b=nDO8QnqFiIJjNEjtGj0VtnNAbvYFQ1fDiDTJXde2Ii4MSrhOqtxLZLb4
   QkGo3pymjfxT/9EV9UUbxlBmyhHdzQXdL0ELE55nhIcAhEFz7C2wD/Rki
   tFwIGdfuEWm/3slQH+zlq12W4tSpo0VaAd8ZxzM3k6ytIY5WOoiSqqjHP
   zhA+G9UNP57sa+ViMnX5i1elEFNISOyG9thlZysh4feIppeWaNjXFS6kD
   GeUs2ATjqhSgdTOUea9y1+TOavrSG9gFD95vF7TKAVHSXvIBCIYw3+vIc
   nTJDUNtLMnEC9inB2VbdNoSIcKQQ8RYPEP7TGqPShWD0PPfJCFN8B8MWq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815189"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040428"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040428"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 89F8674C; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v3 07/14] serial: 8250_dw: Switch to use uart_read_port_properties()
Date: Mon,  4 Mar 2024 14:27:08 +0200
Message-ID: <20240304123035.758700-8-andriy.shevchenko@linux.intel.com>
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

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 67 +++++++++++++------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 062718615944..9ac4be748596 100644
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
+	err = uart_read_port_properties(p);
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


