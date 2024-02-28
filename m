Return-Path: <linux-kernel+bounces-84620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F986A916
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3971C286FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F0425611;
	Wed, 28 Feb 2024 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R92/YfJ0"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42782031E;
	Wed, 28 Feb 2024 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106017; cv=fail; b=l/TvBtXApfTuC5oXbWLVzY/upDzD4vvoPdbXmhC02STQ5XRIIh3qVkBKbC4T1Kck5Gd3/dHikyzlWtn9YdoCY2uViolZOuTVcUniRw3uFzuE5/zDiyhm44DDTcJBEYP01OY9e7K8vOQ0EsjDOO/7pSKHpZyQn0EWJ/9zv6sEyX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106017; c=relaxed/simple;
	bh=Sw1vuiHIqJXIfn+XmGtWdztCucWeY+9FVkPPCrCfMj0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QR97qW5O5I2t2V2mCNw4cYvU7qJYoz43vfum0W196uGf0dX8+8cqM9+YzAb2NhEe9LM+sU4a/n+QFc1542735e5K7mbqsFVmGQzTGCsmSVDCKUDPqXmQNTSpWKx3lutKefhqKTpGWs8rk4h7HU4a40mBz7/wozI1m9CF84FYP7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R92/YfJ0; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnEphOD1KBRS9vn6XeRE6vzLBF7Fko+W8ZZpzzXsnbJ+o7SZw5Z/zp2iPkmmtk4PIaWeww2GJdID37utHHuWKKTVzPZFUi+UI9q5f9ZA+TdGuZVZWG675Z93kYrWm88GqUEi7MHB+E5fh/4JX/4dNl24ZyxJbsInMZRO82McHE4eGpRfGY1QObKREyvXpiokK+DhhYMEs+lDqgLO1KSCpTE5YNb22PYVCMpsWACbOumCjdkdVX5EUdeXybCBhjhJn6NBIWB9DdlDpF3ecxiMMA0zPaXST6yskMwps/0yQm2fb/CN7+y6A+1ed1GEu0ZIRo58wAGrZBhDdjj/uZ/4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh5qEmtdyy/o0PfUGswUK5/e1klUYMnfv5f+aBUfBIE=;
 b=aMtwFQj+gDIvNwbXNwX2Iz0qwDv8oqdwvcxul3w1QhNfknaNCCM1xuE1QcwRZ0OYoJ9tXe7Fn01YZPlMsz1YdfyjMFvdyUqIqX907d4e79/CESLpBKWu4Ewe+ovzjoC0XOjd2M3g9//8B7dzAXLiSIvm99ZP9NOoWPksWgXrLTM2Iw+KzQiZRZo23EP2AX2kn5y2t1TakUtiXchTDjvQJsda2tiTiox/g+VGb3Ynn3fdVambS9lj0VDmbHhx6y5WqMgGtcWEQnorLnQydBbOTPAonn/B0JESSa942H/ubPhV/n8YnzqO5YKcxsmtbFXRMmMDKp49q+Uy13OcgBUrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh5qEmtdyy/o0PfUGswUK5/e1klUYMnfv5f+aBUfBIE=;
 b=R92/YfJ05UkJSZFsqpMM4fj8aSlXSIzeSVkqmkjE1CQwsRtJeUPnhz1zzXXdPxdRw/kebBbXtp/ZEQDieo9dGs1Y5tNnobNkQoqGlJJSma8nBsL6JtDHkuC9qUzPF3oF+VKThU64Qw84Ox6GNBRH29oKnrkfrtawusjF3A1Ok9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB9015.eurprd04.prod.outlook.com (2603:10a6:20b:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Wed, 28 Feb
 2024 07:40:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 07:40:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/2] Add support i.MX95 BLK CTL module clock features
Date: Wed, 28 Feb 2024 15:48:21 +0800
Message-Id: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXl3mUC/32Myw6CMBAAf4X0bA1dQIGT/2E80O1WNvJKSxoM4
 d8tXDzpcSaZWYUnx+RFnazCUWDP4xAhOyUC22Z4kmQTWUAKeQpQSu6XqpC6e0mcO1mRLVFZzBF
 AxGZyZHk5fvdH5Jb9PLr3sQ9qt79OQclUVrpoKEOVmzK7Dct0xrEX+yfA3xZia62+Ell9MWi+7
 bZtH4vjgCzkAAAA
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709106512; l=1267;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Sw1vuiHIqJXIfn+XmGtWdztCucWeY+9FVkPPCrCfMj0=;
 b=V1qKWboTGSaJu7yRwMsD3mWtkyYUns8L42y/Z8FZM3BvU6aX9RJVvBP+HSrktbWQ4HKy7H+nH
 Y/GY4iCQwLPA9tqELLGAhtlgU+xyDiTubZlLYyjrQerMGqwcfCqFzkZ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8e0e85-6950-4304-fff8-08dc38307eb2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2l5hU4UUj76HU1ZOkzODoAOt5m1qgieiJuV6Tb4xtIvPbx963jR4c1vFaK1wn6c306SE0RCZyy52I+fMoXKHwxFXu1cZDKwxMrt07cOVs2BsZqecG5SKZob7o+j2KhDgszjQ0BCduDV8BwkBSoCkrkVUxAiut6BVnBtTgTshhwaUFhtw9IuEfMhkdvadmqeZ5qHu7oFs401RnkjcKR4X8+BOff23BfiequDkCONUESWqv52gsvYT9KOkwYlRKWzofq9oqh4Urc/YdC8dsn17I+RToBpSjTaV8xdE/VvDTPPfmowBsq5Lz/2zA58O90o76v8MVua7/4apjFAxHtG+cuWVn4jBj2DlpmP5evnlI/6vb24mlCeA3aHXkZiaBRRJyd3YbFLQVaM3Z25GF0sWyfHYFbrb9icVaOWlzJsZO4P/Z6XIChw0u0i8p8nOhrsyFnov8dnh7PyOpPU1j4KZpjDCAkACFq2ab4dCYgxn+TvDT9HIZkAuRvBkoB9NCV1Q+ZSk697iwf9/HPY/MuLHWZ+vvgNpvgNEKXpY1Pk++6x+fFFz/2d8ZXPvau8VocSxOYgvEJkX4gfjv1fI/KhJfFIUHcF16Q2tssTvHCFR8UxKUSWSG3kYH98rP6/FpzrOR+56y+78MADpoFpRCC8TQJlw7cgXHMPLgcDNsRX0gVPlU55Bt3n+GGkTDdeN6f8LOFiHfQP17xsv0sbhu7D+/4QwBV9g1l9G4VgozpL7oZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEFNWVcyTmQ2bnUxNjdRWnZlb2JiY0xKakRlNm1rWnI0VkJNS3dVaE5HUjdQ?=
 =?utf-8?B?aWJ3UGd0dlNEdU1jc3laSDI4QlphcGppaHB2WVl6OStZaWEvclM3cHlnbFZB?=
 =?utf-8?B?aS9DVGtwZ2JqbWJ0aXBqY3czMEpJQ25oNVNZR291VmVmYUFLdGdLTmNvOThW?=
 =?utf-8?B?dHpyeCtSbWRVakxFbllhdXhqTUZwbUdlSXVoY1lSNHVOd3hRT0Rqa1RaZEhP?=
 =?utf-8?B?KzNyNXVnd2x2L0dEWlFWRGFkR2tEOW00L1pWdnBOUUc5NGVPZndPUHgvdzZV?=
 =?utf-8?B?WFMxTDY4a3FhNUVXMUVaN21zemplcHVkTWdLb2E5NjFPbEJubFkyejNuOVpz?=
 =?utf-8?B?YkllMkttRU5lMXgxcVBkb25LTFZvMVBsQ0lBbDBldXJFaXJYOHdJQ1J5emUx?=
 =?utf-8?B?eURGRzdSSnhrMnBkazZYQmtid0FCMUFOb0JuZWl5aHVodjF6WHgwV0U3WDFQ?=
 =?utf-8?B?VjkwdDErVERKWmtQUmdkN3locHBnRzR0bGczWmxVanI1ZkVlTWtwd3Y4VzRH?=
 =?utf-8?B?QVNDZHdySkIxclpzdEwxOTcwOEo2WU5rMjdhazNOVjlTQTNQODVjTStHV2w3?=
 =?utf-8?B?Q1NLaFVzdy81QTh5bWQrcFF5UHJYY214clZuSFl5TnlhYjcxR1p4cTNCMDQ3?=
 =?utf-8?B?T1ZMdEtKNUdmUHJxSjdnZ09jZ1F0SlNUbFQzM21rVkVmWFFmTWNhczhITk9B?=
 =?utf-8?B?YzJKQkFRWC82b1dRSU1rWjlvNWNFaVJPMGMxRE9FbGZiVW5zZk1CNUNOcjBh?=
 =?utf-8?B?SVRMUUVneGl2NHhpTVQ2cjRmdHZqQU9vcGZqbFB0VTU1alJ6V1FkQ21jY0tJ?=
 =?utf-8?B?Mk4ybUpRM2NaWGNyaWFqOFl4T1NuTmMyV0RyZjJlZk5CM3BxbG5xRWQwRk5q?=
 =?utf-8?B?em1ZcU85QURFdXdMMmxVeGFSNkZaNzZNUytvTFlIU2tQRkE3NTY2R3Y1VkJR?=
 =?utf-8?B?dExmWnIwNjJrTE5URXl1K0hZZEFoQ293QWxUaFJ5ejBnUDc4MGZwVWVYdmlu?=
 =?utf-8?B?eXNyZ0J2VEpuYk9HeHJMM3g3OE45MkhyU3VHdjZUVlJnbm1zVWhwN3VMeDFH?=
 =?utf-8?B?Yms2Z29UTTJGT0dYVUlxN0krSFd4Mlh2Nmh6UjdiUjNTTlJ5emFmNHcvc3Ja?=
 =?utf-8?B?cVBiZ0tISnpQczJVcUt3ZUE4M3lmSW1jMDN5dXFlcWpVZ1hicVpWcTB4U1Mz?=
 =?utf-8?B?amdqQ2tIRVVIRmVjUG5ONElhWDJnTjVoYnB0TlZXeWRCUS9KdFYxMytraGtt?=
 =?utf-8?B?TW5LbGdLQmV3NGJzNi9UTXlXWVRlVDB2dXhpL092MmVvdWtJNE9LUCsrOHJL?=
 =?utf-8?B?UkN5WWE0Nm9UdTFXcFlqWWVzczZJcGxmR0taZUxqR0tDdDc2RzAxeVpNS2VV?=
 =?utf-8?B?WUZQUDNBcGxCVjllOG1jVU83NXFtQ005RHZ1cjBINE1laDBXcmJjYnRYTmFj?=
 =?utf-8?B?KzFRMFRyalRvZjNhNjVJKytPaUhOTCtyd1Y2anJFYStPU0tJckd3WW1UdzJW?=
 =?utf-8?B?OFpiL1VHY3ROT0pIemdjMjBxcmJDUmVPNVozejZDK1ZBYzhzeHdqOU5zek5u?=
 =?utf-8?B?SkhOV1JwVlIvbkxqM0l4NkxDcjQ5ZitFOUgyNlUyM1hkYnRIMklJQ0NOZU5Y?=
 =?utf-8?B?anZFOUZjMmMzYUdCY1J2MnFjUStGOXMraCs3Y0ROdTc3cVNwbkNrOEtkVjJI?=
 =?utf-8?B?dnhxRDFLVzE5eUwyRmtPRkwvendRQnc3bm9zajhXV3daR2c1YmFJRzlyS1JK?=
 =?utf-8?B?akJJYTFkaWJlbm1tSm9aelhXNXNVeDNFZG9RR0tuaFY4dEpnYzh1K2JiWkpk?=
 =?utf-8?B?aUhqSnJtRmRITENBNk51eVNFVWFHOUZydmszek9zY1hIZzAzZS9ySmloa2Jh?=
 =?utf-8?B?MlgxSEhPRDQ3d2kvbVRBNzdmdjNvZnVMZG9BcDQ0MGVxWEFOYldQY0plSHMy?=
 =?utf-8?B?RzJ4eG1kRXFIMzVWcXI3RGJzQVduYTY5TkhUOWZXRXJsN3lyRStLdG1VZVd0?=
 =?utf-8?B?Nm5uS0h0cUpIaW9yeTBKWWNPZW5wajg2RG1vekR2OEZESHQyR09CZ1F1K2hN?=
 =?utf-8?B?T212OXVodk9aYksvUGNBcFB6TTR5WHAyOTVsZWE2UTBXOXZnZ2FuRU41TnNx?=
 =?utf-8?Q?Ha6YL4F00EZ5XPQJ8OEM5Fc8+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8e0e85-6950-4304-fff8-08dc38307eb2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:40:11.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwQoJXakM+fUdf6fRYIsmCK4FRRuerx+l0LH7GKYl7NpBVBLeyPhD0HZIPU2vPuM185BOH5/ydZ0Rea/I3n++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9015

i.MX95's several MIXes has BLK CTL module which could be used for
clk settings, QoS settings, Misc settings for a MIX. This patchset
is to add the clk feature support, including dt-bindings

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Correct example node compatible string
- Pass "make ARCH=arm64 DT_CHECKER_FLAGS=-m -j32 dt_binding_check"
- Link to v2: https://lore.kernel.org/r/20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com

Changes in v2:
- Correct example node compatible string
- Link to v1: https://lore.kernel.org/r/20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com

---
Peng Fan (2):
      dt-bindindgs: clock: support NXP i.MX95 BLK CTL module
      clk: imx: add i.MX95 BLK CTL clk driver

 .../devicetree/bindings/clock/imx95-blk-ctl.yaml   |  61 +++
 drivers/clk/imx/Kconfig                            |   7 +
 drivers/clk/imx/Makefile                           |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 438 +++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  32 ++
 5 files changed, 539 insertions(+)
---
base-commit: 22ba90670a51a18c6b36d285fddf92b9887c0bc3
change-id: 20240228-imx95-blk-ctl-9ef8c1fc4c22

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


