Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A880B77FEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354863AbjHQU1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354869AbjHQU1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C29D359C;
        Thu, 17 Aug 2023 13:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2D261182;
        Thu, 17 Aug 2023 20:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8328C433C8;
        Thu, 17 Aug 2023 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692304022;
        bh=vq2QpcRQNb8e+Lmh0hjoG6fR40fGSWsXLdAb85uymp4=;
        h=From:To:Cc:Subject:Date:From;
        b=Pa63xgTJLDwrTiqLIXUYrrhQPTKymqcGn6CppUTTby4L6Cpi/59FDtvRXFDzFIOE0
         ZiTpmpcVP03d4oSIs0nEBtqZ+YP6g5myuwimzGYjNMSh1K9ibKi0qxNT3gY7HmKhuO
         a+xlziNUxvou5pHDDqxI0f4csZAj8swIFW94KFUKvR6diY7O4CVfQVWfMsljtXXgjd
         gkY3ymzyzSmonWho08QabPrLs0Lt+NjoQaj4T/Q6mIgFUlqGJvetLwZksXwzwRU09J
         4gXwSqHC2Ik09/owIP7ppv2W5OiTIMsbq3EiGlRqnj1kAdf8wAjKahP4pI78ma8zP9
         cJM1fegVlmF7g==
Received: (nullmailer pid 2179908 invoked by uid 1000);
        Thu, 17 Aug 2023 20:26:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Helen Koike <helen.koike@collabora.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: dt-bindings: Merge OV5695 into OV5693 binding
Date:   Thu, 17 Aug 2023 15:26:46 -0500
Message-Id: <20230817202647.2179609-1-robh@kernel.org>
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

The OV5695 binding is almost the same as the OV5693 binding. The only
difference is 'clock-names' is defined for OV5695. However, the lack of
clock-names is an omission as the Linux OV5693 driver expects the same
'xvclk' clock name.

'link-frequencies' is required by OV5693, but not OV5695, so make that
conditional. Really, this shouldn't vary by device, but we're stuck with
the existing binding use.

The rockchip-isp1 binding example is missing required properties, so it
has to be updated as well.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Make link-frequencies conditionally required
---
 .../devicetree/bindings/media/i2c/ov5695.txt  | 41 -------------------
 .../bindings/media/i2c/ovti,ov5693.yaml       | 31 ++++++++++----
 .../bindings/media/rockchip-isp1.yaml         |  1 +
 3 files changed, 25 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5695.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/ov5695.txt b/Documentation/devicetree/bindings/media/i2c/ov5695.txt
deleted file mode 100644
index 640a63717d96..000000000000
--- a/Documentation/devicetree/bindings/media/i2c/ov5695.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* Omnivision OV5695 MIPI CSI-2 sensor
-
-Required Properties:
-- compatible: shall be "ovti,ov5695"
-- clocks: reference to the xvclk input clock
-- clock-names: shall be "xvclk"
-- avdd-supply: Analog voltage supply, 2.8 volts
-- dovdd-supply: Digital I/O voltage supply, 1.8 volts
-- dvdd-supply: Digital core voltage supply, 1.2 volts
-- reset-gpios: Low active reset gpio
-
-The device node shall contain one 'port' child node with an
-'endpoint' subnode for its digital output video port,
-in accordance with the video interface bindings defined in
-Documentation/devicetree/bindings/media/video-interfaces.txt.
-The endpoint optional property 'data-lanes' shall be "<1 2>".
-
-Example:
-&i2c7 {
-	ov5695: camera-sensor@36 {
-		compatible = "ovti,ov5695";
-		reg = <0x36>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&clk_24m_cam>;
-
-		clocks = <&cru SCLK_TESTCLKOUT1>;
-		clock-names = "xvclk";
-
-		avdd-supply = <&pp2800_cam>;
-		dovdd-supply = <&pp1800>;
-		dvdd-supply = <&pp1250_cam>;
-		reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
-
-		port {
-			wcam_out: endpoint {
-				remote-endpoint = <&mipi_in_wcam>;
-				data-lanes = <1 2>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
index 359dc08440a8..6829a4aadd22 100644
--- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
@@ -5,26 +5,41 @@
 $id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Omnivision OV5693 CMOS Sensor
+title: Omnivision OV5693/OV5695 CMOS Sensors
 
 maintainers:
   - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
 
 description: |
-  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
-  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
+  The Omnivision OV5693/OV5695 are high performance, 1/4-inch, 5 megapixel, CMOS
+  image sensors that deliver 2592x1944 at 30fps. It provides full-frame,
   sub-sampled, and windowed 10-bit MIPI images in various formats via the
   Serial Camera Control Bus (SCCB) interface.
 
-  OV5693 is controlled via I2C and two-wire Serial Camera Control Bus (SCCB).
-  The sensor output is available via CSI-2 serial data output (up to 2-lane).
+  OV5693/OV5695 are controlled via I2C and two-wire Serial Camera Control Bus
+  (SCCB). The sensor output is available via CSI-2 serial data output (up to
+  2-lane).
 
 allOf:
   - $ref: /schemas/media/video-interface-devices.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ovti,ov5693
+    then:
+      properties:
+        port:
+          properties:
+            endpoint:
+              required:
+                - link-frequencies
 
 properties:
   compatible:
-    const: ovti,ov5693
+    enum:
+      - ovti,ov5693
+      - ovti,ov5695
 
   reg:
     maxItems: 1
@@ -34,6 +49,9 @@ properties:
       System input clock (aka XVCLK). From 6 to 27 MHz.
     maxItems: 1
 
+  clock-names:
+    const: xvclk
+
   dovdd-supply:
     description:
       Digital I/O voltage supply, 1.8V.
@@ -72,7 +90,6 @@ properties:
 
         required:
           - data-lanes
-          - link-frequencies
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
index 0bad7e640148..e466dff8286d 100644
--- a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
@@ -199,6 +199,7 @@ examples:
             wcam: camera@36 {
                 compatible = "ovti,ov5695";
                 reg = <0x36>;
+                clocks = <&cru SCLK_TESTCLKOUT1>;
 
                 port {
                     wcam_out: endpoint {
-- 
2.40.1

