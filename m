Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF478FA65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348709AbjIAJCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjIAJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:02:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903A10D4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:02:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso619504666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693558953; x=1694163753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VJAln+FxvaL2Dzcsz1PZfKm9ZVCQjWZvz3A9Btztd4=;
        b=lqQBikyJ8SLnMIUe3umd+3N5EQ9ddqFCwlEQv+AaSP1brQhmLsadx7hRUWKAJaLOsJ
         mgtlhUCiIFv3gdPlQOp3W0idtTf18dvWjq8xtLaeUv/2zoIDWMtmyRi9GOlDXA/1ZNvU
         3dLOCheECrwk2uSwX5o4wDvpolc/gG4v4IsEAGJ0/DvIwBryB34KA+iSy3IFVBMZkSd7
         ueKd3rw9oSOL7Bl2/2CfDxLPP8yaD9TRMgf0wQ5IRXln2KXOztsBan+90CF78WX4Hb+K
         a0O8eGvigAnJ1XSTb5UNRITD+CgVsRwvUliP4QvP7hLRxMWx+FYPlA2Y1+rCtS2OvCxR
         P3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693558953; x=1694163753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VJAln+FxvaL2Dzcsz1PZfKm9ZVCQjWZvz3A9Btztd4=;
        b=IdN7qD0pAgMODY2c8NhE46M37CUqbyd7lRrjBD0Xu6gsfbSJYbyDx/LCcoi3d/sqvj
         XUj19xY6x653+6/aBVn/QD/MZmN2Dx98c/Ad3AX5IVmca0ALs1FNXlqiX0pwlT9Mqn4C
         K9GonFy7VPYE53nwVZ7mRSSht5u2drKZqv+wCDa9Tdx5ajrcPJ0gp0QYnKNDq8sMTjzT
         iUuanJZXw1yk0jVr7qCdElkqB8eQaTrGEvnp2dfpT1Svg2Rz5xfi9O5kY+FibuRgyluS
         R0ANh6IhrSW6BlRPh7rqEthdvpjM+4ZtISqrQC1n5A80IgiQhUhTUkOln1FsmARxZ6CD
         vs+w==
X-Gm-Message-State: AOJu0Yw80PxZNWRwiPAjhYeO6gQZuHMWY6eTXJL/fGlGtXh42UgM9Teb
        +48S83qfrqO6fXQqyCo6uKljiQ==
X-Google-Smtp-Source: AGHT+IHMqvAKaaMztMMy4iFQEJuNgzItxXUvYDtTEYmOaPl8nMUOVjn+s5wvrZm2Kp43g4Esm7n6LQ==
X-Received: by 2002:a17:907:3e1f:b0:9a5:9b93:d60d with SMTP id hp31-20020a1709073e1f00b009a59b93d60dmr5190862ejc.36.1693558953152;
        Fri, 01 Sep 2023 02:02:33 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id ov22-20020a170906fc1600b00992c92af6f4sm1753687ejb.144.2023.09.01.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:02:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] pinctrl: qcom: lpass-lpi: allow slew rate bit in main pin config register
Date:   Fri,  1 Sep 2023 11:02:24 +0200
Message-Id: <20230901090224.27770-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901090224.27770-1-krzysztof.kozlowski@linaro.org>
References: <20230901090224.27770-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing Qualcomm SoCs have the LPASS pin controller slew rate control
in separate register, however this will change with upcoming Qualcomm
SoCs.  The slew rate will be part of the main register for pin
configuration, thus second device IO address space is not needed.

Prepare for supporting new SoCs by adding flag customizing the driver
behavior for slew rate.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 20 ++++++++++++++------
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h |  7 +++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index e2df2193a802..40eb58a3a8cd 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -190,6 +190,7 @@ static int lpi_config_set_slew_rate(struct lpi_pinctrl *pctrl,
 				    const struct lpi_pingroup *g,
 				    unsigned int group, unsigned int slew)
 {
+	void __iomem *reg;
 	unsigned long sval;
 	int slew_offset;
 
@@ -203,12 +204,17 @@ static int lpi_config_set_slew_rate(struct lpi_pinctrl *pctrl,
 	if (slew_offset == LPI_NO_SLEW)
 		return 0;
 
+	if (pctrl->data->flags & LPI_FLAG_SLEW_RATE_SAME_REG)
+		reg = pctrl->tlmm_base + LPI_TLMM_REG_OFFSET * group + LPI_GPIO_CFG_REG;
+	else
+		reg = pctrl->slew_base + LPI_SLEW_RATE_CTL_REG;
+
 	mutex_lock(&pctrl->lock);
 
-	sval = ioread32(pctrl->slew_base + LPI_SLEW_RATE_CTL_REG);
+	sval = ioread32(reg);
 	sval &= ~(LPI_SLEW_RATE_MASK << slew_offset);
 	sval |= slew << slew_offset;
-	iowrite32(sval, pctrl->slew_base + LPI_SLEW_RATE_CTL_REG);
+	iowrite32(sval, reg);
 
 	mutex_unlock(&pctrl->lock);
 
@@ -452,10 +458,12 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(pctrl->tlmm_base),
 				     "TLMM resource not provided\n");
 
-	pctrl->slew_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(pctrl->slew_base))
-		return dev_err_probe(dev, PTR_ERR(pctrl->slew_base),
-				     "Slew resource not provided\n");
+	if (!(data->flags & LPI_FLAG_SLEW_RATE_SAME_REG)) {
+		pctrl->slew_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(pctrl->slew_base))
+			return dev_err_probe(dev, PTR_ERR(pctrl->slew_base),
+					     "Slew resource not provided\n");
+	}
 
 	ret = devm_clk_bulk_get_optional(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
 	if (ret)
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
index 29047bb80bb8..8a4cd8aef38c 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
@@ -60,6 +60,12 @@ struct pinctrl_pin_desc;
 		.nfuncs = 5,				\
 	}
 
+/*
+ * Slew rate control is done in the same register as rest of the
+ * pin configuration.
+ */
+#define LPI_FLAG_SLEW_RATE_SAME_REG			BIT(0)
+
 struct lpi_pingroup {
 	struct group_desc group;
 	unsigned int pin;
@@ -82,6 +88,7 @@ struct lpi_pinctrl_variant_data {
 	int ngroups;
 	const struct lpi_function *functions;
 	int nfunctions;
+	unsigned int flags;
 };
 
 int lpi_pinctrl_probe(struct platform_device *pdev);
-- 
2.34.1

