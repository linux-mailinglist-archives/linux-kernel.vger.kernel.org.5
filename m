Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B748675E461
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjGWTIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjGWTIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:08:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337931B2;
        Sun, 23 Jul 2023 12:08:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso34216795e9.0;
        Sun, 23 Jul 2023 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690139284; x=1690744084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8V9jbWrkBD6li8Ss0Ga4cRkbrGO/YOXZLHgGgY4Tpc=;
        b=MSKn5ppJoNj4uOSJBjjxwsqTzZLkb26s2hVoSMOZ4VZOgSs6SudTzEmiLb2QPV/qjf
         13zkxSGdCOOdhLE4C40hpez1xiv7yxF2LZBBGlFBup1lo43aqQICq6ypjg7WV9NFpjVr
         yB85IoTwCmZYXDPmmNWRJTeBoXV8dDZopNOqOtVszlsAxpCi9N+lRoQCZ4xIqGJitN24
         DijQDUPrhyls3GZxDw4ZYYzdBkS29aSSozmUbKDsMrqr801kuh2ZSnHgq1d+Da3MmVan
         EjRI/H1gIO48rNwztraEV7lCCHVRfEfL8/EaVq2efabYb2+LQigNPEc3thaNtxWv3KA1
         1HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139284; x=1690744084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8V9jbWrkBD6li8Ss0Ga4cRkbrGO/YOXZLHgGgY4Tpc=;
        b=ggzGoNLqxs+xodhiIHow/cCET9zlbZuLQCDoqlfopyxCbKACNi5zwZpp1IuibmzUK4
         RNbNGjqyQP2feDpqSFcd6m8Qdi721v3Hm6V5b4Cz569EUON5cdHOTougSGbfo4qXAt2k
         PKo7E4lHw86jCBd0UXqubZPC5K52Yg7hlQ7frs7O7DvAkpa7Eui9Emzt9PrUGGTiqxxy
         K3rpDwYWpKP5qyRQqS+76tMM4vGcGO//rieInRFRDXcYFkgu0m4aDR9EiPu3fnJKSsQa
         Su85aEhWcUmmfBOtr5ByQdcL/EueC441Ds0dqlmgrSsz0zgHY6gnoBuliqybPWP1SldK
         BsbQ==
X-Gm-Message-State: ABy/qLaMtaVgv/4F0UjkmfNurLKVsb6+Vtkrt9iTgbIKSuls0G52myR4
        eh4YTVTPvvE3cVhDF0DIee0=
X-Google-Smtp-Source: APBJJlEM/0IP6cBw0lEnvpSyXLcdCjTSWR/m2kF1tlLSb9RFu83wGQqw7KvOrBFDIHcb68Igcc7sTg==
X-Received: by 2002:a05:600c:2308:b0:3f7:3991:e12e with SMTP id 8-20020a05600c230800b003f73991e12emr6418892wmo.1.1690139284357;
        Sun, 23 Jul 2023 12:08:04 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.170.196])
        by smtp.googlemail.com with ESMTPSA id h19-20020a1ccc13000000b003fbcdba1a63sm2843320wmb.12.2023.07.23.12.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:08:04 -0700 (PDT)
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
Subject: [PATCH v4 3/7] dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
Date:   Sun, 23 Jul 2023 21:05:04 +0200
Message-ID: <20230723190725.1619193-4-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230723190725.1619193-1-davidwronek@gmail.com>
References: <20230723190725.1619193-1-davidwronek@gmail.com>
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

