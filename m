Return-Path: <linux-kernel+bounces-42204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8183FDDA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99167283FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B54C610;
	Mon, 29 Jan 2024 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PLbTK86t"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349044C3BB;
	Mon, 29 Jan 2024 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507597; cv=fail; b=fTRLhsYZRvwNBXgwEwaiSchROKohlmvDOFWOVs5/Rl3AI1KtPGfcAK5Lexu5Swn2Z0py+rt17gtEulZx5NnfNLO/93yM8VrOghwx+eBqmCH3+qQ/gs1ROUV7UQC2frv/YbD75gZ6rFN+BzDIF0wrSx50O1zlH7MP4Iu96CRU6Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507597; c=relaxed/simple;
	bh=28Rhvhrra0atayVBFYhVQDuUVCrUBLDVaqmami5osvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUgTvgdy3C0YIyfEf1iVhC9ZNGSvyiESlw3P7h+6thPJh1XRHOUeW/Mt4PdZj5EhU29/GLbuzZ/jtEJDJjMU73YpBPQl6uaJHLtHvWI4wI6nCiVyLIe32e9V9YdeUmGiO4x9jYzXUQUEM/Ep8dZTiJXn6SNKIpBbaiJbS8Q7qQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PLbTK86t; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+Z6HiKcnwI2kAZMPaMfiKFCMjtvojmB2xSglRdvNpgBZyxNjl0f8S272G/l2pe73Fuh58lEBa4CyMfYuWGhi+WmL5pn8Cl9wLQueFxkrN7PORwbIuUmeUZHMzwg7TW06LIRPa00frOXMUChwJAzEmhB3JzMcg0OSxJkM49Zn0lwuWU5JHF7/FTwm0QNgA9F5N9BLQ5NviRW5xRqf9HPe0IOH46fkENZdjKrPlmEMogifGdnqnq5Pex4Q9XqKprsxRctvQ5RQT0E0gZGUurm2oLCbLDNDbyqvU05KSYibXO5yKHZxx0597owD0tuOGIDl4YdYqOhUL/3Iqnys4f/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFbI2+4YxRILU1pz4TTvJ96TO5r0YrL3Rwop7Duh4Oc=;
 b=bKReVyDwStvrbPrWEhUoSPOME8HeOWZQ0gELiH8EN6Ys3f3KxZdJOEeO1gEE4PSZXXLj7yGg9bjEajvUe7ve/Fi0Hrk/X1DbpDJ52J0NK17llBYhWA3e4sSRcK24DrkVuh2mNqLp/UWrgxZFvsOPBMpkjJpSlVx9gifEd1ENpuf5MDYoI5J2Un16TFtLczQ13Pl9xcjWrx9M4QYVd73I2ey2+aWt38og2Xhs7WMQBjYzMqtb7veTIZrLW4XK4guodK3pz5REKOwLzvgyvtLdRIiEijQvRy2IO3H7fD4RtJ0HgG0S1l1Q5N4RNE0xCL9+DYrey0E4tmQ2sDeYaODyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFbI2+4YxRILU1pz4TTvJ96TO5r0YrL3Rwop7Duh4Oc=;
 b=PLbTK86tweCkvkfC+CSPO0SoWDRAAZb1OPgheiWRpDmH1gFCHVCFRVGyifdKidOJYza13nCLmFqOUfAPRHbhbAukTG2zLX+HYu0a9vStE1z2gWLFI4TLexCu0+UsaHpbGOi4i195kVcG66OQpUxZ01/Jj2ENu7YSVfNMtKxGeD4=
Received: from BN1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:408:e2::29)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 05:53:13 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::69) by BN1PR13CA0024.outlook.office365.com
 (2603:10b6:408:e2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.20 via Frontend
 Transport; Mon, 29 Jan 2024 05:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 05:53:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 23:53:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 28 Jan
 2024 21:53:06 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sun, 28 Jan 2024 23:53:01 -0600
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
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Emil Velikov
	<emil.velikov@collabora.com>, Cristian Ciocaltea
	<cristian.ciocaltea@collabora.com>, Mastan Katragadda
	<Mastan.Katragadda@amd.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, "moderated list:SOUND - SOUND OPEN FIRMWARE
 (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 08/13] ASoC: SOF: amd: add interrupt handling for SoundWire manager devices
Date: Mon, 29 Jan 2024 11:21:42 +0530
Message-ID: <20240129055147.1493853-9-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: d1adda12-907a-4b56-b318-08dc208e94b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6pzcuSZKEUZqUE6TomHzTBVbSu4tk7JkQu/OhjsVgCcGPC7Cmi+2aLNWhbYfRrpsTu+BHcvLIqXeEVmbaGJDflDXYgDEzG7sfOx0b+A+ryDVMpYgmlkSGvs+UKcMt3qPzUodWTw1di6PSoVUzLU6n0eo8SEYsrTSuK/yoRmggUFa2so7lUCrPYgqBfYXBVBG0e73uGnE40+U11Gsq9NJFP9h/zGjKXHfO/A0VRkbqrhoGtLXCq1YU/31rZVsq+FOOVSEYllTCRItQywfWVM5GCABggyW2FTejxcdZq5ctBkudy9HO0yRAFS2Fi6G1ulQx/BmJe4oc4M/fn+1eOc5OanWHiCUKY9+sxvkcWBgoMRe16UPqcMYU3AI9UzDeBbD+8/jwi3hSqTE3l+Wv+TL6X7r+rYqNHBvhvy0iMMt6OpWaSjfWEtvnXobSoDPqJtqXKebYmoGZCGLbSPYcyuSLldQaszpRM7Nx6TwP+4ht9a3Y9A4zoDtzQ3FQ7s1yhOBQQ2QPASvxmbECPw52Gv1m/xbyOCLj6v+s1ZDR1BtMVTcmF1AGmfesT/NsVcBozbcZsSDv7b6XNy2gIT5zubvBE9ThxAtCNDzA3ZSvTEg6dK0gn074wpGlvFfuDlRi3y/UhcJ5dUpyvxCl3RJA898m8qCLF79lIgOiy4A57SBhL2RGoRP1Ls86yLuclCzzSw64Wd+0ZrDHYX1bcXbfFMlmJ1PQbnstmn2/a+A7EY+KCAVm/BJWIBkp6//eZqocvrkQG8m7pyws9ojtIlgJPNw8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(26005)(1076003)(83380400001)(426003)(336012)(6666004)(7696005)(36756003)(86362001)(81166007)(356005)(82740400003)(5660300002)(7416002)(41300700001)(4326008)(8676002)(8936002)(36860700001)(2616005)(47076005)(70586007)(70206006)(110136005)(54906003)(2906002)(478600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 05:53:13.1573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1adda12-907a-4b56-b318-08dc208e94b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534

Add support for interrupt handling for soundwire manager platform
devices.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h |  4 ++++
 sound/soc/sof/amd/acp.c            | 38 +++++++++++++++++++++++++++++-
 sound/soc/sof/amd/acp.h            |  5 ++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index a913f1cc4c80..7ba6492b8e99 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -78,6 +78,10 @@
 #define ACP5X_AXI2DAGB_SEM_0			0x1884
 #define ACP6X_AXI2DAGB_SEM_0			0x1874
 
+/* ACP common registers to report errors related to I2S & SoundWire interfaces */
+#define ACP_SW0_I2S_ERROR_REASON		0x18B4
+#define ACP_SW1_I2S_ERROR_REASON		0x1A50
+
 /* Registers from ACP_SHA block */
 #define ACP_SHA_DSP_FW_QUALIFIER		0x1C70
 #define ACP_SHA_DMA_CMD				0x1CB0
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 1905f1a4ba64..0752f99cac0d 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -374,10 +374,13 @@ static irqreturn_t acp_irq_thread(int irq, void *context)
 
 static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 {
+	struct amd_sdw_manager *amd_manager;
 	struct snd_sof_dev *sdev = dev_id;
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 	unsigned int base = desc->dsp_intr_base;
 	unsigned int val;
+	int irq_flag = 0;
 
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
 	if (val & ACP_DSP_TO_HOST_IRQ) {
@@ -386,7 +389,38 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 		return IRQ_WAKE_THREAD;
 	}
 
-	return IRQ_NONE;
+	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
+	if (val & ACP_SDW0_IRQ_MASK) {
+		amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_SDW0_IRQ_MASK);
+		if (amd_manager)
+			schedule_work(&amd_manager->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
+
+	if (val & ACP_ERROR_IRQ_MASK) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_ERROR_IRQ_MASK);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + ACP_SW0_I2S_ERROR_REASON, 0);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + ACP_SW1_I2S_ERROR_REASON, 0);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + ACP_ERROR_STATUS, 0);
+		irq_flag = 1;
+	}
+
+	if (desc->ext_intr_stat1) {
+		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat1);
+		if (val & ACP_SDW1_IRQ_MASK) {
+			amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
+			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat1,
+					  ACP_SDW1_IRQ_MASK);
+			if (amd_manager)
+				schedule_work(&amd_manager->amd_sdw_irq_thread);
+			irq_flag = 1;
+		}
+	}
+	if (irq_flag)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
 }
 
 static int acp_power_on(struct snd_sof_dev *sdev)
@@ -442,6 +476,8 @@ static int acp_reset(struct snd_sof_dev *sdev)
 	if (desc->ext_intr_enb)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_enb, 0x01);
 
+	if (desc->ext_intr_cntl)
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_cntl, ACP_ERROR_IRQ_MASK);
 	return ret;
 }
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index e88d01330ec7..2058dae32659 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -93,6 +93,9 @@
 #define PROBE_STATUS_BIT			BIT(31)
 
 #define ACP_FIRMWARE_SIGNATURE			0x100
+#define ACP_ERROR_IRQ_MASK			BIT(29)
+#define ACP_SDW0_IRQ_MASK			BIT(21)
+#define ACP_SDW1_IRQ_MASK			BIT(2)
 #define ACP_DEFAULT_SRAM_LENGTH			0x00080000
 #define ACP_SRAM_PAGE_COUNT			128
 
@@ -184,7 +187,9 @@ struct sof_amd_acp_desc {
 	unsigned int host_bridge_id;
 	u32 pgfsm_base;
 	u32 ext_intr_enb;
+	u32 ext_intr_cntl;
 	u32 ext_intr_stat;
+	u32 ext_intr_stat1;
 	u32 dsp_intr_base;
 	u32 sram_pte_offset;
 	u32 hw_semaphore_offset;
-- 
2.34.1


