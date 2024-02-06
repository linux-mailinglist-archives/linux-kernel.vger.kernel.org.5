Return-Path: <linux-kernel+bounces-55704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7CE84C046
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2242E1F2377B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9E1CD25;
	Tue,  6 Feb 2024 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G3/sn35V"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64B1C692;
	Tue,  6 Feb 2024 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260368; cv=fail; b=k+edqhKqFJ8nWgqg8HkQ7GVU7Izf0gSVfI7mP0a5ZkVHE+NPk2zjm0hey55+V2J4RBzA6xuUIwxBiyaW4EB5I3Zgm9gEqD28P/dqLv4WRjT258xr1iiMzY3CCnxPnLKCXYt/8R9ns0KgJiqjxDU/NZzSaJb6yNTR0XOQLmtKpFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260368; c=relaxed/simple;
	bh=pJ0HtBmEAPbVNQ/dBOcJhXStc0Q18etg0N4FKzXAnlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8OGVkXHAEqQw+fPF1OZrZXukyZlSZF6SruelEHyX7n/7rGZyliihL1dWqWO2uqmlKbqn8PrDcVTPLqryynQ305H6w+M4vylXzmb5l/hjXAS5iB0IDqAkap4LsDtv6mS8Qaz7ItaHtELWKbWrjTvknDSZ81cDBHltBzOn4hmZQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G3/sn35V; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP336opBU6Gx8rkNM41fYl8Bp11NL6ZEdbDx/bOoZT2pw4OUqrl3HZveJM4pHpRSHHsAg4kIyQ8iKg+0XSkj1irmjitTrKTRQKPvsfZmJWwGFmUYPLDzkoM7tt0yaODknnmIMcvDpEYCt4nAT37riUaRbJ6qDXghVOGQyInFkOn9yzZuUiHE8GoOkYuN0gVFVElj2mvD4gIVeg8OiPDnB+WrGenrECWE9avPYkncvtEGc7X4qYXGtj4b3+Ggxae1t6xZBvPICC5YfkfgAAI9uqBe0V1kzykbtUZFrx8h7fwpG8GoSdIXCLxB+cLL2odmk0ZwYeai2P674RqN744qQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJGW9x98xoumygXNL80o+j3YG9L79ihJ2+McEfQsXzQ=;
 b=SBuy5HlGBiIqxob0hMZ/KuiV0YrIP9IyqriybTQ4MLIEo+VN+lG+QZyhxd7SG01QiOQYVuVmgr7LoQl9ewDpnV0K2VJ/+cFDEs0Au0ADJ1LswE3r8VY/5hJdwnSYeN27pLnr5Jl1ZHq6TigYcW+E7ZrCtGq5ohnG6A5zrupV+akAzM4E/VzcU4pzlc01dcuaZbQctq5PFbUArSBFD1g6SI1rZ2ZSuwem+8ugoCo6uytr7h9gGRbbGEOn9MND8gYagn6XEYaahPiI5P9z73QpPRh/1LFBAQqHtzFMo1mmDwS5qa08hbprs0xQWI81fJc5Uo6krB1vMBR0+kSiVOvwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJGW9x98xoumygXNL80o+j3YG9L79ihJ2+McEfQsXzQ=;
 b=G3/sn35Vvh/T/GBUXzXLHHB0yIQkn90WaBHLb52PrR0UWaKqMgHT3svCJG0JGJF3+YlbYvD327VY+9rCBSYujb1MYqLHdK61bjIsHnoDTPDrzhJINmUP4fTqP2RMfCV1rCloCffsnm84G5LDDssZ+YxRYZ9fnKWbQJdDSKkXdW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7988.eurprd04.prod.outlook.com (2603:10a6:20b:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 22:59:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 22:59:24 +0000
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
Subject: [PATCH 2/2] arm64: dts: imx8qm: add i2c1 for imx8qm-mek board
Date: Tue,  6 Feb 2024 17:59:04 -0500
Message-Id: <20240206225904.3565362-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206225904.3565362-1-Frank.Li@nxp.com>
References: <20240206225904.3565362-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 049847dc-1404-4c5c-a090-08dc276742de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0YGOPQDxqGolqkSmdan2ScSurjLaStbfA8tvZUTRA9PexwSDd+4hcJ4XtafVT/znFsrBKICURvno2ijTDX4n41FVGs/hJontqdnsDfACE9PqBqhyFHNZGumzuVBviRC7otDs+h9gCcDk371SxBAAYtZHnwNtAYqD5gt5wMsIa1l5ngGvCX1cIm4O2tvdofi7fWrMs6RGZ6KSzIXwnzU06EBfzoE0qfqMROXHRCmhgPgpgdN4b4osLoi/NJVRSar4LmDMd+dXUO4oC6MsDsFp6dao2DGKzklxeRYd3rBL45WiIvgTPkgGfxEY0iNOFVceQZqNdNn05E/hOX2qyaydZ+VX90tBl+L/Z6ZZKrAD4oAkS/ooJH3J13Wf2vfDFTu1m1vTYXhkRaldIOez8V4/AjmZ7Sl+mdypgJ7+bsE4Hn7Jh7ptiJq5eDTvI2iYdArZMzQS5POU57pp783ZtKWBDW4T+1IvywoCuDwheLY4TFM1hSFc32DB3RbFny1cuRR79ajYr45ghRbxf0XfqKWYL7mlUTm7J28XYcv7efLq/zDvR71CGnr5aKp5ghKm0QWcqsH2nOhIAU+EN6x/WJU3q0aRAm5f83m5JiDVzqf7x2737IORS1ssxcxBVWo1FfPt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(110136005)(38350700005)(66476007)(66556008)(66946007)(316002)(7416002)(921011)(5660300002)(36756003)(4326008)(8676002)(2906002)(8936002)(83380400001)(38100700002)(6512007)(6666004)(52116002)(86362001)(6486002)(26005)(6506007)(478600001)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4LrZDeBZk4UMnC6uo5rrbIIeyz2FmxyfDDAkGSFVSrTRhVDlCp0WMz16UWW9?=
 =?us-ascii?Q?KaP2VLL9CpFifT7I/8ddQZ92QU3a2MSYmhb5y/CPwxBrYLWwdFdWF43Pc/eG?=
 =?us-ascii?Q?ozupsVrR1KBkY0kYTOKg8uNSads1PSJUcMymARX1Eb2nCN2m6Dnf9HBwL6KC?=
 =?us-ascii?Q?YUfQWcKXvCm/zqh7NlI4TwUn//lzPEjLA8FZwNrKz4KLYS6O+ael2WIx104c?=
 =?us-ascii?Q?gbocZtwHul4cuYEMB1IMfWzRou8nxcTWepYhM5c41OSs44xN6yfEY4no+GPV?=
 =?us-ascii?Q?t7IZ0JZD61gj5ZrIpEw2kApB1JunCOVHe7pdrIHd9fsDRztho27MEvlGIrHX?=
 =?us-ascii?Q?oYlb6ZJ/aPeJ37DyJx97gj+f0Dyuef3VzutJHRWj376JEecUycTcCkuKHTpa?=
 =?us-ascii?Q?VrADFiR29k0SlI2jD0KymYEHlwSh561euROgm8fu+FLTLfibdrUTJjJeQqhp?=
 =?us-ascii?Q?Bc7O6enXeQ7PtcQLGfNioH9IDsedK8a5WG+1UkSv6A4DV+2VB3Zj+67dUHtX?=
 =?us-ascii?Q?FPwNYwEModfjsPjs3A99uvEa4chdQi4FSNaHNwfs5MQ4f3jepg7wZbFgV1zB?=
 =?us-ascii?Q?Y/brJDTSrLXQAJoZG9N1abr0Nnp4SMJ59TB+Q9Z/XYl04MDXqSnMVGTT4eNc?=
 =?us-ascii?Q?K2/Pi7TLhjeRwFf1ASyPzO9I/RNytDYObs4rTko6UR5xk++r3+Fd18FfPmfT?=
 =?us-ascii?Q?wohybOEIheGsL3FGBL5Jm5b+cBr8tZ3HarpPt0lpZTlEFcdf9bw5Okka0y4Q?=
 =?us-ascii?Q?4qBH3s7R6Xkm1B6X73LEjApPU5Tal0+ZdZSUiQ1e7YLAGjV8iRxu34fbkZG8?=
 =?us-ascii?Q?3pllEk3FN4jyCPwHZgG7F85m4snNPujYnCYSD/MvnwuBQDtmSmYfL1mstM/s?=
 =?us-ascii?Q?rJm4y9GdvQS4wWHu1jHrE3HQ+8W0MtS5Mm6xuNCOSE7KEEbnILUIgKpwq9V/?=
 =?us-ascii?Q?Ba+jMWOLzrzgZSIgvC5Dn3aCbUrr408K7HeESUfHEzanonEdd/6/Bk1H12m9?=
 =?us-ascii?Q?Q4bC/ZQSQTGdC/3Xv0ZVEU05tnKVx/S6JRjlHBmdJHDpFNqZoQYzkNWdAGiR?=
 =?us-ascii?Q?T6Zza4LH0oMfIgfv0se2UVdTeKIbPjZ4ukonjh3bW7wFkQjmrUZGUholvqxw?=
 =?us-ascii?Q?tLf0RGDdC/kl55C96hcWNrV8tSEeHm/6LD/TAAPN+pR6+/DbLHeoeAk3pclv?=
 =?us-ascii?Q?HqIx1EQmeGHzOPiMwYWdaPeK6dcRZKN+0FzJcQVyHmC7yDaJR7Si0xeF8L1M?=
 =?us-ascii?Q?Y+UwCpaM323SARencpPQeTorBE4Wd7YQe+FEn/ny3T8442uE0VuBOIh5e1h0?=
 =?us-ascii?Q?+hNnndymMcrV/JUOPaOUKl8qkmNttaHqMlSTcbznPqWva1Z6knQQq2gSu7Yz?=
 =?us-ascii?Q?ijy/6Au9RMz54udo4kf0GlOt+o0iT7spRu9ZJYbtuDuBWBgMU4mk7rd2OSw7?=
 =?us-ascii?Q?unyPb2x6dBqD8zfB5bnjc22hfY8rYTX2pj1tSc9xvoX+lrCcJq5EWXP5Ql6+?=
 =?us-ascii?Q?Yy49c03OH2xHHgzpO+JlmtZll376Ld1VOgomnqeEvFlp7zXqF7PaiKJ2J8Yz?=
 =?us-ascii?Q?LXkl/X57A94fPqXrD5bXf94PN5YC50dK6yjBviBP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049847dc-1404-4c5c-a090-08dc276742de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 22:59:23.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+z0GIWp8R0nb6zOacKLC1XvOcbxs2IUA+REPyttmC57MamNRXzSJsROrU6we90tdvqBD6y4iQLqLsvbxNuYwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7988

Add i2c1 for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 6d50838ad17de..77ac0efdfaada 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -41,6 +41,18 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 	};
 };
 
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&lsio_gpio0 14 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&lsio_gpio0 15 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -104,6 +116,20 @@ &usdhc2 {
 };
 
 &iomuxc {
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			IMX8QM_GPT0_CLK_DMA_I2C1_SCL 0x0600004c
+			IMX8QM_GPT0_CAPTURE_DMA_I2C1_SDA 0x0600004c
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1gpio-grp {
+		fsl,pins = <
+			IMX8QM_GPT0_CLK_LSIO_GPIO0_IO14		0xc600004c
+			IMX8QM_GPT0_CAPTURE_LSIO_GPIO0_IO15	0xc600004c
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020
-- 
2.34.1


