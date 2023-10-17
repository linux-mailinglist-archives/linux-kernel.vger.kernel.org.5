Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B37CC88F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjJQQQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbjJQQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:14:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6C3ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:14:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D25C433CA;
        Tue, 17 Oct 2023 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697559254;
        bh=Ye90HBHDZzB2aDp/S5UGI++JNCzZ7q1PX2LEgBDO3FA=;
        h=From:To:Cc:Subject:Date:From;
        b=qx23junqDkaU3YjKyYdbbhUyl6RLIT071nSnCTOJMkBDZHvV4szsntrGDj3OEDqEj
         S897OKmOGZfSvjmRBVYtCU5LPOFJtMX6OJ82xXXEgA9Go4HgUsrSH/WNRLxFm58O8f
         ZUGjc4jgUhf1hAAv7P4kejGqwOn95zb7UDdwHe5jGFc/VkkSJxel6Mw98eYqq+Rcc4
         tBK+OWo+yQhKO7JIk3NlSwDXApMJ1XBfqcDzzy/hOuQFWXCMLlVaVtnCNqYoT9Pa/g
         YzIH4zPCVPoff2t6r9ayWW3UQfdZm/HSJfCmPpvxm89cLOBoVT8Iku16qe2NZVa9L9
         7FyQzoGAsPMNA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: vialab,vl817: remove reset-gpios from required list
Date:   Wed, 18 Oct 2023 00:01:58 +0800
Message-Id: <20231017160158.1065-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "reset-gpios" is optional in real case, for example reset pin is
is hard wired to "high". And this fact is also reflected by the
devm_gpio_get_optional() calling in driver code.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/usb/thead,th1520-usb.yaml        | 42 ++++++++++---------
 .../devicetree/bindings/usb/vialab,vl817.yaml |  1 -
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml b/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
index afb618eb5013..ce1cab75f0ff 100644
--- a/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
@@ -28,6 +28,10 @@ properties:
 
   ranges: true
 
+  thead,misc-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: a phandle to the misc system register controller syscon node.
+
   '#address-cells':
     enum: [ 1, 2 ]
 
@@ -51,23 +55,23 @@ additionalProperties: false
 
 examples:
   - |
-
-    usb {
-          compatible = "thead,th1520-usb";
-          reg = <0xec03f000 0x1000>;
-          clocks = <&clk 1>,
-                   <&clk 2>,
-                   <&clk 3>,
-                   <&clk 4>;
-          clock-names = "ref", "bus_early", "phy", "suspend";
-          ranges;
-          #address-cells = <1>;
-          #size-cells = <1>;
-
-          usb@e7040000 {
-                compatible = "snps,dwc3";
-                reg = <0xe7040000 0x10000>;
-                interrupts = <68>;
-                dr_mode = "host";
-          };
+    usb@ec03f000 {
+        compatible = "thead,th1520-usb";
+        reg = <0xec03f000 0x1000>;
+        thead,misc-syscon = <&misc_syscon>;
+        clocks = <&clk 1>,
+                 <&clk 2>,
+                 <&clk 3>,
+                 <&clk 4>;
+        clock-names = "ref", "bus_early", "phy", "suspend";
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        usb@e7040000 {
+            compatible = "snps,dwc3";
+            reg = <0xe7040000 0x10000>;
+            interrupts = <68>;
+            dr_mode = "host";
+        };
     };
diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
index 76db9071b352..c815010ba9c2 100644
--- a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
+++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
@@ -37,7 +37,6 @@ properties:
 required:
   - compatible
   - reg
-  - reset-gpios
   - vdd-supply
   - peer-hub
 
-- 
2.40.1

