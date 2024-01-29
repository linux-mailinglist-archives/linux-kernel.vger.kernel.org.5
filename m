Return-Path: <linux-kernel+bounces-43457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1854841418
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90BFB241D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21BA156967;
	Mon, 29 Jan 2024 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="McvW9+B3"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048D7604A;
	Mon, 29 Jan 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559417; cv=fail; b=tda1jNQhXxNG1A1s8rp0iw6t8Iz9JSX8g2iurTvAHFrM2JGcTxEs1KPQA977d3fTrMs5L3X3FPtQXd8ERpuVki/bswoaQXM4vUxblTakHqhG+i9nF6Dc8aqx6dnR6G7GGGhGgc9DFqxK0nso06woXFzhWwoi1LyhuSh0+252Idk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559417; c=relaxed/simple;
	bh=RuPGceKsuWshKDWgwpcbzC7UV24LS/+ioYc257ehz+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gwmWDR56yQ3dbwm0p43Bbsw3vCeBuGNu/fpqADztvOx/ZQOztq20+jsP6xqcJQG9yVHlJU4IdsVbXDLEBis8DDBSdYsIMwXTWdFLoixfJEWWvLksPE6FVJ+XDCQv2DQvbADy9/P0n8hv2DCfsbrL3QuCmqY6bLnfFCCcRVWb7z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=McvW9+B3; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo7nWNqIYXIkLvt4TeAv/WicUgf1Nwao40JhuaPhWZwHbgLwPvuZi59cFUghJXpEm4ucx3teAJbFKeFtUiJsfCVv3ayxI6B6VG0OAbvz8C/bUhpqD+prLTPW9ceY6yZ7sBtLiCAAGN51gfyBehehl1sz9es8EXEBxAi5v42kxHYqb6RoVMEH6oFGZI4RS4zVColuPriFMi+C2fMxGaU3BgssYz2jowVdAJwOrDU5/MjATGs8FM5aT5qcHfAZqKK/I+tPgTfjtHCaVXmku1ynFSoQEGpet07gZeX/sajyh64ZPhdgc5kh+Y6StO27H8bsQe0HYP9F7gztzsZNLonJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvYXFO1hSEfagHRw9Co8dNOxLvgllsUiYifS82qpah4=;
 b=impghooIS8TgYVJfkWZiPaTg1AycfszSXAgkNhgunZoYlBldLQFPvTzBRNSKj2rBrcN/ZuyiMeWfzx9SxXVNCui5/Ldo1yhM0yPE+TcNc0CM3sYUcZMKDjv0S4OXmEBkuEIEuoXVXSDk8gEfkKCT/lPJkQCxi7dSZ/QzDNYh3+zmuns2sru9lHTfTm900VD7oZvpNI2UkNLND1hilpUin00bDan/lXiOhMNJlVMoyizmYPZJqqy65+Dco8IHT/H5yaIWAaNYuU3j1a6kq7FVVGP7vQcSQuh4YWfhlylVYnmA1KAoI5JVLiFcOWKaHfjVZ4jPIwHpqnhGnnqjl30Xow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvYXFO1hSEfagHRw9Co8dNOxLvgllsUiYifS82qpah4=;
 b=McvW9+B3RNe4sN8eWbV2NqNmyJVlxMrDGCkLjI9X256Kb9sIEbh6mRyDix1PaYsTtYEVFO7f5REYzer/ySiy65K4TBdAbBQulNLzgjIs7zcWEB/2yFL7ZgIHgWJ6Z9xhu4+YM6r1zGixzadf2v9nhAA/y/trWCSV+B5rgriNHoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 20:16:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 20:16:53 +0000
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
Subject: [PATCH 2/2] arm64: dts: imx8dxl update edma0 information
Date: Mon, 29 Jan 2024 15:16:32 -0500
Message-Id: <20240129201633.234255-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129201633.234255-1-Frank.Li@nxp.com>
References: <20240129201633.234255-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0150.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: fac2a3e6-79c3-48bc-d3cc-08dc21073be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2jNPY1PvvbH42fMRsSR9S2Q9B/YL4WlmCZz8oWq4RuoU4lhWsJRF8L9mE9z6qnzkCvZFJsRXoeWfQHLtU5c/XhjVyeoVEfeNkxL40uhwFXIv4miKBZSb5DjZ00bQollL7FdaryR1Ey7AUOIcx6XjA/Mhyn0yEfOgCW49gRjTc1F1te4b8/of0AuD+gILrOWsr5kZs6yQXp+cG4C9AGcOV1VLJ7DBY+BMTg2t+6CFvscWQxXugaFPAI8Aaq9ZSlCD/pRdC1vYS72XHSpwwst2UtsNzmn/6jtH+AUAl1p7Gt/0l4ZzJOjvCeMwA2Lr0ItRI+b7AFX40iwyvIX8HgyPofl/z6k9g+qFYbKrY9B6PIIhV8DfX4ERSATB8OGYYvpPBTq0djDxskk/gYrItEWZNx0ZmILBT+PHJ0KxDbWVrqSYhw1cf3HAj39VUhKz+d9gG6DHstTpehGNDjtxE44V4A/dTPnMRTMDFXqUB7SErgqJNM8U9rVDf6QaacdE3gKkDprnaWW0ELLqYn+4OiNOFBuD/myOTUesSJiN510caV5S/6P6o9eJQcbUrdF7py0uGQyyVntGaM3ln0vTeydDjRmnwbdrl7/6Xkov2J1aHgcMRIF75/QntbPtBTRECrDFqcGoAVmojJ25GacvvbiVPmj57uwg1FE8NOWKlds1rpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(5660300002)(8936002)(4326008)(8676002)(7416002)(86362001)(15650500001)(110136005)(2906002)(316002)(38350700005)(36756003)(66476007)(66946007)(38100700002)(6506007)(6512007)(478600001)(52116002)(6666004)(83380400001)(6486002)(1076003)(41300700001)(26005)(921011)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZQ1UX2HPBqORU8/3M+ZR5BF/ngXpm0U3eIuGrhC1MYUyyP9IisTJVi5o9iFg?=
 =?us-ascii?Q?lYEvUtLKr0GgR8O5PPXgqJzmMf/SfKBGV52ema6UM26lpQMDQnrIOJAzS0kY?=
 =?us-ascii?Q?ST2IYaoCBnXONzhaQBVm2YL+eXEx9MhRLUiRK/2sfeWftRhJi/SwiF90Xvqg?=
 =?us-ascii?Q?FLhtPSHshK8/lPCPr6HxrW92YGc8LvXgDznBFudZnhr0lNFw32pVhLo/ikNy?=
 =?us-ascii?Q?b88EgCN8MzzdEu1eBdgYvASCwjYFKgQu3S9XVhUfMcqLG+TI8e5IQIQ/gb9m?=
 =?us-ascii?Q?aF/pDn5arGm9IJCxDbzA0AiK4STtIcilyOMTLgDK7ZZR0Gcg4UJMQSbJD+vD?=
 =?us-ascii?Q?Ek8XioO2J/aECE1JFs4WAhfX8YbuJmnLtb9D1IkLUBPPQatU0k2OHR+IYi+y?=
 =?us-ascii?Q?hKe3fuZR9btanTzx6faIxjMLkvznD5DmEOfbCn8ajaUK/YH30LuyecN4qhNQ?=
 =?us-ascii?Q?4X9YuOnxxA8O/xljCm/WjcEmlTQirGnez+kTPsFAECKMkspixZXXeNflqvyo?=
 =?us-ascii?Q?SpVGOI0fZqEX2BA0pk2Ca/HPjUuHsEFG+dk3uHyu2QjqQcc1NjWcpkyEAzU3?=
 =?us-ascii?Q?SO2gJGcchAGv7tt7Pa/be/ZhRVWKV7Z51RnSmLp34dyHs39MuN+7zOuCiyKF?=
 =?us-ascii?Q?onccbm48qMAGdIFF4479QdbqV9mWYBYy+XgbgO9Xfg5rjrDoa9tG0WgRDvwO?=
 =?us-ascii?Q?5yeI6JmJGO6SPDMKY82K2sHfWZKMSEwY22AGv6RKU+EGW6ZRZkRI36zAIh7R?=
 =?us-ascii?Q?xKCfzFEnGdwB5VFRNS9mdHvzTzETebjh6BN6jfGfqENZRI79RV2mj3MiV5qY?=
 =?us-ascii?Q?yA5U2QVyOpUcAlDgnHVBcI1lUSj4Go/cg4JAG8erQOsX8/8UALM/H2LbGOdO?=
 =?us-ascii?Q?7IFlUz/iGZ0IxLAoKsGZvedx5itEu3+/LXHGunIfim6IU9prHkxRFZjLsu4i?=
 =?us-ascii?Q?h8CkdGyLajJnZ00NZbsQX8NjpWW18ds5FZVUhDAQNOQ5XoZl6VDmkkIQi20U?=
 =?us-ascii?Q?LY5980rU4BeUP5EJoZqZ7I5yW5nTpYq/8fJcPOjW9ABI2ygoqceiiLKlkatL?=
 =?us-ascii?Q?ODNSh+LwlFMsBy7ejLb9QDJYJk88XNiSZluZeq99thzQ6SwFhwibYbx1Gnrh?=
 =?us-ascii?Q?xpcKhh8THmM6bRzNx93gZyBvwmmZ2on033SUDY26XzHLyG//qtFpharO0KlQ?=
 =?us-ascii?Q?ZQAyV/K9GvqheSvYfOl7YU1YFYg85cK27DtZYtmDgm3TWu6Bs/NzLtgEcTP3?=
 =?us-ascii?Q?7RQwvwqXxSarJW/3fzc+wZVr2GLahXvsIuzY6T3EsCSdPSuvxZuIgjRiJWra?=
 =?us-ascii?Q?9LWqLUN1aVyf6O/fgnLophHjbBX3ga9ipzDzWpWeX68bjdEvLlaI3y3GAQ6T?=
 =?us-ascii?Q?jNknIZqaG7JcyczZ8OWTUzEHKMh3NAiRBy8gDSqHDzR58jabGrYEblyXY0bd?=
 =?us-ascii?Q?Lw3LQDn4Q6PAqK90B9V45Q4c4uchIH7hgO3aw5nPfoqR2BxQi2foPI9I5gGa?=
 =?us-ascii?Q?Uc+83c4GJffIGOYbXBydTktOq1kFr/DPW8p1hPbMC0VcYxdK+BzWmagd6r5W?=
 =?us-ascii?Q?QEnXmYZcCR0YcyAUI24pjBCDuHXl2c3EhxEtlPSt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac2a3e6-79c3-48bc-d3cc-08dc21073be4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 20:16:53.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaFU48xuwDdg/tPPZ3lyJ3DJhz94wKTyodH/a+kh9/6Z3D6yDfbujAMR395VpcZUnDN3VsWbPZQ/orq/RPjLnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213

edma0 of iMX8DXL is difference with other imx8 chips. Update register's
size, channel number and power-domain.
Update i2c[0-3] channel number information.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 0a477f6318f15..f8fca86babda7 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -15,6 +15,63 @@ &adc0 {
 	interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&edma0 {
+	reg = <0x591f0000 0x1a0000>;
+	#dma-cells = <3>;
+	dma-channels = <25>;
+	dma-channel-mask = <0x1c0cc0>;
+	interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>, /* asrc 0 */
+		<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>, /* spdif0 */
+		<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>, /* sai0 */
+		<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>, /* sai1 */
+		<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>, /* sai2 */
+		<GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>, /* sai3 */
+		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>, /* gpt0 */
+		<GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>, /* gpt1 */
+		<GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>, /* gpt2 */
+		<GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>; /* gpt3 */
+	power-domains = <&pd IMX_SC_R_DMA_0_CH0>,
+			<&pd IMX_SC_R_DMA_0_CH1>,
+			<&pd IMX_SC_R_DMA_0_CH2>,
+			<&pd IMX_SC_R_DMA_0_CH3>,
+			<&pd IMX_SC_R_DMA_0_CH4>,
+			<&pd IMX_SC_R_DMA_0_CH5>,
+			<&pd IMX_SC_R_DMA_0_CH6>,
+			<&pd IMX_SC_R_DMA_0_CH7>,
+			<&pd IMX_SC_R_DMA_0_CH8>,
+			<&pd IMX_SC_R_DMA_0_CH9>,
+			<&pd IMX_SC_R_DMA_0_CH10>,
+			<&pd IMX_SC_R_DMA_0_CH11>,
+			<&pd IMX_SC_R_DMA_0_CH12>,
+			<&pd IMX_SC_R_DMA_0_CH13>,
+			<&pd IMX_SC_R_DMA_0_CH14>,
+			<&pd IMX_SC_R_DMA_0_CH15>,
+			<&pd IMX_SC_R_DMA_0_CH16>,
+			<&pd IMX_SC_R_DMA_0_CH17>,
+			<&pd IMX_SC_R_DMA_0_CH18>,
+			<&pd IMX_SC_R_DMA_0_CH19>,
+			<&pd IMX_SC_R_DMA_0_CH20>,
+			<&pd IMX_SC_R_DMA_0_CH21>,
+			<&pd IMX_SC_R_DMA_0_CH22>,
+			<&pd IMX_SC_R_DMA_0_CH23>,
+			<&pd IMX_SC_R_DMA_0_CH24>;
+};
+
 &edma2 {
 	interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
@@ -48,21 +105,29 @@ &edma3 {
 &i2c0 {
 	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
 	interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+	dma-names = "tx","rx";
+	dmas = <&edma3 1 0 0>, <&edma3 0 0 FSL_EDMA_RX>;
 };
 
 &i2c1 {
 	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
 	interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+	dma-names = "tx","rx";
+	dmas = <&edma3 3 0 0>, <&edma3 2 0 FSL_EDMA_RX>;
 };
 
 &i2c2 {
 	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
 	interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+	dma-names = "tx","rx";
+	dmas = <&edma3 5 0 0>, <&edma3 4 0 FSL_EDMA_RX>;
 };
 
 &i2c3 {
 	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx7ulp-lpi2c";
 	interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+	dma-names = "tx","rx";
+	dmas = <&edma3 7 0 0>, <&edma3 6 0 FSL_EDMA_RX>;
 };
 
 &lpuart0 {
-- 
2.34.1


