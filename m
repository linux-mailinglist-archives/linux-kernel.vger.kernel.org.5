Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1287FD5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjK2LaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjK2LaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:30:16 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F82C10E2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:30:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5098e423ba2so9584921e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701257420; x=1701862220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYN9xq94tv9j8O0C0oRrYF7EmY0bODI5JT1t6FcrN0o=;
        b=JP45zePNJkZA4UIvAVghMahnES8ezpou6+W3rNFxV/1Uur6eWmDnK9BIYsXmY8n+35
         0n6x1KlVCZknx9cDejr8h3a1y4fLpCtr5bKjdIk1PUGrUk0PcDEz940qkJn0rR9BLo+i
         LZxvyaa6aAT5rfj/jVKMLYg91Zp3ZTLUyAKbQRByQ6F+L2jQ0FSZ1I479k6I0X2g8+mU
         kobrJNACPEfJu5bBiwSiXpEi4hm5TfNVIMg1SVyDntbT6EvsQ5c4ZrILcimwU0GvoPZ4
         +GF0wJRsgmH7AKjmYzPDDB7EcEOHlC3ZqRQzS0z0zHA6tKOcl5+gPo9ytcuI8qYZat1Q
         /M3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257420; x=1701862220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYN9xq94tv9j8O0C0oRrYF7EmY0bODI5JT1t6FcrN0o=;
        b=uNxpVJg3nA73jxw1AM3+lc9dCKQTMShSkAZMPeljblyExh8XsJGYi3gA5g29+W3vpU
         rnZaIzr+D70tvK1CtMfjbrqq2rGAQe+kk5bAVMEmXzDbU6dpPr6w7Q8lXOizD5O3ZFVq
         /FytjhSfo00O4S943hkN8eqdTEoFIajVEad0oIgopyF5uj5sd6fCVBuX44Wzhq/34T/x
         Wc6VhDkeZ+nfCSeLgwgGiu7N4hJXZRZPN4sgYgu+S2XToSC91BNZBo7RmfwRLVGZnbrd
         toDb0naeVusYMaWh54Ig+whzzEi4YZTZqANLb7BKDzRxmSsHq747+v5PjwHt/BPf+ey5
         37sA==
X-Gm-Message-State: AOJu0YwrmblTu2XjaLTRo0Sua/5eekFWFysKhu49czhkQgnP9aZrDVvh
        bvd+W/uulg1gssiWtb+w+1iq8w==
X-Google-Smtp-Source: AGHT+IGf+lYuB85sUBy5jbyCRa/bqNfCvJ7yJDrbtC4hGrUhQ8pWpqA2IgrGIJB3ZpyHP5KF9wLIMg==
X-Received: by 2002:a05:6512:3d1c:b0:50b:c630:13e7 with SMTP id d28-20020a0565123d1c00b0050bc63013e7mr1162086lfv.19.1701257420604;
        Wed, 29 Nov 2023 03:30:20 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402440500b0054af224a87bsm6213829eda.33.2023.11.29.03.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:30:20 -0800 (PST)
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
Subject: [PATCH 2/4] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8650 LPASS TX
Date:   Wed, 29 Nov 2023 12:30:12 +0100
Message-Id: <20231129113014.38837-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129113014.38837-1-krzysztof.kozlowski@linaro.org>
References: <20231129113014.38837-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Qualcomm SM8650 Low Power Audio SubSystem (LPASS) TX
macro codec, which looks like compatible with earlier SM8550.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-tx-macro.yaml   | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 962701e9eb42..cee79ac42a33 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -11,13 +11,17 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,sc7280-lpass-tx-macro
-      - qcom,sm6115-lpass-tx-macro
-      - qcom,sm8250-lpass-tx-macro
-      - qcom,sm8450-lpass-tx-macro
-      - qcom,sm8550-lpass-tx-macro
-      - qcom,sc8280xp-lpass-tx-macro
+    oneOf:
+      - enum:
+          - qcom,sc7280-lpass-tx-macro
+          - qcom,sm6115-lpass-tx-macro
+          - qcom,sm8250-lpass-tx-macro
+          - qcom,sm8450-lpass-tx-macro
+          - qcom,sm8550-lpass-tx-macro
+          - qcom,sc8280xp-lpass-tx-macro
+      - items:
+          - const: qcom,sm8650-lpass-tx-macro
+          - const: qcom,sm8550-lpass-tx-macro
 
   reg:
     maxItems: 1
@@ -118,8 +122,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,sm8550-lpass-tx-macro
+          contains:
+            enum:
+              - qcom,sm8550-lpass-tx-macro
     then:
       properties:
         clocks:
-- 
2.34.1

