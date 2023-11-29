Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD817FD85E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjK2Nkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjK2Nk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:40:28 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F210A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:40:34 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c88b7e69dfso80940391fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701265232; x=1701870032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQRwxx9GEOBkFVTtu0HXXPOcGrMBOKITGaWl4mMUCHI=;
        b=JhJFE5s9qNJaFRQopr+cK1bLrEwuATVyZ4pBBTf3+Nx8RQ8Rdi6kvrufAEyjSac/b5
         flnqbFamH5PzLaGzE8QkgEwGWN2rTuAJcdVgsXGTnxpszd0euFL6l7MqmBJ+0fNhW/wq
         wO7TCpJBDu9vGy3k79HbyRuLAZ/GqTH8pS73Iq8FTU9V5kP1YCDVbD2lh570QZhBdZFq
         geMfimrX86N5hsfGe9MsJ7T3HPIRtiuzV/1jwOOUXD1ayvbJhu97sxqQoKDCS1pahgL3
         7/3fpVnp5cleisFgVzjlTL+02qD78Kfxq+lUs9Puaf0iWdeXnYNFIHrYSnoXLXILONLf
         xGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701265232; x=1701870032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQRwxx9GEOBkFVTtu0HXXPOcGrMBOKITGaWl4mMUCHI=;
        b=Ed2jy0824mTueKamx7HdsGeqHL/U1WNRVkIp/LNOyA95I2nr09IbUU7+xZdklrlqW3
         L/vYbuJ/ibTPeW8JZ8rbJIUnuvriLfPqeMTxy9o4yiLmbaFrpanXTVg5Wxv8OG3Jvcdj
         miI8pDp0tZqGjpdyl0dmevwVySErwr8XW67BEk8kjkAjYCPOG6lwsIcVDxTRk45GA/3u
         QuuOnfdnvbWy+iMiSeE6hUnWIeyXh07XBU2Oz8KRMANDy06zMxDfQDHg51qoYR2DBR0+
         THLo5vxHU0bIJaJ522FLz7C72H7S+KmCRS3YUhjZs0Jq/RkszjiKJFrJNzkNfPClk66W
         n5sg==
X-Gm-Message-State: AOJu0YydonlFm6WMKISNjqopjb5WzAYTjlHdFglFdUpk8X5L5xD2rAuM
        4jIptlv3DRlNv5v0hSsCCMQJbw==
X-Google-Smtp-Source: AGHT+IE6EXkIS1MLDJ9G7G35/UHE0u8PoIQgoq4VqHWzasYKaYE0gqoMNy6M4o6VE2MrG4pH/0KbYg==
X-Received: by 2002:a2e:9646:0:b0:2c9:ba44:fd9d with SMTP id z6-20020a2e9646000000b002c9ba44fd9dmr2347821ljh.38.1701265232031;
        Wed, 29 Nov 2023 05:40:32 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:6101:5529:fe2d:d7eb])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05600c475100b004080f0376a0sm2285860wmo.42.2023.11.29.05.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:40:31 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 2/4] dt-bindings: pwm: amlogic: add new compatible for meson8 pwm type
Date:   Wed, 29 Nov 2023 14:39:58 +0100
Message-ID: <20231129134004.3642121-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129134004.3642121-1-jbrunet@baylibre.com>
References: <20231129134004.3642121-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs,
dealing with clocks differently. This does not enable new HW. It is meant
to fix a bad DT ABI for the currently supported HW.

The original clock bindings describe which input the PWM channel
multiplexer should pick among its possible parents, which are
hard-coded in the driver. As such, it is a setting tied to the driver
implementation and does not describe the HW.

The new bindings introduce here describe the clocks input of the PWM block
as they exist.

The old compatible is deprecated but kept to maintain ABI compatibility.

The SoC specific compatibles introduced match the SoC families supported
by the original bindings.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 52 ++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index 387976ed36d5..eece390114a3 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -21,23 +21,35 @@ properties:
           - amlogic,meson-g12a-ee-pwm
           - amlogic,meson-g12a-ao-pwm-ab
           - amlogic,meson-g12a-ao-pwm-cd
-          - amlogic,meson-s4-pwm
+        deprecated: true
       - items:
           - const: amlogic,meson-gx-pwm
           - const: amlogic,meson-gxbb-pwm
+        deprecated: true
       - items:
           - const: amlogic,meson-gx-ao-pwm
           - const: amlogic,meson-gxbb-ao-pwm
+        deprecated: true
       - items:
           - const: amlogic,meson8-pwm
           - const: amlogic,meson8b-pwm
+        deprecated: true
+      - const: amlogic,meson8-pwm-v2
+      - items:
+          - enum:
+              - amlogic,meson8b-pwm-v2
+              - amlogic,meson-gxbb-pwm-v2
+              - amlogic,meson-axg-pwm-v2
+              - amlogic,meson-g12-pwm-v2
+          - const: amlogic,meson8-pwm-v2
+      - const: amlogic,meson-s4-pwm
 
   reg:
     maxItems: 1
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 4
 
   clock-names:
     minItems: 1
@@ -58,7 +70,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - amlogic,meson8-pwm
               - amlogic,meson8b-pwm
               - amlogic,meson-gxbb-pwm
               - amlogic,meson-gxbb-ao-pwm
@@ -67,14 +78,15 @@ allOf:
               - amlogic,meson-g12a-ee-pwm
               - amlogic,meson-g12a-ao-pwm-ab
               - amlogic,meson-g12a-ao-pwm-cd
-              - amlogic,meson-gx-pwm
-              - amlogic,meson-gx-ao-pwm
     then:
-      # Historic bindings tied to the driver implementation
+      # Obsolete historic bindings tied to the driver implementation
       # The clocks provided here are meant to be matched with the input
       # known (hard-coded) in the driver and used to select pwm clock
       # source. Currently, the linux driver ignores this.
+      # This is kept to maintain ABI backward compatibility.
       properties:
+        clocks:
+          maxItems: 2
         clock-names:
           oneOf:
             - items:
@@ -83,6 +95,27 @@ allOf:
                 - const: clkin0
                 - const: clkin1
 
+  # Newer binding where clock describe the actual clock inputs of the pwm
+  # block. These are necessary but some inputs may be grounded.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8-pwm-v2
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          items:
+            - description: input clock 0 of the pwm block
+            - description: input clock 1 of the pwm block
+            - description: input clock 2 of the pwm block
+            - description: input clock 3 of the pwm block
+        clock-names: false
+      required:
+        - clocks
+
   # Newer IP block take a single input per channel, instead of 4 inputs
   # for both channels
   - if:
@@ -112,6 +145,13 @@ examples:
       clock-names = "clkin0", "clkin1";
       #pwm-cells = <3>;
     };
+  - |
+    pwm@2000 {
+      compatible = "amlogic,meson8-pwm-v2";
+      reg = <0x1000 0x10>;
+      clocks = <&xtal>, <0>, <&fdiv4>, <&fdiv5>;
+      #pwm-cells = <3>;
+    };
   - |
     pwm@1000 {
       compatible = "amlogic,meson-s4-pwm";
-- 
2.42.0

