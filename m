Return-Path: <linux-kernel+bounces-104112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E287C918
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D761282017
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4096182D8;
	Fri, 15 Mar 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FOOWL+iW"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85418042;
	Fri, 15 Mar 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487518; cv=fail; b=WHqSqsgZtektqrgD3bMnml76d5ZeeNSKJZHzieLHAEwJJl/NkiYAlAWc6XbR1o2YxMPr5JRdahC2m5n/qSRhz07/TzPGc9d5rUcEswKuYS1Zg61CX9Pf6iZKT5j539Oup3ctH6t3GhjcVY740lKL8d7kvlE6Be2iQ8NGBnSzAEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487518; c=relaxed/simple;
	bh=iuxm19hU13iR8g0Es5bWI+8KhUiO3L5J53875hiuIIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3UcdbXiZeYuoPS9Bv1LWW3NjA0g3Ay/Vlb8ih4vvTqD1bl5SDol0fibpOFAeGWd90ze69sbIehzpLdaLcotdlhoVCjwPhTjG1yNFhdfDfEKlJgbr3w34P9w7NHTlFes2dM05d+puhEW7MO+w+CDJFeSjBwgnQxaoZMdfhZ5ARQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FOOWL+iW; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmH2zixGOEm5rR+z6+9akvtNZolQXcyXLI+uG9d7m73MmNPJINcC71Dub21a4nicuGfP+Osf9MJ95a6D0EyHD8k2+Hf7bYCYiZZsVZ4L0oUxmWkCxW5XkH3xLslO+XikXCBJzUH4F5a2M1NMw5DjhAoVmcCNMzO+iEX5zxAKak4bAgUwstFTa5TIanstqKNd2jfmEnsgzLU1lYQfhDwzxPKQJISO0ol8IAKZPemwb6w6YK5OqC3807nCPiEx2HPhqoUDfCInHB9mZ9spnK/oXxk3br0WQWqy+1/kujew+Jm+HlAjloaDOQnU3UkhdGR+60j+qD006Pyun9fEn5KrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ+MjCh4oK5/RQlIAAMaYxHzGcFLdlJacclyGRoZm+E=;
 b=REWJ/dnlNHpS6WediPwzt9VrX2w8cqCvZzc0OJ9kbnD7f13i2QmJUruCNRg/NUQmXovE7QQrM2w/4Uldog5wYdkTJ3L+7ojwcYTETVGLiX6YTicwJfF1OZZHqr8zXJmkqb3gbWj+9ZaT63OFtk3VSLHtVA2iRqc9wo4TEVthqXocpyvR6oxsGNx+0vWXerRCO5n4n9+Rjp5sd1WsSS8XakAkYa9/mQJGIGf4qXltj8e8zeoaliB7d6JIh/QGImQBgASJDKIARDFb20UOLiidGbLKMHjKSPAisPhIl2XnAwpyoa4+f5Ums7yrxSS+tZKitmAPCs61KXPTnndaV6BeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQ+MjCh4oK5/RQlIAAMaYxHzGcFLdlJacclyGRoZm+E=;
 b=FOOWL+iWS2A2BandsF7w5a+AosvF5cgcUe6PW32sGpdyfzAV6oV9UpOMczAS4avgTfQAVY5Y7dltGJkXmit53O71hZcsyx3AQY/S53mJZmBLrWj/OV8yPzGqP9TPhFvUDEq8w3jUvJyz2s7OYBhmSryqz3TlCgw7ws4OG0PlkyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:25:13 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:25:13 +0000
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
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 07/11] ARM: dts: imx6: remove fsl,anatop property from usb controller node
Date: Fri, 15 Mar 2024 15:24:51 +0800
Message-Id: <20240315072455.2481613-7-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315072455.2481613-1-xu.yang_2@nxp.com>
References: <20240315072455.2481613-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa46286-2628-4829-a0ec-08dc44c10ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f0NJmFtIIrlGT1w4z8TJchVF3sgwR0pTFhFJdPKSJT0bjJuX2kUNXD6+i3PCZjGC7oxmvAQVIKYZefpsAmdlQ/COOnTOr/ugZgpOZoIuJ442JG9IOEqBDyxL44+GSwVt1jnlwLrC6UVIS7piFJsY9f7tNjf1jm8ZFtsZqAq5qb7Gsh46xz0ZOqADCfxPNBTA2t0ixfBFdKFSyy94iT7P6m6w04CGB2tWHqMoCPNiBNdIFaYmPqVOjdiM7QGs5r2y0jlmZNAjBghAxwI/Odb4/6gYvyV34ARcX8VVFMxLz/fAqk6edEtJqYt6IRXwuHcWhXSndVcocHAsfC9OXWy+DfoQHa1qTKLBCffQYaIZkngb4xb0qABqnA8uQxgsi9WnEmaQTlllVpL1hnk1UBlC1/tEfpaR+Zss8hPc3IninK2Ot/FrOiGbbS6jeS82Fsa0JjGhMnX6AcdCxQcthvgEiGP6OFQY2GbQ7BBfjrbQdawQcMmyKmg9IHRJ3RWosDIfG/4nBm+1lEeNhZuKEiXEGF2mEtuIdwUBD+twA/530GP3TIuslawqHGzcEtlkuN67WXlzTKmowQ7o6WsLm/RyWPo3PSOKAn0hsbMLLuV2oP0usuSqwad9CuQsB1HlI13FHMnJgzlnLRgMGy2t1amTnKPKIg8qF+Mv2vK82204J6leef/ZubtvnIRgiXTzzM4EHunmQUYo8KKSUSta19416Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cucy0LJnZl6yzPELXqdcPxp8QuvCgqpeGeulgVZ87xwefmBYO4JAIC1DjAD+?=
 =?us-ascii?Q?DMqQanUJ5/ZpOIMctO+rWA9OvVHUYNjxQCC+DgE4hh2WPJXL/si8xtdl2S5m?=
 =?us-ascii?Q?uq5cklWgVYEVOxC/LHAarMZaGjUaiPrKJk8wdBBKkoUH00QcJsbM63Izfxhr?=
 =?us-ascii?Q?2R5aVEGrTOMKdgZTxuBMthkU9fDFKEKTR9sDKDl5FENDr5SVrvhgOKHNTJRm?=
 =?us-ascii?Q?8kKaA5qM9FFT4jpDQHAPkued6ppxI0w/qQg6IIRooLPaXo9wtybMLs9+Notg?=
 =?us-ascii?Q?yFd6N00Hj5DhHDWvUuci9TVpZUdaH4aowyWRgsrNpurBUk+pDZ3pIHZIBpOi?=
 =?us-ascii?Q?Rs27UkuOcJyTcvFenPebTFLbsrzB9YBZkYguPSNbe2tPvAWwJu7H9Z/0W6cO?=
 =?us-ascii?Q?0xRe0q/lRnQaIa5z/CXaE3RcfxHLvZpiDcTOusP7xuqw7696rrRCjaJ5OH0V?=
 =?us-ascii?Q?mW2XNFxg28VbS1JvHuvwyvatrWOuFBBi1qpxHkP1SnSaVYmrqaFHlOa8SzLy?=
 =?us-ascii?Q?YBfGdQafTP7/eSmvHkADvkBqWws1zMM1YGuiloyauRUda+Y+ZlCyMx3ekmCW?=
 =?us-ascii?Q?+hCySKtkJRs3nDHPL2Dpvg7oqdL0fMg+sIKw9tNnwsRsr/TvfLt/lrsCllIF?=
 =?us-ascii?Q?oGUCBSh9msZ0kDFf8TLfpemn3V85XIBWquGficAqUXChWC6ptQxvwGob3qwr?=
 =?us-ascii?Q?HBaL91eG6Ch4Qbrk8qH1jukbLudUEyhbkbBVWGioLKLkBUMnPCaBV1H1x8Gh?=
 =?us-ascii?Q?MdZsXI4qZcY9Ib4CbO7DjsLUcwwTPSAzMTUmb+iRrTS4MY5w7FMfDdIsqH7E?=
 =?us-ascii?Q?9pxRJ4a3BiutNUpanUn4fxUv8zgyDH2ioYDWyVSMPYS5BnCcU3TatEZm/BNY?=
 =?us-ascii?Q?ykAat3j+K0U7pdsaxQrp6S7hugR/1hGxJxQ7x9IGLV1lk94k5yHJGQ8abdtm?=
 =?us-ascii?Q?ZqeWVEEyPQXcOamemHGBZ9lV/QsN6A+84p7HKPW/tmHwgUWjpoMXpcAwuC3g?=
 =?us-ascii?Q?i1KvyigRaupgm8rm00kXd28/EfjMwjPiT6b8e9upp2TVPEOT/7M7dzqaKJdk?=
 =?us-ascii?Q?VSiZ00mMmPPpPBwsb5HGH7U3x5Akeq1Oxe3WCQETTNVOqstP/WKGULiMEbp1?=
 =?us-ascii?Q?4FPIXU/kVEnNN4o2T9fob6W7Hwh5bC+7kkavsh5A7mc/CWqx0bgkAx9CGRHq?=
 =?us-ascii?Q?kKY7Hd9VDyOahbKhAGCMbwvG3SuPvCPwMl6ZAHdrWnkWL7jklZkqWsdJZD0s?=
 =?us-ascii?Q?Plr63/LTv+R8Jh4PnOypT8C7WfTX3jiOsqzCA7SvyO71VeocEzZrpL7rRJ+F?=
 =?us-ascii?Q?A5r7rgBiK0SIFnA2tu/1hT90SBn3Glvca7URb7FSodKrvk7+eS/2/8yRWxWl?=
 =?us-ascii?Q?Ipcp81X4FjkSpRI24PIWlMo9VQvOmXnf1TFk7gz9edITeyxzzgapqxtbaPka?=
 =?us-ascii?Q?VToNBzjdhvRYwRDcXJOAwS6XPp7X9TLIDgjtPXUInYd56cccbfpPjjR8MR/0?=
 =?us-ascii?Q?0XaFTx3fswbVPz3PzGIdxMQRjwJr0ciq4oyGl5o1oNTBgyELHSr5Umtdfq9k?=
 =?us-ascii?Q?Ct+UPQMpae/w/CsSbAsMkacBwKV8/6yBwFKzUMc6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa46286-2628-4829-a0ec-08dc44c10ddb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:25:13.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpqXjiYMe2xL7JGSVDKacZanmpthEARm5wVl83ocinZ3YoCWtbRN0duu2ZwnPznroxnlXFtjO1nWBrXxnLfRvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

This property is not needed for usb controller. The usb phy needs it
instead.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
Changes in v8:
 - no changes
Changes in v9:
 - no changes
---
 arch/arm/boot/dts/nxp/imx/imx6sll.dtsi | 1 -
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi  | 2 --
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi  | 1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
index 3659fd5ecfa6..ddeb5b37fb78 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
@@ -683,7 +683,6 @@ usbotg1: usb@2184000 {
 				clocks = <&clks IMX6SLL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,anatop = <&anatop>;
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
 				rx-burst-size-dword = <0x10>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index df3a375f0a3e..b8d95957ca09 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -929,7 +929,6 @@ usbotg1: usb@2184000 {
 				clocks = <&clks IMX6SX_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,anatop = <&anatop>;
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
 				rx-burst-size-dword = <0x10>;
@@ -957,7 +956,6 @@ usbh: usb@2184400 {
 				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc 2>;
 				phy_type = "hsic";
-				fsl,anatop = <&anatop>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index a27a7554c2e7..9eb4eee0c272 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -855,7 +855,6 @@ usbotg1: usb@2184000 {
 				clocks = <&clks IMX6UL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,anatop = <&anatop>;
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
 				rx-burst-size-dword = <0x10>;
-- 
2.34.1


