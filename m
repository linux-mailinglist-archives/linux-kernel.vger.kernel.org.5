Return-Path: <linux-kernel+bounces-90574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70382870177
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD6228839E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605543FE5D;
	Mon,  4 Mar 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOJfvzA2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DC3F8D4;
	Mon,  4 Mar 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555454; cv=none; b=o2RlS5F/zsUWySODBZ7wYpCWLmPlDLxaPQJY19MXcTz5XaKUU6YV07jY2eu4g+27lFVbCbcz7xUxWa2zQ3sDfuMY86ljIyIh4abmrqZ7fLnEFKG4Igin97tbh+EUbesf0dDx1nRrsyJTNw2oMVb0yRgnO1bKPdpH2Kq3NHbGY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555454; c=relaxed/simple;
	bh=1/GZYwB2nWuo6C2AG168sBjhMZ3npUtIfk/z9EbJyZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKP4w5QnnF96yaN6oQNHjF0TAzcFSgCcA8PrgCnwV1e2VBILSOXb9Fwz1uPIGKUunRfEm/M4HTbKSVUw8tqX6oEsx8jJvcy4uiVpdJaMQoCsSMfBUD0iNd9SAZqxBK3LWfntaAwpAuklC7DJmwEamL1qTUoWqujQiJOOI3S6QBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOJfvzA2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555453; x=1741091453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1/GZYwB2nWuo6C2AG168sBjhMZ3npUtIfk/z9EbJyZg=;
  b=EOJfvzA2oAS6olVyFI8zkwSUo60bV1MW9mGcRYxkHJQ6iSIrL4DDutb4
   Kri4uG2yPrbAtx/wwB0V4f+902NpflqblVSdI86CPp8teuOQiaA0PzXGz
   ehJMcgOIEJNNEwocQlgpZdionhVPqxfsggAahxGgImhcdRLNSXOnu2h0w
   mOlA7m6NrAchAmJ6sI7qk72oZntAajDG2I4/FUpU/6VFRv2F1UhnJ6tH1
   DqkWHeMCMSRqt1KLtHZBXOmenQaEc25TjuUC0HzHjPrui+PYbTDBGU7kM
   +pUfApMqjdxYkRQl8q4CLRB3fVRHsrpaKnkW/aXCZvDyGZkk43vQN1L99
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815152"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815152"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040429"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040429"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 95B56799; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
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
Subject: [PATCH v3 08/14] serial: 8250_ingenic: Switch to use uart_read_port_properties()
Date: Mon,  4 Mar 2024 14:27:09 +0200
Message-ID: <20240304123035.758700-9-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_ingenic.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index a12f737924c0..a2783e38a2e3 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -234,7 +234,7 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	struct ingenic_uart_data *data;
 	const struct ingenic_uart_config *cdata;
 	struct resource *regs;
-	int irq, err, line;
+	int err;
 
 	cdata = of_device_get_match_data(&pdev->dev);
 	if (!cdata) {
@@ -242,10 +242,6 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
 		dev_err(&pdev->dev, "no registers defined\n");
@@ -259,21 +255,19 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	spin_lock_init(&uart.port.lock);
 	uart.port.type = PORT_16550A;
 	uart.port.flags = UPF_SKIP_TEST | UPF_IOREMAP | UPF_FIXED_TYPE;
-	uart.port.iotype = UPIO_MEM;
 	uart.port.mapbase = regs->start;
-	uart.port.regshift = 2;
 	uart.port.serial_out = ingenic_uart_serial_out;
 	uart.port.serial_in = ingenic_uart_serial_in;
-	uart.port.irq = irq;
 	uart.port.dev = &pdev->dev;
-	uart.port.fifosize = cdata->fifosize;
 	uart.tx_loadsz = cdata->tx_loadsz;
 	uart.capabilities = UART_CAP_FIFO | UART_CAP_RTOIE;
 
-	/* Check for a fixed line number */
-	line = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (line >= 0)
-		uart.port.line = line;
+	err = uart_read_port_properties(&uart.port);
+	if (err)
+		return err;
+
+	uart.port.regshift = 2;
+	uart.port.fifosize = cdata->fifosize;
 
 	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
 					 resource_size(regs));
-- 
2.43.0.rc1.1.gbec44491f096


