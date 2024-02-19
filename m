Return-Path: <linux-kernel+bounces-72002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E930F85ADB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272031C219FE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A925577E;
	Mon, 19 Feb 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkotpivV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6F53E22;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378079; cv=none; b=mbY4zbFnZ5CajkiUZ9/SB6aqT9a5YEpw4B1PYpBSt7umP+QdaW0toCZ5ImEpFZWzwPsrNpcrOKSFBdud+tbxfP0jpmfgyhGS0Eenxu8msnB5rGrEZ5l5DwlW1llyfb+y1tCp8wotGvEM8xO9sK05JnAealHYTKUsbYYT2WnKk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378079; c=relaxed/simple;
	bh=fSZGw8CHrtheqHYmGL9yCRQ6avDh/svcGOMbahUkH18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZwsOHGk3a0jCpzYu6QoOgHmZlNnaoXPaTcuYspdEEd/AUhlqHR2luoTqci8/JV9SCeGN3qxgnXT1XBnZGg8a8dozsN0lYwrv2j0seAyFDeC+QTv7yFts7i6s0Uv+y17pdPno1K8IbN5q4FqHTvO1HohrBGBeIrenVaralEoLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkotpivV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D79FC4166A;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708378079;
	bh=fSZGw8CHrtheqHYmGL9yCRQ6avDh/svcGOMbahUkH18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kkotpivV3qBGtd35q7KqBauD+c7x3sscudQ5oB9JtiEVemDmyNadxo0oNnUh1npEc
	 E9HJqgEkQOlchjjTWp+OW4+A6deuOFnu+tETp3SsOqDQYJ8knnsDtOpNvTkVkclr6f
	 KpcwQT/4pYX4SLn3Hp+RdHwne+XU2PqTfwf2sAIAmkGeuQXpb1f1MMhdc5zgDVxo65
	 gO4qvVa2RyRi8lVhwCVbDdVwsw8Tb9KKZEE4hIvz0In3aqv7SL7E2s6/CldF1xvBOd
	 jUmEGMoZ+HCJNdfk1u8tQ1HaBxiq1IJfRqrs3BGiSqPKQwhEmVRMivMdd4Ge+UAgFH
	 DLuToMwXIjYFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47607C54788;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 05:28:01 +0800
Subject: [PATCH RFC v3 4/5] phy: hisilicon: hisi-inno-phy: add support for
 Hi3798MV200 INNO PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-inno-phy-v3-4-893cdf8633b4@outlook.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
In-Reply-To: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708378078; l=4896;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=GrCYJatgoRWu7Bx47GQoBXbcdNOq+uSu0U+veti+reE=;
 b=ou3NyvShEGVdWHjXOWZHUrDCDkQq0AwopgQeh6RbfmD6RJSnEFQ8RhcVdlRIzycIJ7DskzFF8
 PmGGLHUwY9oBtCsuDnvrcIQBJRY2W7HhlRxK7ag6YVYY/WSRcVROpGM
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Direct MMIO resgiter access is used by Hi3798MV200. For other models,
of_iomap() returns 0 due to insufficient length. So they are unaffected.

Also Hi3798MV200 INNO PHY has an extra reset required to be deasserted,
switch to reset_control_bulk_() APIs to resolve this.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 65 ++++++++++++++++++------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index b7e740eb4752..5175e5a351ac 100644
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
@@ -50,7 +52,7 @@ struct hisi_inno_phy_port {
 struct hisi_inno_phy_priv {
 	void __iomem *mmio;
 	struct clk *ref_clk;
-	struct reset_control *por_rst;
+	struct reset_control *rsts;
 	unsigned int type;
 	struct hisi_inno_phy_port ports[INNO_PHY_PORT_NUM];
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
@@ -104,7 +111,7 @@ static int hisi_inno_phy_init(struct phy *phy)
 		return ret;
 	udelay(REF_CLK_STABLE_TIME);
 
-	reset_control_deassert(priv->por_rst);
+	reset_control_deassert(priv->rsts);
 	udelay(POR_RST_COMPLETE_TIME);
 
 	/* Set up phy registers */
@@ -122,7 +129,7 @@ static int hisi_inno_phy_exit(struct phy *phy)
 	struct hisi_inno_phy_priv *priv = port->priv;
 
 	reset_control_assert(port->utmi_rst);
-	reset_control_assert(priv->por_rst);
+	reset_control_assert(priv->rsts);
 	clk_disable_unprepare(priv->ref_clk);
 
 	return 0;
@@ -158,15 +165,16 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->ref_clk))
 		return PTR_ERR(priv->ref_clk);
 
-	priv->por_rst = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(priv->por_rst))
-		return PTR_ERR(priv->por_rst);
+	priv->rsts = devm_reset_control_array_get(dev, false, false);
+	if (IS_ERR(priv->rsts))
+		return PTR_ERR(priv->rsts);
 
 	priv->type = (uintptr_t) of_device_get_match_data(dev);
 
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


