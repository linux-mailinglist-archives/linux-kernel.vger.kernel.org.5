Return-Path: <linux-kernel+bounces-103784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8801287C46F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D74B217A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBFF768F1;
	Thu, 14 Mar 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ABt2KcCT"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2F763F3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449249; cv=none; b=fkoDpYYBg3REzczpQ0Ynf1sUBPggSRsJn5DMJtU9bSlWDn9Vait0W6ie4NPdg1Mll+gq/NXwnnToTxW8sFt/AzHiwFflHuV513SAfbcp4bLpAHSW+GriI8YcpyKwDYoIVJahlXv1Q43dgQTvhZulqnNH22/bETXi28fG7guLUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449249; c=relaxed/simple;
	bh=UIF4J65ehQgwFgLwNNQv7+xO+t1wQO4o0nbyeYHrPkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMDURIH2Tesx01VclFI3I6cJYKTuPHdZFTCGak/z7pCS1pQCBGH2sOTWOS68dERpwhRq31nGCxVKeJjsAUrkSAkiH7NRqfL2SvEf2ZrRLTMjy0OveBLjmzz71HdAlq1+9g3X6CD4H7AbPgYtmUErfzR2CsFaKWoGnZ4CoSvMdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ABt2KcCT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-430a25ed4e7so5532971cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710449246; x=1711054046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rebonSk8UmoBj8EHW0+x6iBNgmHsWXTbExBrTy61JIM=;
        b=ABt2KcCTKTlgPCIMiO/hqlySV6jsyDRateiNcb72R8QpY/yS5ODckuXKIMfA8lhQHj
         j6wF05HpDTgCQaCxKCvMay4NbaEt15cQc7gMzNaGhg3Wr60X9SFLI14/8MWhRTPZ7hwc
         EbSPDU2hQoWKRzyE5vCx7ctgVtvqwBEHSzZP6WNDaN53zl3OCcYSZZAWTuukUI7MYYGX
         rd2Btwtj4XzJ0D4HrVypQJCpCbSI6DYm4xxYV2YPuHG4wkvgMIcV1cLj2mqJ8DMhVUNO
         CwkMqhKUlWCd6+A/zZZUEt+gNINZ8Eckf6tMr6iIgP2CG66TbaiBwK2G9sAjrRfkTpXB
         S+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449246; x=1711054046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rebonSk8UmoBj8EHW0+x6iBNgmHsWXTbExBrTy61JIM=;
        b=GxMRofCvjGRPtz/kQUJD1BoeD8JzqYIReqiQmVxmcsW/4lQegHxm4OsIMMrPsD3Y6k
         y4sEFXysAR/Qz5u7HXHawNOQJDegV39uj59PUG+30e7ODGPeDdvy/3dcFzJ5ULebsS1K
         FF/AwWPNlo1by1RGyOgRIwSJXv+KFeK0upeP1GhawxN8Kcu0Qkm1g+kzL69M2DMiBSbN
         59gL/fs3h8NydEcVZoqFVYsbvofQgcFeNR2z2RffVCyZbUOIaf/L6RsSbx2O+BuzBRlR
         bw6k2XykC2TCOzJUaLQD4YVJvw0LmZGQD4pvbY4t7vTfxVhmJYlO8Ba4UIgKlN43vsDj
         4N9Q==
X-Gm-Message-State: AOJu0YwdYpNqTvP3ScQSVjhJPsJaC5cEd/eNShb7Jpci+tLayTR4phqX
	ijYhLDkPEjXYmm5zq5D06Fv0iSJMPJWGsXANcul5BNeO9kNCwi/1cXJiPhQSH0o=
X-Google-Smtp-Source: AGHT+IEiWI7uwJUkA2nC89WYPMmqCqUoLsa0nMoO8D5PL661KnZykIIys9gvWKTzQQJUhvwk5sxNyw==
X-Received: by 2002:a05:622a:1214:b0:42e:b2c3:d77a with SMTP id y20-20020a05622a121400b0042eb2c3d77amr2173669qtx.46.1710449246262;
        Thu, 14 Mar 2024 13:47:26 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id n16-20020ac86750000000b0042eef160b4dsm1165272qtp.76.2024.03.14.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:47:26 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 2/2] pwm: axi-pwmgen: support version 2.00.a
Date: Thu, 14 Mar 2024 16:47:22 -0400
Message-ID: <20240314204722.1291993-3-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314204722.1291993-1-tgamblin@baylibre.com>
References: <20240314204722.1291993-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the AXI PWMGEN v2 IP block. This version is
nearly identical to v1 other than it supports up to 16 channels instead
of 4 and a few of the memory mapped registers have moved.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 62 ++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 0c8f7f893a21..539625c404ac 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -32,16 +32,25 @@
 #define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
 #define AXI_PWMGEN_REG_CONFIG		0x10
 #define AXI_PWMGEN_REG_NPWM		0x14
-#define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (12 * (ch)))
-#define AXI_PWMGEN_CHX_DUTY(ch)		(0x44 + (12 * (ch)))
-#define AXI_PWMGEN_CHX_OFFSET(ch)	(0x48 + (12 * (ch)))
+#define AXI_PWMGEN_CHX_PERIOD(v, ch)	((v)->period_base + (v)->ch_step * (ch))
+#define AXI_PWMGEN_CHX_DUTY(v, ch)	((v)->duty_base + (v)->ch_step * (ch))
+#define AXI_PWMGEN_CHX_OFFSET(v, ch)	((v)->offset_base + (v)->ch_step * (ch))
 #define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification number to test during setup */
 #define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
 #define AXI_PWMGEN_RESET		BIT(0)
 
+struct axi_pwm_variant {
+	u8 period_base;
+	u8 duty_base;
+	u8 offset_base;
+	u8 major_version;
+	u8 ch_step;
+};
+
 struct axi_pwmgen_ddata {
 	struct regmap *regmap;
 	unsigned long clk_rate_hz;
+	const struct axi_pwm_variant *variant;
 };
 
 static const struct regmap_config axi_pwmgen_regmap_config = {
@@ -50,12 +59,30 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.val_bits = 32,
 };
 
+static const struct axi_pwm_variant pwmgen_1_00_variant = {
+	.period_base = 0x40,
+	.duty_base = 0x44,
+	.offset_base = 0x48,
+	.major_version = 1,
+	.ch_step = 12,
+};
+
+static const struct axi_pwm_variant pwmgen_2_00_variant = {
+	.period_base = 0x40,
+	.duty_base = 0x80,
+	.offset_base = 0xC0,
+	.major_version = 2,
+	.ch_step = 4,
+};
+
+
 static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
 	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
 	unsigned int ch = pwm->hwpwm;
 	struct regmap *regmap = ddata->regmap;
+	const struct axi_pwm_variant *variant = ddata->variant;
 	u64 period_cnt, duty_cnt;
 	int ret;
 
@@ -70,7 +97,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (period_cnt == 0)
 			return -EINVAL;
 
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), period_cnt);
 		if (ret)
 			return ret;
 
@@ -78,15 +105,15 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (duty_cnt > UINT_MAX)
 			duty_cnt = UINT_MAX;
 
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), duty_cnt);
 		if (ret)
 			return ret;
 	} else {
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), 0);
 		if (ret)
 			return ret;
 
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), 0);
 		if (ret)
 			return ret;
 	}
@@ -99,11 +126,12 @@ static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
 	struct regmap *regmap = ddata->regmap;
+	const struct axi_pwm_variant *variant = ddata->variant;
 	unsigned int ch = pwm->hwpwm;
 	u32 cnt;
 	int ret;
 
-	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), &cnt);
 	if (ret)
 		return ret;
 
@@ -111,7 +139,7 @@ static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	state->period = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
 
-	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), &cnt);
 	if (ret)
 		return ret;
 
@@ -127,7 +155,8 @@ static const struct pwm_ops axi_pwmgen_pwm_ops = {
 	.get_state = axi_pwmgen_get_state,
 };
 
-static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
+static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev, 
+			    const struct axi_pwm_variant *variant)
 {
 	int ret;
 	u32 val;
@@ -146,7 +175,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
 	if (ret)
 		return ret;
 
-	if (ADI_AXI_PCORE_VER_MAJOR(val) != 1) {
+	if (ADI_AXI_PCORE_VER_MAJOR(val) != variant->major_version) {
 		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral version %u.%u.%u\n",
 			ADI_AXI_PCORE_VER_MAJOR(val),
 			ADI_AXI_PCORE_VER_MINOR(val),
@@ -178,9 +207,14 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 	struct pwm_chip *chip;
 	struct axi_pwmgen_ddata *ddata;
 	struct clk *clk;
+	const struct axi_pwm_variant *variant;
 	void __iomem *io_base;
 	int ret;
 
+	variant = device_get_match_data(dev);
+	if (!variant)
+		return -EINVAL;
+
 	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
@@ -190,7 +224,7 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "failed to init register map\n");
 
-	ret = axi_pwmgen_setup(regmap, dev);
+	ret = axi_pwmgen_setup(regmap, dev, variant);
 	if (ret < 0)
 		return ret;
 
@@ -199,6 +233,7 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	ddata = pwmchip_get_drvdata(chip);
 	ddata->regmap = regmap;
+	ddata->variant = variant;
 
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
@@ -224,7 +259,8 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id axi_pwmgen_ids[] = {
-	{ .compatible = "adi,axi-pwmgen-1.00.a" },
+	{ .compatible = "adi,axi-pwmgen-1.00.a", .data = &pwmgen_1_00_variant },
+	{ .compatible = "adi,axi-pwmgen-2.00.a", .data = &pwmgen_2_00_variant },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, axi_pwmgen_ids);
-- 
2.44.0


