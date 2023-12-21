Return-Path: <linux-kernel+bounces-7951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1B681AF99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DAC1F27A84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1170179A6;
	Thu, 21 Dec 2023 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SMmWoVT2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45732CCD5;
	Thu, 21 Dec 2023 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9f2AtxDNlVZTJU1GyH2xXLp2TWOEYu6Qv7SFwNO1iLil2OBNOGhJytWgDF5S7e+NNQ5JlRYB7JzuixiTir8HGIDgTYifMEFm0MYKyTAPHFj3dsF0TcGa+U3CCjDDDFZh07OYIavCcmQSxtDTkGA11MtI2PVfTy8lc9owiTEGBF3S34vrveXax9GzgMIilKYh7SoeYI+VIOs5Ds4YWu9iNsdlTr7OnL2O/P5oXAFiiucOFvYORARC3La/P8hzHed4mYhcMcJwW1NwtMmgbEL15wzXv7Pw3JEq4870BZv3Ml/8O99cNvQoSeHQy09DidB/Pr1h+HFd+y16SnnnTGmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPqL8D8sIUEJdIE9QqRF4FLGLmz9V6QPJ3PtGhXMEUs=;
 b=oJHAVPvU7U5mNGqokA5Mi9p7/6Q2Rj5Ajgau3+gzzsJP50/fDRFF5AG68MQ6YvGkABeDBnaIFxu6ODZxdoG7pcGoSuozduJsvaMZR8mKj5GUimb+QQuTnMMXUSHl6VlOAbb09Z2NjNSm5h/GpEQ9aIqCSIwH1b8+QPjb6LC19H1OfI/chyA62w+FtZmdyjrwqW4PhrKfFMc2EkAysKSZFo0WzTL6BttbwWCKbi1IP8QaJpBV6Uo8nCyPj3GXIF7MJOaqo1nDHCrJ9Y2roDgVmZQz0xa3+X8E9SyPGV1OPOh+blEo5TL/IO74LjthUR8M5G3Th58slfZC5HdPdeQBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPqL8D8sIUEJdIE9QqRF4FLGLmz9V6QPJ3PtGhXMEUs=;
 b=SMmWoVT2nz1EOPyvm4KEOF64A03ERPiH83csBJmZ3bGkKBdpqSauuxbZmy0DYE2DbEjbqjHntCMp5WkIk024mezR4F+T9Ae6/fSqduWFy78wbjJcNb/7DQ8snNyDkkehlI0yhL7rd6+BfpTTFxH7N//hgrUs4Gv749EFNkeLHWk=
Received: from MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::18)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Thu, 21 Dec
 2023 07:37:33 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::84) by MW4P223CA0013.outlook.office365.com
 (2603:10b6:303:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 07:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Thu, 21 Dec 2023 07:37:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:37:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 20 Dec
 2023 23:37:31 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:37:25 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <pierre-louis.bossart@linux.intel.com>,
	<vinod.koul@intel.com>, <venkataprasad.potturu@amd.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Rander Wang
	<rander.wang@intel.com>, Jyri Sarha <jyri.sarha@intel.com>, Curtis Malainey
	<cujomalainey@chromium.org>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "moderated list:SOUND - SOUND OPEN FIRMWARE
 (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>
Subject: [PATCH 08/12] ASoC: SOF: amd: Add Soundwire DAI configuration support for AMD platforms
Date: Thu, 21 Dec 2023 13:05:54 +0530
Message-ID: <20231221073558.3181911-9-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: c11d4c3e-4c01-46c2-c138-08dc01f7b166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zl3+WeUYdqYcvWqlZLKjEB5JdV8IE4CnI7ulcaqb6wo4tuKz6lTEVYyWOoQIimAWTcNGr14nEO6N5RFLzQZQfWAfJcYXOn8yyvgUI4uiPLqFrSD5QHrKZ2U3thuoivGikUcJbqcqhjSms/MfZi9uyoPhkMtBZPFG2i+E4dJd2FY6ynw3NbHXUXmet9tmEIku9rni3QlK2Eprv2V6y3yBDFRE9gu/TTq0ES3V/1XoZY8wp04u+A36Wu1j5KcbqiDumP0yDD24IUkudiimUSwNM1qxRJi1Y3yrPJ/FMH+/sdr6riljSKrF/MrDqSjGeWV3MLyxY4SJ4B3F9/WGWi7LOutQb2YlDdCH3PgxDjAmWGYnh8sE0pFbcGt2MLSuhJGfU3gitLU4RqUmwRiMxXiIlDJZOn4+dSHAWDKGuu2HouMdMiDy7eQeyKAkNvG2mn/aRm1Gl4jZk3SiUd3J+Hsr+CJZCQxMOzl8BlzlmKAhY8Qtg7wHrP5uT1f3T14DDviz8y/Sm6id2m8OnRnxWkPRHTngx8rs7a5Gpc9x40mqEBZAMKXkCul1Y4OcM9EnqSl2hkxZLf/iWHdNF6PWNkocG9adURG4HysSJMASyiEyCjb3IhUEMChtiSFbTNrtqYz16Z7joYfcIJNVqjtv6e7Ka8j0QD//m0X4MvcZjBySI9PESvinCSBAfGfJxw0Q8fP4WAwmpDJETqFsEhry5nrhnEvf3QJE1hFte4u3oSM8RGtmx3HwdYNg324Hl8vZHiAkSZrkcG1llQHZalaY2vU2ow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(451199024)(64100799003)(1800799012)(186009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(336012)(1076003)(7696005)(6666004)(426003)(2616005)(26005)(82740400003)(83380400001)(81166007)(356005)(2906002)(86362001)(36756003)(41300700001)(36860700001)(8936002)(110136005)(8676002)(5660300002)(47076005)(7416002)(4326008)(478600001)(70206006)(54906003)(70586007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:37:32.2900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11d4c3e-4c01-46c2-c138-08dc01f7b166
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891

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


