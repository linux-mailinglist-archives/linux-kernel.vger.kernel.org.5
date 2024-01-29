Return-Path: <linux-kernel+bounces-43556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D8841571
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1EF289244
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7815A4B6;
	Mon, 29 Jan 2024 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rQS8w5Tq"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A015A49B;
	Mon, 29 Jan 2024 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566522; cv=fail; b=qp9wt6o7yhqi1vXhydFDKztqJ3hZbO2EtqdriBaaTMS6z6lpNVl9KJzNh/dkWHsaVM3onFXXP2V5KXBVbcyl6APJXZeQ5slISaya+xnIcs5UKk9/kjaA8Vydy2jL/gbyr8pWEmu83QI1X/mcXT9aeZ4iV+GwvejYcnPa01XEyDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566522; c=relaxed/simple;
	bh=ud7NJA6cF2WD740nl29fQ2l4v5OqhIapQO5zZTMAxLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ooTFKgNjHdYrNkxkLvHU1XmlFUdQUYs5BshJGGZW6WzOcYCN5QdMUavKmgmWl6OuJs/IHcXB7K3tCg6JA62DLTfwjzveU4Zohp/VUgg4aKvCZCAVJKXtrI99R9JrCHfsupdL1QrjtHZnqgwPlqjbTOvR9XW6iP2evOO6PdL5rGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rQS8w5Tq; arc=fail smtp.client-ip=40.107.105.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaL6BmfX7u9iPfKet4AQHlwc0IAVvKpoJaYaQ7ejyybrICLPcImTrBAVWLKSA30U4DU5jGj6MskwAOq7TftOwxBrEA6QH8RxAvFGOMJ9d/ltJSm2PmUONGV1GbFsww4GUCPUdlOXiiBouF9frxW0/+IcJoJGhA2VSowqJBZ9a81NF+hFgJMxDu7QuuXaPyj8I92rxlb8YyCwkYpb1tWFKSaHMX83gXdNNL7BMtYTat/IDO1p/umYxqMsLBlKRusbOq9WAH9GrIYoEvwEhCAZCbEHfhCOmOTwojGm9PSGDTysKh6r5zuczLyZqUkHmtm22Q5lEg7XLC7Pxgagzzz5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr+L653IgFsz1kbBKcUvPxk4rC02E4Xi/aBS0aLgjsg=;
 b=ApdoXOJAz4/muI/xiiVjlSgRQXceLfPhpX6NCG2wDiQwAcJ/AB0wo17xsDvqB3g7xcGDgTdhA3D85+z8M4aegT4dsCj3GI5ONhoithuLcFRzpVEPRsKWQBzZj2rJ9fLkIYMnB7clQ0KHYJPrvYXbYjzpjgOI4HF1JbfUzSCogq2ohXGL4nWrODtDuoi/Va1u5br/UCxRWe3VXO+FqDQ7AQu0PP1YesXuOANAuEnTbEo09zGl18mvtrJWcAPdehPTRUtixJN7dftg6G5LB+Q4jq0U+yyoOfjU9aMfSOD9ZKGVT7/hUWaS6FzawDvOS59lrDBBUho1d5r/rQsuVvYW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr+L653IgFsz1kbBKcUvPxk4rC02E4Xi/aBS0aLgjsg=;
 b=rQS8w5TqzVVg4aaXsp8dkD40YFEWyz9BMZ5GC8cW9ofDPgt78ZApfjc210K2bliQcmAvzQpSeeod4s44cdGIKlslrdAwuHUS0LTV0+HgIKUwWxSQ1r+PwoLORD7qlpa6VC8XiDGCRqoEKFysBp1jsDuKOZPR+QEuiCiLG//7B9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7205.eurprd04.prod.outlook.com (2603:10a6:10:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 22:15:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 22:15:17 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 3/3] arm64: dts: imx8dxl-evk: add flexcan2 and flecan3
Date: Mon, 29 Jan 2024 17:14:58 -0500
Message-Id: <20240129221458.250492-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129221458.250492-1-Frank.Li@nxp.com>
References: <20240129221458.250492-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 31eb07b3-067a-4be1-b224-08dc2117c639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qmK44LC/ShLYNl+XrGYcd747AoLA4SbqZWaauQQY6p83u3rJsVhU7F1y2VavFr8FIJzI1o3L3RB1qZr/d2kJfSjI3CCeJ4iurTzMiFXxs3FFxODrZx5euZJTh6o5BWamE3xLniqQ9HVh7XdsLkCXN6eqxfq4eOrq4/bnj0n5/RIV9aJs2K35+Qi0+oyjqYxbYROkC7YtzZh8bFshYWEfGPR2hV2QT5K3qvgCQC+PgOJ7gI5RCsfWaZleiBMpp4nhI8DuNgjqQznj2fKLv/tl+DpA7qs3p8McpPt8q5gA50Y4nYAmxCynKeKvxd4G8PEMzSUatWZP7C8yJNFDeSI/s1HZreoT9uSv5Pp1J3SbNKB/+SphPI5Qej3HXLZ2iHjFvUh3OgRYSLKuSVjK7YDkaxnzRqE9knZbKQq6bX67KNQWeCPlmx9uWqM3D4YM+EjNrNpMnVKUn5PPgSue9SjBlOV2HyqlPqaLh/dJ0/zg29/QS9gZZecOUptVUV3YYX3s/FqlMb9MfBIOy5cYqE8IgFI5uCl9rWeOlMhamVm2lPOhJCKkTy5IHuAH5p/wfzAbm/VxwqbOkAztWJM5q3jF03JC8GwUWZ3nkLhT/gzHIWiBSNpqSiWeeJJioXgSFoIfNvS5kRmtdbkJtTRWephM7M0CS8bGNYMbN8TY1KZqBBDEQTRt+pu4+m0j3q9FOv1YHt95CWnvZZ5TkyI2QtWJWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(26005)(83380400001)(6506007)(6666004)(6512007)(52116002)(36756003)(86362001)(38350700005)(7416002)(8676002)(41300700001)(4326008)(8936002)(5660300002)(66946007)(38100700002)(6486002)(66476007)(2906002)(110136005)(921011)(66556008)(2616005)(478600001)(316002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4AHiP/r9zAe25MKdad3z9T+QA6ZRbGl9Ff+GMLukLNOqmWC3WZ0qVaTn4QGp?=
 =?us-ascii?Q?j/ie9bt2T4fPXSXvIkK8jwxwyoXd6MnzBSXR4P8jMKFSSveq88GTbYlTCZiH?=
 =?us-ascii?Q?3LPDf+WSZO6obZr5Dfmjd3apjo89YwfZQcMezCh9tElEzipDHA7X0g7ZyHBa?=
 =?us-ascii?Q?VN6wvfELswyRwRnskKyPor6JihQ5ns/ENscy7ErNQegu32wUzzC3mhauzJP8?=
 =?us-ascii?Q?8YWvX/mt6d34/ZsbBLsgOfz649nbevvmvJhF0iLT2qFbrnO7Vt5cZz2pyxWP?=
 =?us-ascii?Q?uXXRnYW1oOLdIgP/kNlatkmJONfnbhJkp691wNMlQgOknkbtXrKII78BTlP4?=
 =?us-ascii?Q?eKkvJhgokeyMkd1IKrs9IF7VjKecHdfCi1WYMrABWj6+hhFZEqknZN40qEQQ?=
 =?us-ascii?Q?/fXTXi7uqjeVGNk5xmuUP1VhkNbT+Y7ECYoXJ4vtESIsBCm83Q+0ykFJJQtS?=
 =?us-ascii?Q?KtozCgC4uxJ+cN83C0ef8/lbIJgJJ3xaF2+SugoSkKtNBoCHTjeIiO1mF9Zh?=
 =?us-ascii?Q?FhCzgfaNWE3b5FfV843EgrzcwH9VTcwmPKP3SaPf8RXaDYmpSbnFdTSGiqoV?=
 =?us-ascii?Q?NQ5Nt1YDmkvuU0FBhT6gD8MmRPt1vGEOmKAH7kGytebg80UW9TuhX/O6RQX3?=
 =?us-ascii?Q?z3dr97S3mORUz65llNidXXz1egZwCy10S0hLoSo9qp42wI0NWb3dhGSm9Jg9?=
 =?us-ascii?Q?Xv96Js8aimKB9HN6gFNQOVe1QngA6P24NDBXoGrJPF6kjnA9ThZIHiu/F2sW?=
 =?us-ascii?Q?NVPxG+jZ0GjoHj1Grvmd140FwI3DQQk2TjnTh1LVgSCqG8zqW91sWAnuDkjZ?=
 =?us-ascii?Q?smLrjSxFDkzS1H7Li/LLTxsi97dFqGsKp8EFSqvIZK+a35MCxO0Rsz+DCbtZ?=
 =?us-ascii?Q?zp4LtEtv8P/Rma1X4yIZR6bBYwKYXuLY48ddGf31dcuBdUpvG88+EfFT2N6X?=
 =?us-ascii?Q?o9tzzW9d3OAYnZxTmSdxri/T0sGFeEfaYlK5LZrjxHdS7ipn430nFq1pnvF9?=
 =?us-ascii?Q?4CFB8e5poMvk9prEMd+hv8IX6zF5/zZoBfnRu8q3MwTlFiOMQlHT8Wwd1My+?=
 =?us-ascii?Q?YXeP/vBiQTqaPyKqHMwNR3gHbuidIT+R1rw6YMej7dh2BwhScaOelqltOaCU?=
 =?us-ascii?Q?ATuxYIeInYs22ToxIz96MoW1dSUgT8xbUrNffRfnZpXCgG4Wl3iXLd8M+0Js?=
 =?us-ascii?Q?RTTygP5DRXxKhSNalN/QSZLQVKLdHj7QO7DCKxfYV/4P5RRor+pvAEq/lKQW?=
 =?us-ascii?Q?7p2TYHLrJF+VxRzNIx818UQwlrZYKjiLp8mvnhFP3wKvPmnc8zqzhnxNAkYz?=
 =?us-ascii?Q?H2hCSIjaPVZfb/ptyvjjq9Igw4ajyFFJtM56jNq420BPShyoutfN1u93OWrx?=
 =?us-ascii?Q?GCT1FXN5XUR07drI3a7qL1xCZ10HVRa13heI+CG9Z7r5oSyJpdpYHd4R7c1S?=
 =?us-ascii?Q?HCEmszgYhEXX17HBPdHxrhF7AnethXYEzG/8v6iGNdjRt3E6IWEtdK/uxnwE?=
 =?us-ascii?Q?yFqTXdrg/2euhqINl8epAOrRaP0t+Sq8yquts1Ns6HD3ewRMTZqU2OQ1d2c7?=
 =?us-ascii?Q?gUBknAtqaLWIavjUNyO5WnvqGnQQzow8wKIgGkK+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31eb07b3-067a-4be1-b224-08dc2117c639
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 22:15:17.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzIm8Pg0HPUO4fDZZu6pFQpK9ZlKqjr5T6qHrXjFPNbBP/nrHcV8i4ATXq+C+v3TrpfZ48Fucc6riAj5L+MCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7205

Add flexcan2 and flexcan3 for imx8dxl-evk board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index d313cf1dd79d5..3ada9710ae71c 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -81,6 +81,24 @@ reg_fec1_io: regulator-2 {
 		status = "disabled";
 	};
 
+	reg_can0_stby: regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "can0-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416_3 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can1_stby: regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "can1-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416_3 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-3 {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -322,6 +340,20 @@ &lpuart0 {
 	status = "okay";
 };
 
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can0_stby>;
+	status = "okay";
+};
+
+&flexcan3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan3>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
 &lsio_gpio4 {
 	status = "okay";
 };
@@ -491,6 +523,20 @@ IMX8DXL_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B     0x06000021
 		>;
 	};
 
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			IMX8DXL_UART2_TX_ADMA_FLEXCAN1_TX	0x00000021
+			IMX8DXL_UART2_RX_ADMA_FLEXCAN1_RX	0x00000021
+		>;
+	};
+
+	pinctrl_flexcan3: flexcan3grp {
+		fsl,pins = <
+			IMX8DXL_FLEXCAN2_TX_ADMA_FLEXCAN2_TX	0x00000021
+			IMX8DXL_FLEXCAN2_RX_ADMA_FLEXCAN2_RX	0x00000021
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB0_PAD		0x000014a0
-- 
2.34.1


