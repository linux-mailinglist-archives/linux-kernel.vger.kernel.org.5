Return-Path: <linux-kernel+bounces-41706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF7983F6D6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDF51C2255C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3176F54BC5;
	Sun, 28 Jan 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoM2PIVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB4254729;
	Sun, 28 Jan 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458333; cv=none; b=K1sDhnTNkCsR0Jz+CLS6PDToQnwXiq6OX9TKTpcFxMD2NM7/lCwhju3VTfq9HFys2C2dw/gFTYA4B5IbcZ2xwf7boQB+3veEjtArcQ2aCjfI0LCHSuFjxveQcMgmX3B0e0Q/l0uz15k/u/KTKH7BSMtEAvg3vliaffNqpp4QXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458333; c=relaxed/simple;
	bh=AYwjX9NZn8KyMuM5X9m/tzbJx+yYqjVr068BuOwxfGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFF1KhW+X6P4Wc+irw4yUnSbvBEXzqf/rx+5HHgF2w5PXblsJvDBL9n94lTbfAAKwz+rYPc+pM9kiCSxqHFFkv54Wg7QGOjMSzPFpotZapja+1d01SKaCQ4ZodF/u7EbutvLOGZNOf42jYlg6GOp4KjKu0hCnu5xcghNq7k6xiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoM2PIVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32704C43394;
	Sun, 28 Jan 2024 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458333;
	bh=AYwjX9NZn8KyMuM5X9m/tzbJx+yYqjVr068BuOwxfGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoM2PIVRqziyZzqKIQnklR5mulKFCAQVELK2aXtBoYwHioXLOsxkqeW+GLvWxxcID
	 O5BJUc6irQSvO53GRl6pXIUbcjlePY7bR2ENOhYjVMQCrlIWYperUScNsGYufZATCO
	 aJx+NH201ixMJwK2OQnp0RTtshG6dQMpbHxpUl0ErQ6tMDXO2IjKL2SDDPeNcd2F2n
	 0m77R6pFCT44nKRbv6v5Pa0gUwputswfQlZWPUX3sJI2jhP86BfKbB69zy+VBZ81nt
	 Hd5X7PO8oaD8VUHALv04b1QtrvDXwR8L1o0HsxhBGvArB/ftNsjV/E/7nKY7aUNiIs
	 0bV8sJPo54KAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ChiYuan Huang <cy_huang@richtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 24/39] ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow
Date: Sun, 28 Jan 2024 11:10:44 -0500
Message-ID: <20240128161130.200783-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: ChiYuan Huang <cy_huang@richtek.com>

[ Upstream commit 415d10ccef712f3ec73cd880c1fef3eb48601c3a ]

To enable TDM mode, the current control flow limits the function
calling order should be 'set_tdm_slot->set_dai_fmt'. But not all
platform sound card like as simeple card to follow this design.
To bypass this limit, adjust the DAI format setting in runtime
'hw_param' callback.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Link: https://msgid.link/r/c4c8df00d8d179b8b5b39a8521de3a85325c57e8.1703813842.git.cy_huang@richtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.43.0


