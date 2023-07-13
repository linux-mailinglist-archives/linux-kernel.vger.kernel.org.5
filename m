Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054F7752BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjGMUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjGMUt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:49:56 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4D2D57;
        Thu, 13 Jul 2023 13:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHEID6fliIRYU5vByveVU2zKHZ3Yda3kQ0p7aH04+e/JVoi3WwiSrCYYZvE+h4YMyFHlGp2kUZmFdXvuYgzj/+HethWBI+KZRlus5oetiu82X5X74WY59OLhOTmeHssAYN+IUmNvaETJYYnA1bmdPrWeiUl23sNwG7JsCl8n3t5J5lSGd6q6D+X+SyXRTRVvEafoqtpRTHGRSpaccV9wte1N09FwkDWAcSTFLKHCk5U+/Qq2OvK3WD+0AKuqVSpPgFUyJeL9jaoWhLu57jSOXshXWo34v1iSOsX0mIRZatOEODlppXFPJBUfhNTCfSBtvAsMyz4OtGT9DxuPtJUnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mH5uFpzxM3A8N74L9x4HxyBQiRdMhUpuF/vJOLsWMU=;
 b=KmZxQR62xNAGGeIJ0B/qFi1xKL+/s61Qa92LSDC//HanBC9eZndV65i/I0YPPoFi8zumjUoWBPSNM4NloLoiX+Z9FDpE6Ylom/qxZcq3DE5Dm7pLdgjwgvYizEDyO4c7l59zg1ZgwqD9GU/qfcTIwfzpVP12BDJa2b3iErcX5VCimVToFrRcAHKiC6NpVBSdQuH5wmfpYp4TImTCR/h/dy5loo+CzcMc3QCfDE9a0JjsEtTDZWFd7h4iot/fQsxbcToQ4WkUjKBaQ1PhV4ayXn0BoA9yhAvAJO0AHkDPNh9vtzjuNvp3XqRMOtRd1NDtkuCZaOwiVs1dyYOFo2Xw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mH5uFpzxM3A8N74L9x4HxyBQiRdMhUpuF/vJOLsWMU=;
 b=IFAJ65rEHXxUlEnoQGP/L/xX6miMAHzX+GYbq2XIjdx0CpngUtjto7InkYZm4Aw3HIpsW8BYGcQlDMFo4IsRLjY2vM6PKAgP9CaWD/gX0jURpaH3/6lglo7G3jleROBsvSd3M4FN6lZpGq4eGd8YGkiTmZIwLwU0P7Z2qmXuMJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9731.eurprd04.prod.outlook.com (2603:10a6:20b:654::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 20:49:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 20:49:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Chester Lin <clin@suse.com>,
        Li Yang <leoyang.li@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v2 1/3] arm64: dts: imx8qm: add cpu frequency table
Date:   Thu, 13 Jul 2023 16:49:29 -0400
Message-Id: <20230713204932.1591255-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:180::43) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca19d71-c101-42b7-36e9-08db83e2b467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iD3CBSQVUeGAu2GlSxn7RmJbRarloMY78Y2V8ciAVnCyrKaX18Aqhl90HT1QD1SiwcU+6ooydBa/4cxil+GN3ATsO1YtY4ujLM2aIi33oE84PGInTibVJBvCnw7Kd3cbUvGvegeIqXwRYl9VH66hyV8ytWBDcMW+DUqZv55H+zvEcyOug8ZBk4XmRIjR+szRwNPH/N9fEKr9ynfSZqc4TGxuXvV/0Hua+VmobIghTyburpbqj2AlIeyWws5DrEe9JdwTC3KRfmMCvjLSdJHuTnenEhlbNCWI5CdS5nrSTWHfD1WzSr2qc+7R43eOXMpYJ8kC3UlU9DUBFmv5K7WwbaM0Tj+Jz/jSrHS+CcjP3UmcPpNVq6bz8CeIIRymoehlJYnN5E7eEYoqcPPB/KyCepbRpuqCutYFgl3U1ok4x6l7lEfOha9Fw/wP4OZ2RCkmWbyDSCRCIXtGUgbSvGVOIzcj17jnTUabCLvuY22LgHWQaoKUno1DPbzjxgkKccgVgZ3nA6GjED4fAfLMja330iIloP7uzrGgg6Z8r58/scAoAiX1h5nwrl6N2h/YyrUodkP7Mu1erxytyyWVjfeTkkkPhUDAtrA2YmVlBUgHo7I83YUQm1LxS9f0lz3jM5Y8twbFdUC0CCdEeV9X8/Iz2C7d6fy1YnjPhgx+HUzLtIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199021)(2906002)(38350700002)(6512007)(38100700002)(921005)(83380400001)(2616005)(1076003)(26005)(186003)(86362001)(5660300002)(6506007)(6666004)(8676002)(36756003)(7416002)(8936002)(478600001)(110136005)(52116002)(66556008)(41300700001)(66946007)(66476007)(316002)(4326008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jHyR9Gn/6i33shYkx0RtFjLlYSTeFxcNCzRBO12MDI1FBmi2L/YtlMoxnvYY?=
 =?us-ascii?Q?XkKIATyHvInXANly2lHk5gH5sf+NrFPkPMZSSFUyFu4QdKdLl9qpqr+qc6ck?=
 =?us-ascii?Q?Oie+uAz+4Ss40NAht/f+e243w8AWLCYYpae/AnwhEQPLispsbzz6Km8aASZ+?=
 =?us-ascii?Q?jPVs+lrSATO1sFYV1UQhZ6V0Z42aVuFIjlenBSd4fXeMIU5H2tIpK0KGBSV+?=
 =?us-ascii?Q?X3H4M6nJds98mN7fO3rM9DSMFdRYT4nb190QNYch/HibjbvKCn6BaCVyq4Pw?=
 =?us-ascii?Q?9hfZfqmdjtFMBSh/7z7zwvN4rCTYv33DqeEDnlvXo25pvcf1hh8UXiK2GR7S?=
 =?us-ascii?Q?2Gx4cDt04kIsSAzdB4qaELqv/5oiUpPLaAsI6F1W5T43XMNSEL8FuRwkfugp?=
 =?us-ascii?Q?iXZyvcVwajkG8E/MYONSl4EUDMQk8F7mrH8XheRM2nQFJUjLzH40zVKEOPlt?=
 =?us-ascii?Q?uWixNDuSpGBUp+GX5D8wta9fXKTRGslA7OQrrfl7zEJn7psNMe2HxJD230xD?=
 =?us-ascii?Q?JLwg6HnoUGGPb4IAylI8gFbBA7tridRllrkCpKJLpr7PTsDRN/wqNRYQUjM6?=
 =?us-ascii?Q?69DiWZqxmMqW3JZvffxcR0rWcFt59b3Q6m4ZYIRDsPSXOjN4yxKrXQRnaoVO?=
 =?us-ascii?Q?JrVLCGIjGwYiG1KibfkXnxEYceIlL0s7+jP7rHs5CwKclG+80NN0uvnGgzpn?=
 =?us-ascii?Q?5/7UYVsOCTsHHNRXXWhZKyTRv27biYqel4UnUf1PG6LqEAkxln84JwALeYsV?=
 =?us-ascii?Q?aujKEofLUH6GfK6tQtY3zOdSJO9m+4CvI/QMZHF7KeoxnTWFtvf6r0hZ7bRL?=
 =?us-ascii?Q?CgJLwhLifV04YYMi0aeE5c3XtTlMszkVt4AJEtOPeNMQ2tAgqH9dT8m3QZQ8?=
 =?us-ascii?Q?jCECuBVmteUMWlqmJg9qe0OIs3JJhz9OO9rejau3Zk25zrwqX7Gcs2ftq40j?=
 =?us-ascii?Q?2S5hJsgITt4eVEUgIkO0zFPQ3iCvdcDUjldv5rYYpEbz08m53P2Yc2VJmFrh?=
 =?us-ascii?Q?626gFTh2iDg+Z5qeH7BCdu2nBkB/2/hKFaWv0wf2sV452kMit+AQAqiFFgZm?=
 =?us-ascii?Q?UGla+g0vFh+mkADMHpU27ZYnJW05ETRV3NMUTDZCMEFqyWRaiWZE8UCkRUvG?=
 =?us-ascii?Q?vFUCFawW61HU8ImP31E7O39x5x61DKZSG032iBhJSqEIddEjnLNw+VAVXJN7?=
 =?us-ascii?Q?k1TR9ZXwQbE3d0gj/UbPaCVLt4eZCN1cwcCgI+U/uHHaJaFBQuBgRfH3AGtX?=
 =?us-ascii?Q?DikE555+gedb3IzH0uEuFg152PwicAz/kUur0RpUt8BUZWbzn+A8NucWhBoE?=
 =?us-ascii?Q?YOGnqUC4c9V8lZo+32nir+GSYkK1YGbcYx/EJJVJ5JPwN2N8JOhHwAYnxfbx?=
 =?us-ascii?Q?lcG2kqGCAN0YUb/10pby0Jw4wuwOSMl2O7bRtVzt9ESp2dpSvmT75hzdaCI5?=
 =?us-ascii?Q?oKONzwqGYPJZD7zhciCKbwueWITIY+0qGcouzPhd4KqlG0HgiDF7mZvXdUwf?=
 =?us-ascii?Q?6bthkXEK1c4u8rgZyVfEtvbhM36TgFCQrzCZk5fivMZFDh8LsomSFPADpJvX?=
 =?us-ascii?Q?diVk7SGtfTkerk+bs72hBgfR86aDJTJAYiCT+2wy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca19d71-c101-42b7-36e9-08db83e2b467
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 20:49:51.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/lbGCSpKI3xlkO2i0gbleV5+2PmNcevEToXD5A+0V/BOFvsluwMuO8Z1Lv7NxBJz0SpZPqh/Ge3ETrFOZNk5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add A53 and A72 opp_table.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- pass make dtbs_check

 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 72 +++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 9fff867709f0..effd84ebade1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -62,6 +62,7 @@ A53_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x0>;
+			clocks = <&clk IMX_SC_R_A53 IMX_SC_PM_CLK_CPU>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
@@ -70,12 +71,14 @@ A53_0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
+			operating-points-v2 = <&a53_opp_table>;
 		};
 
 		A53_1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
+			clocks = <&clk IMX_SC_R_A53 IMX_SC_PM_CLK_CPU>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
@@ -84,12 +87,14 @@ A53_1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
+			operating-points-v2 = <&a53_opp_table>;
 		};
 
 		A53_2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
+			clocks = <&clk IMX_SC_R_A53 IMX_SC_PM_CLK_CPU>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
@@ -98,12 +103,14 @@ A53_2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
+			operating-points-v2 = <&a53_opp_table>;
 		};
 
 		A53_3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
+			clocks = <&clk IMX_SC_R_A53 IMX_SC_PM_CLK_CPU>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
@@ -112,12 +119,14 @@ A53_3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&A53_L2>;
+			operating-points-v2 = <&a53_opp_table>;
 		};
 
 		A72_0: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x0 0x100>;
+			clocks = <&clk IMX_SC_R_A72 IMX_SC_PM_CLK_CPU>;
 			enable-method = "psci";
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
@@ -126,14 +135,17 @@ A72_0: cpu@100 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&A72_L2>;
+			operating-points-v2 = <&a72_opp_table>;
 		};
 
 		A72_1: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x0 0x101>;
+			clocks = <&clk IMX_SC_R_A72 IMX_SC_PM_CLK_CPU>;
 			enable-method = "psci";
 			next-level-cache = <&A72_L2>;
+			operating-points-v2 = <&a72_opp_table>;
 		};
 
 		A53_L2: l2-cache0 {
@@ -155,6 +167,66 @@ A72_L2: l2-cache1 {
 		};
 	};
 
+	a53_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-896000000 {
+			opp-hz = /bits/ 64 <896000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <150000>;
+			opp-suspend;
+		};
+	};
+
+	a72_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1296000000 {
+			opp-hz = /bits/ 64 <1296000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <150000>;
+		};
+
+		opp-1596000000 {
+			opp-hz = /bits/ 64 <1596000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <150000>;
+			opp-suspend;
+		};
+	};
+
 	gic: interrupt-controller@51a00000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
-- 
2.34.1

