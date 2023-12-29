Return-Path: <linux-kernel+bounces-12907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5E881FC70
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA3B285E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1322F443C;
	Fri, 29 Dec 2023 01:46:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B523B3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636823:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 29 Dec 2023 09:46:03 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Fri, 29 Dec
 2023 09:46:03 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Fri, 29 Dec 2023 09:46:03 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, ChiYuan Huang <cy_huang@richtek.com>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow
Date: Fri, 29 Dec 2023 09:46:02 +0800
Message-ID: <c4c8df00d8d179b8b5b39a8521de3a85325c57e8.1703813842.git.cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1703813842.git.cy_huang@richtek.com>
References: <cover.1703813842.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

To enable TDM mode, the current control flow limits the function
calling order should be 'set_tdm_slot->set_dai_fmt'. But not all
platform sound card like as simeple card to follow this design.
To bypass this limit, adjust the DAI format setting in runtime
'hw_param' callback.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rtq9128.c | 67 ++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/rtq9128.c b/sound/soc/codecs/rtq9128.c
index bda64f9eeb62..aa3eadecd974 100644
--- a/sound/soc/codecs/rtq9128.c
+++ b/sound/soc/codecs/rtq9128.c
@@ -59,6 +59,7 @@
 
 struct rtq9128_data {
 	struct gpio_desc *enable;
+	unsigned int daifmt;
 	int tdm_slots;
 	int tdm_slot_width;
 	bool tdm_input_data2_select;
@@ -441,10 +442,7 @@ static const struct snd_soc_component_driver rtq9128_comp_driver = {
 static int rtq9128_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct rtq9128_data *data = snd_soc_dai_get_drvdata(dai);
-	struct snd_soc_component *comp = dai->component;
 	struct device *dev = dai->dev;
-	unsigned int audfmt, fmtval;
-	int ret;
 
 	dev_dbg(dev, "%s: fmt 0x%8x\n", __func__, fmt);
 
@@ -454,35 +452,10 @@ static int rtq9128_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	fmtval = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
-	if (data->tdm_slots && fmtval != SND_SOC_DAIFMT_DSP_A && fmtval != SND_SOC_DAIFMT_DSP_B) {
-		dev_err(dev, "TDM is used, format only support DSP_A or DSP_B\n");
-		return -EINVAL;
-	}
+	/* Store here and will be used in runtime hw_params for DAI format setting */
+	data->daifmt = fmt;
 
-	switch (fmtval) {
-	case SND_SOC_DAIFMT_I2S:
-		audfmt = 8;
-		break;
-	case SND_SOC_DAIFMT_LEFT_J:
-		audfmt = 9;
-		break;
-	case SND_SOC_DAIFMT_RIGHT_J:
-		audfmt = 10;
-		break;
-	case SND_SOC_DAIFMT_DSP_A:
-		audfmt = data->tdm_slots ? 12 : 11;
-		break;
-	case SND_SOC_DAIFMT_DSP_B:
-		audfmt = data->tdm_slots ? 4 : 3;
-		break;
-	default:
-		dev_err(dev, "Unsupported format 0x%8x\n", fmt);
-		return -EINVAL;
-	}
-
-	ret = snd_soc_component_write_field(comp, RTQ9128_REG_I2S_OPT, RTQ9128_AUDFMT_MASK, audfmt);
-	return ret < 0 ? ret : 0;
+	return 0;
 }
 
 static int rtq9128_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
@@ -558,10 +531,38 @@ static int rtq9128_dai_hw_params(struct snd_pcm_substream *stream, struct snd_pc
 	unsigned int width, slot_width, bitrate, audbit, dolen;
 	struct snd_soc_component *comp = dai->component;
 	struct device *dev = dai->dev;
+	unsigned int fmtval, audfmt;
 	int ret;
 
 	dev_dbg(dev, "%s: width %d\n", __func__, params_width(param));
 
+	fmtval = FIELD_GET(SND_SOC_DAIFMT_FORMAT_MASK, data->daifmt);
+	if (data->tdm_slots && fmtval != SND_SOC_DAIFMT_DSP_A && fmtval != SND_SOC_DAIFMT_DSP_B) {
+		dev_err(dev, "TDM is used, format only support DSP_A or DSP_B\n");
+		return -EINVAL;
+	}
+
+	switch (fmtval) {
+	case SND_SOC_DAIFMT_I2S:
+		audfmt = 8;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		audfmt = 9;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		audfmt = 10;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		audfmt = data->tdm_slots ? 12 : 11;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		audfmt = data->tdm_slots ? 4 : 3;
+		break;
+	default:
+		dev_err(dev, "Unsupported format 0x%8x\n", fmtval);
+		return -EINVAL;
+	}
+
 	switch (width = params_width(param)) {
 	case 16:
 		audbit = 0;
@@ -615,6 +616,10 @@ static int rtq9128_dai_hw_params(struct snd_pcm_substream *stream, struct snd_pc
 		return -EINVAL;
 	}
 
+	ret = snd_soc_component_write_field(comp, RTQ9128_REG_I2S_OPT, RTQ9128_AUDFMT_MASK, audfmt);
+	if (ret < 0)
+		return ret;
+
 	ret = snd_soc_component_write_field(comp, RTQ9128_REG_I2S_OPT, RTQ9128_AUDBIT_MASK, audbit);
 	if (ret < 0)
 		return ret;
-- 
2.34.1


