Return-Path: <linux-kernel+bounces-146823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281E28A6B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6E6B22876
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5280112C466;
	Tue, 16 Apr 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q5ai+EHa"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679912BEA9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271982; cv=none; b=g4nBvSs996pAgUHjlBSoYIaOuGamTjnWITBaBlRtfX1ULUe5NT00H2aX9L/cz+Mcfq+OuISg7QCGwkne/IYw+9eYWxM/olBM5NQfq4idWVKQoNGw1GP8TCC6jrqygLFZHy25/2E963THDZTHRlTCZG8BkLur8T2fAggyV+VJXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271982; c=relaxed/simple;
	bh=fVFt3TspoIf3x4uHfvW0rMMbgwzq4+eKFDrqeSJaUQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xm4MrJp0s7BcGnOQTvx3kxqFElrHrllUUmrQ3onaN5Q7ugeCmxvDRSEqskFpzXJ3FknF7059TOFVQHJFWz7pOV2A6Xfup0U9azgghIulWxvizYG4oRqZUnNm/gn1xMt1+IVqBnQ/u1349+dZ8dAZyW7ZRwN5kqPiWmQlpIN2R3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q5ai+EHa; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E46DF20010;
	Tue, 16 Apr 2024 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713271979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkjYb/heaYMzCjQ4QnbfLecl4jtQfd543suxAgCkx34=;
	b=Q5ai+EHaCMUt1LHzoBzp0RKUivr1riPA7SfjAObRdy9sv11F78Z2/Z2uVARG4ibWFm6KJQ
	7T5qEbMlrPGdB72T8U8EXbDN5udTOluG2lVK4Ktfe19oq7QXEy5h4owMDTuh4+VYhBJYra
	PIjpAltwcL7hCxDyMCFp8w4v+2f6SWckxX6Cju1FAx4TXg7b5CLTkDeWFp4f/YdmPgpKW7
	xpNBzNNwi6/YTERptsBBLBsRXcSVL2s/P1wIcGWxIv9dLPR8fZqKRwS5TXE8SAJSNzV2A0
	EzicZT71cPUzCyffhAgC9oH6el92omZVuB9HCFgZt8MVsFN6V7SrQ4gbGHL0AQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Tue, 16 Apr 2024 14:52:31 +0200
Subject: [PATCH 2/8] phy: ti: phy-j721e-wiz: split wiz_clock_init()
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-j7200-phy-s2r-v1-2-f15815833974@bootlin.com>
References: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
In-Reply-To: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

The wiz_clock_init() function mixes probe and hardware configuration.
Rename the wiz_clock_init() to wiz_clock_probe() and move the hardware
configuration part in a new function named wiz_clock_init().

This hardware configuration sequence must be called during the resume
stage of the driver.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 66 +++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 5fea4df9404e..ba670109e7ad 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1076,26 +1076,12 @@ static int wiz_clock_register(struct wiz *wiz)
 	return ret;
 }
 
-static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
+static void wiz_clock_init(struct wiz *wiz)
 {
-	const struct wiz_clk_mux_sel *clk_mux_sel = wiz->clk_mux_sel;
-	struct device *dev = wiz->dev;
-	struct device_node *clk_node;
-	const char *node_name;
 	unsigned long rate;
-	struct clk *clk;
-	int ret;
-	int i;
-
-	clk = devm_clk_get(dev, "core_ref_clk");
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk),
-				     "core_ref_clk clock not found\n");
 
-	wiz->input_clks[WIZ_CORE_REFCLK] = clk;
-
-	rate = clk_get_rate(clk);
-	if (rate >= 100000000)
+	rate = clk_get_rate(wiz->input_clks[WIZ_CORE_REFCLK]);
+	if (rate >= REF_CLK_100MHZ)
 		regmap_field_write(wiz->pma_cmn_refclk_int_mode, 0x1);
 	else
 		regmap_field_write(wiz->pma_cmn_refclk_int_mode, 0x3);
@@ -1119,6 +1105,38 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 		break;
 	}
 
+	if (wiz->input_clks[WIZ_CORE_REFCLK1]) {
+		rate = clk_get_rate(wiz->input_clks[WIZ_CORE_REFCLK1]);
+		if (rate >= REF_CLK_100MHZ)
+			regmap_field_write(wiz->pma_cmn_refclk1_int_mode, 0x1);
+		else
+			regmap_field_write(wiz->pma_cmn_refclk1_int_mode, 0x3);
+	}
+
+	rate = clk_get_rate(wiz->input_clks[WIZ_EXT_REFCLK]);
+	if (rate >= REF_CLK_100MHZ)
+		regmap_field_write(wiz->pma_cmn_refclk_mode, 0x0);
+	else
+		regmap_field_write(wiz->pma_cmn_refclk_mode, 0x2);
+}
+
+static int wiz_clock_probe(struct wiz *wiz, struct device_node *node)
+{
+	const struct wiz_clk_mux_sel *clk_mux_sel = wiz->clk_mux_sel;
+	struct device *dev = wiz->dev;
+	struct device_node *clk_node;
+	const char *node_name;
+	struct clk *clk;
+	int ret;
+	int i;
+
+	clk = devm_clk_get(dev, "core_ref_clk");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "core_ref_clk clock not found\n");
+
+	wiz->input_clks[WIZ_CORE_REFCLK] = clk;
+
 	if (wiz->data->pma_cmn_refclk1_int_mode) {
 		clk = devm_clk_get(dev, "core_ref1_clk");
 		if (IS_ERR(clk))
@@ -1126,12 +1144,6 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 					     "core_ref1_clk clock not found\n");
 
 		wiz->input_clks[WIZ_CORE_REFCLK1] = clk;
-
-		rate = clk_get_rate(clk);
-		if (rate >= 100000000)
-			regmap_field_write(wiz->pma_cmn_refclk1_int_mode, 0x1);
-		else
-			regmap_field_write(wiz->pma_cmn_refclk1_int_mode, 0x3);
 	}
 
 	clk = devm_clk_get(dev, "ext_ref_clk");
@@ -1141,11 +1153,7 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 
 	wiz->input_clks[WIZ_EXT_REFCLK] = clk;
 
-	rate = clk_get_rate(clk);
-	if (rate >= 100000000)
-		regmap_field_write(wiz->pma_cmn_refclk_mode, 0x0);
-	else
-		regmap_field_write(wiz->pma_cmn_refclk_mode, 0x2);
+	wiz_clock_init(wiz);
 
 	switch (wiz->type) {
 	case AM64_WIZ_10G:
@@ -1589,7 +1597,7 @@ static int wiz_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	ret = wiz_clock_init(wiz, node);
+	ret = wiz_clock_probe(wiz, node);
 	if (ret < 0) {
 		dev_warn(dev, "Failed to initialize clocks\n");
 		goto err_get_sync;

-- 
2.39.2


