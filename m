Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3397775F36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjHIMgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjHIMgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:36:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113161BDA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvRMQq45XkVt/4UA226vlO3etCPHGQLZphF4oaDM5hctSqNtOpCpgfs4O/hTsuJMVjuNg0Z7UFuG4yPnFXdyyw3T1oMkcW1saCDSRk3fzmwgbCiOmgeONsl4ZiFEBmm09SyudJmbvgfiK830UXEX7EVY0qiIPeZASHJFUa2rc0/w1iGalyT6OpNo6qRTt1z0qw1lEZw6HzsZhD+pxOWP33zGgPLeSbUSPPLzhJK/5gTQZ4Fdz9u923sikh035VvhIsHpDCu1d07nPLd0gI4dL00hmFS/YSlg9Mp2yk5+D2uWyefiBSv6JlTMXpxENjQqJ9Xv6aMUgwu/KJESVHhlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpOYnRoxLYyPMfOxvaLtJY6B1rcmcV+CpMydwGzvar4=;
 b=Nwo8SkWlxybK5BZrnZsq9/YzfyBZEH/KZq9mEUsAwp1fDw3jKEly7MUm/qMzrSyHfwF/K9TALcBd7IJFbuu1bzC3tcBWKRrrRfhyu1ei97Y3N90l58b8Jl/PUrxwh6+fa8KcBLDyRVNbcnTDr/67lgWl7oJgU0/Jbg1KFkkFOHONnITt4insLBpYiMA3akYQrQ7l0Z9/8s3Rp143RTnpIM3Zlio4ls+nV7qg0mGNjSteqX/vxB5aox4MRMjhD0wjZDt5yYH+D42FL4mhkCJrdS716OfGhii2jkHVDXmM+0jyvjwyOd0CanDeLDcfVG79rOnlCTWFCQTNkyH+3vZttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpOYnRoxLYyPMfOxvaLtJY6B1rcmcV+CpMydwGzvar4=;
 b=wbSpPVBw9Q6gITxgv+5ZysrWVHdyqWBAqKwk8mRxiqSWcP5hzy9tQ2VT2dncBpyjbQoKR/WmkmlAw+2IJTjClrAavhGsI/16OTFs8DJCfRsCmG6yy9UScT5sri/lDQuHu4BD794YsH46pMdWQ3xJUKyjZoULceYOJ4hMzvmwJ1s=
Received: from SA0PR11CA0178.namprd11.prod.outlook.com (2603:10b6:806:1bb::33)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 12:36:34 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::75) by SA0PR11CA0178.outlook.office365.com
 (2603:10b6:806:1bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 12:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Wed, 9 Aug 2023 12:36:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 07:36:33 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 9 Aug 2023 07:36:17 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <syed.sabakareem@amd.com>, <mastan.katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: SOF: amd: Enable signed firmware image loading for Vangogh platform
Date:   Wed, 9 Aug 2023 18:05:22 +0530
Message-ID: <20230809123534.287707-3-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809123534.287707-1-venkataprasad.potturu@amd.com>
References: <20230809123534.287707-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ba7eb9-fab2-4c9f-ec81-08db98d54436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwMF4nsi3mzkZ/9EWe4sRV1RJDxW5/ilU79nObg2iQSQtyTQmqaI3sBou4RiS+P3HnGERsT28C+18BZSIv1bv92SAFwjdjm2nr5ZCJxCrarDwaHtEgfJVfRIeIGac2D0GvI7hzMJqB8zZzapQxvmjS+1IUy4A0rtw1a4f/JAQkwHjfN6LPeAIoxv5Vr//U99FDi9AZm/nUMHaLFR/6qeSNoICAyOcDRpIEKwOd1oOqaPwoyTD23M4zYAWQ1ROZsV0NisQ5MyrOjXW4R1EYV/WwARDzfh2vnHWShobM8G7Hw40QfNK/ZRKkcb4t6Ksm/I3hhhpec66OzGb2XT99jmzMp8v/oMkl0tVRob9Nu+QUZaRJmxjOKicLHZTdwxpcJSqYTkGTkljYBzi4N3Uq4E+IWRQQKrXBWjC2S9LhWw4Mqkup0RahQBvMi/VG6M/khNC06iCseqVHjyeQcLu3gaI9UhxsKrr4mreibu9OmxfX/UJ2QYCfqy3w8bkKOmjDq8r0YlHcxT9zWMDfExKKSAIhgrv1xc5gQQJPfqz4OBAXgUWw7+qwtkMyjTTSLwWpn8f6IFkAHJuLJW2AOSFqkpaUtrgRSGIG+2pGlDDmcrp1oeTKGp5ltvJZ1nx1xFDZjkiulaRKwXsHDCBWbMQOj3oWHL4/TiEu0SGiPrQzeu2rdcehl4JQ2CvsbpvqLhTfEMv10iA6olYHFV8fxVwQWbJVplFxkBjreqlfocnsRdxHKCan2Fq0Y7Tcw6SdlsNtwNBffvKVBKL3I/mqp5srNVtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(82310400008)(186006)(1800799006)(36840700001)(40470700004)(46966006)(6666004)(336012)(356005)(82740400003)(40480700001)(40460700003)(26005)(1076003)(7696005)(70206006)(70586007)(8676002)(4326008)(426003)(8936002)(36860700001)(316002)(41300700001)(47076005)(36756003)(54906003)(110136005)(7416002)(86362001)(5660300002)(2906002)(81166007)(478600001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 12:36:34.2338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ba7eb9-fab2-4c9f-ec81-08db98d54436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable signed firmware loading for Vangogh platform using dmi quirks.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/sof/amd/acp.c     | 31 +++++++++++++++++++++++++++++++
 sound/soc/sof/amd/acp.h     |  3 +++
 sound/soc/sof/amd/vangogh.c |  6 ++++++
 3 files changed, 40 insertions(+)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 0072a62aa4ef..b2e00a10a03e 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -20,6 +20,22 @@
 #include "acp.h"
 #include "acp-dsp-offset.h"
 
+#define SECURED_FIRMWARE 1
+
+const struct dmi_system_id acp_sof_quirk_table[] = {
+	{
+		/* Valve Jupiter device */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Sephiroth"),
+		},
+		.driver_data = (void *)SECURED_FIRMWARE,
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(acp_sof_quirk_table);
+
 static int smn_write(struct pci_dev *dev, u32 smn_addr, u32 data)
 {
 	pci_write_config_dword(dev, 0x60, smn_addr);
@@ -468,8 +484,10 @@ EXPORT_SYMBOL_NS(amd_sof_acp_resume, SND_SOC_SOF_AMD_COMMON);
 int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 {
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	struct snd_sof_pdata *plat_data = sdev->pdata;
 	struct acp_dev_data *adata;
 	const struct sof_amd_acp_desc *chip;
+	const struct dmi_system_id *dmi_id;
 	unsigned int addr;
 	int ret;
 
@@ -531,6 +549,19 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	sdev->debug_box.size = BOX_SIZE_1024;
 
 	adata->signed_fw_image = false;
+	dmi_id = dmi_first_match(acp_sof_quirk_table);
+	if (dmi_id && dmi_id->driver_data) {
+		adata->fw_code_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-code.bin",
+					       plat_data->fw_filename_prefix,
+					       chip->name);
+		adata->fw_data_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-data.bin",
+					       plat_data->fw_filename_prefix,
+					       chip->name);
+		adata->signed_fw_image = dmi_id->driver_data;
+
+		dev_dbg(sdev->dev, "fw_code_bin:%s, fw_data_bin:%s\n", adata->fw_code_bin,
+			adata->fw_data_bin);
+	}
 	acp_memory_init(sdev);
 
 	acp_dsp_stream_init(sdev);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 842105330369..19cad4fcf99a 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -11,6 +11,8 @@
 #ifndef __SOF_AMD_ACP_H
 #define __SOF_AMD_ACP_H
 
+#include <linux/dmi.h>
+
 #include "../sof-priv.h"
 #include "../sof-audio.h"
 
@@ -297,4 +299,5 @@ int acp_probes_register(struct snd_sof_dev *sdev);
 void acp_probes_unregister(struct snd_sof_dev *sdev);
 
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_vangogh_sof_machines[];
+extern const struct dmi_system_id acp_sof_quirk_table[];
 #endif
diff --git a/sound/soc/sof/amd/vangogh.c b/sound/soc/sof/amd/vangogh.c
index f3f6bd790788..de15d21aa6d9 100644
--- a/sound/soc/sof/amd/vangogh.c
+++ b/sound/soc/sof/amd/vangogh.c
@@ -142,12 +142,18 @@ EXPORT_SYMBOL_NS(sof_vangogh_ops, SND_SOC_SOF_AMD_COMMON);
 
 int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
 {
+	const struct dmi_system_id *dmi_id;
+
 	/* common defaults */
 	memcpy(&sof_vangogh_ops, &sof_acp_common_ops, sizeof(struct snd_sof_dsp_ops));
 
 	sof_vangogh_ops.drv = vangogh_sof_dai;
 	sof_vangogh_ops.num_drv = ARRAY_SIZE(vangogh_sof_dai);
 
+	dmi_id = dmi_first_match(acp_sof_quirk_table);
+	if (dmi_id && dmi_id->driver_data)
+		sof_vangogh_ops.load_firmware = acp_sof_load_signed_firmware;
+
 	return 0;
 }
 
-- 
2.25.1

