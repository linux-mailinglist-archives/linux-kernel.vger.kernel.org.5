Return-Path: <linux-kernel+bounces-81434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C545D8675E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F5E1C28EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B185621;
	Mon, 26 Feb 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DNCgVoqy"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692882C8D;
	Mon, 26 Feb 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952428; cv=fail; b=NJs20H1QlRp4G2sH5Lti4Sk/NE78gV+ZiEiWG2Fwc72cud9n1S1gmBmqlZVIztCBNGC0yal3y1l72ZtXE1ygYznWYLrF251X0O07/Cz4fK7Qhyx3TAFEmTOkCon0BbpSSWJhOTQ4qSuPw0s1FEmlORElZ+Rl4QmwI35sehojQZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952428; c=relaxed/simple;
	bh=KTScA5iNgIYRjBFV39Yu+GndLndqZqNZYgb3horfS8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AFJXvZSkwMafpUNmkiP6PHrBwitlYD82qiD6c0FEB5AT+rLFKnwV06IfYSzot+DYlTTeSsb96LgRsOMki7Dc2oxJ/YEF0H2/ASdxDH3SYt9B2z/Ekg2GG6AQvn+hXnoYpKT5E+zNFJBFU5e78cyeW7psKDpxOzm0jDkDApViPwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DNCgVoqy; arc=fail smtp.client-ip=40.107.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQEMtKWUEfE36fbb3v2TQlYSg+kMgw2JH/ibDjDyU0P+75uVvToRQUvGZ7ZwfcnC+3H5xd/kt0k2thpnAQ2zFR5Wr74sKl0VsLO10FcTNxpVBkPCVU6l9l19L0h1ebBwq55svssHrdm3Ir57IMQsclYUDb2APFeXGAc6LGHbe2lweqIM2vvI6LNo4D85gJCunpHPC4S4Ym9cMxte6wq/SWRnZ8fj2tnSiqbiPdwUgZ37bo2YsNs/H5nlvDP7+SNmhnMnAVJ5IFmdy3bAhi7cJmK3abaPOq3L4YIKH97IsIZXqv2Z4nDQ97esKG01Ovt9Ar9rtaLLNK8lv63T3I01wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFvdRDUoO0cyMDlHCBxKHVprw3Af+OGIp872PkY53TY=;
 b=XXbO6e2hHQYnHqxCQwIZKE+jbeMpRR+vTOwwBPdUMeMV/y0Cp9VlCTTFzlJo6c1xr3zH0q7OAFH2l3v0lQK5W4cZ1a24qVFLfAov1lYhNigE3WR94nUyr+1NJ/VMSHvYgt2gA9Xo2p57eowvZ1gH7r1Ggh71UHoPm5+23Z4LNGwb70+pAnNPB2Ui+7EnPxPxTeXA3JvJUFNGvdkWuiGIjQiX6904hcRGd6l9K3gFMoD4FiAdjJKFQ1pOGcoi89RNVBfS7I7x2M3KDIlc7TN/AHVY+v/nzVIGutnPb58oMgT/vcEn9hpIz7VpfQRLZxRDXY9y+dgKZUYhfUmtYO0Gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFvdRDUoO0cyMDlHCBxKHVprw3Af+OGIp872PkY53TY=;
 b=DNCgVoqys1P7bQeST5MqIrnF2nw4rlxjjvb6UiOzriOeRC52DG9fy3GR7+ERu5MYSQdaqN2XAozI+p5nVF6YnDjcznJYgEfVISPFq3wc5TGUZ7PP5WFzoPtyifith1wkqekLxxKR7Th9CqMNK5tBkNf5jcsUpysONxbm4or2+dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6865.eurprd04.prod.outlook.com (2603:10a6:208:181::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 13:00:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 13:00:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: haibo.chen@nxp.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: festevam@gmail.com,
	linux-imx@nxp.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx93: drop the 4th interrupt for ADC
Date: Mon, 26 Feb 2024 21:08:26 +0800
Message-Id: <20240226130826.3824251-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240226130826.3824251-1-peng.fan@oss.nxp.com>
References: <20240226130826.3824251-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dcda4d-3414-47ed-ff7b-08dc36cae4cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hSnYC5numO4nMknEl9pQM+JtLI07raEaZrPdKx/q8LGWdlrxSqp8AxQPMzu1QHatjBFYgUtlSrjvcMZHdzCCGPIj+p0hkWhtK6vNTSY3gBGPxcQCydxl7JdIs0pLfMGj44Q7NFG+YkG7RNm57I9tzFr6BVJi/s9ncSJ+vL1SDPdT9Ig4wE8yoVia1F0CbyeqhJSB8AO2jxO+2tDULP6UBwwvXY1iFbgyHC6J1wwGhuqXCJG/BRfjzHAr8VRWAXURWfgoNiMEZDUWIG4Bu+9DdHQ7aXR392wZBiPQQfcqM0eaJY5LoyL8vmunGOZzMA27Ag75FqqHdQDoRl3EL3poox502eQNZ/Io6EiQqOsoCE2xshK/KfFr/uApAYN0LUg4tZolNmAXFu7W8kGDPEOn19L+XUFc0uOPZsj+t0NGpAsBJnmrZXrTwfbpGC7mxhgXO4K42U+OunstRERiuWMgLUCrZKTQMp2NFQWfCRNGJFmBfdvhacKcs5qawoi6u2heW9zC2OPsNudkfugpboyZfD8QDORdg/kaoOgTquPErT6Jl5h1Q4AD6tf/Khq2WHxK6pHWs2BKX75lN2UPkhQk0hPMO2xom7lFaPoDaal6Ii4JJDALK02zLT5td+oItldl5cd5YoCQGasmMj6eAPCMJTkvBMaEqJ1MZofVYeFHbVK/rmYOCC2FgJPMVQ55PVd3QD58WxfS3uFfnx2mOwcKpllniRLOGPkwZS5IVn2qCBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fTa/ZIf3Wb36MRy0MKeRG1NJEiqU6rBYFQxQW0rOD8Qp+NDP6zK/ReKm+he6?=
 =?us-ascii?Q?49lcd6H18tk9T/MSfe++x/o0IV48lrFCKC4PWYpAvlBd7biuFJ/abrorFSwX?=
 =?us-ascii?Q?cSN5SP3rqmSGaSAeKv3+Dmp6wNopas2ol4YJ4Y7pe/MTD/eKJwp5AVmtfqVz?=
 =?us-ascii?Q?qa3jhNKQNbhDxZQmm/s06N6zva4B7P2FoMGyWkPvsT4UrJMzxIotvElW/Dom?=
 =?us-ascii?Q?GMGBeZe3hKKxtEp+hPnL/xYyeK02gmBfSLFk0/xNt4IhTmJRJDiijqMFAyx9?=
 =?us-ascii?Q?2g6A0rxM68TEG6R3TpKmVLUTb11uhgoFAYdvAxpLO2xSivL4ux3OTh/CjZNy?=
 =?us-ascii?Q?8mD7xBkBnR4JFc5QcoHcnWV08YRHj/HfCZSTo0neIBPl12IOPjrs+kuuOFqH?=
 =?us-ascii?Q?CyXXXBxupvDAzLtMy/bRG4t/EVUAhGSoBouQAmHfyterYlK04lrzXUvrk/1c?=
 =?us-ascii?Q?LqRgnVbPGFDPX8LMKuYX+AJQkKqY877DUjFmpzMCl2pQ1F01cQ0NvkbKZQVy?=
 =?us-ascii?Q?24TiGbmPNP7b8iIs6sjPvFwxoDqPfrXRGZvNRxP18KOJgTeYQcdutG+Hl0CB?=
 =?us-ascii?Q?FAbDOCYHjBuTurWiDiBx3mIEsQ4bxvFrmb2Uv1fVZRoIv/ogJbfBkTjHwx6u?=
 =?us-ascii?Q?+aC2Gb9D3+xG8D+cc36jwlrh207p7PZTsFanwFKXqlR4vGhDIneSLvGH4SCZ?=
 =?us-ascii?Q?jM430NN8bU+2etRI7D3pkoaya3Q/BeXr2BsGL2Yx4V1Yyl1mTpOLziJrQ2am?=
 =?us-ascii?Q?Ci+m/bQCwTgINfoXuCPFS+mTKvo+cOeEbkGakFnIzRStPJvP1g+oZDfydPZD?=
 =?us-ascii?Q?XuSdhcK1fM4Ln+B9GT76Bor1Il6/b3lP7kcA+Cu5FNKQ1PZlnzDECBL1HeeN?=
 =?us-ascii?Q?NJM4NTK0DfIKiM12C26UVs39JRGkS+nExWIlbTjw9NjrSm821YNVzLoEwWXr?=
 =?us-ascii?Q?BjZax//QI5lAPPZwa4TPbhoD22DtBRW1CNe3qR+9YP+j9W+M7qDelqsAbV6m?=
 =?us-ascii?Q?6ZYJF2JpcCz1WupajHjdbSnAdEiuufZtwAceOdoO6xzzfKzo3zlxrRIL2RNV?=
 =?us-ascii?Q?1gSo15xBLKdCPLNs3jAdpQsGHRtCKIRnDbLlW/L6RAmO32yb7u5Wguhq7U8o?=
 =?us-ascii?Q?KIx8KdOeyd4DlohP9AFt/aZ0KYdXhtaw2Vad/tTgGxiF7FpF/DLmWjfrI+gx?=
 =?us-ascii?Q?qr/A9dyT/rIbwHTzUBKMpi5SXd5BKaH8yfbIcse8wlvyBtWmY27904qn/m/y?=
 =?us-ascii?Q?23Sg04ZJtJEld6mHBeKMeWbCNQkBBpj5KqA3YLfJy6Fsx0dE/MlOawgz8xY8?=
 =?us-ascii?Q?zCyC7g2e448iJs0vT9+E6Ka6KIK42OxJGnLagQyE3870ETOcktDwDlZ01Ynu?=
 =?us-ascii?Q?sQZJ/4LlbKkc7MTiQlw4r6XiKnUrG/1fv5ifaRjIGQ6f/m7MAMU1uetj7Bj7?=
 =?us-ascii?Q?YnFu0mU36Qz3Oi04MI76yyF5bmM4InG1dEYHGGOIko9Mz3CxhV/RIVrIvmBW?=
 =?us-ascii?Q?GOJwUydDDWBu7bXyFzyNp3HwwdDXTVs5aW555HPbBBm6XS/dmraUBq0s22uN?=
 =?us-ascii?Q?obvVx95QXPJiIdgWa9K3E4hWWlvczknWx/mssk57?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dcda4d-3414-47ed-ff7b-08dc36cae4cf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 13:00:23.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1GFNcrqywRQUvcLbyAxJcJq8DSRoXJ4PkgTEjJUl+TeJN1zeXcevxHTTxyoO/r82Dnv484w5U/9FaV/PAeOow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6865

From: Peng Fan <peng.fan@nxp.com>

Per i.MX93 Reference Mannual Rev.4, 12/2023, there is no interrupt 268,
drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 601c94e1fac8..b8ef9b938856 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -509,8 +509,7 @@ adc1: adc@44530000 {
 				reg = <0x44530000 0x10000>;
 				interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+					     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_ADC1_GATE>;
 				clock-names = "ipg";
 				#io-channel-cells = <1>;
-- 
2.37.1


