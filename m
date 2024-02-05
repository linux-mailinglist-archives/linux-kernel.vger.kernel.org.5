Return-Path: <linux-kernel+bounces-52794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B27849CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24ADA1C22D50
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6462E41F;
	Mon,  5 Feb 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd8iKo+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035F32C93;
	Mon,  5 Feb 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142364; cv=none; b=VODbLqgIY37TzxNhc+iW5n/gawAz+zgkTeBpO0Y6ykfL9llyC6JDgna1E5VeNdTh55ezyukZiFY0SYvpjTD3pO1ClMuY6jl+Xd1be2PP4AZm6DDW4rvBq9/CvUZn88Yo9pmJScRnTCvumXTWs3VkYyiJwz8mlQ50nloxGlsSOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142364; c=relaxed/simple;
	bh=h/Wjhl4phEKjtwys+YLS96BL5IrD+pUdM1DisLakQwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5+VoSisPhSP/p1AsV0azcolmmDJ1JqejGpkiBVObtz1kLIq1YcMkZMzy+76gMO7eMe1/xjKIXuBrDta8J0nNycXzetmkPTABtiV1SpgCK+AvMHlewsGJAGQTkndKPQLksGSM2Fh/+75oyggAUzv9/fMV32K0N1A6gHswlNJblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd8iKo+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1439C433A6;
	Mon,  5 Feb 2024 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707142363;
	bh=h/Wjhl4phEKjtwys+YLS96BL5IrD+pUdM1DisLakQwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gd8iKo+qWSY0wR4esH/qgfx2hrvkVTjGhH9Nz/yHmqLI4WTGVETLnqOsTpUmRaMKJ
	 qoHQuQnZ5DGIU+WhQEDoOJWvdnUDz+EDBOcttpoIlIrzLJdfO/hiXJdp/VhkwhyPVH
	 YWb5skYGzrfu56Qx1e52hPecq5mK777xKqViQ/zcrcOgR/N934Cw1R0Ho7diN/RMHc
	 kURZj6+Hlkgcg8sGbDafscm4LoxHvXx4rEvKkdIoSDLOBq1CRO/ZHoPJVcx/bTNbNP
	 PU/EEf+jVoLYUraguGBbgfvs9FXyiLvbVOp7ZGQx85WU5nL5BT9qyuz8af47v73Eq+
	 Vzphk47VCKxOg==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	afd@ti.com,
	nm@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 5/5] usb: dwc3-am62: add workaround for Errata i2409
Date: Mon,  5 Feb 2024 16:12:21 +0200
Message-Id: <20240205141221.56076-6-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205141221.56076-1-rogerq@kernel.org>
References: <20240205141221.56076-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All AM62 devices have Errata i2409 [1] due to which
USB2 PHY may lock up due to short suspend.

Workaround involves setting bit 5 and 4 PLL_REG12
in PHY2 register space after USB controller is brought
out of LPSC reset but before controller initialization.

Handle this workaround.

[1] - https://www.ti.com/lit/er/sprz487d/sprz487d.pdf

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v2:
    - don't add phy read/write helpers or add phy to private data
    
    v1: https://lore.kernel.org/all/20240201121220.5523-5-rogerq@kernel.org/

 drivers/usb/dwc3/dwc3-am62.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index af1ce934e7fb..5ae5c3087b0f 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -101,6 +101,11 @@
 #define PHY_CORE_VOLTAGE_MASK	BIT(31)
 #define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
 
+/* USB PHY2 register offsets */
+#define	USB_PHY_PLL_REG12		0x130
+#define	USB_PHY_PLL_LDO_REF_EN		BIT(5)
+#define	USB_PHY_PLL_LDO_REF_EN_EN	BIT(4)
+
 #define DWC3_AM62_AUTOSUSPEND_DELAY	100
 
 struct dwc3_am62 {
@@ -184,8 +189,9 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
 	struct dwc3_am62 *am62;
-	int i, ret;
 	unsigned long rate;
+	void __iomem *phy;
+	int i, ret;
 	u32 reg;
 
 	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
@@ -201,6 +207,12 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 		return PTR_ERR(am62->usbss);
 	}
 
+	phy = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
+		phy = NULL;
+	}
+
 	am62->usb2_refclk = devm_clk_get(dev, "ref");
 	if (IS_ERR(am62->usb2_refclk)) {
 		dev_err(dev, "can't get usb2_refclk\n");
@@ -227,6 +239,13 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Workaround Errata i2409 */
+	if (phy) {
+		reg = readl(phy + USB_PHY_PLL_REG12);
+		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
+		writel(reg, phy + USB_PHY_PLL_REG12);
+	}
+
 	/* VBUS divider select */
 	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
 	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
-- 
2.34.1


