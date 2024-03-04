Return-Path: <linux-kernel+bounces-90572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F5A870175
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31591F247EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F53FB0A;
	Mon,  4 Mar 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuMqMfug"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201827702;
	Mon,  4 Mar 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555453; cv=none; b=EEpoewB0FcWPDbKM1WE5UjYEFLhMGgXXeFYsxOWMi8Pvj8eQbgFNP9P7bTV3GUnMMcIeIEj+9HyXSKXcYMuKXmwYi5rNakZMXR48DQchxva77DcpQFiexaaFt0ZP67/GC50Ut6y1i6Qh0Y/nxS9gOYivOvhYBeE0RJAMGrvqi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555453; c=relaxed/simple;
	bh=nVEDA7ZUIo9sof6a5P5qPlQ65k7G7XcDNwxgT3ojRHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVQsaSR752geNd0+023wLc3k6JtKc8b7nnsR1QS2ypRHLMD35mR81iV/qZmdl3HTu8zEgzWTaKM1MOsHaDRtq71p+Z9IqvJwr0ptttd4Rc8AYCZf/NQ7VtDTliLGsGnunTJcOselLUjLMf50KcAsvYEtSk72DRX/CRw8ZOKY2N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuMqMfug; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555451; x=1741091451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nVEDA7ZUIo9sof6a5P5qPlQ65k7G7XcDNwxgT3ojRHI=;
  b=iuMqMfuglYxfwwqjh5xeViEShZV4s3oyHfs0t+s2l2wFjRV40HEGFjku
   /SXlCnhm2aaxVaLpX+Ootw96UJchxSck85nFmtiS838z0X/Ac+nfEwwLT
   juQlKuUnOOBPKmuSpfUZL1wudD3gqF+RM7oX1phPvpTOBtfzc++0x8sjy
   FNteX5VqpX5lQJWwdJ7wnomC2WIb+8WbEC9aPlTl5aqtylVIvF2t6o9/R
   5Qyy32Oytw53lm4HxYBlBNXTuZbIGQXHJ8PAjfLIcXsDk4DSGZQwqY00q
   S0BVCPwmHgaAvfe9Xos3czcJYDHeKfB4GJIMi4um6NBSNX8TK34PrYTeB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815114"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815114"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040426"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040426"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 73BFF697; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
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
Subject: [PATCH v3 05/14] serial: 8250_bcm2835aux: Switch to use uart_read_port_properties()
Date: Mon,  4 Mar 2024 14:27:06 +0200
Message-ID: <20240304123035.758700-6-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 92 +++++++++++------------
 1 file changed, 42 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index beac6b340ace..121a5ce86050 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -45,10 +45,6 @@ struct bcm2835aux_data {
 	u32 cntl;
 };
 
-struct bcm2835_aux_serial_driver_data {
-	resource_size_t offset;
-};
-
 static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
 {
 	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
@@ -85,10 +81,9 @@ static void bcm2835aux_rs485_stop_tx(struct uart_8250_port *up)
 
 static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
-	const struct bcm2835_aux_serial_driver_data *bcm_data;
+	const struct software_node *bcm2835_swnode;
 	struct uart_8250_port up = { };
 	struct bcm2835aux_data *data;
-	resource_size_t offset = 0;
 	struct resource *res;
 	unsigned int uartclk;
 	int ret;
@@ -101,12 +96,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	/* initialize data */
 	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
 	up.port.dev = &pdev->dev;
-	up.port.regshift = 2;
 	up.port.type = PORT_16550;
-	up.port.iotype = UPIO_MEM;
-	up.port.fifosize = 8;
-	up.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE |
-			UPF_SKIP_TEST | UPF_IOREMAP;
+	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST | UPF_IOREMAP;
 	up.port.rs485_config = serial8250_em485_config;
 	up.port.rs485_supported = serial8250_em485_supported;
 	up.rs485_start_tx = bcm2835aux_rs485_start_tx;
@@ -122,12 +113,6 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
 
-	/* get the interrupt */
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
-	up.port.irq = ret;
-
 	/* map the main registers */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -135,52 +120,40 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	bcm_data = device_get_match_data(&pdev->dev);
+	up.port.mapbase = res->start;
+	up.port.mapsize = resource_size(res);
 
-	/* Some UEFI implementations (e.g. tianocore/edk2 for the Raspberry Pi)
-	 * describe the miniuart with a base address that encompasses the auxiliary
-	 * registers shared between the miniuart and spi.
-	 *
-	 * This is due to historical reasons, see discussion here :
-	 * https://edk2.groups.io/g/devel/topic/87501357#84349
-	 *
-	 * We need to add the offset between the miniuart and auxiliary
-	 * registers to get the real miniuart base address.
-	 */
-	if (bcm_data)
-		offset = bcm_data->offset;
+	bcm2835_swnode = device_get_match_data(&pdev->dev);
+	if (bcm2835_swnode) {
+		ret = device_add_software_node(&pdev->dev, bcm2835_swnode);
+		if (ret)
+			return ret;
+	}
 
-	up.port.mapbase = res->start + offset;
-	up.port.mapsize = resource_size(res) - offset;
+	ret = uart_read_port_properties(&up.port);
+	if (ret)
+		goto rm_swnode;
 
-	/* Check for a fixed line number */
-	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret >= 0)
-		up.port.line = ret;
+	up.port.regshift = 2;
+	up.port.fifosize = 8;
 
 	/* enable the clock as a last step */
 	ret = clk_prepare_enable(data->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to enable uart clock - %d\n",
-			ret);
-		return ret;
+		dev_err_probe(&pdev->dev, ret, "unable to enable uart clock\n");
+		goto rm_swnode;
 	}
 
 	uartclk = clk_get_rate(data->clk);
-	if (!uartclk) {
-		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &uartclk);
-		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "could not get clk rate\n");
-			goto dis_clk;
-		}
-	}
+	if (uartclk)
+		up.port.uartclk = uartclk;
 
 	/* the HW-clock divider for bcm2835aux is 8,
 	 * but 8250 expects a divider of 16,
 	 * so we have to multiply the actual clock by 2
 	 * to get identical baudrates.
 	 */
-	up.port.uartclk = uartclk * 2;
+	up.port.uartclk *= 2;
 
 	/* register the port */
 	ret = serial8250_register_8250_port(&up);
@@ -194,6 +167,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 dis_clk:
 	clk_disable_unprepare(data->clk);
+rm_swnode:
+	device_remove_software_node(&pdev->dev);
 	return ret;
 }
 
@@ -203,10 +178,27 @@ static void bcm2835aux_serial_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(data->line);
 	clk_disable_unprepare(data->clk);
+	device_remove_software_node(&pdev->dev);
 }
 
-static const struct bcm2835_aux_serial_driver_data bcm2835_acpi_data = {
-	.offset = 0x40,
+/*
+ * Some UEFI implementations (e.g. tianocore/edk2 for the Raspberry Pi)
+ * describe the miniuart with a base address that encompasses the auxiliary
+ * registers shared between the miniuart and spi.
+ *
+ * This is due to historical reasons, see discussion here:
+ * https://edk2.groups.io/g/devel/topic/87501357#84349
+ *
+ * We need to add the offset between the miniuart and auxiliary registers
+ * to get the real miniuart base address.
+ */
+static const struct property_entry bcm2835_acpi_properties[] = {
+	PROPERTY_ENTRY_U32("reg-offset", 0x40),
+	{ }
+};
+
+static const struct software_node bcm2835_acpi_node = {
+	.properties = bcm2835_acpi_properties,
 };
 
 static const struct of_device_id bcm2835aux_serial_match[] = {
@@ -216,7 +208,7 @@ static const struct of_device_id bcm2835aux_serial_match[] = {
 MODULE_DEVICE_TABLE(of, bcm2835aux_serial_match);
 
 static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
-	{ "BCM2836", (kernel_ulong_t)&bcm2835_acpi_data },
+	{ "BCM2836", (kernel_ulong_t)&bcm2835_acpi_node },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
-- 
2.43.0.rc1.1.gbec44491f096


