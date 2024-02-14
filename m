Return-Path: <linux-kernel+bounces-65005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78497854679
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAF41F23772
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE061AAD4;
	Wed, 14 Feb 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chg1WU9g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9971AAC4;
	Wed, 14 Feb 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904125; cv=none; b=ndifOT/96zfslGHPgJIL1G0YU5ceB3PDTISfmutopeF6FbHBKSqp8ts//Rd26TtT3A1Qx8Aq2z8CPs2ljH7iA3bt7TpcWUUYZ7EmWO1MWXqTzYRd8IO+rpyTnQzGLyurJX5pTcL71cfCGWkUNBMPoJbfq00DTUbIuSW+8ni3Gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904125; c=relaxed/simple;
	bh=6PUcC/csq5fQvr9+kVvXnCmkEzTXjd+DEMWwhUxgkws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8sK55irtKrB4vPqelG5aPx8P+pg1o4vOyBI7iIActMiSqSrGZUT3PmUlM9dDzRlJebHSr0ODDeNgAX3WmUj1PvhtSEr0QF/t6vgsLeW5MIl2C26+TQv7jww5j1sF3mudQQDzMsg+g1OvEybwpIr2yLS0jIfWaBtZNAb5iicLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chg1WU9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6B2C433F1;
	Wed, 14 Feb 2024 09:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707904124;
	bh=6PUcC/csq5fQvr9+kVvXnCmkEzTXjd+DEMWwhUxgkws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=chg1WU9g7reS7OYILqKi3gPx1pMQhgI3henHrdOcxfpTLGLTuTsojGDkIP86YnmEz
	 ItVPNspOxNeUHlAgvM83atKQ2+dcNBUc+bj80YnuAkA5eGXaDo0TQvR8EtVLumGVwn
	 LSO50gTuLiL4iKmixcS3ZlZ2hf6WwvD6IiZfhkSlUtM+VFEkm05x1wpZEQmy8FN57U
	 QzbhNF7aXKI3LxQnu0T/M9gb/0dM0fEcBVzFkDB7KB4dl7+t2+Sk0JNo8N0BKHiEAT
	 mH6qPWo7Ck3Uvddya/w9GXsNnamZIcklmzz6Sqsp1uY/YuH4DfK5g2Rxj666/aIJqB
	 E+HVeu8QoaPQQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 14 Feb 2024 11:46:49 +0200
Subject: [PATCH v3 5/5] usb: dwc3-am62: add workaround for Errata i2409
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-for-v6-9-am62-usb-errata-3-0-v3-5-147ec5eae18c@kernel.org>
References: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
In-Reply-To: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: nm@ti.com, r-gunasekaran@ti.com, afd@ti.com, b-liu@ti.com, srk@ti.com, 
 francesco@dolcini.it, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=6PUcC/csq5fQvr9+kVvXnCmkEzTXjd+DEMWwhUxgkws=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlzIxm8KWDYg+HSQTW54dy3G5LJyxK8C/tbzPQW
 XFtI3WySAeJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcyMZgAKCRDSWmvTvnYw
 k9VhD/9+X1MeZYthg4izWH39FxY2P5FuMoRsFtyXb5iKBMAxx8mq6JQia5O1+VCXIFvGbNWDMlc
 sB45Ek//gEFjOH2c+JAEpB4daqAIeTqDWRkXl2Jr0epeF+7/csac2EH41dVOSnCM6GVMizlIGxz
 /dCzqw/PWMriRQG/hLalRLKeWhHuM8aL+RqmFZWbCbK1eakgfSCWFa1LqlHzR36WBMvlIcbyjjZ
 I04Im8TjkiB885hYHJeBtpbqgKJfGiWr7xCFfKueWBCcHuA+2FrCz94XwxxqeTaED8xxHTUTO9W
 HXY+1hssg7Tq8ENXcK+kN7nSPsR1fDdXXFffNKaBvo3daN935jKx5b+WSkkbOsRXz4l4u9Yw8FA
 TIa1WaaNyEn7jw99VrKaLo4LqjT3lYPH6GKr2dOg0UEQl1eYTDMH/wOI4Y8cHXkvXoQOTjgW4Ge
 TsTBXe2GQQg0CpnfTT0q4rQDcj332wR4sdzJmMKO4U1uucowNcQ6BU1wiLEa7E9rAw+ZJ5TqB2x
 Guv4VXqqcll2FXglJQKo3gl2y4IVR29qHCqB/+OHNRfepx5ut75Dw/up5WHFe6sDUzTwvuClEQw
 x3i8qiA2kPBYSvTmc14Ng8/aUDYM0dhAQ3TOCsc1QE//I5+Uj1wYO0iNKlj7O8SkvMFe7bJfhxk
 zR/QQh1hRNvHDog==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

All AM62 devices have Errata i2409 [1] due to which
USB2 PHY may lock up due to short suspend.

Workaround involves setting bit 5 and 4 PLL_REG12
in PHY2 register space after USB controller is brought
out of LPSC reset but before controller initialization.

Handle this workaround.

[1] - https://www.ti.com/lit/er/sprz487d/sprz487d.pdf

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:

v3:
- move requesting of PHY2 region to right where we need it

v2:
- don't add phy read/write helpers or add phy to private data
	https://lore.kernel.org/all/20240205141221.56076-5-rogerq@kernel.org/

v1: https://lore.kernel.org/all/20240201121220.5523-5-rogerq@kernel.org/
---
 drivers/usb/dwc3/dwc3-am62.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index af1ce934e7fb..163278050595 100644
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
@@ -227,6 +233,17 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Workaround Errata i2409 */
+	phy = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
+		phy = NULL;
+	} else {
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


