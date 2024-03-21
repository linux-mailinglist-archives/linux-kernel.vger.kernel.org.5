Return-Path: <linux-kernel+bounces-109769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C20E885577
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7121C20F90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDDF79B71;
	Thu, 21 Mar 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mj93P3Zs"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62469970;
	Thu, 21 Mar 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008900; cv=fail; b=URyls5h11T3BIh7tHPcxLvPUA/CquNgo9cHqWrxAMJ8+cSjTDuje/SF8YIoepywB4blCGgQpKh7ysX9EiSjLhsRVjpwcTLLj9C2+sX+wnrsWZMyZ6mcvNS5qvf+miQwKzTOKQjcFuJ+8JT5QgIuIiBotQTgnOSCIh6R70YN9pFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008900; c=relaxed/simple;
	bh=cFi3KbPROo90LiCFpBzTeUofuqj6AupRHxHVAdPiRvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AueCDZYCs0pUVbDvt225JQ4aJqF8kcn1tWgb5MCVW7bmx1ZZUEkMslpNoIoYugne6hZfikBO7y74lkPx8S38rDILwB2iH7t111LX4i7tRN6I9Cl3MLaebrdbWEzITmpdRCiS0bYmJ00KqyYVthS1hdNN4AkkbMR16rvdJfAXGQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mj93P3Zs; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsIsV18mv/o8TBGzQX/YOYKZ4hLZs/pwSGDZP288VkzNZxJcawaIg97tqr7KNQdn19bpG4Qym+MLLfwg8vGtNt+J26b9QgEVJWgGYFS1p6QckA1VTdaEjk70qqfeOWduLvlHa2byGrEQ/Tb/ArVu5uStNWo4d4a1+2P99Ql2p+91o2u/DM85SZRXkJR9IjWjbmyR4xiPMN3lyD1lCvSpaBP/2AenEBrmKG8pFk1i3TYILTI/ywuxw8LWnw/H/55JEVJaH5chfksh+3PrXZ5IGLBVAZHQQvs/4vAVtjrytPaGMruiA23MxkMdWyfnjiIKu0mjgX7pE7b7/N7Cm3ddNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHwvn+mELqtv70ZZGWS3Wqg/316kv2JpEPDyNDxuRmc=;
 b=ODPK+VllTHtyrNaAa9BRabJbIM5/DKyRfacoqqesw34hEmGNd9MEmZTf4J9HaAq46Md/n8v6Bjv6CT8hUns9jklMsYfU8CYEMQeSFis5UmFulxgeRNfQf4yE7FRA0Cv/8p12sodtkvpDzbdfVWY/c2luLWoir5VpC2Bsjt7pL5c+8NHb1keLQgQiIr75fReM1eLGYOIPm/CKX6Ct8mGK02T7Vk5l6pgEWO+Ml5RM6+1KDJg8V2PzZEdxt7MVt4OtRhs1SfpzKKL8wza8jQFjaUpASv6Pj/31YxlH46+bRvkvFA73JWWYeXup+NPnLk1eX6W9UOtOU/p+JE5SaTH1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHwvn+mELqtv70ZZGWS3Wqg/316kv2JpEPDyNDxuRmc=;
 b=Mj93P3ZsWPqja9SzQ1KgYfFbwqQrxtcS1i7Q436KwYyKXVJotma6LoCNZAK9rDlMiaRWjnRSXBVl+gQQ5SYEs9cvjwSqV3dsYbk2r8v9tOdSPtekxP6cWrGJM0hk2VEpIbDe/K6G8RVIe36pZ4pu95yTlMhIXcdRJrl1HRXLZcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:14:56 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:14:56 +0000
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
Subject: [PATCH v10 07/11] ARM: dts: imx6: remove fsl,anatop property from usb controller node
Date: Thu, 21 Mar 2024 16:14:35 +0800
Message-Id: <20240321081439.541799-7-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321081439.541799-1-xu.yang_2@nxp.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: eddd0b44-204b-4ceb-905a-08dc497efe5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LXxYNOWSsh8Aoy2d7qU5UqytfO5Ek7BFVk+jPcgzank4hVhAqS5unmNv05WrG2wJCaISnvlhZrNCgvKzqHdVm9LXHP/O+jXiDUbr5/gZIpjJrk811cM7d3V4dSB3Vudm3tYAtnpHBg7tF5LSk5Bs4QkVwV3HWEPEVhoiKgaTjt5GmV8Q5Xo2rVSruBprbXa/Jt1OEgM8d0w8KyOrkvuuUYd4jkDjoGHgtP/DJYBvBPqKXvSzZ3FBYp89Di3bWCJkvT6gTHqyNJfWYOP7coXhnWpPJDnXTZhkyYG8+2LFzn8A8Omb1XGPKf7QeV7tbzuwWf8dLVTGGobal5zQc6z2yLZ/1lsb1K2bz2B10PDNT6qN/FMhcgYirG1tO9yPTe/VeXHrkdzkVHJQcu7wD9uKBGaWlXlVTy1mnFc8AyNy7h+LHrAdMb/8ugCsTrG2MCvFCqkiLDqP5X1xNwBVcIJ3lf6eWxxqXYsqYYia0AaHy3Ttk8oZyQoCe26x+BcxYvHngcgCKgJs/rxgbrwiWnNI2HASS2DL9dwn1ySLyhyGEp9+s+jxiegdmMnm+CwP8pECnDBBV3dUNCFk2OY3vcOx0WMCjgVSscgExmXIcnHo8sNReDxVFeqwrlM3yyvKgxuTlZQRD05O15AolyHTRc3w7Mq3sR1Jj6Y1JV4Wp/AO3gQUnASDOXORQGaNWjZHyPgoGebcLRgLWT0lMUBTfnDx5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?np1XuXGgVRKojaqMPzEOo1PpRjZfAmW7YGecM4byMeQr5tPXCEWyffLXF4MP?=
 =?us-ascii?Q?s6LwAA6S5XPFvJntl8KIfwpJtdkkIaDiZnNzyFpR6hQCEEo1NGs2H2cZLMDW?=
 =?us-ascii?Q?4Y65eprYi6u0Pd+2qlwuNe0/AY/x4tZppE95sngA80HxYU1XA5nzizr0UBrq?=
 =?us-ascii?Q?KX+Yb5tNUy+3p4+39xTkQkmApqBfqCkjt/YZdt+Zc3Rd6CrfdyvyOhFOinzg?=
 =?us-ascii?Q?cvD2uNMnBFCgnWBgqJoJ1J3ccHQRGwls5+2CW2TGYoJUZXXkQVeI8wL5meEI?=
 =?us-ascii?Q?grXZ9EenayrjmI/p9YgvJo3oEuUqzPisOXhCMlZ6pZTMC/ieF5Fq2/XsEP8a?=
 =?us-ascii?Q?v3Gej95Q7PHM0oAvaCSSFQOjYgt8ZIsdk/w3dRdaFZXmrcBuHoKLJPXrBPuu?=
 =?us-ascii?Q?xAuFx4RG1lIZFKLidmmuhFoKMTFP6mMHfKLXj7tujzrK3adFkdQYRDP8GP53?=
 =?us-ascii?Q?mZL19SNNF8Ml/sDq44acHzMqgm0tC0iV80s7sRemt26k6FJoTzY+5mpbJVRh?=
 =?us-ascii?Q?At6EPc7frzkoq7NVYAMKXufCDGS0cODsqmgHhlze59ohU8uMmg8fCevmtR4P?=
 =?us-ascii?Q?bQGJYYER+tj67yyHKs7QYaBlp0mpFbfJVTBkzTzLxuaPe7N8QhtarZQHwZTR?=
 =?us-ascii?Q?WfxGp2vyjZE6hJeMDEljbqmsrq1QmXqfMutPFei4egz7+hiqGV7FEgDT0KJ7?=
 =?us-ascii?Q?S7lKJDof9UzAlyHlhSj7wTZMTkbnQRhYXbfR0Gc2O6yy8PcHrgwnx1jAdclA?=
 =?us-ascii?Q?clCRmMgp32pADgPWnTOrkIKirz+3oK4APAQfTp4sZhKd1Jz7tpC9Y+6N0zY5?=
 =?us-ascii?Q?bxHIfibtqTp4gWBlR0zN4qxhOqwdipkGL1R96/+79zjx0NLbI+voWHsTrG8h?=
 =?us-ascii?Q?hzQX6UKgMnxxWhPOJm0DHIZm8UYYhIT0LrBJPYDv4h1pBLpjM2saDFT1bQqN?=
 =?us-ascii?Q?B8ZWlOfqrKxSSXZDmVir+W/jeW78BXwetRXrvN3yCBqskB2dBnZabhx2P999?=
 =?us-ascii?Q?wCKEX8JyaSL5zdT1qsLxgaqHpAcLwdxC2aeOLJ6gYSEmC5l5CSHCDg4aWTng?=
 =?us-ascii?Q?1PWV8ZlIkNw/m1JsXlzQb96pW93ensQ2JPnpVW+dmHSu5wC5bJafDjzyU+f5?=
 =?us-ascii?Q?VBrjz3/ainQxYlKMMnvVLL1K8iLGUzo06YHvreBOg+ZNRZRJkmhqbTsSpy45?=
 =?us-ascii?Q?bZuWzHPX16UuqqKOzrO40IhbYDifP+0Ttfv0i8vfEyZQVKLVwUKROfiaMSgo?=
 =?us-ascii?Q?ARJgkuhaJHicH7ODk93h1G6YC6ooe0zZlCQbs3sqIAclUS0Dsm1182Q59zI6?=
 =?us-ascii?Q?ICaGIV2n3+XEE0Oe9HV+FKJ1O7uaRfHI5NT07OrbhT+6Mw2TDeRW/KLzTHMx?=
 =?us-ascii?Q?iUSWAg/YKAdvMthI+zzDfQZPYelFVErGUejOZHzJNqqupxvKH31Hrp44jKoE?=
 =?us-ascii?Q?UKjUClYe4Rmh4EWkzJvMi+NtbEvC2aqWbc044aNJVRVO+Pt211T7ExhalDXe?=
 =?us-ascii?Q?lOlbsWvLGXk7KDqHzFxw8hqAvhCe/fCZeYO0vugcSoIgjAzP85kVhLvFpF1R?=
 =?us-ascii?Q?xDWxaQzyq1G2AGE7UPhu3sJm3losBFax4j7+7NWV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddd0b44-204b-4ceb-905a-08dc497efe5a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:14:56.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6wspJZB0toEZlLtrTzeQ0yQYykNwOLjrZLL+Sfs1Y2myrwbXZNYRUSgmj0x+E8AEuBNHVF5oiKrkrcoDD22LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

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
-- 
2.34.1


