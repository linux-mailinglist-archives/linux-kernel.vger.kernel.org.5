Return-Path: <linux-kernel+bounces-73663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AFB85C59D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17C0B22672
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF41414D42B;
	Tue, 20 Feb 2024 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XTXYywQr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD714C586;
	Tue, 20 Feb 2024 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460191; cv=none; b=cs0bo7OxHoWEX5TEAjjOtaqOt1hIKp8oNsk9PjESptWOlE5CxtexGQics3jkVr2UhbgAv9jBVofxW3vLlQzaYAUcj/6563kKNXasJP9G/fySPM40clXErNOMrBDdT7g9VfML87g7s07gGPHWcxiswymhHH+7ggFVG6bybYIFzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460191; c=relaxed/simple;
	bh=1ywCxdZA6j1aXqHFf9c8clj0wFF7731EK13YoR0WVFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jrav9jnAcW2WYnREXaNJDKZOLRyYxGuJkwmqstc8eDjNlWsbgPCNFIz/1CX+kostl5iWi3eGgvRWG2uwxbBJKnqiyslmfqygadK8DSHWnwP/15JbJXnFfQ8yuYZmF4mLuVXpxxE5Qv1DDF+JGIRl5QTaAwJ9M5Uw8VUQFvnOxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XTXYywQr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708460188;
	bh=1ywCxdZA6j1aXqHFf9c8clj0wFF7731EK13YoR0WVFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTXYywQrejStZNUo9n11YQNELZR4uCYJG/+8rsgatArUyo50k9817SbYWYmMjJ0Mn
	 iX4zoQhM81AQcjqHXcYYcMeH9Wrzh2YstKdO7PTOXiVgiMveGixKdjzGxCAhJB4j1L
	 cAq89kKKLtsQWUsbXtNAdETVrCt0vTb7IncNC70MfXUxr1nKzWPsusYCj1bVZl88za
	 xAIzCNpIn1WRbKcDW2uF7YFWDkxdmh/n1OCBpylgFQAM8fDRACJsn1y0E9DclF7M5+
	 KM6UaXIQQTIfsxul6dW9R61lJOK5NAClntdfnQWyj3B+ObMRopl8rHFEs+QEmohDcX
	 OvjCefnsCSrtw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 349E537820C9;
	Tue, 20 Feb 2024 20:16:28 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v3 1/2] ASoC: SOF: amd: Move signed_fw_image to struct acp_quirk_entry
Date: Tue, 20 Feb 2024 22:16:03 +0200
Message-ID: <20240220201623.438944-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
References: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The signed_fw_image member of struct sof_amd_acp_desc is used to enable
signed firmware support in the driver via the acp_sof_quirk_table.

In preparation to support additional use cases of the quirk table (i.e.
adding new flags), move signed_fw_image to a new struct acp_quirk_entry
and update all references to it accordingly.

No functional changes intended.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/sof/amd/acp-loader.c |  2 +-
 sound/soc/sof/amd/acp.c        | 47 ++++++++++++++++++----------------
 sound/soc/sof/amd/acp.h        |  6 ++++-
 sound/soc/sof/amd/vangogh.c    |  9 +++++--
 4 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index d2d21478399e..aad904839b81 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -173,7 +173,7 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 
 	adata = sdev->pdata->hw_pdata;
 
-	if (adata->signed_fw_image)
+	if (adata->quirks && adata->quirks->signed_fw_image)
 		size_fw = adata->fw_bin_size - ACP_FIRMWARE_SIGNATURE;
 	else
 		size_fw = adata->fw_bin_size;
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 9b3c26210db3..9d9197fa83ed 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -20,12 +20,14 @@
 #include "acp.h"
 #include "acp-dsp-offset.h"
 
-#define SECURED_FIRMWARE 1
-
 static bool enable_fw_debug;
 module_param(enable_fw_debug, bool, 0444);
 MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
 
+static struct acp_quirk_entry quirk_valve_galileo = {
+	.signed_fw_image = true,
+};
+
 const struct dmi_system_id acp_sof_quirk_table[] = {
 	{
 		/* Steam Deck OLED device */
@@ -33,7 +35,7 @@ const struct dmi_system_id acp_sof_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
 		},
-		.driver_data = (void *)SECURED_FIRMWARE,
+		.driver_data = &quirk_valve_galileo,
 	},
 	{}
 };
@@ -254,7 +256,7 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 		}
 	}
 
-	if (adata->signed_fw_image)
+	if (adata->quirks && adata->quirks->signed_fw_image)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_INCLUDE_HDR, ACP_SHA_HEADER);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_STRT_ADDR, start_addr);
@@ -738,26 +740,27 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	sdev->debug_box.offset = sdev->host_box.offset + sdev->host_box.size;
 	sdev->debug_box.size = BOX_SIZE_1024;
 
-	adata->signed_fw_image = false;
 	dmi_id = dmi_first_match(acp_sof_quirk_table);
-	if (dmi_id && dmi_id->driver_data) {
-		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
-						    "sof-%s-code.bin",
-						    chip->name);
-		if (!adata->fw_code_bin) {
-			ret = -ENOMEM;
-			goto free_ipc_irq;
+	if (dmi_id) {
+		adata->quirks = dmi_id->driver_data;
+
+		if (adata->quirks->signed_fw_image) {
+			adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+							    "sof-%s-code.bin",
+							    chip->name);
+			if (!adata->fw_code_bin) {
+				ret = -ENOMEM;
+				goto free_ipc_irq;
+			}
+
+			adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+							    "sof-%s-data.bin",
+							    chip->name);
+			if (!adata->fw_data_bin) {
+				ret = -ENOMEM;
+				goto free_ipc_irq;
+			}
 		}
-
-		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
-						    "sof-%s-data.bin",
-						    chip->name);
-		if (!adata->fw_data_bin) {
-			ret = -ENOMEM;
-			goto free_ipc_irq;
-		}
-
-		adata->signed_fw_image = dmi_id->driver_data;
 	}
 
 	adata->enable_fw_debug = enable_fw_debug;
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 947068da39b5..b648ed194b9f 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -207,6 +207,10 @@ struct sof_amd_acp_desc {
 	u64 sdw_acpi_dev_addr;
 };
 
+struct acp_quirk_entry {
+	bool signed_fw_image;
+};
+
 /* Common device data struct for ACP devices */
 struct acp_dev_data {
 	struct snd_sof_dev  *dev;
@@ -236,7 +240,7 @@ struct acp_dev_data {
 	u8 *data_buf;
 	dma_addr_t sram_dma_addr;
 	u8 *sram_data_buf;
-	bool signed_fw_image;
+	struct acp_quirk_entry *quirks;
 	struct dma_descriptor dscr_info[ACP_MAX_DESC];
 	struct acp_dsp_stream stream_buf[ACP_MAX_STREAM];
 	struct acp_dsp_stream *dtrace_stream;
diff --git a/sound/soc/sof/amd/vangogh.c b/sound/soc/sof/amd/vangogh.c
index de15d21aa6d9..bc6ffdb5471a 100644
--- a/sound/soc/sof/amd/vangogh.c
+++ b/sound/soc/sof/amd/vangogh.c
@@ -143,6 +143,7 @@ EXPORT_SYMBOL_NS(sof_vangogh_ops, SND_SOC_SOF_AMD_COMMON);
 int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
 {
 	const struct dmi_system_id *dmi_id;
+	struct acp_quirk_entry *quirks;
 
 	/* common defaults */
 	memcpy(&sof_vangogh_ops, &sof_acp_common_ops, sizeof(struct snd_sof_dsp_ops));
@@ -151,8 +152,12 @@ int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
 	sof_vangogh_ops.num_drv = ARRAY_SIZE(vangogh_sof_dai);
 
 	dmi_id = dmi_first_match(acp_sof_quirk_table);
-	if (dmi_id && dmi_id->driver_data)
-		sof_vangogh_ops.load_firmware = acp_sof_load_signed_firmware;
+	if (dmi_id) {
+		quirks = dmi_id->driver_data;
+
+		if (quirks->signed_fw_image)
+			sof_vangogh_ops.load_firmware = acp_sof_load_signed_firmware;
+	}
 
 	return 0;
 }
-- 
2.43.2


