Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A20B7D11FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377604AbjJTPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377529AbjJTPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:00:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F9D53;
        Fri, 20 Oct 2023 08:00:27 -0700 (PDT)
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5BF3D6607354;
        Fri, 20 Oct 2023 16:00:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697814026;
        bh=0nsuJcLELNO4KeUAgc+Tm0v2sheLoESSykKnldWwo3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgjbBIZuUP1Ix/uODOIpTPh9yOTx6gW4ly7UzeYbCgkQC44beAKD5pVUGK1wieuJd
         j6tCaZoxFhwxwrvRlDY0mK8M9XvqZnjC1qtNuFda09Gq/K9Edfw9JqqoEOhb7KM/fw
         q0hepDyFc7o/zffgpOxkCB9FiTvX44T5y5DoN0NRzCRDfCSBVOy46lCoeRyd5rH0M7
         7zbCCfcO6fMx5xzhj1TmhUkl8q+/qV7MFDiVM+lw9hNd0iKhr0/D+Hv3taEC0eDyWR
         WzNbgk/TEUf8esupbq54djPeq/VddLJa/1TFAOCZXj7+gcFeAODC6y/qNYo89Ly7z9
         5hJ2nhiLjlO/A==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 06726480103; Fri, 20 Oct 2023 17:00:24 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 1/3] dt-bindings: usb: add rk3588 compatible to rockchip,dwc3
Date:   Fri, 20 Oct 2023 16:11:40 +0200
Message-ID: <20231020150022.48725-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020150022.48725-1-sebastian.reichel@collabora.com>
References: <20231020150022.48725-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3588 has three DWC3 controllers. Two of them are fully functional in
host, device and OTG mode including USB2 support. They are connected to
dedicated PHYs, that also support USB-C's DisplayPort alternate mode.

The third controller is connected to one of the combphy's shared
with PCIe and SATA. It can only be used in host mode and does not
support USB2. Compared to the other controllers this one needs
some extra clocks.

While adding the extra clocks required by RK3588, I noticed grf_clk
is not available on RK3568, so I disallowed it for that platform.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/usb/rockchip,dwc3.yaml           | 60 +++++++++++++++++--
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index 291844c8f3e1..264c2178d61d 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -20,9 +20,6 @@ description:
   Type-C PHY
   Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
 
-allOf:
-  - $ref: snps,dwc3.yaml#
-
 select:
   properties:
     compatible:
@@ -30,6 +27,7 @@ select:
         enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3568-dwc3
+          - rockchip,rk3588-dwc3
   required:
     - compatible
 
@@ -39,6 +37,7 @@ properties:
       - enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3568-dwc3
+          - rockchip,rk3588-dwc3
       - const: snps,dwc3
 
   reg:
@@ -58,7 +57,9 @@ properties:
           Master/Core clock, must to be >= 62.5 MHz for SS
           operation and >= 30MHz for HS operation
       - description:
-          Controller grf clock
+          Controller grf clock OR UTMI clock
+      - description:
+          PIPE clock
 
   clock-names:
     minItems: 3
@@ -66,7 +67,10 @@ properties:
       - const: ref_clk
       - const: suspend_clk
       - const: bus_clk
-      - const: grf_clk
+      - enum:
+          - grf_clk
+          - utmi
+      - const: pipe
 
   power-domains:
     maxItems: 1
@@ -86,6 +90,52 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: snps,dwc3.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3328-dwc3
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 4
+        clock-names:
+          minItems: 3
+          items:
+            - const: ref_clk
+            - const: suspend_clk
+            - const: bus_clk
+            - const: grf_clk
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-dwc3
+    then:
+      properties:
+        clock-names:
+          minItems: 3
+          items:
+            - const: ref_clk
+            - const: suspend_clk
+            - const: bus_clk
+            - const: utmi
+            - const: pipe
+
 examples:
   - |
     #include <dt-bindings/clock/rk3328-cru.h>
-- 
2.42.0

