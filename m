Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB457AF6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjIZXn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjIZXlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:41:55 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88B1E76AE;
        Tue, 26 Sep 2023 15:57:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,178,1694703600"; 
   d="scan'208";a="177325632"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Sep 2023 06:08:31 +0900
Received: from mulinux.home (unknown [10.226.92.200])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DFF8E40B91B6;
        Wed, 27 Sep 2023 06:08:26 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related properties
Date:   Tue, 26 Sep 2023 22:08:17 +0100
Message-Id: <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSI IP found inside the Renesas RZ/V2M SoC can also work
in SPI slave mode.
When working in slave mode, the IP can make use of the SS
(Slave Select) pin, with "low" as default active level.
The active level of SS can be changed to "high" upon configuration.
This patch adds two new properties, one to make use of the
SS pin when in slave mode, and one to make the SS pin active high.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../bindings/spi/renesas,rzv2m-csi.yaml           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml
index e59183e53690..c3d8ad6525bb 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml
@@ -39,6 +39,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  renesas,csi-ss:
+    type: boolean
+    description:
+      Use CSI Slave Selection (SS) pin to enable transmission and reception when
+      in slave mode.
+
+  renesas,csi-ss-high:
+    type: boolean
+    description:
+      The SS pin is active high (by default the SS pin is active low).
+
 required:
   - compatible
   - reg
@@ -50,6 +61,10 @@ required:
   - '#address-cells'
   - '#size-cells'
 
+dependencies:
+  renesas,csi-ss: [ spi-slave ]
+  renesas,csi-ss-high: [ 'renesas,csi-ss' ]
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

