Return-Path: <linux-kernel+bounces-32627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CA835E19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B58284546
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74F39FD4;
	Mon, 22 Jan 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X0wrMtiO"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA6D3A1A0;
	Mon, 22 Jan 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915567; cv=fail; b=CiSVbhz0rWRuG62ESuctAhKfB9fiyvZfazcNwdp1wH3ssvM7vmq+Kd28qlcnH501vK9zTXMZvT3ohAwvuEAHFVuQDmBk7t8olHhlWmscITPAV/Gi5ZiMGdgEzn9vGV98CRJMgcnSJgd6sNZI1DL/AfD+rekiTQDiJqWB8gchIMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915567; c=relaxed/simple;
	bh=6Oh0AeqAs3GSRQ7LlJY6ezIsZ7gv2kjaHXykuOEAlAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAxUflbZj19949LshdhnDucco7bh5Jhh2HINqVyaSiQLuLeH1lln004lghjqLB6m4EjDrcxrSmVpxXoE3Ylg9Sow4XJbN5Ja5mbDEITvpEu9v8rGjPWgiwf3t1t46pelLs0rzyblQtErramURXbFAAhON+c4isZZgBMJLghMX/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X0wrMtiO; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA9XNmCar8AQkkDXNIJVUXHw5sl50yAVDMJQv161/TzMvYR8x6EYp7PdXJ5zLUdUbd0UTb9qF01gqCX1Oh/y50LsiBgVNOwFx/ikAYfGVvopp1DNfZkttnOCNSBhWtynBBWt4gQ06PzoXQQKwz8MZBfcWmJP9m3AFFCRbtelt8Y2WTg1CZ5IiPcy+8QRnP/5A9pYPDlBMkXrbCHoGluAhnfB1afNIlJ0fH6boAmtf5DeRVNKVUnRt4NMoZyypSFaJka+/AXRJr6A2/dM+aWXy3U1vCqzOa3m+SqBZkG+Sn7rVm30x82mEAscEvFsu8ajj4mxHGdLdmDKM3wwR21IKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPqL8D8sIUEJdIE9QqRF4FLGLmz9V6QPJ3PtGhXMEUs=;
 b=AsK9Db0ex62Uu40cnVjS6Lhi73vfEnPjeA5SsOXjAxpiqk/OquCxOiXZYjhiyVhSlQaP/amxHiGb+COmIRyZku4BhECbFfEd1taI/tqCw+axGO1QZwNcCpUw/0rzJ4HldQrShZsty0r3yu+ULvzq2wjy9EC/6UUMLAgUheRrjJlWNWKtfJ5syxBfXIPhHI5GpiqtKt45cW0aEAlb52L0yG3bVuEP6IRgvxmv3CAYxTONWSLL9omsjD+CBfed1WD7k4Z0gbVc045oDIg7IjBSAgHBpedrGTB/wU6vnm0yBZthYt1jH5S8ny6+BJcjQLii+QINfknyqABQ+Xn5Qo17Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPqL8D8sIUEJdIE9QqRF4FLGLmz9V6QPJ3PtGhXMEUs=;
 b=X0wrMtiOcljcVROipQDoEiYqQIXWguQfOXlFs0xUSmFhQW6q+LOHtPNhIvcVAxs+NXzi4jakiNKIOWDCIc6Z4I9IeOJMO82g9OroxzPOxfdKxC0TJwMeHjYJfGilVDm5zAmDvukMg1rCbmVMIZAknlnjB5Y+LumlSx3cHCBdWQQ=
Received: from DM6PR21CA0029.namprd21.prod.outlook.com (2603:10b6:5:174::39)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 09:26:02 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::67) by DM6PR21CA0029.outlook.office365.com
 (2603:10b6:5:174::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.6 via Frontend
 Transport; Mon, 22 Jan 2024 09:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 09:26:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:26:00 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:25:55 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jyri Sarha
	<jyri.sarha@intel.com>, Curtis Malainey <cujomalainey@chromium.org>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH V3 09/13] ASoC: SOF: amd: Add Soundwire DAI configuration support for AMD platforms
Date: Mon, 22 Jan 2024 14:54:31 +0530
Message-ID: <20240122092435.3791175-10-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: a70e9a03-f69a-44cd-dd41-08dc1b2c26a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z+bS0DTjmPyW7sFRgu0tgUYGBm+sjusq9C6Sr5/s/NzmSLq9IeY4G9zZ7LjzhR3E3ai8QgplBfBj/RMzctsZKfFK2GENGuTdO4N89nAtC7gMiFmNAsKUbke3PwVyV54yAosF3sXMrk/OPw/+RDkRrd8d4KbVysC0QUb0J+KeHrHrVYOaOg9eT1DZCAIv/1n7JQxcjtsBZECc3cji+V+RU98vZvibrnUpVxmkwGEI0BazNjckspxbgHcYzZjYYkYoJVTusqf/KK/zPhJAv7UiB79JERuoVOcgFchi63KSxlXkuQnvUByGp+dIf7m+Dsefsyq7C56M/PALXUTdTjUYhKb0YPP1ShDiJDhZoEfrkX3gS0pQywx1nwzraN1ti4efAUmfrOGkVAozySeVv0asTH3U/gwZFGEdH/Ztf+p4OImhht1s+Ysa1MFzVHj+uSHlQ0HWgzl9LtjXN69ORac/T/0f6kfyvHxGaJ/Hu4Y1FM5a0RRSB5q16XCfWUhATxEXB88fq7Zb/lfQfmfKAYCZoXxbrjVjrlVduBbK9OxZHVGdPIWttj5FAdaYLvJxK4+7WhFonBu+awYlLOTjJ6ceVIV2sP1AzKasOxbXHYBTE7LMb9GtDU9WAqEjoN9m3BvBbWZuQrEouAa0drCdoSUwBbRR63khkn53a/mTHdn89aHARwHQh6T5iDEab2zCEkQopI8xi4RD5zqZfRoj/dnOkq8GlBKSD6JYixCF9jTaY50rnG+ctpKOuIIoli7Cpe0v4c28+tIami9f8dZox6QlBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(36840700001)(40470700004)(46966006)(81166007)(356005)(82740400003)(36756003)(40460700003)(40480700001)(86362001)(83380400001)(336012)(426003)(1076003)(26005)(2616005)(316002)(70206006)(70586007)(8676002)(8936002)(54906003)(7696005)(478600001)(6666004)(110136005)(47076005)(36860700001)(2906002)(41300700001)(4326008)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:26:01.9654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70e9a03-f69a-44cd-dd41-08dc1b2c26a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

Add support for configuring AMD Soundwire DAI from topology.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 include/sound/sof/dai-amd.h     |  7 ++++++
 include/sound/sof/dai.h         |  2 ++
 include/uapi/sound/sof/tokens.h |  4 ++++
 sound/soc/sof/ipc3-pcm.c        | 25 +++++++++++++++++++++
 sound/soc/sof/ipc3-topology.c   | 40 +++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-audio.h       |  1 +
 sound/soc/sof/topology.c        |  5 +++++
 7 files changed, 84 insertions(+)

diff --git a/include/sound/sof/dai-amd.h b/include/sound/sof/dai-amd.h
index 9df7ac824efe..59cd014392c1 100644
--- a/include/sound/sof/dai-amd.h
+++ b/include/sound/sof/dai-amd.h
@@ -26,4 +26,11 @@ struct sof_ipc_dai_acpdmic_params {
 	uint32_t pdm_ch;
 } __packed;
 
+/* ACP_SDW Configuration Request - SOF_IPC_DAI_AMD_SDW_CONFIG */
+struct sof_ipc_dai_acp_sdw_params {
+	struct sof_ipc_hdr hdr;
+	u32 rate;
+	u32 channels;
+} __packed;
+
 #endif
diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 4773a5f616a4..0764a80c17a9 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -89,6 +89,7 @@ enum sof_ipc_dai_type {
 	SOF_DAI_AMD_SP_VIRTUAL,		/**< AMD ACP SP VIRTUAL */
 	SOF_DAI_AMD_HS_VIRTUAL,		/**< AMD ACP HS VIRTUAL */
 	SOF_DAI_IMX_MICFIL,		/** < i.MX MICFIL PDM */
+	SOF_DAI_AMD_SDW,		/**< AMD ACP SDW */
 };
 
 /* general purpose DAI configuration */
@@ -119,6 +120,7 @@ struct sof_ipc_dai_config {
 		struct sof_ipc_dai_acp_params acphs;
 		struct sof_ipc_dai_mtk_afe_params afe;
 		struct sof_ipc_dai_micfil_params micfil;
+		struct sof_ipc_dai_acp_sdw_params acp_sdw;
 	};
 } __packed;
 
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index ee5708934614..6bf00c09d30d 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -218,4 +218,8 @@
 #define SOF_TKN_IMX_MICFIL_RATE			2000
 #define SOF_TKN_IMX_MICFIL_CH			2001
 
+/* ACP SDW */
+#define SOF_TKN_AMD_ACP_SDW_RATE		2100
+#define SOF_TKN_AMD_ACP_SDW_CH			2101
+
 #endif
diff --git a/sound/soc/sof/ipc3-pcm.c b/sound/soc/sof/ipc3-pcm.c
index 330f04bcd75d..35769dd7905e 100644
--- a/sound/soc/sof/ipc3-pcm.c
+++ b/sound/soc/sof/ipc3-pcm.c
@@ -395,6 +395,31 @@ static int sof_ipc3_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 		dev_dbg(component->dev, "MICFIL PDM channels_min: %d channels_max: %d\n",
 			channels->min, channels->max);
 		break;
+	case SOF_DAI_AMD_SDW:
+		/* change the default trigger sequence as per HW implementation */
+		for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_PLAYBACK, dpcm) {
+			struct snd_soc_pcm_runtime *fe = dpcm->fe;
+
+			fe->dai_link->trigger[SNDRV_PCM_STREAM_PLAYBACK] =
+					SND_SOC_DPCM_TRIGGER_POST;
+		}
+
+		for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_CAPTURE, dpcm) {
+			struct snd_soc_pcm_runtime *fe = dpcm->fe;
+
+			fe->dai_link->trigger[SNDRV_PCM_STREAM_CAPTURE] =
+					SND_SOC_DPCM_TRIGGER_POST;
+		}
+		rate->min = private->dai_config->acp_sdw.rate;
+		rate->max = private->dai_config->acp_sdw.rate;
+		channels->min = private->dai_config->acp_sdw.channels;
+		channels->max = private->dai_config->acp_sdw.channels;
+
+		dev_dbg(component->dev,
+			"AMD_SDW rate_min: %d rate_max: %d\n", rate->min, rate->max);
+		dev_dbg(component->dev, "AMD_SDW channels_min: %d channels_max: %d\n",
+			channels->min, channels->max);
+		break;
 	default:
 		dev_err(component->dev, "Invalid DAI type %d\n", private->dai_config->type);
 		break;
diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index a8832a1c1a24..0970dbdfa78a 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -298,6 +298,14 @@ static const struct sof_topology_token micfil_pdm_tokens[] = {
 		offsetof(struct sof_ipc_dai_micfil_params, pdm_ch)},
 };
 
+/* ACP_SDW */
+static const struct sof_topology_token acp_sdw_tokens[] = {
+	{SOF_TKN_AMD_ACP_SDW_RATE, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+		offsetof(struct sof_ipc_dai_acp_sdw_params, rate)},
+	{SOF_TKN_AMD_ACP_SDW_CH, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+		offsetof(struct sof_ipc_dai_acp_sdw_params, channels)},
+};
+
 /* Core tokens */
 static const struct sof_topology_token core_tokens[] = {
 	{SOF_TKN_COMP_CORE_ID, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
@@ -336,6 +344,7 @@ static const struct sof_token_info ipc3_token_list[SOF_TOKEN_COUNT] = {
 	[SOF_ACPI2S_TOKENS]   = {"ACPI2S tokens", acpi2s_tokens, ARRAY_SIZE(acpi2s_tokens)},
 	[SOF_MICFIL_TOKENS] = {"MICFIL PDM tokens",
 		micfil_pdm_tokens, ARRAY_SIZE(micfil_pdm_tokens)},
+	[SOF_ACP_SDW_TOKENS]   = {"ACP_SDW tokens", acp_sdw_tokens, ARRAY_SIZE(acp_sdw_tokens)},
 };
 
 /**
@@ -1315,6 +1324,34 @@ static int sof_link_acp_hs_load(struct snd_soc_component *scomp, struct snd_sof_
 	return 0;
 }
 
+static int sof_link_acp_sdw_load(struct snd_soc_component *scomp, struct snd_sof_dai_link *slink,
+				 struct sof_ipc_dai_config *config, struct snd_sof_dai *dai)
+{
+	struct sof_dai_private_data *private = dai->private;
+	u32 size = sizeof(*config);
+	int ret;
+
+	/* parse the required set of ACP_SDW tokens based on num_hw_cfgs */
+	ret = sof_update_ipc_object(scomp, &config->acp_sdw, SOF_ACP_SDW_TOKENS, slink->tuples,
+				    slink->num_tuples, size, slink->num_hw_configs);
+	if (ret < 0)
+		return ret;
+
+	/* init IPC */
+	config->hdr.size = size;
+	dev_dbg(scomp->dev, "ACP SDW config rate %d channels %d\n",
+		config->acp_sdw.rate, config->acp_sdw.channels);
+
+	/* set config for all DAI's with name matching the link name */
+	dai->number_configs = 1;
+	dai->current_config = 0;
+	private->dai_config = kmemdup(config, size, GFP_KERNEL);
+	if (!private->dai_config)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int sof_link_afe_load(struct snd_soc_component *scomp, struct snd_sof_dai_link *slink,
 			     struct sof_ipc_dai_config *config, struct snd_sof_dai *dai)
 {
@@ -1629,6 +1666,9 @@ static int sof_ipc3_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 		case SOF_DAI_MEDIATEK_AFE:
 			ret = sof_link_afe_load(scomp, slink, config, dai);
 			break;
+		case SOF_DAI_AMD_SDW:
+			ret = sof_link_acp_sdw_load(scomp, slink, config, dai);
+			break;
 		default:
 			break;
 		}
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 8874ee5f557f..f98242a404db 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -276,6 +276,7 @@ enum sof_tokens {
 	SOF_ACPDMIC_TOKENS,
 	SOF_ACPI2S_TOKENS,
 	SOF_MICFIL_TOKENS,
+	SOF_ACP_SDW_TOKENS,
 
 	/* this should be the last */
 	SOF_TOKEN_COUNT,
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 617a225fff24..25fb0d1443b6 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -297,6 +297,7 @@ static const struct sof_dai_types sof_dais[] = {
 	{"ACPSP_VIRTUAL", SOF_DAI_AMD_SP_VIRTUAL},
 	{"ACPHS_VIRTUAL", SOF_DAI_AMD_HS_VIRTUAL},
 	{"MICFIL", SOF_DAI_IMX_MICFIL},
+	{"ACP_SDW", SOF_DAI_AMD_SDW},
 
 };
 
@@ -1968,6 +1969,10 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 		token_id = SOF_MICFIL_TOKENS;
 		num_tuples += token_list[SOF_MICFIL_TOKENS].count;
 		break;
+	case SOF_DAI_AMD_SDW:
+		token_id = SOF_ACP_SDW_TOKENS;
+		num_tuples += token_list[SOF_ACP_SDW_TOKENS].count;
+		break;
 	default:
 		break;
 	}
-- 
2.34.1


