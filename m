Return-Path: <linux-kernel+bounces-21917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A682968D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B61B265B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBB3FE50;
	Wed, 10 Jan 2024 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nQoV2BY7"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC83EA93;
	Wed, 10 Jan 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqIBHz6Syps5pQYax0bM23RdHfnMf1I4tcZJkkRF/0JlbMxVCRSHdXM8tKrUybKyRFKFdTFwvB4c4/cxivIIxD7I7rVIqfzchpzgg8W2Dh5YmOjgwX3ZawsInWdwSp01UPu6cDVxb4tCHvkyDvLQchI4ZUNPbspoweI6u1nZUkqhGufnN66uL36mOd/aS0NkaPBR+aMPJmGuYnZ5vtg9uR4sIx1OszIqSR+1aNcPzyZ7YzXh789BfAZDufeUYf4D96FEXV0GIpq4wNnHAaxlAeSpvltQfor+p32JhUK2B//zsP8EHlVMPF8MAIwYVit9XAZznvo6bZYj4dSbfT4JzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+omCGRhppcTZgY3hpYmOov+emvix6/ZrChbQ00XGnbg=;
 b=cXz3izFsWyLGodxCnmpgxoxKF9FUhZ+gsN3s18e5dbGRDEX8rCMjyCgZ1LyrwHMR8av+Ys8h/eQAZehFF2lAbZ6W4wuxbfC0hcyPaOzaODYi4DLfQNHwDK+3o9YjRDIn86aicsdcYoMCcppbTKWgKk3vzYFw86hnVNOTwIUyYgJvlTkPoE7hwkTJzNFdscXZcTJWCdMWtAXSKBKSFKueoXEqGuAQPbC7xnpJht+U4grJvWaUmw5NKDokgWiPg/sau/d/2gbU8V2XLwBMzFTWOU4PW5zmGi48n6QnSMKNglgSxH+Uy/vbxTWW7vqMlKKP9pKyWtnZM7jbSvbgWhe5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+omCGRhppcTZgY3hpYmOov+emvix6/ZrChbQ00XGnbg=;
 b=nQoV2BY7w5FMD67IqbsmasVHDPI6McIfu55kK73Z0ccYB0/hweaQF+Fpu7Ih1x1v8iNs68THuRPp30PhNivGYMv/IFg+3l4is5iKD64NiS4hXQU0x72WXmVFN7SK6wOdMA/DdptrjF1dLMJwic12E6/EMJFxPwwBAHzewAjJuP4=
Received: from SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::16)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 09:46:56 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::a2) by SA9P223CA0011.outlook.office365.com
 (2603:10b6:806:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24 via Frontend
 Transport; Wed, 10 Jan 2024 09:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 09:46:55 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:46:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 10 Jan
 2024 01:46:15 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 10 Jan 2024 03:46:10 -0600
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
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, Wang Jinchao <wangjinchao@xfusion.com>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
	<sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 10/13] ASoC: SOF: amd: add machine select logic for soundwire based platforms
Date: Wed, 10 Jan 2024 15:14:13 +0530
Message-ID: <20240110094416.853610-11-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b53974-4634-4983-83ed-08dc11c114e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EmIheZwDmI97de5OiQDW5WCnSD8+cgMrW61QFUCcNAv+G8JKtqDOsjv669owkRqguzC2G7X/l/ceTRrlI/gzTRpAuOelgBvKlIiYoR/3UD4seboaZckkkyqlfKE8b8YYnKJ1KD5zORKO2x3LEuHUdfdJHSHDy0RjBN4bcDcOAOMfSKHGwaBJtjt/3q9by49C8zcp9Pq86o846LwQhCP4ERhZ9sJWFm0v1YdQHgnnxJ4OCOuYkl9bQpKtydrrlGyiQz5vKKjwfoOInkY+YoDPdeYR9yjsYdmk1uCc0ipWTJ+2gmz3MoDw/uN+4AxqfBVI4tjZq9hQEjudIA77w4WwFrQPtdDsLfJ+UZ6yY1N6YB1qycFryQ2Q5EGRPWCo12a1rNswSnIgXm6cT8mDdQ4lLjA+A7z5ya7vfJUlbU2sXGC6XlnMGThd9x8r3FRB6lSY4fkJ/F4sdOf/l6x7pkVfJZOQYwl4eJhe7SJxtQ1s3Vunj8wDh/EW5Uz14bq2P6VsiR8YfomnpxtAyKyq6tgNOJJ7LtqOrzA11UluuX9JnMKAqIYd61IcZ9IcnUaxKK2Vf8wGiqUitz1um63h+uTWfXo0rhzId++clOGop2A649m4+wlwL9MWr5wwkdLzJ5xtJXDTjQ9N0kwjSdFYFa40WvUsw9jxQuvQkzCkTevP/9XjCH4S/akLjzR5P+Lcrm/fhjMM9UMHkQ7e/C+jej6zrOcln8cnq6i7LYU59sEiUh/jyiHg/C9hR2Ex+x/WB8UHsQTeioXIQ1R1cEJp1Xu3QQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(426003)(36860700001)(478600001)(8936002)(4326008)(8676002)(54906003)(316002)(7696005)(70586007)(336012)(26005)(1076003)(70206006)(83380400001)(47076005)(110136005)(5660300002)(2906002)(7416002)(41300700001)(36756003)(2616005)(82740400003)(81166007)(356005)(40480700001)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:46:55.5751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b53974-4634-4983-83ed-08dc11c114e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

Add machine select logic for soundwire endpoints for AMD platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-common.c | 65 +++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index 2d72c6d55dc8..0fc4e20ec673 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -118,16 +118,72 @@ void amd_sof_dump(struct snd_sof_dev *sdev, u32 flags)
 				 &panic_info, stack, AMD_STACK_DUMP_SIZE);
 }
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_AMD_SOUNDWIRE)
+static int amd_sof_sdw_get_slave_info(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *acp_data = sdev->pdata->hw_pdata;
+
+	return sdw_amd_get_slave_info(acp_data->sdw);
+}
+
+static struct snd_soc_acpi_mach *amd_sof_sdw_machine_select(struct snd_sof_dev *sdev)
+{
+	struct snd_soc_acpi_mach *mach;
+	const struct snd_soc_acpi_link_adr *link;
+	struct acp_dev_data *acp_data = sdev->pdata->hw_pdata;
+	int ret, i;
+
+	if (acp_data->info.count) {
+		ret = amd_sof_sdw_get_slave_info(sdev);
+		if (ret) {
+			dev_info(sdev->dev, "failed to read slave information\n");
+			return NULL;
+		}
+		for (mach = sdev->pdata->desc->alt_machines; mach; mach++) {
+			if (!mach->links)
+				break;
+			link = mach->links;
+			for (i = 0; i < acp_data->info.count && link->num_adr; link++, i++) {
+				if (!snd_soc_acpi_sdw_link_slaves_found(sdev->dev, link,
+									acp_data->sdw->ids,
+									acp_data->sdw->num_slaves))
+					break;
+			}
+			if (i == acp_data->info.count || !link->num_adr)
+				break;
+		}
+		if (mach && mach->link_mask) {
+			mach->mach_params.links = mach->links;
+			mach->mach_params.link_mask = mach->link_mask;
+			mach->mach_params.platform = dev_name(sdev->dev);
+			return mach;
+		}
+	}
+	dev_info(sdev->dev, "No SoundWire machine driver found\n");
+	return NULL;
+}
+
+#else
+static struct snd_soc_acpi_mach *amd_sof_sdw_machine_select(struct snd_sof_dev *sdev)
+{
+	return NULL;
+}
+#endif
+
 struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_pdata *sof_pdata = sdev->pdata;
 	const struct sof_dev_desc *desc = sof_pdata->desc;
-	struct snd_soc_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach = NULL;
 
-	mach = snd_soc_acpi_find_machine(desc->machines);
+	if (desc->machines)
+		mach = snd_soc_acpi_find_machine(desc->machines);
 	if (!mach) {
-		dev_warn(sdev->dev, "No matching ASoC machine driver found\n");
-		return NULL;
+		mach = amd_sof_sdw_machine_select(sdev);
+		if (!mach) {
+			dev_warn(sdev->dev, "No matching ASoC machine driver found\n");
+			return NULL;
+		}
 	}
 
 	sof_pdata->tplg_filename = mach->sof_tplg_filename;
@@ -204,5 +260,6 @@ EXPORT_SYMBOL_NS(sof_acp_common_ops, SND_SOC_SOF_AMD_COMMON);
 
 MODULE_IMPORT_NS(SND_SOC_SOF_AMD_COMMON);
 MODULE_IMPORT_NS(SND_SOC_SOF_XTENSA);
+MODULE_IMPORT_NS(SOUNDWIRE_AMD_INIT);
 MODULE_DESCRIPTION("ACP SOF COMMON Driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


