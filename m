Return-Path: <linux-kernel+bounces-158350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE08B1EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4F41F2147E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B438626F;
	Thu, 25 Apr 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s4D1kSDZ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C784FD4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039426; cv=fail; b=C7zkyxBpEJmhAYlilrIXTxWaXl/gX/ZfT9PxcMYlzW+QO/7vYeCC0R7fL6aPj79Pe2IVHQdYKh84kw+IISFoBrg7+fX3sypCF5ARcBoEP9cVKCZ5P462m96kWbv1nw4EpBXu+/Ui7jW6MC5htbRPwWooTyA0sixypsHslSpe1CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039426; c=relaxed/simple;
	bh=ArjcDJXa9u5BDmuB9C/ZVB+7BnypxsKAiKk1XAM86MU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uArb2JwSDS6t2Is+GZZpa7vSTQCpdGSCGPEtl1NFcm4x6lgFd3DpA3xDbIokYKko8WKZNxs0wfdvGjC1ARMaokR3+kuqdnCcp0ZFrjBiGjk/r0dGKhVl7gb8gtR6wcWFol6LFbLdHgyNadWv437Z/XKo4tMO6qXCx3ZIp7uYgMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s4D1kSDZ; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fy/CQyo6lLKfzCRw9W3+/iCRr/YvoTqnPnMkECGZDHuk+g1LaztILYcLhqc/Pf8zwuZMUBpZCTpiF10Ukb1snzuRD+B7D2NrKOxhRhIThqZ/sfO5vziGRG+5GNP5BORQ/tozXE/0kfevgorzEVAOYRLLVqWfPigGA87FUNRE0BgRpKkp6H4AFerm3MgwGoegab6EOGKP8ogYHlmJBBIO+mbywT2OIkaVx4NPsB1xFhxxChSFO2/+TpjtdcC5OG9sWuGP8NpED6U9+23rsn441bGSWQk8y88B7cQd0c52VRWIJXiPCTNPwxHPWgMW8gIvxmQ//lu/B/Rw6uqdW0g9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4gZZGd45zLqJSduWMpnITSF1PuE8Qi8BF0SxGUP3o8=;
 b=EXdX/j0TsLUk1zcZ4Y0yLJH8FIE8N39Esy1/H4qHlhFAx7AL8COv5JQnXMasB6Sl8znpsRzF4IygpDvoqTuYvGp8IA2+3rQSxK1/7MM9aZ71093vyhBpzDNjdIKPbv5WH5TO66mF335/lmtEBrU1h4Uhjh6XpxAtwseoyKbjX6Sxvn72ea745vzXcwvizSSD8E7QuekSpiKyEeoSaCYkIsAw2FymIraJNEA/qjywiZg9iaYXfCTr9fjc6N2b7PjVIMly+MGJY9DEJEarCaCbfc+teU/pVm6Hp3B8MCr4IRlmLxbjbtBGCbc9JlVPryueRB90FPo2ngpDSewKJZ4S1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4gZZGd45zLqJSduWMpnITSF1PuE8Qi8BF0SxGUP3o8=;
 b=s4D1kSDZwJVatAlpQSD1NIDCBXPjCggIlwm8U4c/G1XbCpj8CvT1pS7h2H381vuYXCkMyLfqMo8U927DWI7iA+Hq+pIeQfjwSUWrkvDGkShNoRkINQxOKm5ln1siRW6ecZS7sNCSff2LPQ2Ksl5nCo0QE9LseJaXQxfgKQBywyM=
Received: from CH0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:32::12)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 10:03:42 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::3d) by CH0PR07CA0007.outlook.office365.com
 (2603:10b6:610:32::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Thu, 25 Apr 2024 10:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 10:03:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 05:03:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 05:03:41 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 05:03:40 -0500
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v2] drivers: soc: xilinx: check return status of get_api_version()
Date: Thu, 25 Apr 2024 03:01:36 -0700
Message-ID: <20240425100136.13933-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240424063118.23200-1-jay.buddhabhatti@amd.com>
References: <20240424063118.23200-1-jay.buddhabhatti@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: f37209d3-fe99-4fc4-7087-08dc650efc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iA0lTY1bFj2TfvJhc4g6O2mXGieZjKRS6k1AcE/FRs+d6ljNe9lF7PNmbnvT?=
 =?us-ascii?Q?bp9cJE1WO7xu+Y5LvFgI73OwvWJhY+cS5vBUc5Z67C3Wfoy1D0bdLvqearL/?=
 =?us-ascii?Q?skZB/J77pysZtqMyn/MEhz/ZoY5Xkx8wj7LwII5A0qTHoTZuKOTaQRXYIOzK?=
 =?us-ascii?Q?IraKqv9i4XK6E7aBLles3cdGkdo5vjHi8ARLfUlh6YEzXKtR2mSEERouuaH9?=
 =?us-ascii?Q?UCDc1Yk4/pZ7OpQhAInx3SqXldJcdVoehSWAymHQtgjJ3iT8MQ+uHj6BEaq2?=
 =?us-ascii?Q?itlGfTV2HoDa+huWuNrpSEbnchlJOY4RL56vnBIENgdiaJCDbwkV4zCOv+sI?=
 =?us-ascii?Q?O4fxwu3bnteAqbKl0TZneTwSLbJ1hk8ydx/Q3QaxrYH1wtvXIsmCRGLlEtjL?=
 =?us-ascii?Q?moEM4eEnGIdfWco2htD6UXrYCwRQLoA9DjTIwjWM6UcF8cx81KfoHzZ1KIfu?=
 =?us-ascii?Q?IR2CbRgzBMpmzGS751TC/GEwBS9NgppZYBOcnueZk++jZ+MiYEwgCn5A0fjL?=
 =?us-ascii?Q?wlRBmYb0JLXtqK3K1nO0hnXCfFJO3TtJ/Uw5i8KtN/Xnd9LpMBd1RUGngWPJ?=
 =?us-ascii?Q?L0fm4ZhCYRxb+Slyhkn0xLZ4qBGoV8r8ip7OnZhvXq8sQPlhcTWU1f4wtbiC?=
 =?us-ascii?Q?BE7RDFQFG7N41BdptiKGW/LvrcewclmsSfP/406+/fmMp1VkT2Nu9Yo75cX5?=
 =?us-ascii?Q?1BmunaErKuD9DBU/vMX6qTducvTKE5Sy7swlOz9Q9HDSAzLdNjrkM9+LK5U0?=
 =?us-ascii?Q?0GQcNkWN58mxNIU6q8pUjLjCTt2aHSm5rZ73PbMSz8LOAxS0Cc9v+FpqjAx4?=
 =?us-ascii?Q?A8kHOahQR9yQyHVs/4NuhIL2onLUV42vTSagRXMskVOuSF0L/PnRe8I4wJXu?=
 =?us-ascii?Q?jRCMg+MuFIIIihdk+Y3H0WM8IECuUrgrjRTSzm+NWYb0oaaXBtT36BXL7NJ9?=
 =?us-ascii?Q?USVwfjlFIB/WXx7hZZ4e+U7aK9oqHTAGZVyd70MyJpRbtd3MRrUu2kSg03eC?=
 =?us-ascii?Q?iqF9cWZp+rvjiYmz/gNY3SU6SybGZxl+hFDB40i6IXe4texmRluK4wDp5iFM?=
 =?us-ascii?Q?7/fXaVUqCuJO6Ticcahdbs97Hq+DCeafczvK1kztaHWLFMdtic21B99BisLc?=
 =?us-ascii?Q?vzlH++RPEvQNLNBC+l/CFdW3imn5N96+tRP34Dc/AZJrf5Xj5okXfuYA0Kpl?=
 =?us-ascii?Q?OWT1zDYDA5C0mYj9KXgBnN8Ys8GziTlagiVb/EVJyA0V42OxFCaMhhYYbf+t?=
 =?us-ascii?Q?TcBAP+JhJBjHsLHgd3JoWqXnKkDodDtBwdide3T1LcHg2Nf8dJHsZVCoERJ1?=
 =?us-ascii?Q?nXBYxMigGOtmYpPX1RKFdm4qsncCK/mn8ksFt9qLpvAT9us5l3aGC1MFbtsH?=
 =?us-ascii?Q?x/xxPCGt4ZepSpj57kylOrXkLuir?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:03:42.0258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37209d3-fe99-4fc4-7087-08dc650efc90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

Currently return status is not getting checked for get_api_version
and because of that for x86 arch we are getting below smatch error.

    CC      drivers/soc/xilinx/zynqmp_power.o
drivers/soc/xilinx/zynqmp_power.c: In function 'zynqmp_pm_probe':
drivers/soc/xilinx/zynqmp_power.c:295:12: warning: 'pm_api_version' is
used uninitialized [-Wuninitialized]
    295 |         if (pm_api_version < ZYNQMP_PM_VERSION)
        |            ^
    CHECK   drivers/soc/xilinx/zynqmp_power.c
drivers/soc/xilinx/zynqmp_power.c:295 zynqmp_pm_probe() error:
uninitialized symbol 'pm_api_version'.

So, check return status of pm_get_api_version and return error in case
of failure to avoid checking uninitialized pm_api_version variable.

Fixes: b9b3a8be28b3 ("firmware: xilinx: Remove eemi ops for get_api_version")
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
V1: https://lore.kernel.org/lkml/20240424063118.23200-1-jay.buddhabhatti@amd.com/
V1->V2: Removed AMD copyright
---
 drivers/soc/xilinx/zynqmp_power.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 965b1143936a..b82c01373f53 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -190,7 +190,9 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	u32 pm_api_version;
 	struct mbox_client *client;
 
-	zynqmp_pm_get_api_version(&pm_api_version);
+	ret = zynqmp_pm_get_api_version(&pm_api_version);
+	if (ret)
+		return ret;
 
 	/* Check PM API version number */
 	if (pm_api_version < ZYNQMP_PM_VERSION)
-- 
2.17.1


