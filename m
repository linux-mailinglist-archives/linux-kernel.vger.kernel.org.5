Return-Path: <linux-kernel+bounces-11218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C172F81E353
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC581C21588
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9B4A994;
	Tue, 26 Dec 2023 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFziaKiF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4617137B;
	Tue, 26 Dec 2023 00:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7004BC433C8;
	Tue, 26 Dec 2023 00:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550086;
	bh=jwVZ6REd/ZS5qU5T1yRiv9rc5NjMMrDhehnwVqOzzRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFziaKiFTctvM3dNvvfRX/9n9niXWymL4/ldV3AW0xtKJXq2xyRSRsziuBeA5ZHYz
	 mDdFRRzq6cYhjYcx7yMGLFcl5Mh+94w0TFZvUO/TouCfvUAwCp+Lqr3nT0LrDX7c8N
	 AUqYNbiH/XLuq+cGOSW0lVex1/94NjWbQbaqD694O7bpChg5laMcEk8cTod2ki473W
	 SI8ACM2lCDsY4vratr1ooN8jUP3c9QUEnoa+RDtmkxCfdyD+Vt3qjiA1caG4NJp7u8
	 HjkkWpRXzmKsfts4FXCeBUhd7MTkzJhOuFSYtydpActHpt75aZb/IvxUaBXAT9mH02
	 981HqCMk98aVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	nicolas.ferre@microchip.com,
	kuninori.morimoto.gx@renesas.com,
	u.kleine-koenig@pengutronix.de,
	andriy.shevchenko@linux.intel.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 25/39] ASoC: Intel: bytcr_rt5640: Add new swapped-speakers quirk
Date: Mon, 25 Dec 2023 19:19:15 -0500
Message-ID: <20231226002021.4776-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit b1b6131bca35a55a69fadc39d51577968fa2ee97 ]

Some BYTCR x86 tablets with a rt5640 codec have the left and right channels
of their speakers swapped.

Add a new BYT_RT5640_SWAPPED_SPEAKERS quirk for this which sets
cfg-spk:swapped in the components string to let userspace know
about the swapping so that the UCM profile can configure the mixer
to correct this.

Enable this new quirk on the Medion Lifetab S10346 which has its
speakers swapped.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20231217213221.49424-2-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index f184d23deaa0f..6b631a608ae8f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -83,6 +83,7 @@ enum {
 #define BYT_RT5640_HSMIC2_ON_IN1	BIT(27)
 #define BYT_RT5640_JD_HP_ELITEP_1000G2	BIT(28)
 #define BYT_RT5640_USE_AMCR0F28		BIT(29)
+#define BYT_RT5640_SWAPPED_SPEAKERS	BIT(30)
 
 #define BYTCR_INPUT_DEFAULTS				\
 	(BYT_RT5640_IN3_MAP |				\
@@ -157,6 +158,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_NO_SPEAKERS)
 		dev_info(dev, "quirk NO_SPEAKERS enabled\n");
+	if (byt_rt5640_quirk & BYT_RT5640_SWAPPED_SPEAKERS)
+		dev_info(dev, "quirk SWAPPED_SPEAKERS enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT)
 		dev_info(dev, "quirk LINEOUT enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_LINEOUT_AS_HP2)
@@ -903,6 +906,7 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_MATCH(DMI_BIOS_DATE, "10/22/2015"),
 		},
 		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_SWAPPED_SPEAKERS |
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
@@ -1631,11 +1635,11 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	const char *platform_name;
 	struct acpi_device *adev;
 	struct device *codec_dev;
+	const char *cfg_spk;
 	bool sof_parent;
 	int ret_val = 0;
 	int dai_index = 0;
-	int i, cfg_spk;
-	int aif;
+	int i, aif;
 
 	is_bytcr = false;
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -1795,13 +1799,16 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	}
 
 	if (byt_rt5640_quirk & BYT_RT5640_NO_SPEAKERS) {
-		cfg_spk = 0;
+		cfg_spk = "0";
 		spk_type = "none";
 	} else if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) {
-		cfg_spk = 1;
+		cfg_spk = "1";
 		spk_type = "mono";
+	} else if (byt_rt5640_quirk & BYT_RT5640_SWAPPED_SPEAKERS) {
+		cfg_spk = "swapped";
+		spk_type = "swapped";
 	} else {
-		cfg_spk = 2;
+		cfg_spk = "2";
 		spk_type = "stereo";
 	}
 
@@ -1816,7 +1823,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		headset2_string = " cfg-hs2:in1";
 
 	snprintf(byt_rt5640_components, sizeof(byt_rt5640_components),
-		 "cfg-spk:%d cfg-mic:%s aif:%d%s%s", cfg_spk,
+		 "cfg-spk:%s cfg-mic:%s aif:%d%s%s", cfg_spk,
 		 map_name[BYT_RT5640_MAP(byt_rt5640_quirk)], aif,
 		 lineout_string, headset2_string);
 	byt_rt5640_card.components = byt_rt5640_components;
-- 
2.43.0


