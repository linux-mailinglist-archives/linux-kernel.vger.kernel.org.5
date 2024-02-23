Return-Path: <linux-kernel+bounces-78667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E18616E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0285C2894B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F038663D;
	Fri, 23 Feb 2024 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="drQue52u"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F74C79;
	Fri, 23 Feb 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704337; cv=none; b=C335d7Ev1ArUFWRnSNNFW8b4E3NaJzhRl75tWydI891F+uJcxRBOqx3vESrJ4Uyg4aScPA7TIviKM1nzEznkQopxDAKSX/MgjI3dtLWs3p4zPI0nS3sJNa0eVnpIHkC5duOTPRcEFh/K66X1o0jK3ZI6xt0r9+Arq+ny9WRtQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704337; c=relaxed/simple;
	bh=cgrG/lkmnv622fu4VKM2CWXUoXsPzdZfZxvEzXF3BbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=erXKkLo73H05VgFZl8gNXChGfrjzfjM5WgL3x435kbaqEQhGhLPtTV2Iu6muo7jTmt0J54t3GDuBaaku98Mq47M3tZ+lfJhX03U2i47C9c5tHQUp/SJTq6EDoYOOHjc1oX77ic0vsJKQ1hgKhK6PXOSgQ/nIsphlTNc/WLLXIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=drQue52u; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E90951C0006;
	Fri, 23 Feb 2024 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G36dyCsQS4BXpbV31b880qblN6dPbFme1l75T2Hw+Zk=;
	b=drQue52ulO+fuP1tUE11b21wt5CykxH2xQBy3/wI1NsvFmYUQsP5Pu8sX79JledvSmebZE
	INzRYr5fgMHge+zoW8S4PgVmcH/BK5jStiwnqU2h4dgG7stSNXTKqXyRwZY235LZMEORpr
	QwrmGtm58EW/INkHY3YgIaENj0HK/2rBkVtIzSTjttXK6sLL1Q6aZoFA8Sr9apEsrAb4Cm
	oRP04uQwJ6E84JcxjUEF4w6Q7WnxQqpwRwMMFkz0DeMqAAqYWSQu2w5PnNllgIREKIFBoK
	W/e1ctnjlUMERh85pezeu9GBN+k83wVPTb+AUMLl7OWqYOc0ef/0EP4GOaI23Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 23 Feb 2024 17:05:27 +0100
Subject: [PATCH v3 3/8] usb: cdns3-ti: move reg writes from probe into
 ->runtime_resume()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-j7200-usb-suspend-v3-3-b41c9893a130@bootlin.com>
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
In-Reply-To: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

The hardware initialisation register write sequence is only used at
probe. Move it from being done at explicitely at probe to being done
implicitely by pm_runtime_get_sync() that calls ->runtime_resume().

Keep devicetree parsing in probe and add a new field in the private
struct to remember the USB2 refclk rate code computation result.

This opens the door to having the init sequence being executed later
down the road, at system-wide resume for example. This is NOT currently
happening because runtime PM is disabled at suspend without the
refcount being affected.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 90 +++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 5945c4b1e11f..4c8a557e6a6f 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -57,6 +57,7 @@ struct cdns_ti {
 	unsigned vbus_divider:1;
 	struct clk *usb2_refclk;
 	struct clk *lpm_clk;
+	int usb2_refclk_rate_code;
 };
 
 static const int cdns_ti_rate_table[] = {	/* in KHZ */
@@ -90,10 +91,8 @@ static int cdns_ti_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
 	struct cdns_ti *data;
-	int error;
-	u32 reg;
-	int rate_code, i;
 	unsigned long rate;
+	int error, i;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -133,7 +132,9 @@ static int cdns_ti_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rate_code = i;
+	data->usb2_refclk_rate_code = i;
+	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
+	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
 
 	pm_runtime_enable(dev);
 	error = pm_runtime_get_sync(dev);
@@ -142,40 +143,6 @@ static int cdns_ti_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	/* assert RESET */
-	reg = cdns_ti_readl(data, USBSS_W1);
-	reg &= ~USBSS_W1_PWRUP_RST;
-	cdns_ti_writel(data, USBSS_W1, reg);
-
-	/* set static config */
-	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
-	reg &= ~USBSS1_STATIC_PLL_REF_SEL_MASK;
-	reg |= rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
-
-	reg &= ~USBSS1_STATIC_VBUS_SEL_MASK;
-	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
-	if (data->vbus_divider)
-		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
-
-	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
-	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
-
-	/* set USB2_ONLY mode if requested */
-	reg = cdns_ti_readl(data, USBSS_W1);
-	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
-	if (data->usb2_only)
-		reg |= USBSS_W1_USB2_ONLY;
-
-	/* set default modestrap */
-	reg |= USBSS_W1_MODESTRAP_SEL;
-	reg &= ~USBSS_W1_MODESTRAP_MASK;
-	reg |= USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
-	cdns_ti_writel(data, USBSS_W1, reg);
-
-	/* de-assert RESET */
-	reg |= USBSS_W1_PWRUP_RST;
-	cdns_ti_writel(data, USBSS_W1, reg);
-
 	error = of_platform_populate(node, NULL, NULL, dev);
 	if (error) {
 		dev_err(dev, "failed to create children: %d\n", error);
@@ -211,6 +178,52 @@ static void cdns_ti_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static int cdns_ti_runtime_resume(struct device *dev)
+{
+	struct cdns_ti *data = dev_get_drvdata(dev);
+	u32 reg;
+
+	/* assert RESET */
+	reg = cdns_ti_readl(data, USBSS_W1);
+	reg &= ~USBSS_W1_PWRUP_RST;
+	cdns_ti_writel(data, USBSS_W1, reg);
+
+	/* set static config */
+	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
+	reg &= ~USBSS1_STATIC_PLL_REF_SEL_MASK;
+	reg |= data->usb2_refclk_rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
+
+	reg &= ~USBSS1_STATIC_VBUS_SEL_MASK;
+
+	if (data->vbus_divider)
+		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
+
+	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
+	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
+
+	/* set USB2_ONLY mode if requested */
+	reg = cdns_ti_readl(data, USBSS_W1);
+
+	if (data->usb2_only)
+		reg |= USBSS_W1_USB2_ONLY;
+
+	/* set default modestrap */
+	reg |= USBSS_W1_MODESTRAP_SEL;
+	reg &= ~USBSS_W1_MODESTRAP_MASK;
+	reg |= USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
+	cdns_ti_writel(data, USBSS_W1, reg);
+
+	/* de-assert RESET */
+	reg |= USBSS_W1_PWRUP_RST;
+	cdns_ti_writel(data, USBSS_W1, reg);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cdns_ti_pm_ops = {
+	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
+};
+
 static const struct of_device_id cdns_ti_of_match[] = {
 	{ .compatible = "ti,j721e-usb", },
 	{ .compatible = "ti,am64-usb", },
@@ -224,6 +237,7 @@ static struct platform_driver cdns_ti_driver = {
 	.driver		= {
 		.name	= "cdns3-ti",
 		.of_match_table	= cdns_ti_of_match,
+		.pm	= pm_ptr(&cdns_ti_pm_ops),
 	},
 };
 

-- 
2.43.2


