Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94C7FD4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjK2LGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjK2LGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:06:51 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DF11707;
        Wed, 29 Nov 2023 03:06:57 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 9F559603F4;
        Wed, 29 Nov 2023 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701256016;
        bh=NNHh2O5OrEdJoEBrrlI3WR9bFXRtApPJeE2ytpFLV9w=;
        h=From:To:Cc:Subject:Date:From;
        b=uP89EbkW275ztvlvlbHJF/Zw4iYhKc3OhWAg+t9RQxbOGa/OGj7uEujUi0HqiBSyH
         KH+3h/IhCI/tTDmBR+OXHHuUiN6Zy35cT8y5fPId5O/LY7nPfX6zN4kaq6bJgIKrF3
         PLAXkn8yLhh8eDuG3I6V55ZB6vo8BDa6dVVGEhQYVCRndNBZAQo4CY7teV2ePrS9E/
         CIgKhugRNe0XrzTaTLSUzpYdrgdKO893kXRz4Jp0rQFfnLBM/eEFHA7qGKa2vWt4S8
         d+t+8LfQkxSB+vjz1l1gzx9fpGd1UjDedas5MzpAzFVQIwSPAk5MM06FAcKvc91KBC
         /W88r/cgvOMWw==
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: input: gpio-keys: Allow optional dedicated wakeirq
Date:   Wed, 29 Nov 2023 13:06:14 +0200
Message-ID: <20231129110618.27551-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
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

No changes since v3

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
2.42.1
