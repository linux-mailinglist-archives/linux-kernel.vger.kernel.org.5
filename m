Return-Path: <linux-kernel+bounces-48095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DB9845722
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755251C25DA0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E594161B7F;
	Thu,  1 Feb 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts9C4TN7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1D161B6E;
	Thu,  1 Feb 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789557; cv=none; b=WCxQUxyw7p2t2bVJFRpBX/MZ8ChDK3qetbmfNIAjOYwBpm3Vyl/SxOahtQAck0O6li4Y3dIcEHTi3r57OkJ+Fi2Phjtyt9Ua2m/A8acMHsQApfEVX9NmY9CNCb5CVSbW2tyK2sUHELZjkzHzKyzNt0947gzu64PDShVOxr6Gk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789557; c=relaxed/simple;
	bh=ENALJ+0xsMIiiXqnLcbkuuaHj/9Uu77rAWI6PeJZuEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qA51ydCoiBN12cLs7zu0+s5SgI1RaQHklyltMs92ywZjwkkcT4kdD7MWm984S9/2LXr/6Mktgn6KjDr4VbYF0EP7H773SrVY6rWc3Uop5O4BLPU/fCBSdVGQBCUDeCRTmUzvQuuDukMpjczpLHCbB6fVlof137Cyr4hv72s0CAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts9C4TN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B8EC43394;
	Thu,  1 Feb 2024 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789557;
	bh=ENALJ+0xsMIiiXqnLcbkuuaHj/9Uu77rAWI6PeJZuEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ts9C4TN78P1HEMN2kCav6hkD9vQFUJa0dzInFOV55bhGr5OVukk8Vtrs/Wfz0gFEl
	 GaxVX60eDEIFMxxdUEY9d3fvdRdax5AmNQ5Rn7QKesF/GYVC7UDNrDVNtQyMPtRmVY
	 ps8TG4Aiy9vRzwn7zfkqET4Bk0QIOft50VytiBEwSmPxwVakRA6ehy5R31nTBx9LBe
	 /vcwmfZoZC9t/BwW1qPfodrgZDMCnz3K2a8EZrJKYwjpiOToS3XWX3de7A46aAxLQ2
	 cln5KPtVr3ZlQ7KvLuCDelxoi7EN9O0ebGcnCsrypfKqcTvMh5kLaB8ijEuCRUmfOz
	 +iycFlHXnXG7Q==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 4/4] usb: dwc3-am62: add workaround for Errata i2409
Date: Thu,  1 Feb 2024 14:12:20 +0200
Message-Id: <20240201121220.5523-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201121220.5523-1-rogerq@kernel.org>
References: <20240201121220.5523-1-rogerq@kernel.org>
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

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/dwc3-am62.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index af1ce934e7fb..35d7a2fb128e 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -101,11 +101,17 @@
 #define PHY_CORE_VOLTAGE_MASK	BIT(31)
 #define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
 
+/* USB PHY2 register offsets */
+#define	USB_PHY_PLL_REG12		0x130
+#define	USB_PHY_PLL_LDO_REF_EN		BIT(5)
+#define	USB_PHY_PLL_LDO_REF_EN_EN	BIT(4)
+
 #define DWC3_AM62_AUTOSUSPEND_DELAY	100
 
 struct dwc3_am62 {
 	struct device *dev;
 	void __iomem *usbss;
+	void __iomem *phy;
 	struct clk *usb2_refclk;
 	int rate_code;
 	struct regmap *syscon;
@@ -140,6 +146,16 @@ static inline void dwc3_ti_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
 	writel(value, (am62->usbss) + offset);
 }
 
+static inline u32 dwc3_ti_phy_readl(struct dwc3_am62 *am62, u32 offset)
+{
+	return readl((am62->phy) + offset);
+}
+
+static inline void dwc3_ti_phy_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
+{
+	writel(value, (am62->phy) + offset);
+}
+
 static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 {
 	struct device *dev = am62->dev;
@@ -201,6 +217,12 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 		return PTR_ERR(am62->usbss);
 	}
 
+	am62->phy = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(am62->phy)) {
+		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
+		am62->phy = NULL;
+	}
+
 	am62->usb2_refclk = devm_clk_get(dev, "ref");
 	if (IS_ERR(am62->usb2_refclk)) {
 		dev_err(dev, "can't get usb2_refclk\n");
@@ -227,6 +249,13 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Workaround Errata i2409 */
+	if (am62->phy) {
+		reg = dwc3_ti_phy_readl(am62, USB_PHY_PLL_REG12);
+		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
+		dwc3_ti_phy_writel(am62, USB_PHY_PLL_REG12, reg);
+	}
+
 	/* VBUS divider select */
 	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
 	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
-- 
2.34.1


