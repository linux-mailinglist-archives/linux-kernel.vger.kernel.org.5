Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0A777AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjHJOld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbjHJOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:41:29 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78750D7;
        Thu, 10 Aug 2023 07:41:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id DDBB6FF808;
        Thu, 10 Aug 2023 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691678487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43vnQBR2KS8SqaomNNWpPAxrNsBiEbiI0oMhAMJc4f8=;
        b=PtpWr7bsRF04hV2V7F4lz5rDT+aPb9VSIG0T5EuvMg1Use6IFBC77u7cPz17+APSkwEfW8
        ArOj9WmvtLiw+dSQSMw9vmx4JY2Vp3iRLs7xD2/R4aJNzqVuqhFvXNpyPsOAyJcGK1jq1w
        pPBDx9J22d/ORYUlyRuFC0lin98QeXvXETq+TOgmvmhQWC3wp8BQc9IVNtJK2vlnkExueh
        1ZF+j0unyhIAQfb2ZYfiEYtatARGAlkUw/lUAEJ0jt8GWVG41GKX6w52AztCJqjVnnKofG
        /hMG7j7JDduQSTHXhCygxnuYyuwNvJqI7tCE5CUYeIVFJXVu3yMGtFa18rDw3g==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2 2/3] dt-bindings: display: panel: Add panels based on ILITEK ILI9806E
Date:   Thu, 10 Aug 2023 16:41:15 +0200
Message-Id: <20230810144116.855951-2-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810144116.855951-1-luca.ceresoli@bootlin.com>
References: <20230810144116.855951-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for LCD panels based on the ILITEK ILI9806E RGB controller
connected over SPI and the "ShenZhen New Display Co NDS040480800-V3"
480x800 panel based on it.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
 - remove T: line form MAINTAINERS entry
 - reference spi-peripheral-props.yaml
 - add 'maxItems: 1' to reg
 - use unevaluatedProperties
 - remove out of scope backlight node
---
 .../display/panel/ilitek,ili9806e.yaml        | 63 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
new file mode 100644
index 000000000000..83d177be4e7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9806e.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9806E display panels
+
+maintainers:
+  - Luca Ceresoli <luca.ceresoli@bootlin.com>
+
+description:
+  This binding is for display panels using an Ilitek ILI9806E controller in
+  SPI mode.
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # ShenZhen New Display Co 3.97" 480x800 RGB a-SI TFT LCD
+          - newdisplay,nds040480800-v3
+      - const: ilitek,ili9806e
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "newdisplay,nds040480800-v3", "ilitek,ili9806e";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_lcdgpios>;
+            reset-gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+
+            port {
+                ili9806e_in: endpoint {
+                    remote-endpoint = <&lcdif_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f966f05fb0d..085e44a7b5e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6516,6 +6516,11 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/ilitek,ili9486.yaml
 F:	drivers/gpu/drm/tiny/ili9486.c
 
+DRM DRIVER FOR ILITEK ILI9806E PANELS
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
+
 DRM DRIVER FOR JADARD JD9365DA-H3 MIPI-DSI LCD PANELS
 M:	Jagan Teki <jagan@edgeble.ai>
 S:	Maintained
-- 
2.34.1

