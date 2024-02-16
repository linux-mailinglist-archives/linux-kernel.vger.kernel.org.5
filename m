Return-Path: <linux-kernel+bounces-68864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE3858118
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A11B263F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E3B130E31;
	Fri, 16 Feb 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYUmG14Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314512F590;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096887; cv=none; b=Y/XHDAx2ON+Pe7l39jAeiWygHppEoTWx0k3i9sD7YH1UCY8g9PjXDJYcZJsu4RvIhGxYMItaQW+J1qY+LNa/beikXX++OHrvm7FEwOhrvZnhlv+MevRRtziWAWVuvHSIkCAmCN22xN2sZp36n1OuyX4hmvkQW+6hqv2FQGxkybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096887; c=relaxed/simple;
	bh=VZRY9XMcrLAgmTWhll1wn7de+3/sRUO6L2Lrel3FpI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPqKCXtV40olTZSb5PnjFldVGf5q04UpzVa8Yp0MzjeHs9jRrRa8ejeYGzq4xTKJkktSifLSShtNg20J5digjRqtnTYx+WaHypmv30y3tfU7sHogTPucfPXuK6Abz0HuH5l3XVgHhKZYu0UDjfHyF/2Uy5Q8oYcVjK+YUIQMbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYUmG14Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FAF9C43399;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708096887;
	bh=VZRY9XMcrLAgmTWhll1wn7de+3/sRUO6L2Lrel3FpI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MYUmG14Y6GAR7dXeLLMyO/HceOQZTMXcdhkW2OLPis21rUNEunHY1VX/sfoEyQKGt
	 /GBdMNvLiaomKDwHrA+o6jfiJw4eRVCkY7s9EQ9S/Sp5DVRq6jC8PRbeSwbBBdwZpl
	 MjMvtr5EMjIy8005XVToeJwH/MpFyoQ1tmz5Fn/Dbp2UElV6dfjZBjqEyj1XyGcwqQ
	 HaoOqwkaObYZjBL1rJHLCmPE045/5JUT9XTQ/5Zl/C+btb15kresMHFWFAq3wa+0Bb
	 gMmIU74Ie0gmEdLyNrka4Dv3sWwDn/f0FSJMsX7Ord0u0MiA79XHAhc3FB3GIDc4z6
	 bg2r6ydx+kupA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F61FC48BF6;
	Fri, 16 Feb 2024 15:21:27 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 23:21:03 +0800
Subject: [PATCH RFC 3/4] phy: hisi-inno-usb2: add support for direct MMIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-inno-phy-v1-3-1ab912f0533f@outlook.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
In-Reply-To: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708096886; l=3548;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=vlXiKqsLZeXsfy+2X2tFbKV08QHZormBiBHhDir/Zg8=;
 b=PvrXOIVdC8a36f4CWMQWiDK4swW9T8EN05s/5LxcRoeUztInX+RUWn2ky2HoAJtxOFlS6uM64
 yd2w5HpwpGgAkRRgHzbqCMWE3hQipcLwTE0595hdjY5aZZupxZNjCY0
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This method of resgiter access is used by Hi3798MV200. For other models,
of_iomap() returns 0 due to insufficient length. So they are unaffected.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 53 +++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index b7e740eb4752..12a158fb749c 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -43,6 +44,7 @@
 #define PHY_CLK_ENABLE		BIT(2)
 
 struct hisi_inno_phy_port {
+	void __iomem *base;
 	struct reset_control *utmi_rst;
 	struct hisi_inno_phy_priv *priv;
 };
@@ -62,26 +64,31 @@ static void hisi_inno_phy_write_reg(struct hisi_inno_phy_priv *priv,
 	u32 val;
 	u32 value;
 
-	if (priv->type == PHY_TYPE_0)
-		val = (data & PHY_TEST_DATA) |
-		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
-		      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
-		      PHY0_TEST_WREN | PHY0_TEST_RST;
-	else
-		val = (data & PHY_TEST_DATA) |
-		      ((addr << PHY_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
-		      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
-		      PHY1_TEST_WREN | PHY1_TEST_RST;
-	writel(val, reg);
-
-	value = val;
-	if (priv->type == PHY_TYPE_0)
-		value |= PHY0_TEST_CLK;
-	else
-		value |= PHY1_TEST_CLK;
-	writel(value, reg);
-
-	writel(val, reg);
+	if (priv->ports[port].base)
+		// stride is 4
+		writel(data, (u32 *)priv->ports[port].base + addr);
+	else {
+		if (priv->type == PHY_TYPE_0)
+			val = (data & PHY_TEST_DATA) |
+			      ((addr << PHY_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
+			      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
+			      PHY0_TEST_WREN | PHY0_TEST_RST;
+		else
+			val = (data & PHY_TEST_DATA) |
+			      ((addr << PHY_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
+			      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
+			      PHY1_TEST_WREN | PHY1_TEST_RST;
+		writel(val, reg);
+
+		value = val;
+		if (priv->type == PHY_TYPE_0)
+			value |= PHY0_TEST_CLK;
+		else
+			value |= PHY1_TEST_CLK;
+		writel(value, reg);
+
+		writel(val, reg);
+	}
 }
 
 static void hisi_inno_phy_setup(struct hisi_inno_phy_priv *priv)
@@ -167,6 +174,7 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 	for_each_child_of_node(np, child) {
 		struct reset_control *rst;
 		struct phy *phy;
+		void __iomem *base;
 
 		rst = of_reset_control_get_exclusive(child, NULL);
 		if (IS_ERR(rst)) {
@@ -174,7 +182,10 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 			return PTR_ERR(rst);
 		}
 
+		base = of_iomap(child, 0);
+
 		priv->ports[i].utmi_rst = rst;
+		priv->ports[i].base = base;
 		priv->ports[i].priv = priv;
 
 		phy = devm_phy_create(dev, child, &hisi_inno_phy_ops);
@@ -205,6 +216,8 @@ static const struct of_device_id hisi_inno_phy_of_match[] = {
 	  .data = (void *) PHY_TYPE_0 },
 	{ .compatible = "hisilicon,hi3798mv100-usb2-phy",
 	  .data = (void *) PHY_TYPE_1 },
+	{ .compatible = "hisilicon,hi3798mv200-usb2-phy",
+	  .data = (void *) PHY_TYPE_0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, hisi_inno_phy_of_match);

-- 
2.43.0


