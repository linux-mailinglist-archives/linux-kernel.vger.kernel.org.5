Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B494477CDF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbjHOOTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbjHOOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:19:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAA5173F;
        Tue, 15 Aug 2023 07:19:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bfcf4c814so728419466b.0;
        Tue, 15 Aug 2023 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692109151; x=1692713951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nhmVvg06wbI8jqCZG20CjBaE/opAQ91Hl7ndYxBDBhQ=;
        b=f37BCx5cn3Ke5BGSr8QDfFO5rmMbMw7eoJnI2c6Y9SMyGZBTlXxnupL/hM4G34rHEZ
         nT4XrOZA0GX6F9kUArQLnPYgT3rN5vY4cZyg6T6odxf0y9byEfo4l9fbTkaNLXgKqybh
         EJBOKAHtbIyhRu7kjv395V5VWchcZSAm78kJ5SenkuUv57B5pr+5XgrQvLHxb9Awg6cH
         feUBew6pe4AdEDkPBBVAlKOJ3PjP8Tb3InAVXCCYonucmzIW4Rf7OQ/Ei4+7lLAFo64j
         ckiOG1H1lRf5vTHLiQZ5b4biVB+QcnWAB81H7mQnulIZ2ovIb5iQYIBYPuQRW2J81bv6
         YGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109151; x=1692713951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhmVvg06wbI8jqCZG20CjBaE/opAQ91Hl7ndYxBDBhQ=;
        b=fsIRaPy1xZOPE9Uq+JSUsL2CkssKylx3gEQVBxsuERTnRtZjAPTcGVAWc5rFoEc6H8
         uzXq2oBuBUCN+R0XKwfMgFZOqGG75rGG3ylK510Cl+zAziUXuSW3ihCqJGq/fjLJxcny
         7pgqFp0IYYO2aEj5IRnYXiofujPafKUQbXsaM4LAt59W2VmgXWmPAPnIS1+UgE9e08Hc
         IDF09jPCPRnG7jSElM1u5GXoM1NZK3EPhiMLP/rUXXrpZsrF4cHeYr4cQZ7i+u+gHCN/
         UHlMx7WanEAiOBg68/cl86s8razhj18Z9NZZvNbFVDO7ue4wjmRbwzFvmBJpNyjwyFj6
         LbgA==
X-Gm-Message-State: AOJu0Yyq3P516n7Lm7mk1tq5xxCO41dVqV0/Ozu73cYUJ+5k4/0ZLq+B
        4L77GmitD2dHzseLpuRtf1g=
X-Google-Smtp-Source: AGHT+IFhEEj+3Bu5Z3UwjEfEbtPfZLCwxJ1ns6kTyOOhp+h1AhvwBTnbkEkbhItRwiu18ULe5xTOTQ==
X-Received: by 2002:a17:907:b1a:b0:99c:e38d:a824 with SMTP id h26-20020a1709070b1a00b0099ce38da824mr10170567ejl.37.1692109151491;
        Tue, 15 Aug 2023 07:19:11 -0700 (PDT)
Received: from fedora.. (dh207-96-14.xnet.hr. [88.207.96.14])
        by smtp.googlemail.com with ESMTPSA id j15-20020a170906278f00b009926928d486sm7078743ejc.35.2023.08.15.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:19:10 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] dt-bindings: watchdog: qcom-wdt: document IPQ5018
Date:   Tue, 15 Aug 2023 16:17:50 +0200
Message-ID: <20230815141908.1084893-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the IPQ5018 watchdog compatible.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 6d0fe6abd06a..5046dfa55f13 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - qcom,kpss-wdt-ipq4019
+              - qcom,apss-wdt-ipq5018
               - qcom,apss-wdt-ipq5332
               - qcom,apss-wdt-ipq9574
               - qcom,apss-wdt-msm8994
-- 
2.41.0

