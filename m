Return-Path: <linux-kernel+bounces-7957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93C81AFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5D4288166
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E971863F;
	Thu, 21 Dec 2023 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vp7j2qne"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13820495F3;
	Thu, 21 Dec 2023 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNRU3n3DIwfwp/K8eiWUyCDAdf1mvyhWesEJWpqoLwAayDWy9KAXZFFjwN/5u69Rtw3NogHa7q8jX+LR8/YTBqI2xpSFxzOGhgVWsy47/rOkDzpy1N3LfhGivMHhZsTqdK5IfFL4qYY5MnTSNHDaJVjrSqOSzplssYPcb3U9Rz7xoZwNJa3N+yxSQTMeDx6mefjOHpULRi3jbIA2z3Am/pKDekKer1rfQ597ojD7ZNUu4rlObP2DHocC5TRkV4YkkVTWgynqX1sxRAbZxxqv+FsIpU6BwCyJuCl2TAcjzcjBSh6M7DUhk4P4BvYBKR0FQgOEG76EMyRHWQ0omU6c/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhoVkhy8GN1PdZmnmv/uRV5zVwbIdlO+MnLOz/NKjrs=;
 b=g0HAc+en8V7zxRIzS9eWHmcqKlQx9RFCG+PTo9ApkfZsaUIRN4h0vrOK9zbGbMv8sK4HWC1PvLp2rIo9UXPW2698HAf/fqw6C+5jMXJ2x9ozTf9GJS55fjDN2HpV/xPIPj+XNlkCyOVSc9fb1JCclp6QE7zMq+ovSRKaqQmTzw8i5ejnc2Pnke8ABCF/LOXpwducRjKPEZHxd/O33GZ/kGs3kg+UbT6OhZS3Zdaz4a4LRLxmWXbReoRW3UT58WorcXrvbTnNrSIT500SkE/0J+lby9+zkfO7E0FwsJYmx74fBXFrwbG8L8s+v+QpHOuCEY5KGkVog9H9K1Ty21hDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhoVkhy8GN1PdZmnmv/uRV5zVwbIdlO+MnLOz/NKjrs=;
 b=vp7j2qne5fRNAJEaHDJ4iVnxeg1e55AUhZ2s00Rbhystfdni6lVLHgl+9sllGzyrCIpGWwcDmpWTwzCUKlLHJn0eJbY2f7d5FNN5nli36tHtXF57L+2DwNuMCnC29WCcCWxX0CTr5t13joyGKy15wZYXIUY3EZoEUe80/YkDjrA=
Received: from CY8P220CA0037.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::7) by
 MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.21; Thu, 21 Dec 2023 07:38:22 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::67) by CY8P220CA0037.outlook.office365.com
 (2603:10b6:930:47::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Thu, 21 Dec 2023 07:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.20 via Frontend Transport; Thu, 21 Dec 2023 07:38:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:38:21 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:38:16 -0600
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
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
	<sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 12/12] ASoC: SOF: amd: refactor acp driver pm ops
Date: Thu, 21 Dec 2023 13:05:58 +0530
Message-ID: <20231221073558.3181911-13-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|MW3PR12MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 27416ca7-9879-4428-c77e-08dc01f7cf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jvzqAxXPL+FHHHiEu2pUl0Lp6iPAyK47l037LGeD18AP/U7enSln5TkPirD+08JAmqhw3r4JldBSrOwW963dUgkFYZCPbNN0/yuYkjLZ+ma3WuX1rZ7QFEGhIK39F/8CF6lx0vh+/aBK5B0V8n4JB3oy2ACGZPebvRAReww4heFi27u5ybpZMkmSjRdfQbEssCP93qC7tM6HXOofH3cK9hc9tWCQC8Sqz46Ty3sGdUCaZ0XJmdkJeUxdC/CZkXnuz8ebTvP3/4DPGdh7yM6w95JhV6pm5YoE0//yjcGrR8mzt/Jab4QoBmkFfZaRG8zMNx+LPtMW42CUH73/AjOscLUSDw5FGjARd/WdFEpGYKOtG37xcLeECv5oYWbjcyYdFZhY9OHxiemn3BvuSpoQWxW7qorIq+dvpnuIG2sOFpb5Nvr/U6uzmA5xLJBnAm4kXa4F3AqnMgahWlPl/9h1a5PZTfpj7tLOeknUEotAcaCrp1sQPy9IznkrcIG/b9aLOlF57xccQIb8YW63093PEkh0bD+7nM1JTVt7Ef6pAcVuJwYS12S15D3ogcyUlyNI5DYMjruLW0mYhNMeDExMSM7ZBZ+eWxlAmb8tUfyPZPipjn8ZNTlhi0gNlPnHWL6mmRXaQjE2CIhYVLPMMJrQauKalzL8ZMO0b3tWSIDaEoZPsN61Cec0eNSJ1m6F2ItJ4/kqj0y7EwvtgOEkPsbOlX06r/yuvYm+FP/Y3Oigc8HCUIgjpLi6cEmyqMpcRsg2aQsN3rfWkJ/w0tmxBz5TqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(46966006)(40470700004)(36840700001)(2906002)(6666004)(86362001)(36756003)(356005)(7696005)(478600001)(7416002)(36860700001)(26005)(83380400001)(47076005)(1076003)(82740400003)(2616005)(336012)(81166007)(426003)(41300700001)(5660300002)(54906003)(110136005)(70206006)(70586007)(40480700001)(316002)(4326008)(8676002)(8936002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:38:22.1666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27416ca7-9879-4428-c77e-08dc01f7cf17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4537

Refactor acp driver pm ops to support SoundWire interface.

When SoundWire configuration is enabled, In case of ClockStopMode,
DSP soft reset should be applied and for rest of the scenarios
acp init/deinit sequence should be invoked.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h |  3 ++
 sound/soc/sof/amd/acp.c            | 65 +++++++++++++++++++++++++++---
 sound/soc/sof/amd/acp.h            |  4 ++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index c1bdc028a61a..59afbe2e0f42 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -103,4 +103,7 @@
 /* Cache window registers */
 #define ACP_DSP0_CACHE_OFFSET0			0x0420
 #define ACP_DSP0_CACHE_SIZE0			0x0424
+
+#define ACP_SW0_EN				0x3000
+#define ACP_SW1_EN				0x3C00
 #endif
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 7a34faae9889..920fead2d93d 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -482,6 +482,31 @@ static int acp_reset(struct snd_sof_dev *sdev)
 	return ret;
 }
 
+static int acp_dsp_reset(struct snd_sof_dev *sdev)
+{
+	unsigned int val;
+	int ret;
+
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SOFT_RESET, ACP_DSP_ASSERT_RESET);
+
+	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SOFT_RESET, val,
+					    val & ACP_DSP_SOFT_RESET_DONE_MASK,
+					    ACP_REG_POLL_INTERVAL, ACP_REG_POLL_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(sdev->dev, "timeout asserting reset\n");
+		return ret;
+	}
+
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SOFT_RESET, ACP_DSP_RELEASE_RESET);
+
+	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SOFT_RESET, val, !val,
+					    ACP_REG_POLL_INTERVAL, ACP_REG_POLL_TIMEOUT_US);
+	if (ret < 0)
+		dev_err(sdev->dev, "timeout in releasing reset\n");
+
+	return ret;
+}
+
 static int acp_init(struct snd_sof_dev *sdev)
 {
 	int ret;
@@ -498,10 +523,34 @@ static int acp_init(struct snd_sof_dev *sdev)
 	return acp_reset(sdev);
 }
 
+static bool check_acp_sdw_enable_status(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *acp_data;
+	u32 sdw0_en, sdw1_en;
+
+	acp_data = sdev->pdata->hw_pdata;
+	if (!acp_data->sdw)
+		return false;
+
+	sdw0_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SW0_EN);
+	sdw1_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SW1_EN);
+	acp_data->sdw_en_stat = sdw0_en || sdw1_en;
+	return acp_data->sdw_en_stat;
+}
+
 int amd_sof_acp_suspend(struct snd_sof_dev *sdev, u32 target_state)
 {
 	int ret;
 
+	/* When acp_reset() function is invoked, it will apply ACP SOFT reset and
+	 * DSP reset. ACP Soft reset sequence will cause all ACP IP registers will
+	 * be reset to default values which will break the ClockStop Mode functionality.
+	 * Add a condition check to apply DSP reset when SoundWire ClockStop mode
+	 * is selected. For the rest of the scenarios, apply acp reset sequence.
+	 */
+	if (check_acp_sdw_enable_status(sdev))
+		return acp_dsp_reset(sdev);
+
 	ret = acp_reset(sdev);
 	if (ret) {
 		dev_err(sdev->dev, "ACP Reset failed\n");
@@ -517,13 +566,19 @@ EXPORT_SYMBOL_NS(amd_sof_acp_suspend, SND_SOC_SOF_AMD_COMMON);
 int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 {
 	int ret;
+	struct acp_dev_data *acp_data;
 
-	ret = acp_init(sdev);
-	if (ret) {
-		dev_err(sdev->dev, "ACP Init failed\n");
-		return ret;
+	acp_data = sdev->pdata->hw_pdata;
+	if (!acp_data->sdw_en_stat) {
+		ret = acp_init(sdev);
+		if (ret) {
+			dev_err(sdev->dev, "ACP Init failed\n");
+			return ret;
+		}
+		return acp_memory_init(sdev);
+	} else {
+		return acp_dsp_reset(sdev);
 	}
-	return acp_memory_init(sdev);
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_resume, SND_SOC_SOF_AMD_COMMON);
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index e94713d7ff1d..947068da39b5 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -31,6 +31,9 @@
 #define ACP_ASSERT_RESET			0x01
 #define ACP_RELEASE_RESET			0x00
 #define ACP_SOFT_RESET_DONE_MASK		0x00010001
+#define ACP_DSP_ASSERT_RESET			0x04
+#define ACP_DSP_RELEASE_RESET			0x00
+#define ACP_DSP_SOFT_RESET_DONE_MASK		0x00050004
 
 #define ACP_DSP_INTR_EN_MASK			0x00000001
 #define ACP3X_SRAM_PTE_OFFSET			0x02050000
@@ -242,6 +245,7 @@ struct acp_dev_data {
 	bool enable_fw_debug;
 	bool is_dram_in_use;
 	bool is_sram_in_use;
+	bool sdw_en_stat;
 };
 
 void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src, size_t bytes);
-- 
2.34.1


