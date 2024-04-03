Return-Path: <linux-kernel+bounces-129018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0530089633A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB6D1F233F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E31BC3C;
	Wed,  3 Apr 2024 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="zyndQt1z"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301B5235
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712116120; cv=none; b=QDcjlPCkB5uzyeN+I//m/Lc4tIRndAdEjZCIsXtE2+AI5GLedE30vrVhTyYdBCSayZHYCzo1Nw3GxSDM/5keX5+VN9nJNouu8dMb3v/07J/tOgvCqBhxvXtq0oPQ9NQolY9GVMb39KV6JMuRzFHxcZKv6dVWQMurkEfmKKiUcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712116120; c=relaxed/simple;
	bh=ndjWUkiQxFhB+YUyp9xI7yNVAxXlfZ48boxBHddhv54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LiR+upQR9wOH3vthZoC5QDr0jRjI/6D7g9d4Vf8MZsn+3yfhqpX8QAlyQiXfvSaKclY7yH96qEcmmEA/g0mkrpUMnNaiwaIlPDtakZFws6y13PiYqOy+w1+irgzz/wab8kf0+uDRZrDVULOrMrca/YARwsPVqxegEYqe+Xjfvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=zyndQt1z; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1712116115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zfGNTdHGRpnjFOt+FjgvToOxrKfAVm82OlrQ9zXAjnQ=;
	b=zyndQt1zIsMppv801JN1EM3Fn/QrlRg7s7TOA950YH4aq3M+3nlukvNKty36CjAMkG+GrI
	In+1Z6RTcrwnGhlfmepyBZzGB+gfRDASmpMTpaSQcnKAG1pYKEGk+smKum12UDf9eHrr6X
	hpm3GtyEOq/hIVAHDpOucZr5KecRLHrtc8dS2LnJBg9K0snCky8P4sS/T3Jr/yQB7GzPhG
	99sQdPH+DWsSXFqiDZbeZVkuDwKfxQJrUeR4lsvdZ3e3farqcSPE5DmGbA5FVb/onj5sBD
	ZvmMA5DPjXu/L0pN/bcIbCUk4D+wI92rJfEaMD7DY4ubb5bDIid/V1XV2YoanA==
From: John Watts <contact@jookia.org>
Date: Wed, 03 Apr 2024 14:47:35 +1100
Subject: [PATCH v2] ASoC: sunxi: sun4i-i2s: Support 32-bit audio formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-sunxi_s32-v2-1-29ebf6ad590a@jookia.org>
X-B4-Tracking: v=1; b=H4sIAFbRDGYC/23MQQ7CIBCF4as0sxZTporUlfcwjYF2aEcTMKBNT
 cPdxa5d/i8v3wqJIlOCc7VCpJkTB18CdxX0k/EjCR5KA9Z4qBtUIr39wrfUoHBoLB6tJqU1lP8
 zkuNls65d6YnTK8TPRs/yt/5TZimk0G3rTnLorSR1uYfwYLMPcYQu5/wFlfHcUqMAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712116102; l=6016;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=ndjWUkiQxFhB+YUyp9xI7yNVAxXlfZ48boxBHddhv54=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAa930fEXUwIDvw7QRQA5oG7s
 X21Y9PWXr+mPX/U2pgIrUnInsJrzVjEV7rxv0RgE6SCtfF2uHA9VEbGEedqfXCwUAAOgG
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT

The I2S cores used in the H3 onwards support 32-bit sample rates.
Support these by adding a per-variant PCM format list.

Signed-off-by: John Watts <contact@jookia.org>
---
This patch enables support for 32-bit audio in the sunxi I2S driver.

I have only tested this on the Allwinner T113 but I'm fairly
certain it will work on older boards.
---
Changes in v2:
- Specify PCM formats for each variant instead of failing in hw_params
- Link to v1: https://lore.kernel.org/r/20240326-sunxi_s32-v1-1-899f71dcb1e6@jookia.org
---
 sound/soc/sunxi/sun4i-i2s.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a736f632bf0b..59830f2a0d30 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -156,6 +156,7 @@ struct sun4i_i2s;
 /**
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  * @has_reset: SoC needs reset deasserted.
+ * @pcm_formats: available PCM formats
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
@@ -175,6 +176,7 @@ struct sun4i_i2s;
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
+	snd_pcm_format_t		pcm_formats;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
 
@@ -1092,8 +1094,18 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static int sun4i_i2s_dai_startup(struct snd_pcm_substream *sub, struct snd_soc_dai *dai)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	struct snd_pcm_runtime *runtime = sub->runtime;
+
+	return snd_pcm_hw_constraint_mask64(runtime, SNDRV_PCM_HW_PARAM_FORMAT,
+					    i2s->variant->pcm_formats);
+}
+
 static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.probe		= sun4i_i2s_dai_probe,
+	.startup	= sun4i_i2s_dai_startup,
 	.hw_params	= sun4i_i2s_hw_params,
 	.set_fmt	= sun4i_i2s_set_fmt,
 	.set_sysclk	= sun4i_i2s_set_sysclk,
@@ -1101,9 +1113,10 @@ static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.trigger	= sun4i_i2s_trigger,
 };
 
-#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
-			 SNDRV_PCM_FMTBIT_S20_LE | \
-			 SNDRV_PCM_FMTBIT_S24_LE)
+#define SUN4I_FORMATS_ALL (SNDRV_PCM_FMTBIT_S16_LE | \
+			   SNDRV_PCM_FMTBIT_S20_LE | \
+			   SNDRV_PCM_FMTBIT_S24_LE | \
+			   SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.capture = {
@@ -1111,14 +1124,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SUN4I_FORMATS,
+		.formats = SUN4I_FORMATS_ALL,
 	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SUN4I_FORMATS,
+		.formats = SUN4I_FORMATS_ALL,
 	},
 	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rate = 1,
@@ -1340,8 +1353,12 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+#define SUN4I_FORMATS_A10 (SUN4I_FORMATS_ALL & ~SNDRV_PCM_FMTBIT_S32_LE)
+#define SUN4I_FORMATS_H3 SUN4I_FORMATS_ALL
+
 static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.has_reset		= false,
+	.pcm_formats		= SUN4I_FORMATS_A10,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
@@ -1360,6 +1377,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.has_reset		= true,
+	.pcm_formats		= SUN4I_FORMATS_A10,
 	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
@@ -1383,6 +1401,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
  */
 static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.has_reset		= true,
+	.pcm_formats		= SUN4I_FORMATS_A10,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
@@ -1401,6 +1420,7 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 
 static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.has_reset		= true,
+	.pcm_formats		= SUN4I_FORMATS_H3,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
@@ -1419,6 +1439,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.has_reset		= true,
+	.pcm_formats		= SUN4I_FORMATS_H3,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
@@ -1437,6 +1458,7 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 
 static const struct sun4i_i2s_quirks sun50i_h6_i2s_quirks = {
 	.has_reset		= true,
+	.pcm_formats		= SUN4I_FORMATS_H3,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun50i_h6_i2s_regmap_config,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
@@ -1455,6 +1477,7 @@ static const struct sun4i_i2s_quirks sun50i_h6_i2s_quirks = {
 
 static const struct sun4i_i2s_quirks sun50i_r329_i2s_quirks = {
 	.has_reset		= true,
+	.pcm_formats		= SUN4I_FORMATS_H3,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun50i_h6_i2s_regmap_config,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),

---
base-commit: 13227c2baa6b345451128828c9c2b0ec3868bd0d
change-id: 20240326-sunxi_s32-f2ab25b8e688

Best regards,
-- 
John Watts <contact@jookia.org>


