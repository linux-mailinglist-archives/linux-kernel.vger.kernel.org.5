Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D6794159
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbjIFQX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjIFQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:23:26 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480B01992;
        Wed,  6 Sep 2023 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694017403;
  x=1725553403;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KrG2MZOvGizkIauCc3KWNFT1LrSe5AapyjWhd8HHjzw=;
  b=nFrXfywm8vIqMf0viZunfjwoaEYf53rY2mYe0TNtZJo6ySVg1yhKRZJH
   vLqxIXyhdBWb46eT+Ad187J24ZrNXQ9VYyM0Gkkjbn844LAqdiZVZ4SYi
   i+DX1DVAxlGPAbsegf3bkuFqL1fs4Jcr5ZbgsquAGso9EpvwsRZ4C1Ok2
   Me3UD2DnfqRKNZ5BDZ2B9/BuXNfP6b6MhExY4fDTqbiQngps5aTjnNKxv
   yMJCWCjJ2aLobN9EECAZlo0RPcYE1AfNpWlanlkhhLHBzQCLSBQElkc4F
   tPymOKd5syW+3dDQsOQUp6rBHfh30Ftjb1ob4nuUf+l+solL5w3eOq1Kx
   A==;
From:   Stefan x Nilsson <stefan.x.nilsson@axis.com>
Date:   Wed, 6 Sep 2023 18:22:16 +0200
Subject: [PATCH 1/2] dt-bindings: display: Add st7735s driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230906-st7735s-v1-1-add92677c190@axis.com>
References: <20230906-st7735s-v1-0-add92677c190@axis.com>
In-Reply-To: <20230906-st7735s-v1-0-add92677c190@axis.com>
To:     David Lechner <david@lechnology.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan x Nilsson <stefan.x.nilsson@axis.com>,
        <kernel@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for a driver for Sitronix st7735s display controller, as
well as for a Winstar wf0096atyaa3dnn0 0.96" 80x160 TFT panel.

Signed-off-by: Stefan x Nilsson <stefan.x.nilsson@axis.com>
---
 .../bindings/display/sitronix,st7735s.yaml         | 81 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7735s.yaml b/Documentation/devicetree/bindings/display/sitronix,st7735s.yaml
new file mode 100644
index 000000000000..36234ec22fe2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st7735s.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sitronix,st7735s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7735S Display Panels
+
+maintainers:
+  - Stefan x Nilsson <stefan.x.nilsson@axis.com>
+
+description:
+  This binding is for display panels using a Sitronix ST7735S
+  controller in SPI mode.
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          Winstar WF0096ATYAA3DNN0 0.96" 80x160 Color TFT
+        items:
+          - enum:
+              - winstar,wf0096atyaa3dnn0
+          - const: sitronix,st7735s
+
+  dc-gpios:
+    maxItems: 1
+    description: Display data/command selection (D/CX)
+
+  backlight: true
+  reg: true
+  spi-max-frequency: true
+  reset-gpios: true
+  rotation: true
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    backlight: backlight {
+            compatible = "gpio-backlight";
+            gpios = <&gpio 44 GPIO_ACTIVE_HIGH>;
+    };
+
+    regdisplay: regulatordisplay {
+            compatible = "regulator-fixed";
+            regulator-name = "display";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <100000>;
+            enable-active-high;
+    };
+
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            display@0 {
+                    compatible = "winstar,wf0096atyaa3dnn0","sitronix,st7735s";
+                    reg = <0>;
+                    spi-max-frequency = <12000000>;
+                    dc-gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
+                    reset-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+                    backlight = <&backlight>;
+                    power-supply = <&regdsiplay>;
+                    rotation = <270>;
+            };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6308efa121e1..c00b2b9086f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6728,6 +6728,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
 F:	drivers/gpu/drm/tiny/st7735r.c
 
+DRM DRIVER FOR SITRONIX ST7735S PANELS
+M:	Stefan x Nilsson <stefan.x.nilsson@axis.com>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/sitronix,st7735s.yaml
+
 DRM DRIVER FOR SOLOMON SSD130X OLED DISPLAYS
 M:	Javier Martinez Canillas <javierm@redhat.com>
 S:	Maintained

-- 
2.30.2

