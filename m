Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1C7806D61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377944AbjLFLHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377933AbjLFLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:07:25 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE8B9;
        Wed,  6 Dec 2023 03:07:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLAxRUWjBtgz7Bup2q/kUDCjSLA3fKdYvG0rayfVuKY5Hmpmu2cSW/yo0Y5qd7oOutOFb4PkZwE0oI8ZWTDIiL86aaD4KPQqkHfYmtcE4SDl+BcuXUqA3JxELOXxobk5wl2Eq0ECARU8xvwYbATQJslbguWyRBQuDHidZzRHdltpy85xZwsz4GEhJHTCkKkBqC2ksqg47yvmfkxxQPk2xvcFFd6EjvNTGdjHezRykgn5JXnCTJ0JV2j/q027D6OS7sreBgbljGg9cuuPDLP85GR1x25hq+DJ8Jgz/F/aVMOiT1CXnzuxUSWPfNx8KYWq152cKgtwU64OqURjYMNWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEKAv+2ap2RpYec7O8hW6yqQYk+MEILSgfpLaFATnJI=;
 b=PehT5ZGOVnGa+xwVTVJ+PkdSwfG7h5dxdTtD08G2U4ubmK+oTPkpcb0AjlijDwSiOASAMQeWXZ9tdRVg1C91gHZ8xyEto5kC7NBDMcKVY3DExbVeLvQfd4APf75Z7tM0CyxYcBF+aUZQCsm02VqTmmjQWiBXVlcbJ5as4wtNJBBUO4tEBumeC2yqiQjfb0AhnyTaK3thDNzoACaLqHFDDwVTqlg9HSFiuK0Jau3eKbjucEo5U84HohhuQcQ0yCy07IBZTmY9dzVYVNC0z3JDomzsOHCtwcOaoCsWmZ+1AYRs5NNI48Ss0Y+1T8WlLvoV9zIm1wn3LJuSwq2awPhmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEKAv+2ap2RpYec7O8hW6yqQYk+MEILSgfpLaFATnJI=;
 b=kl1ImfvDtNjXAA68zKg27hE/C/cN6ldFnktMNqAXrbOEH7KRQnbizIqnpOFs+q15RHs2BhQSkBdQnN4STJ9Txyv9/aYaAgYHk29tNJg2dM9K9jtb8gnJ+nC/gdnwgs5HZ9fFoLrRcTkDk6Vq7U3eMsT1EqhLpnFQ65l4QWBPWN8=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 11:07:25 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::95) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 11:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 11:07:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 05:07:16 -0600
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:06:36 -0600
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>,
        "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Alper Nebi Yasak" <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <linux-sound@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] ASoC: amd: acp: Add new cpu dai and dailink creation for I2S BT instance
Date:   Wed, 6 Dec 2023 16:36:15 +0530
Message-ID: <20231206110620.1695591-4-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206110620.1695591-1-venkataprasad.potturu@amd.com>
References: <20231206110620.1695591-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b8142a-6ba5-4a26-5b2c-08dbf64b8700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGyNFivQ5Ohu5+Dh/SE+jUcWvaZQvmg4vWgWkF0u3H93mHeesA4jc8J1eJQ44KXJBvQhHdUk2OGdJ9sZUaUAjkGIKyMQmcWxW0Rf5L5Cq4aFHn9HCbGviwBTHnzZIOD+bk6Z47sWHJg41atqkcI53wbDvSumezRRbVUePtcU+76UcUeyM5a5UA2ougBIjJ5SqL9GxOXPRiMHGXV2cp+t7td+punV/qcdf9TXCmWbf9cwKO/JAitYpbXOdyUVPMXsqMgrY8hMH8Hwuj9SCEfK/LjoIMRuKMnaeljPGH91iYi3VN6hnpLl8PRVdNbMaa4bNcyT28kWJQ1eaO+ZRKel/0oyv1O4pkMlfadMXmHh6ND7B6IHmBRSbRi/gDqcx2C491m7Fo8UxDjnTsisHcLelAbXPYcWgenk8cKaeyPI6TUZxG0nEesxSBPNbPuwGQkizVmkri272bP4YZuGQIt0wnersLBb2TxcXlGpklWIP04N2qr2AGfLJ5ra+1nieQscBRaQiBINEHpgLQnXw48lCVHEgD7hjVE4n5qvVQlQCIM9wvqJqBFQtRfw8JrcnR2CUUvX+XldPWJc7vwVBH5Dv6GJMjvLzj9ZJD7VPALbMeiD7E9IMEQDsXn3U7lR0odZRQFOhzvDtu4uYB7F0yV+09IVeSvGwB5PcJbPboUdkfX9XJqSULjOw7xH6iaMEqxIFgfTh9THiWxtDVoaDNXbARuNguPHSvLPvhWGcADSTtjg+Q6P2irrTA/mkLQhdTjTQIplF9PSfiiHWmgo4vbGrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(36840700001)(46966006)(40470700004)(2906002)(86362001)(5660300002)(7416002)(426003)(83380400001)(336012)(40480700001)(36860700001)(81166007)(356005)(82740400003)(47076005)(36756003)(7696005)(40460700003)(2616005)(6666004)(1076003)(26005)(8676002)(8936002)(4326008)(41300700001)(478600001)(110136005)(316002)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:07:24.9891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b8142a-6ba5-4a26-5b2c-08dbf64b8700
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sof_bt cpu id and create dailink for i2s bt instance in
acp common machine driver.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 25 ++++++++++++++++++++++++-
 sound/soc/amd/acp/acp-mach.h        |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 34b14f2611ba..4631af028f15 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -3,7 +3,7 @@
 // This file is provided under a dual BSD/GPLv2 license. When using or
 // redistributing this file, you may do so under either license.
 //
-// Copyright(c) 2021 Advanced Micro Devices, Inc.
+// Copyright(c) 2021, 2023 Advanced Micro Devices, Inc.
 //
 // Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
 //	    Vijendar Mukunda <Vijendar.Mukunda@amd.com>
@@ -1290,6 +1290,8 @@ SND_SOC_DAILINK_DEF(sof_hs,
 		    DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-hs")));
 SND_SOC_DAILINK_DEF(sof_hs_virtual,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-hs-virtual")));
+SND_SOC_DAILINK_DEF(sof_bt,
+		    DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-bt")));
 SND_SOC_DAILINK_DEF(sof_dmic,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-dmic")));
 SND_SOC_DAILINK_DEF(pdm_dmic,
@@ -1348,6 +1350,8 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 
 	if (drv_data->hs_cpu_id)
 		num_links++;
+	if (drv_data->bt_cpu_id)
+		num_links++;
 	if (drv_data->amp_cpu_id)
 		num_links++;
 	if (drv_data->dmic_cpu_id)
@@ -1497,6 +1501,25 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 		i++;
 	}
 
+	if (drv_data->bt_cpu_id == I2S_BT) {
+		links[i].name = "acp-bt-codec";
+		links[i].id = BT_BE_ID;
+		links[i].cpus = sof_bt;
+		links[i].num_cpus = ARRAY_SIZE(sof_bt);
+		links[i].platforms = sof_component;
+		links[i].num_platforms = ARRAY_SIZE(sof_component);
+		links[i].dpcm_playback = 1;
+		links[i].dpcm_capture = 1;
+		links[i].nonatomic = true;
+		links[i].no_pcm = 1;
+		if (!drv_data->bt_codec_id) {
+			/* Use dummy codec if codec id not specified */
+			links[i].codecs = &snd_soc_dummy_dlc;
+			links[i].num_codecs = 1;
+		}
+		i++;
+	}
+
 	if (drv_data->dmic_cpu_id == DMIC) {
 		links[i].name = "acp-dmic-codec";
 		links[i].id = DMIC_BE_ID;
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index cd681101bea7..a48546d8d407 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -28,6 +28,7 @@ enum be_id {
 	HEADSET_BE_ID = 0,
 	AMP_BE_ID,
 	DMIC_BE_ID,
+	BT_BE_ID,
 };
 
 enum cpu_endpoints {
@@ -68,9 +69,11 @@ struct acp_mach_ops {
 struct acp_card_drvdata {
 	unsigned int hs_cpu_id;
 	unsigned int amp_cpu_id;
+	unsigned int bt_cpu_id;
 	unsigned int dmic_cpu_id;
 	unsigned int hs_codec_id;
 	unsigned int amp_codec_id;
+	unsigned int bt_codec_id;
 	unsigned int dmic_codec_id;
 	unsigned int dai_fmt;
 	unsigned int platform;
-- 
2.25.1

