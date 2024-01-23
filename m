Return-Path: <linux-kernel+bounces-35848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1499A839745
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78BD28D137
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BEE81AC9;
	Tue, 23 Jan 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="svlwFg8+"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756697FBB5;
	Tue, 23 Jan 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033318; cv=fail; b=iSDDacvoIUlU/0hx6FPG3A6cl/3volRcO7yIP/uqv1xgIfx2YGTOLnSXUjhqtJeum1N2O1Eg9rNz5IMjPeFhsut1Phxf+HBSCuRWWx4aIqu7GLeEpaWQu7NSarphlQWMAUQaXOlUqtL5Jc3mkkkFKfC1pV0IUx5am7akJcSomPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033318; c=relaxed/simple;
	bh=NLOuwtKuhC4fa3RVhUSOnomdFmVSlHfwSUhjMLfdIzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P5L6m1zDjeXBvLcyxuiqtup+lqMG6+ygD8e+gN5/omc8K/lk3I4y9I4OVoiCPuS3att+bM8YvcNFVtaI4Y6qgevS2fn6BZrSOT5v/7Rk9uV3MoFNZBcpITOTCtwWy3nhArFQ0Z/EKT3FZnSOlKWEN/Dq0NUXwWbTrKMh76KYa5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=svlwFg8+; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0eOVNOuDds/2Z3n9DOa2HzI2ILjjFv/JZ0OywiTWcysUjgyyy6lV+g02YJqW7B/pI0Or9Tq69vM77dfeYygHuINirKMY1dHTuMZHGAjru7yRUdNSZpURBoIupjwqa4uUy7l9sjVD4R175iCv5wfxQq5e20u/Vloo7SQ/3kJfRTC6O42hjMn5tZ8guWFhDoiN8PEzdHfaJKj5XJ+pyNOHM5aCAu96w1LaZgeoaRSsbUJQydhPflu1UAwjXLsoQzZgSUnuiClqcu7C1aSsqWF8OD2Il/GWg8V3y7udHG8fjE3Fi6HRU9Pfq/HPtAP9DJjqawNM+FC/XCHPYxvG/F6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ayDa2qqNziYlYaI9YhclQ8YK5YfbJRfijee90xOYVc=;
 b=V9Hw3nKl4iwrgMvF1yQl+mpFv6NVZHAnlVFB4ZjUOB7PvfM+eUdel+a2hbrts+ehqchUPLKRBzuam1fUQ2KYYXgLjCoRSfwwMSZ+bWB2AJ0m5LHJquQp8cS05O2qbOn2xB6UYPDBLCs6pyw9d9eVk8/r01BWGLpCOfDmRsqvdlWy3yvzRDHMjJbk3m7j9Ren9owedc1USfULDdnE9OiZjbKZ1MEpGRB7KBeEhE0+PUGI1boApbApMB+N3ZVBEn5ynjeuqJqEtx82dAFbMzU9Dv3vH5BgI7gOydeW5TR7OJ66B+AqBFh+H3/f1W7hArNEdtxqtcz/LzM0/glKVtovgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ayDa2qqNziYlYaI9YhclQ8YK5YfbJRfijee90xOYVc=;
 b=svlwFg8+ydDWQL/7l+zI5tv3J0dDq3PbudFio00fSP0/GbP7tkeEnXb1XXDhq0/U1n4lYMkInBv/Win1j61366CC9sKeuBK5ORkp6P4LGP2dx1SM7LV2WbPtow7P9d+KLW/6XfeJh6Erj+KurmdUGG11l7RUddvl1gA7NiSFByM=
Received: from BLAPR03CA0077.namprd03.prod.outlook.com (2603:10b6:208:329::22)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 18:08:34 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::f2) by BLAPR03CA0077.outlook.office365.com
 (2603:10b6:208:329::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 18:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 18:08:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 12:08:33 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>, "open list:PIN CONTROL SUBSYSTEM"
	<linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"Mario Limonciello" <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Christian Heusel <christian@heusel.eu>
Subject: [PATCH] pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
Date: Tue, 23 Jan 2024 12:08:18 -0600
Message-ID: <20240123180818.3994-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 31680c0f-d2ad-4328-e412-08dc1c3e5039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8CRPbGZuIB8yLeHogdgDo734i+bIG+pdRM/hOXTmCceNzbyyGpCoHLarKnn71m8JWn2yNrFIvDMz6BvU2YZOCqHQPjLNpae3vFIKowV2vwMkhdM9o2OePE9isoKvXXgVip9M8ikdnaOKyDoAgq5XD7SkpUZqBpqL52rIXHoK/aM+ksTcM8544rdiiO8dhMeD+3T+1eWaTRGfFOg6EyuDQu00k3284HYtx2AA0POPciRa2oci0Surkv0Ms1fGfvYIxGqdZveOuJFtZSWCBDq18giLiu+7LGr3hJaFJLSgBupkzYhPQXYlqIlx2RoL1iBRgKNRviv7eW4BIQspsqfmGoutxg/v5crWByQItumESYUhHGzl5Seixc/oxOI/h8XaS2OD9rqvJ9N07QhBGzZvf1nGnpuQo/BOdnom0QKBsvpghdydO5KnSKsDeZE+m4++NC9TQRnGHk8IsVmWK96hpyGs3vnG/g9/QyWWVOCehFa51uF5AVF4wyT727/k+QnlMBHRKDtaj/1e/Q59qZd9r7WD+dIVzSwaaHx/WDUfe1AlP3uP9oY20tJy+UEu0wLaP5AhFsYTIEzStMvp46b5+qcTBioNRupzB7jBofeQ7X044LdVCukKk9e+/n5cya0A1X337HUIbb8b6ylD2Z1m45CQ7TXq37z2R3VNNTWCg1rwltS6V6eFWLd6Te+e6JFBTKcvtjRY4QcsWZ6LZdFW23ucC/sPtBMh0Q7PZXCwoxP7+LgdS3gKQwYlVEzmy/ww94s489K4xYvkGfhORMJ52mwYX2uYkHFu3QLyHauWvMc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(40470700004)(36840700001)(46966006)(336012)(6666004)(16526019)(1076003)(26005)(82740400003)(426003)(7696005)(2616005)(2906002)(5660300002)(83380400001)(478600001)(47076005)(36860700001)(44832011)(41300700001)(6916009)(8676002)(70206006)(4326008)(316002)(70586007)(966005)(54906003)(8936002)(81166007)(36756003)(86362001)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 18:08:33.8820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31680c0f-d2ad-4328-e412-08dc1c3e5039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

On some systems the interrupt is shared between GPIO controller
and ACPI SCI. When the interrupt is shared with the ACPI SCI the
flags need to be identical.

This should fix the GPIO controller failing to work after commit
7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI").
```
[    0.417335] genirq: Flags mismatch irq 9. 00000088 (pinctrl_amd) vs. 00002080 (acpi)
[    0.420073] amd_gpio: probe of AMDI0030:00 failed with error -16
```

Cc: Rafael J. Wysocki <rafael@kernel.org>
Reported-by: Christian Heusel <christian@heusel.eu>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218407
Fixes: 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI")
Link: https://lore.kernel.org/linux-acpi/CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15n4gRH48y7MEaLoXF+UA@mail.gmail.com/T/#mc5506014141b61e472b24e095889535a04458083
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index ca4a247c2cd1..6a33b584976c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -1162,7 +1162,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, gpio_dev->irq, amd_gpio_irq_handler,
-			       IRQF_SHARED, KBUILD_MODNAME, gpio_dev);
+			       IRQF_SHARED | IRQF_ONESHOT, KBUILD_MODNAME, gpio_dev);
 	if (ret)
 		goto out2;
 
-- 
2.34.1


