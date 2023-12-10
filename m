Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BAB80BB47
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjLJNse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJNsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:48:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607B3E3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:48:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so34450105e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702216118; x=1702820918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3064XmdITzZhPjLLGnjAD2LPSNczuONCpTaBgiThtlU=;
        b=ozW74SMYErSiAOdKNaS4fRVIHiDxvu0elJCcVpN/PSKbrJ0/mGB1DbvBEDqDfaWehb
         W5rOUn/efJVgl4JRyGfBLpo1ASXbzCWBCn1sdcNUwam9Iej8Isuk4MRsQFcs/tZD6WPh
         3JRolH1A2Gc4J5mibJalaSoDSuBFFeyz8ZjthpAC+ZgMRE7UdHcOeSrEJwS3tpqbye6V
         riDklu+X/wKjt/5plIy1hd/azrCrXFFNsYXrx4lr1/ISgoOUyi4gSQ7v5ztLPtOlHY4O
         BrpLhEwK6k5HGOveBGxjYLXwL+z/lAUCkXeijO2LutulD3QlH3BqJjf9ZLkP3M69xXd0
         gtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702216118; x=1702820918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3064XmdITzZhPjLLGnjAD2LPSNczuONCpTaBgiThtlU=;
        b=oL1KxEe2X6NMOKF4V929kX1n4r+SUoIr2XiBbXO4M+7NqUJVFzyZHOORFKjvgBWKtN
         c2GhvH2g1yspnWpTNKdTGsQv3WYJYi14J9Ht7Mv0ysRvTpRTsvNd29EGvWYSsnmcyFoX
         wo458qai0tmLYVz2ZdxBW76+/YlsSSS1h7MMXQIhoQxXKbBf16fyTLrJePezBHCcbS7p
         Lu8nE8q2prXkYrSwYNuWm6cRhf7ISth9sAhnsiU+tOVWJ7K2ksBesR0jNys/fmeO8Jc4
         wqwB4Bzs0YJ/lqCDvrozkuNOZkapdRM8Bu3N5636ztMDMO5nD7tzW56TSAy0j84EXIZ1
         7uxg==
X-Gm-Message-State: AOJu0YyObcr0XlIEbLfAz372EE5d9LUt2Ip7BaxwR9Itlcmf1AX7cN/0
        VuuRmE92Ietm4F4Uk7pp78+MQA==
X-Google-Smtp-Source: AGHT+IEYQWyFLps+8a1ktVUX5+xvwEHwYnJq6SULwm1krEw6dm0X1VeyTvwbJRq3QCqZsYXhNWCVrg==
X-Received: by 2002:a05:600c:3107:b0:40c:2dd8:3a38 with SMTP id g7-20020a05600c310700b0040c2dd83a38mr1452502wmo.80.1702216117646;
        Sun, 10 Dec 2023 05:48:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id be9-20020a05600c1e8900b0040596352951sm12062097wmb.5.2023.12.10.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 05:48:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: samsung: exynos-sysreg: combine exynosautov920 with other enum
Date:   Sun, 10 Dec 2023 14:48:34 +0100
Message-Id: <20231210134834.43943-1-krzysztof.kozlowski@linaro.org>
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

No need to create a new enum every time we bring-up new SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/samsung/samsung,exynos-sysreg.yaml        | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 2de4301a467d..b00f25482fec 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -17,6 +17,8 @@ properties:
               - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
               - samsung,exynos5-sysreg
+              - samsung,exynosautov920-peric0-sysreg
+              - samsung,exynosautov920-peric1-sysreg
               - tesla,fsd-cam-sysreg
               - tesla,fsd-fsys0-sysreg
               - tesla,fsd-fsys1-sysreg
@@ -50,11 +52,6 @@ properties:
               - samsung,exynosautov9-peric1-sysreg
           - const: samsung,exynosautov9-sysreg
           - const: syscon
-      - items:
-          - enum:
-              - samsung,exynosautov920-peric0-sysreg
-              - samsung,exynosautov920-peric1-sysreg
-          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.34.1

