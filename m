Return-Path: <linux-kernel+bounces-4623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7BE818011
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C51C23104
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD775253;
	Tue, 19 Dec 2023 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KHCleshB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03A8474;
	Tue, 19 Dec 2023 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702955262;
	bh=yTI/2EyPQ8dikP4XMvHL83IpZe0+cQCB5jAsZLInsrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHCleshBag26U8woojapCZlBD6PfWUWH295Mm/EC+piz7H0TYxbwdQ9M0UVQcB5AQ
	 G717lm33xF3d5fvfo905cscBVns7jyuJi/DjCdkRPdm360ztQwhV1LGb1baIYrMzQs
	 k+AasryPn1T6SGbJOncBrF8IzRCkI5lZs4RIENjbED3v0oHbDb1MwP0GonY8gZ0/NX
	 N8pAvAxqeUYgRkt/dHw0bx3s6zL7lFv+o3IshyXFIwSqCjuiv2RxRv5ZuoFQ1nwxzC
	 Lb0i2AqYKyO2aUf1WdfP+Or4Iee2W6EEml/BPlD5aeRg1/XIEmH7wOZINVyhkYLsXS
	 i6uh6Tp5KaNoQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DA11F3781493;
	Tue, 19 Dec 2023 03:07:41 +0000 (UTC)
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
Subject: [PATCH v2 1/8] ASoC: amd: acp: Drop redundant initialization of machine driver data
Date: Tue, 19 Dec 2023 05:07:19 +0200
Message-ID: <20231219030728.2431640-2-cristian.ciocaltea@collabora.com>
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

Simplify driver data configuration by removing redundant initialization
of members in static structs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
---
 sound/soc/amd/acp/acp-sof-mach.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 2a9fd3275e42..1d313fcb5f2d 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -28,7 +28,6 @@ static struct acp_card_drvdata sof_rt5682_rt1019_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682_max_data = {
@@ -38,7 +37,6 @@ static struct acp_card_drvdata sof_rt5682_max_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
@@ -48,7 +46,6 @@ static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682s_max_data = {
@@ -58,7 +55,6 @@ static struct acp_card_drvdata sof_rt5682s_max_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_nau8825_data = {
@@ -69,7 +65,6 @@ static struct acp_card_drvdata sof_nau8825_data = {
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
 	.soc_mclk = true,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682s_hs_rt1019_data = {
@@ -80,20 +75,15 @@ static struct acp_card_drvdata sof_rt5682s_hs_rt1019_data = {
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
 	.soc_mclk = true,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_nau8821_max98388_data = {
 	.hs_cpu_id = I2S_SP,
 	.amp_cpu_id = I2S_HS,
 	.bt_cpu_id = I2S_BT,
-	.dmic_cpu_id = NONE,
 	.hs_codec_id = NAU8821,
 	.amp_codec_id = MAX98388,
-	.bt_codec_id = NONE,
-	.dmic_codec_id = NONE,
 	.soc_mclk = true,
-	.tdm_mode = false,
 };
 
 static int acp_sof_probe(struct platform_device *pdev)
-- 
2.43.0


