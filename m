Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E4077E6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbjHPQrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344929AbjHPQqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1307419A4;
        Wed, 16 Aug 2023 09:46:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso899718566b.1;
        Wed, 16 Aug 2023 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692204404; x=1692809204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsImODL9pP4EzwrsGgeSbtpXRSmRGbHYZ1K1zyJDRyA=;
        b=IzcWZi+6F6b9au2dKhJNgHKlK/Gc7//hOHeEZjVPqEDiHQsOVsGS76v2oyWTTgN7El
         SnHGVMzwXO1hCadVUg/iAC1RZLOmcMvXEaPm1QvY2Jams1T2F9r7N0iSAjkiCYKoU2XV
         xzS3k07M5ucAqiiF30mQ9kCqMwmCxj53JPFbaXGpYhW6BsngdYhfw+J64MYiWMfQcIR9
         2HPvE+taEAxdva+nYqOGAcOacubPqbJVeKBsOGcgMGQGpKg98g1+iBfd9CLR7XI3aqpq
         Ok3iRCYvyX5hLk1C3MBb8PUKG2ospBbeqDkeyD7X00V3LMQWf/GkQHd/Nb6VVK6csmXx
         CucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204404; x=1692809204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsImODL9pP4EzwrsGgeSbtpXRSmRGbHYZ1K1zyJDRyA=;
        b=beFYBGNuMvlKUfrN2Rh2g59SOltRefuyaAA6bxf3nzJiStzuO+yLEVg6uHRiliYaTJ
         V0g0kBaY2W+d+pYrKxc+00+ED0aYkaFBQwF18/Wle+D3qJuiNey8xk1cF2BLeJ2bjGs5
         TIa/lrJpvkfINMr9gbRlItG6kpZUXpAVMuhWfbhxR//KQ8cve0LKfpJV0kHukrQkG4H8
         u3US64TYo0KFE31EfUnmyZAX0Xjmf/GV/Rh+3Vd1tx9VIBLYB879ntqdpepI0BjXGvrf
         CzRHdE3ir3/Hc4GdoERCXCtngDnxwKG/ArTnJuvBGbn3ea+ZN0kExqLBZnxeFxXWe3jw
         OuYw==
X-Gm-Message-State: AOJu0Yw9QAnazjczBcjFXBgHbt7+quBV3FpjfFqkTtqmp5D2Uq5xmg8Q
        W2g4lmM8GdWCpI3/dCh6jHB0UJmtE77QZw==
X-Google-Smtp-Source: AGHT+IGO7wHJkMFXsID9CwRLlP67HJ5fTJaEUaK7Jv7nqr8m7qSVp2IcLzOVkqB90VESxmsOq7AsXA==
X-Received: by 2002:a17:907:6d21:b0:99c:85af:7aa6 with SMTP id sa33-20020a1709076d2100b0099c85af7aa6mr2587146ejc.28.1692204404405;
        Wed, 16 Aug 2023 09:46:44 -0700 (PDT)
Received: from fedora.. (dh207-98-254.xnet.hr. [88.207.98.254])
        by smtp.googlemail.com with ESMTPSA id b15-20020a170906490f00b0099c971ba285sm8697400ejq.5.2023.08.16.09.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:46:43 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mojha@quicinc.com
Cc:     computersforpeace@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: firmware: qcom,scm: support indicating SDI default state
Date:   Wed, 16 Aug 2023 18:45:38 +0200
Message-ID: <20230816164641.3371878-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
means that WDT being asserted or just trying to reboot will hang the board
in the debug mode and only pulling the power and repowering will help.
Some IPQ4019 boards like Google WiFI have it enabled as well.

So, lets add a boolean property to indicate that SDI is enabled by default
and thus needs to be disabled by the kernel.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Change the property so it indicates that SDI has been enabled by default
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 4233ea839bfc..590bbbd61de5 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -89,6 +89,14 @@ properties:
       protocol to handle sleeping SCM calls.
     maxItems: 1
 
+  qcom,sdi-enabled:
+    description:
+      Indicates that the SDI (Secure Debug Image) has been enabled by TZ
+      by default and it needs to be disabled.
+      If not disabled WDT assertion or reboot will cause the board to hang
+      in the debug mode.
+    type: boolean
+
   qcom,dload-mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-- 
2.41.0

