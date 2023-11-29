Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB77FD5AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjK2LaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjK2LaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:30:14 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B2B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:30:20 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54af0eca12dso7287298a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701257418; x=1701862218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PpRWp/0m/xWdvHLqY46oTCz3fciQWVaXGN2a0hf71o=;
        b=vrTQqLkq9GIJjeMjvMqQalD5JXGAktojeGarlr9GHvHdtkiXOs3A4xENcSOH0Eaqwj
         7Eysfr3O4xeB0fljYIs3P9Z3Jnmny2PsWo3W6nQqbsWZMEWsGLjtv3661kMl4pUkaW+e
         B5oxEKWqlyFRAky4g7slRN4kgaADg6QwhkUEmjJps9zbb4qAUoV+wm4+P8wCehOCr9FF
         NrLtey8IRJG0JQB7XOsWPBZ4s0Jyuel/WNKlYgHX/7tnFXRcHOS3iflrYMG+Qxg5zW/y
         mvXt3CjV6NSL/exPiFVQ1EAIqa/dk97xZ1E3OucMTh44oE911ab2QZULnl4sOd3FIE0b
         Ru4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257418; x=1701862218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PpRWp/0m/xWdvHLqY46oTCz3fciQWVaXGN2a0hf71o=;
        b=rv8cKMFcKs+kSg0zDS0kDVuMOmWtz7G/dn2fxs1E2IpK8SaoKEi5cIAKdg/U2nOcnj
         +LAf3svlwRQA9CL1taTjXq7cJuagrhSFuQJY4O1WOM/w9ldkWJCjqFuvYq3QhwZHXL0f
         eV1yMMo/f/a+TD7GgRPtb2WgypzsjWS6h9KEa7nxq/pQf8+ypggXiWUPuYOgvKwtSpCn
         EiUL7LLb0fpoT4nPSzIascjE45NFAIS8nJA+aGOhXrhNqflRAvmwkRiYR+E1DqiRd3Vz
         d59X5eWW4YvxHfRJhoMPvYidxRyLqasYp4LqzkQigcUBigYbIuYIdmGhBVXwTGyySkwF
         YxsA==
X-Gm-Message-State: AOJu0YwrNA2cjcYuyykDL+enAImYYHOmPmsUNMFfuyCKXkIW6UWToeFe
        6/Y2LsZ9u56zk+buXTw9KPAQig==
X-Google-Smtp-Source: AGHT+IGbP5HyFHFVjrl6/DXNoynkgfMp56NuMHTtlRoK03FAheE2R3knt3zZS32ZUham4wZO8PA/lg==
X-Received: by 2002:a50:9994:0:b0:54b:3457:a656 with SMTP id m20-20020a509994000000b0054b3457a656mr9592023edb.25.1701257418541;
        Wed, 29 Nov 2023 03:30:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402440500b0054af224a87bsm6213829eda.33.2023.11.29.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:30:17 -0800 (PST)
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
Subject: [PATCH 1/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8650 LPASS RX
Date:   Wed, 29 Nov 2023 12:30:11 +0100
Message-Id: <20231129113014.38837-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Qualcomm SM8650 Low Power Audio SubSystem (LPASS) RX
macro codec, which looks like compatible with earlier SM8550.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-rx-macro.yaml   | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index ec4b0ac8ad68..cbc36646100f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -11,12 +11,16 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,sc7280-lpass-rx-macro
-      - qcom,sm8250-lpass-rx-macro
-      - qcom,sm8450-lpass-rx-macro
-      - qcom,sm8550-lpass-rx-macro
-      - qcom,sc8280xp-lpass-rx-macro
+    oneOf:
+      - enum:
+          - qcom,sc7280-lpass-rx-macro
+          - qcom,sm8250-lpass-rx-macro
+          - qcom,sm8450-lpass-rx-macro
+          - qcom,sm8550-lpass-rx-macro
+          - qcom,sc8280xp-lpass-rx-macro
+      - items:
+          - const: qcom,sm8650-lpass-rx-macro
+          - const: qcom,sm8550-lpass-rx-macro
 
   reg:
     maxItems: 1
@@ -96,8 +100,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,sm8550-lpass-rx-macro
+          contains:
+            enum:
+              - qcom,sm8550-lpass-rx-macro
     then:
       properties:
         clocks:
-- 
2.34.1

