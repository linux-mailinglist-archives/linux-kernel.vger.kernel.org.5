Return-Path: <linux-kernel+bounces-90579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1216870190
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D9AB24BF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E38847F69;
	Mon,  4 Mar 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLhsFR4b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102B44C84;
	Mon,  4 Mar 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555458; cv=none; b=ET272ZSFqFsadHr9eXj7FnTAC/CR2XCmmh+YxN1joqzDHd1X7vAkthG1XqQc6OMoC4FDnPnErjKmM+Om0tZg0/B+LLC5Vz0VnX7EhyxPZ8/7VN2BwaPd0M3ks2ZP2bA+kEHr2pUd1nmdYeMSvlswQ4DQwCZlcAuxdCzo2XG7iVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555458; c=relaxed/simple;
	bh=2fQaXc8Ypf3lwPz6yPzLdFKzd2VLz29IZnJiOdcHyzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWnFEUSsbyRg7V8ZRIJIJFD3hcJv37BtkNO0e1PIQpg5uGQ25NZywkkDxe6IpzUOmegS+pfIKQW0eAH9+zZltUaKsglEHwyuOxbaxxSsV5AiOxo8679yKLgBnLTfJak6t2Q7LnH703bxSR9UBxI42vb0kCfbY/dblDlAxd4hOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLhsFR4b; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555457; x=1741091457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2fQaXc8Ypf3lwPz6yPzLdFKzd2VLz29IZnJiOdcHyzs=;
  b=jLhsFR4bKcHPV/qMsg2WuZrP3ldwzjBAj2DzBotQKC2/fzD2Pifvreml
   HZF8wO5MXj51Ux+gW/qqPWC3nLjV6sqOH3g1sDxKh6AAXXr9sMEMFx9sb
   wAKd/wObsQGiRrTjT/TII7G/XYrs1ZKjvmoiDpFKH/syhaLLfUusAMriW
   bAJxf3Ccdhhi/fO8iiXt3uNK38xZhaipniYaSI5Y5BHTobR8mM4qJrSM1
   NSjJf0bXrXtgUFdH+QZ2ppp0OjpvrL8O9KLSn6BmivImOUCgNp9eawnpd
   nkwI5r81srA4ZXfLZVgJanvl7augnLvBWniS0bqGWeVlX0ct1JZX6lpor
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815219"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815219"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040434"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040434"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D8088AB1; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
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
Subject: [PATCH v3 13/14] serial: 8250_tegra: Switch to use uart_read_port_properties()
Date: Mon,  4 Mar 2024 14:27:14 +0200
Message-ID: <20240304123035.758700-14-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_tegra.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index ba352262df75..60a80d00d251 100644
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
 
+	ret = uart_read_port_properties(port);
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


