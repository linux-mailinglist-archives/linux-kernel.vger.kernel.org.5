Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E77F4426
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjKVKmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbjKVKmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:42:36 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E92D8;
        Wed, 22 Nov 2023 02:42:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3AR7lwBs5WbKm5onKP1zMUs/1vVy+xbeqxF54zj2dfel2Gh4fMq6Sh7XxnLPKTkTvM1uD/Eh352528P0NdEJ+aoIf1pBEUAU0obfP74woehXMXUla6Lg4FuygkG6EGcTA/ioWsE2MTuFTHV7HONeRbTNuJEqTsLkipmaYtOh73PN1GGsOF7CdHcFXelBZruhvTHHu6oxiEMcEYgZCtc+E2tZ0dJBHCqjBCBCqLModgNMbgtXH8ZGQUyfSAUF+afCJosJczEuC8ZsOr2CQemqJkTFC4wYWtJ0zSHtGUFll6ey3Z9oQB65BDr81zf7/gY2nO80Vr4cFvt6eIXuYCNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKO81IDu5hS4rxZyDV+Z+W/4AfsALN9cBXBa0q56iwI=;
 b=jfoSG6iB0nfAt1TFWU/rEJk3tK6x3CBuDftZmexTR5cmvhAmqRsMCIIeV7kq77ButPY8qmJRRLnFwLuD9Xro0Vab3KDht1hlaw9EiPwX0NeV4e+CI15kpnjRzkfiArf1L1U5DQX0Z1pxlyOsGHomwcnbirkJxrllK+xCmcu/DTcpGwhVolv/QvYk63fYEV73Wkbs1wCqChtd9JVN20mZA9Er8GT0/I0vEuTzMaMyUF3cEDYxL+OTKvQQAWmcOh3Nj+Ucfu14bBVV29Jcb6iw0BKj5Sz0o2uMWpiOWhoX2NLgUSlf9xuru/Rl8NiY1ygbd4DW4LdkE0seSnCqRW4hSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKO81IDu5hS4rxZyDV+Z+W/4AfsALN9cBXBa0q56iwI=;
 b=KcGVyZQu/FVNk6CEckB9lfSbD5x7MBS5FrmVfXgSUItXmFyVdsp86XBO3fTMM7BreJEnbddj2zjFEddBB91JrSELUGFbMrno4RtgbhzLq+Yd5+uouJH6nF3P2vnFIxSrDB2bO7mbUxHWHILtKOKE+qNirMvd1G4SCTo5SpioGHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 10:42:28 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 10:42:28 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v3 3/3] ASoC: dt-bindings: fsl,mqs: Convert format to json-schema
Date:   Wed, 22 Nov 2023 18:19:59 +0800
Message-Id: <20231122101959.30264-4-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231122101959.30264-1-chancel.liu@nxp.com>
References: <20231122101959.30264-1-chancel.liu@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:208:69::15) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e93007-0548-4cfc-af04-08dbeb47b8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuskfYUGlWYm57+dG6wOO6AgmNo0UEaDqGL9wY7Zcku+Jy3YDc6IxrGHfP4x3K+GrN9Vrw2xV1MnNKaAmc6c58np48hEYd9wJ4vGCZk7fQIDW/8nN8GeXCHzwp/Ex0stzdWJlPrf0yzmKBH8KrE35+wgaHAeRx1n2Eg0IJDVckeMr4uFIzeZBdYtd0aE3HL7uCnqJVFDAaK/sb3VXay98ce5KgxKX3a0mgt15VuU3SWf/C4n0XcvsS3yYRDmGfhiIRTFI6iJFo44Y1IZt3CMvJPiWddAtDqggCK47mZQuub/mGNatdJqJgWV6+4U4fPLolE0/kNCrd89cFUpa11IC6bG6NccmEGiVRFxao/mxf7/0vkpFq42q9dnfpDuFZ1UOAcoROBMl0ULx7aO+lvQYw/p2tPTvN+vmtLIFh7TnLEKPtfh/rpBTWqH1uIPzezFz7sIHak2c+FbHFGuj2wnyd6gEgOrgP2YHWAgL1b1oado5gsBzXu+TKSh+dqMFiymjI/+wgQXcPxvgsqGHYZMujA4I9HiH6G1UFJGBUYh7ua3MBSL277zDUfruVvBvsIa8EFFz4aRIijtatO/SMkpuqHXaiJPvwbEyPWlOrbNXXYHbBchpDTh718eaSLKk5WV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8676002)(66476007)(1076003)(8936002)(966005)(6486002)(38100700002)(4326008)(52116002)(6506007)(478600001)(66946007)(6666004)(66556008)(83380400001)(6512007)(316002)(44832011)(26005)(5660300002)(2616005)(2906002)(36756003)(41300700001)(7416002)(86362001)(38350700005)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gMkOExz2WWRjcxOn0EBPR5wXqKowVk2qoQa9fTAy2kwdB3ooutLUW76jM5Zk?=
 =?us-ascii?Q?SjbrIHAsTSBO02ag4IFdHz4yL9rxu0mtRw+plrmBMGZc3lywgr5TxFoEURmm?=
 =?us-ascii?Q?RGKGb7l+sH7oLho3tlxtJ2enn8/A9UU6SwJNtC0g83PAH7pqxriFFEw/i++c?=
 =?us-ascii?Q?LYzQjRsrdXwo8TOjjILtojl3TopfINLMrxAhom8Tye+qHHpDN6dphwKXEzi3?=
 =?us-ascii?Q?uk4hGahkHH1k9Ajp19fBsuQRAKgYgB7Bdrvav87o+n3+9Cf8lgD4pSATnXGQ?=
 =?us-ascii?Q?N4BVll2tnzFgojuDy/ao+TV6B9zIs37fkEh8jccN/0ZoALOnZ4GJD2UvUFu3?=
 =?us-ascii?Q?5ddXQpwdVHXdd9nxOkgihCy0F6ZsrZMNZUKswIWDqyZH1LjI8LmnUj5CtCOf?=
 =?us-ascii?Q?VjT9Rl/o+D8F/nDaZuZr4qHYW1S0zZh+HPyrLvINx5vNeKVIbHJK6w/8Y0ix?=
 =?us-ascii?Q?eQYQuM+r3fEZtb/isMC67xwuUURgJHUmvK6uTfANm1FOGuanBPy4OTE30Xz+?=
 =?us-ascii?Q?5LoUbsbgZyhMHtTTW1r87gpaeYjr0RJj/FoY0Oh+yH4e688w4BfK7YZt2Glk?=
 =?us-ascii?Q?eLkY0R+1/2lYgDkMCjdcbgTK6ixso+GT1u+njeSeyOachO62R6XfhH/SvALp?=
 =?us-ascii?Q?O5YlaJAei991fv6EpjbQpotF0Syyx0/4hyim673e1X46CccE4XSa0EvkNKmP?=
 =?us-ascii?Q?prIMBmBNAc9bT24izvR9OshK12puuWIbtmycHqfQZ4OHXbx7jVbLUQxSQ5o9?=
 =?us-ascii?Q?cqZEpwi7Dq/kJ+uhhOYyWkN8/1TE+lZv+/0jwS8okpitreCmKF7boL0KqXYR?=
 =?us-ascii?Q?V6rOeJf1zKgXVgVJ4KVPK/wZpZ4gJ7iInJk5oKmUwvUN4poLppjf+A2+hAZN?=
 =?us-ascii?Q?H6l+roJTPHbsw8Eams68+9noXCpxl5VBePkwFAhl8bpaHx0uF0wIMYZ2OBuG?=
 =?us-ascii?Q?jITGurXPrtfRa1P7IEGxI3tCC1KqiURUUppWoSkg7BpOqWKBkdWavMEj5HJ5?=
 =?us-ascii?Q?F7gYbQ4+I5RyBJUJBDj6isayTaAw9hXo7Gly8ysmdBMOTxgsk0u8qY1P/mjH?=
 =?us-ascii?Q?u9fOWg0GHBB2qJzX9RERHdWEqBQwqwQ39lhC8yrJghYoqASl5R0PK3tvjZHq?=
 =?us-ascii?Q?ukLHTbFim4o4mR1tr7Ilu/aAlZV5qhusBcuY2OklIZebmH1aG5LReKJT6jjf?=
 =?us-ascii?Q?wULlh511gSdOwCDMTuNnGExb94NvG43rIF8R1TpZkUD2IVbT2Mm/f2AvCN/z?=
 =?us-ascii?Q?8sghlImeDtTHjaYVZdRYHN1P1zrq/RisYlHAjzi37uZ6jMpLMpDAc3rvA0qm?=
 =?us-ascii?Q?0kwO6yHGTkU0uKntBSBenhXUaVWlyjxBKcxJ/0XU8Qdi6l8n2rHTo/iTAAB3?=
 =?us-ascii?Q?5erRd8DQTQxrFIGlSNmQxTYOSb/vaXieZ0seWkAeDwFMWCCyBcuw0JS6P8Jn?=
 =?us-ascii?Q?d4PGJ0EgrnqccPvP+bQB35IPZyLdFiqOWjGV9t5Aqq0brrp26+DMZGnEBQCM?=
 =?us-ascii?Q?qcOVmL9M7Sqh0DziiM//xiSGmQlwp0kfsaC9I2jQ2F80ysa3KCL0dDkyRCO3?=
 =?us-ascii?Q?dHxUfsWs5tLxRG6DeaFfoB7oNY7cvMdLQYpYrvOY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e93007-0548-4cfc-af04-08dbeb47b8b4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:42:28.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seKb4RU+pR1jsYekqynPSv+yj8KegFl/LN2A3eGOE7VUf/FHg6CULGOGBEa82E5zelMU2EsV4suLbllGoF3kVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577
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
 .../devicetree/bindings/sound/fsl,mqs.yaml    | 105 ++++++++++++++++++
 2 files changed, 105 insertions(+), 36 deletions(-)
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
index 000000000000..8b33353a80ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
@@ -0,0 +1,105 @@
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
+            enum:
+              - fsl,imx8qm-mqs
+              - fsl,imx8qxp-mqs
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

