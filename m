Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFCB7CBEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjJQJTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjJQJTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:19:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF681F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:19:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9b7c234a7so46544475ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=himax-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1697534353; x=1698139153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0cMOjV281zLFMAkufBNN9u6swFXVx3MkuM8sIVK0Lc=;
        b=fWvd7I7wUVVf6yhQlv31poYvQtbO6bdCOEZwcTIAEywdrpOukILwu700eF/jjl5vFm
         RVVyHi5KbI0phOcMAYgWYq2VjTVhO45BnntaX/A/K3F4t+CRnlIX5OZTpTK1xktwaf2c
         h0phcJACWoG4YItmvvh3X5T2KEypTZhc5qFG/3UEFmILz9daEtVt/bWuNrmnaVOODR5z
         aiHSo+57uPIsYJMzYL2EbLjYYG2RlTde/A4VMXqTHQBiXYNK16KGGdon3GUBdNh4r0no
         jAbYPNRWmFDT+H9aMiM+HsCSBWtnyUZlvFtKQLoTAGkPPxQpsi4xtXGcU0fau3loQYb9
         uOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534353; x=1698139153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0cMOjV281zLFMAkufBNN9u6swFXVx3MkuM8sIVK0Lc=;
        b=EDi0k4+6kqFmH9gI2B40e0t5VLwHSPDWdzRMP4Y0BnOxPTyzpYwkGLGAjGQKshP1rr
         UqPmf3uk5jlU46fvusA36lHF7TZepNMwT2POzcs58MT/YP1V7mZuBZiUH2sxU+OVJRBw
         YTuPCljKai0eGAwcg0ZqxQHMtFpwH22s+2fXBGP4GG1jeuIGm+ZEOkFm+jAyeGMYVMmk
         QuLjjYYhMg5wJV0plqSqylZndgI+gGeg6AqRI3i5WRPIuFoHT9akWzFl3/3M1gs/ChHH
         +J1t5QRYvyuzxxkO9agbzC6pzwQMxIY+ee/dkXQAFs8sOExo5vDoHrrTbXyZpUT3vsrq
         P4Xw==
X-Gm-Message-State: AOJu0YwN59h8e3cYAzVdvx+V9U9x5le1UCnd92lG5gmzBNVyfOFddUsg
        kmOCifkkAigAvq+ylDrPY7GgUw==
X-Google-Smtp-Source: AGHT+IEowEIcFxrnefSEAvSUCADc7cP3eANzhxL30NO0S0F9EwX+B9eZKBZhotvIqWACwobJlcMyYg==
X-Received: by 2002:a17:90b:3698:b0:27d:5d9:a887 with SMTP id mj24-20020a17090b369800b0027d05d9a887mr1486219pjb.44.1697534353366;
        Tue, 17 Oct 2023 02:19:13 -0700 (PDT)
Received: from tylor-mini-server.net ([101.9.190.154])
        by smtp.gmail.com with ESMTPSA id pl17-20020a17090b269100b00274de7c8aacsm6003963pjb.45.2023.10.17.02.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:19:13 -0700 (PDT)
From:   Tylor Yang <tylor_yang@himax.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     poyuan_chang@himax.corp-partner.google.com,
        jingyliang@chromium.org, hbarnor@chromium.org, wuxy23@lenovo.com,
        luolm1@lenovo.com, poyu_hung@himax.corp-partner.google.com,
        Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Subject: [PATCH v3 1/4] dt-bindings: input: Introduce Himax HID-over-SPI device
Date:   Tue, 17 Oct 2023 17:18:57 +0800
Message-Id: <20231017091900.801989-2-tylor_yang@himax.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
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
 pin to meet reset timing spec. of IC. An interrupt to disable
and enable interrupt when suspend/resume. Two optional power control
 if target board needed.

Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
---
 .../devicetree/bindings/input/himax,hid.yaml  | 123 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/himax,hid.yaml

diff --git a/Documentation/devicetree/bindings/input/himax,hid.yaml b/Documentation/devicetree/bindings/input/himax,hid.yaml
new file mode 100644
index 000000000000..9ba86fe1b7da
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/himax,hid.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/himax,hid.yaml#
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
+    const: himax,hid
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset:
+    maxItems: 1
+    description: Reset device, active low signal.
+
+  vccd-supply:
+    description:
+      Optional regulator for the 1.8V voltage.
+
+  vcca-supply:
+    description:
+      Optional regulator for the analog 3.3V voltage.
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
+  panel:
+    description:
+      The node of the display panel device. The driver will use this
+      node to get the project ID of the display panel. Optional.
+    type: object
+    additionalProperties: false
+
+    properties:
+      himax,pid:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 8
+        items:
+          minimum: 0
+          maximum: 65535
+        description:
+          When only one value exist, represent Project ID of the device.
+          When multiple values exist, order in event number value represnet
+          id value from id-gpios and odd number value represent Project ID
+          relatives to prior id value. This is used to specify the firmware
+          for the device.
+
+    required:
+      - himax,pid
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset
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
+            compatible = "himax,hid";
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
+            reset = <&gpio1 8 GPIO_ACTIVE_LOW>;
+            himax,ic-det-delay-ms = <500>;
+            himax,ic-resume-delay-ms = <100>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..883870ab316f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9340,6 +9340,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
 
+HIMAX HID OVER SPI TOUCHSCREEN SUPPORT
+M:	Tylor Yang <tylor_yang@himax.corp-partner.google.com>
+L:	linux-input@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/input/himax,hid.yaml
+
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
 L:	linux-input@vger.kernel.org
-- 
2.25.1

