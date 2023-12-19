Return-Path: <linux-kernel+bounces-4625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35B818014
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43621C23136
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF9BA5D;
	Tue, 19 Dec 2023 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xHxGhrui"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E75C98;
	Tue, 19 Dec 2023 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702955264;
	bh=KKBUh4EW6rsoiJPuZY4j0nAbOd+R8WFN1oLOfidMr5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xHxGhruiItWt4VEAQ5PB4Q2fe7ABzgBsBT3vg2jppuAIDZ5f/27qEqCTwTJee0gqM
	 No0trt93klYqb/T1Pceb7l8es7UbxmsHaVXE0N+AvY2rVodRgap1F4W2zMfhx37LRh
	 KG8SkkhHaI0ldbuUaH2/CoWhMMAlChfh1BOPnGk5wGjEU8RResf7WQMYvXRBV7KRUM
	 VD2zG5vhrohNXj/E+9HGJkRlQAwyl4DdOnrH+JrkT680kT34BqRTjrmoVlX8k7K8tY
	 HiQsq9xHDduAh58UAd2g3I7ALHJErfsvbPza+R1SDrhQIINPeNqmhrHQCgwOZ2sDN9
	 VTKHgNR7x2S6w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0C02B37814A3;
	Tue, 19 Dec 2023 03:07:44 +0000 (UTC)
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
Subject: [PATCH v2 3/8] ASoC: amd: acp: Add missing error handling in sof-mach
Date: Tue, 19 Dec 2023 05:07:21 +0200
Message-ID: <20231219030728.2431640-4-cristian.ciocaltea@collabora.com>
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

Handle potential acp_sofdsp_dai_links_create() errors in ACP SOF machine
driver's probe function.  Note there is no need for an undo.

While at it, switch to dev_err_probe().

Fixes: 9f84940f5004 ("ASoC: amd: acp: Add SOF audio support on Chrome board")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
---
 sound/soc/amd/acp/acp-sof-mach.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 1d313fcb5f2d..6f0ca23638af 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -112,16 +112,14 @@ static int acp_sof_probe(struct platform_device *pdev)
 	if (dmi_id && dmi_id->driver_data)
 		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
 
-	acp_sofdsp_dai_links_create(card);
+	ret = acp_sofdsp_dai_links_create(card);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to create DAI links\n");
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev,
-				"devm_snd_soc_register_card(%s) failed: %d\n",
-				card->name, ret);
-		return ret;
-	}
-
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register card(%s)\n", card->name);
 	return 0;
 }
 
-- 
2.43.0


