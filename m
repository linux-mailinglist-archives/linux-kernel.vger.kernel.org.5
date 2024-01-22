Return-Path: <linux-kernel+bounces-32626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0012A835E17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39D8282947
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D49839AE2;
	Mon, 22 Jan 2024 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zxXPv4WU"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF03A1A0;
	Mon, 22 Jan 2024 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915557; cv=fail; b=Y/dZeB1sfW3YDp5JbLOWFMGLS0Z73NBcS55Csp15ICGf65eD/nUjhyL5bSDCbfAQb4tlRXWns05C0X/XGKIxwBYrW1jfOOFxusu3krtZj9Ya9ZwfYv/4dBwvJSf89OIOGeMi626j77Y+6uwxAyBCwUG7BcIDsRLZxW/TRst/xzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915557; c=relaxed/simple;
	bh=31D+/hqwgpKoYAVDBrZ6wrGvL8bVEyF9/My6LklWUaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVGdDHr4Hju0jsceNyG0g/HyIDp4lRZKMnQmMhQi3hssW7gQ5GLiJGQ8PDnJLZkIRzoXzz+Qm/EzECW/MeE4s0LtnlwVEAKgsPNxGTIzNxYzXM+14UiG7oVuSu+iMqamceKH6RT3BJkGIzshZ5LWef5ctEzb4QqyfGW5/Bxb8l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zxXPv4WU; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzLwel/QtPm1RD57aYF86XkZtQ5cmrna6uh9gwMIFmsqddG1+sQlReUNwmYd1jB7BOkTuSmxbFTYjUj30AyoEg3IJ59ICBZ9qFBzGwZLMZOeq1Xl7moIZU8knerlxjDEvEwhRTZGeSxA/b5whWXpsI/9GXsd/sq2iLEud81SZzCQKEEv2PIZCTqcJj8wrn0TZvnw5RgpOnyYbV6WQY0y0yhuIRykRz1ZSeounhzjgth8e1I3CKnDAd9rpvR06SvIhPv/H4Z+94rQxPI7QI4NSCecIl9IeFckArWlfmSqUR46BmPiwCi8eMxmhmI0fqIwRrw3D2Xn9E77qvHZJEaZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmSvbdZheoMbrfrMOra1kGeyoKcwdWWrtw+v++Bk0J8=;
 b=Bp3G+vVC5ex5mBPxBgxkOLUh2rjDgaQxOmvQOh9xtXPvrNDDh25oSYvkysoDshXc25Fha0LJze7F0+JSCGM7Mf4PdnPzE4V5sltUkJI0RD3fGTizyl2Fy27fc8hW7SMXNvBo16R5qbe126Aq5x22wVN1pRwjPKuxIZJQZx60IVG6w/gnkbrP31jLavm0M88hZ8iA9q//ffPexdgiuKvaoV5eqcFqGyj+6g+YhP/AZSszS5iAHXDMYoeRuF2/e+X/4MYFG7RLSY2fIlHgEdhejAVAstXj/G7F+s37FgyT7vF5spRFNogNd+lhku8OCoMJDkBl/b2OhBEhugATp+2nYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmSvbdZheoMbrfrMOra1kGeyoKcwdWWrtw+v++Bk0J8=;
 b=zxXPv4WUbQCs8NIOA+bqIhalrD/vCYG4NS86GlZ8ZO65tJKTAjtWiSHubhqav4hRzRf+BtFl1af0qu1vXWB6NoXlovgtSlQmUE8SlY+M20+t2eq7P0GFA98E9GRJJM2P6yRIpXSTTXlDse/z3b7ho4w4s4OnKzEASEyOEXGgF6o=
Received: from CY5P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::24) by
 LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Mon, 22 Jan
 2024 09:25:53 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:b:cafe::9c) by CY5P221CA0015.outlook.office365.com
 (2603:10b6:930:b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 09:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 09:25:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:25:51 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:25:46 -0600
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
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mastan Katragadda
	<Mastan.Katragadda@amd.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, "moderated list:SOUND - SOUND OPEN FIRMWARE
 (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 08/13] ASoC: SOF: amd: add interrupt handling for SoundWire manager devices
Date: Mon, 22 Jan 2024 14:54:30 +0530
Message-ID: <20240122092435.3791175-9-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: a3022274-a6e8-429a-c2df-08dc1b2c2109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ykObGMo0ZFmzr8bXObNGwFxvau3BxcEGaCB78PScgYYsNDaWvObvkM6f9640RJb/U1vouQGn7oqdeSjc4godb6XqxSOAI+3/nc3isCMY3LH94tOF35qUMGTzOM8EvGBCxZAe+JJoFHKIQCCps/eI6zLbwegLs1NI6SMxP/jlGot7sP+c7m/rb2TnDVtJVHfYdHQTlHagP9GiRATRa4YHst+AKqroTP2bmcAnKiaFNWkjTCqcqC8UpSlhYQog3riSh/gteIcCGoDmddFJxskZ7ojHKQGncCKAIXF5ghnK8utLO65VmU7PDqvlw7JKNmUjcBPps6Iral019xp7F9+XBuvaz/WH8ITXyYsmjIraPxrfUOUKyPQ8YSYKiXKhIL56LaT8xfAcwhiDXxTm9n+Fbv7/MdaaNrLujMSkThlMMb3UkrGGOPAhX9TMmttP+dzR0ms0dh/InF4e2jtSLOsi+CaqBoGeXUp4+9WChkrJfNPjx21Z69rzGhlc+t81nMOUFnLWtCbktER5LgCbwiEsIz9SEmH31SSKeZ9cR7otWfPEanZQj+u8uSyFjN9hmv2jCQ2y3wOawjk2hfP9MGOb8zDpdnB9qlRkoWsyoCl2utBkuH1zeFa0E3cydybUwty4g8uBiNpln22uOU4HxhHGHf+XBJBN8kiJERvT4Kaoff8K0GC9azHudRYbEjqkNJtJsuQOU5B7j2DCt4cOTS0QvHWMVpHKToawb0arSBnYsgw1YGLleegGmSJUowz45I19AjZkjfCd53ZwEDxhV38kLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(36840700001)(46966006)(40470700004)(7416002)(8676002)(5660300002)(8936002)(2906002)(4326008)(70586007)(316002)(110136005)(86362001)(70206006)(54906003)(36756003)(36860700001)(47076005)(82740400003)(81166007)(356005)(2616005)(7696005)(6666004)(83380400001)(478600001)(26005)(1076003)(336012)(426003)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:25:52.5472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3022274-a6e8-429a-c2df-08dc1b2c2109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965

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
index f24cd6b7490f..7a34faae9889 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -375,10 +375,13 @@ static irqreturn_t acp_irq_thread(int irq, void *context)
 
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
@@ -387,7 +390,38 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
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
@@ -443,6 +477,8 @@ static int acp_reset(struct snd_sof_dev *sdev)
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


