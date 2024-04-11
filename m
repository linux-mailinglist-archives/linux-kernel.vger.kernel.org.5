Return-Path: <linux-kernel+bounces-141145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11608A1AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD4728D436
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E01EECBD;
	Thu, 11 Apr 2024 15:41:56 +0000 (UTC)
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29FE1EE291;
	Thu, 11 Apr 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850116; cv=none; b=el7rT4LJ/udDMUSfVz176+VPijTuUkCHSR0DIKDeFt5YOv3n2b/wwrtnlEIggES6v6Ezzz0Klp290VAsU+jMdxRCeBtG2bqpvPiYRew2hwyUZsrbf/QH2ZbCt1fjErqeViIRgRhEDMyd452QUrvvurupquxEPY7/Mz7wUvh66CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850116; c=relaxed/simple;
	bh=sdve3zvrGeQnGmwpoWkNGk88ZE0iuKbJSVfpS5ImZi0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eG17ohzook5dyw3NTiTpwe/6Hl+SNhNfuATBtHWEt8uvNwTquCl+WWKKCh2+jzcB+NyrmdNka86gBJSQrpZNsNAzvLRVkdCGMgrHeRnT7dNzQcb2k7bolSYWCRwv3bTDLxoHTklkWvfvUpc+79x7cfq5gGux/Ag+d7n8ttO3bug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 924F94D70E;
	Thu, 11 Apr 2024 17:35:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [82.64.135.138])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id D66822003CA;
	Thu, 11 Apr 2024 17:35:24 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 2369040039; Thu, 11 Apr 2024 17:34:32 +0200 (CEST)
Date: Thu, 11 Apr 2024 17:34:32 +0200
From: Etienne Buira <etienne.buira@free.fr>
To: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][RFC][resend after bogus] gpio-syscon: do not report bogus
 error
Message-ID: <ZhgDCKhcHdwGoJ4Y@Z926fQmE5jqhFMgp6>
Mail-Followup-To: linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Do not call dev_err when gpio,syscon-dev is not set albeit unneeded.
gpio-syscon is used with rk3328 chip, but this iomem region is
documented in
Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml and
does not look like to require gpio,syscon-dev setting.

Signed-off-by: Etienne Buira <etienne.buira@free.fr>
X-Prefers: kind explanations over rotten tomatoes
---
 drivers/gpio/gpio-syscon.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 6e1a2581e6ae..14c4f224eb07 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -16,6 +16,7 @@
 #define GPIO_SYSCON_FEAT_IN	BIT(0)
 #define GPIO_SYSCON_FEAT_OUT	BIT(1)
 #define GPIO_SYSCON_FEAT_DIR	BIT(2)
+#define GPIO_SYSCON_FEAT_NODEV	BIT(3)
 
 /* SYSCON driver is designed to use 32-bit wide registers */
 #define SYSCON_REG_SIZE		(4)
@@ -27,7 +28,8 @@
  * @flags:		Set of GPIO_SYSCON_FEAT_ flags:
  *			GPIO_SYSCON_FEAT_IN:	GPIOs supports input,
  *			GPIO_SYSCON_FEAT_OUT:	GPIOs supports output,
- *			GPIO_SYSCON_FEAT_DIR:	GPIOs supports switch direction.
+ *			GPIO_SYSCON_FEAT_DIR:	GPIOs supports switch direction,
+ *			GPIO_SYSCON_FEAT_NODEV:	gpio,syscon-dev do not have to be set.
  * @bit_count:		Number of bits used as GPIOs.
  * @dat_bit_offset:	Offset (in bits) to the first GPIO bit.
  * @dir_bit_offset:	Optional offset (in bits) to the first bit to switch
@@ -149,7 +151,7 @@ static void rockchip_gpio_set(struct gpio_chip *chip, unsigned int offset,
 
 static const struct syscon_gpio_data rockchip_rk3328_gpio_mute = {
 	/* RK3328 GPIO_MUTE is an output only pin at GRF_SOC_CON10[1] */
-	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.flags		= GPIO_SYSCON_FEAT_OUT | GPIO_SYSCON_FEAT_NODEV,
 	.bit_count	= 1,
 	.dat_bit_offset = 0x0428 * 8 + 1,
 	.set		= rockchip_gpio_set,
@@ -221,19 +223,21 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->syscon))
 		return PTR_ERR(priv->syscon);
 
-	ret = of_property_read_u32_index(np, "gpio,syscon-dev", 1,
-					 &priv->dreg_offset);
-	if (ret)
-		dev_err(dev, "can't read the data register offset!\n");
+	if (!(priv->data->flags & GPIO_SYSCON_FEAT_NODEV)) {
+		ret = of_property_read_u32_index(np, "gpio,syscon-dev", 1,
+						 &priv->dreg_offset);
+		if (ret)
+			dev_err(dev, "can't read the data register offset!\n");
 
-	priv->dreg_offset <<= 3;
+		priv->dreg_offset <<= 3;
 
-	ret = of_property_read_u32_index(np, "gpio,syscon-dev", 2,
-					 &priv->dir_reg_offset);
-	if (ret)
-		dev_dbg(dev, "can't read the dir register offset!\n");
+		ret = of_property_read_u32_index(np, "gpio,syscon-dev", 2,
+						 &priv->dir_reg_offset);
+		if (ret)
+			dev_dbg(dev, "can't read the dir register offset!\n");
 
-	priv->dir_reg_offset <<= 3;
+		priv->dir_reg_offset <<= 3;
+	}
 
 	priv->chip.parent = dev;
 	priv->chip.owner = THIS_MODULE;

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.0


