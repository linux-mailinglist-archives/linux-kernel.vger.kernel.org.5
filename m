Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F37EAB94
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKNI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNI1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:27:34 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D5BB1A8;
        Tue, 14 Nov 2023 00:27:29 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CDC2180CE;
        Tue, 14 Nov 2023 08:27:26 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pwm@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] dt-bindings: pwm: ti,pwm-omap-dmtimer: Update binding for yaml
Date:   Tue, 14 Nov 2023 10:27:06 +0200
Message-ID: <20231114082709.54138-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update for yaml and remove the old txt binding.

As we can replace most of the custom timer API with standard Linux
frameworks such as clock framework, let's tag the properties for
ti,prescaler and ti,clock-source as deprecated.

Cc: linux-pwm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v3:

- No changes, reposted without patch 1/2. The pwm.yaml related issues got
  fixed by commit 05b743db9d8c ("dt-bindings: pwm: restrict node name
  suffixes")

Changes since v2:

- Reviewed-by collected from Krzysztof, no changes

Changes since v1:

- Fix issues noticed by Krzysztof

---
 .../bindings/pwm/pwm-omap-dmtimer.txt         | 22 -------
 .../bindings/pwm/ti,omap-dmtimer-pwm.yaml     | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,omap-dmtimer-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
deleted file mode 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* OMAP PWM for dual-mode timers
-
-Required properties:
-- compatible: Shall contain "ti,omap-dmtimer-pwm".
-- ti,timers: phandle to PWM capable OMAP timer. See timer/ti,timer-dm.yaml for info
-  about these timers.
-- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Optional properties:
-- ti,prescaler: Should be a value between 0 and 7, see the timers datasheet
-- ti,clock-source: Set dmtimer parent clock, values between 0 and 2:
-  - 0x00 - high-frequency system clock (timer_sys_ck)
-  - 0x01 - 32-kHz always-on clock (timer_32k_ck)
-  - 0x02 - external clock (timer_ext_ck, OMAP2 only)
-
-Example:
-	pwm9: dmtimer-pwm@9 {
-		compatible = "ti,omap-dmtimer-pwm";
-		ti,timers = <&timer9>;
-		#pwm-cells = <3>;
-	};
diff --git a/Documentation/devicetree/bindings/pwm/ti,omap-dmtimer-pwm.yaml b/Documentation/devicetree/bindings/pwm/ti,omap-dmtimer-pwm.yaml
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ti,omap-dmtimer-pwm.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/ti,omap-dmtimer-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI dual mode timer PWM controller
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+description:
+  TI dual mode timer instances have an IO pin for PWM capability
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: ti,omap-dmtimer-pwm
+
+  "#pwm-cells":
+    const: 3
+
+  ti,timers:
+    description: Timer instance phandle for the PWM
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,prescaler:
+    description: |
+      Legacy clock prescaler for timer. The timer counter is prescaled
+      with 2^n where n is the prescaler.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+    deprecated: true
+
+  ti,clock-source:
+    description: |
+      Legacy clock for timer, please use assigned-clocks instead.
+      0x00 - high-frequency system clock (timer_sys_ck)
+      0x01 - 32-kHz always-on clock (timer_32k_ck)
+      0x02 - external clock (timer_ext_ck, OMAP2 only)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2 ]
+    deprecated: true
+
+required:
+  - compatible
+  - ti,timers
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm9: pwm {
+      compatible = "ti,omap-dmtimer-pwm";
+      ti,timers = <&timer9>;
+      #pwm-cells = <3>;
+    };
-- 
2.42.1
