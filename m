Return-Path: <linux-kernel+bounces-81615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20127867867
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC7A290659
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE412E1C4;
	Mon, 26 Feb 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+MKX2kW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EA12C7FC;
	Mon, 26 Feb 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957536; cv=none; b=uQyzlKPswkb1Mkbe79Cg88jK7TZHpXs+O7ndSyaipkEvk5Qx9YBob+8OhZgeWEuZw0cetvgAcEss6SuQbltkLBxKJQz6xXAUkndcUbKr+uQfsQ2PsBaHg3lAgN+MKYEkJHgCbNxs6ql+8nNsVLnMa5ABXSSt6Y+SsdemrTNKXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957536; c=relaxed/simple;
	bh=J0xi+n8uZBq6TA4lbxbqQ3C4vIDv86jFL+mrVMUmGoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBbFt3c5alT1mb/1facOb4vK0+efv1fCDatylDzRkSAZZ2p7SwsiJ4f6v50cvNm3DF0dGbFMpl9moR4KqS+htp2rIybOOFwuAyDt2jy2RSRTjxpHsMsC1+SdtmcF5nJu915pRBRekuAI2EwSXK+95hZoBQdWy4ORQwii/p/ZqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+MKX2kW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957535; x=1740493535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J0xi+n8uZBq6TA4lbxbqQ3C4vIDv86jFL+mrVMUmGoA=;
  b=Z+MKX2kWCWOIqP6LcpXKezsJSGWZKITA9oaGGQ+f6Hcvl02ij9plBqzm
   midO6vxWsLh3ts2sp2r5toez+ef/x47v0qfO7SYzdrQUgURHFwX32o/zM
   TNvVRLj7XYJznHcGY0sW6QvpplvumkPfj/VCXPFBugQ1GwGqov6mOohzc
   zQFzNjhtbp+RHN7xu+lrUupzY7Wp1D9H42P1lh4X+RMvS5klm6MvEORA8
   iBpua3b1+Zv1ezAb8ucU/zF3fi9hnaxIk3ThW7Ut2IZ+B/fv1Gjyj5FAX
   tx/Hd3kFwRQsSPyl5GCHe60qTgWXkcoHy5YxwhAwZ+weDut+6NaaN6ze0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3375237"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3375237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:25:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937030149"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937030149"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 06:25:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 98B77A0D; Mon, 26 Feb 2024 16:25:16 +0200 (EET)
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
Subject: [PATCH v2 12/14] serial: 8250_pxa: Switch to use uart_read_port_properties()
Date: Mon, 26 Feb 2024 16:19:28 +0200
Message-ID: <20240226142514.1485246-13-andriy.shevchenko@linux.intel.com>
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


