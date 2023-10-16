Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21FE7CB231
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjJPSTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjJPSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:19:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B2ED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:19:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so8643312a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697480354; x=1698085154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHxnwMIuOK6pun4FBy6K8m98uQdlQ5j3Zr63BQJ4VwE=;
        b=ryfDFKBR//BHm5yLeVLYxiDiksAsxv2jQLH4sey9IbaTwN+sVWh3aJOD9gcojk3Dks
         4GYIBP+pj8hTuCfJ8JgMZ6weUiYmTTvQRVSrrLU9/WSGaG9hB4gbbF/NMVsb5fZ8Mz5+
         /PjOizwC7whJXwJ8RumtRzt0g/+Qnu7q/og1dCWllOyGb+szbdY9SaYOAaU+r/eXCVcw
         p51cnTiYTlFt9jasyQXUt7T64FQH6gSo/uAbCIXx269bs4d0Qmj6gVnC2/bhoFWfwQVK
         0N1nWDTqN0xEt5ROx+ZXjXyVPJiGwk7EXxTuSq6nHv+bH2rRO5gvsinMO2IwTlnsDNGS
         s7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480354; x=1698085154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHxnwMIuOK6pun4FBy6K8m98uQdlQ5j3Zr63BQJ4VwE=;
        b=vNqnADFBK2na6U6HqpyI76vgTYJHRL6pJ+GK6Q3RRTmzErgVO27cbZvN67tJG6v5mP
         89bMVUbeflRSwASeE9/e77QWePmSP8kZtySvwuGVyznkriA7uJ+W5+DMURUX9FRdknwB
         bXo1Xe2WyK1/vjD2OrkGFC/4QUAbwv9Ojws7Jn4OVYFrwZY9q67BeBvfWF43Id1zn5i3
         r8Bw9y5ZyYs0tdWZMeTA1BYv+6aUZMlJGfFvol9TKNz3ewyxN/3OCVPa4ultWAESs3Sp
         SasY+ZRFkNPTAwJBg2ju4wGzVX+uq44uMWOlcTD/YIvaR25kBD2EZrD4eOK3U8df6n07
         ZJwQ==
X-Gm-Message-State: AOJu0YyWsTtq5eRzLrYsIYdacOikH2JIXCsWrnJLgozJvgZtudO75bOU
        7I38TRw87XWThw1i/HvBu9LtsQ==
X-Google-Smtp-Source: AGHT+IHaIMFNUycBgL3Pnr/xgETpMNd73VZDZCmkin8neQ/N99qgETS78YHHg5F5PDrGT6N3LQzRHg==
X-Received: by 2002:a05:6402:4405:b0:53e:343a:76c4 with SMTP id y5-20020a056402440500b0053e343a76c4mr7073eda.30.1697480354326;
        Mon, 16 Oct 2023 11:19:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id cw3-20020a056402228300b005333922efb0sm237483edb.78.2023.10.16.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:19:13 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: serial: re-order entries to match coding convention
Date:   Mon, 16 Oct 2023 20:19:09 +0200
Message-Id: <20231016181909.368429-1-krzysztof.kozlowski@linaro.org>
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

The DT schema coding convention expressed in
Documentation/devicetree/bindings/example-schema.yaml expects entries in
following order:
 - properties, patternProperties
 - required
 - if blocks, allOf with if-blocks
 - additionalProperties/unevaluatedProperties

Re-order few schemas to match the convention to avoid repeating review
comments for new patches using existing code as template.  No functional
changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Changes in v2:
1. Fix typos in commit msg.
2. Add Geert's review tag.
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

