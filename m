Return-Path: <linux-kernel+bounces-4624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165E5818013
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8DF1C2309A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C60746C;
	Tue, 19 Dec 2023 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OBRqJFWE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A9468A;
	Tue, 19 Dec 2023 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702955263;
	bh=FnwOT4udSoOtLQKVV79JIZooVh5Oz2VNKMvuC2X9zEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBRqJFWEEjuqBEjc/VsK7Ntf04jlW273Ux4ldBhmu8DI+lo3rx6nx1cDqAmMLtVpA
	 3/oTLCQkMsRQP9ibTTehvGful48NN5S9gCL4cAxF6rUFYdSJy+EhDTfesMxlSh3n0o
	 pZfzZ9jBBj/z6DSb5tV8EoTS2i/2AqNZnfybrAfUlAoHC32h8KzgQyzN+G3x4IRU8H
	 wvrM5ytKJ2ChEMAW0T/jEaMHgakjdvxn1OuNQ2xF3jz4xp3wheh3VfXIgS2JbeISAH
	 u7TWgHkRlIXFqpHCxkD0sJ6N5Rth8+c2eEQNRqMV4QPWiDK72vUbUuk+2WbsywjlGm
	 y1cXxj+tDdzDA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EFA123781495;
	Tue, 19 Dec 2023 03:07:42 +0000 (UTC)
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
Subject: [PATCH v2 2/8] ASoC: amd: acp: Make use of existing *_CODEC_DAI macros
Date: Tue, 19 Dec 2023 05:07:20 +0200
Message-ID: <20231219030728.2431640-3-cristian.ciocaltea@collabora.com>
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

The generic ACP machine driver provides macros for NAU88221 and MAX98388
codec DAI names, but in places it is still using directly the related
strings.

For consistency, replace all strings with the equivalent macros.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index c90ec3419247..346f7514c81a 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -821,8 +821,8 @@ static const struct snd_soc_ops acp_card_maxim_ops = {
 };
 
 SND_SOC_DAILINK_DEF(max98388,
-		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ADS8388:00", "max98388-aif1"),
-				       COMP_CODEC("i2c-ADS8388:01", "max98388-aif1")));
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ADS8388:00", MAX98388_CODEC_DAI),
+				       COMP_CODEC("i2c-ADS8388:01", MAX98388_CODEC_DAI)));
 
 static const struct snd_kcontrol_new max98388_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Left Spk"),
@@ -1273,7 +1273,7 @@ static const struct snd_soc_ops acp_8821_ops = {
 
 SND_SOC_DAILINK_DEF(nau8821,
 		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-NVTN2020:00",
-						  "nau8821-hifi")));
+						  NAU8821_CODEC_DAI)));
 
 /* Declare DMIC codec components */
 SND_SOC_DAILINK_DEF(dmic_codec,
-- 
2.43.0


