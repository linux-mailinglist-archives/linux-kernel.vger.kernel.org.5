Return-Path: <linux-kernel+bounces-7954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540DA81AFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4300B25811
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC41643D;
	Thu, 21 Dec 2023 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aIB8VC8E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D9446A2;
	Thu, 21 Dec 2023 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtSm4O9WNekSyKL60PjQqIeOjuy6JX65pw2k9doB5Ik85u8IHTYPWLeepPEUcT0qCopBpFs9sUa4+B3cZ0AptoWqTugO2+KryZBVHcuzDPNCtWN9vmBYiHxovapDdXlggddVU2xtAAqZ9y24qG5yWKDBqkKzu3OhQYgWWQaSu4CA9WLtNbVLa9hxyHU3HBsav2zwUL+CMlzxBaal5m50Orw5rtol/2qqFJERXu71KEP7hnyGSZmIwayPppZwU6rYZyAC7dNCK8G3X3QtxHwGxinBaNYhUtGnZFFm29mN38lQBL8vDLVS8VmOZPkawQCWpH5uVd3BMaTdzChle+1nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtvoCZz8VSf1VRSZDCxvonKGlPrjlVR/2Z+SSopunkg=;
 b=SE8MEU31jUowFh0ahUYPPluhWpKF3frH+mnUJL7LzUiZgQAQwQ4bna0qe8QprmuzTVGnunwb77cqNf5ou2cies3EHnRULk39ZnDHMmM08Mr+mo/8l6rF3WYOwcIEaxE6ApQQiz0Vib2nGF6+PvSIarRl2NhdG+YR56UV4zc3j+BB6WAl7NxvF3sq6ghSt7x96DY14XY//BR+MUwta76e+psM0O84hl6bKHvqlFmvo5UI7kSV3gzCJ3DkNQPFLsosqwip3OwJST4gIa6AODTh6oDCAM6nhKcUPFJHS8olCVTB3muKquQjJv9f41UvIxXJ5MePg+8Xy1hzqLguith+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtvoCZz8VSf1VRSZDCxvonKGlPrjlVR/2Z+SSopunkg=;
 b=aIB8VC8Exjp8qTFU7tOL8tZ7ItNPAlYa8qn+gONbvmeCG6ZEhLmwdRoIR+tdDeVmrFfxxKNCfvpc82qf1eXtpt09jaVmiCpluBk8Xo6GfVSYTqbMFh8aDxPCY3sxxUsfEJUXUJhf1oc7XQtVVe3rsdLzbKmfR8vIOo6yJ5sObFQ=
Received: from CY8P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::12)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 07:37:59 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::99) by CY8P220CA0028.outlook.office365.com
 (2603:10b6:930:47::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 07:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.20 via Frontend Transport; Thu, 21 Dec 2023 07:37:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:37:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:37:57 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:37:51 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <pierre-louis.bossart@linux.intel.com>,
	<vinod.koul@intel.com>, <venkataprasad.potturu@amd.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, "Peter
 Ujfalusi" <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, Mastan Katragadda <Mastan.Katragadda@amd.com>,
	Rander Wang <rander.wang@intel.com>, "moderated list:SOUND - SOUND OPEN
 FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/12] ASoC: SOF: amd: update descriptor fields for acp6.3 based platform
Date: Thu, 21 Dec 2023 13:05:56 +0530
Message-ID: <20231221073558.3181911-11-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: fa26796d-d5ae-405a-a296-08dc01f7c164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z79PAJLc0vkq6lpUnf+yT6OVMZrIVAlalyNPxwv8M6t2oFB0bGInnONV0fjbwltQ07Trbbw5CW9stSt7JcjpOtPKvb7lTVE/sRhlSOkpO57VtIdSPc6mggjuE0pgaB2BZph1fda1XQus1Y7TIRtHIo4tGxv07jdv2WVLVTM2d14U+0TbfOVrUwalTE6JsmBFUVTODQmFIJVv2fvEvpV/03EwGlkgnj01YxJuVG8VKoJYm3z9Xb9a5hOt/bKdJo3uXD7Lwzp28R6EcnZH5Z6KMRtaILncVJKNjPcwFCDFmXewsisM9fjFkYAcalwLvm8YpvML9YA+/t7Kmm0jGMIPcLpteT3sQbu4xweL06JwU7n1nv2UWaS4IR4HGQhAHhU1D0KhbwVE3RIpKFjiUTRgBOLg4VDs30kD2pFbmlRHmAboxzHroaTCJb9u4bjhgyGx3y5SwxeoLvNi9qVZDNmyyMbWgU50hXvJtXkyKBDlombRACznQYwd3nwOD+5dySFejWE84WCUEcC8V5RQluFiriSTfGUkHcPNiMjKAEBZSJi2G0tAGqpoIGdHd/MIfGnb+ARrdlcakYjGJhqH7Mv46d/OVT6kX9IPTK8tBnWsUdK2kXq0xz1NJmISE98UIIh976cZACcjbN3L8PCbkOafyL8NzJBORmyjuZZ5XFZRiy0DiPYifZiRIMC9uzZHZfSrR/qtTsKl1rvwnoa9KFomO/cQq667jtc3H+iFEUEoziepIIW3ODWCR9CbDKF9WL4VY4YFWSsG6F6LanQY00DbBalLf0v7LVzK4FHe4sN9VcN00PBOanxKttWi5Zyh/wy9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(70206006)(110136005)(1076003)(54906003)(26005)(2616005)(40480700001)(36860700001)(40460700003)(478600001)(83380400001)(8676002)(4326008)(8936002)(316002)(336012)(426003)(7696005)(36756003)(15650500001)(7416002)(47076005)(5660300002)(2906002)(356005)(81166007)(82740400003)(41300700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:37:59.1978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa26796d-d5ae-405a-a296-08dc01f7c164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

Update acp descriptor fields for acp6.3 version based platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h | 3 +++
 sound/soc/sof/amd/acp.h            | 2 ++
 sound/soc/sof/amd/pci-acp63.c      | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 7ba6492b8e99..c1bdc028a61a 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -65,7 +65,10 @@
 /* Registers from ACP_INTR block */
 #define ACP3X_EXT_INTR_STAT			0x1808
 #define ACP5X_EXT_INTR_STAT			0x1808
+#define ACP6X_EXTERNAL_INTR_ENB			0x1A00
+#define ACP6X_EXTERNAL_INTR_CNTL		0x1A04
 #define ACP6X_EXT_INTR_STAT                     0x1A0C
+#define ACP6X_EXT_INTR_STAT1			0x1A10
 
 #define ACP3X_DSP_SW_INTR_BASE			0x1814
 #define ACP5X_DSP_SW_INTR_BASE			0x1814
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 2058dae32659..e94713d7ff1d 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -96,8 +96,10 @@
 #define ACP_ERROR_IRQ_MASK			BIT(29)
 #define ACP_SDW0_IRQ_MASK			BIT(21)
 #define ACP_SDW1_IRQ_MASK			BIT(2)
+#define SDW_ACPI_ADDR_ACP63			5
 #define ACP_DEFAULT_SRAM_LENGTH			0x00080000
 #define ACP_SRAM_PAGE_COUNT			128
+#define ACP6X_SDW_MAX_MANAGER_COUNT		2
 
 enum clock_source {
 	ACP_CLOCK_96M = 0,
diff --git a/sound/soc/sof/amd/pci-acp63.c b/sound/soc/sof/amd/pci-acp63.c
index bceb94ac80a9..eeaa12cceb23 100644
--- a/sound/soc/sof/amd/pci-acp63.c
+++ b/sound/soc/sof/amd/pci-acp63.c
@@ -31,12 +31,19 @@ static const struct sof_amd_acp_desc acp63_chip_info = {
 	.rev		= 6,
 	.host_bridge_id = HOST_BRIDGE_ACP63,
 	.pgfsm_base	= ACP6X_PGFSM_BASE,
+	.ext_intr_enb = ACP6X_EXTERNAL_INTR_ENB,
+	.ext_intr_cntl = ACP6X_EXTERNAL_INTR_CNTL,
 	.ext_intr_stat	= ACP6X_EXT_INTR_STAT,
+	.ext_intr_stat1	= ACP6X_EXT_INTR_STAT1,
 	.dsp_intr_base	= ACP6X_DSP_SW_INTR_BASE,
 	.sram_pte_offset = ACP6X_SRAM_PTE_OFFSET,
 	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
 	.fusion_dsp_offset = ACP6X_DSP_FUSION_RUNSTALL,
 	.probe_reg_offset = ACP6X_FUTURE_REG_ACLK_0,
+	.sdw_max_link_count = ACP6X_SDW_MAX_MANAGER_COUNT,
+	.sdw_acpi_dev_addr = SDW_ACPI_ADDR_ACP63,
+	.reg_start_addr = ACP6x_REG_START,
+	.reg_end_addr = ACP6x_REG_END,
 };
 
 static const struct sof_dev_desc acp63_desc = {
-- 
2.34.1


