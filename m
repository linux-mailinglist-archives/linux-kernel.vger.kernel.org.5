Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109E75ECEC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGXH47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjGXH42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:56:28 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0C19B2;
        Mon, 24 Jul 2023 00:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGYVwFBqa8KNsHI9J8MDbxwDinGd3Bg0sVog4VI9p+jp3pBUDVFm8+u+2nz6J/53wsZF3hC66S/GOhjKAFcZLEB/wJy2Cm6IKR7TwcC2p1EcHhq5EFyEf3yi0rpSLVhU4Kj9l77YrNY0RX0gDkx84Mefj6/cJTXk5GNmzngExWRbq0GJWf5mL1qkPTSG0tFVMPGQhefKrZUCIfRG/LCvECCqfXiFp9Cx6MhaW6isIGJkXlMQpmf/GzCehJuL2yv6bOBcvXSOv9c01uoaBidnrx0QbuiEk9OV7mYqM8F0Vj1ZKx9OWT83nf23q9ws84rs7doDNkR3PqIDYp5I40ylBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjO2qRu94/gXUi9k++duMbP3AXLTytF8snUhJrJnX48=;
 b=XikV+iyXIgZS4bXZyjj2W0Vdg/iA+I1G/IEywDAIjR+VQKP7E0fJncF+w3sXAOkX07dCeRTz4L+/i3wbNcIGtCrgicaH5WnJ6tWaMnQrCcHAiC3scYVGUFX7YLIlE3ECljlT+jzCtNMIc4M0sb0OkZCgxs09mXZULMluGYCjRCBX03smasOjYx+d4asrPDzIlI3aHXVdP55pH8O4ETj7UDd0m6kOwqPfbeunymrwyElAbQMIs/X4Us+jr4lIPnDzgZypSY63BChKY6Q5WgP5pGeytqgONbNJb7WBHFwsPGQb0uQY1Gu60C1/SmealpBfuj+uSbEfBHXkmftBdG732g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjO2qRu94/gXUi9k++duMbP3AXLTytF8snUhJrJnX48=;
 b=BAhT03YWSukmlshfKMnOfZwOivRj51AJyxBKxZVt2+qkC61ut1ALux71ZW6YZisaW7zL6qLtp++nwOd2fbSVIBk6Rzi2kWO1r1TrMq5QAbJlOn8fWm4Zu3X8Z7uIJa68JYXZ7IsYyozhL+H8Fb7wqBN1TRT8x2R0oyHuOFF7WzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:54:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:54:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 10/10] arm64: dts: imx8ulp-evk: enable lpi2c7 bus
Date:   Mon, 24 Jul 2023 15:58:33 +0800
Message-Id: <20230724075833.2763190-11-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 131fb3b5-57e2-457d-1d9e-08db8c1b3792
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q69KSeCLipycqt5L1RmNnJ2oi4KLiXSmkRHzFfet4X7lkNJmZi2JNDBhCkdTNiQY2x6uba2S8IpFFnZXfgjbH0BytRyE6YGZ//5ldBA8/Tbc/8COebOPCzMUF43oRYXog1LKm2JYKlXe24d+TeedHtdCFeGn2UL7aBo0Srherbqp4PazXI3blBZik1LkAEroANeILPKZHYJF+8BMKKmOq89hDcD2K3YdVmCtjE4FPAsqA5AQzAIebAJXV/Jx9PYJpZCAXWKFEn8a4F6Yna7kSLUb/pcqPSka5kcPWJ/8hZ1oMKZ+wexjyqaRPScqgvTDWYXJg+9+0xBV5mCiEZ76cjsYoX2ZuK7bD10RQnBvlZLt7ps3Gf0v7jyL/g6e7/AiSsedjwtxalisxd6tO6e4+rnCF4Wbl6zB/A0gns+bCjwc2hkrYfVGBmGbKnwsFh2R2aCw6QDjHBA2jXAJOX5D9pj7utPCmyck+iGodC0VTWyiEDsS7bCz6f9yuWAvoT7nRW90Qaa5vLrupuDGkV8mfTbqbzTgumq3/csjnpfNZWX68W67fQf8H6xYxdbXgxv5jXtLpSrOrMpPgjayDqL1plhCOYpZ+I0LNZGWE9edYUJGRvLLsuFEB/n1UJEdBN+JNsBqZE/duNqYCCgbu6609g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(8936002)(5660300002)(8676002)(41300700001)(316002)(2906002)(66556008)(66476007)(66946007)(38350700002)(1076003)(26005)(6506007)(38100700002)(6512007)(54906003)(83380400001)(86362001)(52116002)(4326008)(478600001)(6486002)(2616005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FAYfgky0cSPtc9DEhP0gsVZlZLoqO+1WA8Pq6xq5IGro/h+X9c2OE3fzSduI?=
 =?us-ascii?Q?Tgu8QmwcgDUQoDU6uq2jjlteSVBtEwuo3kEWsXLctzL82Ilp8cKzMg6xosu6?=
 =?us-ascii?Q?C1nrCNr9bMArDKPLnUV+HNce9IwQmQt++tuTIu71Yawuz94JLi8c8s6ZmiFO?=
 =?us-ascii?Q?ZwKViDopLXRP//5G4oOaFDMyhij33RT33AtqLT2ZQ2KDja4IkcZtAd6iCfxJ?=
 =?us-ascii?Q?oPREYKidujAvw2SMGXQA82o5tfMVworUDGrB+D8mERnL+mGIojSYbgrtqwtp?=
 =?us-ascii?Q?U5ppAIW7jjU2sfSL7xNhYDcGPUC1L063UdNZJyxaEFww7JyOyWpMv6lLLsG1?=
 =?us-ascii?Q?eojUe7GsfDtmWyO/OmAQ+RzZ5cG8K+VrpaXkL3iKWh4ZuT1C4yWTOwwBF/x2?=
 =?us-ascii?Q?o7RQjUOeglUcjxBjdLkAuIz9pjL9DBdLliRVQLjNbQ/3og+K0rT9CIqkPXEz?=
 =?us-ascii?Q?sfIJEwVNyNFPwTQMhfecaZjx0CLktflc8DXCZceECsc7/3hCSjgl85EwpHJI?=
 =?us-ascii?Q?hT89A+9gk4hngrv6o4ZtYdYvmEIgerUd2Pvkrysel9+um2bCqW9mTraLszda?=
 =?us-ascii?Q?+Vknpo7/FUvzq0FLi1JNdflBRAwYE5Cwvh38AlJ1ZGpuCNi4kLLX8ahJnTC1?=
 =?us-ascii?Q?bQEM3MLp3ASZsfABxCl3TDbtxd68OMl3ge4wBxsTgZ/dJakuSkOmDmg3cytz?=
 =?us-ascii?Q?r5WsbKYy+0xiZQ4t0WSkWIlrMH1D4BsaSsfKFYyMRnYak5syUXs5bGmEK/Qu?=
 =?us-ascii?Q?zFCE29G2/2jzgK6Ytj0U068+BNTqdsvz91cBCym4JVLwgVcaOU41xh+QHJdN?=
 =?us-ascii?Q?rjaSun0j1uCXxjTq/909/uNxHQcvsjbSU3//TlOoXuuIxQYBxCOK+LW55nYl?=
 =?us-ascii?Q?AtcsTS6DYjWlCARk31LHiYZMwAwORZ9MZ4ggdXrIrl3cyhxMXNdAj6k9cbmM?=
 =?us-ascii?Q?lkjKMgwp/5HAsve35+aOipapZVk1O3bo+v08Y6M4CpRXi40HDL02zfCt9YMV?=
 =?us-ascii?Q?aI7L5DZ9p2rl8GvPP1SytbajeNO+ibFnQ3vEgqK8IC6m6ey68C68s9N/wp3z?=
 =?us-ascii?Q?C1R146fkpJkgRxcXqM1n7guiJJFMAoHrgwRBvCKwYQAx8rbE2S69N78Jys9b?=
 =?us-ascii?Q?8x7eagaxZ0fe5tgW9gnW5gDaB7w3uFVf4xYfkQUy9uPqjXItjJnPjuaV5eJm?=
 =?us-ascii?Q?+QQKtQwwnPbpNMBnwsoj6tfhNmJrYxh5ATKRw/wjZTYf63YZj16zTwPKB0L2?=
 =?us-ascii?Q?xZDy7I5OU0XzMsVxmLMyFytiRS+xCeM/sShk3ipu/m5PLNqRXIY19vONRHf5?=
 =?us-ascii?Q?ZttXnlpZ0L9gzGl3orxBfCfLRkE1PbYoOeNSqXZNJpWaacZnryG7sWI+FW5N?=
 =?us-ascii?Q?S9eJSXeyPtOPdoEV+fPeGoQMeHX/7orLgwv50d2th4Uuayp4hQ+mYLf1qGCg?=
 =?us-ascii?Q?jUP+lX18SgvPhk0yGNDPqoEkN0fsFUyzyWDly/E7nSoqvvssSeYBzDQ5E2xT?=
 =?us-ascii?Q?Enn1sU4vMxW8RDYV2XmbE8GKGFz906AIUT9Yiv8YDWrbuqzuO8WGjwKBTMUD?=
 =?us-ascii?Q?mbuYUBaU58zw44lsuay1daJCFyPCvErhkwA7xrke?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131fb3b5-57e2-457d-1d9e-08db8c1b3792
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:54:33.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJawjD5b4aNMTIfDKvbGyigwSX8XiX2IiAlAr/UliOtHgOX8wv+Ww3uim2Dd2BNC1ozmhIHfbdu2wLykoebW0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Enable lpi2c7 bus, and enable i2c IO expander.

Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 1314383caf76..69dd8e31027c 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -118,6 +118,23 @@ &lpuart5 {
 	status = "okay";
 };
 
+&lpi2c7 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c7>;
+	pinctrl-1 = <&pinctrl_lpi2c7>;
+	status = "okay";
+
+	pcal6408: gpio@21 {
+		compatible = "nxp,pcal9554b";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &usdhc0 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc0>;
@@ -200,6 +217,13 @@ MX8ULP_PAD_PTF15__LPUART5_RX	0x3
 		>;
 	};
 
+	pinctrl_lpi2c7: lpi2c7grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTE12__LPI2C7_SCL	0x20
+			MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
-- 
2.37.1

