Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A37FB1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbjK1GL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjK1GL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:11:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3B5C4;
        Mon, 27 Nov 2023 22:11:31 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfd04a6e49so13865965ad.0;
        Mon, 27 Nov 2023 22:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701151891; x=1701756691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWEx14nSnyx/YDeqC2ntKmMHgViFP0zdeOQ1ewPeigA=;
        b=CywTtCxWmHXmTcXJjQb7qpIVaGvx5N15PJezt7gl9NYKzsWMeNMZUfYUOMV1d2KFiV
         5pZJrNM2yExxVwyqXPxW+DMpdF9ftavUf2B61waNTuY8UPi6kAwjJnsxqJ1roxc6cRjL
         VorgVi9hLxonDfmYvliOb0wrkQVsZag7beKNeSjnXsIrKhzdgZgN91ocX7oIW2SIuzUc
         +clBQcBTd9HUw0wMElDrG2n/dwm47VYGt7P2d23oETs8irVq2WIQpH70PNYWgwXg08ay
         6dtVGc7zDFX7Uj64oG5BAFHIxtA4Il1JPjDyjoHVLOwYcM2VGY6GM3w4uwNA9FA1N0Ip
         wSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701151891; x=1701756691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWEx14nSnyx/YDeqC2ntKmMHgViFP0zdeOQ1ewPeigA=;
        b=NKrLcVI5oclMPUXaQ7wCsay5jtGsKHl4uRJu9Y6nNivkVLEOimFh9hqPFmXvEyXGRa
         8ARfFUyZeo4Nc9bV4nT7ay1Ojze3s2eqe6jKGd+M2zsVYN7AlBHgTz/ChgEKIov7+u2X
         jrW+W7QmBrr0gmqFNCOhr+NGCEgf5p1XxXrthZu5yHMp8Jy5YlbKZ4cUeHuTI2Aevd1H
         S4h99viDH82onUdE8ZjFH/nHNjDH4s4EEJ7w0n5Ye7MI+dAM9bELS35Y0fnZ0k9n2KV5
         gKcYVyW6EwOI3kkntFMfyDaJLpnOPSy0Yf68F9gDA344pwF9/+Cy2BQ3wxDt6cJSnV+U
         jVqw==
X-Gm-Message-State: AOJu0Yxewpii0DZHlxOWVbOl8jQSoh5nu7iwlH2n7KdkiQ42DbGULMRz
        eEgQJJ0Ph1YZ9KF4xOjs/Ew=
X-Google-Smtp-Source: AGHT+IH7ag2S2wngHFv7/AJe6FNw+rLlusmt8OHOQUw0XND4pJaHj8gdgD0y+78p3rQ7LUFQcpcTIA==
X-Received: by 2002:a17:902:da92:b0:1c5:cf7c:4d50 with SMTP id j18-20020a170902da9200b001c5cf7c4d50mr17775153plx.18.1701151891222;
        Mon, 27 Nov 2023 22:11:31 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001c73f3a9b7fsm9402694plb.185.2023.11.27.22.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:11:30 -0800 (PST)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
Subject: [PATCH v2 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
Date:   Tue, 28 Nov 2023 06:11:16 +0000
Message-Id: <20231128061118.575847-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128061118.575847-1-ychuang570808@gmail.com>
References: <20231128061118.575847-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation to describe nuvoton ma35d1 pin control and GPIO.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 189 ++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
new file mode 100644
index 000000000000..84287293a726
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
@@ -0,0 +1,189 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nuvoton,ma35d1-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 pin control and GPIO
+
+maintainers:
+  - Shan-Chun Hung <schung@nuvoton.com>
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-pinctrl
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle of the system-management node.
+
+  ranges: true
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+  - nuvoton,sys
+
+patternProperties:
+  "^gpio@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    properties:
+      gpio-controller: true
+
+      '#gpio-cells':
+        const: 2
+
+      reg:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 2
+
+      interrupts:
+        description:
+          The interrupt outputs to sysirq.
+        maxItems: 1
+
+    required:
+      - gpio-controller
+      - '#gpio-cells'
+      - reg
+      - clocks
+      - interrupt-controller
+      - '#interrupt-cells'
+      - interrupts
+
+  "^pin-[a-z0-9]+$":
+    type: object
+    description:
+      A pinctrl node should contain at least one subnodes representing the
+      pinctrl groups available on the machine. Each subnode will list the
+      pins it needs, and how they should be configured, with regard to muxer
+      configuration, pullups, drive strength, input enable/disable and input
+      schmitt.
+
+    allOf:
+      - $ref: pincfg-node.yaml#
+
+    properties:
+      bias-disable: true
+
+      bias-pull-down: true
+
+      bias-pull-up: true
+
+      power-source:
+        description: |
+          Valid arguments are described as below:
+          0: power supply of 1.8V
+          1: power supply of 3.3V
+        enum: [0, 1]
+
+      drive-strength-microamp:
+        oneOf:
+          - enum: [ 2900, 4400, 5800, 7300, 8600, 10100, 11500, 13000 ]
+            description: 1.8V I/O driving strength
+          - enum: [ 17100, 25600, 34100, 42800, 48000, 56000, 77000, 82000 ]
+            description: 3.3V I/O driving strength
+
+      input-enable: true
+
+      input-schmitt-enable: true
+
+    unevaluatedProperties: false
+
+  "-grp$":
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    properties:
+      nuvoton,pins:
+        description:
+          Each entry consists of 4 parameters and represents the mux and config
+          setting for one pin.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        minItems: 1
+        items:
+          items:
+            - minimum: 0
+              maximum: 13
+              description:
+                Pin bank.
+            - minimum: 0
+              maximum: 15
+              description:
+                Pin bank index.
+            - minimum: 0
+              maximum: 15
+              description:
+                Mux 0 means GPIO and mux 1 to 15 means the specific device function.
+            - description:
+                The phandle of a node contains the generic pinconfig options
+                to use as described in pinctrl-bindings.txt.
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
+
+    pinctrl@40040000 {
+        compatible = "nuvoton,ma35d1-pinctrl";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        nuvoton,sys = <&sys>;
+        ranges = <0 0x40040000 0xc00>;
+
+        gpio@40040000 {
+            reg = <0x0 0x40>;
+            interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk GPA_GATE>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+
+        pcfg_default: pin-default {
+            slew-rate = <0>;
+            input-schmitt-disable;
+            bias-disable;
+            power-source = <1>;
+            drive-strength-microamp = <17100>;
+        };
+
+        uart-grp {
+            uart11-pins {
+                nuvoton,pins = <11 0 2 &pcfg_default>,
+                               <11 1 2 &pcfg_default>,
+                               <11 2 2 &pcfg_default>,
+                               <11 3 2 &pcfg_default>;
+            };
+
+            uart12-pins {
+                nuvoton,pins = <8 1 2 &pcfg_default>,
+                               <8 2 2 &pcfg_default>,
+                               <8 3 2 &pcfg_default>;
+            };
+        };
+    };
-- 
2.34.1

