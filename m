Return-Path: <linux-kernel+bounces-73633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF985C55A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E40D1F21B41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C57214A4F3;
	Tue, 20 Feb 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="alM4x5BO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB61468E0;
	Tue, 20 Feb 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459283; cv=none; b=bUJslq2BlqrmJLKdjIVMV1RCux5a1IcV3au96MK59Q32JWlX9hzZxglMiUl/veKLlWOhh7X0e7SIE2ZaAvi/Tq/rc03kjE6EYItJ7Z9OUimSfes3WrJ0QV7mt4oooQiv19l8YAkV/gclTLGOe+hKUtPecjVAERfsQ54d+C8mjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459283; c=relaxed/simple;
	bh=fz4nms9uFIzLRt9/3C1od1Er33MdSyqJcC2YXg6fnlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMqA6V8zZJd0XBNr94qIbjbIVdYnLgy/m4/sRu/UX9eiiGvvvJpwPV0WIb7Wo8T/aqVi/K1JXxHxVaNPKdmo/pOk9ydnRHetFonvKpRLlxf2rhgi7adT3aMN4nQGpQS55dl8ciA96QeGQ5qZDqmvy9Q+yhHbsWSPSZUJLkv5tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=alM4x5BO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708459279;
	bh=fz4nms9uFIzLRt9/3C1od1Er33MdSyqJcC2YXg6fnlg=;
	h=From:To:Cc:Subject:Date:From;
	b=alM4x5BOR8PlsOoyfcvkOrVhjoU/dO7YEkpiD/S4eKu7/a/N/ER6ye600UHuFL16S
	 q1Bl9xFdtb6IWtPLh3uTNzS6TgdwF5GQ9ncIlW3P2hhyODF9s/drPi2dKUprPsw/H+
	 y6Y4Yoi4ZFZIjQZvlPmdA2uanEtmMnu0YHdgeO/lbD0d0KHb5BsgwXin/QNWX9aKxq
	 RNrQUUnYAQOy45H1QHJBabTaO2iV99kmo07tZO44QTWweDtlgEEw9xBVMz99e7mWsl
	 eCMzjR1GuqxLZk68c3uE12n2lbbvCqw7xMyNbhvkoESvbpYmV1Uh935xIWcqNp5Dym
	 vkeqd1OTF+Jrg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA8F037820A7;
	Tue, 20 Feb 2024 20:01:18 +0000 (UTC)
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
Subject: [PATCH] ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED
Date: Tue, 20 Feb 2024 22:01:12 +0200
Message-ID: <20240220200116.438346-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.2
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

It's worth noting this is the only Vangogh compatible device for which
signed firmware support has been enabled in AMD ACP SOF driver via
acp_sof_quirk_table.

Hence, use this information and skip IRAM/DRAM size modification for Vangogh
platforms having the signed_fw_image field set.

Fixes: 55d7bbe43346 ("ASoC: SOF: amd: Add acp-psp mailbox interface for iram-dram fence register modification")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/sof/amd/acp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 9b3c26210db3..71689d2a5b56 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -278,7 +278,14 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 	}
 
 	/* psp_send_cmd only required for vangogh platform (rev - 5) */
-	if (desc->rev == 5) {
+	/*
+	 * FIXME: This causes IPC timeout when trying to load DSP topology
+	 * on the Steam Deck OLED device matching acp_sof_quirk_table above.
+	 * The quirk enables signed firmware support on this particular
+	 * Vangogh compatible device, hence skip IRAM/DRAM size modification
+	 * when signed_fw_image is set.
+	 */
+	if (desc->rev == 5 && !adata->signed_fw_image) {
 		/* Modify IRAM and DRAM size */
 		ret = psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | IRAM_DRAM_FENCE_2);
 		if (ret)
-- 
2.43.0


