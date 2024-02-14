Return-Path: <linux-kernel+bounces-65294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05954854ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088202858D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702654BDE;
	Wed, 14 Feb 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQ3gJj7H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD81CABA;
	Wed, 14 Feb 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918617; cv=none; b=IuJ8V84HkDw8Cr/PbJObI6EP6XPHDC6nNZMINAVycqnYJte+NY9zs+BhfSpPOXB6KmoCb0vizABG7iSHjuS9ea0JCl/a8i7N7jWrDFD6bVsL8xBJQXDxYbuHXR52oi8YsuHsa14pxZ2OiL/um6FRWJug2Bp1pNYPFWWKFtUrk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918617; c=relaxed/simple;
	bh=2zSiHcUofHHkfA9c7NZI3mbaPTePHSRW8IdwMe4QS0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awHCTEdRWInwmzgUPCFY1IFFD/piPWaXyWCFRjrWzuGKmy1seZXd/iYHQ4FrOu+nHWGCEdTivuo7Q8tGkNYDkXkrSSYBEq3unYscfljggLuSo1JBlsT1+VbxDPYMCWYcRO/oJ4sOtFlhWq8O22PcrQCF3fT38c4hfIYxWz9RoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQ3gJj7H; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707918615; x=1739454615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2zSiHcUofHHkfA9c7NZI3mbaPTePHSRW8IdwMe4QS0s=;
  b=VQ3gJj7HR63l+c8MAGxNWgdYLLPeDrT4LcS6j+NrpCOvYIWHeVohgs1W
   E667x3W2B121nsy6lmxqyxd7TVxZz1Dghl6JIVjr5COtvsgdkREDzsaJs
   PU+3kX1jUw1//cwe0lvSvDzRINMfSa0g5u9e1EQJmoaYLd2moXjSZL75u
   y6n7WvaGw4GTqwA6EvreReYw43wk0gTgCszacjmjBwVH4xe2mZKy7J2hO
   fe175yQWBsXyKyYoT6B7FORgODVhnVnnwGysrRjCJvOJEUJcAkQhtC6uR
   d7KS+iFPhxmnamogDncNzX6NvYo7uLns/UtazlVcYHuKnBZubZblhxKAK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2104930"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2104930"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 05:50:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935616681"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="935616681"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 05:50:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D3940195; Wed, 14 Feb 2024 15:50:10 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rengarajan S <rengarajan.s@microchip.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_pci1xxxx: Drop quirk from 8250_port
Date: Wed, 14 Feb 2024 15:50:09 +0200
Message-ID: <20240214135009.3299940-1-andriy.shevchenko@linux.intel.com>
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
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 25 ++++++++++++++++++-------
 drivers/tty/serial/8250/8250_port.c     |  6 ------
 2 files changed, 18 insertions(+), 13 deletions(-)

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
index c37905ea3cae..d59dc219c899 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2699,12 +2699,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
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


