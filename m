Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F04E77FA54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352801AbjHQPHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352767AbjHQPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:07:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B69271B;
        Thu, 17 Aug 2023 08:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaGoJXYTQD6tybbqE6MbVNzMzrUzKIcZWyxBhjGSdyjiXWU4HvS2+ap5SMXINwzvAMRel/KZCaFChk5kuCAYeUp04AhCTnDYt6fWlXwzKBdAWdKfJx/Xj94+EMf+gsLr2XZczKDFmhDi1CAK1YnUwtaQERi8TYZLq2OeYx//pDxOtF0VVYdm8yOwTOthhNLbjN+JmhCWTd4l3qGcT8zzJJSkMfqDdigwe+5RHvYAxGq3OzMpozWVvqb9vO2nLwTYds/50VxRiNDsLW7qtCJGb7H53M+cHmsB0neT6ud5bPsHrl39ZnILkdOgknuK3rHxSdadgW/hQVuAHZ4sLw0CJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz7DE+CfGJK0uI/GEZlJGBUyHE9LCjNSCDZNz2fWotc=;
 b=cQh4HzLlQTABfLSVtgmUaBxjUqL25WlrwvmUylujvSFVrV8Q7/ASIKiQYnbMoAMG2bwacOpPUKsn8WEwDf23FbVKSLmbGKngYVuDdRBIUZRRptBHwapUUvl0iFDcKQ4eV40GTmvu0pbvxPVGePRTqPNtCjNp3zxKwwtvEsYdkFdJfmIKBOvyBP7XSUoFmnJ+vXpYlZ5GHN4Bgqq0vShP7xUAlAcHAplcffMD+Fzg87OT4R43RSc6QSzSAc5/ByufVvldpR7chRVWqrC0Z7w4u6js7N0WvcKpGC93+qaE1zOlfrqqoaHI99PGfU5D2g2HptwrV++ghPelH4fC+iNtzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz7DE+CfGJK0uI/GEZlJGBUyHE9LCjNSCDZNz2fWotc=;
 b=Kg7HnvemSoyK+0daEWfdj2z5H2oUCxHlPVK1qBl8R1WTWTvz9Y98XxB24GKHQvITs87yA9TFjTOL2jOCs2ncQzJ7pxr69ywKCOiXG/bxd5vRxsOFjPdB/wtmQBbeYksud33ZzOYKiSOjn7rvRlPahJE0MExoSsypP3kqEeXKNQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:07:07 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:07:07 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [RFC PATCH net-next 8/8] dt-bindings: net: fsl,backplane-anlt: new binding document
Date:   Thu, 17 Aug 2023 18:06:44 +0300
Message-Id: <20230817150644.3605105-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9385b3-32cf-4344-8018-08db9f339f78
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0WqkugZQgo17mt47ZKAFzDPLiN/GiRH8VZS8WvG8Yu0wK6//eDPYrUuOD4SdASGBiLcFbBW7L6Ej2MXbACJ1LnvRuXGchQRwJUz/n+d73CcW7/5EUqSIh1R+5pxFRLbex0e4CWXcID6Ucftl4hLUxMKW6JJL2v7XdjUbu8kK9gorGYpFzBx+LDxr+QdyiGqpAxAiIR1l1yjLUhu02o/0Xp1zUexSNl+AE8JIkFx/4hvYRNsC6WahK5VQPbBMKefm2JfA1bIn+Fn1q3SSSb3vRURWKwhwz58GmkksJjJQ10j9OZd8kq2cffT5iDfs9iTLCDabbdaS1PSDYED1LLzxfPPITpJMct807OuZ4Whm3MjWJbNFWUAuFM6Lp8ZTBHIjxIJUls2QByvMcHkqSVRFuU8s8Kxo2xLiZF5j6KdlVunqtJY2PHUvkQrNSS/tXAxhZZVJ+u1Q87HUWx3diBYUkrP/9OHNXuMGBheAdlwJomkLZfhuTEWFpWad72tcXQ0lltRl+i2DpZLP2B/FzTXuAy/p1Mk7sZtpSoBoB1z2OGmvIZMDbn1ZNpP9Yz7IQL4N14UrkkrX60RZNPYfwZgj0A+q05Ct24C6vKxMBO2KduV4UW3ioRH60PfZ8I7D0CHM/AR+vYuoDyd1VkpvGeyhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(1076003)(6486002)(6512007)(52116002)(966005)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QdHEXJTnmVVGsgY9jRQ5zQgWpJ5pBTyGYzGGE4QxAFiWY5qwHGg48RRuBlX5?=
 =?us-ascii?Q?QtBX9tdF17KbhZYGPgKh91622KsJZZcaWA5qGxqUvef8bLogUiQCvLvVz2fr?=
 =?us-ascii?Q?rM5wjEhfEMm8YvTuKw1u5jXXjrnlJXAtFvPj30NtxFuTARMg3MynpcdwJE0T?=
 =?us-ascii?Q?nvF+12ExWN3OwO7Ee8trjyMd36VuRdgE10qog070Jmzpr9l2jvTwDyFagotF?=
 =?us-ascii?Q?7o3LSwpYEK0q5OMWYwVANMzbuFG5Rgh7IhM8/xJYR/zRLmwVRWcoe3i2uMu3?=
 =?us-ascii?Q?dyispP674TiTgEi+SEz9x8fcmUhV5VIqhgUuvdufFr85QpUCtn/bxLFJ3pYc?=
 =?us-ascii?Q?LrbJFm+Yt31BrRHbfWtjEDb4IriD2zLtm1JQblF4uB208fw6J38zeOvitgW8?=
 =?us-ascii?Q?U630ApoKg5vhErBZJNBoaLBs5l868iXjsjtuVMuC80gwXBuD/9gyg/bfKIN3?=
 =?us-ascii?Q?yEf4adODNFrXNI09pBxPeYGVg/kKqMikn09JAykpMeDEYuwET+itsSEjO9sc?=
 =?us-ascii?Q?YH3dG6RD2Zmg0l1m2mZpqJVdQDlxgaPX+W4t6mQLIib17fo/NnUYFRbucmsR?=
 =?us-ascii?Q?F71xiq+sug9cLRYaRjze2SfQYFJ9FuBOjZDKA55JM+BgHvzDSEhodzm1QerG?=
 =?us-ascii?Q?hx5uJbjr1Sl0kth9VjFKvpse0rbXK9lKQKalR92R+Dj66P+1q9+szkRA6m6o?=
 =?us-ascii?Q?cpeBP9T6ODaFoD44SoFYs6ARZCEvma69dHZNs5QRCQrD17iahwZDG12v9dUS?=
 =?us-ascii?Q?9jZPPKqtJAt+nXkupY07SXxZ3BkOovUXhl3jECMTG7CZ2R83ayQbEZ7+ehML?=
 =?us-ascii?Q?fczTQENxl+x7A/g331h+O9Mv1xbOWsewYi5jcHZg7kQCyWa71k4A0F/l/sIU?=
 =?us-ascii?Q?cO1Nre7gCGtLgeSqaeTVPyEIrjkMkfuwSQGIrwPUdPWif8c4BRM7Qr83yfP3?=
 =?us-ascii?Q?QD0MSpn9Ctv20aRb82naM51MI6Y2EWrkX+AE4Bo1S9NfS+XYAvRwt5WIZoRm?=
 =?us-ascii?Q?LvF4C5BmZKhaRGAcSSN0WxtrnPDXHswECKL0Boonwh+2VuGsVdbUxKIypm9+?=
 =?us-ascii?Q?P5MQpzqyv/OltJ6ILaCZ8YMceciWF8IrBECYFxlCPoXyqD3iEC0D39a9kyxm?=
 =?us-ascii?Q?hUEg3VJLak71sf3a5WaUHEFz1HL2bRdGHCTo5GOqpvnbBV/qNikxtTTRgx2r?=
 =?us-ascii?Q?MWc8z/hJJFWxffrpI6iwt+GtHhWo1uPPgXVoT0m22aanjvgN+pWvskIVGoOs?=
 =?us-ascii?Q?fnvc+/GPra0lH9g9bJ+39zN0vFOzf2IO5lBYtiKqxRGXH0QEETXy4DUcF1NP?=
 =?us-ascii?Q?4/1jzxte42uaJnGZtUyC2Rmz3QaHu8Zt4afYjuc2gFr46CguqPnWYMno0VQP?=
 =?us-ascii?Q?hKUsZ+058Yysj3wriv7moQXALfe7uRJ2jHLbWUe2Y9Se3LkkaHS3+Bw4UGrq?=
 =?us-ascii?Q?Qy30FufKfpZv3rdw24c0PKZ1xy7mGzpIep7el1ohdhJnNV1BXGqoyFqcqxP5?=
 =?us-ascii?Q?1apMlkO6LMCwHixR61X8htvQ/s9fD6mxFaX/S5Jv7S8zjIOozip2e7xfBOz1?=
 =?us-ascii?Q?LszX8VIZNsC2DH+urICpwKt0mFp7Rv+Hl2Z66uv5gYeyT1Oyql9M1Rpn0z0F?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9385b3-32cf-4344-8018-08db9f339f78
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:07:07.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BVg3tuKK4SsAQHJr+1Z/X7aSUXpOXxWHD5tXHf649rnbjebKlnuSObea/brV3x9l8+oKESgnY04zhu9EBBbFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Illustrate how the backplane AN/LT blocks can be instantiated on the
LX2160A SoC with SerDes protocol 19.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../devicetree/bindings/net/ethernet-phy.yaml |   8 +
 .../bindings/net/fsl,backplane-anlt.yaml      | 238 ++++++++++++++++++
 2 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index c1241c8a3b77..96fa672e4786 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -49,6 +49,14 @@ properties:
       - items:
           - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
           - const: ethernet-phy-ieee802.3-c45
+      - items:
+          - const: fsl,lx2160a-backplane-anlt
+          - const: ethernet-phy-ieee802.3-c45
+        description:
+          Some C45 PHYs have no PHY ID in the standard location, and there is
+          also no PHY ID allocated for them to fake. They are identified by the
+          primary compatible string, plus the secondary one to distinguish them
+          from a raw MDIO device.
 
   reg:
     minimum: 0
diff --git a/Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml b/Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml
new file mode 100644
index 000000000000..7282e93b1dd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,backplane-anlt.yaml
@@ -0,0 +1,238 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,backplane-anlt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Backplane Ethernet PHY
+
+maintainers:
+  - Vladimir Oltean <vladimir.oltean@nxp.com>
+
+description: |
+  Some QorIQ and Layerscape SoCs have an additional block on each SerDes
+  networking lane, based on an IP core from MoreThanIP, which performs IEEE
+  802.3 clause 73 base page exchanges (for auto-negotiation) and clause 72
+  training frame exchanges (for link training).
+
+  By default, this AN/LT block comes up with auto-negotiation disabled, and
+  in that case it allows itself to be quickly bypassed from the data path and
+  for the PCS link to come up without its involvement.
+
+  Software can optionally make use of it, to turn the PCS, AN/LT block and lane
+  (PMA/PMD) into a full copper backplane internal PHY.
+
+  As a warning, the binding for the multi-lane link modes (40GBase-KR4) is not
+  currently backed up by a driver implementation.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          - items:
+              - const: fsl,lx2160a-backplane-anlt
+              - const: ethernet-phy-ieee802.3-c45
+    then:
+      $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,lx2160a-backplane-anlt
+          - const: ethernet-phy-ieee802.3-c45
+      - const: fsl,lx2160a-secondary-anlt
+
+  reg:
+    minimum: 0
+    maximum: 31
+    description: |
+      The address of the AN/LT block within the internal MDIO bus of the MAC it
+      is attached to.
+
+      In the 1000Base-KX and 10GBase-KR link modes, the AN/LT block responds at
+      the same MDIO address as the PCS (determined by the SGMIInCR1[MDEV_PORT]
+      or SXGMIInCR1[MDEV_PORT] registers of the SerDes block, by default 0).
+      The PCS and AN/LT block respond to different MMDs, though.
+
+      In the 25GBase-KR and higher link modes, the AN/LT block responds at a
+      different MDIO address than the PCS, determined by the
+      ANLTnCR1[MDEV_PORT] register of the SerDes block. By default this is 4
+      for lanes A and E, 5 for lanes B and F, 6 for lanes C and G, 7 for lanes
+      D and H.
+
+      The PCS responds in all cases at the address determined by the MDEV_PORT
+      field of the SGMIInCR1, SXGMIIaCR1, E25GaCR1, E40GaCR1, E50GaCR1 or
+      E100GaCR1 registers of the SerDes block.
+
+  phys:
+    maxItems: 1
+    description:
+      phandle for the generic PHY (SerDes lane) that acts as PMA/PMD layer
+
+  pcs-handle:
+    maxItems: 1
+    description:
+      phandle for the technology-dependent PCS block corresponding to the
+      initial (RCW-based) configuration of the port. Must be omitted for the
+      link modes where the PCS and AN/LT block respond at the same MDIO
+      address. Must be specified otherwise.
+
+  secondary-anlt-handle:
+    maxItems: 1
+    description:
+      In case this is the primary (first) lane of a multi-lane link mode, this
+      property holds an array of phandles for the other AN/LT blocks, that are
+      involved in link training but not in auto-negotiation. These have the
+      "fsl,lx2160a-secondary-anlt" compatible string.
+
+required:
+  - compatible
+  - reg
+  - phys
+
+unevaluatedProperties: false
+
+examples:
+
+  # LX2160A lanes A, B, C, D with SerDes 1 protocol 19: dpmac2 uses 40GBase-KR4
+  - |
+    dpmac2 {
+        phy-handle = <&mac2_backplane_anlt>;
+        phy-connection-type = "internal";
+    };
+
+    pcs_mdio2 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        status = "okay";
+
+        pcs2: ethernet-phy@0 {
+            reg = <0>;
+        };
+
+        mac2_backplane_anlt: ethernet-phy@7 {
+            compatible = "fsl,lx2160a-backplane-anlt",
+                          "ethernet-phy-ieee802.3-c45";
+            reg = <7>; /* according to ANLTDCR1[MDEV_PORT] */
+            phys = <&serdes_1 3>; /* lane D */
+            max-speed = <40000>;
+            pcs-handle = <&pcs2>;
+            secondary-anlt-handle = <&mac2_lane2_anlt>, <&mac2_lane3_anlt>,
+                                    <&mac2_lane4_anlt>;
+        };
+
+        mac2_lane2_anlt: ethernet-backplane-anlt@6 {
+            compatible = "fsl,lx2160a-secondary-anlt";
+            reg = <6>; /* according to ANLTCCR1[MDEV_PORT] */
+            phys = <&serdes_1 2>; /* lane C */
+        };
+
+        mac2_lane3_anlt: ethernet-backplane-anlt@5 {
+            compatible = "fsl,lx2160a-secondary-anlt";
+            reg = <5>; /* according to ANLTBCR1[MDEV_PORT] */
+            phys = <&serdes_1 1>; /* lane B */
+        };
+
+        mac2_lane4_anlt: ethernet-backplane-anlt@4 {
+            compatible = "fsl,lx2160a-secondary-anlt";
+            reg = <4>; /* according to ANLTACR1[MDEV_PORT] */
+            phys = <&serdes_1 0>; /* lane A */
+        };
+    };
+
+  # LX2160A lane E with SerDes 1 protocol 19: dpmac6 uses 25GBase-KR
+  - |
+    dpmac6 {
+        phy-handle = <&mac6_backplane_anlt>;
+        phy-connection-type = "internal";
+    };
+
+    pcs_mdio6 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        status = "okay";
+
+        pcs6: ethernet-phy@0 {
+            reg = <0>;
+        };
+
+        mac6_backplane_anlt: ethernet-phy@4 {
+            compatible = "fsl,lx2160a-backplane-anlt",
+                          "ethernet-phy-ieee802.3-c45";
+            reg = <4>; /* according to ANLTFCR1[MDEV_PORT] */
+            phys = <&serdes_1 4>; /* lane E */
+            max-speed = <25000>;
+            pcs-handle = <&pcs6>;
+        };
+    };
+
+  # LX2160A lane F with SerDes 1 protocol 19: dpmac5 uses 25GBase-KR
+  - |
+    dpmac5 {
+        phy-handle = <&mac5_backplane_anlt>;
+        phy-connection-type = "internal";
+    };
+
+    pcs_mdio5 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        status = "okay";
+
+        pcs5: ethernet-phy@0 {
+            reg = <0>;
+        };
+
+        mac5_backplane_anlt: ethernet-phy@5 {
+            compatible = "fsl,lx2160a-backplane-anlt",
+                         "ethernet-phy-ieee802.3-c45";
+            reg = <5>; /* according to ANLTFCR1[MDEV_PORT] */
+            phys = <&serdes_1 5>; /* lane F */
+            max-speed = <25000>;
+            pcs-handle = <&pcs5>;
+        };
+    };
+
+  # LX2160A lane G with SerDes 1 protocol 19: dpmac4 uses 10GBase-KR
+  - |
+    dpmac4 {
+        phy-handle = <&mac4_backplane_anlt>;
+        phy-connection-type = "internal";
+    };
+
+    pcs_mdio4 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        status = "okay";
+
+        mac4_backplane_anlt: ethernet-phy@0 {
+            compatible = "fsl,lx2160a-backplane-anlt",
+                         "ethernet-phy-ieee802.3-c45";
+            reg = <0>; /* merged with PCS SXGMIIGCR1[MDEV_PORT] */
+            phys = <&serdes_1 7>; /* lane G */
+            max-speed = <10000>;
+            /* no pcs-handle to &pcs4 */
+        };
+    };
+
+  # LX2160A lane H with SerDes 1 protocol 19: dpmac3 uses 10GBase-KR
+  - |
+    dpmac3 {
+        phy-handle = <&mac3_backplane_anlt>;
+        phy-connection-type = "internal";
+    };
+
+    pcs_mdio3 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        status = "okay";
+
+        mac3_backplane_anlt: ethernet-phy@0 {
+            compatible = "fsl,lx2160a-backplane-anlt",
+                         "ethernet-phy-ieee802.3-c45";
+            reg = <0>; /* merged with PCS SXGMIIHCR1[MDEV_PORT] */
+            phys = <&serdes_1 7>; /* lane H */
+            max-speed = <10000>;
+            /* no pcs-handle to &pcs3 */
+        };
+    };
-- 
2.34.1

