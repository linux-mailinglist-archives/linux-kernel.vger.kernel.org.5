Return-Path: <linux-kernel+bounces-155616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C46768AF4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0CB1F236DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C8813DDAC;
	Tue, 23 Apr 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mJR3sRrA"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7313D8B9;
	Tue, 23 Apr 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891790; cv=fail; b=t6S+dTEXJD2EqJirdiZF0ulboKE0l48V2vvPAMI5O3i1C8pp3c46NIGImi3+hRkMONMan3vfzjb0npF5EsfdtSAZZ73Tr4zT20IW26Aalar9Gwp3g6IdW3PJJeJpRHNoPg1LxKHaHVvWw2wc7fjzMjFK2eLqbpTp+EKiQuoLL1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891790; c=relaxed/simple;
	bh=iwuTuz5bePMysFQar9rpkTJLiXInLrDemg8z3SG1PwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ht1RVanwH5WXKR+p4DkiSGDuYyCN6YgSSG6rWTxrWxCRy7b4EqsrAPm9fEuGCCfcC+IQz2y5m6uaFxhNxhutGu2LBOqaJjvvAD8+BOzJei94cSs2X1SHr/s18xCObdskJVS1gu4RkecdYxb2+K4OleEBZZsOOkG4Za5ob5i6Nns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mJR3sRrA; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fygC7iS4DAc5HnbCPZmMNXflDU4LrICv9wQ9NVsLZTkqN7v7SjzW39++9pvYXLjDjsUiOckcUvawmCSF71iamRyYBrlhk0/OCsCfa9qfaWzNrcCPD6wd1F6J3CRU2ogfNzdbrrp+X5u7hSv5XsMNnevvbNsmNx6oqiapLBB9xHSkwuXBHbfsVKXHjSMY1cUVu0iQqRzuJblLvNZvAEMZtUt8X5pcvkXP2rUbGh1b98UZ/iTtnWqwCbAcC2T8JMpmfuaxLtaJfoz+7T7JZzUYH5zqXf+rKV8bslWuImPI8XrBFUYYWeU8+EHWBOhts6y1jHSb7ZzGSpuXpKQO6GuqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inasnDcjE9yIFjtrMw+cvl05bZaoFfhLxYwkIjGylAM=;
 b=JAJ+ucm8W4iTtx07Kb0OnYu77h90CanXRmuy4hFgabuHlgkcGZOJzFJ7ADWxph57Ysz3T50STJ76IkmNItRWwQ8Qi+AD9Hpamf/AY6Q4uQn32DPaJTLmGf2utnG7k0S2QWgG8LDUtcsfE6hk3Pip3fWLo7CP41EOMBPazHcFbc/PAgSMTg/5rj11YDIIKme7K1ZiqUDKf1h00TEdPsNdnel/ZcPeVl1O0DF1m43hrAI2HCPhKV6sXyvvS8CLqkDGlABLJQlcFsqD3I4IiEP9FHrGAZGqRjKcYAbhQxzmoq4BPQalx7arLgskxxmdgD7dKw1unPKWP/OWHZ0JjJi1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inasnDcjE9yIFjtrMw+cvl05bZaoFfhLxYwkIjGylAM=;
 b=mJR3sRrAmsaYS5mCgcAxFjIyAM+N7tm1o07E7AMRqDQuIBs2Z6DzjoxEJVgZFVcuTH2T8YMrNVE7vHvWDah/7RlCnnjn4s6J0C3TXIvwIYyTAEJxstaigh42zyFDXxUWFnjUfUfed66GAEfWHuxG1Sn4VmMy4I4SXaJ2iEgDmsw=
Received: from BN9P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::29)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 17:03:03 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::37) by BN9P220CA0024.outlook.office365.com
 (2603:10b6:408:13e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 17:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 17:03:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 12:03:01 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 12:03:00 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <nathan@kernel.org>,
	<ndesaulniers@google.com>, <morbo@google.com>, <justinstitt@google.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drivers: remoteproc: xlnx: fix uninitialize variable use
Date: Tue, 23 Apr 2024 10:02:11 -0700
Message-ID: <20240423170210.1035957-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5a1c92-6e21-42f1-4255-08dc63b73cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uCt0W5e+4lIJ2EHbfML4A7cyeuiWqor9sKu+AKu/nKx64gso9j8Q7Ux5t9ZD?=
 =?us-ascii?Q?cTJ5nrLn6oJsj1iBZs2dj7sLHSysKipqkpJ8ayU/fLDZ6i6lysFY21P2tRyG?=
 =?us-ascii?Q?eFMiGN+6Vxz/6TFueQsdFBtxneXBZsgQ5Un2N8Us6ya0EBtlHVI/UVwnSkqb?=
 =?us-ascii?Q?QGThkIqEtzqM8fUugxFWiIE4dwVVWAERPlkV3VKt3sX01MBivC/+EB9tGbc9?=
 =?us-ascii?Q?higLZ4XVv4TTOF5zV2wORGcOZ6GtIVE0WXWUwaBWbBNMmMSKy3BdeEZcVPYh?=
 =?us-ascii?Q?8YEX0MnnJITFXmqdGkpvXah2rlOA75sLydDMXUP75h8vaovp0rjxMXg5qgEP?=
 =?us-ascii?Q?QYd7QVJwwf/mcct2Mi7w3EqGgGBRAl6jNkHQN13Kktb2+NVlFdUYYI1h2N/U?=
 =?us-ascii?Q?aVCXMYNJ+ZcvNBKLa4gxpt5Va4tuCnkxyIAJK4IcIEs5rSo1j1q04nmyb9U+?=
 =?us-ascii?Q?gBWGnPPROcqn9neBB+p10wXmqTpwLrQ1+1hSBF0I1xEY6dZSt22nH0Avxwz2?=
 =?us-ascii?Q?bg1W2fRx9Qnagyh6T4pRXj38TQzsZBS7gnOrXjgqAfuyYr9raPlYrp7/Pk4w?=
 =?us-ascii?Q?bCXqlz8xWw4LpOiSTvAusY9KdjiwIySm672a1oPiwir4HYr26gAnn4DVKUEo?=
 =?us-ascii?Q?FmLDQpWoN0gPIW3+71BvBH6aZUgO9tFEnutu7VgoJt4k8lHwI6MLF5hBEEOw?=
 =?us-ascii?Q?zByijbvWOYNQGGeTvl9UX2DQHMRvlgZXH9QvucLYq6NWMjPWkIxbFvNl+y1B?=
 =?us-ascii?Q?oLxMqVyZa0ld2auDFjXWKzqB9YJiYph+Fqt6ZlQzYOPMm8nFZNxzPnwhvT82?=
 =?us-ascii?Q?il1uPL1BHiBP5ba8goE8zc7kvxK6b7+KDWIEXyE/rXH5cd+Cf11abP1RMV2w?=
 =?us-ascii?Q?OGwp4Kp2aqjqimaGnj8zfqAVZaxAfN+M0Xrbw9oGaxAJiEBcXuZmIejp1YDX?=
 =?us-ascii?Q?2R6Fw97yE8GafXupbyc0RicVjs9uqowHqUAm72kPqCKqMlKbUIOKbcMVHUgK?=
 =?us-ascii?Q?u5tqDeNtuGZ0XYM8fSHgB7K1BCI7AQoJVXpqxPDNskOCe6XUgiwAiVc/r9Mj?=
 =?us-ascii?Q?EdwDrnR5e6GO9K4NueDjHkXrklQX+AYtZ+ZJpeXm60xKFppxPyPFezTlHYil?=
 =?us-ascii?Q?MSUyXCTgD0Cw8MSi6ujCHg3XBcQHk3tNj4rdA2jbHp1YIdKz7r6bXuWAoqEg?=
 =?us-ascii?Q?bvOrj81lwebk2p+YJ0pSU8m4Hj4x1/JbtDRJROSTf1JyQw3pPX8bp5tZvcoj?=
 =?us-ascii?Q?/Rkbx3LzllI3gXGqQXYeUt5PnJB4kbqNkX3rZWHtEuJYbGkdD++rqkFcc+yT?=
 =?us-ascii?Q?oehd8u01MMcNUqhW0aEOgmOf0snMtYoXk6uBbnX0Mogg7B+KzwJhrDeQxFT6?=
 =?us-ascii?Q?ucB1Sfs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:03:03.0204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5a1c92-6e21-42f1-4255-08dc63b73cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880

Fix following warning for clang compiler with W=1 option:
initialize the variable 'ret' to silence this warning
     907 |         int ret, i;
         |                ^
         |                 = 0

Fixes: a6b974b40f94 ("drivers: remoteproc: xlnx: Add Versal and Versal-NET support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404231839.oHiY9Lw8-lkp@intel.com/
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index a6d8ac7394e7..d98940d7ef8f 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -904,7 +904,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 {
 	struct device *dev = cluster->dev;
 	struct zynqmp_r5_core *r5_core;
-	int ret, i;
+	int ret = -EINVAL, i;
 
 	r5_core = cluster->r5_cores[0];
 

base-commit: e99fcac055b3325283d6c5c61a117651fb147686
-- 
2.25.1


