Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C127C4E22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjJKJFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345794AbjJKJFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:05:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5495B7;
        Wed, 11 Oct 2023 02:05:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c5ff5f858dso46057405ad.2;
        Wed, 11 Oct 2023 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697015120; x=1697619920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP+cC4Mbb/gp/3RvoRNIIeydGHiY8BBAyci0bzJmdbw=;
        b=iwxwZK/V/r1KUW2ZAO04Czvue263rZdIqJqdwd4i69xUvUvsdZialtkXDi3rkbRrPA
         i/2VOATiOMaM5Zpw4In+sliZIzg9cMAao+7YHNV/yJJHE415aMr64LCCdHW0f2vXF8jz
         bzfPpUXW1o0WYIr3uJhLYmYvhxoaJovaAgHISK8HJThg2de2R5ipeQ+VhTCS8O/KeWna
         RdFh6HNIEsDx48GTZaPPWxPp2jdQmkDB0khIH0JUeSJt3Rm5rd22USiSp6NIdODhCZtg
         BK6XU1kWFhnGIa96L/tjXoNfSuNJRKPYhL1C9a1wW5qdLGpKAwnv/wz05dgVpV4EsWFv
         PiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697015120; x=1697619920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rP+cC4Mbb/gp/3RvoRNIIeydGHiY8BBAyci0bzJmdbw=;
        b=RxAk0E94p+wkFb0kY5Tk/+nRlv5agjk0J9Of+1Ua6+KcGGsXCVstBr4s2d1aBWu7Fq
         xrEra42KdGGnSyHewqlWIMO2Ci+Vva/IYel2o2iPRhEefVUOaovTkUlb8zlN2w/WZ5pR
         itajppYq9w4sJXqjupvrPwCWu34UIxT31sO642p7XO6P4nf9rCOo+XadgPzX54FsTRwH
         klkOPYkeHsOmmry6jR3nlrJpdwsIYOqJE1N0RhJLgBAdBCEyRk/h1PNosfXr+RZh3ge0
         YKpbmhynJhL4zUybRVgiswDVyIHeOnochvXHLC5uWAsz6gf1OGpUx2H24O9PLMVg+VeJ
         O8vA==
X-Gm-Message-State: AOJu0Yys9rOjWi3ymvNxrQuokid6tRoa5BsR4GzgVPoiI3PzwBsmFm5h
        TInXRj7tIaEp+4lvE2T8KyU=
X-Google-Smtp-Source: AGHT+IGigYw2NHuJ9S5jl5BvcSCG7n3LNDVxlzN8+5/GiR6eWwM5JH9JyIcjsOKBD9stYpzayTo+Bg==
X-Received: by 2002:a17:902:aa05:b0:1c5:8a0e:b01e with SMTP id be5-20020a170902aa0500b001c58a0eb01emr16204646plb.63.1697015120106;
        Wed, 11 Oct 2023 02:05:20 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001c61df93afdsm13346699plg.59.2023.10.11.02.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:05:19 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
Date:   Wed, 11 Oct 2023 09:05:08 +0000
Message-Id: <20231011090510.114476-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011090510.114476-1-ychuang570808@gmail.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add the dt-bindings header for nuvoton ma35d1 pinctrl, that gets shared
between the pin control driver and pin configuration in the dts.

Add documentation to describe nuvoton ma35d1 pin control and GPIO.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 180 ++++++++++++++++++
 include/dt-bindings/pinctrl/ma35d1-pinfunc.h  |  38 ++++
 2 files changed, 218 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
 create mode 100644 include/dt-bindings/pinctrl/ma35d1-pinfunc.h

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
new file mode 100644
index 000000000000..0ddedbad4b78
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
@@ -0,0 +1,180 @@
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
+    description:
+      phandle to the syscon node
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      maxItems: 1
+
+  ranges: true
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+patternProperties:
+  "gpio[a-n]@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    properties:
+
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
+      - reg
+      - interrupts
+      - interrupt-controller
+      - '#interrupt-cells'
+      - gpio-controller
+      - '#gpio-cells'
+
+  "pcfg-[a-z0-9-.]+$":
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
+      drive-strength:
+        minimum: 0
+        maximum: 7
+
+      input-enable: true
+
+      input-schmitt-enable: true
+
+      power-source:
+        description:
+          I/O voltage in millivolt.
+        enum: [ 1800, 3300 ]
+
+additionalProperties:
+  type: object
+  additionalProperties:
+    type: object
+    properties:
+      nuvoton,pin:
+        description:
+          Each entry consists of 4 parameters and represents the mux and config
+          setting for one pin.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        minItems: 1
+        items:
+          items:
+            - minimum: 0x80
+              maximum: 0xec
+              description:
+                The pinctrl register offset in syscon registers.
+            - minimum: 0
+              maximum: 30
+              description:
+                The bit offset in the pinctrl register.
+            - minimum: 0
+              maximum: 15
+              description:
+                The multi-function pin value.
+            - description:
+                The phandle of a node contains the generic pinconfig options
+                to use as described in pinctrl-bindings.txt.
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
+        gpioa@40040000 {
+                reg = <0x0 0x40>;
+                interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clk GPA_GATE>;
+                gpio-controller;
+                #gpio-cells = <2>;
+                interrupt-controller;
+                #interrupt-cells = <2>;
+        };
+
+        pcfg_default: pcfg-default {
+                slew-rate = <0>;
+                input-schmitt-disable;
+                bias-disable;
+                power-source = <3300>;
+                drive-strength = <0>;
+        };
+    };
+
+    pinctrl {
+        uart13 {
+                pinctrl_uart13: uart13grp {
+                        nuvoton,pins =
+                                <MA35_SYS_REG_GPH_H 24 2 &pcfg_default>,
+                                <MA35_SYS_REG_GPH_H 28 2 &pcfg_default>;
+                };
+        };
+    };
+
+    serial@407d0000 {
+        compatible = "nuvoton,ma35d1-uart";
+        reg = <0x407d0000 0x100>;
+        interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk UART13_GATE>;
+        pinctrl-0 = <&pinctrl_uart13>;
+    };
diff --git a/include/dt-bindings/pinctrl/ma35d1-pinfunc.h b/include/dt-bindings/pinctrl/ma35d1-pinfunc.h
new file mode 100644
index 000000000000..a2609d466dc9
--- /dev/null
+++ b/include/dt-bindings/pinctrl/ma35d1-pinfunc.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Nuvoton Technologies.
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_NUVOTON_MA35D1_H
+#define __DT_BINDINGS_PINCTRL_NUVOTON_MA35D1_H
+
+#define MA35_SYS_REG_GPA_L	0x80
+#define MA35_SYS_REG_GPA_H	0x84
+#define MA35_SYS_REG_GPB_L	0x88
+#define MA35_SYS_REG_GPB_H	0x8c
+#define MA35_SYS_REG_GPC_L	0x90
+#define MA35_SYS_REG_GPC_H	0x94
+#define MA35_SYS_REG_GPD_L	0x98
+#define MA35_SYS_REG_GPD_H	0x9c
+#define MA35_SYS_REG_GPE_L	0xa0
+#define MA35_SYS_REG_GPE_H	0xa4
+#define MA35_SYS_REG_GPF_L	0xa8
+#define MA35_SYS_REG_GPF_H	0xac
+#define MA35_SYS_REG_GPG_L	0xb0
+#define MA35_SYS_REG_GPG_H	0xb4
+#define MA35_SYS_REG_GPH_L	0xb8
+#define MA35_SYS_REG_GPH_H	0xbc
+#define MA35_SYS_REG_GPI_L	0xc0
+#define MA35_SYS_REG_GPI_H	0xc4
+#define MA35_SYS_REG_GPJ_L	0xc8
+#define MA35_SYS_REG_GPJ_H	0xcc
+#define MA35_SYS_REG_GPK_L	0xd0
+#define MA35_SYS_REG_GPK_H	0xd4
+#define MA35_SYS_REG_GPL_L	0xd8
+#define MA35_SYS_REG_GPL_H	0xdc
+#define MA35_SYS_REG_GPM_L	0xe0
+#define MA35_SYS_REG_GPM_H	0xe4
+#define MA35_SYS_REG_GPN_L	0xe8
+#define MA35_SYS_REG_GPN_H	0xec
+
+#endif /* __DT_BINDINGS_PINCTRL_NUVOTON_MA35D1_H */
-- 
2.34.1

