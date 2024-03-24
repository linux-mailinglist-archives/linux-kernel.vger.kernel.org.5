Return-Path: <linux-kernel+bounces-114566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242988905E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CCC291A51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C475297D63;
	Sun, 24 Mar 2024 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNHeVxoi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74D14AD19;
	Sun, 24 Mar 2024 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322212; cv=none; b=KhKWnMIBdOJ4vx1FRa4mFWN8RnSZwqDNW1ssS4R86qJ5RkY/GptKBcQbYwjD/I3LEjJS+gDM2O7mQnrYISxCHaUKBNNZcp0ahQRnr938gwJ650JrYBlv1ZYdo7wtem01dOjRwb+WA9woo6LZl5gStZonoEBnyBy50hKSuSAD3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322212; c=relaxed/simple;
	bh=/nCL1hnYN0oxUcVxl/tK+7/cl18X9cfu+U2FuJ43Bro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brrtYILh81+vMVQZ52GLi0rvhxYSgk5/04RXJElyrKrp6JrOAAdE6G1ykFBLh8ZC43JDV/3lNk+si1V+vLbN+R97WHq4jHM3e6jh1+53I+N7w0fb8MmO2jY2ln2FSDPqm4QPxc/VLS5xDmj+F2aWld2CDrLKHSRYUSwoE88Jc2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNHeVxoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E03BC433A6;
	Sun, 24 Mar 2024 23:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322212;
	bh=/nCL1hnYN0oxUcVxl/tK+7/cl18X9cfu+U2FuJ43Bro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNHeVxoiPfGtLlIxq+2Rn46Pb3z82JzcujVYhJgBIQn9zohdbhXPd+E68oq+/KYV7
	 Y/Ooi96ad+bjuXaEJPxlw1vur+XgCSX+f9YgvlYbv2JVp68FVhbNPeu/pDiZLiFXwB
	 w8fuZP3kz5pqzmPi+f/0F6wUIGcPhevYf43rJAHCp/RH4NHWjxCbU6hZuIbjNGc6oT
	 92EuDQiEOPnQP6wmX+6GHGmJ/5B4GaEvjn2pGwP1+28gsLnaSW0IFzO6AZSwJBu9r6
	 LTgpTO6YCXAzXj+ztNhW4fH9Q23oL28wumcT8yIIjRuanZIn5HFN3Jd/vfuXrXGcwq
	 F2aM7/PxZ0uuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Chao Song <chao.song@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 292/451] ASoC: SOF: Introduce container struct for SOF firmware
Date: Sun, 24 Mar 2024 19:09:28 -0400
Message-ID: <20240324231207.1351418-293-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 4f373ccf226e37a20fdc15a3df8034517a6045fd ]

Move the firmware related information under a new struct (sof_firmware)
and add it to the high level snd_sof_dev struct.

Convert the generic code to use this new container when working with the
basefw and for compatibility reasons set the old plat_data members used by
the platforms.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Chao Song <chao.song@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20221020121238.18339-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 98f681b0f84c ("ASoC: SOF: Add some bounds checking to firmware data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-loader.c | 26 ++++++++++++--------------
 sound/soc/sof/ipc4-loader.c |  6 ++----
 sound/soc/sof/loader.c      | 18 +++++++++++++-----
 sound/soc/sof/sof-priv.h    | 14 ++++++++++++++
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/sound/soc/sof/ipc3-loader.c b/sound/soc/sof/ipc3-loader.c
index bf423ca4e97bb..28218766d2114 100644
--- a/sound/soc/sof/ipc3-loader.c
+++ b/sound/soc/sof/ipc3-loader.c
@@ -138,8 +138,7 @@ static ssize_t ipc3_fw_ext_man_size(struct snd_sof_dev *sdev, const struct firmw
 
 static size_t sof_ipc3_fw_parse_ext_man(struct snd_sof_dev *sdev)
 {
-	struct snd_sof_pdata *plat_data = sdev->pdata;
-	const struct firmware *fw = plat_data->fw;
+	const struct firmware *fw = sdev->basefw.fw;
 	const struct sof_ext_man_elem_header *elem_hdr;
 	const struct sof_ext_man_header *head;
 	ssize_t ext_man_size;
@@ -310,18 +309,18 @@ static int sof_ipc3_parse_module_memcpy(struct snd_sof_dev *sdev,
 
 static int sof_ipc3_load_fw_to_dsp(struct snd_sof_dev *sdev)
 {
-	struct snd_sof_pdata *plat_data = sdev->pdata;
-	const struct firmware *fw = plat_data->fw;
+	u32 payload_offset = sdev->basefw.payload_offset;
+	const struct firmware *fw = sdev->basefw.fw;
 	struct snd_sof_fw_header *header;
 	struct snd_sof_mod_hdr *module;
 	int (*load_module)(struct snd_sof_dev *sof_dev, struct snd_sof_mod_hdr *hdr);
 	size_t remaining;
 	int ret, count;
 
-	if (!plat_data->fw)
+	if (!fw)
 		return -EINVAL;
 
-	header = (struct snd_sof_fw_header *)(fw->data + plat_data->fw_offset);
+	header = (struct snd_sof_fw_header *)(fw->data + payload_offset);
 	load_module = sof_ops(sdev)->load_module;
 	if (!load_module) {
 		dev_dbg(sdev->dev, "Using generic module loading\n");
@@ -331,9 +330,8 @@ static int sof_ipc3_load_fw_to_dsp(struct snd_sof_dev *sdev)
 	}
 
 	/* parse each module */
-	module = (struct snd_sof_mod_hdr *)(fw->data + plat_data->fw_offset +
-					    sizeof(*header));
-	remaining = fw->size - sizeof(*header) - plat_data->fw_offset;
+	module = (struct snd_sof_mod_hdr *)(fw->data + payload_offset + sizeof(*header));
+	remaining = fw->size - sizeof(*header) - payload_offset;
 	/* check for wrap */
 	if (remaining > fw->size) {
 		dev_err(sdev->dev, "%s: fw size smaller than header size\n", __func__);
@@ -374,19 +372,19 @@ static int sof_ipc3_load_fw_to_dsp(struct snd_sof_dev *sdev)
 
 static int sof_ipc3_validate_firmware(struct snd_sof_dev *sdev)
 {
-	struct snd_sof_pdata *plat_data = sdev->pdata;
-	const struct firmware *fw = plat_data->fw;
+	u32 payload_offset = sdev->basefw.payload_offset;
+	const struct firmware *fw = sdev->basefw.fw;
 	struct snd_sof_fw_header *header;
-	size_t fw_size = fw->size - plat_data->fw_offset;
+	size_t fw_size = fw->size - payload_offset;
 
-	if (fw->size <= plat_data->fw_offset) {
+	if (fw->size <= payload_offset) {
 		dev_err(sdev->dev,
 			"firmware size must be greater than firmware offset\n");
 		return -EINVAL;
 	}
 
 	/* Read the header information from the data pointer */
-	header = (struct snd_sof_fw_header *)(fw->data + plat_data->fw_offset);
+	header = (struct snd_sof_fw_header *)(fw->data + payload_offset);
 
 	/* verify FW sig */
 	if (strncmp(header->sig, SND_SOF_FW_SIG, SND_SOF_FW_SIG_SIZE) != 0) {
diff --git a/sound/soc/sof/ipc4-loader.c b/sound/soc/sof/ipc4-loader.c
index e635ae515fa9f..9f433e9b4cd37 100644
--- a/sound/soc/sof/ipc4-loader.c
+++ b/sound/soc/sof/ipc4-loader.c
@@ -17,9 +17,8 @@
 static size_t sof_ipc4_fw_parse_ext_man(struct snd_sof_dev *sdev)
 {
 	struct sof_ipc4_fw_data *ipc4_data = sdev->private;
-	struct snd_sof_pdata *plat_data = sdev->pdata;
 	struct sof_man4_fw_binary_header *fw_header;
-	const struct firmware *fw = plat_data->fw;
+	const struct firmware *fw = sdev->basefw.fw;
 	struct sof_ext_manifest4_hdr *ext_man_hdr;
 	struct sof_man4_module_config *fm_config;
 	struct sof_ipc4_fw_module *fw_module;
@@ -138,9 +137,8 @@ static int sof_ipc4_validate_firmware(struct snd_sof_dev *sdev)
 {
 	struct sof_ipc4_fw_data *ipc4_data = sdev->private;
 	u32 fw_hdr_offset = ipc4_data->manifest_fw_hdr_offset;
-	struct snd_sof_pdata *plat_data = sdev->pdata;
 	struct sof_man4_fw_binary_header *fw_header;
-	const struct firmware *fw = plat_data->fw;
+	const struct firmware *fw = sdev->basefw.fw;
 	struct sof_ext_manifest4_hdr *ext_man_hdr;
 
 	ext_man_hdr = (struct sof_ext_manifest4_hdr *)fw->data;
diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 5f51d936b3067..ba8e3aae0a5cb 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -22,7 +22,7 @@ int snd_sof_load_firmware_raw(struct snd_sof_dev *sdev)
 	int ret;
 
 	/* Don't request firmware again if firmware is already requested */
-	if (plat_data->fw)
+	if (sdev->basefw.fw)
 		return 0;
 
 	fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
@@ -31,7 +31,7 @@ int snd_sof_load_firmware_raw(struct snd_sof_dev *sdev)
 	if (!fw_filename)
 		return -ENOMEM;
 
-	ret = request_firmware(&plat_data->fw, fw_filename, sdev->dev);
+	ret = request_firmware(&sdev->basefw.fw, fw_filename, sdev->dev);
 
 	if (ret < 0) {
 		dev_err(sdev->dev,
@@ -48,7 +48,7 @@ int snd_sof_load_firmware_raw(struct snd_sof_dev *sdev)
 	ext_man_size = sdev->ipc->ops->fw_loader->parse_ext_manifest(sdev);
 	if (ext_man_size > 0) {
 		/* when no error occurred, drop extended manifest */
-		plat_data->fw_offset = ext_man_size;
+		sdev->basefw.payload_offset = ext_man_size;
 	} else if (!ext_man_size) {
 		/* No extended manifest, so nothing to skip during FW load */
 		dev_dbg(sdev->dev, "firmware doesn't contain extended manifest\n");
@@ -58,6 +58,12 @@ int snd_sof_load_firmware_raw(struct snd_sof_dev *sdev)
 			fw_filename, ret);
 	}
 
+	/*
+	 * Until the platform code is switched to use the new container the fw
+	 * and payload offset must be set in plat_data
+	 */
+	plat_data->fw = sdev->basefw.fw;
+	plat_data->fw_offset = sdev->basefw.payload_offset;
 err:
 	kfree(fw_filename);
 
@@ -100,7 +106,8 @@ int snd_sof_load_firmware_memcpy(struct snd_sof_dev *sdev)
 	return 0;
 
 error:
-	release_firmware(plat_data->fw);
+	release_firmware(sdev->basefw.fw);
+	sdev->basefw.fw = NULL;
 	plat_data->fw = NULL;
 	return ret;
 
@@ -185,7 +192,8 @@ EXPORT_SYMBOL(snd_sof_run_firmware);
 void snd_sof_fw_unload(struct snd_sof_dev *sdev)
 {
 	/* TODO: support module unloading at runtime */
-	release_firmware(sdev->pdata->fw);
+	release_firmware(sdev->basefw.fw);
+	sdev->basefw.fw = NULL;
 	sdev->pdata->fw = NULL;
 }
 EXPORT_SYMBOL(snd_sof_fw_unload);
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index de08825915b35..3d70b57e4864d 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -136,6 +136,17 @@ struct snd_sof_platform_stream_params {
 	bool cont_update_posn;
 };
 
+/**
+ * struct sof_firmware - Container struct for SOF firmware
+ * @fw:			Pointer to the firmware
+ * @payload_offset:	Offset of the data within the loaded firmware image to be
+ *			loaded to the DSP (skipping for example ext_manifest section)
+ */
+struct sof_firmware {
+	const struct firmware *fw;
+	u32 payload_offset;
+};
+
 /*
  * SOF DSP HW abstraction operations.
  * Used to abstract DSP HW architecture and any IO busses between host CPU
@@ -487,6 +498,9 @@ struct snd_sof_dev {
 	spinlock_t ipc_lock;	/* lock for IPC users */
 	spinlock_t hw_lock;	/* lock for HW IO access */
 
+	/* Main, Base firmware image */
+	struct sof_firmware basefw;
+
 	/*
 	 * ASoC components. plat_drv fields are set dynamically so
 	 * can't use const
-- 
2.43.0


