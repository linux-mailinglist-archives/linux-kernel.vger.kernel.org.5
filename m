Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBD75A9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjGTI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjGTIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:35:34 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17D26A2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:35:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so792607e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689842109; x=1692434109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h0CcbUp+LfvYNPhD0SmWcMr+zwTgZPbTDhBQrWPEPA=;
        b=leQCoxqtE0B0JiPz3V6ahupqZ3fhkk8ExYDq8HzMR6oS3aG0E6f4Qaf11nuJrWyVcz
         krcxROAzMnjespmJVzCP5btQ08pAV4t3IK0leLHXN88cy/yFtN0epF7/mVoY8xxShfXB
         murraMKn9zS5zB94KZtuB8gPeDkhCqVpsgDdzChsRcXwxxZlQ4fbiXR/TyFzI8KchbWW
         3C+3RT+XExPo2FXG44TL5FuProeW6PLZgOmHDSGECQpfk8KQ433MUkr2D1RWwhh5o59v
         /R/ncP67Pf4yX2G9BNnk6BEZULsLd+7rOHiCB3nyiAEvH7SQos4kPsZA+g65xaERfsGr
         HDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689842109; x=1692434109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h0CcbUp+LfvYNPhD0SmWcMr+zwTgZPbTDhBQrWPEPA=;
        b=WMMpqOIb41hZazW8O6Aewvmf5m1EsxMovxEEw/mu2/Mdu3ROnr/6UfU8X9eor9eS25
         kWD3eXMbIOgL/YCiVzxpqmKoSjluA8f3boArMzrSM62MIi+tpaGq99+0edHLdk5N0e7c
         uqevvIUZzUcMP1MwIQhiUoSQgHMtUVygXtIWcvKes8oMuUgWdm88K7atj2QyyUCJ9Gq5
         /ONKD19We/TKwXtAkM2r5E32Jf6y5GE4RIU/PjobLQ15mqV+6mr7VFB19wq3JSk8ZB3m
         IoayRY/mCfVbb2hW4TXnS0kTf/tx88iEJeZbHBZuQ3dxgsJ/XLI5f9J0eHpD7MJXB6mw
         Wm1g==
X-Gm-Message-State: ABy/qLay/CC1+GfN7GYF5mn9TaLoW76a0vb8Owe9D0G8XzCitYg+uKRk
        K/mzB0OL6FU58jYz1XD+YizvlA==
X-Google-Smtp-Source: APBJJlFPqLzGg6ZNlaIONASIGKlTTonTN71PQH57EX8rVGU5P0ClmQs9qBk5cXgf8ZajZTiCz8kLqg==
X-Received: by 2002:a05:6512:3c81:b0:4fb:8de9:ac13 with SMTP id h1-20020a0565123c8100b004fb8de9ac13mr2170016lfv.23.1689842109560;
        Thu, 20 Jul 2023 01:35:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b00314329f7d8asm627060wrw.29.2023.07.20.01.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 01:35:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sc8180x-pmics: align LPG node name with dtschema
Date:   Thu, 20 Jul 2023 10:35:00 +0200
Message-Id: <20230720083500.73554-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720083500.73554-1-krzysztof.kozlowski@linaro.org>
References: <20230720083500.73554-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect the LPG node name to be "pwm":

  sc8180x-lenovo-flex-5g.dtb: pmic@5: 'lpg' does not match any of the regexes:

Fixes: d3302290f59e ("arm64: dts: qcom: sc8180x: Add pmics")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
index bc17d22dbefc..ddc84282f142 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
@@ -315,7 +315,7 @@ pmic@5 {
 		compatible = "qcom,pmc8180c", "qcom,spmi-pmic";
 		reg = <0x5 SPMI_USID>;
 
-		pmc8180c_lpg: lpg {
+		pmc8180c_lpg: pwm {
 			compatible = "qcom,pmc8180c-lpg";
 
 			#address-cells = <1>;
-- 
2.34.1

