Return-Path: <linux-kernel+bounces-32629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9A4835E21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA53284A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3939FF4;
	Mon, 22 Jan 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VvEsQEFn"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FF3A264;
	Mon, 22 Jan 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915591; cv=fail; b=Q0cfwjQ83RT89RkSIBsDRuMqnVbWFWQLhv/aoRDzyoqPob+EnMh/NRlMelM7VYKyooQs6L5oPoPXnUA6AYtfgRam4muQisbMnigNuQO23/23veZEtXIdk8QIepkBg/gFqoRcSxTzvmRh8GsPFmbBQNIxXeBokV0uZvSagEC2x70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915591; c=relaxed/simple;
	bh=ymemvslKkhYGpyHpqh6Q/7RrSZIdxNF0MnFMcoOfCNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0YCyciKlPfnJf+9ZiL/AWw3+5O62vTAnnn3WezipNvRZwzbhu6rtcjbw19R0DTHPx2BaZ5fBBNojWWD4vjKiXyp9ROeutaZ5rRFg+B9tz9awHirpK4f0SARS/bk2OLzFjOUJvmgMLHJFzWJ9zcj5qRpKZ+KMuAHteiysGzm4A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VvEsQEFn; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrVYa/gOKEJPLN5FTm8eBd4gn2hDhEud1vYrUdu0F8dIWKoBHyhtLgbZ8dBcLjKJk3OIagQBcNFRRrsyAfahI7t6X/T99cPNul86pgSDj/KXjtj+8gSxSW69sSWRqR1+B9r5TeN28jWV9TVZbvLCNfaNcNGmvHoZi7dNcOXVOu+0eJm5Y6GeffJnBeN4pUSgmLMe5tB3WuXlV28zSDfYa/znu1BTnaHEQJx3Qe0X4D+fxrf/aTkFp0wf5f+XkhcIaNAYQjuHN9iH2v5khbxOO80iHX3PcKC5jtBvOHfQ7Th7vG7rexY5qXNZR/o+L0U7ZKajuCPDkfWxJFGVDFImiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtvoCZz8VSf1VRSZDCxvonKGlPrjlVR/2Z+SSopunkg=;
 b=OzBftTZBzT9hxmN4PKmDnaBsdwNdTA6LnIYcCvmMJAhrn5MMLCygeXhZ6RgazmqhAWDg1gaLZAULohAJ6fsxDWiYJnVvrk2Z6Ae5guirIKgb1cUkXuCINBemDkXsnTjaJDuJk6Yl9fwIFwICj8Ww4zax0olDJcQnNWPdqWZ3rrhlTdOq14J1FjmBavTMVVttDNTaausU/ZwwVkTCZicfLYrifjBej3YS9UE68WXzeESiNSFY+43S+iEB5I451vSa0kU7qR4LHgX9DLNv6S1izni2CfDux0C8dbKQz4g4aQEEZH2prr/yAbCnIc0Pr1VOfHqbFyim+rJOV5tVvt6AOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtvoCZz8VSf1VRSZDCxvonKGlPrjlVR/2Z+SSopunkg=;
 b=VvEsQEFnQCxbeoplpyosBHcHKHhcm1UvEnLTVe9Rymwd0dhwE7yD9GA5WO+mmrwOa/RjCg9M8UomGjAR8Bje4XBPYFyarZO3VV2C5x+SFn/wihVHxma8BGdPzr52rlVElH50Q9+DGZizE4SwgB0B9gv6TJi9LiYqdc5lybYVd4E=
Received: from DS7PR03CA0261.namprd03.prod.outlook.com (2603:10b6:5:3b3::26)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 09:26:27 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::ce) by DS7PR03CA0261.outlook.office365.com
 (2603:10b6:5:3b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 09:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 22 Jan 2024 09:26:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:26:25 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:26:20 -0600
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
	<Vsujithkumar.Reddy@amd.com>, Mastan Katragadda <Mastan.Katragadda@amd.com>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
	<sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 11/13] ASoC: SOF: amd: update descriptor fields for acp6.3 based platform
Date: Mon, 22 Jan 2024 14:54:33 +0530
Message-ID: <20240122092435.3791175-12-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: 515f1ce4-10f2-40b1-7ca8-08dc1b2c3592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xvkfuzRopq1jcnbeebO2N6B8XbHpeCY05Ch1iBkip/ESuBtnfmlrciky2mt7JPZ3OGMgwzc4ZKhEJxwsA66KQfux3gX1qrxjlqqMwmz0hsNuYqTnzYxDWi/EhXYD70bNrIoR5uy3qdouOxaTKrjp8S4xhRrtIgZzcFeessiklNG3bbShfCfZ877GYDXVJd54gDcevYZJ0ES8+7mAmYxssDB6gHn/DdznnsI/3cviIipVYy4AFdzjJx3+YuOHeTr067pcD1irk92gcVpd4oBrvuOO8yTu5oks257j87h107VqM8lX8jZSIydRchiAZg440ur5dmXojcDeebL7Yiv/BjtjTX/kFmilQoYAdNrNHUOGnQvRhA7FSzY+E8f0q2EBpi25QrmTjzkc1FPA05IpUaT7JrB4xarvLzVm9KHjN/Qsichd5Lppw84gF6jE52jcfbRvQAZUkae3qkqUzTpTUDY/XaSzVTwN889IVZ0kTaXQQubtYbFchAB7wVIdeqvZfGiGwsMZmBxPOSNV72QGlIy/YvAqTzyQBzALCIGgYdqpnKIpTFkIyKUvUpISucitZjUbjb5Kq9iQuQfUb3jVC5SW0B+BtjwmvK2kgPntotK2bhVOBmFhu1qaP6BwxSvHPxSkAghAsb+KDcPRZIbxLYa7FZZO6s/OhNTBL5eFlJh7VoWOZkliMLiK3FDYRAQnSr6vwQCO97h4iz93uvE7VCuygeDBKs2BgxtRMlbcfb9bonve2R8GRqAhaMS+/fskUd7i23jKZNYg4vhauJlyeU/ZpM1V2ALVI2aY1nplAn+iKuO70NmvYUAMxhgyZPqG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(2906002)(7416002)(5660300002)(15650500001)(8936002)(8676002)(4326008)(70206006)(70586007)(54906003)(110136005)(6666004)(7696005)(41300700001)(36860700001)(316002)(82740400003)(356005)(81166007)(478600001)(36756003)(86362001)(47076005)(426003)(336012)(26005)(2616005)(1076003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:26:26.9977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515f1ce4-10f2-40b1-7ca8-08dc1b2c3592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364

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


