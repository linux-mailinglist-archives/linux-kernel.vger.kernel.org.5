Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89478513A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjHWHNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjHWHNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:13:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AB3E57
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:13:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68824a0e747so1073995b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692774822; x=1693379622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vceDWEE7oHG2SJcCiU06aBCfh4LmE83nkp5r2jFyME=;
        b=TtYZ7oxNlpEddT3Ei771JmMaQEcY+uMc1DeMnznVQB5B1nPIx3hrfcRWX4+FHzqm3v
         iYBduvN69ZVxYxDaisyIbtli/+tCqCpFEtBDgAJVUUTTbZqrJDFA3ncFDrcyjTaK5P4t
         RLQ2rF+ZmBjQ0h/NhBqnSLREkOtgdpaRP72WD4pA5uV+EDdrS0TAeMXx7+SJPhXowWGx
         h3R95Zw4cbs1aJoEg+cuuwVzfzKj5IGbfpkgnY2xHQFpJBWkL3yCH7X1vKhBpMpmdhvv
         Y2FV1WsXehDQVAb2gMgYauZC86aGaX2mZ+v37BFlr6UWIUDMIFRhnQKfAcUgZw8sj4FA
         vvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692774822; x=1693379622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vceDWEE7oHG2SJcCiU06aBCfh4LmE83nkp5r2jFyME=;
        b=jUT7nKy/jcicFDF6rnRsxMZ2UNXEFEZbVGV3ifhyNrdrAq1L2NwzUNvp4HYpTDL6NI
         xMm68K0HYKHlvDOXCQr+cZzqOk99lNxVz8Y/FKQM59kxJJZ2UFF55UNbUk01Dt355nuV
         /wro6j8RxI7HPDkIoowGaUEHImK20POxRwss9kd9ZXFGb/1OZUKI/gv4uRbrTp/+DdwC
         kr0Y9BGbGYEuy/WY8cM2x8ai+IMgKaieQngotjbVf9Vz22aDy2WgtlzZzRhtdjyBq+HR
         B7Cfvo501m/5Olw3qZ26PEuKlllljiRINq4ppbB3bMWjsBR3RJsCr8hqHMwA3jg2lhXe
         DNSQ==
X-Gm-Message-State: AOJu0YxZiqE1e9myWv3oovSqATVC5tvZGgqHTa+cwhnvtR20v0DKpKZ7
        PpyMaZGwrt12kmi6VqaZjoSi+bGx6BKa3LFDy0RNAg==
X-Google-Smtp-Source: AGHT+IFOrl7qVQ7mH4YK/St81eITUfMCxZUOpZq7rAki89ggTGFpQETQScpmVkDassIinKBJpVLWVw==
X-Received: by 2002:a05:6a00:2d82:b0:68a:5954:fda4 with SMTP id fb2-20020a056a002d8200b0068a5954fda4mr6779903pfb.1.1692774822054;
        Wed, 23 Aug 2023 00:13:42 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id g16-20020aa78750000000b0068a690b44basm2520860pfo.31.2023.08.23.00.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:13:41 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: arm: qcom: add sc7180-lazor board bindings
Date:   Wed, 23 Aug 2023 15:13:05 +0800
Message-Id: <20230823151005.v6.1.I26e017b00a341e7a5a2e94a83596923713408817@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823071306.131373-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230823071306.131373-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce more sc7180-lazor sku and board version configuration,
add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
add new board version 10 for audio codec ALC5682i-VS.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
- correct corresponding of new board and new sku

Changes in v2:
- add new entry rev9 with Parade bridge chip
- correct newly create dts files

 .../devicetree/bindings/arm/qcom.yaml         | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..3da04223b03f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -470,6 +470,11 @@ properties:
           - const: google,lazor-rev8
           - const: qcom,sc7180
 
+      - description: Acer Chromebook Spin 513 (rev9)
+        items:
+          - const: google,lazor-rev9
+          - const: qcom,sc7180
+
       - description: Acer Chromebook Spin 513 (newest rev)
         items:
           - const: google,lazor
@@ -491,6 +496,11 @@ properties:
           - const: google,lazor-rev8-sku2
           - const: qcom,sc7180
 
+      - description: Acer Chromebook Spin 513 with KB Backlight (rev9)
+        items:
+          - const: google,lazor-rev9-sku2
+          - const: qcom,sc7180
+
       - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
         items:
           - const: google,lazor-sku2
@@ -512,9 +522,16 @@ properties:
           - const: google,lazor-rev8-sku0
           - const: qcom,sc7180
 
+      - description: Acer Chromebook Spin 513 with LTE (rev9)
+        items:
+          - const: google,lazor-rev9-sku0
+          - const: google,lazor-rev9-sku10
+          - const: qcom,sc7180
+
       - description: Acer Chromebook Spin 513 with LTE (newest rev)
         items:
           - const: google,lazor-sku0
+          - const: google,lazor-sku10
           - const: qcom,sc7180
 
       - description: Acer Chromebook 511 (rev4 - rev8)
@@ -526,9 +543,16 @@ properties:
           - const: google,lazor-rev8-sku4
           - const: qcom,sc7180
 
+      - description: Acer Chromebook 511 (rev9)
+        items:
+          - const: google,lazor-rev9-sku4
+          - const: google,lazor-rev9-sku15
+          - const: qcom,sc7180
+
       - description: Acer Chromebook 511 (newest rev)
         items:
           - const: google,lazor-sku4
+          - const: google,lazor-sku15
           - const: qcom,sc7180
 
       - description: Acer Chromebook 511 without Touchscreen (rev4)
@@ -545,9 +569,16 @@ properties:
           - const: google,lazor-rev8-sku6
           - const: qcom,sc7180
 
+      - description: Acer Chromebook 511 without Touchscreen (rev9)
+        items:
+          - const: google,lazor-rev9-sku6
+          - const: google,lazor-rev9-sku18
+          - const: qcom,sc7180
+
       - description: Acer Chromebook 511 without Touchscreen (newest rev)
         items:
           - const: google,lazor-sku6
+          - const: google,lazor-sku18
           - const: qcom,sc7180
 
       - description: Google Mrbland with AUO panel (rev0)
-- 
2.34.1

