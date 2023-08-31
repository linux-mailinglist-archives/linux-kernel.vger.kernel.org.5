Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3E78F30D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347118AbjHaTHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjHaTHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:07:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E8E65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:07:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fee5ddc23eso11459965e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693508854; x=1694113654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYcBf9zwOXM34XkHVSj+a44vhkm5AHZw6edl4HRxYQk=;
        b=LpMrgSec2TLxuFrlheY4P9u/7Tf7/MbQ7EaqIxQZvy+e1oW9x+9NYBI6fr8rW6Uccn
         YTub1ldB1rXKuNQRf0C25UDQdSXgP7xypZYPZ8hT7RzJuBsh/IXHQ2+Kco5O/9SmFEFK
         BMzKP5LdQGavGmGDnTPsvUgf2CTS+by2Y1X4JEnKBPJHGY5lX28cf546+5zD89QiWV+v
         lQ3YIY3z3U0JbwJOthowLeSCBraqmAMZWl6zjHUI0im4BevPkez5o6bdv8LH0cbiyFSB
         3ZJqJ9B2iH1UyiZs0FeTzO5yKCQ8Wyse1laC3pTRQ1FpYyvkSdLRk8iw3B1C+CbsbIRh
         l9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693508854; x=1694113654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYcBf9zwOXM34XkHVSj+a44vhkm5AHZw6edl4HRxYQk=;
        b=QFqB9jrrdsIAFzfwxmW4DEug25mf2vg5sU9uFsdlep6+j90RV6LYZf8dY3mZSwANUS
         f09RWwngf99k6N4WdaFTs5EIYDX0qMXLEZxl7/v/6Iv1SbiVpoxf+96Vw4NQpDo5xsyW
         xLR196zuzUbLKwP4HxUO/AC7uE4Prgjnw3SMKxifZn4gfMRr5W1UqeqSLL5d3CsJ++V8
         Fv70NdbKguk2EGishZ9/QMZtPIEKPmKqZaOBKqa7HBrPA9jWVc/R0L2zl1//nPqQcwLp
         cDyvovFd8FIRGfG/X6uh5deRQsR1y5SPPA6rGWS1k4wTN7TsF4AaSmx/XdkXItRFXZlv
         Nrsw==
X-Gm-Message-State: AOJu0YycFGSBfqgPRv/NGhqhpDM6rL+HNUVbym7exr38JHS9rUSs1W1+
        GXn5tAbmFEyehUrWBCc9WAdzHgAq3rp2mkxrqjEeU/Am
X-Google-Smtp-Source: AGHT+IFUuWSxKgFiBa3LWAugIwI6zKreITHvXpuh2+aVPok62U+1tFXhBO7QKPQ6CuKZBnglh+uI2w==
X-Received: by 2002:a5d:550b:0:b0:317:51ff:c249 with SMTP id b11-20020a5d550b000000b0031751ffc249mr342579wrv.13.1693508854433;
        Thu, 31 Aug 2023 12:07:34 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id x9-20020adfdd89000000b003196b1bb528sm3058627wrl.64.2023.08.31.12.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:07:34 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Date:   Thu, 31 Aug 2023 21:07:27 +0200
Message-ID: <20230831190731.265099-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add the DT property 'infineon,en-pin-fixed-level' to
indicated that the chip EN pin is at fixed level
or left unconnected(has internal pull-down).

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
----
Changes in V5:
- Update pin name to align with datasheet
Changes in V4:
- Update property name & description.
- Update commit message.
---
 .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
new file mode 100644
index 000000000000..9eecfae5dfcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,tda38640.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon TDA38640 Synchronous Buck Regulator with SVID and I2C
+
+maintainers:
+  - Naresh Solanki <naresh.solanki@9elements.com>
+
+description: |
+  The Infineon TDA38640 is a 40A Single-voltage Synchronous Buck
+  Regulator with SVID and I2C designed for Industrial use.
+
+  Datasheet: https://www.infineon.com/dgdl/Infineon-TDA38640-0000-DataSheet-v02_04-EN.pdf?fileId=8ac78c8c80027ecd018042f2337f00c9
+
+properties:
+  compatible:
+    enum:
+      - infineon,tda38640
+
+  reg:
+    maxItems: 1
+
+  infineon,en-pin-fixed-level:
+    description:
+      Indicates that the chip EN pin is at fixed level or left
+      unconnected(has internal pull-down).
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tda38640@40 {
+            compatible = "infineon,tda38640";
+            reg = <0x40>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 40bc475ee7e1..86c7d34f63bf 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -151,8 +151,6 @@ properties:
           - infineon,slb9645tt
             # Infineon SLB9673 I2C TPM 2.0
           - infineon,slb9673
-            # Infineon TDA38640 Voltage Regulator
-          - infineon,tda38640
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
             # Infineon Multi-phase Digital VR Controller xdpe11280

base-commit: 919a83d020a8dfa1411c1dc1cff23a833f0f5268
-- 
2.41.0

