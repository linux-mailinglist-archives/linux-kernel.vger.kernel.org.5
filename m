Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4C7C9F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjJPGRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjJPGRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:17:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729ACE4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:16:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so7121291a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697437018; x=1698041818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmF5+yStHKKyV0l0IYYnGUX1bf/bvuE2VGird9kSXYY=;
        b=LfOO4QgwUVndQRyBa6FMS6AOoswCmmNb/p4TiCrF0HcMdL2l2b8lGxgXKznWZUM3bZ
         defJsQm1MksmxGE/AbUrLm0UcViJSfxBn2Ki2ruPbG+iFi8zRxrt5IH3tJvRBOYCP6WM
         GS8STZjsmsqCs3sjbcbVlQ3vBBMj570hcV7/KEQuslayh2b+Ma/FDJggNwHNkla8f6Qu
         eukijTQtenZZ7PyvTGhSUOAv3Ux/RKC4Kg40zdntZ6HzHHIUmiIdfJKZ8D1g7MskLCB0
         F5VyY8Mz5+Q7j4qaDsvvgpPfqOvvuLgW897YCPcfuEZeqzgZZ25sFmGxhX8oSy7GeOci
         dj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697437018; x=1698041818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmF5+yStHKKyV0l0IYYnGUX1bf/bvuE2VGird9kSXYY=;
        b=SwqnIN17+YIm6BahkzTXcaQ+ImMGT+GZ9DVI6jUUGHT1/qvJDUt+21O+k7FZ8xZN7u
         utDR2Rf7aItZouC01FW2eO7Oeukn9Q56Fg/p0UkExqG7Go0dOycB9vg5o00WBQNDdu7u
         iSB20tm1nf0GXrYF2pIJ9aRWQg3XBWC3sbAxTWB5wa5WdMQ1c1laV2E6ylq5WqyjRGR0
         87n9a6k0Zx7XOYb081Su+ue94k1Y8pCiAfqN8Xv5lpM+H1HgYAS8YaN+/cCJ79gaS11l
         vQqIiGtSOkw8dqn2m0Ak3cYI0m8MPDAKjdQIcrbw9vqBvtpxAV6RLcTcPDQIQH+5kKVd
         NyIQ==
X-Gm-Message-State: AOJu0YxOT41mtiSz+uVjlS2tEy0xKga8VgoyKZ1WLDDYonZT77b4dLmo
        tA3kV1akLIPrBotFqHogDTJRiw==
X-Google-Smtp-Source: AGHT+IHe5cIN5p6XbzVxAOUtSUAiESZxqFtes9yfDKxd+6qrsRtc0sPgEXvxqQS0q6JeXxxDJNhLZg==
X-Received: by 2002:a17:906:3156:b0:9b2:b71f:83be with SMTP id e22-20020a170906315600b009b2b71f83bemr27707553eje.1.1697437017808;
        Sun, 15 Oct 2023 23:16:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id rh14-20020a17090720ee00b009b947f81c4asm3318895ejb.155.2023.10.15.23.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 23:16:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: serial: re-order entries to match coding convention
Date:   Mon, 16 Oct 2023 08:16:54 +0200
Message-Id: <20231016061654.22267-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT schema coding convetion express in
Documentation/devicetree/bindings/example-schema.yaml expects entries in
following order:
 - properties, patternProperties
 - required
 - if blocks, allOf with if-blocks
 - additionalProperties/unevaluatedProperties

Re-order few schemas to match the convention to avoid repeating reviews
for new patches using existing code as template.  No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/serial/nvidia,tegra20-hsuart.yaml   | 10 +++++-----
 .../bindings/serial/qcom,msm-uart.yaml           |  4 ++--
 .../bindings/serial/qcom,msm-uartdm.yaml         |  4 ++--
 .../bindings/serial/renesas,em-uart.yaml         | 14 +++++++-------
 .../bindings/serial/renesas,hscif.yaml           |  4 ++--
 .../bindings/serial/renesas,scifa.yaml           |  4 ++--
 .../bindings/serial/renesas,scifb.yaml           |  4 ++--
 .../devicetree/bindings/serial/samsung_uart.yaml |  4 ++--
 .../devicetree/bindings/serial/serial.yaml       | 16 ++++++++--------
 9 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
index 04d55fecf47c..a5d67563cd53 100644
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
@@ -91,11 +91,6 @@ properties:
         - description: range upper bound
         - description: adjustment (in permyriad, i.e. 0.01%)
 
-allOf:
-  - $ref: serial.yaml
-
-unevaluatedProperties: false
-
 required:
   - compatible
   - reg
@@ -106,6 +101,11 @@ required:
   - dmas
   - dma-names
 
+allOf:
+  - $ref: serial.yaml
+
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/clock/tegra30-car.h>
diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml b/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
index a052aaef21f4..ea6abfe2d95e 100644
--- a/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
@@ -40,11 +40,11 @@ required:
   - interrupts
   - reg
 
-unevaluatedProperties: false
-
 allOf:
   - $ref: /schemas/serial/serial.yaml#
 
+unevaluatedProperties: false
+
 examples:
   - |
     serial@a9c00000 {
diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
index 484b9a51f6a9..ee52bf8e8917 100644
--- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
@@ -78,8 +78,6 @@ required:
   - interrupts
   - reg
 
-unevaluatedProperties: false
-
 allOf:
   - $ref: /schemas/serial/serial.yaml#
 
@@ -97,6 +95,8 @@ allOf:
         reg:
           maxItems: 1
 
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
index 3fc2601f1338..89f1eb0f2c5a 100644
--- a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
@@ -38,6 +38,13 @@ properties:
       - const: sclk
       - const: pclk
 
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
 allOf:
   - $ref: serial.yaml#
 
@@ -53,13 +60,6 @@ allOf:
         clock-names:
           minItems: 2
 
-required:
-  - compatible
-  - reg
-  - interrupts
-  - clocks
-  - clock-names
-
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
index 1c7f1276aed6..2046e2dc0a3d 100644
--- a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
@@ -111,8 +111,6 @@ required:
   - clock-names
   - power-domains
 
-unevaluatedProperties: false
-
 if:
   properties:
     compatible:
@@ -125,6 +123,8 @@ then:
   required:
     - resets
 
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
diff --git a/Documentation/devicetree/bindings/serial/renesas,scifa.yaml b/Documentation/devicetree/bindings/serial/renesas,scifa.yaml
index 499507678cdf..c98657cf4666 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scifa.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scifa.yaml
@@ -77,8 +77,6 @@ required:
   - clock-names
   - power-domains
 
-unevaluatedProperties: false
-
 if:
   properties:
     compatible:
@@ -89,6 +87,8 @@ then:
   required:
     - resets
 
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
diff --git a/Documentation/devicetree/bindings/serial/renesas,scifb.yaml b/Documentation/devicetree/bindings/serial/renesas,scifb.yaml
index 810d8a991fdd..fb695b3111ac 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scifb.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scifb.yaml
@@ -77,8 +77,6 @@ required:
   - clock-names
   - power-domains
 
-unevaluatedProperties: false
-
 if:
   properties:
     compatible:
@@ -89,6 +87,8 @@ then:
   required:
     - resets
 
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/clock/r8a7740-clock.h>
diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 8bd88d5cbb11..aecb6761b49c 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -86,8 +86,6 @@ required:
   - interrupts
   - reg
 
-unevaluatedProperties: false
-
 allOf:
   - $ref: serial.yaml#
 
@@ -128,6 +126,8 @@ allOf:
             - const: uart
             - const: clk_uart_baud0
 
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/clock/samsung,s3c64xx-clock.h>
diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 468af429c3e6..65804ca274ae 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -87,14 +87,6 @@ properties:
     description:
       TX FIFO threshold configuration (in bytes).
 
-if:
-  required:
-    - uart-has-rtscts
-then:
-  properties:
-    cts-gpios: false
-    rts-gpios: false
-
 patternProperties:
   "^(bluetooth|bluetooth-gnss|gnss|gps|mcu)$":
     if:
@@ -136,6 +128,14 @@ patternProperties:
       required:
         - compatible
 
+if:
+  required:
+    - uart-has-rtscts
+then:
+  properties:
+    cts-gpios: false
+    rts-gpios: false
+
 additionalProperties: true
 
 examples:
-- 
2.34.1

