Return-Path: <linux-kernel+bounces-156363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7928B01CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CB82855BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9FC157480;
	Wed, 24 Apr 2024 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UMg8UlpG"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E91EA71
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940306; cv=fail; b=BgSFed95InB5Nv4mfM9D+UN2XFIxHQaZFfsYkLh9Biys8qwGqW2DB8TwNU76QbmyUQWy6/tF4vvY7teF8yp3MbumtQTKxUxNmTDb2tJQHWDDK1ugZmb8UvlcRVK1yciO4nqHZ+2FDGXr1AvHO8U9Eo6JS7OUU7SC1xgXcExkVs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940306; c=relaxed/simple;
	bh=7gDaoKLArV2L2lxqFVRKrzD4to/+Ud5J+WmGyy6DPCM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nrHwjQ5DSuh6Cs54qfG6FP6iSpbd//zyAUuP2Ddih7gOjJDEwmsmDghYFWnN4eInMAYgFI6ENRgIn1eouKGm4ibRl2NGirWXdT7dEV1OsK1363R90gWgzhHaI7os6X870bZiZTYyF7rN3DsK/wBXWEJQzz3nhwAlNMu/5sW8aGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UMg8UlpG; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKrJGlVALY4tAfvb3rZT22PHgqrnZA6SZ8EdTwXrHbdhPxdxshP7XXQ3cAJ1lDENBnMVgFIh6UfWpPTo/FfiVoMWC+mxP6757YSUOgNH8LHOpD2f7/u9jdz5ftHmLOPX1UAUzN9ypVHULC6usy4Pkccn0YENyNsZ/HB4MvUhAWuqya4HGAhWRwFtxq7LEfj3vqqedSNiUCx/9yMxP4yi0qap0h2Dz/lOCKl3Qf53nUFeHxo0A2V61HboYeXNbuCtSrvibY6qTGw+W4srn6HeYQAV7tYwjfRfcGg7izpO7WFAbg5woiOF+okv6hOLc12K/83XL0TKQ2sjkEdxem4agA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuHNGYB1oeKPKvaJGkDzaJIofDDeotzTYlPj///ahBY=;
 b=SIYgA6QTWhDxqMhq+6EPIxP2g0g9e/WhZok5zrz6DEX9xUnU5RaxRKX8dc4u4Q3LiMCM/ekFt7Cdxh9WVhLcwlSIIEyn22CummOludjx3QTZ5/5ttN+3hrAJVkqWJhJWtO6NBNify1f1WoaAmYv7YjqhmsNmNk8rJrqtMfLViPevJKsZC9hI/wJk626W5vXV5uPE+QeHtt/Tn7z5oaeHnhBSZhFmcA23YrfVTFaX3MnRMIGs8Gx+CrhNEW6R4s/nzDwFodBRsnvG8yLXO6IBjNKUircvudtDvSeOQpG+TxopMPpSOm99dKvHTPxCdy9qN7jdpPXYEjeg7ZAt/NJ8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuHNGYB1oeKPKvaJGkDzaJIofDDeotzTYlPj///ahBY=;
 b=UMg8UlpGiBIog2c8BPinSXd9l57svK/3aEwjg2saEUOU4e7IHzFGuJk9BYEU6V1oCE1CJM+vGdtTUYlp2u0MjsObUehwzhSFASfyo9OvIPwmug1sOoIP/jjihnb5ux6NaJQyzAzMhFecb63uIwKlC0RmtaKymHELW+FQrfCI06o=
Received: from BL0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:208:2d::49)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 06:31:41 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::54) by BL0PR03CA0036.outlook.office365.com
 (2603:10b6:208:2d::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 06:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 06:31:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:31:41 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 01:31:40 -0500
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>, <gregkh@linuxfoundation.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH] drivers: soc: xilinx: check return status of get_api_version()
Date: Tue, 23 Apr 2024 23:31:18 -0700
Message-ID: <20240424063118.23200-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jay.buddhabhatti@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b590fe0-44ca-4da2-b5e4-08dc6428341d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OkJJQS2YouvvSsQodB506xsOyD36JwbK1heWdnUl6lycGWuuffQ59ZL3jXq9?=
 =?us-ascii?Q?rRbAUGU+el6D6udzTETH8VvAupwExBd9xqyVZ60+mPf5BkyikbfVlP81NnIW?=
 =?us-ascii?Q?wQ1P8eOQ69CKsntRvfPVEqdgZEPZpnUqNJ27MY5FW3mXE4fVjoG09rgDY+0m?=
 =?us-ascii?Q?pWeI6dbVcNDe4+iVUzSpdhL2aAEkjKi4i6TqJn2X+5HuOtpy2YAFMK+svQzW?=
 =?us-ascii?Q?DZFklNdv3rzz+8fud8KWy3xco4/9y8U9/W6Rzt+iuKcRfGFvgw4OdY+K8azo?=
 =?us-ascii?Q?F0D7i9FDq0GJwnwCQ6TauajNKIicU+wLEWz7tZoBjrKL0Ml68hNFRP7Rf9eT?=
 =?us-ascii?Q?HPqSHFIO8Gh25dC7g9JhQQFDfCX2b56Hpi42qEObIcjKE7m2tXxyIxEa+4Um?=
 =?us-ascii?Q?UJRAcksFSQkIvaw3iVG5SW2Rj4htYsmrI/EpOJ54/18LEd40CiINf09qidin?=
 =?us-ascii?Q?KZC2u2/C5VMMPQQ86VkbmMJ1WgzqDBBcq3iGkZ5/5/mKGEpb0nMgUMM2rDqk?=
 =?us-ascii?Q?bxvz8Echj+Ba9aJ6BjPWkrnK+kjJQuWwDo1sxk6gRocVrTEyIYjf8voei/DP?=
 =?us-ascii?Q?mTtShrzIKYiXCY6FGaYhhjyH3kM8j5UFchVpsl8UI/KnZInllHWXtg7rLzfD?=
 =?us-ascii?Q?YLCyZAj4zjiaoQMS/9nYIedk4j4AaIhwWF0faoO1bV0F3NJ5G/UYnt087Wm0?=
 =?us-ascii?Q?IrmNcVu1kHKt+AK4X4e34sTkeFJ3u5aWEOBw6sMWXo5m4hU1BDZ9tEtVhwvS?=
 =?us-ascii?Q?F0luwM2nU0yYwAtbMctDodVRE8aRXnVQWpayadtKztBWiWSiAg+bliYoliG1?=
 =?us-ascii?Q?u2C8PWKksnLEZ9RUVau0WpdLTs56pzK9hU+5b8Q++fkHp9BoGL6QsnXgJtYP?=
 =?us-ascii?Q?foaaL+c1rQjhbzDHPYZ07cqJcvKjeJJI+8c7zoyfLbDRno1hJjQxESsHesRY?=
 =?us-ascii?Q?2HSm43iOh7h5IewBRmi8asKc84EBcz49bRZQ51aC4AkLzk8OyOTe8IlSu5UK?=
 =?us-ascii?Q?LMrXtaQdxLX9V/n2ULMuEnYibekWEgWwtONIIz0NTCQxwOJEZzVvK7B0034P?=
 =?us-ascii?Q?9xQCOxdq/7V/9ap0gLK9PPxaPBeN0Tzu/56m1h0Ce4mxct5jWF9IWke5Cyyn?=
 =?us-ascii?Q?2uXBju1Ws6Ol4OH2mhJiNqEFwjhrhkU6Q0d0K6IkgNwh3PVyJ3EOhYFZm+Pi?=
 =?us-ascii?Q?S2i1OSPkq/sq3CjLmABExpjoXF6X5esxBV9dN4QOIyvsGx2GxexoMWz0/sOX?=
 =?us-ascii?Q?H44bT8KBAdITHiQPo7bSIZPIWc2b3OtKqqL12W+yS90/cKk2yoVKhSyVx3n+?=
 =?us-ascii?Q?8XZqk6IBnfZlsFEbi2J5A/kIQ7fJkHiGEGUPRxhiFQLU4IglYMR50OeJIVmU?=
 =?us-ascii?Q?IKyxyAV/CwSTB8c1pjrAIRfup9/T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 06:31:41.5130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b590fe0-44ca-4da2-b5e4-08dc6428341d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

Check return status of pm_get_api_version and return error in case of failure to
avoid checking uninitialized pm_api_version variable from stack.

The issue is also reported by smatch on x86 as "warning: 'pm_api_version' is
used uninitialized".

Fixes: b9b3a8be28b3 ("firmware: xilinx: Remove eemi ops for get_api_version")
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/soc/xilinx/zynqmp_power.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 965b1143936a..8570ab1a6857 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -3,6 +3,7 @@
  * Xilinx Zynq MPSoC Power Management
  *
  *  Copyright (C) 2014-2019 Xilinx, Inc.
+ *  Copyright (C) 2024, Advanced Micro Devices, Inc.
  *
  *  Davorin Mista <davorin.mista@aggios.com>
  *  Jolly Shah <jollys@xilinx.com>
@@ -190,7 +191,9 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
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


