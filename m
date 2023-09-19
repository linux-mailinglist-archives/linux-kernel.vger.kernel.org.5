Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78367A5781
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjISCuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjISCuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:50:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E44010E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:49:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fac16ee5fso4427541b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=himax-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1695091795; x=1695696595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1ioMTNlxJ7TgNaZZMXl7GHG0oUez87wcYueKGu9onI=;
        b=hsPhgfS9I/FA36TbjFJNG/j3YDdIh3riO/sFSdjWM5suFU0PZ3zpYTZ5k0f5ejW0ZX
         2M+i4QgnMpmPR1ZbArXZcB4B54KQyONtbK5VzVGscZdyuGOs+80rP1PojINwSeVMd1/j
         LK3rI8zCMB+YSAZQo78aKZ1brxml8JdpQZePds+kc/+UvyOMnQ4h31DzQTn30dWGyET2
         35VrKEG8TWmmmV0d8YwVs1GtgtzU/dz1W1Qba4bZIO8yzxraAST8ExtEelcv/GFts0Go
         JLQpWo9xS0vFtIs8G3ysQXIkFQLFN6Iu6RtawIinCgSAiY0wXpinX/xvUlmNJdh5M/pC
         9H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695091795; x=1695696595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1ioMTNlxJ7TgNaZZMXl7GHG0oUez87wcYueKGu9onI=;
        b=CA49WP3Fqd8nQ/txEcQt5lK2pjbuM8lMDLzFLrpCP9Ek44NCw6kypWAT5RrFcSq+BU
         kPyfLzlsGM0NLcha+iTJGm7mRqnWKSglNHWe4bZ6XoPurWoUK3yzXuUL/6KlzdcF6hqI
         ruCrlZ20nKrHPu0NQPX93uefgBpwjzCMFFDliDgFDVfV0ydYD5j4Nny+umn2sFWfnnXO
         yRp3VKRZOdVfI4cQmaEvgSuHwuENf6dpbewfr370hs3Plm14usKMVuBEpNB2yHgSoaNR
         TxmwnIKPKeYbkIu/W62TMFeA+Jjzh2VuvahO8fhh+4Hxfn5EXOEQlehypiJ8t0jzCuG0
         UZIw==
X-Gm-Message-State: AOJu0YwomzpLSLVVJusjLseXP9TeDueGctP6nQCC2l7N3Ni8rU29Z6Ss
        fildDC5kOD0Ao8G47kF7MArFOw==
X-Google-Smtp-Source: AGHT+IFBOLFTnjR8cqf6m2DCRVqKzMcPwTrzEcFQphR6isI2+5compA+Fk/S+B2dlCn72AXDfZ1Yjg==
X-Received: by 2002:a05:6a00:2484:b0:68c:70f:ee3f with SMTP id c4-20020a056a00248400b0068c070fee3fmr11886688pfv.13.1695091795083;
        Mon, 18 Sep 2023 19:49:55 -0700 (PDT)
Received: from tylor-mini-server.net ([101.8.12.165])
        by smtp.gmail.com with ESMTPSA id i21-20020aa79095000000b0068fb8e18971sm7613042pfa.130.2023.09.18.19.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 19:49:54 -0700 (PDT)
From:   Tylor Yang <tylor_yang@himax.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     poyuan_chang@himax.corp-partner.google.com, jingliang@chromium.org,
        hbarnor@chromium.org,
        Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Subject: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI device
Date:   Tue, 19 Sep 2023 10:49:42 +0800
Message-Id: <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Himax HID-over-SPI framework support for Himax touchscreen ICs
that report HID packet through SPI bus. The driver core need reset
 pin to meet reset timing spec. of IC. An interrupt pin to disable
and enable interrupt when suspend/resume. An optional power control
pin if target board needed. Panel id pins for identify panel is also
an option.

Additional optional arguments:
ic-det-delay-ms and ic-resume-delay-ms are using to solve runtime
conditions.

This patch also add maintainer of this driver.

Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
---
 .../bindings/input/himax,hid-over-spi.yaml    | 109 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml

diff --git a/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml b/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
new file mode 100644
index 000000000000..3ee3a89842ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/himax,hid-over-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax TDDI devices using SPI to send HID packets
+
+maintainers:
+  - Tylor Yang <tylor_yang@himax.corp-partner.google.com>
+
+description: |
+  Support the Himax TDDI devices which using SPI interface to acquire
+  HID packets from the device. The device needs to be initialized using
+  Himax protocol before it start sending HID packets.
+
+properties:
+  compatible:
+    const: himax,hid-over-spi
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  himax,rst-gpio:
+    maxItems: 1
+    description: Reset device, active low signal.
+
+  himax,irq-gpio:
+    maxItems: 1
+    description: Interrupt request, active low signal.
+
+  himax,3v3-gpio:
+    maxItems: 1
+    description: GPIO to control 3.3V power supply.
+
+  himax,id-gpios:
+    maxItems: 8
+    description: GPIOs to read physical Panel ID. Optional.
+
+  spi-cpha: true
+  spi-cpol: true
+
+  himax,ic-det-delay-ms:
+    description:
+      Due to TDDI properties, the TPIC detection timing must after the
+      display panel initialized. This property is used to specify the
+      delay time when TPIC detection and display panel initialization
+      timing are overlapped. How much milliseconds to delay before TPIC
+      detection start.
+
+  himax,ic-resume-delay-ms:
+    description:
+      Due to TDDI properties, the TPIC resume timing must after the
+      display panel resumed. This property is used to specify the
+      delay time when TPIC resume and display panel resume
+      timing are overlapped. How much milliseconds to delay before TPIC
+      resume start.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - himax,rst-gpio
+  - himax,irq-gpio
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@0 {
+            compatible = "himax,hid-over-spi";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0x0>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            pinctrl-0 = <&touch_pins>;
+            pinctrl-names = "default";
+
+            spi-max-frequency = <12500000>;
+            spi-cpha;
+            spi-cpol;
+
+            himax,rst-gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
+            himax,irq-gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
+            himax,3v3-gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+            himax,ic-det-delay-ms = <500>;
+            himax,ic-resume-delay-ms = <100>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..452701261bec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9323,6 +9323,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
 
+HIMAX HID OVER SPI TOUCHSCREEN SUPPORT
+M:	Tylor Yang <tylor_yang@himax.corp-partner.google.com>
+L:	linux-input@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
+
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
 L:	linux-input@vger.kernel.org
-- 
2.25.1

