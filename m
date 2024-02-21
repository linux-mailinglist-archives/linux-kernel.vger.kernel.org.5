Return-Path: <linux-kernel+bounces-75317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA49785E66F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A67F28778B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD8E12AAC7;
	Wed, 21 Feb 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJYlbGZL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58D8564D;
	Wed, 21 Feb 2024 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540514; cv=none; b=Ons6F8ncnLW0pPMpWBxsyMqVe1VXY+XKhdnSwtte2wPs1+HU+QnnnwE9dJXpXVN9Nfe2A4CvIBI50aSyMomKiwQf6JDU0hLEKCD6E7NDGcKJdxE9vS/Otb0/r/lMKTOqxDPVfWeXmNUYXDMGmDN/c/aWNG6eUxcEl0b6c3pchCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540514; c=relaxed/simple;
	bh=lTV4RH4qiS21e5gSPVWYHbVcBJWdPYtUVhU20SXaAR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQqyT+yWBZoLBdkT3/tEWb2B+ZwiuPZ6NV57prNl8uCKteIsHqvIU1VlD3XwRwzVtGGDw0G9fNBD14wV1aFAEkYxwstufutON/EO9CiNAVBS3DSgN/e1wzla0v441iu6aliRI25NzyA2b1R/q4E8VJmFjs5BCGkkpUN96srFIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJYlbGZL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540511; x=1740076511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lTV4RH4qiS21e5gSPVWYHbVcBJWdPYtUVhU20SXaAR4=;
  b=WJYlbGZLAc4nSX1rS+pirmLVyf04yXiyEaR5VsaVbbSLtrWUzaaGKn35
   gLlUsy6D1Te+rSYSXZeq9bwYhRzNKfP1SHGZzPRpO138IUfY+QVjDmYjM
   p/lKtKp0vtIf+Rbda1SFvKXJ+hayxBTkNlVJgx6yhcKmIM63cgtPJVlE1
   qW68rxrAY45t/hVCD+VaeVGbbmJBstz/cTTxqR7wDhkOfalv3ZVQoqGNa
   JROlODygFKZUNdZrmUhTXVF8tQWZxG5i+hZsVzglK1mhDD4ujioVaiD8G
   c7B/HlhffxtPjbUOLgBl3h9y75wa4pnDzWcYdqGsCZ+vIxKQNcErWm/8+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164888"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164888"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684759"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684759"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8318E2A0; Wed, 21 Feb 2024 20:34:47 +0200 (EET)
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
Subject: [PATCH v1 14/14] serial: 8250_uniphier: Switch to use uart_read_port_properties()
Date: Wed, 21 Feb 2024 20:31:30 +0200
Message-ID: <20240221183442.4124354-15-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_uniphier.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 6399a38ecce2..d3f270a191ee 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -162,7 +162,6 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	struct uniphier8250_priv *priv;
 	struct resource *regs;
 	void __iomem *membase;
-	int irq;
 	int ret;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -175,23 +174,12 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	if (!membase)
 		return -ENOMEM;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	memset(&up, 0, sizeof(up));
 
-	ret = of_alias_get_id(dev->of_node, "serial");
-	if (ret < 0) {
-		dev_err(dev, "failed to get alias id\n");
-		return ret;
-	}
-	up.port.line = ret;
-
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "failed to get clock\n");
@@ -211,7 +199,10 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	up.port.mapbase = regs->start;
 	up.port.mapsize = resource_size(regs);
 	up.port.membase = membase;
-	up.port.irq = irq;
+
+	ret = uart_read_port_properties(&up.port, true);
+	if (ret)
+		return ret;
 
 	up.port.type = PORT_16550A;
 	up.port.iotype = UPIO_MEM32;
-- 
2.43.0.rc1.1.gbec44491f096


