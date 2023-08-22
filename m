Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B70783D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjHVJoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjHVJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:44:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D848CD7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:44:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26d442f43cfso375756a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692697468; x=1693302268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0C05FVrXugMzpMLLN6rQ3DKyIstnViCGSG0P90hg2Y=;
        b=De82AXiiBWWQo5TX7FH8lFyiQyoXAg9CPAl3SAN6L/Yhc1kx+wqsNbcuCzt+YeUzT6
         fQjQlGDd7QtdjR0WW6n9AL3u4iKigDF4ReXOzybiIksoY5V6QRq6giTI1tuoYf48/pc5
         61NzS5xh400lJR8rNJKF+/fTF3M6E1H9sNGu0Yr1crawCClsftRVwc9vdHcAZmv1alAU
         a6MvxQxD8K/7IsUXP2Kck7Dn2qSAdxCmr736u4/Wu4UcQYCnbXii45VF4nWkZpbVdzM3
         XVjtQVEytVDtqfR+55QUMkLRglx2nL+EzLluO6v8yLuxvdWJ004tfuHSeXUCt9z6I8ZG
         jd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692697468; x=1693302268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0C05FVrXugMzpMLLN6rQ3DKyIstnViCGSG0P90hg2Y=;
        b=Xo22QITMk7IvXDbj4V2yC10uzukMdsbXAiHYSlGVUmB5vs5sXQ+phNaKFDbwObBndI
         UV655/Vii6Sxh/KwoPq7N6Keplq8swsxnm3Q6rvSreyFm62vRIlRhaPmW2fatGguwYuA
         sSs1h0gj+Mt5C7ZdSei8+p8qzMNFdStoP09/Nr+5xYE6v3NWcFI0J8DJw0WZW5yxjNO5
         g349/2UQvRY1m04Zx2ib8+bJQvKVamu9gi0zNX/YsPMbQ/FmZRl6ZJuCHubmHW1oHX2C
         //YmzEP/zAb406e0pHLDztmfgUdUX7tMowoxdfkz1QZLr/TKd97EwUvUPZtrLZge0fVO
         qcMQ==
X-Gm-Message-State: AOJu0YxXeKNulu7lQKtPPo0xI82PjKZQ/xiFvBdHlULPpUvxDoB4k+xM
        Bit1oqn7vpWHkKhWUJ5yJNgwy8vdnqxtvNplZtpd7A==
X-Google-Smtp-Source: AGHT+IEmitXTVbbNazoqZB5Cnvk+Smq+OuRyQHxRvpBRt0NNYPguK5hiJA2oGS808+nNpuGAh1SDYQ==
X-Received: by 2002:a17:90a:1348:b0:263:f36e:d610 with SMTP id y8-20020a17090a134800b00263f36ed610mr8456324pjf.0.1692697468340;
        Tue, 22 Aug 2023 02:44:28 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id x33-20020a17090a6c2400b00267d9f4d340sm9976082pjj.44.2023.08.22.02.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:44:28 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: arm: qcom: add sc7180-lazor board bindings
Date:   Tue, 22 Aug 2023 17:44:13 +0800
Message-Id: <20230822174101.v4.1.I26e017b00a341e7a5a2e94a83596923713408817@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822094414.123162-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20230822094414.123162-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

