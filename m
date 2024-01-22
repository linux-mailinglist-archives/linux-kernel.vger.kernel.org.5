Return-Path: <linux-kernel+bounces-32631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB2835E26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EF9B288B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E69939AD8;
	Mon, 22 Jan 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lgPh+jGo"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF53987D;
	Mon, 22 Jan 2024 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915615; cv=fail; b=YrYG60QD7geFCSTxEkJhd3nVHBgMX7+pnG2hODx5B/vlnEwD8HZcOjTLmCKlX/7xGVRWhVRqSrEbuzCPDNYwg/Gfvq00bbRM0r8C13bYKC+HoHK9PH1hwkXpwliqd2C7Y1DQVwD9jB/UanMPeALKJ/Uw1rh5ObiBPjC8UIWRFf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915615; c=relaxed/simple;
	bh=uowzxZRevTt9WCAROFCeIie7vPjduaXYhxvsHTUycdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtEzv+qun4oiuGy35qMk3n1o3jz/Cv1HACy9IvZB9H76HSjLYlkPhwUbdKwj8xVgYln4l2SLl9lUw8VaR2YK31FhwRXc2AGrZfAKZ3K6k/QB7297FS4WjpsHG7KeOOKr9TnGcDuVrB+pPeqFCn9WJCaOsZK4Om2jF8jYXsrPhU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lgPh+jGo; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEvjCtyQHlnX6X15f9Et6DmsVVMmVAllPpWBc4fOyFXvLXFjz0/ODRqWcMb8rQwftTGq+NFxoX9zz4Hk/H7BdEGY5Me+96xk9S6qoy9utAEv2JeX8oXFUojslNDRtUwshapnxCpHK5KwbKHg9j6Dmr92rRoXAgN3ooz6PgMbI2gd1Mam0HowOuNpKpCoIcmWDrlkLRZ8y0ioV1kIvEHWOcBYa7Xe2wLG5GnP2FMG8UlEJbB8s/ozoPQw90r+402KaMIidXd879g0CyAeH2s5VvTNcy0Q04uf7Q4t46Plo/A3Amb1tYzW0RiJV8nUUm3Z76intLRDkgFl57A4rbTXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhoVkhy8GN1PdZmnmv/uRV5zVwbIdlO+MnLOz/NKjrs=;
 b=kaVyKDAkwJditzMfvUSymLDFbGXFyocajcZ1h4FuNOdvEK9innHZmOAMajTE7Pa3Jcn5wPcs6q6+zF+N+DJMbFTlyGdbW4oYKqpIR0veiMPvehbdjSnSwnQlB3N2VkblFugzwiyYSSlrniSzVIjFnRBcgSa8Epes8mAZW3IYlTlWgyvu40FiSf/KUSuC51FMH31v8vrrmomFMJNMDJ1tI+W6jr6PpTHG66e4zDyn1LEkdZFWWteedIq62oKzwH1Iu+/d6Qt15mkbUN9moAuBZhD1M6tBlrppkg6d0GK+qnMywDH208IBUba5CqZ3kJ+fwn0GRp8+dO/a+cQ1TOT3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhoVkhy8GN1PdZmnmv/uRV5zVwbIdlO+MnLOz/NKjrs=;
 b=lgPh+jGofiGnAJ+mC6eUYSgCTEaUyMuOP2oAtqCtQ77sidTBXsBgiyI6T4uY2Vv6nxnjqtaqPQOr70z8rG/B+XfNNy/GSrktyuLZU+/nF/MAOCXm1DvLYwVPKMLrvRxX+zHSjOrKv50cJfQ3PU1xTbSUviRwPk9UmUa7HJ1Vq3w=
Received: from CY5PR19CA0041.namprd19.prod.outlook.com (2603:10b6:930:1a::8)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:26:50 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::67) by CY5PR19CA0041.outlook.office365.com
 (2603:10b6:930:1a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 09:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 22 Jan 2024 09:26:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:26:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 22 Jan
 2024 01:26:49 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:26:43 -0600
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
Subject: [PATCH V3 13/13] ASoC: SOF: amd: refactor acp driver pm ops
Date: Mon, 22 Jan 2024 14:54:35 +0530
Message-ID: <20240122092435.3791175-14-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 0274d9ef-2ccc-483f-5b6f-08dc1b2c435b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ne7pNAKK763a1RynHtuPYRevU5x9XOF7p2om3eDphF4t+yvx8fBO/yrgg1cBRbihbHQ1Q+OaVO6jucOcC3tf+pqitj/c8YP4lRfZJMHC/EcdGdIWPBnAhInXLAocSZX5s3+W5CFMB8YdxuBpIprI2iVmCZCBYITNiCNRGDbUBwl1f/oE4O6bi67K3kwPqgePuoraCvaiMLM/zrT0uZ0No+tQ/LhseSJfdjQ5uM5TpWqVLBFfJJFqQhjON7xOYlpDZ4BvmzXw7XSxUR3RmGmJV883q5SipsSEqdW2clBYuwNAmMsP87xQ0iHAYpKBEPUjXpI9mXs0Z5qSZhZRUO/KUcwaKUpC8QH3rQZ/DBNNW9061kQzSsOOWH+95aTUWyEOGFphV2uQAKQa8a/8+lnOZP1fAH2UK052YK1Nlt/2EXg+sxlulkaOCJLyq4on+3j6wGFak4vpJdoJJ5OCZNIpPUCUqrXanu7cgy7usI9TiAGI3KPNGVYo7CgwhpmjbMjYoyZ8M21IU7n3P7unJ1LzcXpSUUoAqqeSyq298E5ZNIu56Ww/o+bPNopNXwpbB1GHFlszr/hvR9HZsliS3pOKSg3hEsENJpaH/Pl2BCvWNptKa72+F1o/sKBIqjqliH9hiYltKaksdJ3YHl/YoFZHlD8iElWaeGll20mnklLzUkk7ET7zBLCPT1bNtoIFv0588K4Pj92qVIARd8Sdi/Xnm/Yn7b5hNpTd71d+zOJnOssuuCPg5MYQjh1EBzOCSb+hSgjSbTZTam1vWCRCxXDYKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(36860700001)(47076005)(41300700001)(86362001)(36756003)(82740400003)(336012)(81166007)(356005)(83380400001)(478600001)(8936002)(8676002)(4326008)(6666004)(7696005)(316002)(110136005)(54906003)(70206006)(70586007)(7416002)(426003)(5660300002)(26005)(2906002)(2616005)(1076003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:26:50.1245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0274d9ef-2ccc-483f-5b6f-08dc1b2c435b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272

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


