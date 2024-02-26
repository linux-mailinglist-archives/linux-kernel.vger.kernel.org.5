Return-Path: <linux-kernel+bounces-81565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707D8677A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99C11F25B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954B212CD93;
	Mon, 26 Feb 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZToJxGhG"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145C12C540
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956144; cv=none; b=gCC0deM8ZDtgj/b8HC7WVNE4p8c7SMfX9oy7PRM4S+hjd0wcW97tffY+3IX6EgHnVowfUxvkUC417daauPeGzq2G8jAgTL439JRf/f48Yr+i7DvdDd7P64Oc7UBPg/U/wJQ9WTzUhbuJusPVbHMBHO8W9o1oSPc3S8E08YLUSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956144; c=relaxed/simple;
	bh=SrduQYlu24mwPGARYnXMeCn+sTZ1dLl4sYNSXpURd3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fuKyPVUnq9ZrU14SLXMFqCbCe3DKnKcRzevDZEul8oCrMJnpuSUlHPhJhXJ+mFuIQjnkIs7fglxXCm4dlypH156y3StCwfLtZuduU7CuiOQKZvESvMQr5DHhAofy4i2maGwJ2BFsiCfqg+WKYF2A241HrwpF6Bh45w73gcrWO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZToJxGhG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a3371133so8300595e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708956140; x=1709560940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPQGNsmnx8ItRUj59IGkC4A0AuBuTT2gX3dXdQxnn7M=;
        b=ZToJxGhGtMiDYLH1brseWyzVv3uiTtrtbK0Kc9fCgoRxFypuVFE7FiV3MpltAB/Ltc
         8S7QAaBtK7k3QPeFWre9ryU4qmHQuF8cufGtjuKNTk//zCOcK2E1XqEma/bWa6x1Jsgm
         AY0e2iMSHtUpWLNXJjMokcmOR2QGVTM13yuIb818+157ivNMB5YwK/6bAIpQeQY922gU
         0GO4ZyL6pKJs3QMZIb8TYu0BHhQmzBKPdGTkNjI4PtuEzdjzj+VGgCHNMCM4aoEy6JfV
         UmlNvL/v1/6xangC63ZXBZwpEGICpo5qzu0r9L9BQYRENsm425nd9vnJaxe7dv+hyX3/
         gDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708956140; x=1709560940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPQGNsmnx8ItRUj59IGkC4A0AuBuTT2gX3dXdQxnn7M=;
        b=t1MnmVliOHFbuPk6y3t5K45r0YCvVlhLMSz+eduXBvojO0aKXSE7+yOCjs3rDIEjZP
         GQrh+MCmETj6O8SkSnczs2WU4nAMQByQrb/mNPRu1V9oy6qt8xTw15+gwqlrbzBUb+dE
         Ksc9SAhtkAZTn3ZVCxn8c2Cyhdirb4SQLM2NJ5UuQa/MH48lZYOu97M4pOavg4MwFN+r
         JitT89DjeeaffzXmNWh/s59f6b1Vm89vZjxWDTbLgstp5rTXKys08Ago6cBWZJeDvLob
         kOYh/IFrDui6VkEVHtNAIWvYsUpBkXaYDzC6t8+ytOTUIr6knmyhus+bHVqdTUyn4Ga0
         qk+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo+o2HohfAZ4dr3EdMo35LJ88nbkVqPqei5TSLCmcUCniY7cDHp886D1Ul5NXY11Fb0D/+vfRV/+SJVm8K+gnN3lFF32zQD55e0qIw
X-Gm-Message-State: AOJu0YyOQA3CieRJSJ04aBAMYHZokibaBs4ttkjH+5K/S2BBKQNwKpLd
	B11STXomaL5L3xgdKMpLhDGCxqArTVCGkF/IXIXwzwtWymxeIrPuQ59T5qeM8go=
X-Google-Smtp-Source: AGHT+IFtJlh3XDv5IRZeTCLZF4mgcvHxQx8YexVeoN+E9kqnKHMlqNZKpZBaMRsnOLkgyZter7jFLA==
X-Received: by 2002:a7b:c447:0:b0:410:e43d:24e9 with SMTP id l7-20020a7bc447000000b00410e43d24e9mr6075105wmi.22.1708956139906;
        Mon, 26 Feb 2024 06:02:19 -0800 (PST)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d33-20020a05600c4c2100b004129f87a2c6sm2838475wmp.1.2024.02.26.06.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:02:19 -0800 (PST)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 26 Feb 2024 15:01:47 +0100
Subject: [PATCH 09/18] ASoC: mediatek: mt8365: Add PCM DAI support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v1-9-4fa1cea1667f@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
In-Reply-To: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8239; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=SrduQYlu24mwPGARYnXMeCn+sTZ1dLl4sYNSXpURd3c=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBl3JncOT/sN5jqDF7//+lc/ZeUzCaBNJADGLuCuAvr
 2Kv7vvGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZdyZ3AAKCRArRkmdfjHURdHgD/
 wNHRI17DKoBBVZuUR6cTWmWj1X2CDH/RcNiJ4iunhr1d3AZUyeq3jRyrF/Yr/8CMSgfmnBY55uCtoK
 96dvOuQI19T67dKFUZ4V/EnPB+OgtxPxZ6IVvKUiwKYY5g8tUMCg9Zo7XE8AOHhA2QFpnmbqFzUcRq
 deUL8cGtRQ40jNyKI3ftfaqXYJtPgnldwr/+grslVCD6S/hsGfBJPKQOeUCLw8YO2mQl+RPoPBPNub
 z5l6iqo4o9Ohop147O7RT61jfKMhswwtXw8X7ifs4ob9TO4CmdUYdP2RyftmXzBqBk11EoIHKDs4BD
 JGvWsuKwF9vhuGw2qDIV8ZYKU/B9V+cpOJ+7k7+jrocaYaJi/HNUesgq/MNLYxOn4uvx08fFePTvMR
 BKdwxh3g7Vg2APRtje4UBEuEfKPlBP3/SSdx+uxhe8X22IjAqUk8CDotIvQFmTlVLJD1WUT21lHs2G
 gciqaoUQfY4KQ7AiLxU1senUnOKVd7tOzZ+oHHksIHBvuFBK63RY/PxRusOpu2fheSdec9dCYsfYXn
 5uT8hrwBVJVnOULjtN7GLYtAu/1sr+JEYtPhqVJ+kE2Su7VT9+bGMJw/q1ikVpRXemPew03UdMSprY
 4qNVODwFQXu9Q9eL4FSdSV/ubbvhTX2bLz+e6HncTcUK2HxqyAUiqboJ6fqA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add Pulse Code Modulation Device Audio Interface support for MT8365 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 sound/soc/mediatek/mt8365/mt8365-dai-pcm.c | 298 +++++++++++++++++++++++++++++
 1 file changed, 298 insertions(+)

diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-pcm.c b/sound/soc/mediatek/mt8365/mt8365-dai-pcm.c
new file mode 100644
index 000000000000..02ee81663e50
--- /dev/null
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-pcm.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek 8365 ALSA SoC Audio DAI PCM Control
+ *
+ * Copyright (c) 2024 MediaTek Inc.
+ * Authors: Jia Zeng <jia.zeng@mediatek.com>
+ *          Alexandre Mergnat <amergnat@baylibre.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt8365-afe-clk.h"
+#include "mt8365-afe-common.h"
+
+struct mt8365_pcm_intf_data {
+	bool slave_mode;
+	bool lrck_inv;
+	bool bck_inv;
+	unsigned int format;
+};
+
+/* DAI Drivers */
+
+static void mt8365_dai_enable_pcm1(struct mtk_base_afe *afe)
+{
+	regmap_update_bits(afe->regmap, PCM_INTF_CON1,
+			   PCM_INTF_CON1_EN, PCM_INTF_CON1_EN);
+}
+
+static void mt8365_dai_disable_pcm1(struct mtk_base_afe *afe)
+{
+	regmap_update_bits(afe->regmap, PCM_INTF_CON1,
+			   PCM_INTF_CON1_EN, 0x0);
+}
+
+static int mt8365_dai_configure_pcm1(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime * const runtime = substream->runtime;
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+	struct mt8365_pcm_intf_data *pcm_priv = afe_priv->dai_priv[MT8365_AFE_IO_PCM1];
+	bool slave_mode = pcm_priv->slave_mode;
+	bool lrck_inv = pcm_priv->lrck_inv;
+	bool bck_inv = pcm_priv->bck_inv;
+	unsigned int fmt = pcm_priv->format;
+	unsigned int bit_width = dai->sample_bits;
+	unsigned int val = 0;
+
+	if (!slave_mode) {
+		val |= PCM_INTF_CON1_MASTER_MODE |
+		       PCM_INTF_CON1_BYPASS_ASRC;
+
+		if (lrck_inv)
+			val |= PCM_INTF_CON1_SYNC_OUT_INV;
+		if (bck_inv)
+			val |= PCM_INTF_CON1_BCLK_OUT_INV;
+	} else {
+		val |= PCM_INTF_CON1_SLAVE_MODE;
+
+		if (lrck_inv)
+			val |= PCM_INTF_CON1_SYNC_IN_INV;
+		if (bck_inv)
+			val |= PCM_INTF_CON1_BCLK_IN_INV;
+
+		// TODO: add asrc setting
+	}
+
+	val |= FIELD_PREP(PCM_INTF_CON1_FORMAT_MASK, fmt);
+
+	if (fmt == MT8365_PCM_FORMAT_PCMA ||
+	    fmt == MT8365_PCM_FORMAT_PCMB)
+		val |= PCM_INTF_CON1_SYNC_LEN(1);
+	else
+		val |= PCM_INTF_CON1_SYNC_LEN(bit_width);
+
+	switch (runtime->rate) {
+	case 48000:
+		val |= PCM_INTF_CON1_FS_48K;
+		break;
+	case 32000:
+		val |= PCM_INTF_CON1_FS_32K;
+		break;
+	case 16000:
+		val |= PCM_INTF_CON1_FS_16K;
+		break;
+	case 8000:
+		val |= PCM_INTF_CON1_FS_8K;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (bit_width > 16)
+		val |= PCM_INTF_CON1_24BIT | PCM_INTF_CON1_64BCK;
+	else
+		val |= PCM_INTF_CON1_16BIT | PCM_INTF_CON1_32BCK;
+
+	val |= PCM_INTF_CON1_EXT_MODEM;
+
+	regmap_update_bits(afe->regmap, PCM_INTF_CON1,
+			   PCM_INTF_CON1_CONFIG_MASK, val);
+
+	return 0;
+}
+
+static int mt8365_dai_pcm1_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	if (snd_soc_dai_active(dai))
+		return 0;
+
+	mt8365_afe_enable_main_clk(afe);
+
+	return 0;
+}
+
+static void mt8365_dai_pcm1_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	if (snd_soc_dai_active(dai))
+		return;
+
+	mt8365_dai_disable_pcm1(afe);
+	mt8365_afe_disable_main_clk(afe);
+}
+
+static int mt8365_dai_pcm1_prepare(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	if ((snd_soc_dai_stream_active_playback(dai) + snd_soc_dai_stream_active_capture(dai))
+		> 1) {
+		dev_info(afe->dev, "%s '%s' active(%u-%u) already\n",
+			 __func__, snd_pcm_stream_str(substream),
+			 snd_soc_dai_stream_active_playback(dai),
+			 snd_soc_dai_stream_active_capture(dai));
+		return 0;
+	}
+
+	ret = mt8365_dai_configure_pcm1(substream, dai);
+	if (ret)
+		return ret;
+
+	mt8365_dai_enable_pcm1(afe);
+
+	return 0;
+}
+
+static int mt8365_dai_pcm1_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+	struct mt8365_pcm_intf_data *pcm_priv = afe_priv->dai_priv[MT8365_AFE_IO_PCM1];
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		pcm_priv->format = MT8365_PCM_FORMAT_I2S;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		pcm_priv->bck_inv = false;
+		pcm_priv->lrck_inv = false;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		pcm_priv->bck_inv = false;
+		pcm_priv->lrck_inv = true;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		pcm_priv->bck_inv = true;
+		pcm_priv->lrck_inv = false;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		pcm_priv->bck_inv = true;
+		pcm_priv->lrck_inv = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		pcm_priv->slave_mode = true;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		pcm_priv->slave_mode = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mt8365_dai_pcm1_ops = {
+	.startup	= mt8365_dai_pcm1_startup,
+	.shutdown	= mt8365_dai_pcm1_shutdown,
+	.prepare	= mt8365_dai_pcm1_prepare,
+	.set_fmt	= mt8365_dai_pcm1_set_fmt,
+};
+
+static struct snd_soc_dai_driver mtk_dai_pcm_driver[] = {
+	{
+		.name = "PCM1",
+		.id = MT8365_AFE_IO_PCM1,
+		.playback = {
+			.stream_name = "PCM1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_32000 |
+				 SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.capture = {
+			.stream_name = "PCM1 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_32000 |
+				 SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.ops = &mt8365_dai_pcm1_ops,
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
+	}
+};
+
+/* DAI widget */
+
+static const struct snd_soc_dapm_widget mtk_dai_pcm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("PCM1 Out"),
+	SND_SOC_DAPM_INPUT("PCM1 In"),
+};
+
+/* DAI route */
+
+static const struct snd_soc_dapm_route mtk_dai_pcm_routes[] = {
+	{"PCM1 Playback", NULL, "O07"},
+	{"PCM1 Playback", NULL, "O08"},
+	{"PCM1 Out", NULL, "PCM1 Playback"},
+
+	{"I09", NULL, "PCM1 Capture"},
+	{"I22", NULL, "PCM1 Capture"},
+	{"PCM1 Capture", NULL, "PCM1 In"},
+};
+
+static int init_pcmif_priv_data(struct mtk_base_afe *afe)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+	struct mt8365_pcm_intf_data *pcmif_priv;
+
+	pcmif_priv = devm_kzalloc(afe->dev, sizeof(struct mt8365_pcm_intf_data),
+				  GFP_KERNEL);
+	if (!pcmif_priv)
+		return -ENOMEM;
+
+	afe_priv->dai_priv[MT8365_AFE_IO_PCM1] = pcmif_priv;
+	return 0;
+}
+
+int mt8365_dai_pcm_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dev_dbg(afe->dev, "%s()\n", __func__);
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_pcm_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_pcm_driver);
+	dai->dapm_widgets = mtk_dai_pcm_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_pcm_widgets);
+	dai->dapm_routes = mtk_dai_pcm_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_pcm_routes);
+
+	return init_pcmif_priv_data(afe);
+}

-- 
2.25.1


