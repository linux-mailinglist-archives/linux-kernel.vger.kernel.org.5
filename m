Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450287A41CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbjIRHJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbjIRHJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:09:11 -0400
Received: from core.lopingdog.com (core.lopingdog.com [162.55.228.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DF212F;
        Mon, 18 Sep 2023 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lopingdog.com;
        s=mail; t=1695020341;
        bh=B+H2Yde7aQ0rvCr6RPca7aubuh7ZTcIKOPoviGVXPv0=;
        h=Date:From:To:Subject:From;
        b=rDqZhCpgUfIbYop4ZntRaUeRm61s4VGfbZtCyuBwn4fOG9KdTwV7QPpV3il8e0gNw
         nABvEhOHMtrRDHPSRGb34Q8Uh2uT8yOhkUncYl5mXbFwKRGfdb59wfq0VIvrZCbx1V
         BW/+A89mRmjuJ8rTSlgZDAxghz+U5Tf62OU/ou1Hpc35iTtlgYBMsxcqebaYabIigf
         qfkmIp3WbkEf2HWX5iKvQ7PATaCs9MeWNzKdDzoNtvoOHp2i8/dZj0OJrj6Iyfe2Jy
         Pi8wbP6vzprNJcHeQZbFs+BHoFRDb9vUgOhK86ktXjozfc6S7bNFGqoume1WdGHzF5
         RruB7NM5zY9jQ==
Received: from authenticated-user (core.lopingdog.com [162.55.228.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by core.lopingdog.com (Postfix) with ESMTPSA id 3A2DA440CCF;
        Mon, 18 Sep 2023 01:59:00 -0500 (CDT)
Date:   Mon, 18 Sep 2023 01:58:58 -0500
From:   Jay Monkman <jtm@lopingdog.com>
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: [PATCH 2/4] dt-bindings: net: Add onsemi NCN26010 ethernet controller
Message-ID: <ZQf1Mgb8lfHkB6rl@lopingdog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add devicetree bindings for onsemi's NCN26010 10BASE-T1S
ethernet controller.

Signed-off-by: Jay Monkman <jtm@lopingdog.com>
---
 .../devicetree/bindings/net/onnn,macphy.yaml  | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/onnn,macphy.yaml

diff --git a/Documentation/devicetree/bindings/net/onnn,macphy.yaml b/Documentation/devicetree/bindings/net/onnn,macphy.yaml
new file mode 100644
index 000000000000..1813da81b95f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/onnn,macphy.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/onnn,macphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: onsemi 10BASE-T1S Ethernet Controller
+
+maintainers:
+  - Jay Monkman <jtm@lopingdog.com>
+
+description: |
+  Bindings for onsemi 10BASE-T1S ethernet controller.
+
+  Supported devices:
+    ncn26010
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    const: onnn,ncn26010
+
+  ctrl-protected:
+    description: |
+      Enables control data read/write protection mode.
+    type: boolean
+
+  poll-interval:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Defines how often the MACPHY thread runs in milliseconds.
+      If not specified, a default value of 5 is used.
+
+  tx-fcs-calc:
+    description: |
+      Enables driver calculation of the FCS on transmitted frames.
+    type: boolean
+
+  rx-fcs-check:
+    description: |
+      Enables driver checking of the FCS on received frames
+    type: boolean
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  mdio:
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet@0 {
+        compatible = "onnn,ncn26010";
+        reg = <0>; /* CE0 */
+        ctrl-protected;
+        tx-fcs-calc;
+        rx-fcs-check;
+        poll-interval = <5>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&eth1_pins>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 0x2>;
+
+        mdio {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          ephy0: ethernet-phy@0 {
+            compatible = "ethernet-phy-ieee802.3-c22";
+            reg = <0>;
+            dio0-fn = "gpio";
+            dio0-slew = "slow";
+            dio1-fn = "gpio";
+            dio1-slew = "slow";
+            eni-enable;
+          };
+        };
+      };
+    };
-- 
2.40.1

