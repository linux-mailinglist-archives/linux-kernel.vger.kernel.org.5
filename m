Return-Path: <linux-kernel+bounces-129385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FAC8969F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D640F1C25C55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887176045;
	Wed,  3 Apr 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H7e7Jhpj"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2107.outbound.protection.outlook.com [40.107.8.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A886FE12;
	Wed,  3 Apr 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135070; cv=fail; b=USLZtN5dblfet7uRSgM8lOuuaejPDiuSLPUgBjs6mcDtlcy7S+nSfQNSn7iGnAneb928FkCBTfaeIr53hVBM4HMy4oZC9G8nyvUWXJvTSN3RI5bDrniaaCg/+eqA39YLRlUsBwunW+uOWOPU+R0SXtrSsd42wQ7WqcllNE9ZnDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135070; c=relaxed/simple;
	bh=Q8hub979KHZjucxe4vcatPZhxOcdq3WBg2Z8cfDOpR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=onNqNxwUjMoynFA22W44QGHHeS3keubFz/Wb+ekiQFeWK/2TIeUz1pcQqfRdULcfc0aUvuHegVLlax6EWvhypWWSBWIeUqBuIbrjNoVdWXTDrOH2ftZo7AyUT/3MLYMK/VcTfW1p0GhfCcThXx6ebGZZ+0rY1iJKkuqo3ZIV700=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H7e7Jhpj; arc=fail smtp.client-ip=40.107.8.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a05cflP2Lu9uy51IDP7zKtdhTrkSmbxqRAwq2MUgtV6Pod+fSUzZOXccdm4++37SNNmX0aioS/6+nsw3lnjtgOVjZyyv8t+KmmsAM1YZ2Cih5vJkvEUWYIlHXGnHi+7l0xyxeajqSjTFL9mLeGKxsMXrDfqAKD/bJgU5F7yk9BdtQCxkfoUyZXeGIv9ESH3ywA5NwwPo/2G1i9Y4V7vWZK3euixl/riwneK6DeQs77HjqarGRevnNFukKaprEoFcVnW8o66e3v9PwNuYUAPHQAkVSxtaUKuuaM/p6s6f144tYTlb0kk7OS2bGaj8KQXLsL38lYDawPOCQx0TQNbG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7SeUCgH4M4pvyPlcOn146+M0sWYyh3czLtVtdOklvA=;
 b=YZZ824kQbDq3HS8vgZXXmNd6VaerTOmG83WI/sJaYl1GEYUsCvQrIvFy2+uUsM0Ajm1meWgP23H1TQqTRL2ZhU8HKvu4cBe/AdqaHeh9bKQo1cmtKOozOl+QMkYbspTZg+7vAr3q8ncpitbagFEr/SWQZVgFi68wEIKTgMcpE+HsozzB/u+p+Uszrvt3Tvtchk7HTi0VFdX2UANWLm4bFYAfQGDOGGF38F2du47r3a0J6EukkEWgvuI/Ex/V547MTHaAoRANIAfcCtpbHDiStuqvyFmTsuuDs/92wIomaw5aviDsVUBNziHTLEIMYBCL5ZyYxqZ4CGiTq0Zop/HyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7SeUCgH4M4pvyPlcOn146+M0sWYyh3czLtVtdOklvA=;
 b=H7e7JhpjAmq8BxL2MVOjEHJCHB+zggUU8iz4TYo42QiqNuKj0I652p6h6zQ2TsY6RzqnaeGQY+bft5YK3C+NZUUO+HpELi5CjRe2oo+JYPLMUS6JBzXXTJIH1sVx5Mv9ErxmY1nd69kAMjcbv/6ytdxo7wCZ/3JNWVRcdtGHeW0=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU0PR04MB9442.eurprd04.prod.outlook.com (2603:10a6:10:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:04:23 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:04:21 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 3/7] arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes
Date: Wed,  3 Apr 2024 17:04:34 +0800
Message-Id: <20240403090438.583326-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403090438.583326-1-xu.yang_2@nxp.com>
References: <20240403090438.583326-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU0PR04MB9442:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MOdrIeauI0UhJOfiEkBvThDBK3WxedXocOuyZO4u4Bu6LP/DTruH7c3oQmWOKjwiJcgmCG1xyLNBRbAQsLV2x9Jp5YyjeJR67wzgESGhWDRiDff3Q7OV7IuK8iX48hB1fG1SMAyHCnrhMcurugMzTEsPNqOa9LZncRLRN/l8/ehn16sS9i8sBheNbKuWdYD9BJJcnJ8jIQ2++VAmpNh1hh+hsjIVApClipFRGpPzKPhRZKSlaSFi1cqYi1k/BusppXXlCBY2XziQdgT2n8B3ShQObC6dxP8ivwZKCsWCmbdgrsmU7YT3ckFEUBq82zppdGpW1O+pTY0wWeBYSq2/AMJzjTGPlOz7KaLEBJpggRLMiDhe0sQxqjZYSRWBVh728CT/KciEqyePpRKxPge0PFfWXYMbQk3OFEdcxUFmOYWOFSiH4IOyL3HMUzDxORhw2vHYGz8G5MyRP/k5WDq/IqoOQqqH7be4CF0vYwuV49lD3bs5rTxytOzQw7T0VEWTqLNpmkRaJp7JEinkR9Oj40AVJuuYLqq+7DTgXmcbOUpRVwSS1YkuIxmjwC/cm4f/vPG7QNg0HZf3vxbe7TdfzQV65cBYWoTotPytcw40X3bq6abSM177qX+5eJm6IZHz3QGmBJ20uw1LKrWFs9rjfdXSN5MRYEAgfg64skamTO1V48u2SIRomGLeOJV1o2zE0FbpLJ6mledycVB1XZSeig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jh0msUuq9uiSGsaJHhCsBjO9of1MLXVCfpYLHGZGvV+4v4z+Lq4OVH8DdMtl?=
 =?us-ascii?Q?hdHmmsseAMtPNGHd7j6YNMQMN+I/ysUUTQuFU2Fra2zN7oFHfxD0xbW/fZcM?=
 =?us-ascii?Q?A3Ld2JhTOTKCj+7Dqa35lItvi7kvXCoECzQG4D1Qrs3PPH0FtZjnVOmyIlh3?=
 =?us-ascii?Q?C/KbDJW6TJG/BD4DiNelcO3Bt5oR8zMjFKYMVrXNJiPPFY9PsYOslZD+EFoD?=
 =?us-ascii?Q?puVMYPoMvQzaVJHNEhQ+JL+N4K969XApaQR4rnx1RVuaV9yp96O33K57D68D?=
 =?us-ascii?Q?BQEnq3RYFMlE4hPNQ97OgoE6DL1PSVB4JWctPUquFd17vR/iiKXqRpuWMr8s?=
 =?us-ascii?Q?hJSJnBinzHU+BXtrQU7tJi0e/777BuaTLqCrrTx9otIiawtmQ8bIW4LfItph?=
 =?us-ascii?Q?2A0QkizEYeFP7QmsW4x0DcV7NaHSQzV9BhxS1OfvpPWvKbXQfOGWZ2eyU0m+?=
 =?us-ascii?Q?CYrTvloQcesJ4EW000O/0glJFbo1zLwsjBOKFXWp5jAVYTURA8+VmAHGDUJd?=
 =?us-ascii?Q?Q7Otd55DtllDDLCniOZ8pXFj9U40VWKwJWby0XMISDu7c+BfpeS5gXtWsqtn?=
 =?us-ascii?Q?sli6xO4kwFwLsp50YsR1XORhD5xDNO8IcSmfJ32n5ie+pTqcgyd1EwUqHROB?=
 =?us-ascii?Q?vTJJF2HxzEiTdmrQy4dkSn7ODKpmQsBMpSj9lDNjVklU82LNx1LJRRJN2TW9?=
 =?us-ascii?Q?OSHwzUS1CypSN1RvJDAdKq0/177kZYfExq9OppIMGVXrN4s6Z0lLfZBJfcGe?=
 =?us-ascii?Q?OpAtDWvd3ppjJCJdKqZkPAGIv+R5tFSOKDD9/cclhUXdgrrhW+wiWDCp/HYB?=
 =?us-ascii?Q?/A1OYFFaFKIB4Y8de21lnS7XpYNtnDUQ1Q0+DsdDQIpHLaDer84KnF3d+oo/?=
 =?us-ascii?Q?qWEs4xlpV7xhf5V0y4bW5MF2y+0UxwaT8DZUBvRkI+Ze7Ltqu8Hf5KEJ90PS?=
 =?us-ascii?Q?2ECfr6soMqcdAq3KcGfIZRSqHYALiudI0m9XAZ9v1JhPcB0exVCeFhXRk9c7?=
 =?us-ascii?Q?lNoVWZiB75uYafMxGLBBWU9lad3H0SysbO8Cs0M2RvZLCPpZKZzXJy+dlF75?=
 =?us-ascii?Q?Lno142uoNMZCZb4YkxAFf2OYUp+la707/NirOGKOFr4RScEpLoXO16eNHg6Q?=
 =?us-ascii?Q?+gyw+O7zLU45PaHoGA/dzVV/+AktmQQZjh+tjA7aRRP51+1ITk99YPCfNrnd?=
 =?us-ascii?Q?z2KkvuxnQwFdQdLyiPmUCqlznsRMhRUBtU/v3BzU2upj2n7AsVHUBD2rNjz4?=
 =?us-ascii?Q?/8S/0uFp7IETj2H4s5fVMHZ3GMfGjZPQdlgN6/m/cctIPkyMDQ4n5QtVfglA?=
 =?us-ascii?Q?ZHAWY1atyAm1yogcS51DzWNdyceUSJ1AcjnkTLxAttvEUVxXUPte7L8/hWGq?=
 =?us-ascii?Q?pMfuHRJ+ZBWII8q5SabgtUrQIz35HNXNOWHfTu+fdjsXz9xudz7Dmc0UOOuY?=
 =?us-ascii?Q?9gWrqW1kQa/GQHvVlqMYoiMub3/Pz4/qZLrQ4agz6nAEY6UuAqZkcRoXvhSV?=
 =?us-ascii?Q?26lxQbA7FnLRiWPn3IVkHDRh+zanb2QRbSAdL2OHsIVEvLlAwpSoLnwmcYzn?=
 =?us-ascii?Q?8GlJTljR2qjdtaxgAvbPhIqmNdMmWMbeCD8OA+aN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d4732f-d790-4c39-81e0-08dc53bd0d23
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:04:21.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzxbmNPmCe3rdsaZ81k6z2DirA9aTWF6YGWazYzdVe/H4aalSlaSK8vaPyxBOgOjckRxaaiL5ke7EAmn/Dh9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9442

Enable 2 USB nodes and add 2 PTN5150 nodes on i.MX8ULP evk board.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix format as suggusted by Fabio
 - add PTN5150 nodes
Changes in v3:
 - no changes
Changes in v4:
 - no changes
Changes in v5:
 - no changes
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
 - no changes
Changes in v11:
 - fix indent
 - adjust order
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 24bb253b938d..e937e5f8fa8b 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -127,12 +127,70 @@ &lpi2c7 {
 	pinctrl-1 = <&pinctrl_lpi2c7>;
 	status = "okay";
 
+	ptn5150_1: typec@1d {
+		compatible = "nxp,ptn5150";
+		reg = <0x1d>;
+		int-gpios = <&gpiof 3 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec1>;
+		status = "disabled";
+	};
+
 	pcal6408: gpio@21 {
 		compatible = "nxp,pcal9554b";
 		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	ptn5150_2: typec@3d {
+		compatible = "nxp,ptn5150";
+		reg = <0x3d>;
+		int-gpios = <&gpiof 5 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec2>;
+		status = "disabled";
+	};
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc1 {
+	status = "okay";
+};
+
+&usbotg2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc2 {
+	status = "okay";
 };
 
 &usdhc0 {
@@ -224,6 +282,32 @@ MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
 		>;
 	};
 
+	pinctrl_typec1: typec1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF3__PTF3           0x3
+		>;
+	};
+
+	pinctrl_typec2: typec2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF5__PTF5           0x3
+		>;
+	};
+
+	pinctrl_usb1: usb1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF2__USB0_ID	0x10003
+			MX8ULP_PAD_PTF4__USB0_OC	0x10003
+		>;
+	};
+
+	pinctrl_usb2: usb2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTD23__USB1_ID	0x10003
+			MX8ULP_PAD_PTF6__USB1_OC	0x10003
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
-- 
2.34.1


