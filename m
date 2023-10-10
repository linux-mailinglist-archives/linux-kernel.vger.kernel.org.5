Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF07BFE21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjJJNmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjJJNlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:41:50 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070471721;
        Tue, 10 Oct 2023 06:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDd5vx5E5yxFStCfohqG77tDtvVzqXpvduhXnLkW+UlxLcoeHJVqRNQnMG+Gz4uplgw2FLs6LAspbmWIcZLUIKCuZcpHJlk63msldILB8ga+d65uoazG8WigWrl9RwJ7svTq0UM9Rki5UmtlZP7M7OZDHovd+X8nGXgLG4+dWCeGy9U3ISLY0ClKhvrxaysuRb553hLV1uLe0w8IWoyqxd4P2Rl2AAoYsm07oPkbFpxqU4lMopuJL19dn5LrGbkdyElTOOZ0QpSkmL/ZS69PrbQyrwwH8gNSJ+sn7eyesnqTdWBDey/BHYUNl64t75Cf/L9qEf3gTW/tSmiH/gt0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgD7xtr+AlJt7OTxlu0cjJdSBqzJFWnEsLHX7bDNbL4=;
 b=ZHty0I/Rx5LjjXnDYIRs+ropt6MA4gqaR7l2pZ0yrKhZzTe0NJjwXbRl9NQWEapvH+7KSzVrVwEKhyz8zRlFOn6/W6ZNC4jPpmbExQc6ZiocJSDki3q4x/ZppmuNdNHeA9i+LcRsd1alfkl5nG/U3TiHC02bV0GyMOZfwmdXgMTDpZT/jtfGl9vk3ClPT56G1NEJwYGewtfx3FXrjO3V1NEofWR0uIW5Xyikik7AgYTOgp6yoZeaQfqbgaYBqCXZhRnDDhHMDhCu6FmBI5454RveM0qivFGx8TSMSnxqAJoJqGTvM9X76IGkMMsQCAlrEdOfCzksnKAwMYiEVfEPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgD7xtr+AlJt7OTxlu0cjJdSBqzJFWnEsLHX7bDNbL4=;
 b=SRWUh6IqU4ZPuJu1wROAyUD/RS0/wiyzon9zhfNv0R+JwqwowAdXGnxECD6/tQ0KpO2wrdD4hPBFaNfxx2qmUdmGyADBcKwIDkfXGi5UEfJdK4UNsPeBjlcMe5zbjtIy8YNcPRoEV3aizeEDAyigVzixS2Gs7HOSJHSFWjuZl3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by GVXPR04MB9831.eurprd04.prod.outlook.com (2603:10a6:150:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 13:39:20 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 13:39:20 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 3/3] ASoC: dt-bindings: fsl,mqs: Convert format to json-schema
Date:   Tue, 10 Oct 2023 21:38:38 +0800
Message-Id: <20231010133838.799714-4-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010133838.799714-1-chancel.liu@nxp.com>
References: <20231010133838.799714-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|GVXPR04MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b6ae65-6c5c-4f96-11cc-08dbc9964eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DLeDKsX+1TZBSSHl5hCIS+G9G4hp70zIR/waP8+jgkuSHRTXpvfUlTklK2QbJhLGniHgVNURoVtVTMuDhLgPPLBBD8C2FczHLd9kCuel8tHukXT6RkBnuvc2gTN+0n+ZeALxRqcS5AjUtOqmPRb7pYgL7foGC1JkmQBN8xcDin5/ElY2yWRNY6v/LCoIl+WlejmpZUgH/jl6P3VEX0lxq2vtl0s1eLZ4hN7Kf689pSejRxcP7LwhN05SwyReQjRH8h5qlOCzxSoEyMhIMDfiqyjQV8b2sCTkT7vcjmlANEuFllkpCu40F77ntvsu0S9JzWdV+bQxTkRD+sEJg6fxQeMk5B5UAyYj4COXzFM3atkYt/LSPvB1RM+XXAXmGGdxaz0keKgLdfbwmKENGSgeBxnsx1oiAEC41/wf8nOpMWV50b/bKviKfnRs5rLr1HWHS0tZ/GGDUWLUEkVIjup8K/o2t69YFd+22FSu8DrOfaQbttEv54TlxGC/rZA47VqAKq+JaR9DOdgkr1v6OYdVBSIddhl+Sp3hQpGeFyoUm+yKJHb5U9QWhRz9A0rrXlxAB42aeE9VvnizDFAUWsILSNn8opKsTLh6MOxkqoXUa5GG7KXemi/Eccdx4D41ndM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38350700002)(38100700002)(921005)(36756003)(2906002)(6512007)(52116002)(478600001)(966005)(6486002)(41300700001)(4326008)(8676002)(5660300002)(44832011)(6506007)(8936002)(6666004)(2616005)(1076003)(83380400001)(316002)(66476007)(66556008)(66946007)(7416002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?84QAUXvUdIoWIlF6p1iJfI1GWDvxh8QrQKH9BzNkxaPNOoqskMjTNW9aF7xE?=
 =?us-ascii?Q?ccFbqFo+KMtZqkX9cjoQBBtZHdSWn6WkKkExNGydj88EryUX2etDrway8kKN?=
 =?us-ascii?Q?wUdABIhoSebq1nAzXEyFtSmB5iUVH+aeITpkOVdA14w0CF5k5fYu+Z4Y41mX?=
 =?us-ascii?Q?dnrYeiG2FqvnXtDYI+OMDtC5uh2d9lzJA3f9tes3Q1Pu6PXGbk0QbjUwXm4V?=
 =?us-ascii?Q?v4UvVn4gBA1gmm8CNBlvdTxbgj1Bo4n/OCfoCga7rTpndjL+orM4DvjA4ye3?=
 =?us-ascii?Q?wJ5VL97OQQA+cXquoaUO0po0YWVaEjpk1lIGWrmfswDzNbfz4wl15GJDacIN?=
 =?us-ascii?Q?iN5qIAegAtNhLC4tnkwOSryI50IM91k+aBNoG01WvUB87zMRhpmj4XGk2Sp3?=
 =?us-ascii?Q?WxUDDEdebbzVuJZwHGdLurEja/bUktaO5LCFDSxq7OXANnkIHt7BTfLuDnIl?=
 =?us-ascii?Q?f8i1NVfgwOr5WgqXp3Iyn+qAz5V+nrthskfBwddcj6rw1wsHrSa8+6Hz1/TP?=
 =?us-ascii?Q?dKlznBgAuWmpLAtsqGb4vooEjaslm6vfL0/4kTS/GsXydyzh0mrO04RjV7+a?=
 =?us-ascii?Q?2OKNzVosJG8z7KfRQjdyDP84BKYEQQw9EcmCKuUU1+jDpfBdW/mn3fDsFdCn?=
 =?us-ascii?Q?ruv4zenqpEVlCp5l+AxWFu0HglVwX0YCO2ZDS32fW62xMNFY/P1CyquaGd+S?=
 =?us-ascii?Q?myL8eXltut74TRUdpjO4Iye7i5N11WHiA4qAXb4LVaV+GNamNGl+Fl62Bo8U?=
 =?us-ascii?Q?iA8ARRnNNmHrBOwAhLnQ1AytQAYHCrSX/w7+ZkIRCHQhNROfGuFs0WzSjlOU?=
 =?us-ascii?Q?D2f0MGvjwxkQsNB+VCc/ujRS2KKwmi7A72+YEdh1zkKlTCoyrw+vh2HkeQHU?=
 =?us-ascii?Q?X8urN84Dbn4hQQ30OQjsZznnNaaLfUkeVwpw699trhwP4VNzotNfkKvggwvb?=
 =?us-ascii?Q?N0jgYSUFsL/0OHgahe4NHfuiuZrz/azrRYp4aPt2RL3VAz6cB8dwoIJ94FSn?=
 =?us-ascii?Q?s78PNEHoWMM00X7MaqtofF/3TMaN/FeyYx2dkLCNwxizLH822NizNX+on/PS?=
 =?us-ascii?Q?HgxOSgZUiHYTzXK9kRpFdT057Ni2LqSGCL7x5WqDft1SS8SYFWydKvkT1RHQ?=
 =?us-ascii?Q?U8pDAg/SM4lSGU5SQMJ1h44Q0sx4i5AG3yU453QBqjnrq+g1DksuxwTqp7K+?=
 =?us-ascii?Q?ktgEisomVw173kqlTyrIwMMvkqrivZ7eKsxM030eDzJrwd/gt6Dixbyiu8vU?=
 =?us-ascii?Q?po+FjKPD3jC/cikcUwS1G6QQ+Za2amol/HuHTfCTL5kjDPP1iq7mt05nmMO+?=
 =?us-ascii?Q?uHUa9ElFCZbOQ4jMSP1jb5/t/W9e8kVtysBFYh7T/h3A85ou+w/qBXqfKqiS?=
 =?us-ascii?Q?zwIQCGG+I9MpMPqPcfaZv3m6/6e/8KG8v5BwYdtbOP/n27xr3252hyG+xsTv?=
 =?us-ascii?Q?hsnlJxNL8pkiJEwQkolI337TwBOe4A9xczbFr9eEKa3WnBMgl/ZTK8yDwKCe?=
 =?us-ascii?Q?QBITk424qL9HBhtdFZVNP9x3MYhpOcxGfhk+9T9YZGslTcbx8+4jIkH6FBgK?=
 =?us-ascii?Q?SYTAfkZoD2BS+Rv/GV+CPc0CVMfmnUI2OIqw//6Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b6ae65-6c5c-4f96-11cc-08dbc9964eb0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:39:20.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wdh87vkZqCKvKbb4/17S8M6Nz86yjOLxztbeJvxydduU4RnyzdKYXbk5Jn3jV8Ni33h24TfxTbvj5JxvBih6Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert NXP medium quality sound (MQS) device tree binding
documentation to json-schema.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 .../devicetree/bindings/sound/fsl,mqs.txt     |  36 ------
 .../devicetree/bindings/sound/fsl,mqs.yaml    | 113 ++++++++++++++++++
 2 files changed, 113 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.txt b/Documentation/devicetree/bindings/sound/fsl,mqs.txt
deleted file mode 100644
index d66284b8bef2..000000000000
--- a/Documentation/devicetree/bindings/sound/fsl,mqs.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-fsl,mqs audio CODEC
-
-Required properties:
-  - compatible : Must contain one of "fsl,imx6sx-mqs", "fsl,codec-mqs"
-		"fsl,imx8qm-mqs", "fsl,imx8qxp-mqs", "fsl,imx93-mqs".
-  - clocks : A list of phandles + clock-specifiers, one for each entry in
-	     clock-names
-  - clock-names : "mclk" - must required.
-		  "core" - required if compatible is "fsl,imx8qm-mqs", it
-		           is for register access.
-  - gpr : A phandle of General Purpose Registers in IOMUX Controller.
-	  Required if compatible is "fsl,imx6sx-mqs".
-
-Required if compatible is "fsl,imx8qm-mqs":
-  - power-domains: A phandle of PM domain provider node.
-  - reg: Offset and length of the register set for the device.
-
-Example:
-
-mqs: mqs {
-	compatible = "fsl,imx6sx-mqs";
-	gpr = <&gpr>;
-	clocks = <&clks IMX6SX_CLK_SAI1>;
-	clock-names = "mclk";
-	status = "disabled";
-};
-
-mqs: mqs@59850000 {
-	compatible = "fsl,imx8qm-mqs";
-	reg = <0x59850000 0x10000>;
-	clocks = <&clk IMX8QM_AUD_MQS_IPG>,
-		 <&clk IMX8QM_AUD_MQS_HMCLK>;
-	clock-names = "core", "mclk";
-	power-domains = <&pd_mqs0>;
-	status = "disabled";
-};
diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.yaml b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
new file mode 100644
index 000000000000..c697b97f888e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,mqs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Medium Quality Sound (MQS)
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+  - Chancel Liu <chancel.liu@nxp.com>
+
+description: |
+  Medium quality sound (MQS) is used to generate medium quality audio
+  via a standard GPIO in the pinmux, allowing the user to connect
+  stereo speakers or headphones to a power amplifier without an
+  additional DAC chip.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx6sx-mqs
+      - fsl,codec-mqs
+      - fsl,imx8qm-mqs
+      - fsl,imx8qxp-mqs
+      - fsl,imx93-mqs
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+
+  gpr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle to the General Purpose Register (GPR) node
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qm-mqs
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Master clock
+            - description: Clock for register access
+        clock-names:
+          items:
+            - const: mclk
+            - const: core
+      required:
+        - reg
+        - power-domains
+    else:
+      properties:
+        clocks:
+          items:
+            - description: Master clock
+        clock-names:
+          items:
+            - const: mclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6sx-mqs
+              - fsl,imx93-mqs
+    then:
+      required:
+        - gpr
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6sx-clock.h>
+    mqs0: mqs {
+        compatible = "fsl,imx6sx-mqs";
+        gpr = <&gpr>;
+        clocks = <&clks IMX6SX_CLK_SAI1>;
+        clock-names = "mclk";
+    };
+
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    mqs1: mqs@59850000 {
+        compatible = "fsl,imx8qm-mqs";
+        reg = <0x59850000 0x10000>;
+        clocks = <&mqs0_lpcg 0>, <&mqs0_lpcg 1>;
+        clock-names = "mclk", "core";
+        power-domains = <&pd IMX_SC_R_MQS_0>;
+    };
-- 
2.25.1

