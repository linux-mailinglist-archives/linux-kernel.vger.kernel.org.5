Return-Path: <linux-kernel+bounces-95263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF5874B80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C93F1F29C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F89129A9E;
	Thu,  7 Mar 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ReThVaVZ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCD83A06;
	Thu,  7 Mar 2024 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805320; cv=none; b=HIDvRcv/NnxZ+Nzk3jT+7glKCfWp5KFdFQX69uzTuNPblkpGonFSUPTxro1gI+1Cy1NwmIb/Rri976JxiKRyMaYGBxMg2HMHxnifVm33gDGzSDndIMwvAANlJPNIH8rdqmURQHgOInQM5pZ/CKh4sGwEFizj8oJytwg4cR0hAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805320; c=relaxed/simple;
	bh=9K6dlFecVjdiaofvQZmFf1HLeSgphBh5m11nBf8m5dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieUnb1e3R7nZgg/AP1SbBH3kM58gSjUewYeh+4HCq5jfM/Jw2RGmjqZ3t/lhSZJATTBWz/5FIpOFoOf082LtWhGWBOqbkwttHYWyUsx7ZtUizBR+jSvWXoak3VhYCgg5VdKeSjxJM9G1Cbf5l04xnMiIQJ2E5Iyecp2frmJTFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ReThVaVZ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C56FA1C0005;
	Thu,  7 Mar 2024 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709805311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DqnLNP1foaJv1btQXdf+rlQ3lZPfqXjWVpv49y/Boc=;
	b=ReThVaVZSOzqMKfWSrJdW302IizxyaGAeh4iW7KYMnbJm5CHIsMwyoIlo6Ugz+mYV2qWoT
	vpwlbS9LPOID0rpvhRQCVS7fV/H9pIuyAk0+WmlNSvuMv5Z9PlSI0J7mRrn8qHSfDu97lN
	BFj2wcZKD7VkqI6hA7+24CVUBy+nMPfHw5bLUT+u2BJOyTLEYu6zxk8DYSXlojHF6GI+kW
	qyQTtQCu8pQARc8w9pcgefWxtAdA9hXOLJo7wwaVIRnFMynGMM0rTYlo/OXCAgnn5PDQvx
	BfMYP5Ni5v4Zayt3EokEi6q+YoeMv55fElomTnJy9uGTnKPhcS5TsHz2dJncsA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 07 Mar 2024 10:55:04 +0100
Subject: [PATCH v4 3/9] usb: cdns3-ti: move reg writes from probe into
 ->runtime_resume()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-j7200-usb-suspend-v4-3-5ec7615431f3@bootlin.com>
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
In-Reply-To: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
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
2.44.0


