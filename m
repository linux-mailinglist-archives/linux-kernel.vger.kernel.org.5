Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5E175ECD6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjGXHyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjGXHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:54:04 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B111A4;
        Mon, 24 Jul 2023 00:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekqlZ1t/j5xh7urTyPOtVZoSz69a3ITiA2UYOjpPIqYu6rbsm6AtWsi1JWtaR3DnbUjWmtzbRXFjyAAbzXoQdpColfRmnKtaM78XdhVau8dDkBG6naymOpBQHJu/q9SsOESUjTiegPREeWtO0MC4/7+o3MGPc7awnJeTL1WAVLFljkhHcD3YLXgCgjgFZfHjsMd9XoNbx4vwMUaMmmAFSmiISznK3mc8hr/B6phbu71AYaM+IERftSsgJHP3n19dHcWMnqBO9viUkuzxyTEyhnfwJoz8DKPr4MQu7K31b4l2LovORC/4ekaBVTkMeYEUpDGw68Xy4EUoTmhYwI8a5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp40HZhMaV3BAbqklg6lJOSUHuiQWmRVJ8ZEz4xetzE=;
 b=Gv8SW8LnRH3RyMQjd02iFVqw2YxVU3PZ0znHKWP/w9DgK7ZaO5lwJnh7/K+g65Fsbpa8rQ7YiaLDJziiElrkVYfLZi8SnioP6pK7nk/lk6Lpqa7n04hZBRQuWAlnHcvOHD5U9GnuQHe2G3DQeQk7dRhulfL06lMCWdsHYMDIEGIO4PPb0h7qdIBXjz17QaTTadXsiCZI8WuDn4mZjMPIZU4xx68Rnfl2bQOL2pll0z/6eVJv+o+CKr9LisIdc2kzLurMrIoNsWLAZ5NQ/PJryHf3kUTVrA7e1Q+JwTVRpMr6qgn0VlcG7TTEFwU4dby3MZbj91gV15+9jTu86Yymxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp40HZhMaV3BAbqklg6lJOSUHuiQWmRVJ8ZEz4xetzE=;
 b=U8CA2PcVY+LMZMjHQEEX8qrCkXwtQ+JkaniGgfRJXMrErjfPw/hVeh/AQK/QMpRinQpI+jSM7tNbp1o0UM1N5tOjlRPimvajcnuQL8dcgBY6ukMOKLgCDZBDUAgTVqSHSilecV0nUuEYpxOnYSMinjmrAdB4p7B50m0n0Eza0gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:54:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:54:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH V2 02/10] arm64: dts: imx8ulp: set default clock for SDHC
Date:   Mon, 24 Jul 2023 15:58:25 +0800
Message-Id: <20230724075833.2763190-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
References: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: a4310f6a-d874-4876-961b-08db8c1b24c0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avLictzIjQ8AwSqC9uGskXD3UDpCKTsJ+UU+h7kuhCUF8DXOe19UziI3B623lKeG6eJMqXE1hilvGI4HBuWUN0nVXjfKRpMUQnXn+ufNo8BdOGXWR0stLgp4ESlLdbUUpvc9iEUvZjFCGQdtaK50HLX9WkSKQZZTyrfdtFc/EEAVa6BaByrUK9N2GhWFe6kI/yL9VFCQDugETfF67/r6RD7mnpLDsqCeQVikQ/XbxDpf+WDlkB+QSDPuKxdu9kSzOb1vUxgqL8Gbm4fWrbgBfrcBOdi7TsT/1h7LlvE1kjF9k/83bv+bpXodXIHpwj9TGc9/k6fOsPfxIGl3hYN1zvw5iGX7MewF+iyyoHwWYXVz4as0VJ4+NF7OgZd5U5zuCPV42cpRC48pD+a6MX92RGRfCXr2/9QtoPSkbjbKr5EAvOE2+98xB7bl0GKLQwbpGDN8ePnj/QZijSWZj2EH/D1p69Qrbq8fcFGbcvqO8ZAe0pIF5JUs3VKwy0UZfDDdazQB6/KsmXPD2atCZLoB0jheCnZCwaIiafKnZjIbrqXut28hiojsDbObYgjUpKucIaqgouTaVB8NRhUxqUA0MNyRwTUhD8xWRjDhoA+pB7hdtTgi9OnWaXMVTewx2DsKAtGjSsP8UQPcxUbhhCKo6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(6512007)(6486002)(52116002)(6666004)(478600001)(54906003)(186003)(2616005)(6506007)(1076003)(26005)(2906002)(41300700001)(66556008)(4326008)(5660300002)(316002)(8676002)(8936002)(66946007)(66476007)(38350700002)(38100700002)(86362001)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fpC8mVzwjPNd46PRCHuuwOA1JfU38d1YqNz/BVifLiL1lczHi0GXuqpeL4E7?=
 =?us-ascii?Q?dQyMeeMVwD9ERy/e3AqmpuVIv0jgR/xfl36gncZThtL/OQ5vV/UXBROCg5s4?=
 =?us-ascii?Q?g6wq3naBf2cEvAiC5bIB1eQEB2VmYjz6QMDAZViiDm8k+VllrJvCVhqR5qfg?=
 =?us-ascii?Q?qcDJr8N/tJb+jmjJ59JUMbOpfFRdHARZIQ/2OkuEDrALwK4OWBzdHrFw1WPB?=
 =?us-ascii?Q?Cc3z5b59dFsWa5oITKGG9RdigI2m42jjeY/UjEYyzbT7R5j8ny8ho3D3XMT0?=
 =?us-ascii?Q?68Btz0XTQB5ZFL1n/G82HPd4yY1CWfCKb+wQ64z4mO3MhXKrhJHI2BuFn2ai?=
 =?us-ascii?Q?tiTLZ0eE2KBz/i9E/RV7P7RUXTUcKzyMJXF/Z6MGnSKVn98I/EtJwzM2QcnN?=
 =?us-ascii?Q?gxjpSfYdPgMJXOCgl3LzQwl9uno/9tQ5CRaRKKfHKWIZ28UK7djdK+y1S/jZ?=
 =?us-ascii?Q?bds/+cfTScQGkCcytrSuwuOStSWg1/usSf+vEo9/tJCw20zR1IbqY6CsTm3E?=
 =?us-ascii?Q?xqCjdTShi8mlwvtSb2tBwjvZFGPI/ZMQOQ9+bzdKgGNoodH51NpElDjVodhW?=
 =?us-ascii?Q?1msaZ1hWUhwN20wGVd/JkUtaYqruksBv/1zjgFy6zKtN64q/lbzLJUyybQg6?=
 =?us-ascii?Q?HvQb3cOYiIyD3XTAja7NtFY8gewNr3XVAMDQlVuqONQKe3qNh0HxjRhs3eKP?=
 =?us-ascii?Q?5dYMM92verhlB+cbBDXe/DXXML4OkWrGVvRDcW8ADtkQ8hhmbQcccgFwVLox?=
 =?us-ascii?Q?svKezFAqCpdcEOomoKjAdkBmkXB6z3UMfkMz26ZpmsSCSt5XrJGdT6mg4o3T?=
 =?us-ascii?Q?Jlg76CTIY4WQMnyhE3tA23zpS1prE1XSt1wgJR7KFKdrVX2BgJZh8QDcVM4N?=
 =?us-ascii?Q?ibsRMDWQ01bShqNZdm9gPdO1c7W246cTq5yV+Z16o0vh4eOIwML3DbV4Qe7e?=
 =?us-ascii?Q?EFPg+lQy+z6pnZE12mhXXXilJmCoYlt+1u/d5EGaz20pUbIhCqY/S8KWSIin?=
 =?us-ascii?Q?IM0miEdf+gDrKMZ7FCFDSWkSiJi+9YGGz1ZOCxdYj3LuU4uMYwLJ/r4LPCbl?=
 =?us-ascii?Q?hJOXqWdKt1jupwP1QGInnQdOncqQkyHBN5lBdfDwA9796czXlVfWrQEWrHP4?=
 =?us-ascii?Q?zedKoxCDGiqaLJHxqwk4/u52EDKA2EUhZjiobcv0Rvko5y5pztUtaeZ2a4ZF?=
 =?us-ascii?Q?Xxk/VXiixGbbJmoAEzP8g740d9xkb4VhUktqvO81JJi1Ko22TIDcDEQ2Vmoe?=
 =?us-ascii?Q?blKhO8a3gd1ADgnpUA/eQVg1oorl2PEnh7tBMbecuIykYuw6yZUmuXI89XRn?=
 =?us-ascii?Q?VeAm5+acJLbVVEPvHPZ6mt6wzf1Yxrrc7JZ/YyVPcR7YilgoiXhHhLIMM8v7?=
 =?us-ascii?Q?HirRZc3NsCtHCPit4qwAEVv2d4GeEGmOhtfGt8oGmzUao3v3yuaP5TBLPcxj?=
 =?us-ascii?Q?jgqslMV7H2nuMbLHvbnnVQ5tnf4Do5e5AioKZtEFTslLK88MRSNsVT7fU84a?=
 =?us-ascii?Q?VL+6V3HxvlUMjXhDwkRgonjN8tXRbedN9RcMCNn8m61OBAP7VaBpNIteH+Qu?=
 =?us-ascii?Q?QkRsWtLx0C0l0LXHP+8YEHKE2F+6898lhkFD1QKQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4310f6a-d874-4876-961b-08db8c1b24c0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:54:01.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxBdY9csC1OpkSL7fKmvL0+31HxFrsjPtHAPmwTHRZanz7b6d5pwI0z3wkiXSt2KhjYEO9v6TkVih7vhObEd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Set default clock rate and parents for SDHC[0,1,2].

The PLL3 PFD2 maximum frequency is 332Mhz, we can't set it to 389Mhz
as USDHC clock parent. Because PLL3 PFD0 is used for NIC, PFD1 is used
for audio, the only choice is PFD3 which can reach to 400Mhz.

USDHC1 and USDHC2 maximum PCC clock rate is 200Mhz in Over Drive mode,
and 100Mhz in Nominal/Low Drive mode, when PTE or PTF is used.

The patch adjusts clock parent to PLL3 PFD3 DIV1 for USDHC0, PLL3
PFD3 DIV2 for USDHC1 and USDHC2. And set the max rate to meet
restrictions.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8116d6eeb738..ba0edb9a009b 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -370,6 +370,10 @@ usdhc0: mmc@298d0000 {
 					 <&pcc4 IMX8ULP_CLK_USDHC0>;
 				clock-names = "ipg", "ahb", "per";
 				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC0>;
+				assigned-clocks = <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV1>,
+						  <&pcc4 IMX8ULP_CLK_USDHC0>;
+				assigned-clock-parents = <0>, <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV1>;
+				assigned-clock-rates = <389283840>, <389283840>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step = <2>;
 				bus-width = <4>;
@@ -385,6 +389,10 @@ usdhc1: mmc@298e0000 {
 					 <&pcc4 IMX8ULP_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
 				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC1>;
+				assigned-clocks = <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>,
+						  <&pcc4 IMX8ULP_CLK_USDHC1>;
+				assigned-clock-parents = <0>, <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>;
+				assigned-clock-rates = <194641920>, <194641920>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step = <2>;
 				bus-width = <4>;
@@ -400,6 +408,10 @@ usdhc2: mmc@298f0000 {
 					 <&pcc4 IMX8ULP_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
+				assigned-clocks = <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>,
+						  <&pcc4 IMX8ULP_CLK_USDHC2>;
+				assigned-clock-parents = <0>, <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>;
+				assigned-clock-rates = <194641920>, <194641920>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step = <2>;
 				bus-width = <4>;
-- 
2.37.1

