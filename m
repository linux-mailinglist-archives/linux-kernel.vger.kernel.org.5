Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99638757BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGRMce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGRMcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:32:31 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B971B10F3;
        Tue, 18 Jul 2023 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689683544;
  x=1721219544;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=sGKc3f9aEi49syc8A8ZbaYt31rq0mocNyOVaPh8IHJY=;
  b=cwf4DxQdq2tEpsJ60/15DkvmS+SI3nWfgt8efspret1Ry+/1CMjqY/Lq
   C29xXdJJweOA8IzGQa60ql0BvR/+ViXoTPp056irzehQRHlXZ8HowJcl2
   a3KmHBy00Bgy8Stf4sIV4KfsKLqYXOw6l0LtYA4a61vsuQps5I7rh6Xxz
   3nbPFDZthB7zctF7dOuBkJAUvfp+Vfp4yS2bpF9mwLqWTTXsJV8WHZ571
   muo+0ayx9Vvk3ew7Ex3cVZGzD2ZWjpEt6+zTwlYubba07Yk3Jl/6cqWxJ
   Okv6L97uvBaUUGSr8Dl5Lhuou/FHUlx7A6rXSIzmCs6o1HDL+gxL73s66
   A==;
References: <cover.1689683411.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: iio: proximity: Add Murata IRS-D200
In-Reply-To: <cover.1689683411.git.waqar.hameed@axis.com>
Date:   Tue, 18 Jul 2023 14:30:11 +0200
Message-ID: <09975910ea638a9aa893411124bbd2a5c98e45c3.1689683411.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murata IRS-D200 is a PIR sensor for human detection. It uses the I2C bus
for communication with interrupt support. Add devicetree bindings
requiring the compatible string, I2C slave address (reg), power supply
and interrupts.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../iio/proximity/murata,irsd200.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml b/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
new file mode 100644
index 000000000000..67f5389ece67
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/murata,irsd200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Murata IRS-D200 PIR sensor
+
+maintainers:
+  - Waqar Hameed <waqar.hameed@axis.com>
+
+description:
+  PIR sensor for human detection.
+
+properties:
+  compatible:
+    const: murata,irsd200
+
+  reg:
+    items:
+      - enum:
+          - 0x48
+          - 0x49
+        description: |
+          When the AD pin is connected to GND, the slave address is 0x48.
+          When the AD pin is connected to VDD, the slave address is 0x49.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Type should be IRQ_TYPE_EDGE_RISING.
+
+  vdd-supply:
+    description:
+      3.3 V supply voltage.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@48 {
+            compatible = "murata,irsd200";
+            reg = <0x48>;
+            interrupts = <24 IRQ_TYPE_EDGE_RISING>;
+            vdd-supply = <&regulator_3v3>;
+        };
+    };
+...
-- 
2.30.2

