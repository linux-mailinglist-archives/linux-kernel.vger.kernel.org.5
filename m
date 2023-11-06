Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9CA7E1E63
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjKFKd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:33:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F04CC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:33:22 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40850b244beso33228715e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699266800; x=1699871600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNIPKS5bjo7Dr0T0Rtv+hJZqj7mUU2yEUzYTVTWO2dY=;
        b=nSfR5cYNjJ+nQxY4zK+nmulfPquwtkQmMS6pDIsj2BcrRSa20O0TwWFw/gtCZG87ie
         J56K+iLCj5Y4CyTNr/AMfvsL3tKUGHR2zNkvhGLwR/aLzaCHYw1756qsFxAJhzJgFztR
         FCI7UjYFwe9CR6l8N/jyLIxvCxDLPLtoggazk59aDU2lBasohgkI+uwHBNfuuVp4o22v
         fVmVYpV/N+aHP8UimDXOsAKdEQQWsu/Er0S0fEmqmFe00zxHaY7QPZiE0U0ziuv9WY7x
         eCDa0M11IIk4U3MjOnB/pl+5hfcv6r6rE14xA7tQdMJr/cfTgmbSMoX0gHGG3oselHau
         m4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699266800; x=1699871600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNIPKS5bjo7Dr0T0Rtv+hJZqj7mUU2yEUzYTVTWO2dY=;
        b=vt+g3Jl64j99PZtMaXEnZZDaTN0HdTV0YaBXheYtoBOb54Fmj+u0muLQSKJVldqZ+M
         0fPDsc0GbulutkyTQ2NUTDjKQO1vLTS+r44Vbs5XoqK08C5f66y/kyDnd00FMrITETDS
         VdL0+j5DkOVeABFazHkbJEWUr/5RM1N5vJVpiftEtrK37jXj37IvzvtbCWrRzB9uJWE4
         AVqb788cIpYA1OoEY/QeAr451Ov0lPRGYJBJ2P8BTBP2S4/aKqPZ3784eSUAlN+toOSb
         0ppD8+XklYXzdjxMvojkKW2vDEmgtLFZVeQF/VjR/9sQ+snqICVCTIpWVtufQ+GENRfW
         JSMw==
X-Gm-Message-State: AOJu0YxFMyLV+xjYCExntPDP7XA4V6mekcBuGPo4oAbIH2qpVJ4+gaEN
        DW8lbfYukC1JYCAQ154ZPX/E0A==
X-Google-Smtp-Source: AGHT+IFZcXHpJEgaNO2TxS6ZjAx7zwqUsBZowvheo5z7hKAXHcnZJDMKQ6s3lTl4gf5lUUnQ+pX+BA==
X-Received: by 2002:a05:6000:1884:b0:32f:b407:5b77 with SMTP id a4-20020a056000188400b0032fb4075b77mr9038937wri.64.1699266800451;
        Mon, 06 Nov 2023 02:33:20 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:fabf:ec8c:b644:5d3])
        by smtp.googlemail.com with ESMTPSA id d1-20020a056000114100b0032415213a6fsm9033602wrx.87.2023.11.06.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:33:20 -0800 (PST)
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
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH 1/6] dt-bindings: pwm: amlogic: fix s4 bindings
Date:   Mon,  6 Nov 2023 11:32:48 +0100
Message-ID: <20231106103259.703417-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106103259.703417-1-jbrunet@baylibre.com>
References: <20231106103259.703417-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s4 has been added to the compatible list while converting the Amlogic PWM
binding documentation from txt to yaml.

However, on the s4, the clock bindings have different meaning compared to
previous SoCs.

On previous SoCs the clock bindings used to describe which input the PWM
channel multiplexer should pick among its possible parents.

This is very much tied to the driver implementation, instead of describing
the HW for what it is. When support for the Amlogic PWM was first added,
how to deal with clocks through DT was not as clear as it nowadays.
The Linux driver now ignores this DT setting, but still relies on the
hard-coded list of clock sources.

On the s4, the input multiplexer is gone. The clock bindings actually
describe the clock as it exists, not a setting. The property has a
different meaning, even if it is still 2 clocks and it would pass the check
when support is actually added.

Also the s4 cannot work if the clocks are not provided, so the property no
longer optional.

Finally, for once it makes sense to see the input as being numbered
somehow. No need to bother with clock-names on the s4 type of PWM.

Fixes: 43a1c4ff3977 ("dt-bindings: pwm: Convert Amlogic Meson PWM binding")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 68 ++++++++++++++++---
 1 file changed, 59 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index 527864a4d855..754b70fc2db0 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -9,9 +9,6 @@ title: Amlogic PWM
 maintainers:
   - Heiner Kallweit <hkallweit1@gmail.com>
 
-allOf:
-  - $ref: pwm.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -43,12 +40,8 @@ properties:
     maxItems: 2
 
   clock-names:
-    oneOf:
-      - items:
-          - enum: [clkin0, clkin1]
-      - items:
-          - const: clkin0
-          - const: clkin1
+    minItems: 1
+    maxItems: 2
 
   "#pwm-cells":
     const: 3
@@ -57,6 +50,56 @@ required:
   - compatible
   - reg
 
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8-pwm
+              - amlogic,meson8b-pwm
+              - amlogic,meson-gxbb-pwm
+              - amlogic,meson-gxbb-ao-pwm
+              - amlogic,meson-axg-ee-pwm
+              - amlogic,meson-axg-ao-pwm
+              - amlogic,meson-g12a-ee-pwm
+              - amlogic,meson-g12a-ao-pwm-ab
+              - amlogic,meson-g12a-ao-pwm-cd
+              - amlogic,meson-gx-pwm
+              - amlogic,meson-gx-ao-pwm
+    then:
+      # Historic bindings tied to the driver implementation
+      # The clocks provided here are meant to be matched with the input
+      # known (hard-coded) in the driver and used to select pwm clock
+      # source. Currently, the linux driver ignores this.
+      properties:
+        clock-names:
+          oneOf:
+            - items:
+                - enum: [clkin0, clkin1]
+            - items:
+                - const: clkin0
+                - const: clkin1
+
+  # Newer IP block take a single input per channel, instead of 4 inputs
+  # for both channels
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson-s4-pwm
+    then:
+      properties:
+        clocks:
+          items:
+            - description: input clock of PWM channel A
+            - description: input clock of PWM channel B
+      required:
+        - clocks
+
 additionalProperties: false
 
 examples:
@@ -68,3 +111,10 @@ examples:
       clock-names = "clkin0", "clkin1";
       #pwm-cells = <3>;
     };
+  - |
+    pwm@1000 {
+      compatible = "amlogic,meson-s4-pwm";
+      reg = <0x1000 0x10>;
+      clocks = <&pwm_src_a>, <&pwm_src_b>;
+      #pwm-cells = <3>;
+    };
-- 
2.42.0

