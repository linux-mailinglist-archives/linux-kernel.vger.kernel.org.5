Return-Path: <linux-kernel+bounces-147877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3A8A7ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5043F283263
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED620BA4B;
	Wed, 17 Apr 2024 03:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QEbD8r3b"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E55B672;
	Wed, 17 Apr 2024 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323242; cv=fail; b=bxAhXWpT4uWlSj6zaOure8eZ8z83djJkPmWDtV1DlvZFNvXycnyU2btMaxvdW3ap74WVGsEQDbCES1YPCpjN9usv1qOI6JMWd9CZ88GtbfOsxeRvr51S/CbSWqw5MRTey2o2g2CHv7xeNYmisy6/9JXJKxDW1bsm9i8VFxEQzeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323242; c=relaxed/simple;
	bh=tT2veE2cq6FwkYmmEozwLYI36Z4TzMuPJcaZo6Eur7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hvRXxutdFifuPsmVhHbDtDnEkoBZmKpOr5xV8j0fH3A2rZ4AhX6uTTWrvKLiNdJIW6G79oEPVkNqsxGZZYoRy1f8lyr5eDnhLaLCNiTFUDn2P7cjnyh7XMrTgxbuxdgE68Bj4JTr7Cw/9tW/buuTOYx1Y5moi5Tdr1UMNbgxDKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QEbD8r3b; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xjchg89ErgMgvBOLHCgo2Be79UdL4CyrAKvG3XZ0/ZE9bHyXMir/DEiMEFoEXiwgnyayFjYDu9CD2W9vy2j9AmMaMyjjjDm7cdNzyXEtFxh392GkX5YosYy4r9PZup9XZ60V8vOFGoNgQRMDCRlu5JdlzEnIdl1g6LAIIrzHs78JEgkVELTgEDzUeIIb81Nzuyto7v6pfueJlXywo/PDVEyFfRYUOuyMZHRv4rO+SzPzWeQW0V0mDlv2MsItgBBFSLdY379DDt7GTyXu6SZPV6Ul1bjy5W4VlBCsxX87/JbaHpXwk15UrxnGPLy/woNNrYxnpAU3/zoawmJFQebS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pXXr+wNtQS244rHa6r0moFlNV+RVyuzrNikIm/fxn0=;
 b=Y+3TWdbzhBKkAE9oGnps+iNzASY86KogmLoq0Dr34f/hnSGexdH2x+knrivINQ+PuAlZfbxOMcdLbxyF56ogickjMD+74XSPazun5rJyIMDShQz9WnBgJ/Sp3eQPU0ln8PE3jedmsEgnp+kVb7lYLOFg6u321/WFhAsw5zezKiAxOAabiP99fDPRWRRnrcGtBdmNOSprhnXvnIUqyhBIeLz2+8Xj6nNgMRpQHkstTlUCvcCxxy0+aFOm6fA/NJSwvdk45QLx+SXq+P6++1kMP9e/FSNbO+ExYeUMWFAoB8qXmT8Jpswr4zXnCohiKytbNjnoCkI9F8xXInpnvwfoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pXXr+wNtQS244rHa6r0moFlNV+RVyuzrNikIm/fxn0=;
 b=QEbD8r3b6xXj90Sxc/QaJAAjPe3UHNcVLgD/WP0R5ZNTG1kSZkwb749GE0TW0cxSKE5n+lhK9bnpZgfCRS9yNPc48KNT3y/uf18G3z7oYiwrD3puZuXRvK9CX8w9hc2AyjhtmJVkCK2C7JcQFKVyXiJG+fx4/0IPHUSkyzyxSfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU0PR04MB9321.eurprd04.prod.outlook.com (2603:10a6:10:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 03:07:17 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 03:07:17 +0000
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
Subject: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc PCF2131 support
Date: Wed, 17 Apr 2024 11:14:55 +0800
Message-Id: <20240417031455.3177778-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240417031455.3177778-1-joy.zou@nxp.com>
References: <20240417031455.3177778-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU0PR04MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e63ebc3-db03-474a-5405-08dc5e8b7d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TtDSckiBC68wK1eP3i4pUgzcDaEii2x0D6WX4sYBlu/pO23fBVbOOflKAwZfQXPX1xS8IvOKQLRbLA8Z3E0dwCYvyOV8I1xyuJTkjznc5MmVemBRUqc9PkTufUc2P+w4k93RCM4ktCe1datJyKcgnrHWyJcoS2kXoueLbNNH4hdR8aWabSTyzqAL/E0abCfJDpQAJ8vHibyVfzpuHeRyjPKf6gBaAiQvVEU3BRraE+AsxBbo92L7QAJPIeTpcWTgOsozWaYywP3WlkgyQuCmBQ4nFaQA46cSIyzAK0S6TNAbaWAw+VINFklyp2jBwazV+TpeWCT0+xSRi14m5YHMmneGvREGJGXRtaqHj5CJBvD9Mnm45HafpGX/fZnwgY4cPuWgDl2qVTIzf3dbzdlaruJ9ys5Grfn31MSvPqyBeD+ZZVUbid6gujD1NGjJqBetpcwg7AeKtBenYTk1fsZc5nHb22kqd9uuEz1y2435r+NLd4kopcbvuMUTWaHfOoew0wRRN9JGy1Eb9vqbSTu5FG8mnDXtjLhs9NfFsw5m+SgiQnr9Y7EoLiX7SiDZv/dEXYwe0zpBt+euuuAwpaICFOqYxNIxHna537zRCTFxK0khtQdWINyk6iTZfhgxWcTVHAEaQqYKbeGxua/4PFw4NGmZt/AnjcL6dI8FcCsntBZDhkA/IDTb23tuOR8NhgsWrrsdi/NznI9NSC6dKn4jIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jisBXPYEJktmxD5olafyti02xATKVbZRNmvZ9rzzuerqU62QUgtCyFoKlqAY?=
 =?us-ascii?Q?7L3O5Sy+HYm9+JgHd4rjIEIjJgg3vvJTmbon4xZlDNY2nAqaOtfBomuYNYOU?=
 =?us-ascii?Q?rQO2AZRBwZxs5guV5Pgh5zh3lLmqIDVjGbDju36e44ZLdXHDrIxMwX4ly1F8?=
 =?us-ascii?Q?/CRLrFNyo3+6o5ZMQOCrvZXX6Gs7UyO/QAIg6A5C80dT59cEWhYqyt9G+w4o?=
 =?us-ascii?Q?v1pRF9ZiO//z5PMAQp31gGAh1KcnEBaK4Kt0Zjz2Hnv8mpik4ZXz4CzAjfsb?=
 =?us-ascii?Q?b4uqdClgyCihetJlnoMODrAJ28U35K8NiEXGQkwz/5JRByfPSH61DCk9cJkK?=
 =?us-ascii?Q?VxYWT56J25ocf3FGboGpbwWQs3FDdkjtjsC06Ud7Iuu33yXO443TdcrMmmSC?=
 =?us-ascii?Q?u4KXI2XPEpGF1Zp5C/S+Qn5HwoiuMchR8wmRKFSZrSTuM4AQv7QrhMcPfqfT?=
 =?us-ascii?Q?ViNT54VGzY3SGHHWNqarLLxkMyq9vbIj2O0MpctljtzVTb0L6Nsf2YLuLvsk?=
 =?us-ascii?Q?jkdBFqSr3G7rn2I8r6kmyXj9S5hy5clV8a4G1ZDtsdK2uTOHULKoiWarMQm9?=
 =?us-ascii?Q?Xb2RoWN/2Aa2tvcwbdD2+tRUvKQJDfxcmVOwvC0slmTgCOaldY6YM1LcOM2f?=
 =?us-ascii?Q?AQZqf6quwjCuNep9i6RofC59SC30vC4vvLMBPf8BjzUACqHKhFnwjTsK/ECm?=
 =?us-ascii?Q?jCu5EM56kMb22gneVB/yez0iZCspWRqutzk7GcUhgHyI03oungepThJIj6mD?=
 =?us-ascii?Q?hfe5xyKE2fQ1FNRJ986TKyOgIPI9w3zRYE82+iVdeU51vZtOZxa1j08OAEJS?=
 =?us-ascii?Q?/1SQEBVvj7McRh2IY6gkM2Zj6BkiK1x4MyAySDPqEhNLAl/Wa1+wjuEXEk4P?=
 =?us-ascii?Q?aU3KBVb1gv7rowehaTQNjdWGgEj0giyhRxJ9C2XjJd5ptAFT9jNiOd2/r4Xb?=
 =?us-ascii?Q?7onGPff9P9N+lq+AUP5sVz5JKug8vj98rp+gOxMahUi6fgz0NXj9q4u40TG6?=
 =?us-ascii?Q?I9b3e3lLhkZ4iRS9L6z/3uKV6OCQF1665D6/OSwbXyrNTsYAylRXgZCPn2K2?=
 =?us-ascii?Q?ZCNagL4zPFiKK+piZvBfWBpKHraLNlXPTdorKQyy8Kz97XyPimt0D02ddlc1?=
 =?us-ascii?Q?TZRU17WFoXFDvvJrYmRTijLkRRn3KF4z2vaB/tQJmE+OMc1KIKbzdm+Vvzqk?=
 =?us-ascii?Q?2DLiveeXFMguXMKWu8CJHedw9TocBI444warR6pzvei688+oXqFdFnWBLmFC?=
 =?us-ascii?Q?GZ6eOaeEMP3G6+j2At/p5PpmgZ0BvxXCRnVabtd3Z2E2TKuXi5r04Bgpl15z?=
 =?us-ascii?Q?xBUbZw5aMuZV/9x35mAJeAkHHZZRaO/G2/t1AraA4as0rPxS1N+JyutFu7KC?=
 =?us-ascii?Q?+37dh+DRl2uPg9233AW6lRkZ5u21BHzgTs4Q+UIFFL9GhZ/eb/R1YUc5Q6Hu?=
 =?us-ascii?Q?u8Joi/2lNYRgqTPExGVQpnbARRk6Qp5PYc6osf7zDcuOng2SE9ATpxsk5RD3?=
 =?us-ascii?Q?aK0spOQzzBhRLqfn2HljepWggK6QR221i2Gn3AajVVoyviQCmAyDCWLGHnZm?=
 =?us-ascii?Q?9L3V3ha+7OJqz4891GxouEts1h+h2TJJvO5GXjk/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e63ebc3-db03-474a-5405-08dc5e8b7d57
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:07:17.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrNwlYry5wdK2tpe4v+WozuqyRRu8n7AOHIBca3ZR90Tsb3fQUmBydTsSXwM/C87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9321

Support rtc PCF2131 on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v4:
1. remove the sleep from the pinctrl-names.

Changes in v3:
1.adjust the indentation.

Changes in v2:
1. remove unnecessary status property.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 07e85a30a25f..bc3c9271d747 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -281,6 +281,23 @@ ldo5: LDO5 {
 	};
 };
 
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
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
@@ -343,6 +360,13 @@ MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
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


