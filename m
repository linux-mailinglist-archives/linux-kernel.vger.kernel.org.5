Return-Path: <linux-kernel+bounces-90571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E5887016A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1FA287AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E203CF6D;
	Mon,  4 Mar 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnyEIcKk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD33DB8B;
	Mon,  4 Mar 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555452; cv=none; b=JsbvKmENPl8HTLvheyziUi44kk48lu2FvpXM4qUliPP0BkBVdBQR7nBret9dBBozUd+6Nu5drOhfmcGqZpphq9wG8Yl3RQ9MEaqY40aqzO6P7cbJ1nR4PRssmO8PMBzNoiddZcRqDqCDg0fDKflvWqpuK2A+SJ5sv0KR9nnai7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555452; c=relaxed/simple;
	bh=TnMt2ju9cdAL7PKJz1vum/eONvPof09ld6E2GiIPEVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdwaAqLjhKyJZNg6RoNg+qEBs3YvJFO1X3ADHMqUhCNw/j7Vbn6cTC8WhOlv7HftFA+YWmPj7FLNAn84OTrTRzSoQuOFhRuEWHyFwwnk1iAtY3qpxxRqG5UOikjRjDXGFclnY04GwqEX9QBCvaCfi/Eavx7rqQEDl5wHRCxp1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnyEIcKk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555451; x=1741091451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TnMt2ju9cdAL7PKJz1vum/eONvPof09ld6E2GiIPEVg=;
  b=EnyEIcKkVQZTW7RMkD5/KI1SwzfKgLeR7mDUTQxp6a7ilowEuor/Oh5T
   7S0GBUXC5O8qshdU1sH1XYH19zUWkSvnRfWwdeHEiXBsxXnftlf0U910t
   lUgUMOcwvxfrsFY6yVXPVJpxuTCSnHo99zuBMnor3P9KTdQmDHSySjav4
   bsvsEDZJ5A9DBnTtYliWcc5kehpb7POJ+PY+5mtMfHuNoDeH6Eqo6F6dB
   N6tKuCztafJx+cYUlOMq5Ab27+tIEvEjx24ItMFEeWL5aK1fM/SArY5kw
   rZppPNsgtOpOzURZ/UX2x7O7iqlpk8HPXSGM8wMH5hdX2Fik8UZQ+Jnqm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815099"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815099"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040432"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040432"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CB7CFA59; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
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
Subject: [PATCH v3 12/14] serial: 8250_pxa: Switch to use uart_read_port_properties()
Date: Mon,  4 Mar 2024 14:27:13 +0200
Message-ID: <20240304123035.758700-13-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_pxa.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 77686da42ce8..f1a51b00b1b9 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -92,11 +92,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	struct uart_8250_port uart = {};
 	struct pxa8250_data *data;
 	struct resource *mmres;
-	int irq, ret;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	int ret;
 
 	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mmres)
@@ -114,21 +110,21 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret >= 0)
-		uart.port.line = ret;
-
 	uart.port.type = PORT_XSCALE;
-	uart.port.iotype = UPIO_MEM32;
 	uart.port.mapbase = mmres->start;
-	uart.port.regshift = 2;
-	uart.port.irq = irq;
-	uart.port.fifosize = 64;
 	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev = &pdev->dev;
 	uart.port.uartclk = clk_get_rate(data->clk);
 	uart.port.pm = serial_pxa_pm;
 	uart.port.private_data = data;
+
+	ret = uart_read_port_properties(&uart.port);
+	if (ret)
+		return ret;
+
+	uart.port.iotype = UPIO_MEM32;
+	uart.port.regshift = 2;
+	uart.port.fifosize = 64;
 	uart.dl_write = serial_pxa_dl_write;
 
 	ret = serial8250_register_8250_port(&uart);
-- 
2.43.0.rc1.1.gbec44491f096


