Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69E7785178
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjHWH2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjHWH2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:28:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EDBE6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDkENIdJx9P/TpcOvHzVmDoXshutskRL7eM5jXXc3k+3zVgSyB/QjzywcfJ7/g7ZNLdzLDrEVaULut0wo+1NPfByJMvyO4+YHTQzynezHlUOPZrcHkjXomNTya8uhVA0xrpnD29DL+txhWUTDgPMfyS/XBKs8pr5ZhxZPFi6Pg8O4IcvgEK8uGbYfVesWTCqHprjwFUjyI37/y3r9HMbp/zX6WvAmwRn1YMHOrCb1o8OUh84pJ82fle56nyjBXohNyKX79J9NtC8ShMvoc9Z/dtFIp76YX39q3w5+dS2WfuT3MM6Okj/NJD60d+LDPoYH2wQBtUOW2d2PeFuETemiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyNretq+psH3Ob4bYZt/zMZiJlgmAkJJrRKdM/9Jh4E=;
 b=BkjK8Mr3Rk4un+DXFhhRvhEgakakyR3QTPFejbVs8BehumYjwoZFPsOafAtjla+z2D51G+lPIwZPQQh6U8/qT9IjUulMSDuz78pQEvW7SSH4MeNSnfufSwquTYA0YZQ1oI/6tg3dmHqb43vmo54viAT7hjtJyWTW/EP3TCtnegx7upV0xz5OT6aNoA7/iCvtuAiKSK2VLzPBK+B9qLcCBNPJK/5cDXTUJwp8MB0MbPxehDFhHI0sLo0EDPvQky3aU+mSvhANovAk9JPZJefgXOzCqSIqV5aVV65VLrHVwYFQLajXUTMviIhM1HHlJPpu0mdCxhOlaeZs8CFi9vnNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyNretq+psH3Ob4bYZt/zMZiJlgmAkJJrRKdM/9Jh4E=;
 b=MOQLbbBJWcKE8Qw4DhBMRqA+pMQn5/UXPluRjG1l4TA1dPLLOZ95RJnOiukDnjTj9BJRxCuOgl2YDsYGdbNzCJu6kVp5x8YmpObQiiuePH45J33PEQk1OkqZz9MWynUyS7u7kP/+MV7e/u6jYj/JknpkmSELG8V0691/IFcQ8Ek=
Received: from PA7P264CA0361.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::23)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 07:27:41 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10a6:102:37c:cafe::ed) by PA7P264CA0361.outlook.office365.com
 (2603:10a6:102:37c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 07:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 07:27:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:27:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:27:31 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 23 Aug 2023 02:27:25 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Chao Song <chao.song@intel.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] ASoC: SOF: amd: add module parameter for firmware debug
Date:   Wed, 23 Aug 2023 13:03:35 +0530
Message-ID: <20230823073340.2829821-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
References: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 638a4ba4-5922-466b-a700-08dba3aa6f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vrd4KNvjl9RHILpqKPRtHPuhaVqjT2laCJ2CeO9tYCFQ+eZefN7DQGJHxdVdvcJXCkfUSKwNLgcDJtIW9JMPTDbe7JtoR4/3dsRpxQLjUuMnM6QPZVv+g5SEPUDXY6h9JrmneWID40QyGwPAg8aNjun8z03xsu4OloQ28BD93zEjbylLsY960gjy0SWADZQbPDDY9T1HX55oIWGZYq+GlEnsHAMsMRYkutkVNn3CF6J6de88H/HON3m6/HX/lI9Ep4Cq+YGGxmN3fbCEbmh07yk5AF+vShP30MSQgLXZBfSfDBEvgJirQJiMVlegzf6L8sus/i4CkoYGKPqJl3vkbQ6PjIQmUzILDz1W5eLP42vjFXY8fi8z8uKsMWrvGYmyBWGIFVv1tWJG3wHDwzIMAEVgDIizbEcnc18biuatn4YmA6QJoKwApUCQumiyVs02T23SP/+W/oyHegsYQH37Mck1uEbrIZltrPJL8eA/CsOcTlKIXW021woe67GFebQ+G5IILbU/FfDWqHhTyH1DitGqvG/gU3uIGDMr90xugi6oM4Cc/rn4det6TwE33VhadyH/J1HDs9Ddb8OHjURZQM9HWgL/mDXlNQNg0Kr3YpDRBjftum29cHRsoXDNDTo9NFiOpqL6fWHFHBxAB/NRDbLk8XPxXMRYKOOrq8iplL7RfzxYZAZ42N/gtH3mpCTcAulKJgm36DzYKkl7tc9w/3mzd1+PvGH5BiR9bG786LdRo6cw96yHSlCsxFrcEJ5Gc31iojvQOgOYkztxkHEdiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(70586007)(316002)(70206006)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(81166007)(82740400003)(478600001)(6666004)(40480700001)(83380400001)(7416002)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:27:40.9650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 638a4ba4-5922-466b-a700-08dba3aa6f4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add module parameter for firmware debug. If firmware debug
flag is enabled, clear the fusion stall bit which is required
for enabling firmware debugging through JTAG.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-loader.c | 3 ++-
 sound/soc/sof/amd/acp.c        | 5 +++++
 sound/soc/sof/amd/acp.h        | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index a63c00b53a5e..a427673cfb03 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -207,6 +207,7 @@ EXPORT_SYMBOL_NS(acp_dsp_pre_fw_run, SND_SOC_SOF_AMD_COMMON);
 
 int acp_sof_dsp_run(struct snd_sof_dev *sdev)
 {
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	int val;
 
@@ -215,7 +216,7 @@ int acp_sof_dsp_run(struct snd_sof_dev *sdev)
 	dev_dbg(sdev->dev, "ACP_DSP0_RUNSTALL : 0x%0x\n", val);
 
 	/* Some platforms won't support fusion DSP,keep offset zero for no support */
-	if (desc->fusion_dsp_offset) {
+	if (desc->fusion_dsp_offset && adata->enable_fw_debug) {
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->fusion_dsp_offset, ACP_DSP_RUN);
 		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->fusion_dsp_offset);
 		dev_dbg(sdev->dev, "ACP_DSP0_FUSION_RUNSTALL : 0x%0x\n", val);
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 651b56388cb6..ebc985e2aaad 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -22,6 +22,10 @@
 
 #define SECURED_FIRMWARE 1
 
+static bool enable_fw_debug;
+module_param(enable_fw_debug, bool, 0444);
+MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
+
 const struct dmi_system_id acp_sof_quirk_table[] = {
 	{
 		/* Valve Jupiter device */
@@ -558,6 +562,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 		dev_dbg(sdev->dev, "fw_code_bin:%s, fw_data_bin:%s\n", adata->fw_code_bin,
 			adata->fw_data_bin);
 	}
+	adata->enable_fw_debug = enable_fw_debug;
 	acp_memory_init(sdev);
 
 	acp_dsp_stream_init(sdev);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 97bcada822ef..4dcceb764769 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -205,6 +205,7 @@ struct acp_dev_data {
 	struct acp_dsp_stream *dtrace_stream;
 	struct pci_dev *smn_dev;
 	struct acp_dsp_stream *probe_stream;
+	bool enable_fw_debug;
 };
 
 void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src, size_t bytes);
-- 
2.34.1

