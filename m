Return-Path: <linux-kernel+bounces-156671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5728B069A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C1EB2583F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AB31598E3;
	Wed, 24 Apr 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aUCb4VaB"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAD1591EF;
	Wed, 24 Apr 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952537; cv=fail; b=cfNBy/UZsOpugQszgjelAQF5W1WCGQXwE33/GuKF7g69KuNJ4JldJfmDwVysVQGkyH5ZeAd+2j5as+YrRWG28Kb8ZuvMTH46JgCOrq1JrBbafPAbvrl4A5Uzh/Pi5zmKD7F7UbWaszVnBAHoi0D3Wgf+YSK/eSIvg71c74NW2k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952537; c=relaxed/simple;
	bh=zoVOGal6cgQ1bpmQI1ZNyAe2G8nNjJU5dVjlP09XpWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amk8r4iqWajt5UYPO3FKZ6hPUJsYwwAa+N+789ZBtkPefjBux1qFXNvbN7SbIw19yw+bSKm2IZDvrUHmEoJwixq8R6laduSffXoRM7FB8shYG21PK2uTyQx3lUX8z5IV4LhjjhVo10VHD3Lbfo5rHh3oZilfQ+IxoACBxBpVejs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aUCb4VaB; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUbDXDHEj7FqiokPAjGvzN8uYBwqexG5YKEgn1Nb6bYdbn5UBF0AYzxwzkxtHknQrpbGxZkFcTUlUYJ3hyXJU9TUO+Vp3YUBMB8MLAe7G9JO1a4V+9LHd0qg0QGai+bzEbJQrwxmrxrCFFo0QyTO1hMOjZKI7wDTiRAxgbUoUYL8b5guFATBIhmYhSbq3uiqKXrPPW23rIoBMeQygngT4N6ZnPmwhY66+929hIcuBanf2Sn+npqFNavr8/jEvqmRD1NvbF7Zf3yGSKbJeJcZHDZ0db8PxbR/vLI4pm+TYHUzzCmICEC1XEoa7wg/huaRON41xnmkSoZ1DqCBAFuefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUyOSBYA3l4OkJBb+ZbwkkErgKlejgw8t93Cq1e7cCk=;
 b=NdPMtDvPlgvt6YuFo3bsWzS97WIQhX0cy5ilV2JP537R8PAyX5oWwbGjIJ45ZtThak9gtnxOUYwE5Cbb3QRStClwBKy2QxqR+UEFG94WmFb8FlEf0s21tttsDJxGTp52uSNd9i1UQ7/ZSV6jT+GA3iJXER7fmrlIeFdkArJV7qyogQ9QlhznR4tIEb5t6he1QK3zqez/vwPnepVVscprtEFiMwdmVRe5v1lux32TstP4SpFm5uR0xwNL0mhCDNLy5q0+Fv/6yf70eDuooCta/NACCYZ0AkK6mAwz4o0l8WcP2ZHHIwThwx6JAPt5ExN1T6SwtxRxXRfG4OcdYr8Puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUyOSBYA3l4OkJBb+ZbwkkErgKlejgw8t93Cq1e7cCk=;
 b=aUCb4VaBSymG+yidJ53XIOeCMfWMPhKQYVQRjluNvzFxpQzlr711IYpTBTgO6zIWwCuKMc6TUo/p2n8OD5mTCIsc4LNvG/croTqYKaEfOjxLRNllCV31aLZzf+/VePS6ilicwofMVnt8xAMOYs/Eg7lVBo8Hi0zS1qkWplGLbanD8iM/e5UPw5eNCOPZOvfPNRIxIAm68BmfBCN59C2FUeZswMRDROtUVo4+RmySltKZkaTlqHv6TZbcLqP2Q8SNZa/GqA/9m4j9NtFRaQSkV17nx8aMKVe42hEPYbLxDgjLWut16fcjE5mBGN4TOpFeF8BM81EK64y0Y9oBzTLgnA==
Received: from BL0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:91::33)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:55:32 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::e1) by BL0PR05CA0023.outlook.office365.com
 (2603:10b6:208:91::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 09:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 09:55:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 02:55:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 02:55:20 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 24 Apr 2024 02:55:17 -0700
From: Prathamesh Shete <pshete@nvidia.com>
To: <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <jonathanh@nvidia.com>,
	<treding@nvidia.com>, <sfr@canb.auug.org.au>, <linux-gpio@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <mochs@nvidia.com>, <csoto@nvidia.com>, <pshete@nvidia.com>,
	<jamien@nvidia.com>, <smangipudi@nvidia.com>
Subject: [PATCH v3] gpio: tegra186: Fix tegra186_gpio_is_accessible() check
Date: Wed, 24 Apr 2024 15:25:14 +0530
Message-ID: <20240424095514.24397-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMRc=MfJokORpEOMkOmQdzTuZxcUAcnmpdEyJWKqvT0gCpuzbg@mail.gmail.com>
References: <CAMRc=MfJokORpEOMkOmQdzTuZxcUAcnmpdEyJWKqvT0gCpuzbg@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe1e682-4bb7-45b6-efd6-08dc6444ae02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TB0bKri1tcd3bK7nOSBl52bdp8pfCHY+OR8IoOZn+w5ZPVz34jIsKKxXKTy4?=
 =?us-ascii?Q?SqEaqgUImMDfx9Op/G+uL83KHNhqP7l9QN6KLrResMIdvCW4LRRZap50SFDr?=
 =?us-ascii?Q?s9KR9YbOi7nW2/ZqgUR+jWMo7JUVBbHNI7TNyM7/RrYV+VdbA0KzcBPV8Okk?=
 =?us-ascii?Q?nkviLmRuFwhoaiMrR5rD47G04PiWJJ/VIEgKBQ1PBhCAX0IOt9cIX9PTlmh3?=
 =?us-ascii?Q?BFNtv9RTBCwWwJdq+4CC6DWS+M9MVlw/c5J6ucjUyVWJgDc9hWDq5bUOIacS?=
 =?us-ascii?Q?n6HObP8eMwsYVCz6vorTqaN9l4xcfJ5mDaJP3Oz4frtbnYUHp6CnzBr0MV/x?=
 =?us-ascii?Q?0qR/WPL/zDBzwq5xNqjYtsP2oNgTp6vVy1PwfnRQYVuDAo/M1cYzOgMV6WUc?=
 =?us-ascii?Q?YUJkmmfmTkK32agWDzeGfcT0eh/viNFYwMou2qtmpseEt6Sxvmt1eFlO0I4a?=
 =?us-ascii?Q?SvGo3sIYYKLKffLaJK/QwO4oXxMqEOmC7TyuCGwYxh+sKk0F+KSu3/54fADj?=
 =?us-ascii?Q?YbY/3Axrn6rlpm2EbTAhWqnSukS+MXivXYt9IBhCXXh/rQ5pChWG1ejH5pF+?=
 =?us-ascii?Q?/dB6yYBC/hMCzEjC3HHPuv/OsGmimb+nDxUNIydwFqTYKfA3P6Bi6qP+blvw?=
 =?us-ascii?Q?vmFdFnquezXPfooELliaJXaYkSkvUQ347+9b7FT8qqAA1l3P8PTspoZ5Kt70?=
 =?us-ascii?Q?fsBscoXsOvruUXOQghfa95oAlTkwsml1vy77+PduidF+Rt4r16LyOqlyNRLW?=
 =?us-ascii?Q?wgcB04+TbIWheHyowqQO60KMAqd3qiC2baRqFQm4A8XTG7LXgotZD9fuWVcf?=
 =?us-ascii?Q?A6VSlhO1wI861t7PVjbjKq23lIalJ1qH6ozXImhJe4ah3NgGhbXhd/tSooCv?=
 =?us-ascii?Q?Cjc/e6Lr0elmq9r/Y7MwgpFPSQQ/ct9ZEuLkEmGXWplXWzK4WTwXZIKX2XBy?=
 =?us-ascii?Q?w7RSECo4GwgiiFwqdXk5Y6pPZDPGGH6ARTD70yU88pINEo0TxNm3Dyoz2yYJ?=
 =?us-ascii?Q?zzXcQO+JAPitDle6qmXIoU7JFhG/ZZnppFfBNmxoNxTRZ5ngE2O4ZlpVEfy9?=
 =?us-ascii?Q?BwyeVWBcL2w6g1keBtLIWW4nlQxad+j1iBrzKcOLPlcQ5UD6TZEVWsYH5+KT?=
 =?us-ascii?Q?UcAjPEJiDaULPWAvJVZsRXNPheY37pBXyuT0W+UeHhLwN3yeqo2WGviE3owi?=
 =?us-ascii?Q?ryI+H3xKLITgJ2eZZtw/OwFUEhi2lu9UZrA+yDi+tbVRNNRNNNaznsbI0hpF?=
 =?us-ascii?Q?BrJEmOBrtIe5IAEcaURZDt+RtApaRDr7u+yTuU2wsqYskNq0bnc/lVqFowVD?=
 =?us-ascii?Q?JJ9/M1jnI9USfAZ34O6ddWzEeENO3BjWkhD6quNsT5nJJjNVH5icaEFryxHz?=
 =?us-ascii?Q?Uy9mRpNAoIHfvshC1ouTiEldhXJ5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:55:31.7718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe1e682-4bb7-45b6-efd6-08dc6444ae02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904

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
Acked-by: Thierry Reding <treding@nvidia.com>
---
V2 -> V3: Retain Thierry's 'Acked-by' tag from V1 and add change log.
V1 -> V2: Fix kernel test bot warning.

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


