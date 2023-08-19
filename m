Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4D781651
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 03:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbjHSBJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 21:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243275AbjHSBJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0310F1;
        Fri, 18 Aug 2023 18:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6D696142D;
        Sat, 19 Aug 2023 01:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46580C433C7;
        Sat, 19 Aug 2023 01:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692407374;
        bh=GgoHcra9ObNeUpMqTTIFhI0O8hWFNszRalZ/9DjEEpY=;
        h=From:To:Cc:Subject:Date:From;
        b=YtHu/QrehUfHn+7eu9li7sSBi3C8cH3oLD+Pk8q+XvFEA0BH4SwjDKr8RQqvLtrpW
         uUhQVPidC1TU7kKHnczgnvIpEjZT5Kx5oa1GksQp3UNauNQkfrc3FZiTk+6p8znoO3
         K6Rmg+vCpQDbmWDQWzjAsEHm2fbVAxQ+69n4YaxDPiMW3gbG7IUgAuHbsdR9PIQHUf
         eFLJqB8iycd0tM7sE8IyUslw8aeARXq1L1pNURJ2dRcLu+malGOYae7OOpoFJBFEls
         Kg2JnQh0dv3F/Y05JOoQZzclAfroRc+trbw2jnlwuC92csX1eKcVL+GSyEmc3UEyTk
         gZaySZXpFUYXA==
Received: (nullmailer pid 916541 invoked by uid 1000);
        Sat, 19 Aug 2023 01:09:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chris Brandt <chris.brandt@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: renesas,rza2: Use 'additionalProperties' for child nodes
Date:   Fri, 18 Aug 2023 20:09:27 -0500
Message-Id: <20230819010928.916438-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A schema under 'additionalProperties' works better for matching any
property/node other than the ones explicitly listed. Convert the schema
to use that rather than the wildcard and if/then schema.

Drop 'phandle' properties which never need to be explicitly listed while
we're here.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/renesas,rza2-pinctrl.yaml         | 61 +++++++++----------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
index 37173a64fed2..8271e7b2c162 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
@@ -37,40 +37,37 @@ properties:
   gpio-ranges:
     maxItems: 1
 
-patternProperties:
-  "^.*$":
-    if:
-      type: object
-    then:
-      allOf:
-        - $ref: pincfg-node.yaml#
-        - $ref: pinmux-node.yaml#
+additionalProperties:
+  type: object
+
+  allOf:
+    - $ref: pincfg-node.yaml#
+    - $ref: pinmux-node.yaml#
+
+  description:
+    The child nodes of the pin controller designate pins to be used for
+    specific peripheral functions or as GPIO.
+
+    A pin multiplexing sub-node describes how to configure a set of
+    (or a single) pin in some desired alternate function mode.
+    The values for the pinmux properties are a combination of port name,
+    pin number and the desired function index. Use the RZA2_PINMUX macro
+    located in include/dt-bindings/pinctrl/r7s9210-pinctrl.h to easily
+    define these.
+    For assigning GPIO pins, use the macro RZA2_PIN also in
+    to express the desired port pin.
+
+  properties:
+    pinmux:
       description:
-        The child nodes of the pin controller designate pins to be used for
-        specific peripheral functions or as GPIO.
+        Values are constructed from GPIO port number, pin number, and
+        alternate function configuration number using the RZA2_PINMUX()
+        helper macro in r7s9210-pinctrl.h.
 
-        A pin multiplexing sub-node describes how to configure a set of
-        (or a single) pin in some desired alternate function mode.
-        The values for the pinmux properties are a combination of port name,
-        pin number and the desired function index. Use the RZA2_PINMUX macro
-        located in include/dt-bindings/pinctrl/r7s9210-pinctrl.h to easily
-        define these.
-        For assigning GPIO pins, use the macro RZA2_PIN also in
-        to express the desired port pin.
+  required:
+    - pinmux
 
-      properties:
-        phandle: true
-
-        pinmux:
-          description:
-            Values are constructed from GPIO port number, pin number, and
-            alternate function configuration number using the RZA2_PINMUX()
-            helper macro in r7s9210-pinctrl.h.
-
-      required:
-        - pinmux
-
-      additionalProperties: false
+  additionalProperties: false
 
 allOf:
   - $ref: pinctrl.yaml#
@@ -82,8 +79,6 @@ required:
   - '#gpio-cells'
   - gpio-ranges
 
-additionalProperties: false
-
 examples:
   - |
     #include <dt-bindings/pinctrl/r7s9210-pinctrl.h>
-- 
2.40.1

