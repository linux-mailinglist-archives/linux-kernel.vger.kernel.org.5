Return-Path: <linux-kernel+bounces-32625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0326835E15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01774B275FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE46739ACA;
	Mon, 22 Jan 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0fp898Np"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E443A1B7;
	Mon, 22 Jan 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915542; cv=fail; b=CnxR21y0OV+bwfobRMRspjdzZqW6iVChKz5EBUD8/WRRHuvbRskhglrHmobhGq+VSarUOhDtCle1y7btw4ZrPl0X+NUXzcv9aeMi9F7vyjlGZtHnmJYqqu2E2bmiBDVkjlBLywmFowmklJgMAMA6V1rvzZV4+juDIDjKOl91GOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915542; c=relaxed/simple;
	bh=70tYyohuzJBuHeIMEu8qAErJX0isonNJlXcOljksQBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URiL+evv3XRqnk0cuYeKyZtlN25N+JVZudG3fIGVKn1p114AOx1b7khIV/5TP19gMGBCL6E5I/gS+4sj6ocyJd5GlRuTAzmVpTLyQwC05ThizCRlt+2YaeW6LJtxSfLE5zEXfEF9XFWMbn8st3I/hrnjmXZ8KKDz4PD232Gi5n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0fp898Np; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8pvzLppyGVh8bOyM4XfogG9LJ8/rpl1w0kM8mHJA9f9a+cRKZZoEtNSC9Kru9hAwjgYrqRaHhK9KRGt+AbMY5VmMs/ft2Qk2VDmtOC/xyTXplvmdg6cjbYTeVB5/oNY4vuhZhJcvv+IcDtRJmwVzD+48LoL7ZyMTLQLCvjk1eKcRYJE8hpEEb9cNrJryTDi1k8mQ+MOY8eNXrTM5iJjABbcyZsd3TfAP415uAMMB5nm6DUaiWh7vZFYUotmOQPascEcrj1h5HleHHyAO59Vlhf5huE38QTmSJNWp7Updh0271iE51WLXBzEpCHEsp4dOQVkpUTK92lZop94L0kQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zC5WRwtu6+qO+9CXnFzJPWrGYlpkczne7vfVG5jg8k=;
 b=iPSeyilKf/cXmG/NxJWYvCl8JCuQwE4ZkMoEtRKBym9V/g1PxcqUMsvgo2UMtBUHpdjouJseGClaKgFaN6z9ZvX4R/whHLNScujKQ3siKLijfMq7YGem6LNbdCJiRp0PrYPVGwS+YJMhIczCvwAmhwD+JCFYXuG5ScDzWW/05Zfcjk8ujZOZ/5Mp+RNPMP6JyjD9LbAZ2wKth+fAFdZ6t5dDpjtjDLcZ3nvjNVT0o3D26/ib0LjIe60QXqBH4j2GNdxJmhi1dm3OMY7c/mvGEwJLhiFaAPNdRzfppVhtGXKj33Fu0dH3hj+Od38kRqhzSOG/WyqfuQlZrw78Nvnd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zC5WRwtu6+qO+9CXnFzJPWrGYlpkczne7vfVG5jg8k=;
 b=0fp898Np1gB5p/fy3pPSrjM2oa1fq48BDzb9zK7+WFxHkf/t7EKT/a1M4sVwfT0sDA+kcNBeD2qIL9K35phGtHAkxx3wAd3uyz9nNn7mUvQkl7S2lUuC8ZF+qdcFnRKOvpZVkdYYC17RFZN0B1DZXIgw86FMnHr2zdNlSLMShf4=
Received: from DM6PR10CA0028.namprd10.prod.outlook.com (2603:10b6:5:60::41) by
 IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:25:38 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::40) by DM6PR10CA0028.outlook.office365.com
 (2603:10b6:5:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33 via Frontend
 Transport; Mon, 22 Jan 2024 09:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 09:25:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:25:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:25:37 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:25:31 -0600
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
	<Vsujithkumar.Reddy@amd.com>, Mastan Katragadda <Mastan.Katragadda@amd.com>,
	Rander Wang <rander.wang@intel.com>, "moderated list:SOUND - SOUND OPEN
 FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 07/13] ASoC: SOF: amd: add code for invoking soundwire manager helper functions
Date: Mon, 22 Jan 2024 14:54:29 +0530
Message-ID: <20240122092435.3791175-8-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c8a35e-de0b-4c28-78ef-08dc1b2c1878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K0W0tvCgKNfoq1HEq0Zc6v+mjnYFZNbkfDCoNS1DNfPtM6ZbrmO1r86KSJH+f7Xif/fHpqSiJNPOe955cj3dD8tuCaWc6fQmxyfzo3o5mxpP6e7NKlVeqpbw2QBK84vZAVQrUho4UXLsCY5s8mf1e0N4uiU7GnBPIGk8V5aULWH5K0mLCb4/nj+nE6oE9hANH01fWHTdAvIZ0M2M4oHRMIfFk+HOQHof2JrUNvkAwwpw5s8Ag06zIV2+CFJ0V1EMGSKpe7hh6Y+MbAXzp6mI78T+gysvo6ZfEIgO511Ih5AwuWi6V32sVVXrZ8Wp6qfy4Vrj2YxG7Et6Rh/CtIf0kHfgCgzsTTU69D+UFA1y++JEmkZVS7U4Gx3WezOXXKQlzT5SlifgqxhwLmRcjaKpAKhtOFUdlK+ErgqL7KNgxeKIyvyMpca1orrvX5g8wEZa/P4T6G6Fmp2QFvtRXfI2H0wWmmhR/jgV046hKqXxb4u9IxEW8c3j2jBeoPUfPnoU2asdPcbrVGg7PvrsVcnlNXTcfuwdGexsHY4wcNtQax64mf78OV6F6tIKZGnlHrDpFkb2eT8kyTbE1XMn3XM2R6EateV47BakurtT6cbRgEVXv0H1q6zijYJcFzhl/uC4aq1Fhf0c/vZhYU9heLfjSBQJBYW4rHqgn+G2cwvEBJiDl3S6IwXONIOgYEAfwPAv0rkQZtGRCaTZWju9kCoWZ+3y1p6Jh9ClYyUuQanpReXYBKfFF/I7ahbkPXWyxjWQBouzCLop5GcdsG2j6fpucQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(26005)(336012)(2616005)(426003)(1076003)(82740400003)(36860700001)(4326008)(8676002)(8936002)(5660300002)(478600001)(2906002)(7416002)(41300700001)(7696005)(54906003)(70586007)(70206006)(316002)(110136005)(36756003)(356005)(81166007)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:25:38.1889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c8a35e-de0b-4c28-78ef-08dc1b2c1878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776

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
index 32a741fcb84f..f24cd6b7490f 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -491,6 +491,81 @@ int amd_sof_acp_resume(struct snd_sof_dev *sdev)
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
@@ -527,7 +602,9 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	}
 
 	pci_set_master(pci);
-
+	adata->addr = addr;
+	adata->reg_range = chip->reg_end_addr - chip->reg_start_addr;
+	mutex_init(&adata->acp_lock);
 	sdev->pdata->hw_pdata = adata;
 	adata->smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, chip->host_bridge_id, NULL);
 	if (!adata->smn_dev) {
@@ -549,6 +626,21 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
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
 
@@ -596,6 +688,9 @@ void amd_sof_acp_remove(struct snd_sof_dev *sdev)
 	if (adata->smn_dev)
 		pci_dev_put(adata->smn_dev);
 
+	if (adata->sdw)
+		amd_sof_sdw_exit(sdev);
+
 	if (sdev->ipc_irq)
 		free_irq(sdev->ipc_irq, sdev);
 
@@ -607,4 +702,6 @@ void amd_sof_acp_remove(struct snd_sof_dev *sdev)
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


