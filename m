Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19E27FDC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjK2P5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjK2P5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:57:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AACFD4A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:57:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bc22c836bso2013396e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701273463; x=1701878263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vA0x6TLGrrwrneDYeNbPP8u/I8CMuud7wLf1wVHyc/E=;
        b=LKSyjgsnMToOAYXJMfSztu3tCnmFKdO/LZHIK5z3TkA/wGuARdjRNkzvxrq1jJI6oV
         D0xBFrPauxPKvbY9oR5TB5KoJFOfQL6QHEHeCSjemhqJ/0W5iYzQg+JIwoSraRGJvmhw
         Pkw74zi3rnfOQjqMnITIl41LQgzjcMgYEfjK5KBMhYGJjRkxBS7fe1qsj93zbrPmEH2Q
         rJtFQ9pJYbeyQBJZb/ssz4gwS7KBrRT8Wja/NM6veM5owUFcdWa0Enlq0UHMAxhqagQ4
         9s0Ls7NvBqiWFGzFbNrbJ+gdmRGg1aid2SA0hZgzrWVIUo0HATyF+PMXzN6Dg5RTUvjv
         nSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701273463; x=1701878263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vA0x6TLGrrwrneDYeNbPP8u/I8CMuud7wLf1wVHyc/E=;
        b=Eyn9GNTOivicA7us6Nc+f75lqy8+hB6YMvOXTIuFaH9Q9Qav5ByV1ZlewLht9WHk12
         x07KBnLH3ED+AUlShsKzSCoqft64Bc1S9/N5jTfCnmS1NS+9NOeZ/yPELN6y/5Q3ofRe
         LUncQN8zX1RCoOPzRcJHAGke+FfDmDtOt0jcG5jtGSBgMoiuMlMlf8PG6iaBDRFgrnEj
         iby6XcHprhDPrQzVekd8CNW5xQU5SkuOK3ZIub/pU1KC3yeMcqpFi7MTVB9ulPdkSyHZ
         B5UwVWiu5u1qZAZqLh8geWWvnie5FDQ3P5lmfveyuO5yLZ6NB9A2eu38rCTk6WtzLIM7
         /93Q==
X-Gm-Message-State: AOJu0Yzi3SCQLciwZe4mSB1gy3oLJc+vur3epmW/YXkBMmVOXLjamzRK
        k6BNdmv8T7h8t9lTHKuPEYFDjg==
X-Google-Smtp-Source: AGHT+IF+Z+kwt6F2DX1OduNpIDwwv9Ayq2GX7aWrmMCjgCQFl2Myc5kLzUmIxfrRWVgaj7HNcVtCKQ==
X-Received: by 2002:a05:6512:108f:b0:507:97ca:ec60 with SMTP id j15-20020a056512108f00b0050797caec60mr15616839lfg.3.1701273462620;
        Wed, 29 Nov 2023 07:57:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id gy5-20020a0564025bc500b0054b686e5b3bsm3345130edb.68.2023.11.29.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:57:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH] dt-bindings: pinctrl: qcom,sm8550-lpass-lpi: add X1E80100 LPASS LPI
Date:   Wed, 29 Nov 2023 16:57:38 +0100
Message-Id: <20231129155738.167030-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Document the Qualcomm X1E80100 SoC Low Power Audio SubSystem Low Power
Island (LPASS LPI) pin controller, compatible with earlier SM8550 model.

Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml     | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
index ef9743246849..ad5e32130fd7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
@@ -16,7 +16,11 @@ description:
 
 properties:
   compatible:
-    const: qcom,sm8550-lpass-lpi-pinctrl
+    oneOf:
+      - const: qcom,sm8550-lpass-lpi-pinctrl
+      - items:
+          - const: qcom,x1e80100-lpass-lpi-pinctrl
+          - const: qcom,sm8550-lpass-lpi-pinctrl
 
   reg:
     items:
-- 
2.34.1

