Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C37A0DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbjINTCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbjINTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:01:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2F82112;
        Thu, 14 Sep 2023 12:00:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47243C433C9;
        Thu, 14 Sep 2023 19:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694718057;
        bh=qShUtFOUyzVf8/Vy8Ou2aMiD2+CkI0mrrVsJEqs5+Do=;
        h=From:To:Cc:Subject:Date:From;
        b=WD3EM3v+YCsBFw/HyGd5NpYli5TyFDn1qgSxdXNa5AQACYr3nq+s4WGnNeZcmLYZw
         LYMq6jvrnI2End4qZDjcMCF1z8XvldTNI/k8tOuxi/ugnRwcZPCQ0yKNLwaJInp47j
         IvasPjFi9rX51Y01FD0p2ScHUnJbNP9YkA4TElP2gve9YSNRTo1tWFhbAwVYo1bwGR
         CKcXDOgJ2aqC0f45FYpbx1Wsgxexl6tSsNuPsQkr8tFjvP/o6ePwxJif3z2LquVvjM
         GxwKSGl13V/8sq6EjXNIIiazum1ELgB/n+hCMfrqAIZWrYztj079ccJWpn+NN8Lnzu
         5IbAWdz5aC6xQ==
Received: (nullmailer pid 1853444 invoked by uid 1000);
        Thu, 14 Sep 2023 19:00:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: dt-bindings: st,stm32-spi: Move "st,spi-midi-ns" to spi-peripheral-props.yaml
Date:   Thu, 14 Sep 2023 14:00:42 -0500
Message-Id: <20230914190049.1853136-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to validate SPI peripherals, SPI controller-specific child node
properties need to be in a separate schema, spi-peripheral-props.yaml,
which SPI peripheral schemas reference. As there is just a single
property in this case, just add it to spi-peripheral-props.yaml directly.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/spi/spi-peripheral-props.yaml    |  5 +++++
 .../devicetree/bindings/spi/st,stm32-spi.yaml | 20 -------------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index dc4f7bb47090..15938f81fdce 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -113,6 +113,11 @@ properties:
     minItems: 2
     maxItems: 4
 
+  st,spi-midi-ns:
+    description: |
+      Only for STM32H7, (Master Inter-Data Idleness) minimum time
+      delay in nanoseconds inserted between two consecutive data frames.
+
 # The controller specific properties go here.
 allOf:
   - $ref: arm,pl022-peripheral-props.yaml#
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index 9ca1a843c820..ae0f082bd377 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -18,15 +18,6 @@ maintainers:
 
 allOf:
   - $ref: spi-controller.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: st,stm32f4-spi
-
-    then:
-      properties:
-        st,spi-midi-ns: false
 
 properties:
   compatible:
@@ -59,17 +50,6 @@ properties:
       - const: rx
       - const: tx
 
-patternProperties:
-  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-f]+$":
-    type: object
-    # SPI slave nodes must be children of the SPI master node and can
-    # contain the following properties.
-    properties:
-      st,spi-midi-ns:
-        description: |
-          Only for STM32H7, (Master Inter-Data Idleness) minimum time
-          delay in nanoseconds inserted between two consecutive data frames.
-
 required:
   - compatible
   - reg
-- 
2.40.1

