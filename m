Return-Path: <linux-kernel+bounces-76327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6903F85F5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B5289637
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B383A1B9;
	Thu, 22 Feb 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RQh0c8Jh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642D3A1C6;
	Thu, 22 Feb 2024 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597626; cv=fail; b=oVGEY8L1oo5WTjqNCzB6obfcwiJLtm2ghg7GANg5kk3fFiFq11XKDGa12TOhuSyriH17FuvF4kOzD+htesrkDFPL44abN511w9NMmYzFKzOt0GKoqaZoFZ4LneagSSVMpzyPLI34nmBOWuN1wgsu3m8pg7t4LQV4zQWV6GVlC3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597626; c=relaxed/simple;
	bh=FKultOKtsTKp2TwITMeCASQHTfP/auhDEPhN5dxj8Ew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u8iZo/MeGM4NFU+4Y78zhSAsnweShLRHmPVmaP0x0rKW1Ci73nSPyRyAPw3Rhnj52rIgFtS2KKyBEp7iHoctNv/7NcHdCuekRSDymIuig2IaFNgHUulvOB9LrUktg/4j7AiSO9p5EwHxUKstQJLSKVGulCElx/QO3ahwrDfXnAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RQh0c8Jh; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6zy+6ynYw9JyU2CpZcdwzA1RU0kpYBBMto5m1XPFfgiYZF/lz9NQjQeJommD6RP+wiIjT4Qayf3ocwNKp+3kcgwW6aQa5HaF3BBHNztLkxPzza/4H6oDXQHXkggGOiwZo1hY1ZtM1myG5JydW55JQbzzWrmuTGOXFvLyR+S6KMBlVLZmtRwFbYwPKU4TlLO9+DUuu+mf9p76jl4YpnDf6UZxnGNe547ydN5SyIkllBqpaMS11OAstu7egsOHJkULzCtXEFem9raGmnBx7jbVgBk+vriIANRkx1/aXE24opPvf+DDJw2byXu1D6PruhIFrG1wQbUsnG/c4SAhXZZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utQRZSoPuLj8ixvhRGZRozdBRzpUdm7ndmufKj6dyc4=;
 b=PigtasgSaejByFFiDkVTiZH+ETE5ymbQetlKw5090RlZkb1sJr6u4LgUSnKgeeaIsEfU8QdvAI6lGCYe2T9OS0fx2pF5yqLbZCu7gtAg34tlYFTkf4ftX863n0Hgy2Qqn2tA98b5MrCOH3YnYL3J1a65nbx68w3tPejBrt/VRiPV+LdxobO4dLYwXQEJXm5TgkgydVd3D+IeKHyEjFSJ1wjQbh5rbCnMgjFKZ0VaZ5gYo55ERqfRoqQNRVuZAphd3tJLITe+zTVJEMnUl+ivz0DaLpw/2n4YPOEQBKDcRtsUF6uWm99qiqFjJAO9slIjFnhfsan0P2IDj8n2rKNhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utQRZSoPuLj8ixvhRGZRozdBRzpUdm7ndmufKj6dyc4=;
 b=RQh0c8Jhejwri3VkXHpgqVBNm1F5C1s08piYDO41NlYJdLktEAYO/I4Zb7HPlx+lGM11Ajd+pgwSVnSh3p7kTr4nE2czIsyIV0r0sYaZG0OBRcAeLLkTFmwb9/D9uXQx+i3MMh84cK9wPEuWWBK+ZS1saF38qAXM3b0P8v/Y6wk=
Received: from MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::22)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 10:27:02 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::79) by MW4P222CA0017.outlook.office365.com
 (2603:10b6:303:114::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42 via Frontend
 Transport; Thu, 22 Feb 2024 10:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 10:27:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 04:27:00 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Thu, 22 Feb 2024 04:26:57 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Mario.Limonciello@amd.com>,
	<venkataprasad.potturu@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<arnd@arndb.de>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 1/2] ASoC: amd: ps: update license
Date: Thu, 22 Feb 2024 15:56:55 +0530
Message-ID: <20240222102656.631144-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe93a7a-8b79-4de7-ba81-08dc3390cef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G5NeJ6p06hUBFcEf1HQ4xMHM23qT4Tr6CP/NdBvrRrozxFtCJbDSJp6Of+yGTwbjSCqIybxg5xOuzhApWl523iCy5f3rU6Sb2GON8I/3Z3BafMMOGfJVrgaQPOpvsfHXIs1069qwRv3M02A4HtqVkmiRo80tmj7f4/xL/sPSwAYokA7qPOUFAdDTMYXm6NbqTslOF3sbhB4DJ7Miz0TsoqdL7CMOTNVMOj7tGRUNbj6EPkv5wlyHytmTJeFiMa5FutpK76z8o46I8YemgBzCNKAiGPLYvkD4uH6mJ8/IZBIIdhXSwbeLA2gIcEdaTSNZ5K72az42lX2vqFshwUFz9pu2TVH+uq8N0/JKtsE5uA8QiI94q5z3gtq2AyDjIocPFxQXx9DYN/y7xB1psAopFYFzV1DiJ4GytxJAkQZ8ritHEPwqWdqrfdGUJleHKy5U9j3HWwibgyTqRzGQf8TXbYjgeFPRtWcQ4AjLX6xhINzC4+JGLHGxy6AfVDe71nKNAZHw0BmVEh/138/61Ixfv06b243w3mXm+LUlbsPsHdHyHPwS3OAzH3TlI45OagFbkmyQDMUPK53sUpYXTkph7agZxwnidHw7Ftbwp8PQCJIyHPJ2flvTgcHxX6yxflCp/xAIbDOpX19nfYmk5uQkVnIon1T1wDVz7agcAkNXkWU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 10:27:01.8551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe93a7a-8b79-4de7-ba81-08dc3390cef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785

To align with AMD SoundWire manager driver license, update license as
GPL-2.0-only for Pink Sardine ACP PCI driver and corresponding child
drivers.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/Makefile     | 2 +-
 sound/soc/amd/ps/pci-ps.c     | 2 +-
 sound/soc/amd/ps/ps-mach.c    | 2 +-
 sound/soc/amd/ps/ps-pdm-dma.c | 2 +-
 sound/soc/amd/ps/ps-sdw-dma.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/ps/Makefile b/sound/soc/amd/ps/Makefile
index f2a5eaf2fa4d..b3c254886fd9 100644
--- a/sound/soc/amd/ps/Makefile
+++ b/sound/soc/amd/ps/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-only
 # Pink Sardine platform Support
 snd-pci-ps-objs := pci-ps.o
 snd-ps-pdm-dma-objs := ps-pdm-dma.o
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 205bca95aa06..c72d666d51bd 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * AMD Pink Sardine ACP PCI Driver
  *
diff --git a/sound/soc/amd/ps/ps-mach.c b/sound/soc/amd/ps/ps-mach.c
index 3ffbe4fdafdf..e675b8f569eb 100644
--- a/sound/soc/amd/ps/ps-mach.c
+++ b/sound/soc/amd/ps/ps-mach.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Machine driver for AMD Pink Sardine platform using DMIC
  *
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index d48f7c5af289..7bbacbab1095 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * AMD ALSA SoC Pink Sardine PDM Driver
  *
diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 9b59063798f2..66b800962f8c 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * AMD ALSA SoC Pink Sardine SoundWire DMA Driver
  *
-- 
2.34.1


