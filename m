Return-Path: <linux-kernel+bounces-155117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF648AE57A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862B01F240EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522BE84DF2;
	Tue, 23 Apr 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K+6F9M2I"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591E2AD11;
	Tue, 23 Apr 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873649; cv=fail; b=iXZDLlcasIuT1mHiw46X6Uinlhc2oaIRTePL+tEazS5LxmGBme3bLOIEyHE0Toa9QPcg8ebvM1lDGdVZXfsFbeVnFMTBehawnt0kHsheeKxtcmsKo2u7H9JfFW3/wDoHn2eTezKNNk6EJxFuKBJFO0FbkslWeCxgX861kEYm5l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873649; c=relaxed/simple;
	bh=N95eFet9en23hUv4gotXYxKwheqNZiL9WrDFPgm0ej4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EerlZTSJQcqv5Ct9D6zHPDILh1C66Twsev+slhYnk9fHjaQkiQAO2ZrJ5qcXFLsZoYo5EYNxcwcZXrSSP4DAiqG/EgVusHNACqhbDEYJCVZL35Plx9Hed9N2iXYB7JKE+QwtvwUK716b22Ppjns8CqNhytsmAQy8VZhPG3E8shw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K+6F9M2I; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcH/zTvBLUT5vnJUJSmfzhdHsIfeKm37vWEQwpnOlOjy9UuAJMXDLbmOvBNrD2NGXcvhx16U84d7Q2ohw18vXfObVIkNGFpdQo28rex7GHdrueQ7gHvh+F9FvhyZuI2Ejutkt3PchzxFCjod32bvzYRHulcpWea+8wXOrChvGtVMKO79lH1bB097BXSvCOGeSZCiq8PkVoOyeWknrTvK2VWBXhSG0nCbW7JqVpUfvR2bcvrduSfAsgPIT282NjYmmeZg23ryMUiX49uwyJ5kY9cc9PDGOBPoqD147OoODTM5XSSpyzQNI0lxLOhhxhoiPzQ5Y26FNIQhgR2bg5KjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Xz9h7cPg9TXUXXSKZmbTelqnZA4UGUBAXomaKRzsCg=;
 b=FgPrCqJo03SeqxXosI9cRxnsAMNl7EQNgvzsRYKa9uvvRzBa9Q3909biH5aDUZhTyyi4fUIu6EIIZyRQkiTA6xKjrWbCo9ttuF2dxRQYChKNWY2Wz/0HXoPFNEMCp6P/YXDq2SoKnj0UnIJZSdbJVhlZzq3cmO8Owm9+jsIXiTkv1VrQQ6O/P5wiFE1yO2PXyFwLssvLhyac7owciGda6Hzzxui+J8KDAgb+DvOJkQ4B++GfbM0WzIOQhvCiv/SSXc+SvTCJkvBZqth6nEmbsAWbyxvHyqC8zQsoCprEFbYoDzvR4v05MK8NbZqvOX3Ad9ly47aaajQSHWM8ryyT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Xz9h7cPg9TXUXXSKZmbTelqnZA4UGUBAXomaKRzsCg=;
 b=K+6F9M2IRKG05HsSIN9sj7lo1w8fCi5jZufbXsKJkxAt9fejpRbuOFXjdVYyVNekNjWiggcLKp61o/TES5EN32NlAXElCgIUVBINmgbWMpURwFnEETxwRh96+RqYsn6zrmfz0Ng2naQ/38I9iCZRSO83EDs587KPQIoJZRgrlZldWxFiPnTn2WhYS4VbsqpHjNX0PLKuJG+2nrhhaiTtRV66jeiwH4P7mwLOJHrUHpX6hJPmTo2nvDqs+j3yALdtLO2l4UjIcikgZ6iWlrwI7kY1YQTARVp+/u0YkWAi4B8II3fUEHwMKBnyLpy9SXgJk7KmEIyPks80YqZ8zzMNXg==
Received: from BN8PR15CA0053.namprd15.prod.outlook.com (2603:10b6:408:80::30)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 12:00:38 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:80:cafe::58) by BN8PR15CA0053.outlook.office365.com
 (2603:10b6:408:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 12:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 12:00:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Apr
 2024 05:00:17 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Apr
 2024 05:00:16 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 23 Apr 2024 05:00:13 -0700
From: Prathamesh Shete <pshete@nvidia.com>
To: <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <jonathanh@nvidia.com>,
	<treding@nvidia.com>, <sfr@canb.auug.org.au>, <linux-gpio@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <mochs@nvidia.com>, <csoto@nvidia.com>, <pshete@nvidia.com>,
	<jamien@nvidia.com>, <smangipudi@nvidia.com>
Subject: [PATCH v2] gpio: tegra186: Fix tegra186_gpio_is_accessible() check
Date: Tue, 23 Apr 2024 17:30:11 +0530
Message-ID: <20240423120011.21554-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CACMJSeu+fUdYoxue-q=DxFdvtopgshQY+i2kpZMP-RGOTqMu_g@mail.gmail.com>
References: <CACMJSeu+fUdYoxue-q=DxFdvtopgshQY+i2kpZMP-RGOTqMu_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: af34eac1-e130-4103-07b0-08dc638cfd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eod41ayva1XH61sm9jrzphH113eBQYGqREQ3Clf9iPWE0QNrKPHxn6PdEwvj?=
 =?us-ascii?Q?F2V6VXO+FfvHj2B9KAn1wWTjlH6nxqujrIv6Bqm3whKyTc90qYJvy9p0OvtQ?=
 =?us-ascii?Q?JgijEyVR4A9Ylrw14oe3URE50L50xf0XVZNUTdhTOtmN0n+D8nBIlMXs36Lc?=
 =?us-ascii?Q?iFk/taylIdJeyk9jGEGQXMeqlAwWPiOWDVB/H4xY7Wh5QJNeZ+izZjRzanST?=
 =?us-ascii?Q?NGatCaPyM0SV/5wB/lNczNNasEzJOfDg4AHNbsODLRoto+gXfS2Tap6qX9NG?=
 =?us-ascii?Q?U+6E24NpcxfmPT9AxFi7Q/HJCGefyaoXwCwhqPs7x5bfLDg9VcAdgzFkobjD?=
 =?us-ascii?Q?hO7JfnBDLpWusERn2jTLP5y5ii+LNvysaWa8sTp4ZDnc2W+lCZ6T/iF5eipt?=
 =?us-ascii?Q?j0KeesX92t9TahHC57tCoGOjYHehPxJk6VJhPqkjUF6LPrRS8VscLUkzPV6C?=
 =?us-ascii?Q?Wsmld/199zrmP4WOVLSPxm+4Nii6EP2yB4hK885KFgR7Q3uiH5IlXihjv3Y9?=
 =?us-ascii?Q?CrhbBOMeKmDdKGQ00/IKnXpg2bsma7bvrH+YgDZ+e0Sz23mJ1pPiSIQgM0wS?=
 =?us-ascii?Q?DZuMIKLBEbT/hayOH/aaU/VnbA8kM/Db1Jfo3TxiTTENX0b8E+Rc6q/KWHgS?=
 =?us-ascii?Q?eUyTpKtkLSRRPbgOJ4NdTkQp2glX1rBkrREMC+Ku2n5OFVtQ/usjJIL9+bgM?=
 =?us-ascii?Q?ga4nQ4qSB7uCYk4KzR+se+v6B8c5Dp4RVyKKFbpAp9SZryAmLDD8G/2QLVzF?=
 =?us-ascii?Q?Z744IWdFp6IosozR72bHeHnG0jVbOPj83iW8GZ/r7ZrJ1qFaXyp17U35F/lb?=
 =?us-ascii?Q?LMrLRegj3LF7ogR8XNVFfbKuVJVKT1w2nT62zZbEyJGvMmAtAg7d03yGjo4y?=
 =?us-ascii?Q?WppgUZYXz8x6tDmGaTEfGz7ymjIk1akl0fgrpEz/OmPr6dTxgfo+Tx7d9goi?=
 =?us-ascii?Q?wIueN6XxaTOFEZKzpHlC5oTutUCv6LMnihsIqMS5TY/MDWI9gFpr2JTQPQHn?=
 =?us-ascii?Q?3YRxDK03/7vbBhMEsB1zk2YaY/4gcuFopxPisuTkjM8RpIxwLFhQMReFTaNO?=
 =?us-ascii?Q?us3nQk2XhRSltnFxTfiXqW5J3JF18DPh0dPGhpsnmXj6wY8nGR2M9fkZ57cZ?=
 =?us-ascii?Q?/WJOS1wFJsrDr02v1GEe6mpMKbaPYVwHulcMxnUhVp7k5C4iqWF9cvoDLhRg?=
 =?us-ascii?Q?YWHXcRmrf9lQ96lnL73a6RbcfxnSzQ89DeYaQMLH65liOopPE/GlNfSrJbPD?=
 =?us-ascii?Q?kpQutieIoxyG8fAz99Ehx48jMQtE5o1zqSXF3JiQwbUHiH8MjKN+j6vKfM5e?=
 =?us-ascii?Q?XFEtplUoCdQJmGSQDpS3mwEt47XRrGZX1eJNxbiOObOZwoh9VgmIDD38eobE?=
 =?us-ascii?Q?h0CdH2R02S7hh+WpFWxdOaSrz83H?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 12:00:37.5867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af34eac1-e130-4103-07b0-08dc638cfd6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128

The controller has several register bits describing access control
information for a given GPIO pin. When SCR_SEC_[R|W]EN is unset, it
means we have full read/write access to all the registers for given GPIO
pin. When SCR_SEC[R|W]EN is set, it means we need to further check the
accompanying SCR_SEC_G1[R|W] bit to determine read/write access to all
the registers for given GPIO pin.

This check was previously declaring that a GPIO pin was accessible
only if either of the following conditions were met:

  - SCR_SEC_REN + SCR_SEC_WEN both set

    or

  - SCR_SEC_REN + SCR_SEC_WEN both set and
    SCR_SEC_G1R + SCR_SEC_G1W both set

Update the check to properly handle cases where only one of
SCR_SEC_REN or SCR_SEC_WEN is set.

Fixes: b2b56a163230 ("gpio: tegra186: Check GPIO pin permission before access.")
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index d87dd06db40d..9130c691a2dd 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -36,12 +36,6 @@
 #define  TEGRA186_GPIO_SCR_SEC_REN		BIT(27)
 #define  TEGRA186_GPIO_SCR_SEC_G1W		BIT(9)
 #define  TEGRA186_GPIO_SCR_SEC_G1R		BIT(1)
-#define  TEGRA186_GPIO_FULL_ACCESS		(TEGRA186_GPIO_SCR_SEC_WEN | \
-						 TEGRA186_GPIO_SCR_SEC_REN | \
-						 TEGRA186_GPIO_SCR_SEC_G1R | \
-						 TEGRA186_GPIO_SCR_SEC_G1W)
-#define  TEGRA186_GPIO_SCR_SEC_ENABLE		(TEGRA186_GPIO_SCR_SEC_WEN | \
-						 TEGRA186_GPIO_SCR_SEC_REN)
 
 /* control registers */
 #define TEGRA186_GPIO_ENABLE_CONFIG 0x00
@@ -177,10 +171,18 @@ static inline bool tegra186_gpio_is_accessible(struct tegra_gpio *gpio, unsigned
 
 	value = __raw_readl(secure + TEGRA186_GPIO_SCR);
 
-	if ((value & TEGRA186_GPIO_SCR_SEC_ENABLE) == 0)
-		return true;
+	/*
+	 * When SCR_SEC_[R|W]EN is unset, then we have full read/write access to all the
+	 * registers for given GPIO pin.
+	 * When SCR_SEC[R|W]EN is set, then there is need to further check the accompanying
+	 * SCR_SEC_G1[R|W] bit to determine read/write access to all the registers for given
+	 * GPIO pin.
+	 */
 
-	if ((value & TEGRA186_GPIO_FULL_ACCESS) == TEGRA186_GPIO_FULL_ACCESS)
+	if (((value & TEGRA186_GPIO_SCR_SEC_REN) == 0 ||
+	     ((value & TEGRA186_GPIO_SCR_SEC_REN) && (value & TEGRA186_GPIO_SCR_SEC_G1R))) &&
+	     ((value & TEGRA186_GPIO_SCR_SEC_WEN) == 0 ||
+	     ((value & TEGRA186_GPIO_SCR_SEC_WEN) && (value & TEGRA186_GPIO_SCR_SEC_G1W))))
 		return true;
 
 	return false;
-- 
2.17.1


