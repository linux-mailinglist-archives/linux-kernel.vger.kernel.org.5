Return-Path: <linux-kernel+bounces-73664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C0D85C59F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383421C20DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24014D44D;
	Tue, 20 Feb 2024 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HXCwnRWZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355514C5BA;
	Tue, 20 Feb 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460194; cv=none; b=jKuFjrTtrh472J7mQ6tJAVpcH7F3L+VYQUDwMbgvxrm79nFjl/s0B876scEcrE9DRuoooqdWZ5UKEOxKlVF79E2FEkyfRps6g/6o1hd/D/FXIpFUS256HRAn/Yvtv1ruvO92TkINEuu/mf2dvgt6e6PWu8DCyKZ4xQieVm3A6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460194; c=relaxed/simple;
	bh=yyYbfe7MYV+zSUFDLRCmIriY0MML29KBgGRbZMEyMio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeaLCqH535ep5k+/FlGb/bKkQ1XwGenUW/cEIFzIpsnmX6JvQIQ5aK6WHbbxV5kRummo182MUIl2nY+j3Xh6jEHYPbyoQNgQ+3x0R8z6TVFtkS/exVQ5GVSIbBASMYuByBrk9a058NjZSqaqDOxaU1/07cXrc718IHvQOmU/95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HXCwnRWZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708460189;
	bh=yyYbfe7MYV+zSUFDLRCmIriY0MML29KBgGRbZMEyMio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXCwnRWZZXEoqjCL/NuFmaJn880yobgYu8HKFE4HrB1KtHQlcGVi+HSRgmrFS4e2l
	 /qxU78OrvkQbRncW1b3HGUQxBcD4+GfkQfpyBk4aZjQsSlo5HEG81yWleV99M77Lg/
	 rqCAWB0NWLV0Btryqii0Fw7TfukmaIPyd+rE/ltB7o0BlPhjl8a0SRpommzYtCdbz2
	 FU1VOKn6Sp6AyEGKyMaAgU+b9oicejTC1UFrkWtlzRgfs7voOF/4EwS8VLEkkllm/8
	 TZaNLaxH5yARcrJUKlpzbBDy8cA1sA32QX/axHzGNpYehS+QuluMVLpP5XDplu97JL
	 4cP+95WNhXymg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 704F337820CB;
	Tue, 20 Feb 2024 20:16:29 +0000 (UTC)
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
Subject: [PATCH v3 2/2] ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED
Date: Tue, 20 Feb 2024 22:16:04 +0200
Message-ID: <20240220201623.438944-3-cristian.ciocaltea@collabora.com>
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

The recent introduction of the ACP/PSP communication for IRAM/DRAM fence
register modification breaks the audio support on Valve's Steam Deck
OLED device.

It causes IPC timeout errors when trying to load DSP topology during
probing:

1707255557.688176 kernel: snd_sof_amd_vangogh 0000:04:00.5: ipc tx timed out for 0x30100000 (msg/reply size: 48/0)
1707255557.689035 kernel: snd_sof_amd_vangogh 0000:04:00.5: ------------[ IPC dump start ]------------
1707255557.689421 kernel: snd_sof_amd_vangogh 0000:04:00.5: dsp_msg = 0x0 dsp_ack = 0x91d14f6f host_msg = 0x1 host_ack = 0xead0f1a4 irq_stat >
1707255557.689730 kernel: snd_sof_amd_vangogh 0000:04:00.5: ------------[ IPC dump end ]------------
1707255557.690074 kernel: snd_sof_amd_vangogh 0000:04:00.5: ------------[ DSP dump start ]------------
1707255557.690376 kernel: snd_sof_amd_vangogh 0000:04:00.5: IPC timeout
1707255557.690744 kernel: snd_sof_amd_vangogh 0000:04:00.5: fw_state: SOF_FW_BOOT_COMPLETE (7)
1707255557.691037 kernel: snd_sof_amd_vangogh 0000:04:00.5: invalid header size 0xdb43fe7. FW oops is bogus
1707255557.694824 kernel: snd_sof_amd_vangogh 0000:04:00.5: unexpected fault 0x6942d3b3 trace 0x6942d3b3
1707255557.695392 kernel: snd_sof_amd_vangogh 0000:04:00.5: ------------[ DSP dump end ]------------
1707255557.695755 kernel: snd_sof_amd_vangogh 0000:04:00.5: Failed to setup widget PIPELINE.6.ACPHS1.IN
1707255557.696069 kernel: snd_sof_amd_vangogh 0000:04:00.5: error: tplg component load failed -110
1707255557.696374 kernel: snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP topology -22
1707255557.697904 kernel: snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at snd_soc_component_probe on 0000:04:00.5: -22
1707255557.698405 kernel: sof_mach nau8821-max: ASoC: failed to instantiate card -22
1707255557.701061 kernel: sof_mach nau8821-max: error -EINVAL: Failed to register card(sof-nau8821-max)
1707255557.701624 kernel: sof_mach: probe of nau8821-max failed with error -22

Introduce a new member skip_iram_dram_size_mod to struct acp_quirk_entry and
use it to skip IRAM/DRAM size modification for Vangogh Galileo device.

Fixes: 55d7bbe43346 ("ASoC: SOF: amd: Add acp-psp mailbox interface for iram-dram fence register modification")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/sof/amd/acp.c | 3 ++-
 sound/soc/sof/amd/acp.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 9d9197fa83ed..be7dc1e02284 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -26,6 +26,7 @@ MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
 
 static struct acp_quirk_entry quirk_valve_galileo = {
 	.signed_fw_image = true,
+	.skip_iram_dram_size_mod = true,
 };
 
 const struct dmi_system_id acp_sof_quirk_table[] = {
@@ -280,7 +281,7 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 	}
 
 	/* psp_send_cmd only required for vangogh platform (rev - 5) */
-	if (desc->rev == 5) {
+	if (desc->rev == 5 && !(adata->quirks && adata->quirks->skip_iram_dram_size_mod)) {
 		/* Modify IRAM and DRAM size */
 		ret = psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | IRAM_DRAM_FENCE_2);
 		if (ret)
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index b648ed194b9f..e229bb6b849d 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -209,6 +209,7 @@ struct sof_amd_acp_desc {
 
 struct acp_quirk_entry {
 	bool signed_fw_image;
+	bool skip_iram_dram_size_mod;
 };
 
 /* Common device data struct for ACP devices */
-- 
2.43.2


