Return-Path: <linux-kernel+bounces-111042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CDE886741
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E531F22BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3FE111A9;
	Fri, 22 Mar 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UOSQ7LQb"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725E10A35;
	Fri, 22 Mar 2024 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711091044; cv=fail; b=ge8Z4hIBj+YUHVIPRn9FFfnPubOInDz1DBoFN2p21aSGmuS2PW6XK4JOXGhYQae1OvRw8BUMLc9qICdBKd7stj/HTlOGTisTyoZ1u5v7b+qbzH1j2gabHjAZaJL4sz2BXfJnvh+1OpmtRoRSdUZ0VGapqaMJ5EuZRVs1yEZU5Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711091044; c=relaxed/simple;
	bh=8kQEDYEW9v1tqSrqRvEKCnJox9KK2bCHALbmILJsgDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hJZphM16u+pE3pK/cH27k0I5ZO+0zqyYtpud51/ulVWux3hndUDeNPJnRv+YhkdkrubGstAeOgruGTUMTy3zJNkx3gxIt/g//sdMeAkFS3kZbCGs0StyEof1BfOjA5vQzbqenM3vRViyiqyDRa+E7OJgBRpbpJX/fSkqXsTzvgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UOSQ7LQb; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAlsv/SVOByERIiiZ5HynI79mYXbx0wqnxwCmrGqn4ka/rurJ2HBlZ0q5DTLd9l4Aln49dTq02vTdWnijISRy4vwV5VZGwr5r4FrPo3cBreBfC9M7W2j5D2pDtm/KS2BRs2Xg09VREq3jzhsdKC1iCXNwgyf/1BuYGPSboGcN95bB/39aJ8R0rLITzWJnrz5N18uSEJPgmRT6wd82gvvQeEXA4GnzN325lTG6K+WYoWaqFknExZUULohDG0wFHXImflMQk+64SYP2Ip3H++01sI2Ycn8p0c5n6AiPj4Fj9tmeWhKI9K4yuoJONf6usb2oFDVvOJpsFnxHHdDJu/lzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvPmvxP4a/imKBh10t3nC3rSrKRULrn9Gq7KSQ9i+KM=;
 b=WalHvZ/6b4fcD4/jhSAoei5nCjogB+8Z0MvWvT+Gy60SRvShb6yPBxqojS+TNdjeVBbddRjigfvoImtfZ+ktHoYtcX0v8K4y/pDQ0CSFNEGaXfRyPEN7T5JOadYAWFpQhW/SUIp4FTVvrf6847noht2q6CfQxgSsv0bfaPE7q9Wa5ot/NFg6shkOHYZY06onGBxvVGWS3GQ8FY/ZVRzh9Lvsauv9zxlYtht/M5x8Mygl2PWI3hOo4nTJVY7IUrjaxTU28so27p3vAN92QWs7EPMBX4zJlHhAPtCHgniz6u5l2wegtF6h4HT+yQHMxdcF+h60IJUqEs580k7rbE7zhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvPmvxP4a/imKBh10t3nC3rSrKRULrn9Gq7KSQ9i+KM=;
 b=UOSQ7LQbDaBhtY3MdcFoEOZ9X+EuWO24sDStvQ6SitFX/YBrWvdbDLs3csJKMV29h2aEMMv92wDRT4NrV6RURhM7scKtekMyN612kFSc6ir6luiXUACa7KCL5J0Y1XiMGKqqbZykGnwbEfThaP7TnfjRv7MkG5Vm22apLOAnwSE=
Received: from CH2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:610:4c::32)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 07:03:59 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::bd) by CH2PR10CA0022.outlook.office365.com
 (2603:10b6:610:4c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25 via Frontend
 Transport; Fri, 22 Mar 2024 07:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Fri, 22 Mar 2024 07:03:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 02:03:58 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Fri, 22 Mar 2024 02:03:54 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <venkataprasad.potturu@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<arnd@arndb.de>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, Lucas Tanure
	<lucas.tanure@collabora.com>, Cristian Ciocaltea
	<cristian.ciocaltea@collabora.com>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] [RESEND] ASoC: amd: simplify soundwire dependencies for 
Date: Fri, 22 Mar 2024 12:33:50 +0530
Message-ID: <20240322070353.2367300-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: fa043dbe-1a8a-49b7-05f0-08dc4a3e3f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dCMBYO7kjwhZr/0OYLv1t3RATRIba/Fa7xof3ePJ3GC6r9Pk0yyQmZ3fslztpHVeg0AK8Z4VRTvKOcVWubI5Ll1/dlR/Dy8PveKSQw8FuUCd6nD1gS9idMW8vksPir6ZoiVkUDVs+h2oEmGRGq1q4fdSs78aFVQU5r7Q6yvHnAqbcrQBixPtkQp0NPXvMG6jP2X+gG2rjX0Za4dnYpg/btEVaeh9Qy2iAC+V/y9/bcy0jPIYmdIESHTRo62IklSuFAb3X+/uyqne69Jd6kxderKfKtkoPiJVO+cV6U/fVrgStUJIXjmNOna4x0kBRRPdYA3AEWeU07vmaDREaEx5foJJyusIxFnZPm29MuuxD5P5gBWTmeXesUGjsPxS2m+hNh0Jf0esl/Y3VpcZHZpNVLsNGiqLCWf8H+uXB8qjHsbRhxpNOO3GSTF5qow3Q7sUl4XXLvEhzLWqfrY4GGHdKWhfdR4DOzW5m3/sbPhqsxNrBdKnZeiE0h59WqEyKq4R4VO2pXRw2H6gJ/cK+P+g6ceiuCVM+TVupwoZx9n9go+IksoZI627Guxp5MfZRKK8IRxzOS2cS0sQ7mritXMVHQS23/ozHfXmiwEM8lhV4wRQTzLf376acJZL+aNnfy1awJ80327ZGxIlkf+HiJyQOKFsYTAJ0jRK4O/hYJQCcDS61ruqxG/HXHGUdCcF5ggAqWwQTza7XG1s1Jc88qWhmlWlliDgQM3BwK+m4UzQ430LFkYioFi1NW3bLKM/g2na
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 07:03:59.4367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa043dbe-1a8a-49b7-05f0-08dc4a3e3f96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

The CONFIG_SOUNDWIRE_AMD is a user-visible option, it should be never
selected by another driver.
So replace the extra complexity with a normal Kconfig dependency in
SND_SOC_AMD_SOUNDWIRE.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index fa74635cee08..3508f5a96b75 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -134,15 +134,14 @@ config SND_SOC_AMD_RPL_ACP6x
 
 config SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
 	tristate
-	select SOUNDWIRE_AMD if SND_SOC_AMD_SOUNDWIRE != n
 	select SND_AMD_SOUNDWIRE_ACPI if ACPI
 
 config SND_SOC_AMD_SOUNDWIRE
 	tristate "Support for SoundWire based AMD platforms"
 	default SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
 	depends on SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
-	depends on ACPI && SOUNDWIRE
-	depends on !(SOUNDWIRE=m && SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE=y)
+	depends on ACPI
+	depends on SOUNDWIRE_AMD
 	help
 	  This adds support for SoundWire for AMD platforms.
 	  Say Y if you want to enable SoundWire links with SOF.
-- 
2.34.1


