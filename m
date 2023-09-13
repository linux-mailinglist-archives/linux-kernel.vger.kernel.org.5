Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8779E449
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbjIMJyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbjIMJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:54:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B1B1FD3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:54:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5007abb15e9so11371182e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694598841; x=1695203641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqhtzcGyFHDluGDjY5bQjlFxQW1yi0cE3p4JZH8FKz0=;
        b=ssmIRhy1mSisYkut48LhtZojZ1lknTHmP1p8aC87Iqc2BOscjRuCSUxZopuMljgUSt
         TuyVprXiaaZjL2OhIRwQfUmcRd//dNzpaqrHE2Dffu2p5EMGObH3ou2VATzYdbVeOjra
         sL0Z0OlfPE7Rh/EyqHo2wFIKMKhzXYauZLj4g4CZgObf8j6U/Xc5QewYm8IbdOhROmws
         3fv46nWfbkkMov+RrAdVEGNwl1DyXR8f4JHRKVcq5z68EfHfquTiFaJYlXo2bMuC5wok
         dVLYAkFiOsZQLKd3N/ast2aPbE4PSKeooSDwZE3BxeOWTcVRBy7yGH11ugfya1yy628W
         TLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694598841; x=1695203641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqhtzcGyFHDluGDjY5bQjlFxQW1yi0cE3p4JZH8FKz0=;
        b=I2TgJwLpx3J+LNzIaVmjtnu7EjmIF6oVx9IndwKp912k6Dt4QcCi4e5BV0+7HasisY
         CUBimhdKF+0Emnq3rLT7YT+bLP/ojAYw54Qm5Kz7Nz1cprAPyTB3AVQtJn726Mz9Ur/G
         cb2iBVX9+skWCqWnRSN2+6se0KcvppVl/zbEa6D0hEcXBotpb5NzRXic2Xsfo0YOpGKJ
         6um7GSBa+mUoQE69bIbI8Rs3pbLl/aYiIgbgtDrnS1wJhk3omD5ie7btKu6+9b6HYj1l
         eE6SUq47B8XwVooXsIczuCfJg08omPu2JZAZgsU86W9duL9m6hhB/K0DCtAsu01UY9Wr
         lu6w==
X-Gm-Message-State: AOJu0Yy19Tj2aIMoNNjx/vBSClFn0lKPUzjIJx6NFhuaXhrYDSdjB8bM
        cDSSedHCyhJmhQQ1vmTl04om7Q==
X-Google-Smtp-Source: AGHT+IHNbvyFQSnMJb6OfLYWUcESZqwdneFRKa8pRDV1Q+3U0qRNYgJV0xi45nmOtjU3fgbew0oEQw==
X-Received: by 2002:a2e:9c95:0:b0:2bf:b106:6296 with SMTP id x21-20020a2e9c95000000b002bfb1066296mr1992334lji.4.1694598841134;
        Wed, 13 Sep 2023 02:54:01 -0700 (PDT)
Received: from [10.167.154.1] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906939500b00985ed2f1584sm8092669ejx.187.2023.09.13.02.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:54:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 13 Sep 2023 11:53:24 +0200
Subject: [PATCH v2 2/4] phy: qualcomm: phy-qcom-eusb2-repeater: Use
 regmap_fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-eusb2_override-v2-2-7d8c893d93f6@linaro.org>
References: <20230830-topic-eusb2_override-v2-0-7d8c893d93f6@linaro.org>
In-Reply-To: <20230830-topic-eusb2_override-v2-0-7d8c893d93f6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694598835; l=6150;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=LovaKfaqbkXiJ4az1PcPQZkH3FJdcJGz/pvW4OALguE=;
 b=XQp+5kTi6ild6Zxmlevo6fXNSvkR8Nv36RLh64N3zxki1otft+Now1GEIXUujMQqQ5DBWTfRS
 WxuRAaSJgqFCoVICxB3WM94ZbpcnKYskhI1gv+Va/0L5iwrtLU+/Orp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to regmap_fields, so that the values written into registers are
sanitized by their explicit sizes and the different registers are
structured in an iterable object to make external changes to the init
sequence simpler.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 91 +++++++++++++++++---------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 52c275fbb2a1..7561da01e633 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -28,14 +28,42 @@
 #define EUSB2_TUNE_SQUELCH_U		0x54
 #define EUSB2_TUNE_USB2_PREEM		0x57
 
-#define QCOM_EUSB2_REPEATER_INIT_CFG(o, v)	\
+#define QCOM_EUSB2_REPEATER_INIT_CFG(r, v)	\
 	{					\
-		.offset = o,			\
+		.reg = r,			\
 		.val = v,			\
 	}
 
+enum reg_fields {
+	F_TUNE_USB2_PREEM,
+	F_TUNE_SQUELCH_U,
+	F_TUNE_IUSB2,
+	F_NUM_TUNE_FIELDS,
+
+	F_FORCE_VAL_5 = F_NUM_TUNE_FIELDS,
+	F_FORCE_EN_5,
+
+	F_EN_CTL1,
+
+	F_RPTR_STATUS,
+	F_NUM_FIELDS,
+};
+
+static struct reg_field eusb2_repeater_tune_reg_fields[F_NUM_FIELDS] = {
+	[F_TUNE_USB2_PREEM] = REG_FIELD(EUSB2_TUNE_USB2_PREEM, 0, 2),
+	[F_TUNE_SQUELCH_U] = REG_FIELD(EUSB2_TUNE_SQUELCH_U, 0, 2),
+	[F_TUNE_IUSB2] = REG_FIELD(EUSB2_TUNE_IUSB2, 0, 3),
+
+	[F_FORCE_VAL_5] = REG_FIELD(EUSB2_FORCE_VAL_5, 0, 7),
+	[F_FORCE_EN_5] = REG_FIELD(EUSB2_FORCE_EN_5, 0, 7),
+
+	[F_EN_CTL1] = REG_FIELD(EUSB2_EN_CTL1, 0, 7),
+
+	[F_RPTR_STATUS] = REG_FIELD(EUSB2_RPTR_STATUS, 0, 7),
+};
+
 struct eusb2_repeater_init_tbl {
-	unsigned int offset;
+	unsigned int reg;
 	unsigned int val;
 };
 
@@ -48,11 +76,10 @@ struct eusb2_repeater_cfg {
 
 struct eusb2_repeater {
 	struct device *dev;
-	struct regmap *regmap;
+	struct regmap_field *regs[F_NUM_FIELDS];
 	struct phy *phy;
 	struct regulator_bulk_data *vregs;
 	const struct eusb2_repeater_cfg *cfg;
-	u16 base;
 	enum phy_mode mode;
 };
 
@@ -61,9 +88,9 @@ static const char * const pm8550b_vreg_l[] = {
 };
 
 static const struct eusb2_repeater_init_tbl pm8550b_init_tbl[] = {
-	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_IUSB2, 0x8),
-	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_SQUELCH_U, 0x3),
-	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_USB2_PREEM, 0x5),
+	QCOM_EUSB2_REPEATER_INIT_CFG(F_TUNE_IUSB2, 0x8),
+	QCOM_EUSB2_REPEATER_INIT_CFG(F_TUNE_SQUELCH_U, 0x3),
+	QCOM_EUSB2_REPEATER_INIT_CFG(F_TUNE_USB2_PREEM, 0x5),
 };
 
 static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
@@ -93,7 +120,6 @@ static int eusb2_repeater_init(struct phy *phy)
 {
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	const struct eusb2_repeater_init_tbl *init_tbl = rptr->cfg->init_tbl;
-	int num = rptr->cfg->init_tbl_num;
 	u32 val;
 	int ret;
 	int i;
@@ -102,17 +128,14 @@ static int eusb2_repeater_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	regmap_update_bits(rptr->regmap, rptr->base + EUSB2_EN_CTL1,
-			   EUSB2_RPTR_EN, EUSB2_RPTR_EN);
+	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
 
-	for (i = 0; i < num; i++)
-		regmap_update_bits(rptr->regmap,
-				   rptr->base + init_tbl[i].offset,
-				   init_tbl[i].val, init_tbl[i].val);
+	for (i = 0; i < rptr->cfg->init_tbl_num; i++)
+		regmap_field_update_bits(rptr->regs[init_tbl[i].reg],
+					 init_tbl[i].val, init_tbl[i].val);
 
-	ret = regmap_read_poll_timeout(rptr->regmap,
-				       rptr->base + EUSB2_RPTR_STATUS, val,
-				       val & RPTR_OK, 10, 5);
+	ret = regmap_field_read_poll_timeout(rptr->regs[F_RPTR_STATUS],
+					     val, val & RPTR_OK, 10, 5);
 	if (ret)
 		dev_err(rptr->dev, "initialization timed-out\n");
 
@@ -131,10 +154,10 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 		 * per eUSB 1.2 Spec. Below implement software workaround until
 		 * PHY and controller is fixing seen observation.
 		 */
-		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_EN_5,
-				   F_CLK_19P2M_EN, F_CLK_19P2M_EN);
-		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_VAL_5,
-				   V_CLK_19P2M_EN, V_CLK_19P2M_EN);
+		regmap_field_update_bits(rptr->regs[F_FORCE_EN_5],
+					 F_CLK_19P2M_EN, F_CLK_19P2M_EN);
+		regmap_field_update_bits(rptr->regs[F_FORCE_VAL_5],
+					 V_CLK_19P2M_EN, V_CLK_19P2M_EN);
 		break;
 	case PHY_MODE_USB_DEVICE:
 		/*
@@ -143,10 +166,10 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 		 * repeater doesn't clear previous value due to shared
 		 * regulators (say host <-> device mode switch).
 		 */
-		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_EN_5,
-				   F_CLK_19P2M_EN, 0);
-		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_VAL_5,
-				   V_CLK_19P2M_EN, 0);
+		regmap_field_update_bits(rptr->regs[F_FORCE_EN_5],
+					 F_CLK_19P2M_EN, 0);
+		regmap_field_update_bits(rptr->regs[F_FORCE_VAL_5],
+					 V_CLK_19P2M_EN, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -175,8 +198,9 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
 	struct device_node *np = dev->of_node;
+	struct regmap *regmap;
+	int i, ret;
 	u32 res;
-	int ret;
 
 	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
 	if (!rptr)
@@ -189,15 +213,22 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	if (!rptr->cfg)
 		return -EINVAL;
 
-	rptr->regmap = dev_get_regmap(dev->parent, NULL);
-	if (!rptr->regmap)
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
 		return -ENODEV;
 
 	ret = of_property_read_u32(np, "reg", &res);
 	if (ret < 0)
 		return ret;
 
-	rptr->base = res;
+	for (i = 0; i < F_NUM_FIELDS; i++)
+		eusb2_repeater_tune_reg_fields[i].reg += res;
+
+	ret = devm_regmap_field_bulk_alloc(dev, regmap, rptr->regs,
+					   eusb2_repeater_tune_reg_fields,
+					   F_NUM_FIELDS);
+	if (ret)
+		return ret;
 
 	ret = eusb2_repeater_init_vregs(rptr);
 	if (ret < 0) {

-- 
2.42.0

