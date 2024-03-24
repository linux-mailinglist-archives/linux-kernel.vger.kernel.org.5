Return-Path: <linux-kernel+bounces-113557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54598888547
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EF31C248DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F621C5247;
	Sun, 24 Mar 2024 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvrS767I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E31C5229;
	Sun, 24 Mar 2024 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320359; cv=none; b=LWI+sgUiMrwFvk8jA5tV5oeu3guVe7QJuQ0iEiyE02u9ObkRYmBqf1eognG5gruORVioH3QyKKg15ClCISWD5lVeSC6UFRN1cpWmb7Y2uvMGscAXVBOBX8sC4brnBqTInP6HG/urhIIjZ2Q0n8lYzzxh0/z7QxzFOxPK0jngL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320359; c=relaxed/simple;
	bh=Sx1yksQl0LV79V7f0kT98iIvDs1S/8zItAem+FKlwOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6LHazu5mGSv92j8QddOq3NjU6B5g6KFybTuuPGWWMcdDT8O8oeq/utxSfEa/CvaWOSgOhT6zZqF9iZJMTD9R5MoPrFfXDp9AuYSQCMKfaaSR2ZqHWh4hfep/AEMVoOwny9pqoT9JDiT2XVaQzw+FsRJKDX5ilWl1nisVJC/x/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvrS767I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD81DC433F1;
	Sun, 24 Mar 2024 22:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320359;
	bh=Sx1yksQl0LV79V7f0kT98iIvDs1S/8zItAem+FKlwOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvrS767IYSxsjzPHH+0yeyUifYDOjvw1WeenfWb+lNblSkhAW85DRwH2OGS9YX8/N
	 eub+hDGQKkF26+RipiPbjPBUBgKL/A29mfe8jsnyVAQMY3ZROt8ot93/wowoKokJkP
	 ui4ejnTHNjPbX1NTUSwyAD+Zl1xr65Spz0JCBBDtjBwakod46zG1InhSJYzWgrrGlh
	 7DOXf4ekRl3iyvCMsTYw4+EMEmopb7o4l5+GZa8i/fJ0vWt7YMBJTAO5U1vFXhtvVO
	 H2cG2o5Z4SON5qduTBvTNa9LmegUPeT+enTxx8y4CyYjZfLhCvXqfdGC66ktk/emHC
	 2+OJuDltaZM5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 666/715] ASoC: SOF: amd: Move signed_fw_image to struct acp_quirk_entry
Date: Sun, 24 Mar 2024 18:34:05 -0400
Message-ID: <20240324223455.1342824-667-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 33c3d813330718c403a60d220f03fbece0f4fb5c ]

The signed_fw_image member of struct sof_amd_acp_desc is used to enable
signed firmware support in the driver via the acp_sof_quirk_table.

In preparation to support additional use cases of the quirk table (i.e.
adding new flags), move signed_fw_image to a new struct acp_quirk_entry
and update all references to it accordingly.

No functional changes intended.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://msgid.link/r/20240220201623.438944-2-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 094d11768f74 ("ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp-loader.c |  2 +-
 sound/soc/sof/amd/acp.c        | 47 ++++++++++++++++++----------------
 sound/soc/sof/amd/acp.h        |  6 ++++-
 sound/soc/sof/amd/vangogh.c    |  9 +++++--
 4 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index d2d21478399e0..aad904839b817 100644
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
index 9794d64a110fd..deddf8a92db87 100644
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
 		/* Valve Jupiter device */
@@ -34,7 +36,7 @@ const struct dmi_system_id acp_sof_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Sephiroth"),
 		},
-		.driver_data = (void *)SECURED_FIRMWARE,
+		.driver_data = &quirk_valve_galileo,
 	},
 	{}
 };
@@ -255,7 +257,7 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 		}
 	}
 
-	if (adata->signed_fw_image)
+	if (adata->quirks && adata->quirks->signed_fw_image)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_INCLUDE_HDR, ACP_SHA_HEADER);
 
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_STRT_ADDR, start_addr);
@@ -556,26 +558,27 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
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
index c645aee216fd0..90a2d9d0dd633 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -193,6 +193,10 @@ struct sof_amd_acp_desc {
 	u32 probe_reg_offset;
 };
 
+struct acp_quirk_entry {
+	bool signed_fw_image;
+};
+
 /* Common device data struct for ACP devices */
 struct acp_dev_data {
 	struct snd_sof_dev  *dev;
@@ -213,7 +217,7 @@ struct acp_dev_data {
 	u8 *data_buf;
 	dma_addr_t sram_dma_addr;
 	u8 *sram_data_buf;
-	bool signed_fw_image;
+	struct acp_quirk_entry *quirks;
 	struct dma_descriptor dscr_info[ACP_MAX_DESC];
 	struct acp_dsp_stream stream_buf[ACP_MAX_STREAM];
 	struct acp_dsp_stream *dtrace_stream;
diff --git a/sound/soc/sof/amd/vangogh.c b/sound/soc/sof/amd/vangogh.c
index de15d21aa6d98..bc6ffdb5471a5 100644
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
2.43.0


