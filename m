Return-Path: <linux-kernel+bounces-81614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F60C867862
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4010F1C29EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F512DD8A;
	Mon, 26 Feb 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DS+iiPGY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871A12C7EB;
	Mon, 26 Feb 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957535; cv=none; b=IoscVFeG+ZbZRXXFDx3YAtCm5HFCLe2tgGKcXNhcn4WfKkKrUffe/nURMDPirZwC+mtVUJDvSY3ImxphEjXHaYtgEnLH7YEm9EIKHZQyQCMB8SC167yhnhNRAUPRK6CY5o+bKpZOfyi/1l/AulfVYAFv3C1RGdLsO4YAT14qiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957535; c=relaxed/simple;
	bh=I4Dp8lscp5MpgtPKkZb6GpVT2AnT2N5Frc+xmVMhCuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD1tv0a5RszhFEtklxmYpaC7A18jzjFCEaedQezd8TtlhoQ0xiMGOrPqT0B7r6GwxDVoISlcNvVLjr2OXuO6CKumHb+pGpLX5RPnS+HEFRN4mbZyWePUUmLB8WmmAgKm2EwsJYVQuMqyNLz2NNQOYkuI36aKx0cPzW7gz4SB1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DS+iiPGY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957535; x=1740493535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I4Dp8lscp5MpgtPKkZb6GpVT2AnT2N5Frc+xmVMhCuw=;
  b=DS+iiPGYEWrBf4fBkiA2nJmw+2SprsezPtG0ErHNTDS2TaBTYuqgZgrp
   slz2iss7uupJis8aZgJpqceY1vFfMQKBRevP5CQKikENI6aBrD1m0n+I8
   3tUHXzziACNIjhsSorgy4XDizzNeSH9HLTvwsMn3xsMT4Oro+6u1IAoFP
   KO3BouLE6nRpRGWhd/blfWtIDIk/9wxbf5EPmooLI+rryQMgdogMg0Hiv
   e1CgEYb5zSNACVTN2W7SNnHLvmeJzhlNddC5Uf/dDpQNdBmi5eKxA7CVb
   L3UnLA8IEDbwogQQ36vT1Q8HQm1QZEPvrzwYDljuzifu1PV4ozazfMWVW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3375281"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3375281"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:25:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937030150"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937030150"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 06:25:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A3B5DA43; Mon, 26 Feb 2024 16:25:16 +0200 (EET)
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
Subject: [PATCH v2 13/14] serial: 8250_tegra: Switch to use uart_read_port_properties()
Date: Mon, 26 Feb 2024 16:19:29 +0200
Message-ID: <20240226142514.1485246-14-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_tegra.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index ba352262df75..ce48d02dfa0d 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -57,25 +57,11 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	port = &port8250.port;
 	spin_lock_init(&port->lock);
 
-	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
-		      UPF_FIXED_TYPE;
-	port->iotype = UPIO_MEM32;
-	port->regshift = 2;
+	port->flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	port->type = PORT_TEGRA;
-	port->irqflags |= IRQF_SHARED;
 	port->dev = &pdev->dev;
 	port->handle_break = tegra_uart_handle_break;
 
-	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret >= 0)
-		port->line = ret;
-
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
-
-	port->irq = ret;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
@@ -88,12 +74,18 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	port->mapbase = res->start;
 	port->mapsize = resource_size(res);
 
+	ret = uart_read_port_properties(port, true);
+	if (ret)
+		return ret;
+
+	port->iotype = UPIO_MEM32;
+	port->regshift = 2;
+
 	uart->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(uart->rst))
 		return PTR_ERR(uart->rst);
 
-	if (device_property_read_u32(&pdev->dev, "clock-frequency",
-				     &port->uartclk)) {
+	if (!port->uartclk) {
 		uart->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(uart->clk)) {
 			dev_err(&pdev->dev, "failed to get clock!\n");
-- 
2.43.0.rc1.1.gbec44491f096


