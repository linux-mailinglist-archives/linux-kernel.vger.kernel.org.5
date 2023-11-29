Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354777FD5BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjK2Lab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjK2LaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:30:20 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1078A1710
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:30:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54bd7e5182cso643302a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701257424; x=1701862224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuoTW5fNts47GPp/zz/U4BPEMqSdOcRJOpgotFGXLGo=;
        b=TD1HTmbmVOmkmbeL7NASVcgXpk+ouNAYhqa6M04Du+3uMpzxq4maeXwhqrsClgsVip
         N4dhPKaWFz/ZYa1y73bmk77rxI2WyyluvtwZRuji/YYtxlWdws4Bi5awxWtdjVYD5TaT
         hYMsV8xZfXc8e4I0ZEu+Oo5wU91ODbqZDCk430YmGFyb+qmcc32vyCbnMNdvhx2bFt2O
         ikgMm0zAQXctXztxAVol+sSJQq9shT7vReFFORbaEwpIP8E9q4SlMY6K6IQucb/2u4CP
         n4ZVVkhTdYWom/IRELsQggGZzp3kJ3oluv/JJ43JzndDPmcAYfb7f6bce9ZEHeW8R6Dy
         Gupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257424; x=1701862224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuoTW5fNts47GPp/zz/U4BPEMqSdOcRJOpgotFGXLGo=;
        b=JaV2T9euku0jb0Xr/JC1Z0vBR0rqxqebk9i+wc4lmNORCdDvaVEtYnruOjFkngUlS4
         kx/I/evPs364v1iyYS5TH94J+xTjfb9eBZrG9Js4UHcuWHrANZ/0xfsll6fn2HRcplry
         U/NLHtB1H8KGAiSquLWJ2uzn65WD/m1GXoACULztvziCYrWjWpj47kZkJBD9d9j2ipip
         rPgHgF9Ap5/N0QRdDrM8C6ypja9ogQwZprOnC3bB1QJ6oyg6TNqd+Mv4igvRVuQtjsUx
         P6VFqAk/fHa99Updr3UcH5rh779pDCGKNAfiVMUwITnBUrIoFhjaCAK2uqwK/iU427z4
         gLlA==
X-Gm-Message-State: AOJu0YwHFci4qyFeIAnAKYMX9sBDxWpAIgQVAbH2t6TY/pRPlHzoDHln
        lfBjyVUzACcSAlXANmb3dhbcWQ==
X-Google-Smtp-Source: AGHT+IEHx5bvhNh2IGOAE7PXOlw27mYMxj7q8yRLiaQc1GYWBHE0clKsOrSLO7MzxHMzKLVRVjkuPw==
X-Received: by 2002:aa7:df0c:0:b0:54b:52c4:68a5 with SMTP id c12-20020aa7df0c000000b0054b52c468a5mr7456394edy.39.1701257424378;
        Wed, 29 Nov 2023 03:30:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402440500b0054af224a87bsm6213829eda.33.2023.11.29.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:30:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 4/4] ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8650 LPASS WSA
Date:   Wed, 29 Nov 2023 12:30:14 +0100
Message-Id: <20231129113014.38837-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129113014.38837-1-krzysztof.kozlowski@linaro.org>
References: <20231129113014.38837-1-krzysztof.kozlowski@linaro.org>
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

Add bindings for Qualcomm SM8650 Low Power Audio SubSystem (LPASS) WSA
macro codec, which looks like compatible with earlier SM8550.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
index eea7609d1b33..5fb39d35c8ec 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
@@ -11,12 +11,16 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,sc7280-lpass-wsa-macro
-      - qcom,sm8250-lpass-wsa-macro
-      - qcom,sm8450-lpass-wsa-macro
-      - qcom,sm8550-lpass-wsa-macro
-      - qcom,sc8280xp-lpass-wsa-macro
+    oneOf:
+      - enum:
+          - qcom,sc7280-lpass-wsa-macro
+          - qcom,sm8250-lpass-wsa-macro
+          - qcom,sm8450-lpass-wsa-macro
+          - qcom,sm8550-lpass-wsa-macro
+          - qcom,sc8280xp-lpass-wsa-macro
+      - items:
+          - const: qcom,sm8650-lpass-wsa-macro
+          - const: qcom,sm8550-lpass-wsa-macro
 
   reg:
     maxItems: 1
@@ -94,8 +98,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,sm8550-lpass-wsa-macro
+          contains:
+            enum:
+              - qcom,sm8550-lpass-wsa-macro
     then:
       properties:
         clocks:
-- 
2.34.1

