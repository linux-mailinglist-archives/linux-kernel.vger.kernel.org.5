Return-Path: <linux-kernel+bounces-134174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF2089AEA4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEED1C221A4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F91C0DF3;
	Sun,  7 Apr 2024 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NpSqf5K4"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2114.outbound.protection.outlook.com [40.107.105.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC07489;
	Sun,  7 Apr 2024 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712466707; cv=fail; b=LAkWl0RCPw9woTVcM0AbtVIz6bSYmiop4CtJEeEH0e+rFnUCFMo2klE9Ce9U5SUJYMABYlv05NOLtCn+xqgSxb0Op1lCohX2/xGLSYY7OUYD4XqoEwbR+KFIWaWvLjUjeQ/79fWCOgV6DMC978lotbGGzOhMI6KUNGeYkDJ8sYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712466707; c=relaxed/simple;
	bh=EQsrKfYjyA397qAlN9ygawbg/+qksePu/2Ah64GCV2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzn6n/0Kf2HFAmK9jFPoKyhfalOWsr+jQKsvPX8kQp1UUlMXWt/r4me5TTlQSZzaX4OcKq4H5Bf658d2k++soKd+oG+yIwm3hqJHncVlQhtnArP67Alz+W0yrqlpsvL7xnGQYM0r52Egnq3isexnArkqAAPoIdf2GTv91OO8gBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NpSqf5K4; arc=fail smtp.client-ip=40.107.105.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk8Pto/mL/6IuuxHj6luOMMjwS0vW1C+IqqkduadO98iMZJGeIlPR/P7XChbeUoQGMQ6blz3nZJokVOVl+dMZmGOvrMUoT0jK3Q9aGyoGV1fye09qVNFU4+tUAMXGDMLl986AVsMAVMWeOnzFFPVkPq251PxrrUryxkG2589S7rKPVYxzfpYXJjFjBrDAYegPQD2teyHNnaPjOlUMe4dm7s+056v3qjrUOUtEm+Z+939Xqh9LAdi6jnvvv6ndLzZnmNgs2kMyM7NZaxEKnAGk+7D75KM8rdnHxg+u4mkHDfTUqozPMPOvi3XsBUewIqv6LMkqROBk7Jdq2KwFYllbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSGPbRK3Hg4LsgDh0uEry2TcisjDNcukYsD9mMH23Q8=;
 b=bcdDhl9QS4eT0VM9ghW8PxjSEDJbUJswo2sX1M7DDznwjfjBQA12a7W+MTLCbRNwv5dQVCDr1DMsaqCCD5CDMZfZ77U3/Qqaj1qVDg4wRX8Po1VkEMT1oZLJBNVoRndzr7Kyrrk28siENzoJAUzjl+d2vnBXXSmT/p8CvWVSNVyagHVWhCEdK8eOpN3+YGGdXF09hcFKehsCyCcFaErtoe/m+YYH4iOv9Sj7YtAZEByf1EqS8+nKvywUlOj1UuvCdYlkGjwVIy8NjQz01gzCe+bINfx27M4olQAs5QnRXcrSpE15GVCMWpPu+29kKaAQd2aLSu4sj0RINCqYub110A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSGPbRK3Hg4LsgDh0uEry2TcisjDNcukYsD9mMH23Q8=;
 b=NpSqf5K4S/6bsc8f5UCDmNBddQpAq8e0yZG6RVPdxIixxlWn6+rorvv6HJp6lWth96sJRT1bFlFhQs+faM8+MrC2n65u5fLVXTOvYBcCeFpP2n8RmQbvv8gG3xKxrb122X4mbs2Mb/xuFLIxqaScDk61AeQA8mh0jjBOOr7ohnI=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VI1PR04MB7008.eurprd04.prod.outlook.com (2603:10a6:803:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 05:11:42 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 05:11:42 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
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
Subject: [PATCH v1 1/1] arm64: dts: imx93-11x11-evk: add rtc PCF2131 support
Date: Sun,  7 Apr 2024 13:19:13 +0800
Message-Id: <20240407051913.1989364-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240407051913.1989364-1-joy.zou@nxp.com>
References: <20240407051913.1989364-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|VI1PR04MB7008:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I5w2jZDX/xbNSOPDT17j9UOjXNjVpvaZUfwxCcXoYUkxPkHc+4WI/qXbt1wKd1IsAhugQil6xWBt7OzOarfKKY2oXXKDXeoJbQSqvk6dU3N5mIDqr1q00J2tBwF6jMzW0aJ8BKv9BtiHrg9voE6c6CIoeaWXAY1ZCanRlykAOlOLNxQkA1fusS1YWDav1STxldQ8jYKlbp/nWAIPsqC7CCs+oD8kNeJwNafYqCrgSf01/yPoutyCS1fgfMju+6czEgEMqVexa97ddKERrK57FA9fwwJwtr4T4FSjuI3597N3BVORfDa8W0Sm7jTL55reI7HHPjOrf9yxO0iOPEFOCWtOd/Y34jCn2bYYj5cm5rnlon9Xb6SMCZsLcq7fTsDXiFXBLhICusor9Xy2ylylY93bpEM1xieACfUMDD3uGE/RBqNyQKTLS8RDGai8gJLt+hj3lshC0SF59WMTzqRsrwmwhX9R1ACB7lL13mmlKnhxRXT9kg90vvBNvK/hhQVu4W2zwzjbc38mTuvewyVBF4ZCCNCrpCMeDoAyt42ZyI2VehoY5xTMd47fiC/Ec3iaxj+OItqsgJTTVCLQGOJz9CuUso6tAbeTDWE7gRCBmXaC+0NN1aI5WnSh92R9FgG0z6VD0Z13VQnRtLNjTiqtWWKozFn0AuUfetZQau4uGntBee5t+9oB0pX/bJMv8Pj+ZwCqN5k2qhpTf4twtD8E/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?baABYpcsKxNZJUAAZMA5yUbK5idNOJh/S+TTP5PaCFpIHtXvCzErs6qAmRKP?=
 =?us-ascii?Q?2S3RVLTG1e+naYi3dHOaiKo3cmdDyvvIYpRwErKg+kCVoDaFiI2W+2cJ3H6B?=
 =?us-ascii?Q?63O8UlvQ8Vd3PO8aBgOmy16NagAhsxWReJHMwcHpxlXqPYkqxuGJbVZQo2m+?=
 =?us-ascii?Q?Fnt6N7H6JyaxHjRh6tuXa67M1f9GrnGCYOl0/qqEQY/AzfDSU7pwKoGrK8JP?=
 =?us-ascii?Q?pVwYLZJ4ufOnCmmeWvX9ap8GHHYpNZzG3dl1ZZtp/ZLFLqhn1AXTRjIueP5f?=
 =?us-ascii?Q?YyXJiAFgwsCBqDuKYlTHCH6icUrDSkG4wUY4EgNNCAxk/FbIqfCEemAkoGvy?=
 =?us-ascii?Q?f7/lFEC3mGEPU18sz1RDHpfc3xrx88JagirDGtc/E+7jVnSl1uGqrVGaLgWl?=
 =?us-ascii?Q?OfQeVjug92VlqGcHcwUY16J2jlylWDUMuz/z28F2y1wyXyNmmHbj/HHdVPDt?=
 =?us-ascii?Q?M2oKp5psJ2q40J+/XYF+Vn9iG+LDq83o1SHQjikxixI4MI0KbCm3qdqEPDN6?=
 =?us-ascii?Q?ZDXOCAz6YnkdtE/3d8OU34qw8jKhyW/EQHSoy4fHM43IZsxmOMv8mE/RbF9n?=
 =?us-ascii?Q?hZzvSYDD/0yQSgHEulVPD1aZKloJ9GLuhaPc+k1dWHgVc8bfOw6SFE5J3h4f?=
 =?us-ascii?Q?gezQytqBgGo0heQsSVv/qpBYIxrFc1I/RawFGxYBWW8PmXtwGIfUeEtjLLw3?=
 =?us-ascii?Q?Bl1xAUVSfR469L3TaF2Tlu8LdbZtT/l8uupp7BIHZ1Hb4zNFFtolagyKr/kG?=
 =?us-ascii?Q?0N+txt+aBBRmlWFhMhq/asj/OcOYTovOb/UMeaV1Wk1uDnzsGZxRE8zijSOA?=
 =?us-ascii?Q?/ct1wNqDttY6+ZVSurpCRUPKtDLYUvANoKtNnYuKYssZYgNa0U2MVAjLud2n?=
 =?us-ascii?Q?tl7e+uBXUu3QtlUCUjrDsnfHqiV/tMJSGKUCJ/pw+6BA4tkz2MrLCE0UiBwo?=
 =?us-ascii?Q?ykYWeQGGcULyqtRKlLht3XXcH8xLuSDDUBPYUnaxlTJcZnmTqZ5u+0/eiSkM?=
 =?us-ascii?Q?bB6ZaTqMTdfuSnYPQwSV0vWBCOUye66vaEW4I/pbNwuV7br+aNRAwEBJndoF?=
 =?us-ascii?Q?vCFxGGNapyvoLZTYLpkGKwCCDTBGDWr4MgvmVgCojBFvGR791hfrtA4ODMuu?=
 =?us-ascii?Q?ggNsI6tH3PPMGdAYH2jK5Lhg67au90VcJVSjCfYonmI23QpmD+cbdfig/5tl?=
 =?us-ascii?Q?kdeGlEKs7s7NSKp1R3D8LMde/tf8EDsqXIBGT4XJszTxdIOE8ChjPVtwaQdn?=
 =?us-ascii?Q?SrsuvTGkJGmOEtNrtuTuarNFLyvZ7Pj6Jlb2lU61rcGcr2aRos6J5rhY/avv?=
 =?us-ascii?Q?CfsIJQzyqo3AWuAR2cUWu1Cx15+U/CLD1gZjvNnPr8dqdjRhNroWdOdu0qn1?=
 =?us-ascii?Q?GKKauZP5xB+OennG77AX2sigpiPV8PTTW17Geet5KAcbZu0DSy//c7kEhEJt?=
 =?us-ascii?Q?lJP/zUUXzvEwNFuH3f/MK89f+XuAr996260ixCsvcdaH6YpFl/yZOaxeVJov?=
 =?us-ascii?Q?4sVcl0QfSvdeR2UPR8N7zR2Wn2j6V4Y/rBkfn+v6kkWNfPrAhIa2BZVTtnVt?=
 =?us-ascii?Q?hM73Gzg61eaMVcnW/yPGtaxjelp94vUMQC/yNaGl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f6f192-e3f2-4246-3531-08dc56c13683
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 05:11:42.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sm5U6UnWaJKoD+LO03ziphgxI4m7viherJ4MXRqC/L00PpAsZ2iQFith1zbG67c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7008

Support rtc PCF2131 on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 07e85a30a25f..065fa3390791 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -281,6 +281,24 @@ ldo5: LDO5 {
 	};
 };
 
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pcf2131: rtc@53 {
+			compatible = "nxp,pcf2131";
+			reg = <0x53>;
+			interrupt-parent = <&pcal6524>;
+			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+			status = "okay";
+	};
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
@@ -343,6 +361,13 @@ MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
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


