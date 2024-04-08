Return-Path: <linux-kernel+bounces-135303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F789BEA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5B11C22670
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503136A333;
	Mon,  8 Apr 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L542gy1t"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2100.outbound.protection.outlook.com [40.107.104.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077B6A337;
	Mon,  8 Apr 2024 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578043; cv=fail; b=qbJQSOXRtqKomqBsyfYbAm2nGGbuMJpZNRnAI9pTMB+THNR+l/op/WHooaRNse3v2qptD758FOwhxc4DY0n1FUqsVNY7nFmju8Yw09p+poD2NYY3u3w9ukn5OCjm/b2eoc2r6NiTsuG/ehHuDHeQ+dowdP0HwqeVmBbozg5mux8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578043; c=relaxed/simple;
	bh=ZHkBYrQbR0L5KMKu/omdGqRQbUYkewuR6DQuddHPaCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rl9i3SiHXn2ibqJotB33Cbu8Cqs+rAeyPeHMedcsrwYAOlpPqa6qI/eqgcD6PCXxXyL0MTaw1u9IB5kp5KstgvFWVCMp1GhowvId76Id03kxluVvvgMXgs9fYSoUKszixXhk1fmckECxjgSGbbar8iSnc+b1/EZjmtOUpLVJU3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=L542gy1t; arc=fail smtp.client-ip=40.107.104.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPNDHnbBS9Y+j14Glr7Q3QA/NGk1sR8AfwPmDAMylf18LhuOoq7NTYaqCUQIoCtWL82Lp4LWuEyhZvN35dP9QoFS601hCmYj/f6C5XbwDxe0eAIVBMMwUaYJft0HsT2br4ZTWe3mpNE9pVMZ9k0dhkaieRl/Ays4BGHvhj2orjeBcwudMNU6VLMaS1275jSSPGhNv5W5fXnSGIckPynsy9QaRYwf6qM8MzZmjlhZxm9qfSgXdeu4jn5wrUD2BieG3Pqyg8WZibX1XG92tpAhGFWYJZPieM5aQ3wmGMn4NYK/GaFcJtzmh68a2VEDOx2FZwhKYDeoApiVIz4fE3kshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TCaknamnu/SmzZJBQSL92jC7qzhNnXOjqDbf/p8Vmw=;
 b=F3J3Le8lUHwvRyvQmWal9d6csAkTPkaFpJY+iKNKb0n2OF4nTvIbX+A5GnJO90w5J7tCYOkBr0lZU91UHSNyeYLmzjqUXClPoLMzyPBnPFWVJbf9CI3MZBLWa6sykuDTOsi+z+AGSGkv+vwSySrlI941uzByncj1JLYJgmXxpub9Qv5sHW9qE8YuxUPxk/iXbp3Ge5XXScq9Q6u9K2uV6gIuhX5PtXO+ehTSmFNFVK/tPXuYtiKD4XVW1ihFCQMMBy52vgwENjazLU4JRugF5ESUrFq+meoJr+6BQ8ODwHqhFFEb8W1Nug0SICgJGszpeblAC9KB/96LVMcbp3+tKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TCaknamnu/SmzZJBQSL92jC7qzhNnXOjqDbf/p8Vmw=;
 b=L542gy1t2rfY3xYQysnLX6qs0YHqOECcrKXm/kHWq+GYALA/eYr8aDZf/kjNPG5Pc5eNrmCRwA8fhscciReZMKYaQnI6WvTylivwYfQwidZHT66P5vybBMvIPJDdlNB33PTnLtW565PT7xnwD7D7DViSxspq6wkpzezzlpN8Ouk=
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10)
 by PA1PR04MB10416.eurprd04.prod.outlook.com (2603:10a6:102:446::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:07:13 +0000
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57]) by PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 12:07:13 +0000
From: Mirela Rabulea <mirela.rabulea@nxp.com>
To: shawnguo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@denx.de,
	festevam@gmail.com,
	alexander.stein@ew.tq-group.com,
	Frank.li@nxp.com,
	ming.qian@nxp.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	mchehab@kernel.org,
	hverkuil@xs4all.nl,
	linux-media@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] arm64: dts: imx8-ss-img: Remove JPEG clock-names
Date: Mon,  8 Apr 2024 15:06:54 +0300
Message-Id: <20240408120654.1196880-2-mirela.rabulea@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408120654.1196880-1-mirela.rabulea@nxp.com>
References: <20240408120654.1196880-1-mirela.rabulea@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0177.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::34) To PAXPR04MB9231.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9231:EE_|PA1PR04MB10416:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jANXkPkFjbkmLlY8qQWcsXH4kYIYSlf587j9/ATHmGpPZobfffABx+DnuDlE1CukY/AQE0Czta5IKDSzO7jfSsoUbK3HY7lPqnkuT8JjesEaHNRCrb640lhoxpOrqyVW4mWYQS07At9hg5aegvWGj9Dl0O6NPR5zTXUVa+MOSH0TOUbz4qvDQHmhop5z9WeSxBUiVIzAvVUlcmY3tn1RS+5s4dCbb+ytu2sjyOzmlYcnwvTFtg5bSxQ6iWYFnVIU5rQMn9oQJidMz98pxC4xCQDv4iuF2/j+b5myQUNTjirxh0yomz2VN7UDn1qa4injiY4PYLuy9zjrEINdsPWVIIMElQikS7Uzmwgdznef8Z27WDNhigWwSUm4KoMvZifnGlr3+VMgZm+4DoTWvX9jwCzf4Q/F0UgXp7lKb8PQM3TALX0V1P30XNJH6Qy+pGTbKg83OAnGvCUdAIt2gY7skYNDUdGj4p+crPdm8F/tnFN3MieLCE/V057a3Av4/LWiRZqRBQtSTjauorylIOVBs6dQNAXLB99jyo3pbbb/Jv6D/Hy7LQXRRb23SVV1wZ15xkpy8Bg74xA/vhUh1um3UgDuaKSl1Wkd65VH8d/td+ady4TR/U6FIcKUyghqr2j8kO8D6QcqPtyO9gl8BswCpjr/kzwUWPNQ5nVaQ5aUIfpoyJ5dGUbILzJsK7ktdHKbOHstvN5H7TZ2IFaRmtzLx7wIjG7cdHceXc4hhIcAzew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9231.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7WpjifQqwWH3N0IM5STexbwdjSNZLTTfUUE+M8cArTPv470slFCqXDpjKAiU?=
 =?us-ascii?Q?FjweKoclSGrRIABEkye4giI0g7PIo42/VD12HRutJKVbaQsMHzPnLp8hJjBX?=
 =?us-ascii?Q?TBqRJ1fcDImyMxEB3RrIHDdmvWDQh0EI1qs3RRgOJqMmg1nrYmDl8bRPf01+?=
 =?us-ascii?Q?ZNzYqDRdRWU98ArgyzxE5FvBEW9wifFmdMEHXy8PBkuIcbCbv6AfcEBs+ahf?=
 =?us-ascii?Q?EMppsiO3GoO5t5ZH08bjmJ8QAQVYPROVYbt8H6hLQj+nCpiYNuiDVduexW1P?=
 =?us-ascii?Q?DtJmmJ/VxIoWniQ+dsfej/rL/lwfiHINRMYPEQKx6gfyRfOVu+B7e3mK/g2n?=
 =?us-ascii?Q?aOs76zpDNmFjOGyYvby+iUTSmY4ZAcGL+IC6EH56CMsDjRUSjUNGhmomwRiR?=
 =?us-ascii?Q?wZiEmQtx2r3n8t1nD0GWPP+NdeECnnniS6M7t0TBkvwgc/yheb0BVCcEHq5j?=
 =?us-ascii?Q?k0tgNKQELGUQ1Knb3vdQUI3vwWulZWsyevau22YPBZOm5ciJYpMMnOvSNDv+?=
 =?us-ascii?Q?OT6WUXt7xbAqbZzzDRzSQR5YHYMoxpKXenAF/xoDSf4qfkZ3Dskl8+8+rYTM?=
 =?us-ascii?Q?kDrjsnvx2A0qiAPfA1MpsUQVKUQbuk/OktNaxZZXCyoWII7KATU9QzQ90BjQ?=
 =?us-ascii?Q?0vLhP1IjER6QinrR4PLe4Uxpc1v+wp1WzCtiOAMVa35ittAYbBoieiLoFvO2?=
 =?us-ascii?Q?+Kf1Q1b1WtWx0FsEzSF3bkOIadBvp6ihCwTcpCA3dL6HeMXxG3Hr/meSqNS2?=
 =?us-ascii?Q?arr4IzDaVtyQ2SlpOR4xs++Uz62y0Vdc0S0ISy58KbhGpDy71h7zBPtUjUTW?=
 =?us-ascii?Q?x5yiYh8f9lv13vmDFB2wZQJt/UL7gGQpI+4Ae4UD91M/vJ3Q3ccmBKSUM2T9?=
 =?us-ascii?Q?pI7EqURHpiEYOEFETbiazxhkxggWh5CgohhGE8/l9dI1YrjhzceIuTRL6wuH?=
 =?us-ascii?Q?xsPfkN84aPl/uFQBco2+gesizOUYIEJFK/wT5RGjjtbYPSJss7x9dQPgmFdj?=
 =?us-ascii?Q?3NNeXfQ0y8LkxGtWeze4kgYIuOZuv/jH3jtAmFbeokRHcKDLn8kV+ukzuM/R?=
 =?us-ascii?Q?FA+bN7vW66rSvpY4DqyBssGOGikWpm8jPZTOkDwtz3ZxCIS2XUZtLmBEQTN+?=
 =?us-ascii?Q?bf8XR+jqFJlfvstDrGBRWV+2crBbfaD3KvsOWxrhxH80J4yfa9NdHdzwUSVn?=
 =?us-ascii?Q?7/rmdgdO8MLQ2CQLw3b+QLW+mYIwpRNzJq2x5aCnEnOgzBnklKJLfqYS/lXp?=
 =?us-ascii?Q?tEuAvJfwRyox/qfb7wg1YW1wBABKQqc1azZErrOorcvr4Wz6T/hkc83vBqAQ?=
 =?us-ascii?Q?UX/Pb39dQWw5YqAzTLVLY0YJEt7rH8tFaUI9f/ZmsyhIbFAfPWfZoTTeD/h9?=
 =?us-ascii?Q?bAvUgd3hvid1W/Q0gI/UiFZTC9namkDORHlxV7EImZdK3Qlu7NmpBcU5Clan?=
 =?us-ascii?Q?N5IA/CiZg5c0oyIYqSWJ3dpcc70sF0Ee2xYNjp9Xi0KSGE1vKFnUhzl1vGVK?=
 =?us-ascii?Q?sdTXLzK59uaxWygbdhbseJ9ZgqJqxQY3BFu2BDFljH9aZ1X0zt27N4C3FC58?=
 =?us-ascii?Q?gDdjo/FU2NmOUdUzap2oU4cyUrUUdyFUA0una0v0QG3QTzwv2sOsqPzVjBNu?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cec0880-1092-4d33-8fb0-08dc57c46cd9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9231.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:07:13.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKyzNdk8N0XJ4Jro0s08vSHAUNBLmVh5Zk8J01cTG5jkrtxQiy3NEzzrk4Ppl5iymhKR23qf9+o+nuwgHFVsmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10416

From: Fabio Estevam <festevam@denx.de>

Per nxp,imx8-jpeg.yaml, the clock-names entry is not valid.

Remove them.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v5:
- Use <festevam@denx.de> address for both Author and Signed-of (Fabio's feedback)
Changes since v4:
- None
Changes since v3:
- Just added "imx8-ss-img:" in the subject

Changes since v2:
- Newly introduced.

 arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index e7783cc2d830..77d2928997b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
@@ -21,7 +21,6 @@ jpegdec: jpegdec@58400000 {
 		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
-		clock-names = "per", "ipg";
 		assigned-clocks = <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
 				  <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
@@ -35,7 +34,6 @@ jpegenc: jpegenc@58450000 {
 		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
 			 <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
-		clock-names = "per", "ipg";
 		assigned-clocks = <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
 				  <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
 		assigned-clock-rates = <200000000>, <200000000>;
-- 
2.25.1


