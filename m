Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8024752BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjGMUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjGMUuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:50:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D648CE;
        Thu, 13 Jul 2023 13:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKQiuV39k6LjkXIg47A4VsxfVfbTT5lRQFcnVMmQCfcpwyU9I4k88Dyz0FgQaWLMIFhM4EJqFKgGUnZMjrlhItQSk6GNyxcPeDNlMK6pdytzO8YNC1KW0AENN60VtRxJ9GBPDI5c9M9/63RAXqVXsxrVjlh1gcWguBqPvOXSY4WIhIS1aVxBjIZuNgM3n/FAvphcMSFptGYplvfOMV9IHNmX87vR7+p01V75oDjqDLtBKjX9p3EKGbhUqVyBWZhLuKiN8EP7QsmI0AF4cNGW9Kia5SK3bzuiRNKLJ/loqWAOqZwU0JY9dsb7qHGTfxI8ta5jX4Y65ID09Q3ixXBofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xvILuE9OtYpuohp6RuCQD53b/yyqAd109GFZiDqHqo=;
 b=YOocdoaZneweYxyI/jyfz9Lk1G0OIOogR/+L241FSXiweiEBBJ06Tgh5dmJBxqX2uEmG9OGofO8xAOagB0O0ZYz4j3GfEZHZ6M2ucK5sqLru/Z2crmvDfsAw8ySWb1oOWftJT4jxH7+L9dQxDEpWnIn9gIyFZgczJMRXb1gFoLlWMmICm5jpgXSDJ6Ut1QRoRG6XlW2jCxJEDG2/UxzTtQslc4NlJPMWaNGsjmr5DCxT/9yiVF0XH+S+4l2LxMXcjG6awfEzSCR4z5hjiURv8Q8ENZ21pyCIVsQhyjgd+poVazg7slun/EVIYtThNrqKbGhvM6ltL10nFr+EVyNi9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xvILuE9OtYpuohp6RuCQD53b/yyqAd109GFZiDqHqo=;
 b=lpRHTVQgfq2UspxJ3pT0oQuO1oKQ7WRUmdDUWmG+lz+6T1DoqGhL5hwuRIfT3KPMFLTHRdnJCYp/lhdgA5J6vUlWF73KdY/0XtYgluE+nm7A00KVFVYOZ1Ha4VfSxoUZtVsTmgA10uMa0AY8ptPJi3q5CgJVrRxr6oBc36fXqD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9731.eurprd04.prod.outlook.com (2603:10a6:20b:654::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 20:49:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 20:49:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v2 2/3] arm64: dts: imx8qm: add thermal zone and cooling map
Date:   Thu, 13 Jul 2023 16:49:30 -0400
Message-Id: <20230713204932.1591255-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713204932.1591255-1-Frank.Li@nxp.com>
References: <20230713204932.1591255-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:180::43) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b4ddc4-bd7e-40ca-070c-08db83e2b74f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD1litjE4jtGp8RrsLPvi7l56KVvDUzDreCJp79MAN/0jQQ/NqdCgNExKpwC+sWxHj9hPnNgvvNueri/g7LnAMThHDCFs5gki2YCEQjPn0/NBxDvjRiNjSdJtv0eldBJGSnfddNrLQ8E2mkwaNDCF8pS46yzVYV0XtYIgfFf0EDCiprNByzlwbREz9g2rpHXysGI1ZPuZGlz5geF1+gwgVO+Pj+7w3O0sau446QYEMsain/SzBnyTU+RVPqiMxe5LRP5OMPF7/vs3UDAzuwFRzWuO8/+ZjdAsHp4xaW2BNeiubjodaW/bNwOBxGwSTqsQPJOjJwmD1tc2gQ9NuJGbKEQxLyoEsim2zhO0k6SDU432HPD90yjvYZDkVQ3+e0vhjxZDP3AvGcoRPNehbWs+q2G3Af1J2aO6IWMcMifMLqTBuAbsoxqnOWIte0VUTfAKoS32lVslj7rSFZWhI9bMh25VBV9rTbzmmCx4Y529hc4qNUI39izZOq8mjGGdD8jPcA6BQWGoJU1fsCZ/ZYs2eaulS6j8Gn0wIHZCP8ld1a5GDVPEpvJsZ41n5nvo6qEV3zxDF6NxE0vvgm9RReyI3hzz8lugDY72AW0mHvvHYd6OCHhsxmcFmpMq5Wq/jQfqidcrFEsYW6yl2AEpBFGm2Ta4YcSaGXMa4mKrMuZBe8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199021)(2906002)(38350700002)(6512007)(38100700002)(921005)(83380400001)(2616005)(1076003)(26005)(186003)(86362001)(5660300002)(6506007)(6666004)(8676002)(36756003)(7416002)(8936002)(478600001)(110136005)(52116002)(66556008)(41300700001)(66946007)(66476007)(316002)(4326008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGRcXbQwowf3UoyVsNdC3c9wrAQ4hMcUDnFW7ZUmuS1sE9q8F5k0dIaK3L1k?=
 =?us-ascii?Q?z6g8Vks39Po9sDKQVQJlLdmBZg1ELIovMdWwmfY2y2YMfYb+wi9o8GK+OJTz?=
 =?us-ascii?Q?a1L+ImfOds6a5C+EdfJp+CS66JmhPB4cnc04mgszAxpXUB++8YLNsWHRXLIb?=
 =?us-ascii?Q?KtUSL9kO0jw4SmESJ/ophzzqNDcao2FP7Q95GbgqWquSRwkjeSW2BWkfS7Nk?=
 =?us-ascii?Q?A+r2tIXJfmAxYIjxNvQBF1IaAYbuxVGxADg9W9hF5bR1E55oP1v/b3t5NDkS?=
 =?us-ascii?Q?AHkmTuCe+OuL8exEQSX9EEpQkjci1+qRQvoK6OT/3zUhDCUbN0g66IrIwHnj?=
 =?us-ascii?Q?HNQOeSE/TCbRXMr/ub77+UcToFE5XUeTByxxLOhquZhSJbl9dOx6HtmSWxmP?=
 =?us-ascii?Q?j4W9riwNZwq72BqukpG+IwL1sQ4GqNOSR6RRtylY1hByVhBbit4shYOCkpDP?=
 =?us-ascii?Q?D6Bod5HdV4vgSJtYgK/Hc8W4oBmSDxwgkZ3tqsQ84q2K7yibeBd/epBYfh/0?=
 =?us-ascii?Q?Y8RspFVpYh1I+3wEh5GB2qFmqe0lvdKQIhLBRj9PwT2ZAcVFMMTKf50ig63Q?=
 =?us-ascii?Q?1UEuE2eTfvN5k9DA99vLbskqttgPrCQ0KYTQFx2hscXuk/LGnUDyPn1q9M7a?=
 =?us-ascii?Q?xnpF1fkkgUo4XlIz/wGb9p7ZWDRbzP+a1Vf69F4gqnqwJEJSPS3NoJW8mQTv?=
 =?us-ascii?Q?K+bLdOZxAZfW8tTDUcFYYm8QnlOZybpJ4VU8iA/We9+I2bJqB12zgvXVtJSi?=
 =?us-ascii?Q?yPWJXSdUyOZERw1stSf8pzx0aCiPPepyimCiBEzAu8zygQ24P7t94ub+Sk4y?=
 =?us-ascii?Q?YAI/7ao2KQhnb0dh/hKmgzL6mfI2ifuUvDGXwcBulqEWtoPhuVwxU9ho83DG?=
 =?us-ascii?Q?y8YcDsJYvRp48QQWEPAp2fo3M+fmyY/Bajls0TKZTmAkq7Cw8gNUd5MhR+oO?=
 =?us-ascii?Q?lbJ4KoQP3ISLVvi/1+O8cBjgk9vELCfYbcmd0MDnuks60j2l3Sf9lpbbbBbZ?=
 =?us-ascii?Q?Y+DKiRqrxt9l68xm8siw1m4u0+c9XZ0YVLqUVYboVjBKERJWKjrscVGBenve?=
 =?us-ascii?Q?IiH6APIeJhnqwPXsownt6tt/7/s0fI9Yro4uB5qPZMifC2nppTg03XAhb6aL?=
 =?us-ascii?Q?9V5Nz3tJ8G7OzDzBoNlXaFT9gj5D25KGKvlIJghfbfYDG2KMNxPeV6tdYfht?=
 =?us-ascii?Q?UctSCUb3P2tl6as5ow5MHEPHY2RP6Ji9GEjAcb+5ZNpYR/ZaIfGoUiMHl86K?=
 =?us-ascii?Q?O4dokGh85OaPyyFj2pYRmAD9zZcNt429bFIB9fyyZx68g8Rr1cCFNLRXgyn0?=
 =?us-ascii?Q?ZzI4jd74UuyRzF5TzR+JrDcNaDn7omtexyYH1wn2uovtb3PxeeXXVT08u5fY?=
 =?us-ascii?Q?t0kq9GfOqlis3WtYAeU3iTsxs6ZPVi1dOU5I/2ftvOGTM1xVrro62o/dJsek?=
 =?us-ascii?Q?29k6oZqptk+Q72grxQ736EYxHWTpQI913UFNI6Ll759wMDxNktupjCZ3mEuc?=
 =?us-ascii?Q?HyJUYU5KIX94HW9G3SX69cdDJIbAk60YfBVE/Uv2ytBpDMbZGsE++gI8VKxz?=
 =?us-ascii?Q?5C2tx6V3J8b5biptpd782MuYdROaxFB+buKqYqjn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4ddc4-bd7e-40ca-070c-08db83e2b74f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 20:49:56.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnutPFqlaBfzHi8EHBFa3RNEgEG6mqU/KU+Fyn9YkVPfADcLBWa9jUUaql989UXepCiAQb06yz63khnqAlrVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal zone and cooling map for cpufreq.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- pass make dtbs_check
- remove stray blank lines

 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 134 ++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index effd84ebade1..0e425df1bc4e 100644
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
@@ -284,6 +291,133 @@ iomuxc: pinctrl {
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
+
+		tsens: thermal-sensor {
+			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		cpu0-thermal {
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
+		cpu1-thermal {
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
+		gpu0-thermal {
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
+	       gpu1-thermal {
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
+		drc0-thermal {
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

