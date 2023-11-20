Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242CE7F0EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjKTJMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjKTJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:12:23 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E08210DA;
        Mon, 20 Nov 2023 01:12:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF0mE4ae0bzJhmsxUpVNo6CBy7OrDacxyQZobDhQBlQC7WmcdhIPnwL7QVl/CIjL57qnEGmumrS/fDl05zg1p23CdOcjeacdilrYWz2CYfx4bYQv2f8vWTNAMNX8Yi7VH83iQiwhiFI0yKJClJmf2pZ2H3RnXUdcTMIkdF9l1hUt7RPlBLuFjuHMcZipK1hIwkGwS5qy8YuR10EJfhIRGyc+/+EoDDk8dYvRpsefvTfKP7WtSrfgw0U33Bk4b5e1DsLn5jP9ceGqUqNJRsq8y0xy7H6FAux+BbqITbIZbRGEkMzXKLRyPxFQiIuvKkf0X3aemLTShgqxDd0tHBNwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luGc91YIHm7PJu1Sq2eBjN9Ud/issUKfZURg3+bsFtU=;
 b=f6XSBH9BmM2mlRcQYv/cZL0M0cfAr6rU05JxQ8LycmNGmU/2ZhAnrsi0hhTPWQh9tko6DKwPz/wUTwELQ9QVNwF5dsD3NPiRSiCpnBVfqr5tmDfDYRyzvk05BpdHlKHuWMvCp6MGULL3ZoXuMsC3LkIjlY188AaX7Y/F3WvRGna0WWMUv0k32jZomuXN3ERMo7hYbysRyLGwmLmocxxLxv0hB8qNOyXJ9SOeB735wb17CYC60U82BnX3BYWuqeYVNSkMpOmXNtdj7EAJL95bfoY41Pwjc5z/QlHpmXlaK48WT40wYR9baksgllrEw3A9uklmy8ik4/pQ5klew4y5nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luGc91YIHm7PJu1Sq2eBjN9Ud/issUKfZURg3+bsFtU=;
 b=qm7JjqlGIGYskyWQMtrvBul9vw+uzPQZmYUyUzvA0XoKrLAQIHQNouXOT3+JS3UdE7K4J02r/ST8TrNo7ws2zJCfOSPzrPVOO0td9cQQjuvUrDR3iDlKk7iungAAKndG06MQTPshxEQpFMBWMELureFlJF6AQRUmyTJTTCMNirc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DBBPR04MB7563.eurprd04.prod.outlook.com (2603:10a6:10:206::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 09:12:14 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 09:12:14 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [RESEND v2 3/3] ASoC: dt-bindings: fsl,mqs: Convert format to json-schema
Date:   Mon, 20 Nov 2023 16:49:05 +0800
Message-Id: <20231120084905.664-4-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120084905.664-1-chancel.liu@nxp.com>
References: <20231120084905.664-1-chancel.liu@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0052.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::24) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|DBBPR04MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2d3cf2-bb1d-4f83-7ef8-08dbe9a8c94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxpOcp3PnzCGwGBxCZL2v5/ElSjMoRtUHZiC9LfeAm5VkCZ2p71R9iAXWy/cwLtc2m1bqtXTQc+geMXAGuSjf5auxNJLuvPHD80r5MT//dUJDabbOFHXAmAbkj39jBcNs4ZS/QyWM6r73/uKqQ9GL+Sx6lXaxDeu9YIRk64QFH2r4nN76NKpQXFpS1yxX5BAXjbSf7B1GuuDYyrUPGyg2yzUsu9YiqyEEqYNPRyUnKtzzDmt5wx3TURBT8+j/y1jIv/v448JUVcs7TNSMdPnJ2eS1TdSkyXC7VsTLs98q5FcTPcmwyNZCFxQW04//g/cIMVp2Q78/hH4WUXbGwS7K6cghcLsf5ayuhGHVui3aZawBZ6e4/uAchOdB2DwGaRA4QlzcuNAN6j3NhfaKzOm7YnoTuD3HPAw29mRWTgmEANvMlIpe7bAtTSwHgNViPymmRlHOF7W3e1WBTKTyhWjgfxhmiHdIA2vsJMS7KYHYxmHU5AnUypoCaXmRwvbEg+1LxmBjW3et+dDU6bApsnT1DnCojCnqYDAKMaOPBvfASl0oRSsHcsQk4keC1ssgVcngB53DmOIMgN6EW4clsUTjJFLTTOpdUnLcah6rN+e/3VbBHFEjEOjeXh+V5nAwIy8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(5660300002)(1076003)(2906002)(26005)(2616005)(4326008)(8676002)(8936002)(41300700001)(86362001)(44832011)(38350700005)(921008)(83380400001)(36756003)(66946007)(52116002)(66556008)(66476007)(6506007)(316002)(478600001)(966005)(6486002)(6512007)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/xB7TFDSLhrwawEQMw1LUTzfxiisCWIHhOf340Bv58ZtWUXDBIS88qHN+SH0?=
 =?us-ascii?Q?Su0QzruPbK5VVd2MF3frDIUFGQM0+En4wYb00Epb6eNCRxODhQ+OhHUqEFoC?=
 =?us-ascii?Q?X7l/JGjV8dFpxqt/iqumwZWTXKS5bnxont4fs/+MtseopSZDaJgOWC82Zl+H?=
 =?us-ascii?Q?+5hQuQW5Wr95mB843+Prxct28RLwhHUy6YoYwEDf/wiGAizLw0FIWn8kX2jE?=
 =?us-ascii?Q?lvIyfCFXPAYz1wHImYPmAaZzN/6oyTVXrb+fhLiPj3rNHNkYONB6lFOusgnC?=
 =?us-ascii?Q?jeFpukXCxz4IgqDWAwDPq1QPb60+UxNRw7+dhRLCrKqcf1wKbEfrFeHPiDcU?=
 =?us-ascii?Q?fvJzqTlouAuNFtdFe4awPDKi+wgS0vLXcm94NZiOopkRNcoCm+jLOMEmqb9k?=
 =?us-ascii?Q?2Q+HMra/d8U3nBscvhc4OymI4jdtz9ceG/Joyxgig/DHjPgUKDkaykMykh71?=
 =?us-ascii?Q?toDENTUttCwDztFFe+Xp7AZXCmGXByOGpQqPHc31jbOyqQ9pn06yphEk8eRZ?=
 =?us-ascii?Q?KpLuxptCgcudbGs/j0GQ0qh1G0GIAIY1f3A288VqFxWcNUsIUWBXhkT6EpjX?=
 =?us-ascii?Q?eAywzEe6jU2eRGsH3ilIb17nGdrVcPfEnMrAGAjD+2rNCjqvdHc4ohsVIO+l?=
 =?us-ascii?Q?fkTaiLgRvLamiVtXb4xk1lajHV7MzaTu2CBVryeVCqzG1nfhOC4x4C90nboo?=
 =?us-ascii?Q?Dq6m4oL61y5Szn7LcF9s74fXB7FRIOzMDdwOeAXDjXp0cPrLqRLSveLAQVK7?=
 =?us-ascii?Q?fV7ytptNpAhx1sGMhpTHsG7jYHzQC7YhwfxOQsDNyaEknHQlruTwdoBXMuin?=
 =?us-ascii?Q?/X7t0O81BOfdEL63S0uSfe0Zi8FVoCgjAVcl9Cdrh+2X29RMcJbu9b7VNpXB?=
 =?us-ascii?Q?YJmWeqSEfEadOOl7x7fN6D4HOEP8/Jtjih24aiFEodiJyxFrnW+itccc/J86?=
 =?us-ascii?Q?EQ4/epPG6F053Ee/t3yigcyB3uAjXR89WnHt0nMq+zcjTs8DFt5/5wB0USp/?=
 =?us-ascii?Q?ooVVWGUuCq8nlFrpJcsE60KZVMbu63eegKWDmPZ1wIbHXjS/w2viLp27aYqt?=
 =?us-ascii?Q?wKm0xH4LYJftpnyl3j2NLv5GKq7j+7uU/phvo+9zpEReH6EHB9uVTcwcSgWp?=
 =?us-ascii?Q?7pD4tfFj4V+Ay8CIpcL0hO9ul/m50oAbufRBVhnSarccTeu27eH0Q7hVT8Z3?=
 =?us-ascii?Q?YdimM3wXRM5E19Z8CV11ecfWEERYBEnIoiw3pL0811OH6wMbhRt+ZoCdotjj?=
 =?us-ascii?Q?AkWXMz0mXWgcT/rReTaLSM+J0FgMQ++bsSQqVY1nY8W7PhwCA4SyKdrfvNox?=
 =?us-ascii?Q?FlwmWTIdq0+QoZCcxpDJR28KX5UZW3/w0WvTDwJ7/MtGU43vgIgRyfs6KGyv?=
 =?us-ascii?Q?IPnBddPqASOWNTkEyuqFI5t+0rhenDKfPGc6ByTn6I7H59exgQtBAbrUOKj9?=
 =?us-ascii?Q?iTHPEYcKi67gKns9Oc7TJwEwYiufaXNpnY9uzikbEvC6WBP0BtuReaZipw82?=
 =?us-ascii?Q?3YffKyUIrXZe1YxfaH1Kkgi5etnb4Fx+lizsCK/KaDktos+cLyJK4cohYC+Q?=
 =?us-ascii?Q?AB5J7y4XGzuWmgURg1OhOcikchcM53HiEx38LJzY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2d3cf2-bb1d-4f83-7ef8-08dbe9a8c94f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 09:12:14.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbuohfoKZ3rnPwhvsYgNiEyDgJuHciPCuZh7Fhy2wBk7P8iaYGqRnmGiXK7amz2uOqF4tsFeafnUNd6JGVwxlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7563
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert NXP medium quality sound (MQS) device tree binding
documentation to json-schema.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.42.0

