Return-Path: <linux-kernel+bounces-65066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8B854762
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B18B23AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D81865A;
	Wed, 14 Feb 2024 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cc+kckfn"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499CC199B9;
	Wed, 14 Feb 2024 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907295; cv=fail; b=mF0IKgVMCQdbiocuBKkdR2WlbRmp5rtDlwMSZ0IcA0jQjhk7j7WDIwXpAxREGHdl3xnwet2ZtGjs4Cpjd3wYmkowu5vyWPO/kyarWiLYcd+R33aTtpUpHY0gxwlDe+XijkTRBgOnxAkrI01TreJev7x0H2P5k34jzJGeE9xRcug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907295; c=relaxed/simple;
	bh=80XaQIdJt5Hn2ceeiCmLP8bhIedeJGu/EXa0a2Z38eA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ke7HvdhzVB+hyIq0DqrnUU5aHUpT4BS5L7nyR65Qmnxm2oEzekuq9myn6yfUuOlLCFVkOpr+e41lnd1LKsfSKa1gF4aBX3H8kCfuUoTkf5KpnL1gr+X/IM7wGqZudvXlCABSfcz9oRq/wKJ9Tou37FoZ28VI2gS+GAkMNcWEpdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cc+kckfn; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwllMQjk1MXRYt+CD+jDxFQGs+Sj+pTIgaXV225NvReJCgzsgHHdrmuB0WecIhg5b4kGIQAvplcNzyo5mKIOxHp/Cv/kRg2pS4DdnlnE5Ubpu/U6EZ2u5PuhaVD3YQo8YQxwlY9bdpYMQ8zRmfW2xFGy78WYlEBeQ72BeJ5WEMee+LeOtCVa16Dls+RvvoaOQBLc1V34PfB78ERpY41/N1p0zITzBLBN3OTInvD8BhA9vqjpn1qK5DhkgvTu5SpPUrueoGBCU/IFTNGu0HdAacyZ4AqqTOHMtJFXEB1D2nOzTNz5Is8xW7RT0NSwNt3Yy1dq156jlhear7+9MiuGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgimMXS9vuppJuC7eO5AdWn9o5Lmar7dDoeXfFI30KM=;
 b=L8cgDdqjJ7BzSzomwcaAQAHbAwBw2sEv3atPORWvKzuJXYRS1vKdlEpbOryhA/YwOL8iIuCZmetJOOLErd2/1yFOOYXL+GUqGq76iJOypJ80dtwTtsB8SqLG6CQFAa4xFd27+V/wEG4AS1ThaGDUStZiwi9LT83l79qYOnPLkdsNaoXlY4MfQsLhP6umr6cp5OwetTnvUvArk+TqUiorecYWQIaETMbW8b4gDqI4KroWvfSB9FoBeCqyPSGj4l3dkcFDAQC0c1bbFQ3kAMptx/EHHQhly6DZz+OUw1YGVlov2XBOyt2A2YYVDmXQYGGa5+sG89NRvUbbLalGrw6o4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgimMXS9vuppJuC7eO5AdWn9o5Lmar7dDoeXfFI30KM=;
 b=Cc+kckfnf2iBc+d2viQ8QUC3T1Di+b5DlpYn02Zq0bj/w+HYDllcf5SgwB51Ff4DigdhNaZ8kgxIYiQltdiYtmyubXIzlzppsK4bMmT6oJXMb1w+wP3+oBTdLN2JWLnz5bBvYnjVEWpTznZmEteTazhko1ac+Wk+8KN61Dl2H9I=
Received: from CYZPR20CA0004.namprd20.prod.outlook.com (2603:10b6:930:a2::29)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Wed, 14 Feb
 2024 10:41:28 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::f1) by CYZPR20CA0004.outlook.office365.com
 (2603:10b6:930:a2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 10:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 14 Feb 2024 10:41:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 04:41:26 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Wed, 14 Feb 2024 04:41:17 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <Mario.Limonciello@amd.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] ASoC: amd: ps: add machine select and register code
Date: Wed, 14 Feb 2024 16:10:05 +0530
Message-ID: <20240214104014.1144668-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214104014.1144668-1-Vijendar.Mukunda@amd.com>
References: <20240214104014.1144668-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH2PR12MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e69bf7-93c4-48d7-5e32-08dc2d497fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXKOLrDN5lBx8cB7Var5zoYFPKDeRCCVMFi77Bi2ZA1ViJ6QGe3vAi0ut15iqOr8EaoCpg/a6cTZk2imbw82e7UEBI+9kUD5SQZdbub8DCcxTijFCVT+QesxXEPiXRLzJEoM3KirVxRkGYBMbXI+BUSyZwVkIqXThie5UpJFw6DRemLYRws/jni6RXMbgx1cfwdkM03Xi7Ex3nV8sXmKGQO+Z0o3CJINpi1T3+pKcHkv9QHI8YJrpaGKpchvV+tV9cy2pKjLJHdgKF+Jtxt6zPWepjUy7p1zjCHrqegc90mR3m9T/ebLWlLPvm4v6z3IAi1pEi50wa9tOMWLaPPsKmHp75GnWt+0l0eTuNRuGvQ3uhQBgMysYchi2aeNHhV+GIYQfsmobCDl5AlxP3tPzOFw5v7HI7pfPuWycPmXWrgzkascnObFxUaFAP5GU5kR431DQYu3eBmskEwasbRy5UG50V5JrYyDy5+42+ImKdAN0pKjFOlf9TF7w/NaRyLd26K/uMYVxenqL60DgMkiMfdFdflmHAKeYlxNLxTxXjdTxliKe9bl0Rgr2chRFFH1uewIAeur50QZPY7wteNsKI8N+sUQpBxu7U88uvLZJuQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(8676002)(4326008)(6916009)(70206006)(70586007)(2906002)(83380400001)(26005)(1076003)(336012)(426003)(82740400003)(81166007)(356005)(36756003)(86362001)(54906003)(6666004)(316002)(2616005)(41300700001)(7696005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 10:41:27.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e69bf7-93c4-48d7-5e32-08dc2d497fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940

Add machine select logic for SoundWire interface and create a machine
device node based on ACP PDM/SoundWire configuration.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  4 ++
 sound/soc/amd/ps/pci-ps.c | 81 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index fb4261f7fa4b..65433184d03e 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -219,9 +219,11 @@ struct sdw_dma_ring_buf_reg {
  * @pdm_dev: ACP PDM controller platform device
  * @dmic_codec: platform device for DMIC Codec
  * sdw_dma_dev: platform device for SoundWire DMA controller
+ * @mach_dev: platform device for machine driver to support ACP PDM/SoundWire configuration
  * @acp_lock: used to protect acp common registers
  * @info: SoundWire AMD information found in ACPI tables
  * @sdw: SoundWire context for all SoundWire manager instances
+ * @machine: ACPI machines for SoundWire interface
  * @is_sdw_dev: flag set to true when any SoundWire manager instances are available
  * @is_pdm_dev: flag set to true when ACP PDM controller exists
  * @is_pdm_config: flat set to true when PDM configuration is selected from BIOS
@@ -239,10 +241,12 @@ struct acp63_dev_data {
 	struct platform_device *pdm_dev;
 	struct platform_device *dmic_codec_dev;
 	struct platform_device *sdw_dma_dev;
+	struct platform_device *mach_dev;
 	struct mutex acp_lock; /* protect shared registers */
 	struct sdw_amd_acpi_info info;
 	/* sdw context allocated by SoundWire driver */
 	struct sdw_amd_ctx *sdw;
+	struct snd_soc_acpi_mach *machines;
 	bool is_sdw_dev;
 	bool is_pdm_dev;
 	bool is_pdm_config;
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index c42660245019..205bca95aa06 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -17,6 +17,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
 #include <linux/soundwire/sdw_amd.h>
+#include "../mach-config.h"
 
 #include "acp63.h"
 
@@ -281,6 +282,42 @@ static int amd_sdw_exit(struct acp63_dev_data *acp_data)
 
 	return 0;
 }
+
+static struct snd_soc_acpi_mach *acp63_sdw_machine_select(struct device *dev)
+{
+	struct snd_soc_acpi_mach *mach;
+	const struct snd_soc_acpi_link_adr *link;
+	struct acp63_dev_data *acp_data = dev_get_drvdata(dev);
+	int ret, i;
+
+	if (acp_data->info.count) {
+		ret = sdw_amd_get_slave_info(acp_data->sdw);
+		if (ret) {
+			dev_dbg(dev, "failed to read slave information\n");
+			return NULL;
+		}
+		for (mach = acp_data->machines; mach; mach++) {
+			if (!mach->links)
+				break;
+			link = mach->links;
+			for (i = 0; i < acp_data->info.count && link->num_adr; link++, i++) {
+				if (!snd_soc_acpi_sdw_link_slaves_found(dev, link,
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
+			return mach;
+		}
+	}
+	dev_dbg(dev, "No SoundWire machine driver found\n");
+	return NULL;
+}
 #else
 static int acp_scan_sdw_devices(struct device *dev, u64 addr)
 {
@@ -296,8 +333,44 @@ static int amd_sdw_exit(struct acp63_dev_data *acp_data)
 {
 	return 0;
 }
+
+static struct snd_soc_acpi_mach *acp63_sdw_machine_select(struct device *dev)
+{
+	return NULL;
+}
 #endif
 
+static int acp63_machine_register(struct device *dev)
+{
+	struct snd_soc_acpi_mach *mach;
+	struct acp63_dev_data *adata = dev_get_drvdata(dev);
+	int size;
+
+	if (adata->is_sdw_dev && adata->is_sdw_config) {
+		size = sizeof(*adata->machines);
+		mach = acp63_sdw_machine_select(dev);
+		if (mach) {
+			adata->mach_dev = platform_device_register_data(dev, mach->drv_name,
+									PLATFORM_DEVID_NONE, mach,
+									size);
+			if (IS_ERR(adata->mach_dev)) {
+				dev_err(dev,
+					"cannot register Machine device for SoundWire Interface\n");
+				return PTR_ERR(adata->mach_dev);
+			}
+		}
+
+	} else if (adata->is_pdm_dev && !adata->is_sdw_dev && adata->is_pdm_config) {
+		adata->mach_dev = platform_device_register_data(dev, "acp_ps_mach",
+								PLATFORM_DEVID_NONE, NULL, 0);
+		if (IS_ERR(adata->mach_dev)) {
+			dev_err(dev, "cannot register amd_ps_mach device\n");
+			return PTR_ERR(adata->mach_dev);
+		}
+	}
+	return 0;
+}
+
 static int get_acp63_device_config(struct pci_dev *pci, struct acp63_dev_data *acp_data)
 {
 	struct acpi_device *pdm_dev;
@@ -526,7 +599,11 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		dev_err(&pci->dev, "ACP platform devices creation failed\n");
 		goto de_init;
 	}
-
+	ret = acp63_machine_register(&pci->dev);
+	if (ret) {
+		dev_err(&pci->dev, "ACP machine register failed\n");
+		goto de_init;
+	}
 skip_pdev_creation:
 	device_set_wakeup_enable(&pci->dev, true);
 	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
@@ -640,6 +717,8 @@ static void snd_acp63_remove(struct pci_dev *pci)
 		platform_device_unregister(adata->pdm_dev);
 		platform_device_unregister(adata->dmic_codec_dev);
 	}
+	if (adata->mach_dev)
+		platform_device_unregister(adata->mach_dev);
 	ret = acp63_deinit(adata->acp63_base, &pci->dev);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
-- 
2.34.1


