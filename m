Return-Path: <linux-kernel+bounces-32620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D669835E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C07B20844
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327B139ADE;
	Mon, 22 Jan 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mtwvnp1g"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387B3987D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915505; cv=fail; b=K2iiZmmP0KCR2yEMSDgD5cZSlxCMp2PRAVhAfvcu3CJ0jmGCJoJQGCefTyc0t8uY1iwZZ5fMPJtAUSGWdlDthhE8kVlKQ0TAytiFw/FbpoVywdBypjNR76VtqU18ravy05buOo5bMn2qtAuuyV3Vtu7ED89Lw+y270qVOiJEV0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915505; c=relaxed/simple;
	bh=7z13QeROUfU/Amsr7nVs73fALXrwGUWGWRgbui52WHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8UZVrabBrCo7ojJ+zgjjDUFYWEql6aI5TEo9Au7zdJ2EykyoytQ0Xzap/PsiOCs0qQHZ0ZQPZDW5GiZfTskIwwi6M8IBqi0XOiYlsLTCkV+p+//D6fCqBMf/wE+HRKC1ROldxGjnjY2aYYRpVqmdeR+d7s4JgNKmL+nL9PaqTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mtwvnp1g; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxXSEtpVXPbeDW1PSimycXFEiSlOumIZUb+KXxNVUmRwBzofgKtAxiqav+Yil/fauRhhiGR0bfp3YW9j5KE0PGJGzuxhvq2loROJpQp8esFVJNQ2aBohgyFNyFgzuakPiuS0stz8ot7S+A6e8WOTomHk5tZioIdEdnKhDkJybywawb0q3KpmZXe5DtzjO1XPh3nBRI+iLGU0zqQDGNR9bXJ/NcttnsfoZXsv0WdIYsEzM1S6z/EYQ3Q5PEpaVEcQ3s1TMlJ87ZoqB84YGPfYrW/FVDy621WiWG7KH5R9ZyWEpBJzDYgB4lVyIuKDsNv/WEoPUVCClrhniwY4iOZw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlNQyoxzY+Wi5nmdDaMQA5mOdyGEOSzOl0U+uSSPLWM=;
 b=CTb4B49S10Uuj+AUvoLlyM+27FbvPZ5sPPBl94WqeLIOS8dKKGGWso6O7i2jsZNNSNRQ+EYGA0gVH/8J9mNI9CKcYRDLaVWooR/3pM99SK+jS+ZcLxgg8jkcahYFIMDyu46mRl2PxF2Ek9pbGFYXtz0EJH98CuZ3XlOXOzFXL2oeG/Dqwi3J01be1e3l1XHyF/mFnDD9Z3+Lrf2K0Enjbb9eUYQSYibI/Lp/h+Vp13GBhw9aLPPO7wwz8TGjpOL+BCPWJWobTRFhsH94xUeje67HppJ3+xP1khz/UfSTPMQtwqInbpRBKZGeHKM4CGVLs2PuETcR1UwJ5fKM7HeZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlNQyoxzY+Wi5nmdDaMQA5mOdyGEOSzOl0U+uSSPLWM=;
 b=mtwvnp1gq5BAGw3mJoK05eXGkv0R+couvDr0tHVOQlIEhFmIKb1p1NnHEmU3O+CepmSDfatgdSi7FTXR4xrazt4ll4a7z2PWUSR9+A/FYxqzGUNAN7cPpY9OqCD6Qop6mKJPeCqj+2Oa+NhXc7VmLEWxyJX+5vAMVdHkoejN3YE=
Received: from CY8PR10CA0034.namprd10.prod.outlook.com (2603:10b6:930:4b::11)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 09:25:02 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::4) by CY8PR10CA0034.outlook.office365.com
 (2603:10b6:930:4b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 09:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 22 Jan 2024 09:25:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:25:01 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 22 Jan
 2024 01:25:00 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:24:57 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 02/13] soundwire: amd: update license
Date: Mon, 22 Jan 2024 14:54:24 +0530
Message-ID: <20240122092435.3791175-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122092435.3791175-1-Vijendar.Mukunda@amd.com>
References: <20240122092435.3791175-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b08bf57-56b9-4b14-a144-08dc1b2c02d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lv1aJ9DGUCsFjx2xaUeh50orEnNjaU8PMHaXEO3CDmtonxcm7rZs+R+hyQpbM9mFrJ65k6D728oR33VKDC18EJhCEl6/5z2cZeMRm+QyHd+EP2EFVtAhIHVmGNmyCh3WwTSbYQ6xuLF0np1yyWs8xlx1IhT3bfX6lTWtMamDy81EgyYGhqur6DT8Al1eiX0hwXL/LCNeNywAaxURJdoHg6uYNd6df5RQlXkTLnjpYEQgKyzmUjPLljtPRMr2cYYa65JadALwIYQozQkjPSoZFwIeWAX9p8vbqOR7ER7OAT264XEX3h+KIDNZjjo50N9UBZo0Xcs7UPMgE9SBQXeFXqyQzDmFca73yneIZtUz+nR0W4ECiO79xqE1WZuZDfE+YcD/x/flrC+oNezHqbs69CVKCF5gAcMQepR0PQsVp2imo+8VBz3UYoRDGI1l9GHylYhkEuRLLTZfmDypPOB4i4QJ+P9WFcWTS4e2x/DpbH8PCEZGxLfucl4jKVzzCXw+pLpitxlp2v4Ufhf6PjF1Cl5HNk5jzZWukmf/QUXTag1CfvwzjM59GKEQpkUFD9xgxQ9WNEoj1/ATmFupJX2fhve2oxpAytAk+HgnWcGsy2ebgCpqZgQTB0SPvUKBSFi7DSIQVPh73updTHkfzQT5v/q5inzDy4GGoSpf4B3cGL37bUkW62PAw98yL7LdMSLzC7F3D136t6FzZbKjD7faygrcf4u1T1Oyc9RwCEeMZ5qXNW0q/Oy9w86a5gd47076fN4+SKz2taqMI6euyjGpXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(86362001)(478600001)(36756003)(26005)(1076003)(81166007)(356005)(2616005)(82740400003)(426003)(336012)(47076005)(83380400001)(36860700001)(8676002)(2906002)(110136005)(15650500001)(316002)(5660300002)(8936002)(7696005)(6666004)(4326008)(54906003)(41300700001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:25:01.8543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b08bf57-56b9-4b14-a144-08dc1b2c02d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130

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


