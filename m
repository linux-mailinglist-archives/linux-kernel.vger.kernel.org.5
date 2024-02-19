Return-Path: <linux-kernel+bounces-71683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E01C85A8F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330A01C20EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF613D99A;
	Mon, 19 Feb 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc5qEz2n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D83D3AE;
	Mon, 19 Feb 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360166; cv=none; b=Igfozwc7NR3P9LDXLLB8bNPzGDCpC0Bt+9JLeQF59hgASNK5gQx3VKNEOCgNb1MvIsVflI+X1rk+/+wHWYlhAZUkag7un6HP2If18HN5b+9/ACF/BDKPI04fCwI2CVZgOvSEzTfLHIClYPVeQIwKbFZ7ElYo4qaikOnRnToT2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360166; c=relaxed/simple;
	bh=W4/kGjT53spVGkI433QKff0LENTori6sITEsXM46mBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FacrgABsLHkZOBFDMgdGXZT/MOCXc8SCJXsn8AFhFAzf+NUnlI5DtLyfNCw46n+Lj58HcXYhPzzBJTqLHH1SvXjE/kof9dSoH9kY0D3yIuUDzwFmQO2+bJ7pt92QEfjFy1PXRSEeLYiOBTNpf+Hdbanx2xizOC0p0tuu/oZs4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc5qEz2n; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708360164; x=1739896164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W4/kGjT53spVGkI433QKff0LENTori6sITEsXM46mBs=;
  b=Sc5qEz2n1gOkEJtGvLhFPJHA8jNxh4SHi0hVi0Z/x66foWbInXejt6Pq
   kiqsM3FNEWIG8IMpGlg4PgGOezEpQOlow5mGqtxMRic2OBSkfuCbBF/01
   H8NGkveKe4on2vPkiMhbQWv/BON9FysO0P4AQ6Q4vXq6S+3yog09WPeBT
   lxA2daNNhpmQJCW7RsXGzdEFxsqu0g+t5DShIMqI9/oyS8hYbGrkR4hqs
   R+WIcGgMkxd9MDNuNSKyFMc2NDvvZvqFJZsY0OMEKnpRJNIeq5cYAyE6l
   qXANm6A8KAw+Iprs2kl2/cW6EFPFsTeUFtwshwkopKUIJxahMV7tNMHPo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="12995340"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="12995340"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 08:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="827022505"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="827022505"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2024 08:29:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5E79E305; Mon, 19 Feb 2024 18:29:20 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rengarajan S <rengarajan.s@microchip.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] serial: 8250_pci1xxxx: Drop quirk from 8250_port
Date: Mon, 19 Feb 2024 18:28:34 +0200
Message-ID: <20240219162917.2159736-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are not supposed to spread quirks in 8250_port module especially
when we have a separate driver for the hardware in question.

Move quirk from generic module to the driver that uses it.

While at it, move IO to ->set_divisor() callback as it has to be from
day 1. ->get_divisor() is not supposed to perform any IO as UART port:
- might not be powered on
- is not locked by a spin lock

Fixes: 1ed67ecd1349 ("8250: microchip: Add 4 Mbps support in PCI1XXXX UART")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rengarajan S <rengarajan.s@microchip.com>
---
v2: fixed compile warning (Greg), added tag (Rengarajan)
 drivers/tty/serial/8250/8250_pci1xxxx.c | 25 ++++++++++++++++++-------
 drivers/tty/serial/8250/8250_port.c     |  7 -------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 55eada1dba56..2fbb5851f788 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -94,7 +94,6 @@
 #define UART_BIT_SAMPLE_CNT_16			16
 #define BAUD_CLOCK_DIV_INT_MSK			GENMASK(31, 8)
 #define ADCL_CFG_RTS_DELAY_MASK			GENMASK(11, 8)
-#define UART_CLOCK_DEFAULT			(62500 * HZ_PER_KHZ)
 
 #define UART_WAKE_REG				0x8C
 #define UART_WAKE_MASK_REG			0x90
@@ -227,13 +226,10 @@ static unsigned int pci1xxxx_get_divisor(struct uart_port *port,
 	unsigned int uart_sample_cnt;
 	unsigned int quot;
 
-	if (baud >= UART_BAUD_4MBPS) {
+	if (baud >= UART_BAUD_4MBPS)
 		uart_sample_cnt = UART_BIT_SAMPLE_CNT_8;
-		writel(UART_BIT_DIVISOR_8, (port->membase + FRAC_DIV_CFG_REG));
-	} else {
+	else
 		uart_sample_cnt = UART_BIT_SAMPLE_CNT_16;
-		writel(UART_BIT_DIVISOR_16, (port->membase + FRAC_DIV_CFG_REG));
-	}
 
 	/*
 	 * Calculate baud rate sampling period in nanoseconds.
@@ -249,6 +245,11 @@ static unsigned int pci1xxxx_get_divisor(struct uart_port *port,
 static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
 				 unsigned int quot, unsigned int frac)
 {
+	if (baud >= UART_BAUD_4MBPS)
+		writel(UART_BIT_DIVISOR_8, port->membase + FRAC_DIV_CFG_REG);
+	else
+		writel(UART_BIT_DIVISOR_16, port->membase + FRAC_DIV_CFG_REG);
+
 	writel(FIELD_PREP(BAUD_CLOCK_DIV_INT_MSK, quot) | frac,
 	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
 }
@@ -619,6 +620,17 @@ static int pci1xxxx_setup(struct pci_dev *pdev,
 
 	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
 	port->port.type = PORT_MCHP16550A;
+	/*
+	 * 8250 core considers prescaller value to be always 16.
+	 * The MCHP ports support downscaled mode and hence the
+	 * functional UART clock can be lower, i.e. 62.5MHz, than
+	 * software expects in order to support higher baud rates.
+	 * Assign here 64MHz to support 4Mbps.
+	 *
+	 * The value itself is not really used anywhere except baud
+	 * rate calculations, so we can mangle it as we wish.
+	 */
+	port->port.uartclk = 64 * HZ_PER_MHZ;
 	port->port.set_termios = serial8250_do_set_termios;
 	port->port.get_divisor = pci1xxxx_get_divisor;
 	port->port.set_divisor = pci1xxxx_set_divisor;
@@ -732,7 +744,6 @@ static int pci1xxxx_serial_probe(struct pci_dev *pdev,
 
 	memset(&uart, 0, sizeof(uart));
 	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT;
-	uart.port.uartclk = UART_CLOCK_DEFAULT;
 	uart.port.dev = dev;
 
 	if (num_vectors == max_vec_reqd)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 86c22f22e7a9..56a137603dea 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2620,7 +2620,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 					     struct ktermios *termios,
 					     const struct ktermios *old)
 {
-	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int tolerance = port->uartclk / 100;
 	unsigned int min;
 	unsigned int max;
@@ -2638,12 +2637,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 		max = (port->uartclk + tolerance) / 16;
 	}
 
-	/*
-	 * Microchip PCI1XXXX UART supports maximum baud rate up to 4 Mbps
-	 */
-	if (up->port.type == PORT_MCHP16550A)
-		max = 4000000;
-
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 * Allow 1% tolerance at the upper limit so uart clks marginally
-- 
2.43.0.rc1.1.gbec44491f096


