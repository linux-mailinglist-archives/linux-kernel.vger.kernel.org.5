Return-Path: <linux-kernel+bounces-150963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C558AA733
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF52835B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCDC2AE88;
	Fri, 19 Apr 2024 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W0/LFdyF"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40329CE5;
	Fri, 19 Apr 2024 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497395; cv=fail; b=Kx7B/lWxt3Q6ZIpDBEFjbeBOOLg5mtTiBRmID/cHWHQgW2CF2BKJL7ske8BhoVwnNkxm5tUjn4D858dvxA5blO9ucY9a5zn624DZCepTPenB0G7c88hVSXQQJMEXgpCwUCHZFVT68PfjFt7AKkTX65epNIOehkR5AnvfCXrcHlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497395; c=relaxed/simple;
	bh=a8Yin9UNvJZ1H69GAJ2Gs9KZmurfHKDKhqvvf0HW9hw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aP9CoDDlkgXUPmQ+GZvu4YJS1/5t/90FSiDcyswiGacek4yOcg5cY5HbJQhJkel1UqdW5UsmbgQbt8BRU9+iUP+geB1ANbA1Kqpe8h5UhUDJ4ZBTw1fYaMiskV3VB7AyXWVz+/pFodL7csLkgXGKbyG9tEX75MzXAg4u603iCVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W0/LFdyF; arc=fail smtp.client-ip=40.107.6.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu19XImvL74V4K5+ubGNcP0BGZzxPkQfGmQGKhEq27TiGlS4q/b3O3a0DhnJe8Z9PZB71xq6C5tjMlfv3AdvxOivahp8yi8Gy6wNRotbRniEZTOE3CxR10E4i2Yc+GShsgzBth0Lawlt3XneEhf/Hi8YoX7DLbVVKsdu8Go0UnTJs7WWzjDBJADaj8qKf5u0fY01S6ZW8xNOKljBgSZp7AjN7kpYeYvLgkqQSepCqrZ0Y9DYQdtK2HKJ1fCOzaQFK3SNu4uoTMdl0OuS5w0NqOKusWxbRDWklLgFEYg/te2t/ynNSVMvKKKyLJoWLuob72mo/U7y0MlvogMsfL25jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3NVyXgePVeYYgwWIWlhBWJiZIvg/AVy+K9WBcxlvX0=;
 b=EpmG1QuAALtTIh5pe8DeCHROFaailGodEJEX+i8dmQZnMeAtucxz8/i9SdtLqtoP4wlQS36Uhkx6rYh6x6WHx6Rye4sKU7Cty3U51EKk58YO9BkQ05nXkX3NDM6nZVZ058D0HS6OYg+DKl3jSOtgWMOUfi9eeh2DkWSb0mzWq4C6lC17ySoMQZkeAbqz4+t1XzvTmBHQ6pDJKRJXJh6CQyuKVope0fDaIWhapxrHxC7Kb9DU+aCi8q0CX2dHzGMBZt/BVCj7PZQY1MHdI/DkVYALjmSeUZCn+Ju0QTPZg7+6by5doU4R5csuPLJLtUBP7hLHoD8tFAhraTQzQGOChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3NVyXgePVeYYgwWIWlhBWJiZIvg/AVy+K9WBcxlvX0=;
 b=W0/LFdyFd4fvtbh29UfWeMkLXPKCSkrSTwr+NLa/AtPtQVBC23TCi6rIjatcEnm8sE+2Kzru8c21lTxBy1Z1zgX3+YLrj9FrfeHBh8XbgImQujvg/dntsIx+8SAVPrZBC+ihsWPCGaAxmgKkT6J574sgefgi7uCeI0I3CzW2wEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:37:05 +0800
Subject: [PATCH v2 10/12] arm64: dts: imx93-11x11-evk: add sleep pinctrl
 for sdhc2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-10-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=1902;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=IkgkzajW3i1/2uBfzzBinYnK7req5nUwjI0YrZQay6g=;
 b=hci03aqo6vL+ELpg33s+D1JzSKFLo4+HTokNTzFGGiKtmq6cUNyL/2kqWpL6Mmv1sgzrQSt/J
 lRLgdkIGXCCD7gIHpHWNdOn6iLHsQXc2yfiwl9xjh6I/RR9HMWGjIIE
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ca031a-328f-4dfc-9d97-08dc6020f84d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zhlqdh2aixgbEHyYX4MrejVUcfga5862IfGNi00n717kUo2D1dHTa+FyDpTNv6XzWVEKcTdrHJLzHyTSmMH+JXyPkCIx0zwfoJjr0PEXON77zbfiO33yLEwBnljTuPULg5zkPcZa6cPI53/97WMZOl9Gp+awl4m2wUXwnmlj8M1zE0EEcljzwcSze0AwoG6QR/obdcQJgt9mN7XEE5fDnln0/6g0WCfjtr+fhjhlugUnJ33RzDYDJtoHM7rFcsqUmI9YTtuTLJ50/7SurWIOvcCm4pfQPBcSik1GbcVAKkpKU61B6ZCA3dGnEE743GMnPbQZhad30Dex8w98Z0Apm7GkU2vsNegSAzaXqXUypa8maIe/3nfhZ8E4Cdw6aizvbTbDjZRZYVuSH/7z91VBPifZcvPvZtarab748dCqYB9UhcAwH/ZyD7xia/koioq0IgOlOuw0aEfKyRN+5EJs4iIMGjU/r3T8ZNKIB0JtgA0KY4jCNRKFbWWSEfHTqML9+mOyUigYTWwaATHfObsUGHm5AapBaFG5g/QeZIexKrKli/V3s9fs/BqzjFqQ0QX12zT0Tdshdq4GfpoOmb5iquDf21D67ZUf4qAOmAFlpR8/bxHU4YkCU7uPIjkjpl81uwnt4jD35jzdaeumr7oSVt3TtjvoXn/7pqdXa7vlpAuL+CaLHTd02GQv3mke7wHD1qlKvXzKBDpNUj5l+DMgjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUxKOE00OFBHeXNCSW5xU3lPWVFjTFhCS0hRU3M2bk5OSFJ3OVFrMmYvU1ZB?=
 =?utf-8?B?L0kzamRVNHpnUjQzNjdGSm54enQ1bUtseDRpUGt5Vno1THgwNThGVkxXOFdj?=
 =?utf-8?B?UmdWVlg4eEU4OE1yb09rU1ZIOXdPVkJicGRVSVJXZjRnUERKalRUNUhncGYr?=
 =?utf-8?B?dXkvbEJ2blZ4NE9tTWRjWVRjYnBsbm9ENk04VWVnckpXSUowcEl5aXVSUEs5?=
 =?utf-8?B?TEdSSHhqaHJrWDNxaDhreHF5TytOYldibWl3cnRRbHYvNmRuWExNOTBWL3JN?=
 =?utf-8?B?NVJKT0RFVEJHOUZiWXd5Tk90ZURyVHFqbHlwN1F0OTBMU1lwOHhpN01NNTZh?=
 =?utf-8?B?eE14WmppUlBsYUZueEd5VFk4UWppVW9LNloybXhrdjVEdkhnUXB0TnBZYnlM?=
 =?utf-8?B?bHJ4QjBoT2RtS3VMNS8wNGJ2YmpqVzNsa1ZxK2Z4cUk3aWZWUXgrS2RXVzVI?=
 =?utf-8?B?OHhyQmNOblRKUU9NQkFYSHBNeElPS0tYYkdWQ3hDaThPU2pYRVRhcm1jRGt0?=
 =?utf-8?B?cERkMkphaXQ2WTRKaUlLWkVQR1Q0ZTZSNStFYnNqd3A5ZHRVTFNBTjN5RVp4?=
 =?utf-8?B?RFZGMk1HQVFiMEozT2h1b2xYNnhCMkxyQ21sT2dGamhvRnpxdWdzV0VEODkw?=
 =?utf-8?B?c2JYL3RWTStuNzFJWlY2Q3NrVTl2QXRsMmJuL2dnT2Z2ZWhER0EwL2F5eWxE?=
 =?utf-8?B?UTBFbk9zSml5TWljdWdrZko1bUMrNFRvMXJFeXQxL0lrb2NNcllCZEJickgv?=
 =?utf-8?B?WmJmbFAxa0VhM3Q4Yk9FUjIvd1ZWMmZ3VXZtS2wvSjltazlBOEtobWpudlM4?=
 =?utf-8?B?bkE4UGY3ZHA2RlcvdEh6MWh4VzdGYllwSFpSeXlBaFBkRkVYVmI0YWoyWHkr?=
 =?utf-8?B?cGNrSVl6OW16NHJ1NEhYSFZhY2VWdW9OcEU1c09VVmFpb28wRGpKNWVVNHdV?=
 =?utf-8?B?ZXF5QU1SN01ncVBGTkQ2ZE9zaHNSMTZMMytSeGNoZDZBYWtxQ1U1ZGFidFJD?=
 =?utf-8?B?Z3FBWGxzejIrYXJlMmVVU2ZjVkRTTC9YOU9MeEJBRC9sQ3FoTnpWSkwrMFhw?=
 =?utf-8?B?KzVCWFVSSmR3QzI1VmVRMCt6Qld0ZDJxblJOcDZPZUozeW5xTDRudzlSOTBl?=
 =?utf-8?B?UmI3OUlNbXRlUVM0eGpoU2ZTVGR3UmtmVWNZdFRFT25GTUNhVTZ3TURtSnZY?=
 =?utf-8?B?b2JkeG1PYlZYQ1g3MjFCdjhVanVBL0RTdllsWUJ2aFphYnEybkZqSnI5Tm5K?=
 =?utf-8?B?eDRnV1BkZ2xkc0pHY3BYeFZ3U2ZVeXZrUzN5WGFldTA4REJzYXhLSXEwMlVC?=
 =?utf-8?B?ZWlld2RkR2VBci9SdE5qazNlMlpXdHRKRzZmVFU3RmNjc1Z2RUdPazFhQU1U?=
 =?utf-8?B?cHNEOWtqZjdoU2tQdFBWYUNTN3VTSy9uYkZEME13WC9BdUxFY1NSKzVaZmJi?=
 =?utf-8?B?azg0Z2JyOXY3eWpBTnBCT0sxQjVkbE9Gc0VXeUlwTFI0OGoxUE5mRGREV0NV?=
 =?utf-8?B?RnNDNm5lVDdvblZSV1NFeHpGeXdOMytqTm8rOTlneDVGdHVQY3VYSTFSRXhJ?=
 =?utf-8?B?RDJhZ2QzNXNkZ1M5TzZxSnVTK3RkOEtNOTY0R2pWR1ZQdkZnVWkxM2N2NzdV?=
 =?utf-8?B?R3Q1ZVJtTXF3WUZVaGlIa3hETU1hZFhsOThGYUVQUFNvYjg2MndZODJJN2Y0?=
 =?utf-8?B?NHhjWDZxQXpnRHhONzNmajRKKzdXTVBFcmd6d3lNMnNsczRhVzZxZ1o3NUl2?=
 =?utf-8?B?SVN0MHZSRW9sL0JyMDl4dWRaRzZBQ3g2K0phWHFud1A3a0RMOUlYdWpTWURY?=
 =?utf-8?B?Y0V3K0ZWMTJuM09qZVptYWdvNmhSclZ5Vmp3Q1I2cUVhMmpCclg4cXN3VFAv?=
 =?utf-8?B?dTE2RHdlNmlNdnhUajFpcFphVEFoU1JWbmovNVZlb3ZyQVZBZHMvN0V2L0FG?=
 =?utf-8?B?ZU1tdW1iUnFCZGRrY2pKWS8xMy9CNkMyTGtZWTN2SEUwUStFVGVSbkUwRFVr?=
 =?utf-8?B?TXdlZjF0emZsRWhuVUVuaTk0UjEvUXU1dmo2R3k0VGxEd1Y5YW1jTmZYZUtR?=
 =?utf-8?B?Y2VVTWdCNnVUUFdkeXRWMmc4aTZHNjlxQjhFenpoQzliTkJlYm1mM1F5aVlX?=
 =?utf-8?Q?CDs9g1EHTCsSJTtLzTtiyIpEl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ca031a-328f-4dfc-9d97-08dc6020f84d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:50.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8Twk5YJwZ/x0GRupXnW3hqPf+lz1ztncWSNZZeDvOEm7KmFlzLtN9CywvZRbUzmLyuFfhVsGm/ea9jY0G09fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Peng Fan <peng.fan@nxp.com>

Add sleep pinctrl for SDHC2 for suspend usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index f848cb0922ef..b29d470d2492 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -169,10 +169,11 @@ &usdhc1 {
 };
 
 &usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
 	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 	bus-width = <4>;
@@ -452,6 +453,12 @@ MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
 		>;
 	};
 
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x51e
+		>;
+	};
+
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
@@ -490,4 +497,17 @@ MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x400013fe
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
 		>;
 	};
+
+	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__GPIO3_IO01            0x51e
+			MX93_PAD_SD2_CMD__GPIO3_IO02		0x51e
+			MX93_PAD_SD2_DATA0__GPIO3_IO03		0x51e
+			MX93_PAD_SD2_DATA1__GPIO3_IO04		0x51e
+			MX93_PAD_SD2_DATA2__GPIO3_IO05		0x51e
+			MX93_PAD_SD2_DATA3__GPIO3_IO06		0x51e
+			MX93_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
+		>;
+	};
+
 };

-- 
2.37.1


