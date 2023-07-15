Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6CC7547CD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjGOJUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGOJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:20:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A4D3C03;
        Sat, 15 Jul 2023 02:20:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31434226a2eso2901566f8f.1;
        Sat, 15 Jul 2023 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412803; x=1692004803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8V9jbWrkBD6li8Ss0Ga4cRkbrGO/YOXZLHgGgY4Tpc=;
        b=WA3D4vJ6DdaktgKjCxj8Qv4Yp7ZHpCbyqHre06LdNGhh9wkgSH5ervHghkKWJCH/An
         Asdj2F/Oog06UcvVvgoydksFXy/pm/tXfnTdl3H9ogLsA/tAMvpclok9gQ7JuHExMZgZ
         SCzY47YelnEf3AdG0rkgffHU71MrOACRG/I2PUfbK5tJB1gE6DzkpzMBV6Wax2SGJ4gK
         OrWEBHHaHAaAVl+5SnWm2dhmmFyXERxd8hVUMfoyYnDQW1irpL4snpbXN+L2ke6XnwcJ
         vkLUZruQKbfXW9/OWYtyW0wX1XmuQ8Hx+PpfwcKx4Sry1MEPcq3Ey+Pw/zMO3omRRu16
         D8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412803; x=1692004803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8V9jbWrkBD6li8Ss0Ga4cRkbrGO/YOXZLHgGgY4Tpc=;
        b=GI4pJJqADDu4szHbt/vDR+g0ZPoNH2Uy2O3KmfNXCDMaEl5r0srMdHTPZZX5nCNzxi
         ILiJKmQEnIEyAEI2RL1evQd8jwPnSJmS09+Y+6YZpJXqKOul66tTQeqpNvmha0Z5Kd/q
         CoyukrPVQ8bkfIcDjoojwmbJLlPHeYREbme6scQrqVpFf4wDYb57ZaYY3hh5/2uNHXRi
         wFoBJRoMB2rI7oes+vP9o/1RcDV1uGzI9zmdsW39RybsJNnDSuHNXBd25+k3mb3zUilx
         ffvXrpJwMz9srmvL3rk0BIRw0dwBQHcAM6T9G7aryFVbif9nEM65ky6oarTSBGbD0gtT
         ZaPg==
X-Gm-Message-State: ABy/qLZuZM/fWxfll8g2JTIN7UYCdnMGZzSDlWEifO9vYGToDzJudxzh
        +KFsAA16DmF9wkMWgthd1eE=
X-Google-Smtp-Source: APBJJlGpCrsDeSmRkVSdUlcYFb9+bZKqeCEnnDzhSZco4W141np5iaGtH/emMEltDuBtCILgvsjhaA==
X-Received: by 2002:adf:ed85:0:b0:313:f5f8:b6d2 with SMTP id c5-20020adfed85000000b00313f5f8b6d2mr6722235wro.48.1689412803493;
        Sat, 15 Jul 2023 02:20:03 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.202.152])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm3238133wml.18.2023.07.15.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:20:03 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/7] dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
Date:   Sat, 15 Jul 2023 11:16:09 +0200
Message-ID: <20230715091932.161507-4-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230715091932.161507-1-davidwronek@gmail.com>
References: <20230715091932.161507-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the xiaomi,joyeuse board based on the Qualcomm SM7125 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..a403c433e9b5 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -77,6 +77,7 @@ description: |
         sm6125
         sm6350
         sm6375
+        sm7125
         sm7225
         sm8150
         sm8250
@@ -929,6 +930,11 @@ properties:
               - sony,pdx225
           - const: qcom,sm6375
 
+      - items:
+          - enum:
+              - xiaomi,joyeuse
+          - const: qcom,sm7125
+
       - items:
           - enum:
               - fairphone,fp4
@@ -1072,6 +1078,7 @@ allOf:
               - qcom,sm6115
               - qcom,sm6125
               - qcom,sm6350
+              - qcom,sm7125
               - qcom,sm7225
               - qcom,sm8150
               - qcom,sm8250
-- 
2.41.0

