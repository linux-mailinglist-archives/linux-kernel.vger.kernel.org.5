Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4A7B0AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjI0Qyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Qy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:54:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD591
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:54:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3815BC433C8;
        Wed, 27 Sep 2023 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695833667;
        bh=OWCmuPebvFogsaXQ+UWO53mmD8IYPbNXCEUOxHi0SX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OS6UKmOIJ/EdftafGfIt8QW4UBwispRhzODgAANJ7P8uch/3it1bBEZWsLLigHDWD
         zyjsBBapu3BDfr6Iszc4lUfcX1l5hwuHHagsjSiY25YT71V0mX53itbjZjYG/UDCCH
         /h/y7TOD7R6dV+WE6mPfpwEMhgEOeGshLQ9CY6fIV+I9P5o+MCjXD4SE6rWu5cAMXk
         rhJFkRpJbU8XJrjlVEKIfKjuUzYluje1/CETC0vP6ILLDEPXvolfdsHdGPGOI2H1AD
         JWNOai2dCtkM+pSx3elaxzamyUpsoNNdG36u7/As+zMrOt9a/ECzE9PQgOwCesCXrg
         YJH3WiMIm7j9A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: usb: Add T-HEAD TH1520 USB controller
Date:   Thu, 28 Sep 2023 00:42:21 +0800
Message-Id: <20230927164222.3505-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230927164222.3505-1-jszhang@kernel.org>
References: <20230927164222.3505-1-jszhang@kernel.org>
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

T-HEAD TH1520 platform's USB has a wrapper module around
the DesignWare USB3 DRD controller. Add binding information doc for
it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/usb/thead,th1520-usb.yaml        | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml b/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
new file mode 100644
index 000000000000..afb618eb5013
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/thead,th1520-usb.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/thead,th1520-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 DWC3 USB Controller Glue
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+properties:
+  compatible:
+    const: thead,th1520-usb
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: ref
+      - const: bus_early
+      - const: phy
+      - const: suspend
+
+  ranges: true
+
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+# Required child node:
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+
+    usb {
+          compatible = "thead,th1520-usb";
+          reg = <0xec03f000 0x1000>;
+          clocks = <&clk 1>,
+                   <&clk 2>,
+                   <&clk 3>,
+                   <&clk 4>;
+          clock-names = "ref", "bus_early", "phy", "suspend";
+          ranges;
+          #address-cells = <1>;
+          #size-cells = <1>;
+
+          usb@e7040000 {
+                compatible = "snps,dwc3";
+                reg = <0xe7040000 0x10000>;
+                interrupts = <68>;
+                dr_mode = "host";
+          };
+    };
-- 
2.40.1

