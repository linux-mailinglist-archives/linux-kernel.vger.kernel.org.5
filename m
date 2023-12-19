Return-Path: <linux-kernel+bounces-4630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A7F818019
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875EA1C231B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4755A12B98;
	Tue, 19 Dec 2023 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IJQE2hYq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002F1170E;
	Tue, 19 Dec 2023 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702955269;
	bh=VsdVshjW3wDguFc4wS/NQ6xhp6QJt6hm5jWcMmmqG2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJQE2hYqBhGwUSj0s6TUtYNO5jMuEndDAKJ9wWKtLQ0ATd9dnKbqvZNT3YpZPeF6/
	 YeMyN4rrRbh2z+UdsP+IOHm7xdEzo516g/Pr9OQrWrsK1YgTM2RRpMciDLZKGz95sq
	 CFLojYgjLs/MOl9+Iu7/DVJzUpusmsSCBAYHvM6Y8uS7yvM4BUbhooqjBrUsG3xS89
	 jHf6XWhvk9x2mu41MoMpFvLZ0CrLvdsISLyvVQcIZ1stKrytvr7dxLhQT/c6tx8Bsi
	 L3Qz5br65XzBnDkhar06ToeIB8+L7c7DijkwVHAvKk11q9ipLABF3jv/fLucJT1GI0
	 qpW1rxo33Fg+w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 875313781F7C;
	Tue, 19 Dec 2023 03:07:49 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	kernel@collabora.com
Subject: [PATCH v2 8/8] ASoC: SOF: amd: Compute file paths on firmware load
Date: Tue, 19 Dec 2023 05:07:26 +0200
Message-ID: <20231219030728.2431640-9-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219030728.2431640-1-cristian.ciocaltea@collabora.com>
References: <20231219030728.2431640-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version fallback if
firmware files are missing") changed the order of some operations and
the firmware paths are not available anymore at snd_sof_probe() time.

Precisely, fw_filename_prefix is set by sof_select_ipc_and_paths() via

  plat_data->fw_filename_prefix = out_profile.fw_path;

but sof_init_environment() which calls this function was moved from
snd_sof_device_probe() to sof_probe_continue(). Moreover,
snd_sof_probe() was moved from sof_probe_continue() to
sof_init_environment(), but before the call to
sof_select_ipc_and_paths().

The problem here is that amd_sof_acp_probe() uses fw_filename_prefix to
compute fw_code_bin and fw_data_bin paths, and because the field is not
yet initialized, the paths end up containing (null):

snd_sof_amd_vangogh 0000:04:00.5: Direct firmware load for (null)/sof-vangogh-code.bin failed with error -2
snd_sof_amd_vangogh 0000:04:00.5: sof signed firmware code bin is missing
snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP firmware -2
snd_sof_amd_vangogh: probe of 0000:04:00.5 failed with error -2

Move usage of fw_filename_prefix right before request_firmware() calls
in acp_sof_load_signed_firmware().

Fixes: 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version fallback if firmware files are missing")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
---
 sound/soc/sof/amd/acp-loader.c | 32 ++++++++++++++++++++++++++------
 sound/soc/sof/amd/acp.c        |  7 ++-----
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index e05eb7a86dd4..d2d21478399e 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -267,29 +267,49 @@ int acp_sof_load_signed_firmware(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_pdata *plat_data = sdev->pdata;
 	struct acp_dev_data *adata = plat_data->hw_pdata;
+	const char *fw_filename;
 	int ret;
 
-	ret = request_firmware(&sdev->basefw.fw, adata->fw_code_bin, sdev->dev);
+	fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
+				plat_data->fw_filename_prefix,
+				adata->fw_code_bin);
+	if (!fw_filename)
+		return -ENOMEM;
+
+	ret = request_firmware(&sdev->basefw.fw, fw_filename, sdev->dev);
 	if (ret < 0) {
+		kfree(fw_filename);
 		dev_err(sdev->dev, "sof signed firmware code bin is missing\n");
 		return ret;
 	} else {
-		dev_dbg(sdev->dev, "request_firmware %s successful\n", adata->fw_code_bin);
+		dev_dbg(sdev->dev, "request_firmware %s successful\n", fw_filename);
 	}
+	kfree(fw_filename);
+
 	ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_IRAM, 0,
-				      (void *)sdev->basefw.fw->data, sdev->basefw.fw->size);
+				      (void *)sdev->basefw.fw->data,
+				      sdev->basefw.fw->size);
+
+	fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
+				plat_data->fw_filename_prefix,
+				adata->fw_data_bin);
+	if (!fw_filename)
+		return -ENOMEM;
 
-	ret = request_firmware(&adata->fw_dbin, adata->fw_data_bin, sdev->dev);
+	ret = request_firmware(&adata->fw_dbin, fw_filename, sdev->dev);
 	if (ret < 0) {
+		kfree(fw_filename);
 		dev_err(sdev->dev, "sof signed firmware data bin is missing\n");
 		return ret;
 
 	} else {
-		dev_dbg(sdev->dev, "request_firmware %s successful\n", adata->fw_data_bin);
+		dev_dbg(sdev->dev, "request_firmware %s successful\n", fw_filename);
 	}
+	kfree(fw_filename);
 
 	ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_DRAM, 0,
-				      (void *)adata->fw_dbin->data, adata->fw_dbin->size);
+				      (void *)adata->fw_dbin->data,
+				      adata->fw_dbin->size);
 	return ret;
 }
 EXPORT_SYMBOL_NS(acp_sof_load_signed_firmware, SND_SOC_SOF_AMD_COMMON);
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 1e9840ae8938..87c5c71eac68 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -479,7 +479,6 @@ EXPORT_SYMBOL_NS(amd_sof_acp_resume, SND_SOC_SOF_AMD_COMMON);
 int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 {
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
-	struct snd_sof_pdata *plat_data = sdev->pdata;
 	struct acp_dev_data *adata;
 	const struct sof_amd_acp_desc *chip;
 	const struct dmi_system_id *dmi_id;
@@ -547,8 +546,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	dmi_id = dmi_first_match(acp_sof_quirk_table);
 	if (dmi_id && dmi_id->driver_data) {
 		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
-						    "%s/sof-%s-code.bin",
-						    plat_data->fw_filename_prefix,
+						    "sof-%s-code.bin",
 						    chip->name);
 		if (!adata->fw_code_bin) {
 			ret = -ENOMEM;
@@ -556,8 +554,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 		}
 
 		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
-						    "%s/sof-%s-data.bin",
-						    plat_data->fw_filename_prefix,
+						    "sof-%s-data.bin",
 						    chip->name);
 		if (!adata->fw_data_bin) {
 			ret = -ENOMEM;
-- 
2.43.0


