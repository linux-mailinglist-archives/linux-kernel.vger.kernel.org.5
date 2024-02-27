Return-Path: <linux-kernel+bounces-82953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D7868C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F3D288F12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2B1384AF;
	Tue, 27 Feb 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlJQJE9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F13136991;
	Tue, 27 Feb 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025888; cv=none; b=U2pBOGJSyo2GiS/8e9UdgT4xDHy/ANkaYraRTP6C4YInfMlU0IdftavtWlu/2/Ce7QIXXprqfxFvE/knZu7n5phUpdYYBSQky27wpRqZJMLTk8Swm94LRFquUL4LIorApNSgeSIWPmbS5OA5f+5ec4SxnegHw2d/hG7Qt5906kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025888; c=relaxed/simple;
	bh=nRhSXkHSCQaq7hKSlocKBCiXPwHTyVzbdYzD4QN2vWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbYE66I6/l2E7NtJrhDM5QakoPsSpm8HVkVrm+wsxAkaBhaSho13mYHM1JkPxHPGVXzwgDTjMBwJf/5mRqbei8BotaB1d9W6KuxGGplkf38Rd7XlA/TSGinqQEkI9mCN1ta09G5TFOxgKpwKwaXoLZPfVRvygs8oH8X1RhaZwLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlJQJE9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3979AC433C7;
	Tue, 27 Feb 2024 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709025887;
	bh=nRhSXkHSCQaq7hKSlocKBCiXPwHTyVzbdYzD4QN2vWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MlJQJE9SAyEXCNaj2L/4R2vf5OVfDQlJU+S2DHAwF5zULcTae7xCZiLRbyGTmCwaa
	 1/rqrqFicvhHR23SDLm9MIYHyqaqM9xvoHX9DhjWbmGXzSOdX0Pf1NdjlQaGG0gMqE
	 P0YZsqdzWBjvw6cdbOF/fVAZI10PX8u0NH4kcj7ZJxg7av0hE5xhqemTYjFK9Xqmbp
	 yp1HEsMt0gAfaeu2jrl5/e6T0tyTECeOp4ozUJlGCxWcbuylfZ6soRUOzqedmNvjdB
	 DmlFF+SSCbitLFojlxlaof+GRoQyyxh1e9PoCjtBw9zADT64Q2uGjStl9S9on0ZWWr
	 tvuzjAfDwm7Rw==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 27 Feb 2024 11:23:51 +0200
Subject: [PATCH v4 4/4] usb: dwc3-am62: add workaround for Errata i2409
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-for-v6-9-am62-usb-errata-3-0-v4-4-0ada8ddb0767@kernel.org>
References: <20240227-for-v6-9-am62-usb-errata-3-0-v4-0-0ada8ddb0767@kernel.org>
In-Reply-To: <20240227-for-v6-9-am62-usb-errata-3-0-v4-0-0ada8ddb0767@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=nRhSXkHSCQaq7hKSlocKBCiXPwHTyVzbdYzD4QN2vWA=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3apMqGm1+GkACNuRhdnWag9WVMqRyI3WZj4ma
 p1ovgKuEJiJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZd2qTAAKCRDSWmvTvnYw
 k7YyD/9Atkwmu1zPusaDS+gHdq4hF/+AhfHRq9LaIeAi/RkQ5Io4gtMvQ3fcZUUj3stWI2jQDDf
 jFlQRPyPRBtzQsqNNa++JlzBm8PUeyTZpNVNwhs7K80iIV+hnDBa5zSIYNslGPa7VVFz/+8h8J2
 uSKv+hMF/Oo+AADAxhLV2Xuach+Kk54Lq1NeStrr6qD2mUAF5pUaUZlRpQGYScwIfxGC0W7JW3u
 aRpbSW03T1riLcaKEt0FvfZpevQTRnc1IoEvwiRpWFJ8/eSaLCn/6AeCm65J1vhpM19P94h2oVU
 DuKY2qau4e82wkZdptO3Mqwqqr8riMkt2MZKinx9iCKbQMHd0LILa5wfmahpf3Aazh4z50SvW4E
 tN21qTROhGSxb295jQdhMmZVk+4voxmDY8yaP+Viuzd/RCdGHfKVBreEpvU1PJ5+p74ajLhDtlg
 48h7ygOs/qbKYSpPz+x12Nnm+uwXhxHaHrHUii+U7/4OGvSYlBvo6R6NFYJD5qs3L4lg3RZymyD
 yysvaZJwDGH2J0sFstawEoEgc/cz/2EFVn5CFJ1Y/i8Ckk6OFPQisOHqpcIclvvWfXFkH0BOONX
 8NraNhqdWEa2MZrc8c3RrkxqLHTzm8Wco17wHP6lcOG//5UjfoZyv3bkiqbN0PN1IYz5m9/MtxE
 uP8cgNOF/i1NzGA==
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
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
Changelog:
v4: Added Acked-by
v3: move requesting of PHY2 region to right where we need it
v2: don't add phy read/write helpers or add phy to private data
v1: https://lore.kernel.org/all/20240201121220.5523-5-rogerq@kernel.org/
---
 drivers/usb/dwc3/dwc3-am62.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 09b1f5a1c4fb..fad151e78fd6 100644
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


