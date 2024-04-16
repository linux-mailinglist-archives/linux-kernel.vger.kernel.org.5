Return-Path: <linux-kernel+bounces-146796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3278A6B13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E2F2841D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C24C811F1;
	Tue, 16 Apr 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GNa3eqSQ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766012B143;
	Tue, 16 Apr 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270918; cv=fail; b=Uv9d/mgsDoz9iH++LPw98nFSmKIv+OazQb0HQn6Gu6QeY7sCVuO39KvbU6d97O97HkDscJrhY0mYqy7EwNWRtjYXxmiaOeF0logfZIrcAWiTJQq6WkkJyJUl9sZ9GLBZfC0l7VZRHHhxlX2Pug+u4RDNIbOwubow9kUWiOcU9Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270918; c=relaxed/simple;
	bh=m2+yzipPU9KP4I3SoL2sYcO1b1xel6Gg8BCeBXLPTOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SDzCWRyaATjAzovudk2+KaooNn+oib7vg69TLFDI0V/W9kotdMN1Iz47HhwcFIYTR9/p41hj+Qm/wxfoVDxxM7PA/SSRsU9aWyZr4yS0Mwk1QXCrLYvp7d+L13Y0eaHwPGKmNYu3LjBTbSxfp2rO4Dpk6z2yI5JEH6pQjYuH8xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GNa3eqSQ; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhiF1lJUWZK/nBeNdxiabY+5Id9iiKYTer5p6r/WYSkt6MKL3lcOjRhS4uWIdtmYvcWV5m1Xu1WMlXpdQPUIy1gGtM3OZb3CJKEV6pl4pBL4Gh2HpmlBcIsyeV7u9DqSgnl5ZuremHegIpCbj0joQUXUuxjNvxBWx1bU762wk3vh7PYjY49pI4WJLsfjiXg/KWenUKqUIdExX+Ao6yfXv3PfjMDFt8+BN+0UyDAwILHpQurRAW1wTMh8WWx/KPL6fKhipNOFXeGviXH0WpFp0yAq8ZXqBvkqbG7pnmrKcaJ2jy8mNZHapP14zcDPITjyKBldfSUEhPRGXNxANFvpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm3xgn12Qi5o3UoGAzoVPsIM1fz6m8EDo+t5i6775v0=;
 b=K3eN2rC7DfLm2VoQhrwHm+3mXA+PdhkQcux7sDKQU64QbCXvl+H4Z7mJ/RS0CSjnlMQ5DSG7OMB9tDd2z/b7sDjeIGSWDrGBBlX5niUyfi15eL0u/7s4KiTb/cn3IR8rZYmEY9oIY941I66G1GcUii54l4NHSS4UkYbOQTfwrYKiLnnW6+IDo/hSDJ4bL/CisJIpuewlgj1mkTxUub9TI9yMVLprs+rZhqErIy+eSS9sy+3sfDeOqtcovcNU+I15Z/fsnwdACiR5pdmBVTGdvml3HrYW29ceHvWzDhfmO7U6KEuVBNhy0U5Ol3Y6/tKdoahPevyAyJgSTb9yEOxukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm3xgn12Qi5o3UoGAzoVPsIM1fz6m8EDo+t5i6775v0=;
 b=GNa3eqSQr5WB6f6vRal3qWW5862R5lLO1La4/ybHu2Xz2Z0cFWc+N3V2CNIYwgdUT3dpTg6znLLxXF/AHDomy38qpexpzJ2BQQt/sQJ7RXlYcJb986Fu7xEmbjdxAi9uWMWMLN3ehrObsst5R5HWMQE/YQiZ+wTbndtV0JDKSEXbcn1Ir8N8OjT1v2XWLcNANZVwdyPitsU4fXiOf0p6piHU6cZ2DrPxmHcxEwIJV290bS4z6g/T9lioQA8yBNJDdtYC0UnjGZSAt8rOfc8ta9egzEpH1jWTHNmOSxSYTs5ZNppHsIcr1gF6OrONhBMWGAOnIy8ilf4Mb9oJtUu70Q==
Received: from BYAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:a02:a8::49)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:35:12 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::d) by BYAPR03CA0036.outlook.office365.com
 (2603:10b6:a02:a8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 12:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 12:35:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Apr
 2024 05:35:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Apr 2024 05:35:06 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Apr 2024 05:35:03 -0700
From: Prathamesh Shete <pshete@nvidia.com>
To: <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <jonathanh@nvidia.com>,
	<treding@nvidia.com>, <linux-gpio@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <mochs@nvidia.com>, <csoto@nvidia.com>, <pshete@nvidia.com>,
	<jamien@nvidia.com>, <smangipudi@nvidia.com>
Subject: [PATCH] gpio: tegra186: Fix tegra186_gpio_is_accessible() check
Date: Tue, 16 Apr 2024 18:05:01 +0530
Message-ID: <20240416123501.12916-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f5e69d-8940-4bb2-3480-08dc5e11a95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yasai6qY6TqUFE9fmNU3P/JdEH7RXHt3SJ2nXX1WftuIhsVRJvcPxTTjzfrqgBBEHp0h7OKPIytWu5nkqB5tNBDHlCmEc/lMNrBHvx+Yras5Xk/IgzodCJCEvoF4zsVNi/SPYMaFrkdcGys7d3DC1rzSq04DgV8PzO62jc4//K+arlJIYPkSl0vLwMs9ISOd8QiDc0Wqtx1PBDy+e2ilKNYdDZG0i28OVwrt7nhULPZRmHf3C82ZURDPvU7rfNfydEPOkT5GxaqDxjK6PB5pvFc1OhQQnMWUg8l6r8/ptaLo1nc09kkS4ggGy7upo+DwkbEN/BZsu+t+NAnzvBs+0u0NmjV06Y2ugKYJCC+jkrXs4/GmlRmcDR6tR7ZnNWNglH66erPC9DFI/B7+TnppTYacK/Uwp9D1wBS1ktn7u/NBY7lVGgXYQ9aXekuIAtBC7HzTm8BuyrS6Nzx286Abl9hkLS/LhqEuBTQeTQV9inGySquvY42DETqVXsPHwn0fBliSGk03ZifUf0cjfflrwgo29PxWX8d0zHeXF89yuc+jgDtyK1rPht2KmfIwTs5nw+oiHrkYdQSHw9ZqjXhZBYtT+HrXXFmZ0vfmEP5gSxs+EC42c0IyxALOeBJN2sM/pfiyQxnZgX3e0gt8nsuh0rjZwb1UwL31FEOkN91QlIcWveHqyD/lO4FSf8DBuPUg6Ril3wfz0gW4FK4qPw2YHvnsBgeyYEvdvMS58Emev42IGI5KyhctVAB/IaVC0FBb
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:35:12.8458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f5e69d-8940-4bb2-3480-08dc5e11a95c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053

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
 drivers/gpio/gpio-tegra186.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index d87dd06db40d..54c8b02eec22 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -36,12 +36,10 @@
 #define  TEGRA186_GPIO_SCR_SEC_REN		BIT(27)
 #define  TEGRA186_GPIO_SCR_SEC_G1W		BIT(9)
 #define  TEGRA186_GPIO_SCR_SEC_G1R		BIT(1)
-#define  TEGRA186_GPIO_FULL_ACCESS		(TEGRA186_GPIO_SCR_SEC_WEN | \
-						 TEGRA186_GPIO_SCR_SEC_REN | \
-						 TEGRA186_GPIO_SCR_SEC_G1R | \
+#define  TEGRA186_GPIO_READ_ACCESS		(TEGRA186_GPIO_SCR_SEC_REN | \
+						 TEGRA186_GPIO_SCR_SEC_G1R)
+#define  TEGRA186_GPIO_WRITE_ACCESS		(TEGRA186_GPIO_SCR_SEC_WEN | \
 						 TEGRA186_GPIO_SCR_SEC_G1W)
-#define  TEGRA186_GPIO_SCR_SEC_ENABLE		(TEGRA186_GPIO_SCR_SEC_WEN | \
-						 TEGRA186_GPIO_SCR_SEC_REN)
 
 /* control registers */
 #define TEGRA186_GPIO_ENABLE_CONFIG 0x00
@@ -177,10 +175,18 @@ static inline bool tegra186_gpio_is_accessible(struct tegra_gpio *gpio, unsigned
 
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
+	     (value & TEGRA186_GPIO_READ_ACCESS)) &&
+	    ((value & TEGRA186_GPIO_SCR_SEC_WEN) == 0 ||
+	     (value & TEGRA186_GPIO_WRITE_ACCESS)))
 		return true;
 
 	return false;
-- 
2.17.1


