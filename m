Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744D4785177
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjHWH1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjHWH1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:27:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22576FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqScS92G7V+RjWGXv2XXV97lGB8pKhXM/mdLc9qA5Ulk0LO+heLjDL5iZ8JOXaZM37fpV4uZdAtB6Qy3lQbrT8UxPykeVKrn9/mspAk0BivjDOEI2cMXj/r8Dostbh1jTSC0HlAg4b5R6Z5ynCgRrPNmEzUT7+5CDJ8W5V5Ht00vOzgWv7B1WLYmieZEG8lI7PJObD/ljPfrApfhREzu7KyVArN3kSXH6uETQVZ3JjK7HUNM4bES72cdZF/Kban93e3R2z6unZ85AjOWdd7Kx39t8RZOBNZqeWkuTEwaqwwOmzloYv210BL64VKWlzz3tf3uPmPJUybpEybBEMvEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA/a8B5QHiscWxlk6kSBSn1FQkZ3Bib5mLSeCksjWzY=;
 b=oZo45VLSNtRf9QBtmLHbh3bnV7i2+D9lemtKVzzkq7t16gzGKNz3pIyTZJW0kwneiPSEBiNRim3Mz2bYjumOgjG8yiQiv9dfABaDMc2Ux3v2HE2bGMrXElkdBc9g7uic4uP0cumZteJwwpn5BUiRANRwJFItV7ww8r8sTgmrA4+QuwSa8VLsK4OSCJ0jFSixoUBtn9FOA4NOhnr0kFET2yLP8gmwd0zZ2aEO5wEf1l5eV70Rvueijdr4VIommAsaNpaVnfe+Bvwrswt6BTqLAloZCG7++4ARZc/nlTBJsUr8YSbPDKaZP4Tcne6ti6CCb2pjb1LYwoZGFd//0KNm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA/a8B5QHiscWxlk6kSBSn1FQkZ3Bib5mLSeCksjWzY=;
 b=axA1juUWUHXBKdDfBRJf8inVw6JxNQunjwQ7r/gqkqlTvke6LWH5aNp0KnS2gvbqJI3ImqimxC0fPVmXU3yDBHwdhXQqIGeIuIzH2airgGBCokBBnOkp4XvTvuxq4pLbsqvwxGubDdPn20O4mHGgl8aCF2Y9luqUcmfd3PIAsfw=
Received: from SA0PR11CA0100.namprd11.prod.outlook.com (2603:10b6:806:d1::15)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 07:27:24 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::d0) by SA0PR11CA0100.outlook.office365.com
 (2603:10b6:806:d1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 07:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 07:27:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:27:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 02:27:22 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 23 Aug 2023 02:27:17 -0500
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
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] ASoC: SOF: amd: enable ACP external global interrupt
Date:   Wed, 23 Aug 2023 13:03:34 +0530
Message-ID: <20230823073340.2829821-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
References: <20230823073340.2829821-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: f8368a7c-a5a0-4fe1-6666-08dba3aa6577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izO9kYVQ/ljtSYm+rwpcKPTmYn/RXuwsVnE5faBKLREJn1b434LeKXhRtMKDYYHRBPWB8aqP9vqw9xfojZCj712MuIxXyd/M5dhlg0IBXsNaapx7DdcQHD0crYI82PqILXaPpijTErQfsCLueZeRzmLkPxfTxpbXxu/Xzkq0DR/zLN5CfUMVgBpIIgF/WjBNzFEusdFR4rmSjQ5NzmpO/WG5RXB+U4xPbJm61uFEabX3juY8pXtozM+3UGaW6CkHqwQsE9EMtwQ38dVgI/5pNT6l1kTDTZNFC1Va+QTlnbekYzS95RFNN7QOzVRsFGe5OTHyXBgZ/aDnDM8L/Rk6Izt+JhpQx5bWY0sN+XSERYHg4yg/YQHoPQ0YRymiE8hzk8vZKglSp9CiWTs888Px52NyOafOSBQLsl3lLp2kSoOe3yyfVlKOKP9U/5F1kHFIsSQanBS8zU8Z9t+GVkp2dv0QNosOGku+C9mUFW8/YpvgUs1DUftpdYoMHnmCZX3dgd4BCH6O6ebisBtTg8CgRBah1wrhc+tki+jETLhF0XyNCYHLgnhUSFMIkMCtq3M2lj3c6FPYThrMMudJ7s3fcsu0EjkGLKYKJ5iobeFc7RvTyTLGyGl58vCQAy1UvxhvBmhqWp8ZR/ZUFPVuCUJvl4BbNxL/KxYIp7jqcO79DIrsKvZiPqaSOGkxPBpFk3qxcYXteARIwi18nQh28lZIdAW8C0h38G2zjs2COhi/AOjZAUQlmB1yPfD7Caec3G12zQSzfBnnJAHrHStf+a6ooQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(7696005)(316002)(6916009)(4326008)(8676002)(8936002)(70206006)(54906003)(70586007)(40480700001)(41300700001)(426003)(336012)(7416002)(26005)(1076003)(5660300002)(6666004)(478600001)(83380400001)(40460700003)(47076005)(36860700001)(36756003)(86362001)(2906002)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:27:24.4523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8368a7c-a5a0-4fe1-6666-08dba3aa6577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously ACP SOF firmware used to enable the ACP external
global interrupt register.
This will restrict to report ACP host interrupts only after
firmware loading is successful.
This register needs to be set from host driver to handle
other ACP interrupts(SoundWire Interrupts) before loading
the ACP firmware.

Add field for external interrupt enable register in acp descriptor
structure and enable the external interrupt enable register.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 3 +++
 sound/soc/sof/amd/acp.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 630c2c5fe4c7..651b56388cb6 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -420,6 +420,9 @@ static int acp_reset(struct snd_sof_dev *sdev)
 		dev_err(sdev->dev, "timeout in releasing reset\n");
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, ACP_CLOCK_ACLK);
+	if (desc->ext_intr_enb)
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_enb, 0x01);
+
 	return ret;
 }
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 19cad4fcf99a..97bcada822ef 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -174,6 +174,7 @@ struct sof_amd_acp_desc {
 	const char *name;
 	unsigned int host_bridge_id;
 	u32 pgfsm_base;
+	u32 ext_intr_enb;
 	u32 ext_intr_stat;
 	u32 dsp_intr_base;
 	u32 sram_pte_offset;
-- 
2.34.1

