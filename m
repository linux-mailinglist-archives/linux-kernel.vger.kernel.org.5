Return-Path: <linux-kernel+bounces-129386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE308969F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA891F237E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BE37604F;
	Wed,  3 Apr 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YBQltnQo"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2114.outbound.protection.outlook.com [40.107.247.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C371746;
	Wed,  3 Apr 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135070; cv=fail; b=MT4KV/JTjUD9hgNXpVxKL/qUC6f+l1/SgpwrnxXaXzA5mK56GBUn+lx4NQVyShJowsk/C2KAYKyGaTGLqpyA6usy6jzyXIsDUT7Ztn7WNltnGrbrSI4SyLfcHL/hPQWeBI3hguCSW8WcpkKjHDZ2ReV4xJdK4BAfQuU6EP1SNxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135070; c=relaxed/simple;
	bh=Y9jJPO747GT5TwHA5iUgadjbX1G14IccF6aDDhHbajE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEIguj9PXJuyipzEibGIfQbat0Ja4+p7yVEBVSKuuns5ROJbU7Uy0mUmzsgZXAloo1kAG7upm/PLNuXAblgWblM65A+52Lynmwr7g6f4eOolB/xEVIWIaNQkPaJ8yoW42Kk31YfAoCNDfpKyWRNwpN6OrIFAqoxtoas2vUodPbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YBQltnQo; arc=fail smtp.client-ip=40.107.247.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrhJ/XdWkXK+52fU9LL6oBn6dYHDtwZd78Li2AnJORbTveIErXuq9KK923vIIhsk2PgqInfIoS1ZX+eSEJSpnmeh1PEdmGPSE/OXVj80rZuJ9qoLTckUllui4Rq7aSM/EPRyx4AXWtlvA3T5pIDVFaLDIhGquGLbjIO6ZPNO1BPbD8r15lw5E36ErBAEBaouSpp1l2VLpNC/E4QQjHNIQK9Z0fK3aVPILb1nk5u9QXMp/M4Q/31cMU6r1XQ/XXgCb3RbFTiOfmjIfYudu8TXJ/LLV3w05C/FyM7o+kyHtudomrEOmQuTYZ8F9C7HGuyRHHlLvzDepQeHgyaqkYIumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y5E9TUwGcKuJ7tf911F4InYnlZU64IzFPQ2r5eMcN0=;
 b=QVuIVQA7LeXJDVRXOJEwWN7rK9qJ0NCabld+cBXOCrkAlHyrYBLI+BVY+1/u3kOgw5VFB3ixODItiuy3nD5J4FAURYnBDUWmv1BhfoyJ2ZC+VRcBtcA5xNlaOBhCkqcPJI/17aN3y104a16tdupHjyuU9CEvkE0ItnVNTnWXdzywnKvN68Rn82ysnqAlhq+awGQnbSB4WpIRQ4fXDEtU+oIZ5QCZUHovNe+ZuVVOkDvvO1PxMKhkKT5i+uPZIQD0uPTmmkDFeLQqto5BKx/zedKOl36XIqzz7XLKdNZuujQq13LDwyaTTJI+xhKY/3mZwU0U4fa6rImRuTMQ4y6rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y5E9TUwGcKuJ7tf911F4InYnlZU64IzFPQ2r5eMcN0=;
 b=YBQltnQoKvFD6rwhZ30DwGnxUUAduHr7CY9lESpYyIdh84pcbq4FTxwJ9MMD+KO/18azvLOCYkbxDaTn1z1Gs+tXgfGgh7m6RJVIMTXIMb6cWi+be9gS5VLbFXtDFqinFospp1V5InF2FH3ubQlzLKEMOSTTw7bmER0g3DQXbNY=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:04:26 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:04:26 +0000
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
Subject: [PATCH v11 4/7] ARM: dts: imx6: remove fsl,anatop property from usb controller node
Date: Wed,  3 Apr 2024 17:04:35 +0800
Message-Id: <20240403090438.583326-4-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8216:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lTfUTsP33TiJoIIymcd67bSOHb4xMGVhQ7rh7DQaIL0v5n84oMClE4LYPSu2JZGPG9UmxdYG1pmeJ1ux34lDk0gm3JDA96cgq0YGbm9mKSWhUrXhyyIUP4CvvdCmB3tu5BI2CnrUCUn6Nl4PrXE7Ove32T/KbWIZjodZYNEjV3gCrQho6F/tiyu4ZvS99PMzAtJsZdHUVlpFpsDDWi+ayjW5V05W0libbR8Hjxd1QTYS5k6917A3lNs514a5IVpmrT04vzKBrhLLCd80rUG4Ts6dATKk8/Z7+Lb3RaNE2GbcvwmDzTZMlnxZoygq2LNSP1KSbCxHmBKOI6jqxgGgeAjJp11zNFN6M5axy8flSYwws7Ory8IX8DZOe9u6I9r7fnfPrRoZ5UGrPYGhUb8D4/E0GgB5iHLZmjABloUuhimz4ScCF1mORnEDsBKfKilNZVCmvqKyU338kXl4bKf01UVnAYK13XVYLJIsBPAfBsUPMTxbpl5NWEd210mCe2nkgZ/fUmweI/EA/V+uURH3IZ0fSqxmBE+FdlM2XJI8zLPPmqBBG4E6x3FUkk9pyH50DdwAU85xKIJwNyskW9iI9/cLMvPVBAaztLfyXueWjLPi+4oN/kFziKbqUXmvkT+rrMb42M+Ax2hCzxnnMXDDCDMryr4mkJgQvMCem/4HrnL99lUHAMI8cLOLrMMZdN068gwX1UktEDD2xtshp4fp6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJOK7jM0jQZhPjepKc+kMIVJClwczv0OjHWBteKp3UGOPlxaZdplbdb1nIlP?=
 =?us-ascii?Q?/jT693++TkovQMFC7az0yGfRo+QG3HEpN0C0ctEBK+0i2BspOVfueuX7e0Ip?=
 =?us-ascii?Q?2dOvnNZ3t4jiq5etVqfOGC0VsIjl1k8ZdLWZXoGnzoeHnBoucCb5jRnHk7XV?=
 =?us-ascii?Q?xXLqA3Q9vmYNwZpmyr59q5HDysZdPAT73ZjmZ6lj6KXI/tH0hYfiGY4YiBmB?=
 =?us-ascii?Q?XliZccJjRO6vkJiAYiFtaZel21CRCCzsPSGd0j+6SE6GXw9Q/B0V7hgKyF5k?=
 =?us-ascii?Q?lM5ipzBbmdTjBJD8x9l2//hRC3nO3ZpNuLtXUYj1fx/ikRECSNu3Wvb1flml?=
 =?us-ascii?Q?9y/ouEDJrSd/hAyCFVFvXzay0nrt1lbK343m7BCj6kIJvQxC7FDJN+3wfK3U?=
 =?us-ascii?Q?OX54U2+1jTzR6utkuabI2OzBvwJxW3+VrUgI9vlVURWVlMbz0Ha9ZFaMGYrQ?=
 =?us-ascii?Q?Q8hCcmqkuHFkAbz8BLRvh1L02ZUI/+hieMYlnRhFwAnX9yonejdvAgPpqq1t?=
 =?us-ascii?Q?8/80mW3U+azRoLDk8q6mXZTBkq0UCMJKGUHHcK/VFtbyeifHv6zK9QCBrAv/?=
 =?us-ascii?Q?EaQ7mRRpAMS6OwpMGAj0/mKyafeCNCuvhXTEKu4dso6lRFRLH6tGGc/fcEPZ?=
 =?us-ascii?Q?+fUjnM9edRLqSmjQwY3IPqVdAxDbFOAlyMzsno8lzC4dTT1tIGQLW68d/a9i?=
 =?us-ascii?Q?c2eDet116QSmG7Xe8zyCKg/KvDvaP/kInXjOK0a16YmgxWZPHrUw/L8jBFLq?=
 =?us-ascii?Q?UliO2WhYlsq6H2AMsPY0Re2dNPEx4bHShigArTlxjlhJJRhWhtti+4vTpiI/?=
 =?us-ascii?Q?eHUEMD8I160R19xpQpho2VtWXbG978DXKP72kwMq8CVqe98E4y2gEPNipP3T?=
 =?us-ascii?Q?Gk7QidYb2LgrOSKv2XjHAs7AnTupEfGtalHpuurHPSucX1PMsfq7hHZwiSKF?=
 =?us-ascii?Q?MWqOklcHuqwe25OKpnHm1MGnAwoXrhrdadML5lL+1kLwntoNGAGnOnEZlNXT?=
 =?us-ascii?Q?6VPCaMKDeYP7xifOk7gBvcIuXEdd5CEmXwHV8g9pgRqarhjjt8/F9QGiCcZQ?=
 =?us-ascii?Q?g5S3sppM5cxd6TZvYq2W8Dwb5KhBXrM16WcMFDA99M4lqBvpHmVhXGv2v9lG?=
 =?us-ascii?Q?Bmgtz+7/Eah2nEkQtRsm68SpUKC4BjroBrPCffgDocv+EY9hmWq+8jIDsWOp?=
 =?us-ascii?Q?+GEeM9em5FI64jzkp/1ZqtzYn4StmS0gIunWLAcitjaZ3300pChEPVYECbws?=
 =?us-ascii?Q?rihx/muFKbxUy8w8gEAkeubyEZPDZNrDsCUwnc/aBwY5pDXwTYXTj++ung0O?=
 =?us-ascii?Q?DJ6haJRWRIDgxNwXVQq3cz6KTCaY74LybyXKpCjFjVRENUiBYedAeMMRb9PZ?=
 =?us-ascii?Q?XWa224RgRF21n9Ahls7i9gPw65XNY9ETfOTnBu3rH8rDIqIvzEmzILi0bmbq?=
 =?us-ascii?Q?9ehzIWjLWBaWPZkOlThOes/K3gOJqple85T/Owmpg4F6nMbvvN9U6RtzRCBM?=
 =?us-ascii?Q?OCri8dh34Nfu2OcjMDEdS4M3nb13NMwhWVox3QVhWUyoaJhxeGK54d3f1VNA?=
 =?us-ascii?Q?IfGtgl91uZeWg+OfmZ+QEgnjsLCwIOSSaS0BreK0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbbbc9a-6577-4c8e-ae61-08dc53bd0fdf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:04:26.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvY1Wjq1p5rk1ffVTW3Q9gc85gZTB7g5mnfTPyR+w44nMY8HjPuboPekEKpVVZ3+sNnXyXOp+6tgR2tN20v7sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8216

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
Changes in v10:
 - not remove fsl,anatop for imx6ul.dtsi since it's already removed
Changes in v11:
 - no changes
---
 arch/arm/boot/dts/nxp/imx/imx6sll.dtsi | 1 -
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi  | 2 --
 2 files changed, 3 deletions(-)

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
index 0de359d62a47..6d3deba60de5 100644
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
-- 
2.34.1


