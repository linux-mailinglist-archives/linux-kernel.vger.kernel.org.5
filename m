Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76B7751284
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjGLVSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjGLVSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:18:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD8CE;
        Wed, 12 Jul 2023 14:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8trrgmdokNSbT6aDyYNRmLqWh9qM8t5+Q3dF1VYEIPpoaP7mv6R1wVBhjtoR7JGCF4BnfMrBJBECDZfZKlwT5DUO//qNlbxFdP9zUAw7CjTQ4hHXk2Vje1HiLdMK/x16ZwrFi1BuTTmHriTs4YQgw5sbVBCsvQ8EPbdV0LPoyhn/2SejdOLimfCSP1Oi6n56psv0oJ9vM57lG/E29+VyNLn+x8N6PNw7g//qS3qL0GTQol5GquPRrBgJfHe/fzrbLFLb3+Tay9RFr7uYl2HvZUjdu9HpQEvoK1aFMUIRoURP00Jf8YvHkGebr+yZ+xG+5ZD9pyBseTMLRFmzk2z1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fQmA4y+rCcxOe7OWc6ZXfDSbY0scnrz3oQamXVaYO4=;
 b=So1s0kNolNwfaTgH8mUE0dyvJ1WIXGFCUNUIAdVPCS5Hs9sCdxSvtozHvScC8or1YxlG2TXbo95tJrp4F+fvYvXIC6aVVrgZGWalaWjLD1rrvMiacuA6IBJJYMWGKbHYes62vMIQIn6gnN3zraWmdEpXCDN8S/Frfz4unDfWK4FDkVlfOe5zb4bW6Rc2dx6sWQKEQ37yBIr+sKFYMXImcKK3S3mh4WHSEuI9kJEZIi8WOX2bOPBLNy/OCo9367WYaLpETPYUluQMgqK0/b7XKCJPRQTV+jRoWBi/d0vLBJJGchV15nzZz524WnL7LNtGK2j/1KtdPRDRXtbhDf5Qig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fQmA4y+rCcxOe7OWc6ZXfDSbY0scnrz3oQamXVaYO4=;
 b=erE1cXKOjPg27m4XqnFyGbJC60v+m4K0FZPZNA5lx3ZMtnxfC097AY+9U9o8Le905Y8zeZlzsFxAm8WgNQazJYKedlXfJ8TnMoxvRSBBr82p92Q7smb/1hfOltTHTtV4hGqyY43wMe6qvcW4Y+danc4kVyN+vRFOEe9UWupkKrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9187.eurprd04.prod.outlook.com (2603:10a6:102:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 21:18:19 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45%3]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 21:18:19 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 2/3] arm64: dts: imx8qm: add thermal zone and cooling map
Date:   Wed, 12 Jul 2023 17:17:53 -0400
Message-Id: <20230712211755.1538847-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712211755.1538847-1-Frank.Li@nxp.com>
References: <20230712211755.1538847-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e98674d-b546-43ea-a9b1-08db831d8418
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHIgwfE4f7wu0U2KZoIObhfYZE2Ag2PA9/r08NjTMuvkp32+ki884HCcpgYRGYAKH2nkLAroJJ6sS5vsPRSoqKa8QKbJNl34FB5TtwmTOpqF3Uq/p/xWTzFBXEnMPQlZQ9qBvcl+XBbxh2cZtxD7ss6nIwgwUXxZIPzyYf9rxXp3o8jfcYQj6zzovzGNcgtxtmeIDYdLgDYxYEwxm+q3gLJXMd88jcj8+kYApPm9/XtuxeLhek5p/bgNh3m+5RLNMo8wZjOcLE95i7HDI1WEGu7ahuCaI89rz7wFn/QDgXFXl0RxhMYB1qa1K4jyMLfnz+yG6DQsj9ykWPrM0NNAAhVn4mTYn8NsxlhENDI7GB9c+cc0DBEa+ZrGltH5yKzN4kTdgwsGlgz1MscypvdueQ3X4WzC/ni0Vd+3TT5Urf29eNPPXSF/WtomFh7QCNOvovlFGhHwGCILrrH5R3+kYIq8K3YPmg7imXY6N4nX1tQRNjbjMTBkATnt9OC5iGqCio82tZmkmpRmOyxTc8ohLHGgP1XRH7BeBUxYnF+iicIHtB3TpLLCoBOylxpTXdigbUsx/pZGey42Xs2wRaf8j1g+cnRVGAilYsozQM17/Kk4uhwCVML2EeyECMCHyxytNx9RKoizpbFNHl3lmK02yweaNwygdZafvyG6SeGKc/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(41300700001)(8936002)(8676002)(6486002)(6666004)(110136005)(5660300002)(2906002)(7416002)(316002)(4326008)(66556008)(66476007)(66946007)(6512007)(52116002)(36756003)(478600001)(186003)(86362001)(38350700002)(38100700002)(921005)(83380400001)(6506007)(2616005)(26005)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5wBEmg4rDhNjB50cSpKI2NsOSnAg+nM+sZ9Mn0OQVPVmKh4Mcuh9ZRVVixeF?=
 =?us-ascii?Q?TXaXir75mIg7hTAHrTgVrIuIBQUL6q+gZuA1YXMtgJHcOTfrDTCITaMBrrRD?=
 =?us-ascii?Q?DISRlfQ91FTF+RI6thb+UaEO2T5x3OGRykAr5Dki2EPEjdhlZ2l6H5KDXAaI?=
 =?us-ascii?Q?Cx6AQU5EL/2HFpB6b6D5SBwm/qiT3bS5wdq6ycckwjiz8eg5sEe51b//Gzwl?=
 =?us-ascii?Q?DD8W6+V3gwq5AToTTXyvGVr8/fDYXlcT/fvI8iRzjt9ag4XjzAtBj5OxFceS?=
 =?us-ascii?Q?oCyNWv3+HdYfC5SEUHGD/RdIfHI5MTwQuvs7XB3FS8v0sSTgeXj71OXn5s1a?=
 =?us-ascii?Q?YSw8tq3yBDDZueVi+MxS0PiDbIKrnoy5bLScKnRdBU6xdaZ92erO707Vm2i+?=
 =?us-ascii?Q?7ayT4C9SOlJhF9Yz/ax7RHS122tgAo4Jz4XEW+bzIck6lzk041QdHzWj+qBR?=
 =?us-ascii?Q?lavacHY/bGGTYad8MngW6tSLtUmQZq46EPE3KAwqO2czBwivW08rCI2dvEs3?=
 =?us-ascii?Q?/YToEgem2SByak4t9ZuDirpVREAbUYCKgFZqBYjfQZLbUcqJA2ia84GKO+FS?=
 =?us-ascii?Q?4skQqUaF2W9nNy0nMwe981UKjSmSnYEEJO4ebKWg/BU/zHBVnhqY5ig/wZjU?=
 =?us-ascii?Q?e1TJMvrI30qMCwEqA7+juA8c2uZItPBbwb+WFABqr5XQyYdj1lPsAX4Z7WAK?=
 =?us-ascii?Q?87uluOl5O0IzTt8vAzVTFe3UOZC8xe4XMjaHl8mYoS0+9Tv6IbkASXT5AUl2?=
 =?us-ascii?Q?X9vo97Uh8+tqGXLDP0/yn2xjyf6x69wZ3bslSiHZQJqkgTmND9Rq/Q2Nd6JR?=
 =?us-ascii?Q?78EP5+nnrIxTAS4ZfHSEQ5mmemyTDPtUV7gLhPS9BUrctiQMJ7xwGlQUm4eH?=
 =?us-ascii?Q?P0EFZKqlMK+dqgYbr6htLIMFCFRN0QDSAKsJ5fnTXXKrLyFiS5p/woD0b+Ii?=
 =?us-ascii?Q?uBoUvMFnotjl/rwA2ZWGqSYiE3tHjvJLBrrjaPaYoix/HVR2bO1KyTuCEQk5?=
 =?us-ascii?Q?LQAdnE0/W/vyJIzAhmBK7uRC65podNtywKWYlMMJzBVbRfppt+hTIr4SqTdm?=
 =?us-ascii?Q?ZoYVobOo+Q4GJvUvTXZ27s5mk1wwF49mfodLMEpIp372t3HhFOWXcj4x0gxp?=
 =?us-ascii?Q?eoHa4dgMdcECFUKOJIX1BD4ptfVGkmiLUNx9tpg2uiSnifQ6YgP+3c4uj5gD?=
 =?us-ascii?Q?iBJJxj+qL/DD6+6ntjquWbfZevMBIkstvLQk1WPMbHpqjtxqgR1pZ8hm7qGX?=
 =?us-ascii?Q?5ZqWw2urXrRyfrDNlz4e0ywGxJWjvaEuapON5WzhHLTIr6SPv98t8D4pUc1m?=
 =?us-ascii?Q?50wNaSh8qEWeCtph9VqFayDs3PkvaFfp1i+oWm7icQpwc51I/2zOGkJacRqe?=
 =?us-ascii?Q?VzsvPN0qVV7I9M8qEpzBahVouEKw+paA+sbqgljZdTYNG7OmBTvy4sB8mFsQ?=
 =?us-ascii?Q?1VPA79Z2fws8tmKIJvVmFklwxVnDF56J7uKcY0eZmqXwPpnV9S96ABhw1p9D?=
 =?us-ascii?Q?Uif4r0jbA/TZLHPxxKRWzs5kPoPDIbxeLeiHBTcAfNzwiNlxJSEmFyvAP1Jy?=
 =?us-ascii?Q?0uzqa3cK28Sm6aAVugY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e98674d-b546-43ea-a9b1-08db831d8418
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 21:18:19.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9Aj/2H7nAC0kT6up3y52KZrVJl/7UCPQWRflcTQTFf3jQw3FsBk3SO+bTbmZlvBP4guuVEaaAqop2jtRjaNKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal zone and cooling map for cpufreq.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 135 ++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 24508b84804b..30520186de83 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/pads-imx8qm.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -72,6 +73,7 @@ A53_0: cpu@0 {
 			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A53_1: cpu@1 {
@@ -88,6 +90,7 @@ A53_1: cpu@1 {
 			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A53_2: cpu@2 {
@@ -104,6 +107,7 @@ A53_2: cpu@2 {
 			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A53_3: cpu@3 {
@@ -120,6 +124,7 @@ A53_3: cpu@3 {
 			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A72_0: cpu@100 {
@@ -136,6 +141,7 @@ A72_0: cpu@100 {
 			d-cache-sets = <256>;
 			next-level-cache = <&A72_L2>;
 			operating-points-v2 = <&a72_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A72_1: cpu@101 {
@@ -146,6 +152,7 @@ A72_1: cpu@101 {
 			enable-method = "psci";
 			next-level-cache = <&A72_L2>;
 			operating-points-v2 = <&a72_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		A53_L2: l2-cache0 {
@@ -284,6 +291,134 @@ iomuxc: pinctrl {
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible = "fsl,imx-sc-thermal";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+
+		cpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tsens IMX_SC_R_A53>;
+
+			trips {
+				cpu_alert0: trip0 {
+					temperature = <107000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit0: trip1 {
+					temperature = <127000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device =
+						<&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A53_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A53_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tsens IMX_SC_R_A72>;
+
+			trips {
+				cpu_alert1: trip0 {
+					temperature = <107000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit1: trip1 {
+					temperature = <127000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert1>;
+					cooling-device =
+						<&A72_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A72_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tsens IMX_SC_R_GPU_0_PID0>;
+
+			trips {
+				gpu_alert0: trip0 {
+					temperature = <107000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu_crit0: trip1 {
+					temperature = <127000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+	       gpu-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tsens IMX_SC_R_GPU_1_PID0>;
+
+			trips {
+				gpu_alert1: trip0 {
+					temperature = <107000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu_crit1: trip1 {
+					temperature = <127000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		drc-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tsens IMX_SC_R_DRC_0>;
+
+			trips {
+				drc_alert0: trip0 {
+					temperature = <107000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				drc_crit0: trip1 {
+					temperature = <127000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
 	};
 
 	/* sorted in register address */
-- 
2.34.1

