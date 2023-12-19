Return-Path: <linux-kernel+bounces-4627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F47818016
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3165B1F243B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42687D526;
	Tue, 19 Dec 2023 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5WoaJT75"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6CA8BFD;
	Tue, 19 Dec 2023 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702955266;
	bh=NedD0CsTyD06CZpoZGygoYeaj43j/jCPYz4qI72jJJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=5WoaJT75SqIPQPy5/Vc2rZUoXCIC4RzpQyyp6Ho42tU6BgZB4x1XCgcBNWWE5Bx9+
	 HUFr5J41WF4dw/v29/aq27nYcOmCvFz6T4VouDc/lCs2cIft+/t6TwyDDXTPnkMSHj
	 9NCzmDgAZwtahf0GcetOTsDVg1zSInRRKCECHaX53ml183fg2O/EFhyPYxTBQWsL3h
	 u1PYwZKubok48pIqLiWEFWniCbwpYS765u9zgSaQCH+57GhOsaMiyIoqukmqZQMy9b
	 q6uBEn4pM4OGerlmrZMEr6PKQgCys9B8EK++E9ra4UlqVlSBhHo0oOGv4IUg4O1ytU
	 qQzUcla1XKeXQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 42AB237814AF;
	Tue, 19 Dec 2023 03:07:46 +0000 (UTC)
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
Subject: [PATCH v2 5/8] ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
Date: Tue, 19 Dec 2023 05:07:23 +0200
Message-ID: <20231219030728.2431640-6-cristian.ciocaltea@collabora.com>
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

Driver uses kasprintf() to initialize fw_{code,data}_bin members of
struct acp_dev_data, but kfree() is never called to deallocate the
memory, which results in a memory leak.

Fix the issue by switching to devm_kasprintf(). Additionally, ensure the
allocation was successful by checking the pointer validity.

Fixes: f7da88003c53 ("ASoC: SOF: amd: Enable signed firmware image loading for Vangogh platform")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
---
 sound/soc/sof/amd/acp.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 603ea5fc0d0d..c6f637f29847 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -547,17 +547,27 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	adata->signed_fw_image = false;
 	dmi_id = dmi_first_match(acp_sof_quirk_table);
 	if (dmi_id && dmi_id->driver_data) {
-		adata->fw_code_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-code.bin",
-					       plat_data->fw_filename_prefix,
-					       chip->name);
-		adata->fw_data_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-data.bin",
-					       plat_data->fw_filename_prefix,
-					       chip->name);
-		adata->signed_fw_image = dmi_id->driver_data;
+		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+						    "%s/sof-%s-code.bin",
+						    plat_data->fw_filename_prefix,
+						    chip->name);
+		if (!adata->fw_code_bin) {
+			ret = -ENOMEM;
+			goto free_ipc_irq;
+		}
+
+		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+						    "%s/sof-%s-data.bin",
+						    plat_data->fw_filename_prefix,
+						    chip->name);
+		if (!adata->fw_data_bin) {
+			ret = -ENOMEM;
+			goto free_ipc_irq;
+		}
 
-		dev_dbg(sdev->dev, "fw_code_bin:%s, fw_data_bin:%s\n", adata->fw_code_bin,
-			adata->fw_data_bin);
+		adata->signed_fw_image = dmi_id->driver_data;
 	}
+
 	adata->enable_fw_debug = enable_fw_debug;
 	acp_memory_init(sdev);
 
-- 
2.43.0


