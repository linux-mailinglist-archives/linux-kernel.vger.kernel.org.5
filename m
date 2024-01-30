Return-Path: <linux-kernel+bounces-44841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE484280A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F3728D72A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D96823D6;
	Tue, 30 Jan 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p9Ot7I7o"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF178612C;
	Tue, 30 Jan 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628380; cv=fail; b=byl9r52xhMWvm5WzqzU1BMlt6PhEFFHxD2x9hhbsteVEqlJkyy6/Mw0wjKvv5LZpq/Z4+xzh5jBWMOeclpwPDHy2mQBrNS6RDSHC8z87UssQIm/J1HaTVyVCCHzzZat1wydfkDsTEBv36iZHg6VPZRlIlm9AJDykU1330FfDc6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628380; c=relaxed/simple;
	bh=depocyL5MN7gKXi1Em/s+C9MAMu3IhUZ8bz5EqUPirU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JSOjQsDYXI0Fgcv4wiT5z/zmIHfbtyhN6LY80PLfJKOrSd88tk5ngjkk0Q/kt+COzYcOMCit0pKZap6CTg7i0NftaFXj2uux9mUSUoGDBpK5eJADEgHhC8WD9Sfu5ri/CTASQBjZaujdMu1GI6PpbFofnWgIhuyuE3Hc7yjbkfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p9Ot7I7o; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQXLXNuDsXQqcoI/gO98Z/BlYimxMNK0izMulE6qgIJsLdwdM+7bd+/9oVhgMezafV9bKpxlz0c9cdLkpX22tHmCwURWgVLvFYDpD0y3ukjpcsCYR2LPzXqBh6+zcK6JfLK1J/TnOS9O+SOs5si/tQbQ13NMvGWzhv8BOzDxFOYq8hvoW0LVb6LuCfHKsApvUYZMHZDiUMSycX4NrxWdpD8UKb5zyh+qZMkAVRw5oYaQJb5pS3S43SivTUs3hd4bx5qjlBYlnE9MscLfWK1pypOardwcG8FfyEBqzioGsA+DNHht+cPZ64uo79n5DNJILZ/SlPD0bbJihn7EWY+OEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rECQuZ1CkMOYrIviGMRG55Dxi8zKcdngiPiD06WbAcc=;
 b=j7pucnquMdd05gmFlropG/fS1NuYS6RWoaQHGi5nE7xFb0TFJpkXZMs1/CjWsJC8RjNtbQtAxZpd5AjOvuYZxI3TofqBDARG1jGoqMKWmtNpmsHqaG2rL5Cg30wl6xzeyYcaSmjumP4JqQ3WFd1uSOvCzYvTxAHjodI1ZReCShW4tWPiax8Ib7SgCWZ2h9Mf04qlM3Wt0BSOo+g7KGtqEK9YsLWk7zLLVBu6kMOQ3I3KoKzjplJbSrs7kKwPsoxAMSDok0ePbKBaTO8e/6++UoDNTSxf6Rp3LZgDSHwahyxwh+MLQLncJmRAvDbrRoeO+t+YeJknEucodOLMOWwxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rECQuZ1CkMOYrIviGMRG55Dxi8zKcdngiPiD06WbAcc=;
 b=p9Ot7I7o4bwjz/ZfVKFpb4Cnvrj30S4lA16aWq7HCG6Qk30smrsSFzResfLbiqOT93EYtRBukh0W6XzzgZ2NLXqJwE6dB4JLK71PDtpY4nGfVVI9juIMBh0LZq1MHPA5FdbeAd+4ZO77pt4aNSNWmVD5oc419eIJfk8edGtP0+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9902.eurprd04.prod.outlook.com (2603:10a6:150:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 15:26:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:26:11 +0000
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
Subject: [PATCH v2 3/3] arm64: dts: imx8dxl-evk: add flexcan2 and flecan3
Date: Tue, 30 Jan 2024 10:25:47 -0500
Message-Id: <20240130152547.272125-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130152547.272125-1-Frank.Li@nxp.com>
References: <20240130152547.272125-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9902:EE_
X-MS-Office365-Filtering-Correlation-Id: 616c2dbc-17c6-4eee-859c-08dc21a7c9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BOqME16j9ilUcPFlc9aen1LAEEMotQg3rjMo0Fppuh+8xchVgq5w0LtT7ZTgT6pGpmYPEZEV26PjiUjnfgqp7/aMvFI2TewxHkdxbEfQsmRQv48wRsbvF/xb0ny2kR/R/ZTC4kWq+ZqyeRUYXFzmE4L39XCVhkGBmy9fY39MTTRLLkWErjr+h83M99grN+Udy7D1v/yFaUu9FM9OVUcQZtmH3t3tXxAn2GX29iRDTWXlliRWeghCmbO6ZbgK1YGU1MGQJsESOhcvqV1Ad8e6JYjNIPVVbKJHEdBPT+lr9vcy1ZYPMIsKFexskXoJngZmdIzoDZuxnTqVMiA8sjK1mtU7uO3EH2Dslk4qKeZOg2vMrZnVowG2m291QzhpV56B1AouYByxG9fomwBrBah4nUf3M73S2YWzU5OcBjQRQN3tnJFrIWs2XapNCjRCXe0NXGVL5SnIgKlU5VuC1Vo1lfKUGMHK53G2JhYmcImcgz6pUhjbZ4zpu5HJoKaLyrhbPjrvVHezhhHuP/uHgS9XzJF+VS9TbuoICIbpUVjV3T/pZpAS04N8gOBJ/2C678ljsuZ3tx8+IIlLOLOqzsb9CEAl38yV8tI8H/hRAN4z4yVNwfHofXuE5Y6aawVClh2Tp7qWteuqtzBIUMG+NVd9zN2tIVeAtBMT3/OvebS5nN2tuBQVvzHv+xVQM6eBSz8FWN9Dtq+AlwhnJ5pRgBp44g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(6506007)(52116002)(2616005)(6512007)(6666004)(83380400001)(26005)(4326008)(5660300002)(8936002)(1076003)(8676002)(66476007)(478600001)(6486002)(316002)(110136005)(86362001)(66946007)(66556008)(38100700002)(7416002)(38350700005)(921011)(2906002)(36756003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aKDnlUNsK68PENLZ8G15TnfnGnFOFK9bTkWJyfS/vUsmEl0QVgN94ZM5jhUt?=
 =?us-ascii?Q?sxb5BgitjZ72C8Ww6ekchWBDr6maJrSUvNiZBHjUwZakZh8md/uxvwQ5Pelv?=
 =?us-ascii?Q?dtJSLp5JLJJdAVBueZs49Qbt4TVp1VKLO6Wg76Mw9+KseM/FLk6Rqm7mNJBv?=
 =?us-ascii?Q?Oqln3WEe9EDnNxqjlBcXOT/m3xEWY8ZeUuTh2Pp6fVwy8Nir+hE1k/crSUpP?=
 =?us-ascii?Q?diCO+3c5PDmAz0/TZHZixxrqypfVvCxMHKqIFW+Yj7zsOgCay/QO3liU5HI3?=
 =?us-ascii?Q?0BzFFxf3YC9c2v3QfHt4m0FxG9/W0QCj0zDfKgFo0nd0pETUgkCn1tT5t96f?=
 =?us-ascii?Q?HfB1kpnNW0aw6sKlv9VqtPFx3QsdYDc5StBBCeHVaNte0rgY0HoXMAHqNTg8?=
 =?us-ascii?Q?MiUnMthqMRBdj+FkSFl6wQvmvtCnaMOUW89kflT2kk2AjnOJAXDEjPmLBoHY?=
 =?us-ascii?Q?tOHX8oURWXq9/yp+Ko/xKJ75ZAEumfTzgEU6hbXujDClik4yga9vq3DkdJFd?=
 =?us-ascii?Q?9s5YIGe8TkhTWyvgVutM8AALylZ5Xde2icvgWnsmmtWS4VkQp6HZhWFDvy8T?=
 =?us-ascii?Q?FwXJN84cgjlkJ54pG8aFa1EvdSQ/tFlZ+Vl1uo8Khj6shNICKFSSPQvJxjfW?=
 =?us-ascii?Q?OhTS2zs9uvIilmPtQS8DYK3n5ZSU6Cv38NMf63I7gMGWjN2ZyO+iIbDt9qNN?=
 =?us-ascii?Q?ZrkukKOhMb3aFAd8Izoy2CLVrgRyaP8Xu6KrftKCQGTBBhW2pxAVmkHoCv4E?=
 =?us-ascii?Q?hOVh3wEOq/Uq93o7VIfIcpHwOEcpF/UJ3KI2sLHVoQ/zwJMU5LzJ3aTlIcfp?=
 =?us-ascii?Q?E6XI7OV2YKIB+sx/jDIzDJlTf5rqLtX/64kMmVhpPi3EG+HzEcFnVeT857dp?=
 =?us-ascii?Q?C1lof9m5gTmC3sSZcuySHX1vsT/w4RboNStDA0Qa7fWpluY6IRxn3TMICEZY?=
 =?us-ascii?Q?2LJ+cKzoFyQwewCLhPbTgauLAUvAQlMDXU0faWzIIGPYYsEQoe9R8TQh/AxD?=
 =?us-ascii?Q?tVU0Qc6WbiJeqAnteVKxhdjXC2hfFGQy3d9XSpT/rJBBFHxIhhM0BLzaisU+?=
 =?us-ascii?Q?ZZ9KsDASaLlr/uLcP+BDm8ZT4Im0dstbgA0/b1Q2fTvjRx4R+AceuiPWgTS9?=
 =?us-ascii?Q?I2zCNUpsHuMhMinnweEyC++zT/P9tFuHwx6rDoY+wd5YjcBbAHAY7ma4zpvz?=
 =?us-ascii?Q?tgYkVuT14R+febpJ5PyYzvLWVQX6slMPAey91N8wK8tv/qy/cBw5MnpFCtIG?=
 =?us-ascii?Q?V+k2ATKYPhAv/GGCR9EjJJz5BVezoHhKpvtT/CMPsC74xz+QZOaLtWtZDamc?=
 =?us-ascii?Q?6/exfdf4Q4LZgJluws6LCmIMPu9WJgxzWU9GNFGl0hwo9g4VlOn/jPlmirTd?=
 =?us-ascii?Q?YpbbUo2R71RtCUns7A9+tDuwR7vJHxxQKZyZ/XYiz/vdGm3DNSLSci3QymzJ?=
 =?us-ascii?Q?DoZ98FQQpTOc8IQ1yp/EYQ5klC1WDWSXQpBXbExv2OoxP9eeo9mNC4/X59dT?=
 =?us-ascii?Q?wD3K+FXuuU3zgoNo4iP7ylyG2BLdSNYLy1V87zJOUWubxaReDmy5kxdSa2bx?=
 =?us-ascii?Q?LQGPBfZryb4J/tj8/gB/qpHSRKBy0xteWLXG/Uf0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616c2dbc-17c6-4eee-859c-08dc21a7c9a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:26:10.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ajb+madTiW+we/ZUxJkqZkQV5qijfi0211LOOlMxlbXSSu0UHWhUmzGguim2/ET+7xU+9bP418FZbzaLbUALjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9902

Add flexcan2 and flexcan3 for imx8dxl-evk board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    -none

 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 44da3cc331d84..2123d431e0613 100644
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


