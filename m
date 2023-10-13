Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D57C8827
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjJMO7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJMO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:59:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2352EBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:59:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d81864e3fso1849265f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697209181; x=1697813981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os1SaGixPymAzc87N0J0x0jFQUdmX5KiKLLsTm7SPUs=;
        b=R3O9SfM1Pg6PUl/2zAkP3AkJ6ME3y0m7sSZM0TnE1dfsWiwA8afQJ6QjA0BsruXN/D
         Nrcmzq0Et8Gmc7IpbVvaMmFRmsnWw4XK+x/F6zcINFxeAkgOhlg6K1cKNIJzr3xdHReC
         R6/s9GUyfXtRVI+COtW3AF2pJ+EZPjOBknF5ET6INWSTDL2v4x/JRVqEoMXXcKDZRUil
         ss8Rj/WbBVOd7hs90gCNAzSznqnwfmPZnqBeUkMJekDZhOvFGAD93FYRT8yh6mPEXW3E
         IlkqCbgczYz28lug4O2/P4f1kLUyPCU4SUbfNnhWa3r8o2UnPDCppKOCnSd4kv0jMOJy
         J0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209181; x=1697813981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os1SaGixPymAzc87N0J0x0jFQUdmX5KiKLLsTm7SPUs=;
        b=BN5N20bmTS1oD2G+TOj0wKwjvmCXw1XaRS9gzTsvDV0Q4earYL1J2/VjXkaWpuRUr0
         elbLsXezcbBryy8SjZONJQS2TRS7j6DC52FFqRSlp5kPq1ah3u5cyUoL1+kltkommbRc
         ALiL4S1N9xz3c5uEMEkwQL+iqzNZxJWpvOTH/r+TsmSuN9/b6xt60khJQp5ZcbV8vQTP
         ER8uJRG3DGcJwkr/RmSVMNx/8k2GIhQxwpHzrVhkKsrB4aJVhlFoiEv4F+3mOtWaBLnF
         rVHz0tSDdKp/ShGJ+ocdddnjyMu5Ivc22D6zpMmfGeMg8uzkw97Ah3ZPfugYCW33P/vX
         qOsA==
X-Gm-Message-State: AOJu0YwZt56R3BwzLVnnnmYuBo+OFakPzabJXKicvJJL8XjuGrnjaJXx
        w1wmW/dB+tfSZVIMEBLhVWrz1w==
X-Google-Smtp-Source: AGHT+IFo2I+V7vf/Zl0BTreJTldq95ey32tamdgWaZW37F9sPTzdpjO8i3XgGGnytWGGlG7Bi07wzQ==
X-Received: by 2002:adf:a2dc:0:b0:32d:8108:500 with SMTP id t28-20020adfa2dc000000b0032d81080500mr7223064wra.58.1697209181547;
        Fri, 13 Oct 2023 07:59:41 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id dh13-20020a0560000a8d00b00327cd5e5ac1sm6428267wrb.1.2023.10.13.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:59:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] pinctrl: qcom: lpass-lpi: allow slew rate bit in main pin config register
Date:   Fri, 13 Oct 2023 16:59:35 +0200
Message-Id: <20231013145935.220945-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013145935.220945-1-krzysztof.kozlowski@linaro.org>
References: <20231013145935.220945-1-krzysztof.kozlowski@linaro.org>
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

Changes in v2:
1. Reversed xmas tree

v1: https://lore.kernel.org/all/20230901090224.27770-1-krzysztof.kozlowski@linaro.org/
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 20 ++++++++++++++------
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h |  7 +++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 4fb808545f7f..9e410a281bfa 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -191,6 +191,7 @@ static int lpi_config_set_slew_rate(struct lpi_pinctrl *pctrl,
 				    unsigned int group, unsigned int slew)
 {
 	unsigned long sval;
+	void __iomem *reg;
 	int slew_offset;
 
 	if (slew > LPI_SLEW_RATE_MAX) {
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
index 387d83ee95b5..206b2c0ca828 100644
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

