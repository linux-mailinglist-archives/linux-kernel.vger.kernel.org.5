Return-Path: <linux-kernel+bounces-21904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5254C829672
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1645B24FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343B83EA9B;
	Wed, 10 Jan 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eLG2in3T"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271D3EA8B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVnQnbFO6L82E8sRMU93S3jm5ePWrcqQ3C0L8frX5rIvwysHQti4Qg70q2pmXDHB6NrDuf3ehdwQO1iedrdEDkRwYw5KT8VIo75C8yGliXSMkdL7sRPFQdwy64wTxE7eF91K2o0tk/UdG58hp5ORw0YdcpAHS4TSGf7C5aZwB2E7HQXGi/yLZERnPmCSYCFxneIzLcg6Bznox+Z42pm/UEUBATsA8bNhAgX3YQEA/ilJdovtF9krKoKC3IWnJltoE/QEJHbVCysI7gBp1Z9q75cm5djzXXj1s8rRLOG64cTDmjVwrdCLBrw4LKXVLBaiSmnz3CxV19f7Kv/TZwihxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlNQyoxzY+Wi5nmdDaMQA5mOdyGEOSzOl0U+uSSPLWM=;
 b=FDIi7uLLLvJIzmZO5hQMKqu1T4vXqHquVbiiEI1g3t+SgV9AZmEuelDFd9O0jH0MiSNOU6pnqHG0/pEqyRiMKxblGPTJSOlM5Msto2EF/7T4aiLETr2yzSuQTmSbmZmbr2muX63Gt2+iC4iqZFTDyR5dF7G1UbPsOjYMt8CJ9tWgCpyjg3H/bjYmkFSc5Ohq8imqM/lvgz/L52aA+7I4bbdSg0RqE22t2hmYBMJ1e9/X8KCN94mCsBFHvbtVNDAzGPmbBtZT6MN5ELAE2HWVv83mcJ2HNTo4jG6ntQPCG7i2akXX2HmkvUcAPjAf8/VFaQ1x8/THJV4yT7g7Pb1yAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlNQyoxzY+Wi5nmdDaMQA5mOdyGEOSzOl0U+uSSPLWM=;
 b=eLG2in3TvVt2QijxDLedti/N4RwvDKle4mTy8As1Yq5I2RNYs96piI3PPvpSkl9ozMABs9Sd77QjzrSGEyqHMR6awYbFPNxwRGKDBrML+JDf8hAwB3zmQKLC2u5vHFWwy/nCwApsfKnP2w4elW1J+Xyk5rDMlbJooN7BSsG0EYk=
Received: from DM6PR01CA0014.prod.exchangelabs.com (2603:10b6:5:296::19) by
 LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 09:45:16 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::53) by DM6PR01CA0014.outlook.office365.com
 (2603:10b6:5:296::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 09:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 09:45:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:45:08 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 10 Jan 2024 03:45:04 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 02/13] drivers: soundwire: amd: update license
Date: Wed, 10 Jan 2024 15:14:05 +0530
Message-ID: <20240110094416.853610-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 6782c12b-8211-4e19-b834-08dc11c0d98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PixZ8LxlXxLdSU5PnPD8tp2p1QpAi8ZB5n5BFyAgonfZFkSp/J+J3ozxVbLX1JE0li4l9mOjPHUUmuUFEiL9XhdNAiXOJy3m6aVzmfvgAiQW1dAYIJ+BntktAtJ3uv1fkzaGQ91OQ0pFZnND0uIiw5aKJyZS5eGQX3Db3WKrlz+K+/or8N0WfKLrN4O91JqbvvZoZEwTVjXmC7bMP/DLXeyvD0hWnXea79ALPfOy52MfxblB9DUutJKYuqKNMdVSdrHz/WgIjbMmTcG9XPkgiLs661hKdcYHcYsYb6cnTLYBu/GsPr7Z0KUIsDIQBLmPEGGTRYFwF9YnveJf9I9zJJRsDSQnz0V65wbKH0HX9im9mdkzyKczSoUS7WF6fZTeLOtS/z9rRegLSlAbU7EZIATEGyDFRg7cY3x/Ms61vWOU8BgJgEbx0EquCLU0keTg+gG7ZS6hxMo1XgbRdc8SyUBEKoYKUm/1W/wlvRf8eRaAUz5LGMDjXVb2xyFpuyYAUXPGcWY3LDGJqDB+pRVgUNsOVY2jKK1UdHzdxSh3xO68uysS37eYERbktgjdSMb6fxcGvWeryqDViCJ/oaTQYuAqa4BH8VkPBiaCIsT/fG3NdVi5XoufsZGyVCWsLQBNr0NKABWpjSE0lpzy491dGCk8YwWS1fI27V3LJxb3OMcM/xP2/zxvHyFL04m8jA1+4CinNgKEXzFz1oATptO/9KiQuqhaVEli0HkyOPhMJvq7rzu7CxFW3zlf3vQ0fg/fLFA4mvhLmIoxnxjoSPf3jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(26005)(336012)(426003)(1076003)(2616005)(82740400003)(36860700001)(4326008)(8676002)(5660300002)(15650500001)(8936002)(41300700001)(2906002)(478600001)(7696005)(54906003)(70206006)(70586007)(316002)(110136005)(36756003)(356005)(81166007)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:45:15.9970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6782c12b-8211-4e19-b834-08dc11c0d98a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

Update license to dual license to align with Sound Open Firmware (SOF)
driver as SOF uses dual license.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c   | 4 ++--
 drivers/soundwire/amd_manager.h   | 2 +-
 include/linux/soundwire/sdw_amd.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 3a99f6dcdfaf..afa2d83b7e69 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
  * SoundWire AMD Manager driver
  *
@@ -1207,5 +1207,5 @@ module_platform_driver(amd_sdw_driver);
 
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
 MODULE_DESCRIPTION("AMD SoundWire driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 5f040151a259..f57165bbb9d9 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
  */
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 41dd64941cef..56b4117c087a 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
  */
-- 
2.34.1


