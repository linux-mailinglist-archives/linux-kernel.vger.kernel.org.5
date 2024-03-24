Return-Path: <linux-kernel+bounces-113558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11B888549
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D15B1F2343C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0891C5AA5;
	Sun, 24 Mar 2024 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1rUB6p1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F01C5253;
	Sun, 24 Mar 2024 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320361; cv=none; b=YhIx+ljW3q21MaMYSP007vMIl8hvFZ/g/RsHLknlZKWSecGezlPJDP+axdjEoV3zENgJNf6vyzsk9T/5Sn5ACoz9GdOjgpfEpTb+98BWcdKZW9u0+y3g77Svea6fPeLpRuD7nFOV3dWEWruSe6lC5XML4W+ioCgx/0FftxXBzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320361; c=relaxed/simple;
	bh=iAAwPBARqElI3urwW/f/AREmpJj/qdzdFprYZpKRXh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSjALqYZN4hCuTcl9ZSLC6GBoWCOZwDnP0Ep6Qcn3fr2dfJmuOy84/FoMj1ZCzcngWVPDgDSuxzsrpdT3/9NPSjlBMeV9Q4gBoySk8J0r+oF+NOqAND5G9tWQrThtMJT7E/x7BuDJPKmsWk3ot/qddHD6Ajoc6WI1e4SW3CUVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1rUB6p1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C403CC43390;
	Sun, 24 Mar 2024 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320360;
	bh=iAAwPBARqElI3urwW/f/AREmpJj/qdzdFprYZpKRXh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1rUB6p1qX/BCkwSjs1eG0jjf5GEcBMKI1zU1kpuE9Kh1DEv8UykHYIZ6xPBPqy4P
	 jbgRk3mqjjcFicz0tV9NJnExxkT3cvPC9QxBmnMXN7PVDOBuBXc/njmod2Y25Xfq6h
	 +rnNn7tpe3mN4hkXv79ObDULoiOfijiPKODI3XHSTf4hAsAzNVby6RxtunqJlJDKlX
	 FfzlNmhuVNUfzpZiqjZyn5lTvX56n/1nIilCpNdJahFIsBOvZXt8lOWg52Du9087eW
	 6wLip4wMfZIeWbHiEZWDGW+1LDm3ZfmYkB1hfCuAyJcLAd7sbw9rQCgmrZK14WEhU8
	 xslpbFeqFTg5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 667/715] ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED
Date: Sun, 24 Mar 2024 18:34:06 -0400
Message-ID: <20240324223455.1342824-668-sashal@kernel.org>
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

[ Upstream commit 094d11768f740f11483dad4efcd9bbcffa4ce146 ]

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
Link: https://msgid.link/r/20240220201623.438944-3-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp.c | 3 ++-
 sound/soc/sof/amd/acp.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index deddf8a92db87..4db8cdc91daae 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -26,6 +26,7 @@ MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
 
 static struct acp_quirk_entry quirk_valve_galileo = {
 	.signed_fw_image = true,
+	.skip_iram_dram_size_mod = true,
 };
 
 const struct dmi_system_id acp_sof_quirk_table[] = {
@@ -281,7 +282,7 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 	}
 
 	/* psp_send_cmd only required for vangogh platform (rev - 5) */
-	if (desc->rev == 5) {
+	if (desc->rev == 5 && !(adata->quirks && adata->quirks->skip_iram_dram_size_mod)) {
 		/* Modify IRAM and DRAM size */
 		ret = psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | IRAM_DRAM_FENCE_2);
 		if (ret)
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 90a2d9d0dd633..7d4a8b6b3cc67 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -195,6 +195,7 @@ struct sof_amd_acp_desc {
 
 struct acp_quirk_entry {
 	bool signed_fw_image;
+	bool skip_iram_dram_size_mod;
 };
 
 /* Common device data struct for ACP devices */
-- 
2.43.0


