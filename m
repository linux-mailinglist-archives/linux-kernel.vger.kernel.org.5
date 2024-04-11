Return-Path: <linux-kernel+bounces-139780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233928A079E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CF928AB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F9A13C80D;
	Thu, 11 Apr 2024 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="AeUASavu"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6455D13C80B;
	Thu, 11 Apr 2024 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813074; cv=none; b=mjqBNqxawufwt0cVisZc9K4eBlG+OX3dp2STVfEMY02z5E8q/lUhWCkeHii/DG9208sStxeZFum/epfp15ZqJ/nKdSZ34PKNIsDXCP9OV5gCt0Ft645LjtIH7shhg6Ig1FpjjkfnwFB3vxMAt9XdByh+sLN1hg5CGclotgfBRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813074; c=relaxed/simple;
	bh=cMcNbp6qZx7YcqIcrUoQemHHiu6y77uoRqWrfG6QieM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv/croC6fy1Nn4mKTkJ6UHajbTPi729MkssR2SJw4CmmqxkocGB/CwCKyFXIPTN1Zx4KjpE8ipnujNsfmR0sJsNkyyikZ4GGTMAMDge17sugcDWKjeZXUwL3l1ptOi6s+wP2iwkZvRUtg3Q74XtyKajPrUjI8H6EbzeIMtdP72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=AeUASavu; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id E1BD7603E6;
	Thu, 11 Apr 2024 05:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712813071;
	bh=cMcNbp6qZx7YcqIcrUoQemHHiu6y77uoRqWrfG6QieM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AeUASavufVbze58Mcc9yiMZJUZ+AJzhhii033h76dvsglXYe3qZI2Lsq77j8/xr2J
	 3HwNxRpYEhzkwfafWiENZPo1PYovEvN/M4piTHHX52WYTrZPqXrhMGG/UUlW4vNO7U
	 KyKRqAeOKBWATbTiy2JwaPaWAOev0HLF2gxr+pLblT5Vwajz0Mv89evAkTeeBKTVdw
	 X19HisXNj4blrVKw4sk7BsvR+MH4Y9zezDI0QEApL6ji7Q+E7uHA6oO3xB4/e70QvH
	 r4f/eUqv2ppiFs8RFXA1jjA2TxTpVnHdd+yvWGC/6qdL6zHTmVnGFPZpGg8x0qxpvG
	 r6KCs1WxRJG7w==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 4/4] serial: 8250: omap: Use reset control for resets
Date: Thu, 11 Apr 2024 08:22:57 +0300
Message-ID: <20240411052257.2113-5-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411052257.2113-1-tony@atomide.com>
References: <20240411052257.2113-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For at least am335x and omap4, we set the UART_ERRATA_CLOCK_DISABLE quirk
that ends up calling reset for the interconnect target. We can do this with
reset control framework and simplify the 8250_omap driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_omap.c | 66 +++++++++++------------------
 1 file changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -29,6 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
 #include <linux/pm_domain.h>
+#include <linux/reset.h>
 
 #include "8250.h"
 
@@ -147,6 +148,7 @@ struct omap8250_priv {
 	struct pm_qos_request pm_qos_request;
 	struct work_struct qos_work;
 	struct uart_8250_dma omap8250_dma;
+	struct reset_control *reset;
 	spinlock_t rx_dma_lock;
 	bool rx_dma_broken;
 	bool throttled;
@@ -1490,6 +1492,14 @@ static int omap8250_probe(struct platform_device *pdev)
 	priv->line = -ENODEV;
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
+
+	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
+		priv->reset = devm_reset_control_get_exclusive(&pdev->dev,
+							       "softreset");
+		if (IS_ERR(priv->reset))
+			return PTR_ERR(priv->reset);
+	}
+
 	cpu_latency_qos_add_request(&priv->pm_qos_request, priv->latency);
 	INIT_WORK(&priv->qos_work, omap8250_uart_qos_work);
 
@@ -1695,47 +1705,6 @@ static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
 	writel(val, priv->membase + (reg << OMAP_UART_REGSHIFT));
 }
 
-/* TODO: in future, this should happen via API in drivers/reset/ */
-static int omap8250_soft_reset(struct device *dev)
-{
-	struct omap8250_priv *priv = dev_get_drvdata(dev);
-	int timeout = 100;
-	int sysc;
-	int syss;
-
-	/*
-	 * At least on omap4, unused uarts may not idle after reset without
-	 * a basic scr dma configuration even with no dma in use. The
-	 * module clkctrl status bits will be 1 instead of 3 blocking idle
-	 * for the whole clockdomain. The softreset below will clear scr,
-	 * and we restore it on resume so this is safe to do on all SoCs
-	 * needing omap8250_soft_reset() quirk. Do it in two writes as
-	 * recommended in the comment for omap8250_update_scr().
-	 */
-	uart_write(priv, UART_OMAP_SCR, OMAP_UART_SCR_DMAMODE_1);
-	uart_write(priv, UART_OMAP_SCR,
-		   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);
-
-	sysc = uart_read(priv, UART_OMAP_SYSC);
-
-	/* softreset the UART */
-	sysc |= OMAP_UART_SYSC_SOFTRESET;
-	uart_write(priv, UART_OMAP_SYSC, sysc);
-
-	/* By experiments, 1us enough for reset complete on AM335x */
-	do {
-		udelay(1);
-		syss = uart_read(priv, UART_OMAP_SYSS);
-	} while (--timeout && !(syss & OMAP_UART_SYSS_RESETDONE));
-
-	if (!timeout) {
-		dev_err(dev, "timed out waiting for reset done\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
 static int omap8250_runtime_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
@@ -1747,7 +1716,20 @@ static int omap8250_runtime_suspend(struct device *dev)
 	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
 		int ret;
 
-		ret = omap8250_soft_reset(dev);
+		/*
+		 * At least on omap4, unused uarts may not idle after reset without
+		 * a basic scr dma configuration even with no dma in use. The
+		 * module clkctrl status bits will be 1 instead of 3 blocking idle
+		 * for the whole clockdomain. The softreset below will clear scr,
+		 * and we restore it on resume so this is safe to do on all SoCs
+		 * needing omap8250_soft_reset() quirk. Do it in two writes as
+		 * recommended in the comment for omap8250_update_scr().
+		 */
+		uart_write(priv, UART_OMAP_SCR, OMAP_UART_SCR_DMAMODE_1);
+		uart_write(priv, UART_OMAP_SCR,
+			   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);
+
+		ret = reset_control_reset(priv->reset);
 		if (ret)
 			return ret;
 
-- 
2.44.0

