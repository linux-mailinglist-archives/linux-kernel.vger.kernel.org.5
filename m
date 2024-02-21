Return-Path: <linux-kernel+bounces-75312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BC85E661
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33271F26720
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672C93C068;
	Wed, 21 Feb 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfE1ktOS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A36126F10;
	Wed, 21 Feb 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540508; cv=none; b=IcflJYKZBpLJiLoATuagyApIL2t/p7qErn7un5NAWxIZ6mZcw89eMwW/1JhLole8sk2rGMRVCuvWy1N6O5zmDmUrZqS7RLyzfJQwsnU3JjC9KKe9gguIXqf0myZI5h2ddzWMYtrnzmIWSOwYTKIXSwkTR4SIg3vSe2Q0PNbvU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540508; c=relaxed/simple;
	bh=J0xi+n8uZBq6TA4lbxbqQ3C4vIDv86jFL+mrVMUmGoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YK6b8HHPeWpo5zb9cvpmUOGLA0H2fXhMqT7I7TEkZiZ6m0yT02/vBxlxQ+bT4tpRjampctKWfAY/WDPhZ4FlSOEyXqexNExqO48GZ0BM3p3nEQTKNfBqBzRoZf/sl9gF+y0fKwucBnZ4W7s5e7m90BgV+zHaGzTcU2oIn8JxhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfE1ktOS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540506; x=1740076506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J0xi+n8uZBq6TA4lbxbqQ3C4vIDv86jFL+mrVMUmGoA=;
  b=TfE1ktOShmuPHUFPkCgi3Rvdgn0oVPcUCZyVzHlY396HvJmsxefDtlnM
   bmSWQc3bPwmpEoiW1OcbGJiEoauTttGiT0HLLNojKedKj2tut9BHWLjcs
   2GlBMolVyHlSS9zoeixQxBVdWWyQHKGaJ+ulLIkqYJWEcFLCEcZ/VzrjC
   qhnARaFB4LwpW06fbpo6zzKRsY2YiYaO1Uf2Pn1hczp5ADO1nS+EHBXJZ
   utExjIkINQ3zLgtH1XZZCBZkzJ+7Yim8du1Cw4IUOfKcNSY22/4lbvVPV
   Ff1xmUA4Bg10BYryGbi+p8dPLlhPYIZTL9rJBhpB5IO3TaVbHDf0GRHFk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164841"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164841"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684757"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684757"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6A910898; Wed, 21 Feb 2024 20:34:47 +0200 (EET)
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
Subject: [PATCH v1 12/14] serial: 8250_pxa: Switch to use uart_read_port_properties()
Date: Wed, 21 Feb 2024 20:31:28 +0200
Message-ID: <20240221183442.4124354-13-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_pxa.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 77686da42ce8..0c9140b93414 100644
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
+	ret = uart_read_port_properties(&uart.port, true);
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


