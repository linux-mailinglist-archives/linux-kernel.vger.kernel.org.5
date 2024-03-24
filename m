Return-Path: <linux-kernel+bounces-113260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909EB8882D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A9286C56
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0272D188A84;
	Sun, 24 Mar 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5GsmeH6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F801188A69;
	Sun, 24 Mar 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320060; cv=none; b=jjewyt0pwt2hcNjrSVwv4JARGZ7qalrIttJJnXSUAy7yCrAbFu3mAP/rdxEZc+dGEugbXh9TKkpA1J0+UnGAvhDxUhgg50JFf5RUdOHu1zFfL5SOKjM/2ToNoIYsjs33Z+J9hakD3BRM04LTmkSkq74P94WGlgMTAACRbochAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320060; c=relaxed/simple;
	bh=7Kh9WBTrHZpZpHd+8mqm62KvN/Rtbc1InbRLgxFXGC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzIXhLeJrGyCE/ofNHk8hq95kCjYq9G37JWTQMwRhAl7FYmhevY01qDmyLN4WCzfGj2Fk8VHylimrmIq+y0tW9SNPUt4HJhhKd+7tVMV+COIRw6IRdh44/GwAauy+bVfmx1yXjwi0OBiY75rqA8w6mPzUyeyHuQ0hV0oCUZ0O3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5GsmeH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0355BC433C7;
	Sun, 24 Mar 2024 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320059;
	bh=7Kh9WBTrHZpZpHd+8mqm62KvN/Rtbc1InbRLgxFXGC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5GsmeH6JKFiGxr/OU4dJEvhmwVn631cYAesK3rcRjLWH14pZb7oWbdSu5WiRTkVd
	 18cJIlY3wdPVCQKxKSrvtYUwzWz2+oWJJOoSt7TLcN+o0jKSOFlbDwv8tNE1/rMH7v
	 VtK8yQb7UezHYlZPhhDL4K0Jx7SSxlDZoVOIvh1XZCmasjmeibHWYD0l12qH5wpjVV
	 WR9GMdwwgLfk/RZkG6/9IElnqZj+lvse0hPmO0dRFF9XePZxeAfrwZX9+cyXYcKta6
	 mVjRQavXfSuhU2UV8JdO1sL1OSi9rjLYEtb9T68TT4B1UMxMjchvLJkVO11xrRbXvt
	 VaVrffUkfytHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 369/715] ASoC: SOF: amd: Compute file paths on firmware load
Date: Sun, 24 Mar 2024 18:29:08 -0400
Message-ID: <20240324223455.1342824-370-sashal@kernel.org>
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

[ Upstream commit d9cacc1a2af2e1cd781b5cd2a3e57fbde64f5a2d ]

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
Link: https://msgid.link/r/20231219030728.2431640-9-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp-loader.c | 32 ++++++++++++++++++++++++++------
 sound/soc/sof/amd/acp.c        |  7 ++-----
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index e05eb7a86dd44..d2d21478399e0 100644
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
index 9aa9600c05d61..9794d64a110fd 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -493,7 +493,6 @@ EXPORT_SYMBOL_NS(amd_sof_acp_resume, SND_SOC_SOF_AMD_COMMON);
 int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 {
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
-	struct snd_sof_pdata *plat_data = sdev->pdata;
 	struct acp_dev_data *adata;
 	const struct sof_amd_acp_desc *chip;
 	const struct dmi_system_id *dmi_id;
@@ -561,8 +560,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	dmi_id = dmi_first_match(acp_sof_quirk_table);
 	if (dmi_id && dmi_id->driver_data) {
 		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
-						    "%s/sof-%s-code.bin",
-						    plat_data->fw_filename_prefix,
+						    "sof-%s-code.bin",
 						    chip->name);
 		if (!adata->fw_code_bin) {
 			ret = -ENOMEM;
@@ -570,8 +568,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
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


