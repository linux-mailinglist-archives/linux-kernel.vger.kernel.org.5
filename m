Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E6758FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGSHyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjGSHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:53:42 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552571FFA;
        Wed, 19 Jul 2023 00:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689753221;
  x=1721289221;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=sGKc3f9aEi49syc8A8ZbaYt31rq0mocNyOVaPh8IHJY=;
  b=VHECJyJ/Gh8dURIpkrhfmUCQTRcqFt9+K1B6AnicmwILSYr+S3o5EW41
   YM8GrikeQ12PhOhscsoNv3D+HCB4EWfbzrFOW7VG7/sdzGyRwugTXgS+Y
   OawqG+Nt88sYNUO8TyE1IYlMmoMhKIQ2/X6hv8kFw/xOyP1hAdFfv3KKV
   1O45DLyW0hIa2XajgSO4n58KvvvzBvZFoHUs+PDRfXm0FmHfaJBwTdRfG
   ZinfuBTVIon0O9L9OhEnBxaP/6TF2/8P9vREXxQyLYI7xrOq84q8QcnHN
   j2jvYIRm55n8mzIpoTIbAiCti4n5RlMT0b9V0VYxr2n09xeEhdg+S+Wts
   Q==;
References: <cover.1689753076.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Waqar Hameed <waqar.hameed@axis.com>
CC:     <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: iio: proximity: Add Murata IRS-D200
In-Reply-To: <cover.1689753076.git.waqar.hameed@axis.com>
Date:   Wed, 19 Jul 2023 09:51:16 +0200
Message-ID: <09975910ea638a9aa893411124bbd2a5c98e45c3.1689753076.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

