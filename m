Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB55D788928
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245338AbjHYNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245337AbjHYNzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:55:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBDD213C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:55:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso1402316a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692971720; x=1693576520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPFNeQZ6wVRfzI8X+CMFP24H+xIdOAmdyrQlfRbcMWo=;
        b=ZN01E7vC5V4lr5DN8gK8WHHWia8UvZTCNZidis4wfPTVeTWXb7LIUjOy2lUstg2QFL
         5GAg2aiShjUkSQK+8pamK94NEv+14WKP3TKGoCvA4s04POXDZOQ07bM8jTkNWPCLQGoY
         SWsNKpUONLJeLM0Zel0KZHHSgd/OC2bb/eka/nIgZ4q0zDvllFitZi/8m8NOOyaZZQUd
         kcmAthFH0TpQQWMESMcUQQ51C0EWAzsK7QnHzzLiak9o9vbiOTCXyuvBGia+Ze1Bd2Ze
         DrKM71kEzpn1GWokkIAhYGn9ktuS1TNBEsEGm4iN5+SUe/of73o5DcFx57RZFOlcNzXU
         qD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971720; x=1693576520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPFNeQZ6wVRfzI8X+CMFP24H+xIdOAmdyrQlfRbcMWo=;
        b=RBt6E818hOcy4FSAKS9Mfy0wHV2vQc841b/7aayyqti0Xf+TYwyuSszurY7Z9bPTMX
         EANEBgkIiXsRXSKpgdf8XEtsJMbsEay6EvwAKzgVUtoFIsFHpqRFAK4urCQGojojf16B
         +vgLuKObXCMFnG0Ps4Ggfup7wvc4VejxJJm0FgX5Rpbx31U1pGMIAM+w/UaZ92taL0Mf
         +yycKlMtAiDsW5yRgx+hqwqiyQWB+d/t0ZSgScKOoCfXVUY1a3ZWY1BtUd7JzoQJSAeY
         +Jw9iTyFovWUm+rh5OIfaYheTjTWebTL37iYP0ENPat9z49oI6GWPsm9MtJooVZ+qy5h
         gY0g==
X-Gm-Message-State: AOJu0Yz0yfGQJ+acqgH0o3YdCzysVbyl4F87aEYcBR/xx8fbQrzmu89x
        YDvH48cO5D17wVGqyUP9clTGmw==
X-Google-Smtp-Source: AGHT+IFRV3jqjze/aOO11lTy2Fdk+HSPuP8nR7u8lakxQfGbHRcI9XDn413gGrhmM5E4cgTzI4fdqw==
X-Received: by 2002:aa7:c698:0:b0:527:60c:53d9 with SMTP id n24-20020aa7c698000000b00527060c53d9mr12929555edq.15.1692971719371;
        Fri, 25 Aug 2023 06:55:19 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7d615000000b005256aaa6e7asm1019660edr.78.2023.08.25.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:55:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: mmc: sdhci-msm: allow flexible order of optional clocks
Date:   Fri, 25 Aug 2023 15:55:03 +0200
Message-Id: <20230825135503.282135-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
References: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SDHCI controller lists optional clocks, but still expects
fixed order of them and does not allow to skip such clocks if further
one in the list is needed.  These optional clocks are truly optional,
so we need to allow the list to have different orders.  The clocks are:
 - ice: used for Inline Crypto Engine, which is actually separate block
   and merging it with SDHCI is not a requirement,
 - bus: clock for SDCC bus frequency voting,
 - cal and sleep: used for RCLK delay calibration and required for
   certain platforms for such calibration (as expressed in original
   commit 4946b3af5e8e ("mmc: sdhci-msm: Enable delay circuit
   calibration clocks")).  Only MSM8974pro has these clocks.

Relaxing the order fixes dtbs_check warnings:

  qcom-msm8974pro-fairphone-fp2.dtb: mmc@f9824900: clock-names:3: 'ice' was expected
  qcom-msm8974pro-fairphone-fp2.dtb: mmc@f9824900: clock-names:4: 'bus' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 10f34aa8ba8a..69a213965089 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -85,10 +85,10 @@ properties:
       - const: iface
       - const: core
       - const: xo
-      - const: ice
-      - const: bus
-      - const: cal
-      - const: sleep
+      - enum: [ice, bus, cal, sleep]
+      - enum: [ice, bus, cal, sleep]
+      - enum: [ice, bus, cal, sleep]
+      - enum: [ice, bus, cal, sleep]
 
   dma-coherent: true
 
-- 
2.34.1

