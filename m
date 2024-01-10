Return-Path: <linux-kernel+bounces-21914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9915829685
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17AF1C25191
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6C41776;
	Wed, 10 Jan 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kGzVZvb5"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258054176B;
	Wed, 10 Jan 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrYZkImzjumVvpBlTOlzr1bH0t2lKjADeY7N3xkFSNz6xxA84VxMgCJvrAck1j6X2yR/SYkc4RqutzfydGM0rXN5dE4WKV3HV8uOdgdhJkoq/EdoBj4i7e9LyCAsrUHiie76q76egrGuxshhHHuBZHyz40MLW8HRTl3JCULl/r9aW0DJyzEmLX7d9R45oSZuezeqXbx3pOvG1Z7UxZcUY7zJWoc1E3Zs0Ey+HGLK274NWh7VkloPQMyVUfd4c7bge7O6Nm11ex817v1ib27pD1N9qAmbDkBCxzgw0d6pzbMfMQ1gfcRXtHTdSbgqSX6WAJRxJ/wnpa7N+bJIQtLgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPqL8D8sIUEJdIE9QqRF4FLGLmz9V6QPJ3PtGhXMEUs=;
 b=oU169gaVICu9daW8zIp7UQoXvprY5o+bpPKEHh5ZSLhXFvjqrSpu20q9gYR9xClH152o+RnGCpOlFD4Eiobmnd+E/qi+xAJ0ONnihtRwT3RVlPzn4NPWACMJuxudy/xRptrSSSG+4wu6LA8ur212Pd8psEXPyPUIZHdvlUx5Hw1g9Lyto6BPb0opCioY/BfL+PCbnTVCqf5lDCGKdjzo8ecqhVBdsFDNIuleYDJP5m1aPxmWMu1kGTcZjI648VedodR6x6J2dpKoSOb1PsbdRlNKxCc2DcocJZpb+BbLBhKpDXNy3tYKGT0jIgxEzo1ZOEcsiu5gAPNJlqQ3++My/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPqL8D8sIUEJdIE9QqRF4FLGLmz9V6QPJ3PtGhXMEUs=;
 b=kGzVZvb5BE0gcM8aIF345Zv/5HMXLlsgdyLQvJba/A4vKZ1HW9WwPNbeBkiWyDmYS+P1iqaWeTtb/TTIJhjJ39NNHzdwYZas9FRmisFLyeMTxmzXcgLI8IQuS0HUquqfvN10H17mFZRpv5XVWgCpBAmcFXp6UnK5+J8CMR4lzEw=
Received: from MW4PR04CA0201.namprd04.prod.outlook.com (2603:10b6:303:86::26)
 by CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 09:46:08 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::51) by MW4PR04CA0201.outlook.office365.com
 (2603:10b6:303:86::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 09:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 09:46:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:46:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:46:06 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 10 Jan 2024 03:46:00 -0600
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
Subject: [PATCH V2 09/13] ASoC: SOF: amd: Add Soundwire DAI configuration support for AMD platforms
Date: Wed, 10 Jan 2024 15:14:12 +0530
Message-ID: <20240110094416.853610-10-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CY8PR12MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cd55b6-e912-4a9d-c279-08dc11c0f86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Id7qoyuNQh78xXTOdqbx5uxszobWc7J+pAo/DxpGimGphjogA8f6hEkd4UE/3JhYKntvwJUuZ8J48Tnl6dgw1+O3zqYP1TMkSKv3quYiFmAeVgk4zpHb6dJBcUFe//VVIEpOSb+bN60OgBu1onOKAPZvvp4NjwyiScKa8xjpAge22wisWhhe3YY6+im/YsVBU/Qg0YzS+NzlyvDu9m1c5Okg5flGwKKtkU/mG4P1eMd16UAl8jxBYbykgAYUNb9uO/JdoCooId7VlNiGnBOFQlk2+hjN02w4lReJuHKUQ5KYiHxS9Jm/V88B7+zFWpQUI/wML1mtehuEAf7yogjpW9g0aq1QaoeKSmDMPQVbEoozV3N0DlrTnuO+fJYdPvhUTVCO1AcR2GsYmWjHSFrmGzQBhJ/JDrKlJr7koqhjW4fjdD9YBOPN+QAtazHlVwfVMXKpzwqizBotUKcWMwMlmUMFxi3VfYhJPLEnk6Nl7nlfmbEm7zFbMg/bVOmdZZGTieL9cNGaS3otFO/1PuaIykigbfnKzZfAxiZDkiQMFwN1VYIoWrC9sjM92Dhsq0s5B5jqEPAIlBWEkcjLBZh84CUDELSvE1Tk/Z1lqfrsVmdaGbYsG2xQTirn13avKcORzZFdsh/FuH5/dgj2cRU5TQyl8IFyFnrqj8Mv3m+V3CoDqwMOfFrxDaSRoRHrzmyZ/QHuqqofQSHvJ5llTyjPbhIDQyLy1a429D6Q5mmxKQJ5uAzYMZO0J+ujPIWHY5TCH8C3SLvmWSGka5A3Z7rz7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(426003)(7696005)(2616005)(1076003)(26005)(336012)(6666004)(478600001)(5660300002)(83380400001)(316002)(41300700001)(2906002)(36860700001)(54906003)(70586007)(70206006)(110136005)(4326008)(47076005)(8936002)(8676002)(7416002)(356005)(82740400003)(86362001)(81166007)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:46:07.7672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cd55b6-e912-4a9d-c279-08dc11c0f86f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098

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


