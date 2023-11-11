Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509CB7E8CB3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjKKUrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKKUre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:47:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F16E2D77
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:47:30 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9e623356e59so266704266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699735649; x=1700340449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Peg1pxCwGlnhNKPOTBWdvFK6RQItCTgLiK4ys22+0zI=;
        b=q1zBnuKZgE8y/IgPhTpQCy1JhBOB4879vLQuhvTmXNGAOT70oRsrnWRRGMi+K/RpkN
         pasJP1BhPp3rX9kXmXOQCaGTDBDWBV0vNF3o5Z3avjHm2jk6etL0Rw8ljatHsvGNOTeC
         YM1eQjy4eku2213kDgS+yYpdAQv9lYfUAatfKcE8N6ajJG5TnSjNG0rz/qinNLexK2oj
         iqOBfYznH9pIPFdJPPDx4MnkakKLo1IuDaYjqxztISHt/wJwhrvIE8HBYuUU5JxD+Tzz
         CilP9Gb0oEAMG7cLW57MBOQcyhm3x1E94+wLbpyeX9voe7FzynlrcmgTZ58lEs2ckjew
         tMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699735649; x=1700340449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Peg1pxCwGlnhNKPOTBWdvFK6RQItCTgLiK4ys22+0zI=;
        b=vxVT2OgtMBxzOO63O9cm9jQpDu3I4CPEbq0XqNfvRjihZRB3B4T6JOn/2Kd2WasPOY
         EQMz4MlYp+u/JRum+RCuL9HEUOrSCzYosEjR1ZYhq7Kbp8NjmFewjDylqgLF7PblVTOT
         TEI/oX+JJILXt5MMUx9F2DCabtLui1pUIFX0030SuUGm9noXDqanXlTf+D0IDP0L1FfV
         kLfQPu+/iPO3lAgt0fev4adjw5+7KLzu+oMh0A5o0rHI3jbjiFrlkYM0QidQKwlJuNXD
         roYzTAHmiFRlHSuyn8VjV2SLW6XCFm7JtdrrhoeAI8yO/bURU2fgSkWpOAyfJZN1wiY7
         GaPw==
X-Gm-Message-State: AOJu0YzsUBz8+T+Rxfi3xsYMGhPPdsXnYebS1L0fXERpWedskA0isCPD
        sipFsP/0O2GyFN5UkdsmYVPtfg==
X-Google-Smtp-Source: AGHT+IE/AWG1HaOZp60zhem7NngI/0APEHckp98uQ4HTdPA7+GViVgAA3x2I697DRgKOwHFqYwMXbw==
X-Received: by 2002:a17:906:234d:b0:9d3:f436:6809 with SMTP id m13-20020a170906234d00b009d3f4366809mr1743119eja.39.1699735649053;
        Sat, 11 Nov 2023 12:47:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id dc3-20020a170906c7c300b009b947f81c4asm1547346ejb.155.2023.11.11.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 12:47:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sc8180x: align APSS with bindings
Date:   Sat, 11 Nov 2023 21:47:25 +0100
Message-Id: <20231111204725.35707-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC8180x APSS Devicetree bindings expect qcom,sc8180x-apss-shared to use
qcom,sdm845-apss-shared fallback:

  sc8180x-lenovo-flex-5g.dtb: mailbox@17c00000: compatible: 'oneOf' conditional failed, one must be fixed:
    ['qcom,sc8180x-apss-shared'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index a34f438ef2d9..6f5c07fa6c2e 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3421,7 +3421,7 @@ intc: interrupt-controller@17a00000 {
 		};
 
 		apss_shared: mailbox@17c00000 {
-			compatible = "qcom,sc8180x-apss-shared";
+			compatible = "qcom,sc8180x-apss-shared", "qcom,sdm845-apss-shared";
 			reg = <0x0 0x17c00000 0x0 0x1000>;
 			#mbox-cells = <1>;
 		};
-- 
2.34.1

