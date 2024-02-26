Return-Path: <linux-kernel+bounces-81617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DBE86786C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39921C2A27F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390312EBFC;
	Mon, 26 Feb 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlhVrdeU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3B12CDB1;
	Mon, 26 Feb 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957537; cv=none; b=sOdjyCyx0ChM5mf1Ys0zrTPoa3BGK1zA6jdcQa/LK9sVYauKQpdVyBJHpAet6R6myXfIPsrbtNh7mBsJ0GrvS2CUcIHOhKSLue1gqgtgvZxBzM/FFpZ3nilcAWRtRVEXw9iswAwn19ayuOWFiXLrFgbPeb/AFDDaxP9jzM4DGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957537; c=relaxed/simple;
	bh=lTV4RH4qiS21e5gSPVWYHbVcBJWdPYtUVhU20SXaAR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcXETm9gu4zxUJis05XZ31tsuriiUN9rEAmnVfqQZJ5ZqkuO6Dov732TLtvBAYKxC5YQ5Rhkf2d0lnYN5X8lJa+gkbpD3/vB1ilfUiAOVz5b1V3l5QT2abT8B/mZoQb9dQPeSDoJdHvJzdlVsx82cLbFGvZ51RH+m9+ZVwC68NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlhVrdeU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957536; x=1740493536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lTV4RH4qiS21e5gSPVWYHbVcBJWdPYtUVhU20SXaAR4=;
  b=jlhVrdeUqDSZUIRzZ6ZxKAbBNda8h+Xi4zNyKmdFtm8TevpqQB68ofRG
   8WYReZzxgbv8UM3V+y9X2t7Trn0DJR1BUcQGywht2r7F98DL1BpsA/YiX
   8eJZfHtIWDqSjtnl8ywMnzMA6Ha6q5mUcnKyRXXL8BnhyFp/OfueaNjA9
   Q8nsP26E2hgXyMYyNFUNaF87AuZYhVdZnGRAcnzb2QZCP/f4ZmZYDmZpp
   ivQK/0v0YbA5mV1zxeDaHk76FoDNe8oXdfOJnxbN0t5X/UFKIEa+QoYBE
   M+X1We8p/5Slj4Z8I7NBGN1qpoQ6GQNEaeiUFZpfJtJpG7UqMlZ+f0gQZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3375292"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3375292"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:25:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937030151"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937030151"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 06:25:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AE687A97; Mon, 26 Feb 2024 16:25:16 +0200 (EET)
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
Subject: [PATCH v2 14/14] serial: 8250_uniphier: Switch to use uart_read_port_properties()
Date: Mon, 26 Feb 2024 16:19:30 +0200
Message-ID: <20240226142514.1485246-15-andriy.shevchenko@linux.intel.com>
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


