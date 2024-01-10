Return-Path: <linux-kernel+bounces-21918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94982968E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B840FB267DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC7A3F8D9;
	Wed, 10 Jan 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DEe7Kq68"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B6405FE;
	Wed, 10 Jan 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8ZMu3uagdlflN0ScPApa1zccH4mXzmZIHpt1Ke/r/W9/QuFhuN6jggsaxcdZDePturaAfMZ/ESJepr+Nr7NZUjSeCRGq+yK02Tg/GvxUmiXozLI4UskdPqZRGCfM9MqbPFAEnp8N63pL8mjGmlAXncotItzlbgn7HzsKezNlt8vbsHVAWaK+FL7ue1CeVgcJAAiEM6oEtIuEaFy3qqLOMXLHh9TOTO9XlbHAGTOO44ZZF5I5HB4NL5D2X6syClghdr2vjSsmTaP4+27xRj8dnBfgytLS3WISSTchyfTvWgfr4+OyryGcNSyTnfxJX2F1JzmTeOxMJymIgxO+xDOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM5IfcLFOV5I+4SsS+sfeBeWW0qVpPfMyKw8GVqZb7k=;
 b=BmWLAqb+7dU+LLVs66VxTcuwCrnHzQmrTnnZE6yqqz+D5IobUwwkc7yzVGWvLuvAHyZm5DkMhU9MYnLcwvO580MMlMKR1BkSa7TRTkg/Yi/HQ1rm4D0pRoyxQsvgLsgHS1KEvo0+tv0SnINExADf3r9G+jD1wY6nMlSBtKGmZOAkBrVz8hRvxmgLhd/YUv3oEoJ2wHYp21tY+sFZlq6Oc3o8I1PFHEJxyt+1oW6dvtitt/Eef0BHE6/NbK9XOHMuyn3XZqWc9HZlQLrlufFKXfCYNS5TU0yzUSeV9k3WQCWAwPDwbENVze8r7QWfedZ4O37i44o8x3TMivgTS9jQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM5IfcLFOV5I+4SsS+sfeBeWW0qVpPfMyKw8GVqZb7k=;
 b=DEe7Kq68AP5hEJ11QRJ52N9mL5t+Opx905s5/wvNDV/MQR8Pwm0/rWovwNF/s2wKMfrqxjcD2IikvQuBrOOPXk8fhDtKINuQoqccXU/iTQnYzPNCL2Aec2SS0oRAW/0fGcsZbUOZk9iGO2oCEjGYB2RWMCoRExBL7XITuT6XYSE=
Received: from DM6PR07CA0131.namprd07.prod.outlook.com (2603:10b6:5:330::19)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 09:47:12 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::aa) by DM6PR07CA0131.outlook.office365.com
 (2603:10b6:5:330::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 09:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 09:47:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:47:02 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 10 Jan
 2024 01:46:58 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 10 Jan 2024 03:46:53 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, "moderated list:SOUND - SOUND OPEN FIRMWARE
 (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 12/13] ASoC: SOF: amd: select soundwire dependency flag for acp6.3 based platform
Date: Wed, 10 Jan 2024 15:14:15 +0530
Message-ID: <20240110094416.853610-13-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 805c36f0-8ac2-4d57-79b9-08dc11c11e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Djy2Qtdk1kMoPrb9Z+HjmjUzOdV9gVrBQ26Dil0Bgzh0Hh/nYppN+i1T1HlVwedYlYv3Or8lc/20abcY9Rn5D8G59/hozMdp88Mph2UOjdPtDjmQaNUL3IRWitlGYNqrT0gzwIIClWuVlJiJAq8r8AdxtzhCuV6BQr3uMmTeMCcPVMRD1Eqio4tMmGRBVmuaEqXpOGjGJZ69eRsGzvFMiGYJm3oGaWiHiCr7HkwLASY1zL34Ezf9TLHtj0m9nD6S5iy//inPgOJjm4mqGWVbMlOwT92DUNpmMYR6Gmlo0i7B/oPKJMe8FlxI8hcoDc4Mcje9O2y541OwrkgMKoEMJvXDUFlZ564z35GLAgtKCj9T6lM5N4BvYZFm605UzNTWdFQXwnHDnexwyFpm3FdKsgZACow25tBL+RUoqlm7HNR2blkraVRNMzr8tisNYN50tIQBBqy1bxJ2LUjtIfyfUBRDZNBL/Use4Zyf/GNuHL6yuec2yNlxiVUOW+z6x220VaWqHKdm0N4OTclq732xUyTfnELRndO7WNduvGHYEodYQkUCfL5r2c/GYaZLrwbWxX0cKHTJqMWIPdGbwMAwVDmc1ScoevKWcJgxLx/W05ulTDRghbs6cD3bCww2yQA2ULmL2i2uybSwfjjv7clDKxFjmHx4I8uJDncm/xKQ82hMi8FaCi8nEkUQsJe4scluJa2Ih85gPvV0upFivIymgmuvrfSi3fOyoCymGOM80i47S9zdg4CqYTKuI4XO13LTJRpJU22VNmh5dtoe2LZMaw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(4744005)(7416002)(5660300002)(41300700001)(40480700001)(40460700003)(336012)(426003)(1076003)(26005)(2616005)(36860700001)(47076005)(7696005)(6666004)(478600001)(86362001)(81166007)(356005)(4326008)(70206006)(8936002)(8676002)(54906003)(70586007)(82740400003)(36756003)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:47:11.3871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805c36f0-8ac2-4d57-79b9-08dc11c11e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897

Select SoundWire dependency flag for acp6.3 based platform for SoundWire
configuration.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 1cea1d75130c..c3bbe6c70fb2 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -81,6 +81,7 @@ config SND_SOC_SOF_AMD_ACP63
 	tristate "SOF support for ACP6.3 platform"
 	depends on SND_SOC_SOF_PCI
 	select SND_SOC_SOF_AMD_COMMON
+	select SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
 	help
 	  Select this option for SOF support on
 	  AMD ACP6.3 version based platforms.
-- 
2.34.1


