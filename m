Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B437E8B33
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjKKOYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjKKOUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:20:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C404C4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:20:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c773ac9b15so439155966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699712421; x=1700317221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+rGHu4+hJGBcXxtLJ4Rwqvl52gGeDFd9pbxtP6MGM4=;
        b=vDru2G1+lqBr2jr6dxFZYFlRHm6jsNFhAloQhK9nD36hNr1FKhF6IGkSul8Ep74Gcc
         c7/epWhh3/Vcr7IrNoOW2zKQR0vKDMU5lE/zEqaYRYovBC3Lk5uT5sBP8t5KXvmiSmAN
         GdFvwwmGwVdY5lxtWc/W12Lj9bt4wZtTrderCYTFLB5g2redDfKJmMvYSOkUrS4BMwBr
         X+ToV6+zaSOFsJh9GuAqyt+rfyYbm7UnjR7XaYVSd7R/TEUHdLWrTaIKAmiKqJrhISOy
         rCkMiiOGchHCG3mPslDlmI7lJcJhTOh8GVrZvRn2tuxnjdTZPe18IJQT+cnXdaS8GFXj
         n+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699712421; x=1700317221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+rGHu4+hJGBcXxtLJ4Rwqvl52gGeDFd9pbxtP6MGM4=;
        b=ep2Yg3q6EeQH83nmI82EH7fNWbFka8NtYgWPPlp9lWtzfcx1hOzihDv61hkZ41JUE8
         oF7Vo7BoQwORm8Mp6W4uDncEHvyttgEM+tfXOq52lVdXRnXxU3c09H9cDDt/o11ly/1C
         U+5hIYrwGhTqBmzpnKpd0+XpAYFv9uuni81bB75fJhKj2c/EKW3KCREAF5w6ZtgGhNdP
         tqOFbDAADcvBvPxx0gFj/IHdJkEIXBIQpkPFjWsxoJMhXK3UDPwzy/5VSDfR/Qb4Rrmj
         dDwYNZji+7NPbnloUIxUzUDFgJ/YXuDao4yg8VWyw40i1lWeVPbLSamw2punOVkEv+RA
         nTag==
X-Gm-Message-State: AOJu0Yx9bABnKi4PJa65cmDd9PZ/KBtRnvsjgZuoInDzUWNviFG/PTy5
        ddO6lSsEaa93J5e3RIpqr4iXUw==
X-Google-Smtp-Source: AGHT+IECfXbaxOyC0p84OSUFRchWp6f0l4rtPfq/72J6ycLCYhXwSvjyroaayvZVZLq2Q1VBC7meaw==
X-Received: by 2002:a17:906:b30d:b0:9bf:4915:22c4 with SMTP id n13-20020a170906b30d00b009bf491522c4mr1123508ejz.67.1699712420937;
        Sat, 11 Nov 2023 06:20:20 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id gl11-20020a170906e0cb00b009b9aa8fffdasm1136125ejb.131.2023.11.11.06.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 06:20:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display/msm: qcom,sm8150-mdss: correct DSI PHY compatible
Date:   Sat, 11 Nov 2023 15:20:17 +0100
Message-Id: <20231111142017.51922-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SM8150 MDSS comes with a bit different 7nm DSI PHY with its own
compatible.  DTS already use it:

  sa8155p-adp.dtb: display-subsystem@ae00000: phy@ae94400:compatible:0: 'qcom,dsi-phy-7nm' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml
index a2a8be7f64a9..c0d6a4fdff97 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml
@@ -69,7 +69,7 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,dsi-phy-7nm
+        const: qcom,dsi-phy-7nm-8150
 
 unevaluatedProperties: false
 
@@ -247,7 +247,7 @@ examples:
         };
 
         dsi0_phy: phy@ae94400 {
-            compatible = "qcom,dsi-phy-7nm";
+            compatible = "qcom,dsi-phy-7nm-8150";
             reg = <0x0ae94400 0x200>,
                   <0x0ae94600 0x280>,
                   <0x0ae94900 0x260>;
@@ -318,7 +318,7 @@ examples:
         };
 
         dsi1_phy: phy@ae96400 {
-            compatible = "qcom,dsi-phy-7nm";
+            compatible = "qcom,dsi-phy-7nm-8150";
             reg = <0x0ae96400 0x200>,
                   <0x0ae96600 0x280>,
                   <0x0ae96900 0x260>;
-- 
2.34.1

