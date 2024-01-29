Return-Path: <linux-kernel+bounces-42198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA983FDD4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6321F21529
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00614C60C;
	Mon, 29 Jan 2024 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cD5GPc4A"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D44C3A9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507549; cv=fail; b=bVGXbJtq6LSieGyabWuABWRfAGqLvh0uuRALvV7OCWgPmFDZinY+n0xeRpZf8l18W5GI32sl8Mkn0q7IeaRimXT6pLjskTOiv4Wwe+/GEHhr3ufRfvyBjqcR9Y/dvMMMMUscBkm8IQuNhDprxdpsAX7FXYVbzY8pY+/aYvbBCqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507549; c=relaxed/simple;
	bh=TWAJUAlp8odwyXYtQC8qnnEUXeb7+qTDmg4yu+xupso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MM4x4AwupikkX10LOZ+jeFO3UdcJ8CVtdR/CM2Jgd2GW8whsFEHyC4AEAdLoZ+hebbAfW2F2YxfouLSjXd+QTqUdTwLbEl9h0ofeBOdIfSAhaImF9B9RwNCCOWQs1ruQoF+/aUKRCFcgfByXcB4lArLotX/awonEHDZ+rigQajI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cD5GPc4A; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp7KNEVuzZ+bz03ZGrgGRF2picHWzexXBkfR25MZD/RaVK5V17NYTed+GT0Yg0o6y5uE7diBkGkdI/YdIfuuj2bmSMimemrL58TcPq7XMnK0QlLpacjFF768ZZEbzMinpYyQviKrwypSf+LhiBPraETK/e952cqqbx2YmW54Kl4xXs0m5AibK8OMmCpZcOuFiiRCqcy81d4kI4dxXPOQzNMo5qFe+QFf0flOOqJtVoQePqJfJj/Qg5lJT57A38cFK38JrTCFdsbdnWeP3+O15GgzYE3avw1wgxEF6TxVQd+zOjLG+K7Db3yRotVs/J/+FiB7szXQgCGVE5acoSZtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q16wMUHq75VT/TAcpIKBp8489nmAekaVEEG4tIkUFXA=;
 b=VTYTLAeu0Bw/JbZxaVXi7DbzCOMoZOh189gOJNy6DCx9nCBkxcU11Rld51aNtedp7phknAwwR1Jj+NKAyXVy6n3R1OUqCEY1rKanyh4lswJ1hL0ExYtSQYhRtciTbrkx2JbHnmYghCwqHsJbtLHrjSDbOeeWmrolEPX4HndhoEKtYjO8QcTVzPpGcEVhXTVQ+Q937Mah/oUtHRy6jEkhIm2Ie9N/vhpo4AG9ClQj8cEYF3XWUqF51UkTTDL2E3Xy/t+mx1N4KHwnYX0JyM9w3HcwZgTi0miOrFOQWi+9DNDT9yhE7QgL4Esf15ojpEEF4aSSTES2bt+6ijNUGETBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q16wMUHq75VT/TAcpIKBp8489nmAekaVEEG4tIkUFXA=;
 b=cD5GPc4AgtwcmsmUZudM59YjkqEXg3Fwm2IYfOSVz+k6B8yoVpj9Ui0qEpUXCHVafX4Spn9YDFew2wYNDO5Vu1zWS8upBASVd8Rni3W09tTu4kJaWK8Ut0xKY/Y6ONBT4Fbz9WWrdQH1vUdGNSeaeYz9Etg44W5zu1ZwyCvEWBk=
Received: from BN9PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:fb::25)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 05:52:25 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::8) by BN9PR03CA0050.outlook.office365.com
 (2603:10b6:408:fb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 05:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 05:52:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 23:52:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 23:52:15 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sun, 28 Jan 2024 23:52:12 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V4 02/13] soundwire: amd: update license
Date: Mon, 29 Jan 2024 11:21:36 +0530
Message-ID: <20240129055147.1493853-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: a4631d4a-08d6-4bd5-9bbd-08dc208e74f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rlJHPE/7FGCKw7yOZyPN+aDZQnL3WlgAnXQ6dvsWw0MIpCvCJHlFCiOEpU4AEU/PmuuMs98SaXBjXjI53rzhmPgtGijY/mRcbXEc2r60ThX6nzwLEaVk17Bj83b9cB4ZA79mKq6fLbdlRuc8dXcSUiZQ5ONtI26ST4kqV+NraamPOIQ72PB19TQvjE+RK24zg0Gxpeb47H2IKCY52Rie3NYG7+XYc/PEkaj+xTnsK/827+Vy7NipdLS8UsRY/dfHdQmw7DI2iUmiRYSda9GZq1XGC5NllhD4kOyPfeinUs/EqsMquTPmZRerxHeUj8aPSbJUXB5LkpDzYHk/p4NYb+JvITadmmpiwisOCVcWDcR62ELp1bDcWMMyUe/JSl+HmS/N7iA27pmBRZw4A+qvwsuReZd4cS8QRfsgWWPPh3hCmdiERJTTFIUR796TYCmXvZ1aGF+SP4aST/OdiP8WXdlMyJ91ur1nclP4ApR+Y12p/Zd1Myj7SpLQHNDo+ZPeamJfa2XVC1fmwbK9Iyz849M9RvK4+fnfAwXdg5zLaM+GXohptvaplxVOf1GqVaymWYMtSkoM5i2tdF628BuR2Ua694XzdTbvqCYt+Gk+2scmQy5ahTdru14OH54luLPBfsP1C77cXwHHagb9H/47XIkIxrC+rgT+hnYUe7V4njUVCv/xPtrIcmUDRQLz8ZmWU6mPS2tNqqX5SnbwdoscyUP7JrfV1slnqqY/SGKjabzj0f7AaFe9w81BM5Sj7c+anX1Nqbf2WezSxut8CNT5Mw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(36840700001)(40470700004)(41300700001)(2906002)(5660300002)(15650500001)(36756003)(70586007)(110136005)(70206006)(86362001)(54906003)(83380400001)(316002)(47076005)(478600001)(40460700003)(40480700001)(6666004)(7696005)(26005)(426003)(1076003)(336012)(2616005)(356005)(4326008)(8936002)(8676002)(81166007)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 05:52:19.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4631d4a-08d6-4bd5-9bbd-08dc208e74f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

Update license to dual license to align with Sound Open Firmware (SOF)
driver as SOF uses dual license.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c   | 4 ++--
 drivers/soundwire/amd_manager.h   | 2 +-
 include/linux/soundwire/sdw_amd.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index f54bb4dd2d10..f2c66b165be8 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
  * SoundWire AMD Manager driver
  *
@@ -1215,5 +1215,5 @@ module_platform_driver(amd_sdw_driver);
 
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


