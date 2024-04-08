Return-Path: <linux-kernel+bounces-134743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35289B646
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B1D280CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061208475;
	Mon,  8 Apr 2024 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hwUVxNQc"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2133.outbound.protection.outlook.com [40.107.22.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7754C63;
	Mon,  8 Apr 2024 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545674; cv=fail; b=EojozA82Vlgv2/tfuHDEUhrIHNcsOG3SSKyZkRwE+58oL3E8zJxtwm++/Eu6u5L7vXNmk5ZFqwdzAurXnTSxCgceh5mhMdVMfy2dVO0kAK9iN6uU17sHe1YrXm7oEXEGRZuQMZO0U0/Wd8QXDcjGH/3tKNtdnUq1VwWhXFjEARM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545674; c=relaxed/simple;
	bh=Ks4KKKLHpQj+HgUWvysHt96WnVXkyo2QKhjcjCz0Uaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxvo37/IAEOykKSpCXD7JBJ4R/pSMi5l1KAGmpPTdJkBA/hsV9aCIcv15jlJGmxcYgjGngEiSZA5lWpQayCRjTjdDXnytmgdEr3j+X2OR8t+dbj724jRVeqYVF7KbkHvjFxGCtRyTH91nBhwRPNo6GuT1+l/RTuZHGBzn9ouOko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hwUVxNQc; arc=fail smtp.client-ip=40.107.22.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9J+PsX2BQ2Y0iOdKeApQyDsCMlWNckKBLNDVDUnbqq+aMFADaSoXSlAKFJkPOHeLPP/+wU8QBNqZUgixhYmpMsigTmoMs5jJ9/NiDQcDm49q0YAkEBOob/Ia75LHsH6m0CcWHNx3JuCKbhiM8L4Iu+C3nAnacy2XjsQzjugi/ELaSI5dC+0wDZhb5kSgafnZWIAuvD62YoLaA7FyZjIXZ96+xh55fka378KVMbPZ/oC3c6u8jOFHJJVFhSjDjjD8HoGkNjIgU4dyk84rJvdQbUOgwLB3WuoCwqwhCfLsuDgr58mNJVqC7CaBkHZqJSpOcAwI8fpmM87j0GdLvPh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVFDfes7qmzDjufPq7GpbX54fyyysmDVLtqVuw86V/k=;
 b=LesC6zMrcu2m1mLBmn0dVqu0mbAr+j8iRkY9yqm5uaIDW/RnEvJ/m+a6w91ZFgIjtOXxouoGTrlpji+1LeO/HYb3492dD1slz6sIGQ/WSVx0fyqUuxjJsLWm5hz1LbMijRs3MjiXwvXYaohTuUKs+ey37lYiXvWwuODSFBn2KdY446xzYbbBSvbrnbYFFVwWNu+JusXF1ogX8AMGFxd5R8zrpBpUsRZCNETZKUHz+6YMFpPLFHOj4pJXu42j2pOGakbvnNg0A4PbL2aFBeLzZSxjgjVdAPyidoZf3gSR44IijwhPv/jB3rbdyJjKGHFa4BZ43KdfrtEZpRVEkkTghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVFDfes7qmzDjufPq7GpbX54fyyysmDVLtqVuw86V/k=;
 b=hwUVxNQcheAepoMX4fKmWhWBuZnTR/5YQyDpzJdkZeG228wiKS/ZMNPtVqeE0KuqlgxqEviRooE/azoKPSpUaPtxvEHwHdgq2ScUwqkPdL3gmTVTwS3heMFAWMNOi/Sz7Lc3jtGmtHKJJzJpEwwb+O5P1CvnDDjEZe4s9bfvrYY=
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10)
 by DBBPR04MB7561.eurprd04.prod.outlook.com (2603:10a6:10:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 03:07:47 +0000
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57]) by PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 03:07:47 +0000
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
Subject: [PATCH v4 2/2] arm64: dts: imx8-ss-img: Remove JPEG clock-names
Date: Mon,  8 Apr 2024 06:07:34 +0300
Message-Id: <20240408030734.1191069-2-mirela.rabulea@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408030734.1191069-1-mirela.rabulea@nxp.com>
References: <20240408030734.1191069-1-mirela.rabulea@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0230.eurprd07.prod.outlook.com
 (2603:10a6:802:58::33) To PAXPR04MB9231.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9231:EE_|DBBPR04MB7561:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	th9aM++Iqe1lvloGFIiHenj5WSNsFzadQx4eiMPLwQG/j5LtyNmU/Qz+RmNsDAOvOpcc97sOlAM6brOU1OW2Hryast5kx7FLAw64qt8NIMLy/SXMNQqFIeE4pwrXCJ/Y2qlonT+NMVj+MVdloZfN415bWEGYqqrM+XqDL5IejNbmNFfIJV1XIFRcK2CeYTm71bg9Pkr3F5OjgQzBSAUZwfWCe+vbj1XvnLhbLCx5XtQijM7CRjBrgXeLblKAYg3IOfFRtgzTgBP3/Q8TEgU8wvhcw7DmSeXjqMJ37jaAo/d7q3xGhVtEGmA32FV6YcUEzrtpp/uXPmreBn0JKMqIT3Kleen1sVMgLrgIACQJwtiypIfSGyd+HiUKgfsrk9ZhTBhHaM3nbdOA8S8AXV3X6Fw0tU9ZxjSF0TWnTqqw3Svvqs6bTyFKmJ6J2/xtRQcSgwQjin1s/cxteUHMX3pPdCpwPMnwlOYemzgryt4PRbAKLpq3GHvF5TdX5huek87Z8vo6/0dDQkmHEwGUl+PwbvAYADkegDKW42LVv4vgKygFhYa5lvfKsgxE5W9MmIsZlyK95t5tdeZIHIF+bxA0xSZd1/Rnq8fXJu5Hv1AL6zqmP2lIn40b8YQopYva/4CXLmDCgdt1ApNopyX47qGGidPvo6FGFM8XvV+BTJra9t7lOMO39j3M/o+9bZeZICgkncvWPLP6zDdiaBpj3I876t2oA4iHlCJAicKBbtaKMYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9231.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+q0NgWqH10rXQZO3A2KK+5dpQcgXnzH67ucmze5+NNLwd7qyLS+AZCYGGYs?=
 =?us-ascii?Q?bjzA3LgPECnRhW5JArZPX0pgHlyeEER0aRCDNvF0cD69KUfY2pDc7M8eF2Ml?=
 =?us-ascii?Q?+Ii5UpnK+IM6cRv134vfCz9o9lKsCb8TTxJKZUyW7eJDd7AdrM6+DhyfkPm+?=
 =?us-ascii?Q?dyLxJcHy/35hybI7TUQTTMxWCcWtbGtOfFvbl9c8egOwBSmGTTtzIkIJk0u7?=
 =?us-ascii?Q?X+nao9FoOCYSiCTiZUYezu5X0K5Z+ONH4XVs8yiY2rzl3axvzSNYzLlkqmzY?=
 =?us-ascii?Q?Dp12YPyh3nsmjNszsa8Sxnn+pRqGs1mb2sZKNwg3Uh25j3ujCV6Xy0QNJ/Hs?=
 =?us-ascii?Q?2TkzOAzT9n0M9ZaAJis5S8Fr5XQOxznqBCz3rPUcjuZaS/XWDQz0s7KqYh4Z?=
 =?us-ascii?Q?K+VUm2tETB0PznzKhTe86XsUq02WzY/USR0EGPH01Wd8ZyenCtsf6cUEwXbN?=
 =?us-ascii?Q?X8BNi8HbukWMHo1dpPz2SfOiQ0iK+m5JDd9yq7HZubk318BxStWCYEvzTiB7?=
 =?us-ascii?Q?LcsoRZ7okkbUwtRfuFW4xMDeKjUm0Bo891zYGB6MH4PXT1o3J1AGWjqjHYer?=
 =?us-ascii?Q?eeGyiOYTpVbQXX7EVo6BDPwEpMLNqdE1aQFmzibQn47zJYVflDb5PVDHJlhS?=
 =?us-ascii?Q?1Rpz59veJJg0E/qHqsIaMutsoJJh7KqE9EG+p6GZ9Y/ly/e8223ZpeTiPhTa?=
 =?us-ascii?Q?qJ7WYYoAf40K0oe3P2lIJsb0yAldcS3yEkWVnJHy+5InOSXSN5yLn5Q+RKWl?=
 =?us-ascii?Q?p1aHhYcwZ+1eIhzu5s8op6iaiZkDBIhHg7Htu7yZvTwlJsuzjSi1s8+G7Zyw?=
 =?us-ascii?Q?iP+zTXNuwpzV90hc2HwSPqgPneB8NvC1fEwgkh5Kq/qJ08WkNoXra835ZXKD?=
 =?us-ascii?Q?X/Bhmnx8Ce5mTkMk2vGg3J+vGkIHhaOTBCjVaIp/cpzTI1XhDWBLu3CCaBe/?=
 =?us-ascii?Q?MrBBHR1wBS01n03YwZmJWc0XbAdQbf5o/Sm0VT/Pl+WEG3vAMdsKChmZ+yye?=
 =?us-ascii?Q?5FVogBOarhHAHCVWoF5LOlEMG2Gcwld7hsujU2JKt9duch0UVuGSF7c0j6vP?=
 =?us-ascii?Q?ooVMPaJqHvngRuIqrow3BB/jCLu6G4+xVPq4kG7b580ECcA07dhNdnBP+kt8?=
 =?us-ascii?Q?nlyBURdZ6afWOsmM5CRQ3tO5ifFER/5Y5oMR6xvHeyNpjmLBKRT1kUExIh3B?=
 =?us-ascii?Q?XHctTEy0rE1S9VsbUN82I2px8SXLfqhEyCvNO9Xr2NfFYVJYylxR1zTmB/sN?=
 =?us-ascii?Q?IFBVbTDYdniXgM+9XmEXDJq1gtoUiL3Z/X3q2j67Y8SCqG9zrusBM+c/kUTY?=
 =?us-ascii?Q?GV/61FrGU5I0U3msHYCAgQuixlRULPHO6i88MUnO5+ZLhGNZ5RHuuP1fc51l?=
 =?us-ascii?Q?eb5T6Pn1OMzNUx6nuP7OnlPRojqMJyDuT9VWElS5BLqc0/2WMD94Ce9RAgKS?=
 =?us-ascii?Q?N1nu78cqXz+U61u5e0TCsnEMTOLG7MSk9zZVIiiQtIQqIAVEAdMFu2aAufkO?=
 =?us-ascii?Q?ltM4rVCnlrbdJdYUEwj87i6gT0HVKgqahTNzdcsKkYKCC77wJYPlyqBJI75f?=
 =?us-ascii?Q?3+UvkkzAJdwbrNy4fR9WBcz0UY8xeNW1/760NgHS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d450236-6427-42e6-a7ca-08dc5779117a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9231.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 03:07:47.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sVDOIsUiC276YnSB+PBa2PGLW0QDKTaaBSx0L8HTuc4Mbw6mELHZn1r6r7rXRQZNV1txTuy1WhjuC/7E+ImhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7561

From: Fabio Estevam <festevam@gmail.com>

Per nxp,imx8-jpeg.yaml, the clock-names entry is not valid.

Remove them.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---

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


