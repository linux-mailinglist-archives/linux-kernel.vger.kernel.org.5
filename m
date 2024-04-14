Return-Path: <linux-kernel+bounces-144378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B18A452F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277121F21347
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC3136E21;
	Sun, 14 Apr 2024 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="VbVn7xQy"
Received: from mail-108-mta25.mxroute.com (mail-108-mta25.mxroute.com [136.175.108.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755213699C
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127017; cv=none; b=BCGHvaP3hmoBCkBEOkseJ1WiMgtCi0lnMgRFnumspV8nXWu5pni1aidze/neUl06rC90K7fbGz+tsnQyTW2L8Gep/uyO6kLrARlQPrCetyBkkGOTaG8FnLWkfrLq3MD5/RcQYgcHpBYk1RF1h7G52wWEnpD9HyTV1XCFJKK2NWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127017; c=relaxed/simple;
	bh=/appuRh7QR4oppenmbepS6ozjwx24OFaCqI22tl7X/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tS5n4r7w5OKVhYl4PmwEZNsVKOtQ1DF4JZH3S+w8dDkU3o+K5wMb1HO3NxjDqTCq81aoO2kB7+ByP3iwsPgQOyeKI/MBFqAxeP3FsQFTP7kHDaL5x14qqUyfjv0I+rzBl1RU+xHHyqGieEEgyUM1KJA3kxAwyWZhBUJMzfMCYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=VbVn7xQy; arc=none smtp.client-ip=136.175.108.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta25.mxroute.com (ZoneMTA) with ESMTPSA id 18ede52ceab0003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 14 Apr 2024 20:35:52 +0000
X-Zone-Loop: 6030200e0a9c3cf43bf0156b5bb31f63390db692b006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8JaICCDIbxfFQFB9p4l2NBR215uf+cJpoqKWqbp9IrI=; b=VbVn7xQy9tIwahhJZUHqFwHLiL
	XLnsX0Xdxr+RaItGcYBxJJ+kiCP3Ww6ggSsSWc93YPtvgfMhXn6qRvzjdGE5Axy4SrppZcpaY5auC
	R3bgUW2fuhQZfRgRxy3e6JZXNq0zT+xEoAOLjJZWCjPFH4bnJAAhLZTi0tMLlbGxtcqAhmIDXLovB
	HSH9oXj45wgiyzPYu2PYFa1WSbik2m5+hPWcmPkSdsivudvtBxu7AX5Atx5XCzDbRyszTaLHlqGE+
	NeWxWj22dtVVVCtY3XCtngYY6DccttMkfgALM/y0qxM6MYS0xp3DQBdx6vgN47fUbxPXSpL5oumPe
	pXmXhbww==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>
Subject: [PATCH v4 19/25] media: i2c: imx258: Change register settings for variants of the sensor
Date: Sun, 14 Apr 2024 14:34:57 -0600
Message-ID: <20240414203503.18402-20-git@luigi311.com>
In-Reply-To: <20240414203503.18402-1-git@luigi311.com>
References: <20240414203503.18402-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Sony have advised that there are variants of the IMX258 sensor which
require slightly different register configuration to the mainline
imx258 driver defaults.

There is no available run-time detection for the variant, so add
configuration via the DT compatible string.

The Vision Components imx258 module supports PDAF, so add the
register differences for that variant

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/imx258.c | 47 ++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 32267d36b8f3..54f7625e60a3 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -321,8 +321,6 @@ static const struct imx258_reg mipi_642mbps_24mhz_4l[] = {
 
 static const struct imx258_reg mode_common_regs[] = {
 	{ 0x3051, 0x00 },
-	{ 0x3052, 0x00 },
-	{ 0x4E21, 0x14 },
 	{ 0x6B11, 0xCF },
 	{ 0x7FF0, 0x08 },
 	{ 0x7FF1, 0x0F },
@@ -345,7 +343,6 @@ static const struct imx258_reg mode_common_regs[] = {
 	{ 0x7FA8, 0x03 },
 	{ 0x7FA9, 0xFE },
 	{ 0x7B24, 0x81 },
-	{ 0x7B25, 0x00 },
 	{ 0x6564, 0x07 },
 	{ 0x6B0D, 0x41 },
 	{ 0x653D, 0x04 },
@@ -460,6 +457,33 @@ static const struct imx258_reg mode_1048_780_regs[] = {
 	{ 0x034F, 0x0C },
 };
 
+struct imx258_variant_cfg {
+	const struct imx258_reg *regs;
+	unsigned int num_regs;
+};
+
+static const struct imx258_reg imx258_cfg_regs[] = {
+	{ 0x3052, 0x00 },
+	{ 0x4E21, 0x14 },
+	{ 0x7B25, 0x00 },
+};
+
+static const struct imx258_variant_cfg imx258_cfg = {
+	.regs = imx258_cfg_regs,
+	.num_regs = ARRAY_SIZE(imx258_cfg_regs),
+};
+
+static const struct imx258_reg imx258_pdaf_cfg_regs[] = {
+	{ 0x3052, 0x01 },
+	{ 0x4E21, 0x10 },
+	{ 0x7B25, 0x01 },
+};
+
+static const struct imx258_variant_cfg imx258_pdaf_cfg = {
+	.regs = imx258_pdaf_cfg_regs,
+	.num_regs = ARRAY_SIZE(imx258_pdaf_cfg_regs),
+};
+
 static const char * const imx258_test_pattern_menu[] = {
 	"Disabled",
 	"Solid Colour",
@@ -637,6 +661,8 @@ struct imx258 {
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 
+	const struct imx258_variant_cfg *variant_cfg;
+
 	struct v4l2_ctrl_handler ctrl_handler;
 	/* V4L2 Controls */
 	struct v4l2_ctrl *link_freq;
@@ -1104,6 +1130,14 @@ static int imx258_start_streaming(struct imx258 *imx258)
 		return ret;
 	}
 
+	ret = imx258_write_regs(imx258, imx258->variant_cfg->regs,
+				imx258->variant_cfg->num_regs);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to set variant config\n",
+			__func__);
+		return ret;
+	}
+
 	ret = imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
 			       IMX258_REG_VALUE_08BIT,
 			       !!(imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK));
@@ -1491,6 +1525,10 @@ static int imx258_probe(struct i2c_client *client)
 
 	imx258->csi2_flags = ep.bus.mipi_csi2.flags;
 
+	imx258->variant_cfg = device_get_match_data(&client->dev);
+	if (!imx258->variant_cfg)
+		imx258->variant_cfg = &imx258_cfg;
+
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
 
@@ -1578,7 +1616,8 @@ MODULE_DEVICE_TABLE(acpi, imx258_acpi_ids);
 #endif
 
 static const struct of_device_id imx258_dt_ids[] = {
-	{ .compatible = "sony,imx258" },
+	{ .compatible = "sony,imx258", .data = &imx258_cfg },
+	{ .compatible = "sony,imx258-pdaf", .data = &imx258_pdaf_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx258_dt_ids);
-- 
2.44.0


