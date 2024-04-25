Return-Path: <linux-kernel+bounces-157906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F88B1870
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA911C213CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB61173F;
	Thu, 25 Apr 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qMTQHgjb"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C21D11717;
	Thu, 25 Apr 2024 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008464; cv=fail; b=pOtoXioWWJw43jJaclKK5oe9yCXxPyUsobUqxcc9KJmmtZSWEbc+h9kWv/t1lU04ZvZQNWlvqNl1ObWg9g34kMgoccrcmkm1Lpxe2r7pYYvc42mhJ/sEkiHv5rIrZBtRUbc3Fy9RQ9ikPAf6hrb3CpmTHjMQvK4nWwmVXIfXzQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008464; c=relaxed/simple;
	bh=BJdxgc/eEvr2JKaOOqCQCZP1/I/SMLh2hThhaW3BuBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QjMjj8P6I40qpNu5Y/6YNUbjJTlj7ilCdfwBvVNQ4ynZE0J/SYH7WgjuJZp7odiIJDWnecCHUZJZlXoyTEKgtUbl+RBBn0vchXuIeqcAVdxZ1drReCafKVW+VPalIQVRIi/7h0kaAScoR8PIrPz9sFdjJ119kvQmeW1M5jqIUvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qMTQHgjb; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6VpvLbxrop3f7x2JUt0zOFoLJdtbzlvWJ6r0qQcFpUc8Bv+00/OD9ZLejFhASE9Vo+bp/rSrqTL7g5ajDfdqn1vKQ+MzJuwFYImQZaEBjB/5VeGazkTyE9YpOTCAJndMRXN3rGivMGNgGDVEIVw178+BVJrd4rEXOLuMsMtqF6XuKOlsUzaA0MFSpK96AZ1Db+4UL7fWbF5UR0Klspjp82u05o72BzVizZL3tJgzGbXyUK4d+JYfT7l4/5TqPNeSnwKHEdPoHI7qKerbIvlcVypgtZQcU86qwR/lP/MPsu+eYGWDow5UYHRGrpwSrNNeSSZT+Xr/9x29XnCpLLJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z0LSs5TN+w3IAAGFz0zdlhBUL9CjJ6b4rPH5hbwF/c=;
 b=J97IOWnd52MgnnRjYURTnovVzcPta5h6QeBv0wrS4AEbA3Dc2w380Pp0oM+gQnfG0xKOuEJlx9q03I6t0f/SC2LnDDDqD5tYqrMq5GG31PvsFlgTo6CNC/esTK/MLPQCa8+YdTZsgLzpcz/zq+mjT/H+Lu40CgjAWlFb+fzVPIWlUMsUefsAPKSTDPB56Qy4IfOCePLb4PYG5w+ho+4OZ4ZP9hbUtmEsnkjdewEroseR3t38jODHEqVFPOs+sDcX/CsLrS5OCMaf7qp+FGirNar4xKDvs5V3OcCrztKD72zZzka0uWTXbU6AoWpHQFVqNZmhzAFrovwm5MObR+Zpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z0LSs5TN+w3IAAGFz0zdlhBUL9CjJ6b4rPH5hbwF/c=;
 b=qMTQHgjb6rcHrJRjHBO0VtIg3lD2TVQNmZd8kbzOfVl2Ho/NDuMDd1oGObVBE8ehO/d+W1LX0CZAIFaconNxAZB5+XIDxk4w6FGipYHAGmhkWnKBwnEV60HetjDBIx9tSs0lII99m6GMgI2sfxFuCwZO4ylMnHx3JxBg+x8WGAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DUZPR04MB10063.eurprd04.prod.outlook.com (2603:10a6:10:4af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 01:27:39 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 01:27:39 +0000
From: Joy Zou <joy.zou@nxp.com>
To: m.felsch@pengutronix.de,
	frank.li@nxp.com,
	ping.bai@nxp.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] arm64: dts: imx93-11x11-evk: add RTC PCF2131 support
Date: Thu, 25 Apr 2024 09:35:07 +0800
Message-Id: <20240425013507.2840128-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240425013507.2840128-1-joy.zou@nxp.com>
References: <20240425013507.2840128-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DUZPR04MB10063:EE_
X-MS-Office365-Filtering-Correlation-Id: eee75262-30e3-4b44-74a8-08dc64c6e505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JPut6tAMeGMt3cW4YpvHyQULQixweameB0YFsoftqxFD+adlqVIEesgmcCw?=
 =?us-ascii?Q?+7IcfeD+xZSPms/+JtWHuzw6/p0Vr438gF6rUuGkK9p4sjqX0+Zmvdl++Ulq?=
 =?us-ascii?Q?P4pzE/uGHzRS3CshhCLaVrtgOwBDMb0YnCw31EjKwHlJtZSv0iWUVrFrpl5j?=
 =?us-ascii?Q?4mnfgnWiakAMp1DB1RpilvZyzXGNEW5BnyxWmqDJgANvQpyHLpHM+HkTvE+y?=
 =?us-ascii?Q?8OXqUZUJRl17KgZRxrO+ybhclHEbcBMc02fBbzXF411tCDwnxONWofU3dVPD?=
 =?us-ascii?Q?YCcAiwS0XjEhDMaUi5c3Pz9jYglH89MR42LoFLWZ54g2iui2ZVykdvRaYFZQ?=
 =?us-ascii?Q?ODw9lEIQCwc2CN6lwA+seDbvrfCOwoXyIEiy7lPuOFTqAlPEhgfAsBGYfnSz?=
 =?us-ascii?Q?tGHrxOHk/6LJc5g9gLVbGKo7FUPZr0PpB1a9IsOVU7mgLYmHX1wlChRl070w?=
 =?us-ascii?Q?tK8CrYKDxvNBKD38B+aN7/KksLY7mdwH3R+XjHC5p4HYOfUcnX7RIcVWsSY5?=
 =?us-ascii?Q?szZ0XicfSJ3KV3rMdRc5vcFm7drpNZXI4yg6+f1eNl7whC+4XrUn910bE9/N?=
 =?us-ascii?Q?uf/aq25NeVpc+bYBs8b1FSKBxfcYm0zy0qWOe9jWNOpidy56FK8Uh74RpGT8?=
 =?us-ascii?Q?ALzfK88fYbyilVwCbgnznlLoXdT0+uWyS2nXZ6Bx05FLLT1hOGGpGjIVORv4?=
 =?us-ascii?Q?8IBUXklNETvo8JKQHZ9bCkhpHAgy+eaclfS+enSueed6WKfz4iv2a7H2Z6OG?=
 =?us-ascii?Q?JGpM8NyqfCi6gEqzGIFCnTGy/BDQeHJhE+kqlQCfwwGIIRWGo686H6IH+Xlt?=
 =?us-ascii?Q?xTiO3pqMK95IUjqHC9JnyDMksgfsRsJAU2qyUhGd1YHNFItCiVa3ZBz4l2TM?=
 =?us-ascii?Q?poduWwZNp7eu/zI3NrtgsttvDUkr1z/eK7EQIMGCCn2fydB/tVDmgFBKdWhK?=
 =?us-ascii?Q?NY/fm5cvq0rQuZFeh5sDMbKt2uFGzS4FEqGD28+S0nUFLUxqrWUDAZHGj6SH?=
 =?us-ascii?Q?YdO53vT/8M0sbK9dIf+XbQwRK1leZRpEpkAqAT+Hxrg9Y3NUonDuSmzywcLZ?=
 =?us-ascii?Q?sUgLotU4X7PpHmk+9BHCq95uPtxAQOYhF41UMFoh3nmnM1z7ciMtihnHWjT2?=
 =?us-ascii?Q?0oHv73QH3mdbmbeAIONDeF0B6fU+BAO2FdwPj7QL0WboOH+ArRtyzx/0hG5w?=
 =?us-ascii?Q?S3Dd9IMsx2gHYRc7C3l4UqMLf+CPo5mJBzWn0Feb6hTwMlrhFlJSQshwyg7Y?=
 =?us-ascii?Q?udwzzNUYbuYjSM8mfEKz77Hk1nKi6TFzYEHMJpeDojXcGBULAPWlq5Q86UcN?=
 =?us-ascii?Q?26ujO6dWWZkrt23MjY3Cp3rtdfejBs76jCUaWnfWTBlMLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K9B4GUBiHLvSQ9bhaMWRJE6B3S1rGCapcDUDFItCLIgUHvPrqIkvGo8i4X8M?=
 =?us-ascii?Q?n5EHMey23TCiSuvL4Dzi35p0yuUeYd2DJ3j6X2q2hUWx1SqV6l/13sjzpWqJ?=
 =?us-ascii?Q?WFosJza9+ozxNPITFrRPWvbN9TV+QwvErdE61mjglsjrxvBuLSRx5nDkkIZh?=
 =?us-ascii?Q?H+2v/ZbL+JkJz7rvOBu8KQI6qTlVh2EUXCf0jtzcZPqX9KOn+G12r1RUh8rG?=
 =?us-ascii?Q?oS8P9xyUkuF9YKJ3QBs/QFAb2dr6bAVlSgY0ZuVDw15DqJ9JqL+vNyMj1rPq?=
 =?us-ascii?Q?PfJsbfaaZiJmmDd95EVqRMb+A/ZsqBfxgBgbnzHXmJo8/2RGJr6wGticaFxe?=
 =?us-ascii?Q?LJRDgusWiB+zXs7F+7J2J91NtO/ADAqam5nPO7P31JIe7zb0I38aDwPrUZIU?=
 =?us-ascii?Q?uIh7SffHX9GmaYpJkfXLRQ4yzS9R0T0zZn+HTHMkFNiJK1iDZElVpZ2z98pz?=
 =?us-ascii?Q?7UeFqknBJcJMFX60PIss5VnGPN5yPDmOTBJMnaq4RFNEvKwf5A9z0/Q9sqJ2?=
 =?us-ascii?Q?KtbBlnyhwIl7mpFo4wLq9kKvifTbKYEkPYmtJTS4KnKE9G+15uoBFCyg9YLa?=
 =?us-ascii?Q?VOj1X39a0bTVLAMbWqhoIHtAKGVZDRuRGTBUNSCnPzMwj3kCm3TLs+RqjwN+?=
 =?us-ascii?Q?6fJZ8uAb36LiBAaf1SJFJEBYvWWOEP4zJ0HK0OLefeet6jzPstod2X5qntiE?=
 =?us-ascii?Q?tgzuO+JUr/h3ZbUGNbRADzUA0bGgGv0o8gwyhvxptBqRn+jIvFp2FVGTkyh1?=
 =?us-ascii?Q?oAgEL7OtM3lwOq4QHMsiX78dLo3LtlEGpb7qDzx+gXEi6XBcAhG2FUQn3wCd?=
 =?us-ascii?Q?6+9thJ8sHbUtGgzEip2j7T7pCVwm8kFKRooZ79QofeO9U0Pp4UImiOi7zzIp?=
 =?us-ascii?Q?AUPntrzXz/pUKpI2yaLIanYDqfMEGxJSrDxaIcM9sbH7Ud1VnpPUGzIG+sNZ?=
 =?us-ascii?Q?dYHF+H5JrwhUN91s2imCfdQ1to+5+L0dcLjfVwytKweoLGpBYsVgEb2/G7sW?=
 =?us-ascii?Q?9zvM5P58h4oCSXwtnJcD6KQyYOQgYyFHyX88Dj7T/vPXu9OB1TDk+BjKG9//?=
 =?us-ascii?Q?2P+nhLyalal3fOpEWD52Ky36LjtOmNmyflyXQfn6aXT7Yi91mPM4bYQ6/ozE?=
 =?us-ascii?Q?nzCzOzp1e3fRaapwpdi1fC3UtJ9HQ3363jmkmLTVurpohzsJt0GEg67d4a1z?=
 =?us-ascii?Q?9/oYHtjtfMT8/0Z73SCFcx+glcTsw1RkfMtkysR1qobhZ44HAl8m1zg1znzf?=
 =?us-ascii?Q?Q5uWZ7ivRfmloAvAQXS60FGns80lINZxPfLQ1hSJUJjhmKrBe12FhNGc9t5l?=
 =?us-ascii?Q?mpOg7DCplT9C3+rR1/wvQpvoBRnmUC6AbvhfJ1glXpYcsmBpb/A2aO1w89Lx?=
 =?us-ascii?Q?eA/MuRc1PnX7duJUR8QhtnkgXbADVprloflm0Sqeh/JTYV1zrV1sTD+R6Dwf?=
 =?us-ascii?Q?MahOlT+KoqMfAowwyqDF26jxYEZ/GZJyRQATjzhVALazIbDd0pAJVHFR3ids?=
 =?us-ascii?Q?4h1hlRbrTfzWKbtK2+uSNFL5gpMoVSqVIS7McChtRRB/I7y3bFu7fH8KA/T0?=
 =?us-ascii?Q?vUKCkd7zQGC1N+oIrKaZDcV0A4izD6Z0x0tbF9VG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee75262-30e3-4b44-74a8-08dc64c6e505
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 01:27:38.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9Y4jvszUysEZq5rnZnKlQjkA907parRzoIqnTDwhMfmpiw7n4kwsy+PxQTr85/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10063

Support RTC PCF2131 on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v5:
1.remove pinctrl-1.
2.change rtc into RTC.
3.remove unnecessary cells in order to keep terse.

Changes in v4:
1.remove the sleep from the pinctrl-names.

Changes in v3:
1.adjust the indentation.

Changes in v2:
1.remove unnecessary status property.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 07e85a30a25f..11eeaa9d2674 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -281,6 +281,20 @@ ldo5: LDO5 {
 	};
 };
 
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
@@ -343,6 +357,13 @@ MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
 		>;
 	};
 
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_pcal6524: pcal6524grp {
 		fsl,pins = <
 			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-- 
2.37.1


