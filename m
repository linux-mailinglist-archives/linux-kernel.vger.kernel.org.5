Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249527AE617
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjIZGia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjIZGi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:38:26 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 818E511D;
        Mon, 25 Sep 2023 23:38:19 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id B53DC80A3;
        Tue, 26 Sep 2023 06:38:17 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: input: gpio-keys: Allow optional dedicated wakeirq
Date:   Tue, 26 Sep 2023 09:38:08 +0300
Message-ID: <20230926063809.25654-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow configuring an optional dedicated wakeirq for gpio-keys that
some SoCs have.

Let's use the common interrupt naming "irq" and "wakeup" that we already
have in use for some drivers and subsystems like i2c framework.

Note that the gpio-keys interrupt property is optional. If only a gpio
property is specified, the driver tries to translate the gpio into an
interrupt.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v2:
- Fix indentation as noted by Rob's bot

- Add Reviewed-by from Rob

Changes since v1:

- Run make dt_binding_check on the binding

- Add better checks for interrupt-names as suggested by Rob, it is
  now required if two interrupts are configured

- Add more decription entries

- Add a new example for key-wakeup

---
 .../devicetree/bindings/input/gpio-keys.yaml  | 41 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -31,7 +31,23 @@ patternProperties:
         maxItems: 1
 
       interrupts:
-        maxItems: 1
+        oneOf:
+          - items:
+              - description: Optional key interrupt or wakeup interrupt
+          - items:
+              - description: Key interrupt
+              - description: Wakeup interrupt
+
+      interrupt-names:
+        description:
+          Optional interrupt names, can be used to specify a separate dedicated
+          wake-up interrupt in addition to the gpio irq
+        oneOf:
+          - items:
+              - enum: [ irq, wakeup ]
+          - items:
+              - const: irq
+              - const: wakeup
 
       label:
         description: Descriptive name of the key.
@@ -97,6 +113,20 @@ patternProperties:
       - required:
           - gpios
 
+    allOf:
+      - if:
+          properties:
+            interrupts:
+              minItems: 2
+          required:
+            - interrupts
+        then:
+          properties:
+            interrupt-names:
+              minItems: 2
+          required:
+            - interrupt-names
+
     dependencies:
       wakeup-event-action: [ wakeup-source ]
       linux,input-value: [ gpios ]
@@ -137,6 +167,15 @@ examples:
             linux,code = <108>;
             interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
         };
+
+        key-wakeup {
+            label = "GPIO Key WAKEUP";
+            linux,code = <143>;
+            interrupts-extended = <&intc 2 IRQ_TYPE_EDGE_FALLING>,
+                                  <&intc_wakeup 0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "irq", "wakeup";
+            wakeup-source;
+        };
     };
 
 ...
-- 
2.42.0
