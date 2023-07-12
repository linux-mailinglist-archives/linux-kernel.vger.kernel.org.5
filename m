Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9058751282
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjGLVS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjGLVSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:18:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D7CE;
        Wed, 12 Jul 2023 14:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzo6z3JadFL+Ljj78tW0wD1iz86WSy+ZAnypspWTlluSXHb3q4A5UPq2+BCla8ieQU9JuIiA6ovTSN22idgHxsRRh57IkxhvzgAz6cG6zBdSYU0ZQfpHudJYJOeiCmVkckYMFOwdLkl3144UMENRvA6ahECk7dlU5FPY+JKn8PdznQn3vwKk/dy+y6rXJC27G8QfVxl4GgEYY6J9ypspZOh5F8mYIbmLxRfOCA0xLucrLNOGGl6IqjKM/cfA7KnBmm+x4s8jiF+PGVtGcq66hzQYvqI+qO2jNKbUKKPqynoNGa75zoXEXzh+SQau9tuR6ieAUjgneucbx4N77Ap+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UYUAjRarxHoJHWAz0LGhNFQLy4xG1sSfLmiiv/gjeo=;
 b=DaoirWw+9axnDqQHYE5gNKotbpoUXj9yEwxDHHiq8JV+i0AE/kDHI6Vigd0mcCf9ZEQ2sEuAFVTfqoZrMCC2TIUDeH2nbPd2OS8cgdbZOwdY8GnIuh+/bGH4bMT+3G0S65ZDNHit/AT/I6lTBh/vasHt6wbm/fD08g6LP9pvNqSpwLKzM4Cf4FcxV1Fe19zTcgytLwHRMSYfgQX2yH37G5K7LL2DSYnhDO0NE6n3SS9kNXUDOnSbJSj6D99CJtXqxwsFOvgn0w0joXSFaXsGgoIabz/lQhnH/saL5HglVsKtkyhuKKovXBoGoLLL3ZMzAxfTmSBGHybBS4SaDfnUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UYUAjRarxHoJHWAz0LGhNFQLy4xG1sSfLmiiv/gjeo=;
 b=eiZOpMoJdRSqq5aDiAIkRTT7qnDCs6euouTeIsLLlST0EvWTL/af+9IWd/FACciNbqDIb+TqfYHzyrXlPykrjXPD0SMFJlFDJT+pmK50jW/j3mxc2NigweZEoIaKtLX5FLWJlQJYqthwGupWXdA4/LOGgP7JB9sgQCae8tZvhx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9187.eurprd04.prod.outlook.com (2603:10a6:102:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 21:18:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45%3]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 21:18:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Chester Lin <clin@suse.com>, Zhou Peng <eagle.zhou@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/3] arm64: dts: imx8qm: add cpu frequency table
Date:   Wed, 12 Jul 2023 17:17:52 -0400
Message-Id: <20230712211755.1538847-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 9920463c-8d02-4b3e-b2a0-08db831d8129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCXHLli99IVe4ZnRl26eF5uZHI2cINnjJK9TPLM06iUe4fjoasyJa01hsqbHwLd16E0sTfNciUoucuUiTsoe8i/RKiaJ2foQlCF++mNmpgOi6oAGRNJdKM35l08yMwB7JQZsd7l7OzqupsT8MXnjdUs+wpw+vaTpYwokawvJ4tTFKJsf8He9sjk4seNMhVY6dP5MVLmxVdl37qYSiJQ0WgcWuGWkQtgQ8u8f2MYzJLcSUSLidn6K6WsSQJbeolPA132Zey+mbb88LkgprQ8dv9gknmSrCBsDPXsgjAFLxDMQIaU+k/B5mku8MVsILm863RblWQ2jVsr3Ua3vlQdAMLH9g01Dl4Dyus+WcHJT4YTiiae0Je8bA0jOUxAwws/UCYW2Ts2QySGWaDDFQejOF/UZa7x5tu7863f22G9hdT9ivPfqpeQ20hf0JP2sZA5OTrwU0wNcMnMWhgxUS33eJW6IH84hZj1eO8x+o1OIhsRr8GcCVC7KPyg8D7Zd1q5PXUBPKDNtSZKwzFsz2uh+6wrnS8xFvj3THZTZ2u2GoSM+w6JLPkCQsTJLk4l7qdunrurpbwkAwtsQa/GqdofymTvPeVebeY53njo3Ff9DJgQwLETWaTMvyYgqTX+R53QD2m4VnPoAgj9JSszYx6R3AAKU5WAoPBxA1KRILrOMO4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(41300700001)(8936002)(8676002)(6486002)(6666004)(110136005)(5660300002)(2906002)(7416002)(316002)(4326008)(66556008)(66476007)(66946007)(6512007)(52116002)(36756003)(478600001)(186003)(86362001)(38350700002)(38100700002)(921005)(83380400001)(6506007)(2616005)(26005)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IeCxgOWiGe+iq+NkmD3SEzMJHlTEy8FtsnitG66NLrkFtLAZFs8pA1wCMQOG?=
 =?us-ascii?Q?YfjN1YVGEYSXmdoFWNGXe813lbzko5y6Z/rwkZH+ltewwCvbJdHieLAvAGsS?=
 =?us-ascii?Q?t41kFNY9xgnOWX7qcj0STv5BfcqDM8D8aQelgYNDFXyj7WYeYYUpjb+oIu72?=
 =?us-ascii?Q?ghn8GFpuB3XOkP2g2Em1upHFS5OlmDjvH6BI+dc4WPWNNg2GTz+RQRVE+v1a?=
 =?us-ascii?Q?Ah0XowFtI9KQPDVWEI4oeeMOJ0GUVCNOZ3D1sqijLKgOK70kU53jW1uP5AfG?=
 =?us-ascii?Q?OIPbX6HL7lBAlR7D3v9BpXuIpItuGEYz+NGbNH5nigd5rF7DYOZGq8/shH4L?=
 =?us-ascii?Q?HjPdkvZJF1/8il3x9AbEikxiKSiW5T3kXeQx9wQfvnykxFj/utmVO8YDtUwt?=
 =?us-ascii?Q?LHhjJavNa5yCocwBQ3RO+eu9I8C5dmqJZCuQhvGg2hLNF1xZw0Of8Bpnl9Ly?=
 =?us-ascii?Q?VlgM+nukmhs87hIX1qVlJhEzRXX5DuTl0IUhPWPs+meq1/8yyLyEgD8A+AcE?=
 =?us-ascii?Q?lYpGcBCvzlAuCMiPCefMD6ydh1ZLxiE7PWrLH3r6bQiDxuUpSE7t3Z2q6GKa?=
 =?us-ascii?Q?W53VCh45/hv9/fIWRy14ktalBvRJ5Vd76lgSbsKG6/BOpavNdqxGLrGlxFnH?=
 =?us-ascii?Q?G2ns1Zy7Vvz+SMVHhp6t6UGE+RzPas7l7+QUsA9vJx2J1vk6HWZOZkNo+633?=
 =?us-ascii?Q?v8Dzlw9ajR9c+7FTZlxUi0Z7Kb1X+2zDN8DSeb0VCazXcQqIOx53ybwoRPgX?=
 =?us-ascii?Q?5SpCM7HjyIWTSzHqhs9HJlnHVMzezYV4YjBT1+HBoVremQ7WBfDo5FruiLdt?=
 =?us-ascii?Q?nRWS3IdFWWLtzlfcAtSaLd5VHox3Eqf9wZY8IdTpEdCwk3JRe0qgBh81+hBg?=
 =?us-ascii?Q?elNfND4IUkH7OnvHiIxuzpo0Y+hW5XIgzxYMU5XA/RFYqmiiBHQnL/b4fjn9?=
 =?us-ascii?Q?aootO1RyNaunvwe9tUfBQhskkrVVGsmo2nUxfMXclVKebsjkDB5ERj8lhHWu?=
 =?us-ascii?Q?0KvJfVNcSLEewQHCLu2BoitG+20D9h/4U9q8WkNShB630Nwrg7CZ2ing183x?=
 =?us-ascii?Q?MAX2yY+SD1C25irrWBT/b/gCQWiK6QW6noQtnVVfdfecH+mnBF73lsHPLoC6?=
 =?us-ascii?Q?zxZXe3rIVa4FA87vnmb9yrcYex1XBeChPJ/giPKN07ga9TL/RZs/R1ICooYW?=
 =?us-ascii?Q?PpmDzlf+6PW0rcU5BUN/bpoYZdg3p9+7DflYEd9j6lDFGRKtZxnMC6ZqyvlE?=
 =?us-ascii?Q?Gxq9VMhGZoizu9g74ReHhKg4EM9K35dAgAfzrYaA4WPb/GRP3Mzl0N/Opvet?=
 =?us-ascii?Q?Q3kkTG6oD8IOatS/sS43P6z3qEAdwzj+EcPr71SiP9Gj53e7ihPTdZh3SNTg?=
 =?us-ascii?Q?01cTAaEdVG7gkdWGTb5+iejS9FU9v1VEx4EKsvQwpm8JS6KJcP4BSFfYQICs?=
 =?us-ascii?Q?IOqTxdd6sfOAh5E3mzR3v7mZtq0w1qos1bdWV52mclxbjVMxUwgsHZFnc/9t?=
 =?us-ascii?Q?QNnEKmS070y3t9QCRTh5mcUZv52HNp52++rpgBBuxurkFXJ3UCDnQs0wakPD?=
 =?us-ascii?Q?v4eulOr7Qvl/1/0n3B0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9920463c-8d02-4b3e-b2a0-08db831d8129
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 21:18:14.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W76naZlNu0QhT5v+lSCe7yp9cD7tw4+/JELBABoYOuilzgU+qOk9hSuWLIesxefuQdWX6N7u8zPAZy/xXOCgbQ==
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

Add A53 and A72 opp_table.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 72 +++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 9fff867709f0..24508b84804b 100644
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
 
+	a53_opp_table: a53-opp-table {
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
+	a72_opp_table: a72-opp-table {
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

