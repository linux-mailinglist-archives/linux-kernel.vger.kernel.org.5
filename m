Return-Path: <linux-kernel+bounces-164953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1738B855D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9916286593
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D94D599;
	Wed,  1 May 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EpDEf2fu"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062B4F883
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541580; cv=fail; b=TePoeitvt+5iNJZpzNn+SXL4IuiEc913FjtO9sFTmc+g6KAkTmSP7xQ/DiCCBfSlq604hkHrbbchgvNaCO3KeRUUQWm5Qqv1wDp8tMhO87xvGC0s+gFH1hRzj19TYnZ3Vxf8jxLluoawUYL5bHx6i6+4rb9MeH0O7wjc2WONHrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541580; c=relaxed/simple;
	bh=S605Ab6u6or+3JvE4foa1S8dRXvMfe9HsRyb6n9Iwd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hw1zhIAHvy+JsgjjXFB7ArdpCxQKhD8+Be/U5/tl4FMNxE1ZYKS3nApTenT0ZtWV1vVdLrvH6H9p0J5nzKbRwVn1NjEkFKE1Y1Comm5fNjUVwQGmgljlGaV94hskBhSAEgyC4IBl/p7qP8ijpOkZYSZ/U7xS0o3K5XPRSX3YoIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EpDEf2fu; arc=fail smtp.client-ip=40.107.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoG3pN4tiG9roCt9g3LRbn06xO2y9OQorPUDU00lUYHUzlk9g5aUNHDcnqlvU/JN9mfxZZBUEzu1t+Eaj5JTQJFyQx2nNMQVLY7aHsFfTtDjTPL2R00uyAOLP2yChoVckTD4DGfAkKG2yuYN5S0RdFWN53frc+fvp6MkvpH3v5vfQ1CU+J2AIBSUscZnSeTWIwTzJY5pgIQq3rGmDqywv8FoROAL7ZHifgoodNA0TlHyAMHqOM8qFVtlAe4KpgT6HVgEjMQfL2uWKbHQPYfdjvDrCCIEd3RZBoZNm1B8hDCeoz6cbpKyNWhGvfG+V8UZLKkzMhWr53Dstq/P8o+lWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V53U+Djg2gLCUFc8LEai1j506uzl4s2ODmchchaDJWo=;
 b=Mtn9auIRD50Vvm8gmC8/m5ew6G6eNJ+2D5pA8nDBxow+Ds1YO8vzLw0+/CfKbkVY/UTfBami+AfT8ds4XuXrqbx6WY1ngq4nFUC2C9ZubZTIdJR/eghSmKrpSRgIrrHfqNTlVVfnb9rj17HXntmb/dtfgJpqkxYXfQ4RbEFe6Q1Xnt1YGYCBTueOwldgr3Swei/xunGFIBT8Tx3lSbOExVQueYqzNqX+i61fIhOV8FjNIxsaEeKmbV6Jqt9zKwQqa7QphArOPxmtHJ0VVoNV0zsEZ3ZK9AHwKD/mMlfpGcOndfvTdsNqJAfo+h4vUCN1zOHgxWEJTpB3kPVmFsoPkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V53U+Djg2gLCUFc8LEai1j506uzl4s2ODmchchaDJWo=;
 b=EpDEf2fuq8R/pLoRH5KosMIXVoY7hYrKbWjt+Uek9xumPN2LlX5suURwxLpy8PXek7SuQH71WgHRA6ldkxFmvdHwju/60jXMvErOp/M5aDQyReT3RA0B7/enGEkkqOqBHpIn+zqgAnUAAH2piHXiTfA5NTFJz2nkxY/gfNOLMcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 05:32:47 +0000
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab]) by DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 05:32:47 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-imx@nxp.com,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: Silvano Di Ninno <silvano.dininno@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	frank.li@nxp.com,
	daniel.baluta@nxp.com,
	Vabhav Sharma <vabhav.sharma@nxp.com>,
	Franck LENORMAND <franck.lenormand@nxp.com>
Subject: [PATCH 3/4] soc: imx: secvio: Add support for SNVS secvio and tamper via SCFW
Date: Wed,  1 May 2024 07:32:04 +0200
Message-Id: <20240501053205.1737248-4-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
References: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::20) To DB9PR04MB9354.eurprd04.prod.outlook.com
 (2603:10a6:10:36c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9354:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fe66bf-635f-4607-3955-08dc69a0225a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jmB3uzjr6GELoQntj9q5mesZb1vwZvT6wp4aWdaHy0FabwtvDupyxP+MW0JD?=
 =?us-ascii?Q?HBDhUK4tSsEnfv/r8JHgvvwxvzEZMCRuR6NYLYMg3zheeHxAG6bCEqB7OenA?=
 =?us-ascii?Q?mDaLnN6azVE4reiVoBfnxMgaICL6tlQJzLIz1p9iylEP59p1VJCEKJ6r1D3A?=
 =?us-ascii?Q?mooW/+aN4rZ4jY7ZdvMwRfmNKFhrQEexBoYeXA76rq512f7o+cb+d997xIh+?=
 =?us-ascii?Q?ayyqcvgmjfPb02YH4TXFI755HLlWHqcspv+1NSBAnmvjqTzzYV/p23R3Curf?=
 =?us-ascii?Q?uXfV1FaybRevThwcGmJFhgWo1fq7gi84wOmZTjvhlM1GP5GHACXbHIpogAAq?=
 =?us-ascii?Q?+xK/t/AP6vWDtpCw0Gw2ObqT5H2Z2B7XBFmXq0e7ORaDbOhMTTAvDj3tM//R?=
 =?us-ascii?Q?hecAf7ly7hJUF9nAA49ZCJbDZEtFL0IsNRbaKv+UQaWwIuQhlCEHXv6p+vKl?=
 =?us-ascii?Q?OMX/Fv0X3qcHn0+75cMnxSWOq8ZF8AjTnFPseC8ZVLjsRgjzpm02ptlkfIKs?=
 =?us-ascii?Q?4ljHsNZ87TfRqX4mMsM84HiISgXQzJ7RD1nMQg5arR4N1wdh35OOaLuCrv8M?=
 =?us-ascii?Q?vjtusipa7WU2R1SxtRdoQ7A9LqtW/zB16T2I9e20TU/G8O79Wnd633gDjFJ+?=
 =?us-ascii?Q?NBuM+u4Sm43id9Jzq9JpMIIKeDYIapToESMeXfVGVD+F0/HmvloNKaeIgzM6?=
 =?us-ascii?Q?F1Z427hshBJap9AjCZSojB/6jKcBSn0R6zTi2+mZdDj4WZjZkHqiX2nujf8J?=
 =?us-ascii?Q?d+vSMMPHypwMgzx/fY/Bc/P8ckJ6qcxORuCwdSK/q3xKug7kfH9tHr5Rd0I3?=
 =?us-ascii?Q?yIFXR7ijUxKEktDjesmpu1IkZ+jW+MTNwQVT9UW8FMHKB01ehGRTZvBBZ8Vp?=
 =?us-ascii?Q?p79ScisG0Q+mvVLAh4fop8geHhvShf8rUOsOG+GHU51Lbh49TuO+luK42GOC?=
 =?us-ascii?Q?uk0+tIpOX/cqZSY/s+CgRnVbwrSdcJn3EN9c744qEItWH+Q724JBg3czYw3p?=
 =?us-ascii?Q?SeVb1OilJ0ku5xlTUHDP2u4pxOfFd5C2gm+rjQDynmh1KTp2l9NpYPpUICj3?=
 =?us-ascii?Q?bCvwCu5SEDALAOMGqfkdlVdRjfGFxwkuk0wr/FcRDNHw22MUbBeqhyNjnS7Y?=
 =?us-ascii?Q?wPcdtyUNvQFZYPDvHaqSAGGLQv3LJNtHZAzr+mIDvDv0fwCIRZGfjtPhTyPZ?=
 =?us-ascii?Q?08wwObHPnM6BTwwH0cowSkNIHHdJ4WVS5S8p3X3+iNlkO/i+s7/S6Lptk/NI?=
 =?us-ascii?Q?8iwjw3LnPo2nXg01ZYaAbqtvfWWMqi4+4ZdPlQHK6eXUxCzMoFbnA2NKWiea?=
 =?us-ascii?Q?n+a9IXcdXj5yrPPG83UYK9+C6jZMspB52f6LPq0J72bAo8NMKnnicZJFc4Kl?=
 =?us-ascii?Q?LILNfbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9354.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kkdi2FkiEL6/W6DoPMawmbBcpj9K8ZzaLRGw5T8Ykd4BaEy4BWu2aI4bje2Y?=
 =?us-ascii?Q?9P8Q3QZJzsiQmUJmBmyLK4xWgIEPqUNt7ACFQ6q80a+mna9idWfOwez1PHSZ?=
 =?us-ascii?Q?uw8g93p39cXEGOjmGMhRmOyfL35zWpj4d5Pd07E/Zd1DSBDqVwF+y7jOs+la?=
 =?us-ascii?Q?rIh+QkkSFk79c4UrVgow3pSV4BF/CEI8kCcWnhTaTBrqGLlXwF1x2zn23I/9?=
 =?us-ascii?Q?TKHO3bi1kAbnHRZMn2smxYciW3OO6Jm+tDEuqDjlz865X36dgl++C4E3ebxP?=
 =?us-ascii?Q?DcOqISJS38DaKiuZrn46ShQ5PtVxTN8Xb3g9Buf2d+eL+AeLvqXuvWVTspnd?=
 =?us-ascii?Q?WVihh+P2R49aOZAzBcR7ibdEFpN3QAzAm9NyAZQXj8C8F1dC7pnADNvvM8Di?=
 =?us-ascii?Q?geuk9Tr7fX5EuLKeRf9SlCo3fX9wIHoyiO7t90+pQb5p9ssSFN1ngT/5n22e?=
 =?us-ascii?Q?tCD0KpHgi5yMmDquiJao5hbUifedt+JuAMRNT7FZU3zIg7YS92ovIVA3arpD?=
 =?us-ascii?Q?EEBiGadaXrQ2wRSp8DYhi0PVRy1nag7SaLvFPoPgDCCLZQH/JcXxIwlVCipS?=
 =?us-ascii?Q?geh8cAtI7hcpYEb+WC1gztUrrMCLt70aG+rdZoFpgOHGShY4ak7+U2rNHL4U?=
 =?us-ascii?Q?w4XBl7IgKCiLUOUOQ/+AzP6N9EJ9AgcWR+LI2AiOVf1WL8ZYV/My9WbIgGNv?=
 =?us-ascii?Q?6Nqc6uxGCzQNIdn15Ea+2QZA/+qk27hhNz4DKkxD9MFBnzB6hu/Nu67KjbM6?=
 =?us-ascii?Q?8vmAaRU7uqvheBoFfnoCTy9vO0E1gz3VYrBODbEwzSkxhsbJrtIxiewGreC8?=
 =?us-ascii?Q?qElfJx4RU9BLd//38rfFKaQo+QwoinBmCZXhbTpJ62X8US2WOQ5E232ZJDaP?=
 =?us-ascii?Q?YuFVEXBByY09TrJuXtv/i7yJeOOSZGGADyKSVMDwnlePehs1huqxMnNzlSX1?=
 =?us-ascii?Q?DLzeGcHRxyi+ytUA+10Nn7cUsp7Vn9/cIa1SDgqrzjTBRSCwq/w6gliX8T1J?=
 =?us-ascii?Q?omoOivgZPrTcqNFC7OAhGv1Zxv+I8KeR4fQ4vsEE7Cxc/pHjXfs1KJf42Dym?=
 =?us-ascii?Q?K9JRpUACkWA5r6l8tnM6tH2gjijxYL3n2h1Sxbvc5l6Xp/yqILKw1CL0wPSI?=
 =?us-ascii?Q?/SCJvXRAkqR8K1rXZnFgEkxsbpvBOhrb8b7OskP/vYWVvS4P6zslP8kk1Nl1?=
 =?us-ascii?Q?kFc32CnTNOipdGkBSH292epLHe03O7c7afh0Ee/vqZjZX/0VM/R3i7BktEeh?=
 =?us-ascii?Q?UAjJlUuQUl+6hEaE8p8QS/ZViMFHKoklDx1+vb1nEDnlchOAWBGihdH5ZF8j?=
 =?us-ascii?Q?eZY4UOT7jZDGGcFl0N5ym/0uCDPWXvSz/Bl8ZOhV+Upm27gBWIAsj94CYboY?=
 =?us-ascii?Q?NAHtE+ReEIroJepgIixyOwUV+gtAkShT1blZkG9GmYokBg6Oti+Lv3Gsw2fg?=
 =?us-ascii?Q?0/QBL9LKOafqHsBng7U0qBXs10K/zbjWG3aL8+5JRXPsccnscSh1g3s9ezNj?=
 =?us-ascii?Q?p62PMt0cXaK6ly6/0W+7kb0iNk2dKKEA11x1KW0jFXnthc9VTaJ8TQOhJHfN?=
 =?us-ascii?Q?OnyDiEr/s7ruhI6oEgeWVZUNbn4XxuXiM54K0KBh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fe66bf-635f-4607-3955-08dc69a0225a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 05:32:47.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Q1B/Ci26xVugJvH7xPmczRVLAEYfdlqbnzMtgyotNNlv39qNchy3OkuA0NiLTstM/OmkoH7B2RR4WqFXwusZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

The driver register an IRQ handle to SCU for security
violation interrupt.

When an interruption is fired, the driver inform the user.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/soc/imx/Kconfig                     |  11 +
 drivers/soc/imx/Makefile                    |   1 +
 drivers/soc/imx/secvio/Makefile             |   2 +
 drivers/soc/imx/secvio/imx-secvio-debugfs.c | 283 ++++++++++
 drivers/soc/imx/secvio/imx-secvio-sc.c      | 595 ++++++++++++++++++++
 include/soc/imx/imx-secvio-sc.h             | 216 +++++++
 6 files changed, 1108 insertions(+)
 create mode 100644 drivers/soc/imx/secvio/Makefile
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-debugfs.c
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc.c
 create mode 100644 include/soc/imx/imx-secvio-sc.h

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 2a90ddd20104..3d2715a8b798 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -20,4 +20,15 @@ config SOC_IMX9
 	help
 	  If you say yes here, you get support for the NXP i.MX9 family
 
+config SECVIO_SC
+	tristate "NXP SC secvio support"
+	depends on IMX_SCU
+	default y
+	help
+	   If you say yes here you get support for the NXP SNVS security
+	   violation module. It includes the possibility to read information
+	   related to security violations and tampers. It also gives the
+	   possibility to register user callbacks when a security violation
+	   occurs.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 3ad321ca608a..bda0259077be 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX9) += imx93-src.o
+obj-${CONFIG_SECVIO_SC} += secvio/
diff --git a/drivers/soc/imx/secvio/Makefile b/drivers/soc/imx/secvio/Makefile
new file mode 100644
index 000000000000..55ef1c044009
--- /dev/null
+++ b/drivers/soc/imx/secvio/Makefile
@@ -0,0 +1,2 @@
+obj-y +=  imx-secvio-sc.o
+obj-$(CONFIG_DEBUG_FS) += imx-secvio-debugfs.o
diff --git a/drivers/soc/imx/secvio/imx-secvio-debugfs.c b/drivers/soc/imx/secvio/imx-secvio-debugfs.c
new file mode 100644
index 000000000000..6f0af138ee29
--- /dev/null
+++ b/drivers/soc/imx/secvio/imx-secvio-debugfs.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019, 2024 NXP
+ */
+
+/*
+ * The module exposes 3 files in debugfs:
+ *  - secvio/info:
+ *      * Read: It returns the value of the fuses and SNVS registers which are
+ *              readable and related to secvio and tampers
+ *      * Write: A write of the format "<hex id> [<hex value 0> <hex value 1>
+ *               <hex value 2> <hex value 3> <hex value 4>](<nb values>)"
+ *               will write the SNVS register having the provided id with the
+ *               values provided (cf SECO ducumentation)
+ *  - secvio/enable: State of the IRQ
+ *  - secvio/check: Check the state of the security violation and tampers
+ *                  and calls notifier
+ *  - secvio/clear: Clear the state of all secvio and tampers
+ */
+
+/* Includes */
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+#include <linux/nvmem-consumer.h>
+
+#include <linux/firmware/imx/svc/misc.h>
+#include <linux/firmware/imx/svc/seco.h>
+
+#include <soc/imx/imx-secvio-sc.h>
+
+static int fuse_reader(struct device *dev, u32 id, u32 *value, u8 mul)
+{
+	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
+	u32 size_to_read = mul * sizeof(u32);
+	int ret;
+
+	ret = nvmem_device_read(data->nvmem, id, size_to_read, value);
+	if (ret < 0) {
+		dev_err(data->dev, "Failed to read fuse %d: %d\n", id, ret);
+		return ret;
+	}
+
+	if (ret != size_to_read) {
+		dev_err(data->dev, "Read only %d instead of %d\n", ret,
+			size_to_read);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int snvs_reader(struct device *dev, u32 id, u32 *value, u8 mul)
+{
+	int ret;
+	u32 *v1, *v2, *v3, *v4, *v5;
+	struct imx_secvio_sc_data *data;
+
+	data = dev_get_drvdata(dev);
+	v1 = NULL;
+	v2 = NULL;
+	v3 = NULL;
+	v4 = NULL;
+	v5 = NULL;
+
+	switch (mul) {
+	case 5:
+		v5 = &value[4];
+		fallthrough;
+	case 4:
+		v4 = &value[3];
+		fallthrough;
+	case 3:
+		v3 = &value[2];
+		fallthrough;
+	case 2:
+		v2 = &value[1];
+		fallthrough;
+	case 1:
+		v1 = &value[0];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, id, SECVIO_CONFIG_READ,
+					v1, v2, v3, v4, v5, mul);
+	if (ret < 0)
+		dev_err(dev, "Failed to read snvs reg %d: %d\n", id, ret);
+
+	return ret;
+}
+
+static int snvs_dgo_reader(struct device *dev, u32 id, u32 *value, u8 mul)
+{
+	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	if (mul != 1)
+		return -EINVAL;
+
+	ret = imx_sc_seco_secvio_dgo_config(data->ipc_handle, id,
+					    SECVIO_CONFIG_READ, value);
+	if (ret)
+		dev_err(dev, "Failed to read snvs dgo reg %d: %d\n", id, ret);
+
+	return ret;
+}
+
+static const struct imx_secvio_info_entry {
+	int (*reader)(struct device *dev, u32 id, u32 *value, u8 mul);
+	const char *type;
+	const char *name;
+	u32 id;
+	u8 mul;
+} gs_imx_secvio_info_list[] = {
+	{fuse_reader, "fuse", "trim", 30, 1},
+	{fuse_reader, "fuse", "trim2", 31, 1},
+	{fuse_reader, "fuse", "ctrim1", 260, 1},
+	{fuse_reader, "fuse", "ctrim2", 261, 1},
+	{fuse_reader, "fuse", "ctrim3", 262, 1},
+	{fuse_reader, "fuse", "ctrim4", 263, 1},
+	{fuse_reader, "fuse", "OSC_CAP", 768, 1},
+
+	{snvs_reader, "snvs", "HPLR",    0x0, 1},
+	{snvs_reader, "snvs", "LPLR",    0x34, 1},
+	{snvs_reader, "snvs", "HPSICR",  0xc, 1},
+	{snvs_reader, "snvs", "HPSVCR",  0x10, 1},
+	{snvs_reader, "snvs", "HPSVS",   0x18, 1},
+	{snvs_reader, "snvs", "LPSVC",   0x40, 1},
+	{snvs_reader, "snvs", "LPTDC",   0x48, 2},
+	{snvs_reader, "snvs", "LPSR",    0x4c, 1},
+	{snvs_reader, "snvs", "LPTDS",   0xa4, 1},
+	{snvs_reader, "snvs", "LPTGFC",  0x44, 3},
+	{snvs_reader, "snvs", "LPATCTL", 0xe0, 1},
+	{snvs_reader, "snvs", "LPATCLK", 0xe4, 1},
+	{snvs_reader, "snvs", "LPATRC1", 0xe8, 2},
+	{snvs_reader, "snvs", "LPMKC",   0x3c, 1},
+	{snvs_reader, "snvs", "LPSMC",   0x5c, 2},
+	{snvs_reader, "snvs", "LPPGD",   0x64, 1},
+	{snvs_reader, "snvs", "HPVID",   0xf8, 2},
+
+	{snvs_dgo_reader, "dgo", "Offset",  0x0, 1},
+	{snvs_dgo_reader, "dgo", "PUP/PD",  0x10, 1},
+	{snvs_dgo_reader, "dgo", "Anatest", 0x20, 1},
+	{snvs_dgo_reader, "dgo", "T trim",  0x30, 1},
+	{snvs_dgo_reader, "dgo", "Misc",    0x40, 1},
+	{snvs_dgo_reader, "dgo", "Vmon",    0x50, 1},
+};
+
+struct imx_secvio_sc_info_seq_data {
+	struct device *dev;
+	const struct imx_secvio_info_entry *list;
+	int size;
+};
+
+static void *imx_secvio_sc_info_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct imx_secvio_sc_info_seq_data *data = m->private;
+
+	/* Check we are not out of bound */
+	if (*pos >= data->size)
+		return NULL;
+
+	return (void *)pos;
+}
+
+static void *imx_secvio_sc_info_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	/* Increment the counter */
+	++*pos;
+
+	/* call the start function which will check the index */
+	return imx_secvio_sc_info_seq_start(m, pos);
+}
+
+static void imx_secvio_sc_info_seq_stop(struct seq_file *m, void *v)
+{
+}
+
+static int imx_secvio_sc_info_seq_show(struct seq_file *m, void *v)
+{
+	struct imx_secvio_sc_info_seq_data *data = m->private;
+	const struct imx_secvio_info_entry *e;
+	int ret;
+	u32 vals[5];
+	int idx;
+
+	idx = *(loff_t *)v;
+	e = &data->list[idx];
+
+	/* Read the values */
+	ret = e->reader(data->dev, e->id, (u32 *)&vals, e->mul);
+	if (ret) {
+		dev_err(data->dev, "Fail to read %s %s (idx %d)\n", e->type,
+			e->name, e->id);
+		return 0;
+	}
+
+	seq_printf(m, "%5s/%-10s(%.3d):", e->type, e->name, e->id);
+
+	/* Loop over the values */
+	for (idx = 0; idx < e->mul; idx++)
+		seq_printf(m, " %.8x", vals[idx]);
+
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
+static const struct seq_operations imx_secvio_sc_info_seq_ops = {
+	.start = imx_secvio_sc_info_seq_start,
+	.next  = imx_secvio_sc_info_seq_next,
+	.stop  = imx_secvio_sc_info_seq_stop,
+	.show  = imx_secvio_sc_info_seq_show,
+};
+
+static int imx_secvio_sc_info_open(struct inode *inode, struct file *file)
+{
+	struct imx_secvio_sc_info_seq_data *data;
+
+	data = __seq_open_private(file, &imx_secvio_sc_info_seq_ops, sizeof(*data));
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = inode->i_private;
+	data->list = gs_imx_secvio_info_list;
+	data->size = ARRAY_SIZE(gs_imx_secvio_info_list);
+
+	return 0;
+}
+
+static const struct file_operations imx_secvio_sc_info_ops = {
+	.owner = THIS_MODULE,
+	.open = imx_secvio_sc_info_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release_private,
+};
+
+static void if_debugfs_remove_recursive(void *dentry)
+{
+	debugfs_remove_recursive(dentry);
+}
+
+int imx_secvio_sc_debugfs(struct device *dev)
+{
+	struct imx_secvio_sc_data *data = dev_get_drvdata(dev);
+	struct dentry *dir;
+	int ret = 0;
+
+	/* Create a folder */
+	dir = debugfs_create_dir(dev_name(dev), NULL);
+	if (IS_ERR(dir)) {
+		dev_err(dev, "Failed to create dfs dir\n");
+		ret = PTR_ERR(dir);
+		goto exit;
+	}
+	data->dfs = dir;
+
+	ret = devm_add_action(dev, if_debugfs_remove_recursive, data->dfs);
+	if (ret) {
+		dev_err(dev, "Failed to add managed action to disable IRQ\n");
+		goto remove_fs;
+	}
+
+	/* Create the file to read info and write to reg */
+	dir = debugfs_create_file("info", 0x666, data->dfs, dev,
+				  &imx_secvio_sc_info_ops);
+	if (IS_ERR(dir)) {
+		dev_err(dev, "Failed to add info to debugfs\n");
+		ret = PTR_ERR(dir);
+		goto exit;
+	}
+
+exit:
+	return ret;
+
+remove_fs:
+	debugfs_remove_recursive(data->dfs);
+	goto exit;
+}
diff --git a/drivers/soc/imx/secvio/imx-secvio-sc.c b/drivers/soc/imx/secvio/imx-secvio-sc.c
new file mode 100644
index 000000000000..a4e96c730a23
--- /dev/null
+++ b/drivers/soc/imx/secvio/imx-secvio-sc.c
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019, 2024 NXP
+ *
+ */
+
+/*
+ * The i.MX8QXP SoC contains the Secure Non-Volatile Storage (SNVS) block. This
+ * block can detect specific hardware attacks.This block can only be accessible
+ * using the SCFW API.
+ *
+ * This module interact with the SCU which relay request to/from the SNVS block
+ * to detect if security violation occurred.
+ *
+ * The module exports an API to add processing when a SV is detected:
+ *  - register_imx_secvio_sc_notifier
+ *  - unregister_imx_secvio_sc_notifier
+ *  - imx_secvio_sc_check_state
+ *  - imx_secvio_sc_clear_state
+ *  - imx_secvio_sc_enable_irq
+ *  - imx_secvio_sc_disable_irq
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/firmware/imx/svc/seco.h>
+#include <linux/firmware/imx/svc/rm.h>
+#include <soc/imx/imx-secvio-sc.h>
+
+/* Reference on the driver_device */
+static struct device *imx_secvio_sc_dev;
+
+/* Register IDs for sc_seco_secvio_config API */
+#define HPSVS_ID 0x18
+#define LPS_ID 0x4c
+#define LPTDS_ID 0xa4
+#define HPVIDR_ID 0xf8
+
+#define SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER 0x53
+#define SECO_VERSION_MINOR_MASK GENMASK(15, 0)
+
+/* Notifier list for new CB */
+static BLOCKING_NOTIFIER_HEAD(imx_secvio_sc_notifier_chain);
+
+int register_imx_secvio_sc_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&imx_secvio_sc_notifier_chain,
+						nb);
+}
+EXPORT_SYMBOL(register_imx_secvio_sc_notifier);
+
+int unregister_imx_secvio_sc_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&imx_secvio_sc_notifier_chain,
+						  nb);
+}
+EXPORT_SYMBOL(unregister_imx_secvio_sc_notifier);
+
+static void if_imx_scu_irq_register_notifier(void *nb)
+{
+	imx_scu_irq_register_notifier(nb);
+}
+
+static void if_unregister_imx_secvio_sc_notifier(void *nb)
+{
+	unregister_imx_secvio_sc_notifier(nb);
+}
+
+static
+int imx_secvio_sc_notifier_call_chain(struct secvio_sc_notifier_info *info)
+{
+	return blocking_notifier_call_chain(&imx_secvio_sc_notifier_chain, 0,
+					    (void *)info);
+}
+
+int imx_secvio_sc_get_state(struct device *dev,
+			    struct secvio_sc_notifier_info *info)
+{
+	int ret, err = 0;
+	struct imx_secvio_sc_data *data;
+
+	dev = imx_secvio_sc_dev;
+	if (!dev)
+		return -EINVAL;
+
+	data = dev_get_drvdata(dev);
+
+	/* Read secvio status */
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, HPSVS_ID, SECVIO_CONFIG_READ,
+					&info->hpsvs, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		err = ret;
+		dev_err(dev, "Fail read secvio config status %d\n", ret);
+	}
+	info->hpsvs &= HPSVS_ALL_SV_MASK;
+
+	/* Read tampers status */
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPS_ID, SECVIO_CONFIG_READ,
+					&info->lps, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		err = ret;
+		dev_err(dev, "Fail read tamper 1 status: %d\n", ret);
+	}
+	info->lps &= LPS_ALL_TP_MASK;
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPTDS_ID, SECVIO_CONFIG_READ,
+					&info->lptds, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		err = ret;
+		dev_err(dev, "Fail read  tamper 2 status: %d\n", ret);
+	}
+	info->lptds &= LPTDS_ALL_TP_MASK;
+
+	dev_dbg(dev, "Status: %.8x, %.8x, %.8x\n", info->hpsvs,
+		info->lps, info->lptds);
+
+	return err;
+}
+EXPORT_SYMBOL(imx_secvio_sc_get_state);
+
+int imx_secvio_sc_check_state(struct device *dev)
+{
+	struct secvio_sc_notifier_info info;
+	int ret;
+
+	dev = imx_secvio_sc_dev;
+
+	ret = imx_secvio_sc_get_state(dev, &info);
+	if (ret) {
+		dev_err(dev, "Failed to get secvio state\n");
+		return ret;
+	}
+
+	/* Call chain of CB registered to this module if status detected */
+	if (info.hpsvs || info.lps || info.lptds)
+		if (imx_secvio_sc_notifier_call_chain(&info))
+			dev_warn(dev,
+				 "Issues when calling the notifier chain\n");
+
+	return ret;
+}
+EXPORT_SYMBOL(imx_secvio_sc_check_state);
+
+static int imx_secvio_sc_disable_irq(struct device *dev)
+{
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	/* Disable the IRQ */
+	ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECVIO,
+				       false);
+	if (ret) {
+		dev_err(dev, "Cannot disable SCU IRQ: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int imx_secvio_sc_enable_irq(struct device *dev)
+{
+	int ret = 0, err;
+	u32 irq_status;
+	struct imx_secvio_sc_data *data;
+
+	if (!dev)
+		return -EINVAL;
+
+	data = dev_get_drvdata(dev);
+
+	/* Enable the IRQ */
+	ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECVIO,
+				       true);
+	if (ret) {
+		dev_err(dev, "Cannot enable SCU IRQ: %d\n", ret);
+		goto exit;
+	}
+
+	/* Enable interrupt */
+	ret = imx_sc_seco_secvio_enable(data->ipc_handle);
+	if (ret) {
+		dev_err(dev, "Cannot enable SNVS irq: %d\n", ret);
+		goto exit;
+	}
+
+	/* Unmask interrupt */
+	ret = imx_scu_irq_get_status(IMX_SC_IRQ_GROUP_WAKE, &irq_status);
+	if (ret) {
+		dev_err(dev, "Cannot unmask irq: %d\n", ret);
+		goto exit;
+	}
+
+exit:
+	if (ret) {
+		err = imx_secvio_sc_disable_irq(dev);
+		if (err)
+			dev_warn(dev, "Failed to disable the IRQ\n");
+	}
+
+	return ret;
+}
+
+static int imx_secvio_sc_notify(struct notifier_block *nb,
+				unsigned long event, void *group)
+{
+	struct imx_secvio_sc_data *data =
+				container_of(nb, struct imx_secvio_sc_data,
+					     irq_nb);
+	struct device *dev = data->dev;
+	int ret;
+
+	/* Filter event for us */
+	if (!((event & IMX_SC_IRQ_SECVIO) &&
+	      (*(u8 *)group == IMX_SC_IRQ_GROUP_WAKE)))
+		return 0;
+
+	dev_warn(dev, "secvio security violation detected\n");
+
+	ret = imx_secvio_sc_check_state(dev);
+
+	/* Re-enable interrupt */
+	ret = imx_secvio_sc_enable_irq(dev);
+	if (ret)
+		dev_err(dev, "Failed to enable IRQ\n");
+
+	return ret;
+}
+
+int imx_secvio_sc_clear_state(struct device *dev, u32 hpsvs, u32 lps, u32 lptds)
+{
+	int ret;
+	struct imx_secvio_sc_data *data;
+
+	dev = imx_secvio_sc_dev;
+	if (!dev)
+		return -EINVAL;
+
+	data = dev_get_drvdata(dev);
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, HPSVS_ID, SECVIO_CONFIG_WRITE,
+					&hpsvs, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		dev_err(dev, "Fail to clear secvio status: %d\n", ret);
+		return ret;
+	}
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPS_ID, SECVIO_CONFIG_WRITE,
+					&lps, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		dev_err(dev, "Fail to clear tamper 1 status: %d\n", ret);
+		return ret;
+	}
+
+	ret = imx_sc_seco_secvio_config(data->ipc_handle, LPTDS_ID, SECVIO_CONFIG_WRITE,
+					&lptds, NULL, NULL, NULL, NULL, 1);
+	if (ret) {
+		dev_err(dev, "Fail to clear tamper 2 status: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(imx_secvio_sc_clear_state);
+
+static int report_to_user_notify(struct notifier_block *nb,
+				 unsigned long status, void *notif_info)
+{
+	struct secvio_sc_notifier_info *info = notif_info;
+	struct imx_secvio_sc_data *data =
+				container_of(nb, struct imx_secvio_sc_data,
+					     report_nb);
+	struct device *dev = data->dev;
+
+	/* Information about the security violation */
+	if (info->hpsvs & HPSVS_LP_SEC_VIO_MASK)
+		dev_info(dev, "SNVS secvio: LPSV\n");
+	if (info->hpsvs & HPSVS_SW_LPSV_MASK)
+		dev_info(dev, "SNVS secvio: SW LPSV\n");
+	if (info->hpsvs & HPSVS_SW_FSV_MASK)
+		dev_info(dev, "SNVS secvio: SW FSV\n");
+	if (info->hpsvs & HPSVS_SW_SV_MASK)
+		dev_info(dev, "SNVS secvio: SW SV\n");
+	if (info->hpsvs & HPSVS_SV5_MASK)
+		dev_info(dev, "SNVS secvio: SV 5\n");
+	if (info->hpsvs & HPSVS_SV4_MASK)
+		dev_info(dev, "SNVS secvio: SV 4\n");
+	if (info->hpsvs & HPSVS_SV3_MASK)
+		dev_info(dev, "SNVS secvio: SV 3\n");
+	if (info->hpsvs & HPSVS_SV2_MASK)
+		dev_info(dev, "SNVS secvio: SV 2\n");
+	if (info->hpsvs & HPSVS_SV1_MASK)
+		dev_info(dev, "SNVS secvio: SV 1\n");
+	if (info->hpsvs & HPSVS_SV0_MASK)
+		dev_info(dev, "SNVS secvio: SV 0\n");
+
+	/* Information about the tampers */
+	if (info->lps & LPS_ESVD_MASK)
+		dev_info(dev, "SNVS tamper: External SV\n");
+	if (info->lps & LPS_ET2D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 2\n");
+	if (info->lps & LPS_ET1D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 1\n");
+	if (info->lps & LPS_WMT2D_MASK)
+		dev_info(dev, "SNVS tamper: Wire Mesh 2\n");
+	if (info->lps & LPS_WMT1D_MASK)
+		dev_info(dev, "SNVS tamper: Wire Mesh 1\n");
+	if (info->lps & LPS_VTD_MASK)
+		dev_info(dev, "SNVS tamper: Voltage\n");
+	if (info->lps & LPS_TTD_MASK)
+		dev_info(dev, "SNVS tamper: Temperature\n");
+	if (info->lps & LPS_CTD_MASK)
+		dev_info(dev, "SNVS tamper: Clock\n");
+	if (info->lps & LPS_PGD_MASK)
+		dev_info(dev, "SNVS tamper: Power Glitch\n");
+	if (info->lps & LPS_MCR_MASK)
+		dev_info(dev, "SNVS tamper: Monotonic Counter rollover\n");
+	if (info->lps & LPS_SRTCR_MASK)
+		dev_info(dev, "SNVS tamper: Secure RTC rollover\n");
+	if (info->lps & LPS_LPTA_MASK)
+		dev_info(dev, "SNVS tamper: Time alarm\n");
+
+	if (info->lptds & LPTDS_ET10D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 10\n");
+	if (info->lptds & LPTDS_ET9D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 9\n");
+	if (info->lptds & LPTDS_ET8D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 8\n");
+	if (info->lptds & LPTDS_ET7D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 7\n");
+	if (info->lptds & LPTDS_ET6D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 6\n");
+	if (info->lptds & LPTDS_ET5D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 5\n");
+	if (info->lptds & LPTDS_ET4D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 4\n");
+	if (info->lptds & LPTDS_ET3D_MASK)
+		dev_info(dev, "SNVS tamper: Tamper 3\n");
+
+	return 0;
+}
+
+static void if_imx_secvio_sc_disable_irq(void *dev)
+{
+	imx_secvio_sc_disable_irq(dev);
+}
+
+static int imx_secvio_sc_open(struct inode *node, struct file *filp)
+{
+	filp->private_data = node->i_private;
+
+	return 0;
+}
+
+static long imx_secvio_sc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct device *dev = file->private_data;
+	struct secvio_sc_notifier_info info;
+	int ret;
+
+	switch (cmd) {
+	case IMX_SECVIO_SC_GET_STATE:
+		ret = imx_secvio_sc_get_state(dev, &info);
+		if (ret)
+			return ret;
+
+		ret = copy_to_user((void *)arg, &info, sizeof(info));
+		if (ret) {
+			dev_err(dev, "Fail to copy info to user\n");
+			return -EFAULT;
+		}
+		break;
+	case IMX_SECVIO_SC_CHECK_STATE:
+		ret = imx_secvio_sc_check_state(dev);
+		if (ret)
+			return ret;
+		break;
+	case IMX_SECVIO_SC_CLEAR_STATE:
+		ret = copy_from_user(&info, (void *)arg, sizeof(info));
+		if (ret) {
+			dev_err(dev, "Fail to copy info from user\n");
+			return -EFAULT;
+		}
+
+		ret = imx_secvio_sc_clear_state(dev, info.hpsvs, info.lps,
+						    info.lptds);
+		if (ret)
+			return ret;
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+	}
+
+	return ret;
+}
+
+static const struct file_operations imx_secvio_sc_fops = {
+	.owner = THIS_MODULE,
+	.open = imx_secvio_sc_open,
+	.unlocked_ioctl = imx_secvio_sc_ioctl,
+};
+
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
+static int imx_secvio_sc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_secvio_sc_data *data;
+	u32 seco_version = 0;
+	bool own_secvio;
+	u32 irq_status;
+	int ret;
+
+	/* Allocate private data */
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (!devres_open_group(dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
+	data->dev = dev;
+
+	dev_set_drvdata(dev, data);
+
+	data->nvmem = devm_nvmem_device_get(dev, NULL);
+	if (IS_ERR(data->nvmem)) {
+		ret = PTR_ERR(data->nvmem);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err_probe(dev, ret, "Failed to retrieve nvmem\n");
+
+		goto clean;
+	}
+
+	/* Get a handle */
+	ret = imx_scu_get_handle(&data->ipc_handle);
+	if (ret) {
+		dev_err(dev, "cannot get handle to scu: %d\n", ret);
+		goto clean;
+	}
+
+	/* Check the version of the SECO */
+	ret = imx_sc_seco_build_info(data->ipc_handle, &seco_version, NULL);
+	if (ret) {
+		dev_err(dev, "Failed to get seco version\n");
+		goto clean;
+	}
+
+	if ((seco_version & SECO_VERSION_MINOR_MASK) <
+	     SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER) {
+		dev_err(dev, "SECO version %.8x doesn't support all secvio\n",
+			seco_version);
+		ret = -EOPNOTSUPP;
+		goto clean;
+	}
+
+	/* Init debug FS */
+	ret = imx_secvio_sc_debugfs(dev);
+	if (ret) {
+		dev_err(dev, "Failed to set debugfs\n");
+		goto clean;
+	}
+
+	/* Check we own the SECVIO */
+	ret = imx_sc_rm_is_resource_owned(data->ipc_handle, IMX_SC_R_SECVIO);
+	if (ret < 0) {
+		dev_err(dev, "Failed to retrieve secvio ownership\n");
+		goto clean;
+	}
+
+	own_secvio = ret > 0;
+	if (!own_secvio) {
+		dev_err(dev, "Secvio resource is not owned\n");
+		ret = -EPERM;
+		goto clean;
+	}
+
+	/* Check IRQ exists and enable it */
+	ret = imx_scu_irq_get_status(IMX_SC_IRQ_GROUP_WAKE, &irq_status);
+	if (ret) {
+		dev_err(dev, "Cannot get IRQ state: %d\n", ret);
+		goto clean;
+	}
+
+	ret = imx_secvio_sc_enable_irq(dev);
+	if (ret) {
+		dev_err(dev, "Failed to enable IRQ\n");
+		goto clean;
+	}
+
+	ret = devm_add_action_or_reset(dev, if_imx_secvio_sc_disable_irq, dev);
+	if (ret) {
+		dev_err(dev, "Failed to add managed action to disable IRQ\n");
+		goto clean;
+	}
+
+	/* Register the notifier for IRQ from SNVS */
+	data->irq_nb.notifier_call = imx_secvio_sc_notify;
+	ret = imx_scu_irq_register_notifier(&data->irq_nb);
+	if (ret) {
+		dev_err(dev, "Failed to register IRQ notification handler\n");
+		goto clean;
+	}
+
+	ret = devm_add_action_or_reset(dev, if_imx_scu_irq_register_notifier,
+				       &data->irq_nb);
+	if (ret) {
+		dev_err(dev, "Failed to add action to remove irq notif\n");
+		goto clean;
+	}
+
+	/* Register the notification for reporting to user */
+	data->report_nb.notifier_call = report_to_user_notify;
+	ret = register_imx_secvio_sc_notifier(&data->report_nb);
+	if (ret) {
+		dev_err(dev, "Failed to register report notif handler\n");
+		goto clean;
+	}
+
+	ret = devm_add_action_or_reset(dev, if_unregister_imx_secvio_sc_notifier,
+				       &data->report_nb);
+	if (ret) {
+		dev_err(dev, "Failed to add action to remove report notif\n");
+		goto clean;
+	}
+
+	/* Register misc device for IOCTL */
+	data->miscdev.name = devm_kstrdup(dev, "secvio-sc", GFP_KERNEL);
+	data->miscdev.minor = MISC_DYNAMIC_MINOR;
+	data->miscdev.fops = &imx_secvio_sc_fops;
+	data->miscdev.parent = dev;
+	ret = misc_register(&data->miscdev);
+	if (ret) {
+		dev_err(dev, "failed to register misc device\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, if_misc_deregister, &data->miscdev);
+	if (ret) {
+		dev_err(dev, "Failed to add action to unregister miscdev\n");
+		goto clean;
+	}
+
+	imx_secvio_sc_dev = dev;
+
+	/* Process current state of the secvio and tampers */
+	imx_secvio_sc_check_state(dev);
+
+	devres_remove_group(dev, NULL);
+
+	return ret;
+
+clean:
+	devres_release_group(dev, NULL);
+
+	return ret;
+}
+
+static const struct of_device_id imx_secvio_sc_dt_ids[] = {
+	{ .compatible = "fsl,imx-sc-secvio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_secvio_sc_dt_ids);
+
+static struct platform_driver imx_secvio_sc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name	= "imx-secvio-sc",
+		.of_match_table = imx_secvio_sc_dt_ids,
+	},
+	.probe		= imx_secvio_sc_probe,
+};
+module_platform_driver(imx_secvio_sc_driver);
+
+MODULE_AUTHOR("Franck LENORMAND <franck.lenormand@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX driver to handle SNVS secvio irq sent by SCFW");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/imx/imx-secvio-sc.h b/include/soc/imx/imx-secvio-sc.h
new file mode 100644
index 000000000000..d8c9208217fe
--- /dev/null
+++ b/include/soc/imx/imx-secvio-sc.h
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2019, 2024 NXP
+ */
+
+#ifndef _MISC_IMX_SECVIO_SC_H_
+#define _MISC_IMX_SECVIO_SC_H_
+
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/notifier.h>
+
+/* Bitmask of the security violation status bit in the HPSVS register */
+#define HPSVS_LP_SEC_VIO_MASK BIT(31)
+#define HPSVS_SW_LPSV_MASK    BIT(15)
+#define HPSVS_SW_FSV_MASK     BIT(14)
+#define HPSVS_SW_SV_MASK      BIT(13)
+#define HPSVS_SV5_MASK        BIT(5)
+#define HPSVS_SV4_MASK        BIT(4)
+#define HPSVS_SV3_MASK        BIT(3)
+#define HPSVS_SV2_MASK        BIT(2)
+#define HPSVS_SV1_MASK        BIT(1)
+#define HPSVS_SV0_MASK        BIT(0)
+
+/* Bitmask of all security violation status bit in the HPSVS register */
+#define HPSVS_ALL_SV_MASK (HPSVS_LP_SEC_VIO_MASK | \
+			     HPSVS_SW_LPSV_MASK | \
+			     HPSVS_SW_FSV_MASK | \
+			     HPSVS_SW_SV_MASK | \
+			     HPSVS_SV5_MASK | \
+			     HPSVS_SV4_MASK | \
+			     HPSVS_SV3_MASK | \
+			     HPSVS_SV2_MASK | \
+			     HPSVS_SV1_MASK | \
+			     HPSVS_SV0_MASK)
+
+/*
+ * Bitmask of the security violation and tampers status bit in the LPS register
+ */
+#define LPS_ESVD_MASK  BIT(16)
+#define LPS_ET2D_MASK  BIT(10)
+#define LPS_ET1D_MASK  BIT(9)
+#define LPS_WMT2D_MASK BIT(8)
+#define LPS_WMT1D_MASK BIT(7)
+#define LPS_VTD_MASK   BIT(6)
+#define LPS_TTD_MASK   BIT(5)
+#define LPS_CTD_MASK   BIT(4)
+#define LPS_PGD_MASK   BIT(3)
+#define LPS_MCR_MASK   BIT(2)
+#define LPS_SRTCR_MASK BIT(1)
+#define LPS_LPTA_MASK  BIT(0)
+
+/*
+ * Bitmask of all security violation and tampers status bit in the LPS register
+ */
+#define LPS_ALL_TP_MASK (LPS_ESVD_MASK | \
+			   LPS_ET2D_MASK | \
+			   LPS_ET1D_MASK | \
+			   LPS_WMT2D_MASK | \
+			   LPS_WMT1D_MASK | \
+			   LPS_VTD_MASK | \
+			   LPS_TTD_MASK | \
+			   LPS_CTD_MASK | \
+			   LPS_PGD_MASK | \
+			   LPS_MCR_MASK | \
+			   LPS_SRTCR_MASK | \
+			   LPS_LPTA_MASK)
+
+/*
+ * Bitmask of the security violation and tampers status bit in the LPTDS
+ * register
+ */
+#define LPTDS_ET10D_MASK  BIT(7)
+#define LPTDS_ET9D_MASK   BIT(6)
+#define LPTDS_ET8D_MASK   BIT(5)
+#define LPTDS_ET7D_MASK   BIT(4)
+#define LPTDS_ET6D_MASK   BIT(3)
+#define LPTDS_ET5D_MASK   BIT(2)
+#define LPTDS_ET4D_MASK   BIT(1)
+#define LPTDS_ET3D_MASK   BIT(0)
+
+/*
+ * Bitmask of all security violation and tampers status bit in the LPTDS
+ * register
+ */
+#define LPTDS_ALL_TP_MASK (LPTDS_ET10D_MASK | \
+			     LPTDS_ET9D_MASK | \
+			     LPTDS_ET8D_MASK | \
+			     LPTDS_ET7D_MASK | \
+			     LPTDS_ET6D_MASK | \
+			     LPTDS_ET5D_MASK | \
+			     LPTDS_ET4D_MASK | \
+			     LPTDS_ET3D_MASK)
+
+/* Access for sc_seco_secvio_config API */
+#define SECVIO_CONFIG_READ  0
+#define SECVIO_CONFIG_WRITE 1
+
+/* Internal Structure */
+struct imx_secvio_sc_data {
+	struct device *dev;
+
+	struct imx_sc_ipc *ipc_handle;
+
+	struct notifier_block irq_nb;
+	struct notifier_block report_nb;
+
+	struct nvmem_device *nvmem;
+
+	struct miscdevice miscdev;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dfs;
+#endif
+
+	u32 version;
+};
+
+/* Struct for notification */
+/**
+ * struct secvio_sc_notifier_info - Information about the status of the SNVS
+ * @hpsvs: status from register HPSVS
+ * @lps:   status from register LPS
+ * @lptds: status from register LPTDS
+ */
+struct secvio_sc_notifier_info {
+	u32 hpsvs;
+	u32 lps;
+	u32 lptds;
+};
+
+/**
+ * register_imx_secvio_sc_notifier() - Register a notifier
+ *
+ * @nb: The notifier block structure
+ *
+ * Register a function to notify to the imx-secvio-sc module. The function
+ * will be notified when a check of the state of the SNVS happens: called by
+ * a user or triggered by an interruption form the SNVS.
+ *
+ * The struct secvio_sc_notifier_info is passed as data to the notifier.
+ *
+ * Return: 0 in case of success
+ */
+int register_imx_secvio_sc_notifier(struct notifier_block *nb);
+
+/**
+ * unregister_imx_secvio_sc_notifier() - Unregister a notifier
+ *
+ * @nb: The notifier block structure
+ *
+ * Return: 0 in case of success
+ */
+int unregister_imx_secvio_sc_notifier(struct notifier_block *nb);
+
+/**
+ * imx_secvio_sc_get_state() - Get the state of the SNVS
+ *
+ * @dev:  Pointer to the struct device of secvio
+ * @info: The structure containing the state of the SNVS
+ *
+ * Return: 0 in case of success
+ */
+int imx_secvio_sc_get_state(struct device *dev, struct secvio_sc_notifier_info *info);
+
+/**
+ * imx_secvio_sc_check_state() - Check the state of the SNVS
+ *
+ * If a security violation or a tamper is detected, the list of notifier
+ * (registered using register_imx_secvio_sc_notifier() ) will be called
+ *
+ * @dev: Pointer to the struct device of secvio
+ *
+ * Return: 0 in case of success
+ */
+int imx_secvio_sc_check_state(struct device *dev);
+
+/**
+ * imx_secvio_sc_clear_state() - Clear the state of the SNVS
+ *
+ * @dev:   Pointer to the struct device of secvio
+ * @hpsvs: Value to write to HPSVS register
+ * @lps:   Value to write to LPS register
+ * @lptds: Value to write to LPTDSregister
+ *
+ * The function will write the value provided to the corresponding register
+ * which will clear the status of the bits set.
+ *
+ * Return: 0 in case of success
+ */
+int imx_secvio_sc_clear_state(struct device *dev, u32 hpsvs, u32 lps, u32 lptds);
+
+/* Commands of the ioctl interface */
+enum ioctl_cmd_t {
+	GET_STATE,
+	CHECK_STATE,
+	CLEAR_STATE,
+};
+
+/* Definition for the ioctl interface */
+#define IMX_SECVIO_SC_GET_STATE   _IOR('S', GET_STATE, \
+				struct secvio_sc_notifier_info)
+#define IMX_SECVIO_SC_CHECK_STATE _IO('S', CHECK_STATE)
+#define IMX_SECVIO_SC_CLEAR_STATE _IOW('S', CLEAR_STATE, \
+				struct secvio_sc_notifier_info)
+
+#ifdef CONFIG_DEBUG_FS
+int imx_secvio_sc_debugfs(struct device *dev);
+#else
+static inline
+int imx_secvio_sc_debugfs(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_DEBUG_FS */
+#endif /* _MISC_IMX_SECVIO_SC_H_ */
-- 
2.25.1


