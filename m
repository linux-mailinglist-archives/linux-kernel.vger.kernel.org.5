Return-Path: <linux-kernel+bounces-42203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1C83FDD9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353A31C2279E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1694A45959;
	Mon, 29 Jan 2024 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AP+zA6te"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B894F1FF;
	Mon, 29 Jan 2024 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507579; cv=fail; b=GKOiOaqsgcDw2efOXyGbKUcSOJBzG0Feev9V2Lzvs8PDL8rDtFnLG4ntkrLzp0FqvfNmxxFpRN92UAQVe5ISF8fr+Rwfm6ckXCF5m/QfGimZpve/R8g89SwqTS6eEVLyXD8GhFIC5+TKl5gRwTq2q0AB+aS1bcCk1yFnKtUsv/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507579; c=relaxed/simple;
	bh=RRgG0mLjFCIX53F1VoHK9mQxWp1mZQagFX0ndP2QuNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGUpZEHEUoKdRYVXCT/otOxkIY+B2XgqLTFioil3TQDpEc8ZJVdbHTa8q94Jg1n86elezOxZ+haUtQK0J/b6LROzG6AmoMir5ZjnqPtd5Nzt8grujzFYW/lPm/mSIcEz3OtqIZqOBmvsD2W4wApUBpuP07JnfRF54k/Ff4ar9EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AP+zA6te; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhknsWd4HotWGSmWCMhaXU2uiUU/F/8eMDS1tZH0ZuoLD+9OLZXqJyjbp+Jm4KRUZzZvi2Wz6nvZ35Xjp55HoXlZEWou/xmvUL9njctnCBWSzrJ8/WUhsr6unSNMs2iID2msHAZm8DWzwFz4siLUOSPZxDDlU+taSzH8tjJlLrbQD0F+KqgMnggJOLgwmqo+56ihueBO5KzY9etn3YAy651B51Ozram6FfWvLTCaXlQgOfpawJtUN238GiJaRZwFTv6/NNuyY2e05XF3m84LCp16X5/4VM9SBt1Kzab+z42ySZUkTA09tPySYOOyYW1H9ND6rUNrN5iom2qRLobo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj6rQnwRAGmGe65C1SY9GxTlsRq+Z/m0+8pZbeN70iw=;
 b=KGnPVLjJLLhpZr05Ovw/oEIA4FSa5BdY54AQtKpb1kM0zVv1hN5CPjJ8er9eVH/D0pZz9ax7TrY+SoJkbi2UUZAwbc0eBG/JdmpN8ZTlwvWpVcpfe34sfht2jiQWzUFG79eziuIOQqvVWwXI8A2iYmixbRsKrC/DZw26gV3OIdGvnYAsNrBdyOfsOrtFFNDbcpArDfJmc33NRxvok/qYb370NHJ29geg2htVpnan6GaGEsZyFxUR1T/oTpFBdsIJe1RvNZdsg0hHM+N5jTKdeblcvhmue9UZw78inbremrCbT928TT6+B090SoLgs08yOerNYYKlinxDMpW8c+LlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj6rQnwRAGmGe65C1SY9GxTlsRq+Z/m0+8pZbeN70iw=;
 b=AP+zA6teB4GpKUGfTrsTYcv1zcJPOcxrRCEu2OzJcAknILC5AJzQ957zXR5jor9UuvPjNV0opLpkwXVC1A+pVlq4kXjykWbH0+KrJZjaBDObSDAR6KSL21pILJjMHymyedOKho54VSCjns9VATzMms3E9jDqJ7ujTUsYJRz5HGo=
Received: from BN9PR03CA0911.namprd03.prod.outlook.com (2603:10b6:408:107::16)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 05:52:51 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::df) by BN9PR03CA0911.outlook.office365.com
 (2603:10b6:408:107::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 05:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 05:52:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 23:52:50 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sun, 28 Jan 2024 23:52:44 -0600
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
	<Vsujithkumar.Reddy@amd.com>, Emil Velikov <emil.velikov@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Mastan Katragadda
	<Mastan.Katragadda@amd.com>, "moderated list:SOUND - SOUND OPEN FIRMWARE
 (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 07/13] ASoC: SOF: amd: add code for invoking soundwire manager helper functions
Date: Mon, 29 Jan 2024 11:21:41 +0530
Message-ID: <20240129055147.1493853-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM6PR12MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 906704ac-eb3d-4c3f-a2ff-08dc208e875a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u+X5K/usXtIe8NRAnezF3cm/ijBhROoKIo27g2ZOtQ8Ou/5EBxqaLuj3yRmOvvQd/nWs2RxSRqEZtwt/aphdTwPW3CTbzk8UIilZ+zIrGrOJ0i+58t+/hZ7wqkvYmgsRiS2elASk8hHPQScqod16RRjFskN8VsjTDV0sUVY62tK4TUjm2BZK7DWWyHV1etoXsP5t9AhyDp7cqrCQWA2I90PGY5F2kim7GC9R2D3zQTJoHFwBpZRokiuEN8MlbE2trx+8FTJ7Ciuxuw0siYrqDYYVru+sKNWD101Nz6EkWPPooZ73hTLd3d3onID4SMns2WT6x0aHjwEkhx13Psyf0Sy2dHC8pUFK3ZGkGWEL/7QE7tymaHl0F5qLqLrx9poiYejuTpRMeC/tgPg9rm0CUteFql40cD+bBkUbRAO2lkWha0zbaX+DQts3uJL4dgPRwoHNTAsBzO65MuPWStidFgqg7tLY/YQieHW7aObh62knS8GJrGylTkn/L0W2tLVnd0czkVYTsXZcATeS2XtsZnr5c3Ka6EUz2ICgxXJBDSoIMSnNDATEB1GENbfN+vhM/7DNIwa5EMwjuGPIWYk0/OLmj0e4ZsNXpXu/50+sAllWHW8xM7E+TF1MyZ7OqCeai4XIsL1VO9Eis5CuysWQOWlx4ZUQMj6WUOoPhNAV4KqjAvVqmE/pAAo1ryKcGnHCPP1MeUS2gzKhqTdGBu3HMRCd3aB9+EozI9NPEq6Oo1IgpXnQqKlX+LepdIL1pAj7Fk9AaiOJKz2paPRl1zCrQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(41300700001)(82740400003)(81166007)(356005)(40460700003)(40480700001)(36860700001)(7696005)(86362001)(70586007)(110136005)(54906003)(70206006)(316002)(8676002)(8936002)(47076005)(426003)(336012)(5660300002)(2616005)(7416002)(478600001)(1076003)(2906002)(4326008)(6666004)(26005)(83380400001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 05:52:50.7608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906704ac-eb3d-4c3f-a2ff-08dc208e875a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942

Add code for invoking Soundwire manager helper functions
when SoundWire configuration is selected.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/Kconfig | 17 +++++++
 sound/soc/sof/amd/acp.c   | 99 ++++++++++++++++++++++++++++++++++++++-
 sound/soc/sof/amd/acp.h   | 15 +++++-
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 19c5e27a193f..1cea1d75130c 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -60,6 +60,23 @@ config SND_SOC_SOF_ACP_PROBES
 	  This option is not user-selectable but automatically handled by
 	  'select' statements at a higher level
 
+config SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
+	tristate
+	select SOUNDWIRE_AMD if SND_SOC_SOF_AMD_SOUNDWIRE != n
+	select SND_AMD_SOUNDWIRE_ACPI if ACPI
+
+config SND_SOC_SOF_AMD_SOUNDWIRE
+	tristate "SOF support for SoundWire based AMD platforms"
+	default SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
+	depends on SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
+	depends on ACPI && SOUNDWIRE
+	depends on !(SOUNDWIRE=m && SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE=y)
+	help
+	  This adds support for SoundWire with Sound Open Firmware
+	  for AMD platforms.
+	  Say Y if you want to enable SoundWire links with SOF.
+	  If unsure select "N".
+
 config SND_SOC_SOF_AMD_ACP63
 	tristate "SOF support for ACP6.3 platform"
 	depends on SND_SOC_SOF_PCI
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index a2b441e3d6d3..1905f1a4ba64 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -490,6 +490,81 @@ int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_resume, SND_SOC_SOF_AMD_COMMON);
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_AMD_SOUNDWIRE)
+static int acp_sof_scan_sdw_devices(struct snd_sof_dev *sdev, u64 addr)
+{
+	struct acpi_device *sdw_dev;
+	struct acp_dev_data *acp_data;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+
+	if (!addr)
+		return -ENODEV;
+
+	acp_data = sdev->pdata->hw_pdata;
+	sdw_dev = acpi_find_child_device(ACPI_COMPANION(sdev->dev), addr, 0);
+	if (!sdw_dev)
+		return -ENODEV;
+
+	acp_data->info.handle = sdw_dev->handle;
+	acp_data->info.count = desc->sdw_max_link_count;
+
+	return amd_sdw_scan_controller(&acp_data->info);
+}
+
+static int amd_sof_sdw_probe(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *acp_data;
+	struct sdw_amd_res sdw_res;
+	int ret;
+
+	acp_data = sdev->pdata->hw_pdata;
+
+	memset(&sdw_res, 0, sizeof(sdw_res));
+	sdw_res.addr = acp_data->addr;
+	sdw_res.reg_range = acp_data->reg_range;
+	sdw_res.handle = acp_data->info.handle;
+	sdw_res.parent = sdev->dev;
+	sdw_res.dev = sdev->dev;
+	sdw_res.acp_lock = &acp_data->acp_lock;
+	sdw_res.count = acp_data->info.count;
+	sdw_res.link_mask = acp_data->info.link_mask;
+	sdw_res.mmio_base = sdev->bar[ACP_DSP_BAR];
+
+	ret = sdw_amd_probe(&sdw_res, &acp_data->sdw);
+	if (ret)
+		dev_err(sdev->dev, "SoundWire probe failed\n");
+	return ret;
+}
+
+static int amd_sof_sdw_exit(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *acp_data;
+
+	acp_data = sdev->pdata->hw_pdata;
+	if (acp_data->sdw)
+		sdw_amd_exit(acp_data->sdw);
+	acp_data->sdw = NULL;
+
+	return 0;
+}
+
+#else
+static int acp_sof_scan_sdw_devices(struct snd_sof_dev *sdev, u64 addr)
+{
+	return 0;
+}
+
+static int amd_sof_sdw_probe(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static int amd_sof_sdw_exit(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+#endif
+
 int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 {
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
@@ -525,7 +600,9 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	}
 
 	pci_set_master(pci);
-
+	adata->addr = addr;
+	adata->reg_range = chip->reg_end_addr - chip->reg_start_addr;
+	mutex_init(&adata->acp_lock);
 	sdev->pdata->hw_pdata = adata;
 	adata->smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, chip->host_bridge_id, NULL);
 	if (!adata->smn_dev) {
@@ -547,6 +624,21 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		goto free_ipc_irq;
 
+	/* scan SoundWire capabilities exposed by DSDT */
+	ret = acp_sof_scan_sdw_devices(sdev, chip->sdw_acpi_dev_addr);
+	if (ret < 0) {
+		dev_dbg(sdev->dev, "skipping SoundWire, not detected with ACPI scan\n");
+		goto skip_soundwire;
+	}
+	ret = amd_sof_sdw_probe(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: SoundWire probe error\n");
+		free_irq(sdev->ipc_irq, sdev);
+		pci_dev_put(adata->smn_dev);
+		return ret;
+	}
+
+skip_soundwire:
 	sdev->dsp_box.offset = 0;
 	sdev->dsp_box.size = BOX_SIZE_512;
 
@@ -602,6 +694,9 @@ void amd_sof_acp_remove(struct snd_sof_dev *sdev)
 	if (adata->smn_dev)
 		pci_dev_put(adata->smn_dev);
 
+	if (adata->sdw)
+		amd_sof_sdw_exit(sdev);
+
 	if (sdev->ipc_irq)
 		free_irq(sdev->ipc_irq, sdev);
 
@@ -613,4 +708,6 @@ void amd_sof_acp_remove(struct snd_sof_dev *sdev)
 EXPORT_SYMBOL_NS(amd_sof_acp_remove, SND_SOC_SOF_AMD_COMMON);
 
 MODULE_DESCRIPTION("AMD ACP sof driver");
+MODULE_IMPORT_NS(SOUNDWIRE_AMD_INIT);
+MODULE_IMPORT_NS(SND_AMD_SOUNDWIRE_ACPI);
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index c645aee216fd..e88d01330ec7 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -12,7 +12,7 @@
 #define __SOF_AMD_ACP_H
 
 #include <linux/dmi.h>
-
+#include <linux/soundwire/sdw_amd.h>
 #include "../sof-priv.h"
 #include "../sof-audio.h"
 
@@ -191,6 +191,10 @@ struct sof_amd_acp_desc {
 	u32 acp_clkmux_sel;
 	u32 fusion_dsp_offset;
 	u32 probe_reg_offset;
+	u32 reg_start_addr;
+	u32 reg_end_addr;
+	u32 sdw_max_link_count;
+	u64 sdw_acpi_dev_addr;
 };
 
 /* Common device data struct for ACP devices */
@@ -199,6 +203,12 @@ struct acp_dev_data {
 	const struct firmware *fw_dbin;
 	/* DMIC device */
 	struct platform_device *dmic_dev;
+	/* mutex lock to protect ACP common registers access */
+	struct mutex acp_lock;
+	/* ACPI information stored between scan and probe steps */
+	struct sdw_amd_acpi_info info;
+	/* sdw context allocated by SoundWire driver */
+	struct sdw_amd_ctx *sdw;
 	unsigned int fw_bin_size;
 	unsigned int fw_data_bin_size;
 	unsigned int fw_sram_data_bin_size;
@@ -207,6 +217,9 @@ struct acp_dev_data {
 	const char *fw_sram_data_bin;
 	u32 fw_bin_page_count;
 	u32 fw_data_bin_page_count;
+	u32 addr;
+	u32 reg_range;
+	u32 blk_type;
 	dma_addr_t sha_dma_addr;
 	u8 *bin_buf;
 	dma_addr_t dma_addr;
-- 
2.34.1


