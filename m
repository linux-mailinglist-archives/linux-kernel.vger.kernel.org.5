Return-Path: <linux-kernel+bounces-81320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27721867419
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C651F2BC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300485A7B6;
	Mon, 26 Feb 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXoNMWSo"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2AA5B053
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948776; cv=none; b=PgsisCJelJTD8NjprcHviE8SjXbaO2budSQtPaevVxXQUvH1WmRxfB10KQRZq3PA8zCH2dTQTI4Do1C9BkYbZd/rO9/J1JNVZc9ofZTtWFHmEXt2mxjs9vq3qUOF6adbu+MgsxxnO3AEeP5fxj6tVxeycdXfemKUkEre55jRL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948776; c=relaxed/simple;
	bh=CkwbBUIUKO5SJ9t7ffy8WMpQrbWGeysU5UyJwC6emfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmmRoA3PRenYmxbUOtlyP94KNyJkeouOgfubCzfI13dKnWxlUfgtw3uVUT9Ih9IM4n6/H3YOozh6k9BDWL2lUyfV0Gx92kJuN82R8VvldzUHGiB8SK+enXPQaF4LcTOYTHd2l1sUDhasVDyD5nqKojtYQKsKU9yPtyPLf3S8cEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXoNMWSo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3d484a58f6so412602166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708948771; x=1709553571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l6k8/wA1f6Mt62+K8VGN3NZatUJVWNKv8dxjTtiByU=;
        b=fXoNMWSoWIzxWZye6php03rV1KGLOjyzhTQ/H1yo+UYexSyqhcm2d2Mg7olOuQunis
         HERcOLbTr+cNDfZGz17tnr6U1DB20qQbxHGgMRxqt9Kg+o6JV1XpPR1uMttIP8xPH/vT
         JLGgbP+MFBPwbg+/45cE0FPvFcSI2pWXWi6f9MCwR6lsWtQop8X77Vf4ai/1LLW86bjs
         Tq/z2YTuXwzuffQ4e0LlKWk3+ZkobnlIkvN5bTqbk7o3Vcob8egzArG3Pp17jCm3NEsf
         2+UibSgIUJrdU6D2F5TImcC3iQ0vfd8d5Xj4N1eLysmCPZ3ZFyxpm1myJgzley56KD29
         eEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948771; x=1709553571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l6k8/wA1f6Mt62+K8VGN3NZatUJVWNKv8dxjTtiByU=;
        b=lakT+UspEozBHgomNvBLb/vE9F/C9d914dddOUrtfSGSLnvZb1BGfhXt0BgghIPJJi
         W4lBjArBBaNDDkTeoSEibFPAXytxbc/u/bgRTdWYPyfJarRq5rA7INwEHuovqNACgiEl
         Mp0JuWjxaj056vNIUU1FsZfx69eWesWLDJKq3fxCdvNFdiLkoYnAD9zm9WDtkJFcuaVF
         jrFqPpP61MQ9O5lr2YyOKMXlqnZCZvogS7gyXzl53MgPsvVFP/XdKgUk5VeD94pMR9QX
         H1bo1FzSyHuxkK+u2gqvOvoD6qv5TjbToQPR0tQ290FNo5Z0uqVJr5XsUwqT4RPox56+
         oJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlKIcm3OucUl0Td2Jey7k4XBABsde6t6NGeA76D+42vjOgwszokQRa1lVkPi5hVIdg5yiPYE3JfNFtbbEOvjumM/8JPi/j3oGhfqdl
X-Gm-Message-State: AOJu0Yyg4Y0gcp11VYEhysCFEOQgbZGXd6mTX+4PzenV1QC+er9HDOeI
	vBHa+iCqimTj6HSLyc8AQcQdBZ3mUKEvsfnk8ZgBqQovURGIewTZ0cj7vQ3KD4k=
X-Google-Smtp-Source: AGHT+IEVe+Ft2Fvaqu+b6O1sPtvkt/pyfWbuEvL+voODkgtb5Pjp9z6KZIzUvsRqaEkJNoiL8btUpQ==
X-Received: by 2002:a17:906:f28e:b0:a42:fcf2:1077 with SMTP id gu14-20020a170906f28e00b00a42fcf21077mr3357389ejb.23.1708948771284;
        Mon, 26 Feb 2024 03:59:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id tb16-20020a1709078b9000b00a42ea030a6esm2311877ejc.82.2024.02.26.03.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:59:30 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] ASoC: codecs: tx-macro: split widgets per different LPASS versions
Date: Mon, 26 Feb 2024 12:59:24 +0100
Message-Id: <20240226115925.53953-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226115925.53953-1-krzysztof.kozlowski@linaro.org>
References: <20240226115925.53953-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TX macro codec differs slightly between different Qualcomm Low Power
Audio SubSystem (LPASS) block versions.  In LPASS version 9.2 the
register responsible for TX SMIC MUXn muxes is different, thus to
properly support it, the driver needs to register different widgets per
different LPASS version.

Prepare for supporting this register difference by refactoring existing
code:
1. Move few widgets (TX SMIC MUXn, TX SWR_ADCn, TX SWR_DMICn) out of
   common 'tx_macro_dapm_widgets[]' array to a new per-variant specific
   array 'tx_macro_dapm_widgets_v9[]'.
2. Move also related audio routes into new array.
3. Store pointers to these variant-specific arrays in new variant-data
   structure 'tx_macro_data'.
4. Add variant-specific widgets and routes in component probe, instead
   of driver probe.

The change should have no real impact, except re-shuffling code and
registering some widgets and audio routes in component probe, instead of
driver probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v4:
1. None

Changes in v3:
1. None

Changes in v2:
1. Keep all the MSM_DMIC/TX DMIC MUX audio routes in the shared
   tx_audio_map, because it does not differ between v9 and v9.2.

2. Rebase. qcom,sm6115-lpass-tx-macro appeared so add new
   lpass_ver_10_sm6115 entry.
---
 sound/soc/codecs/lpass-macro-common.h |   6 +
 sound/soc/codecs/lpass-tx-macro.c     | 377 +++++++++++++++-----------
 2 files changed, 232 insertions(+), 151 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index d3684c7ab930..18f5b8c8e822 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -11,6 +11,12 @@
 /* The soundwire block should be internally reset at probe */
 #define LPASS_MACRO_FLAG_RESET_SWR		BIT(1)
 
+enum lpass_version {
+	LPASS_VER_9_0_0,
+	LPASS_VER_10_0_0,
+	LPASS_VER_11_0_0,
+};
+
 struct lpass_macro {
 	struct device *macro_pd;
 	struct device *dcodec_pd;
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 7e51212d4503..d6b3b6bb6923 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -255,8 +255,18 @@ struct hpf_work {
 	struct delayed_work dwork;
 };
 
+struct tx_macro_data {
+	unsigned int flags;
+	unsigned int ver;
+	const struct snd_soc_dapm_widget *extra_widgets;
+	size_t extra_widgets_num;
+	const struct snd_soc_dapm_route *extra_routes;
+	size_t extra_routes_num;
+};
+
 struct tx_macro {
 	struct device *dev;
+	const struct tx_macro_data *data;
 	struct snd_soc_component *component;
 	struct hpf_work tx_hpf_work[NUM_DECIMATORS];
 	struct tx_mute_work tx_mute_dwork[NUM_DECIMATORS];
@@ -1237,53 +1247,6 @@ static const struct snd_kcontrol_new tx_dec5_mux = SOC_DAPM_ENUM("tx_dec5", tx_d
 static const struct snd_kcontrol_new tx_dec6_mux = SOC_DAPM_ENUM("tx_dec6", tx_dec6_enum);
 static const struct snd_kcontrol_new tx_dec7_mux = SOC_DAPM_ENUM("tx_dec7", tx_dec7_enum);
 
-static const char * const smic_mux_text[] = {
-	"ZERO", "ADC0", "ADC1", "ADC2", "ADC3", "SWR_DMIC0",
-	"SWR_DMIC1", "SWR_DMIC2", "SWR_DMIC3", "SWR_DMIC4",
-	"SWR_DMIC5", "SWR_DMIC6", "SWR_DMIC7"
-};
-
-static SOC_ENUM_SINGLE_DECL(tx_smic0_enum, CDC_TX_INP_MUX_ADC_MUX0_CFG0,
-			0, smic_mux_text);
-
-static SOC_ENUM_SINGLE_DECL(tx_smic1_enum, CDC_TX_INP_MUX_ADC_MUX1_CFG0,
-			0, smic_mux_text);
-
-static SOC_ENUM_SINGLE_DECL(tx_smic2_enum, CDC_TX_INP_MUX_ADC_MUX2_CFG0,
-			0, smic_mux_text);
-
-static SOC_ENUM_SINGLE_DECL(tx_smic3_enum, CDC_TX_INP_MUX_ADC_MUX3_CFG0,
-			0, smic_mux_text);
-
-static SOC_ENUM_SINGLE_DECL(tx_smic4_enum, CDC_TX_INP_MUX_ADC_MUX4_CFG0,
-			0, smic_mux_text);
-
-static SOC_ENUM_SINGLE_DECL(tx_smic5_enum, CDC_TX_INP_MUX_ADC_MUX5_CFG0,
-			0, smic_mux_text);
-
-static SOC_ENUM_SINGLE_DECL(tx_smic6_enum, CDC_TX_INP_MUX_ADC_MUX6_CFG0,
-			0, smic_mux_text);
-
-static SOC_ENUM_SINGLE_DECL(tx_smic7_enum, CDC_TX_INP_MUX_ADC_MUX7_CFG0,
-			0, smic_mux_text);
-
-static const struct snd_kcontrol_new tx_smic0_mux = SOC_DAPM_ENUM_EXT("tx_smic0", tx_smic0_enum,
-			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
-static const struct snd_kcontrol_new tx_smic1_mux = SOC_DAPM_ENUM_EXT("tx_smic1", tx_smic1_enum,
-			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
-static const struct snd_kcontrol_new tx_smic2_mux = SOC_DAPM_ENUM_EXT("tx_smic2", tx_smic2_enum,
-			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
-static const struct snd_kcontrol_new tx_smic3_mux = SOC_DAPM_ENUM_EXT("tx_smic3", tx_smic3_enum,
-			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
-static const struct snd_kcontrol_new tx_smic4_mux = SOC_DAPM_ENUM_EXT("tx_smic4", tx_smic4_enum,
-			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
-static const struct snd_kcontrol_new tx_smic5_mux = SOC_DAPM_ENUM_EXT("tx_smic5", tx_smic5_enum,
-			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
-static const struct snd_kcontrol_new tx_smic6_mux = SOC_DAPM_ENUM_EXT("tx_smic6", tx_smic6_enum,
-			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
-static const struct snd_kcontrol_new tx_smic7_mux = SOC_DAPM_ENUM_EXT("tx_smic7", tx_smic7_enum,
-			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
-
 static const char * const dmic_mux_text[] = {
 	"ZERO", "DMIC0", "DMIC1", "DMIC2", "DMIC3",
 	"DMIC4", "DMIC5", "DMIC6", "DMIC7"
@@ -1429,15 +1392,6 @@ static const struct snd_soc_dapm_widget tx_macro_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("TX_AIF3_CAP Mixer", SND_SOC_NOPM, TX_MACRO_AIF3_CAP, 0,
 		tx_aif3_cap_mixer, ARRAY_SIZE(tx_aif3_cap_mixer)),
 
-	SND_SOC_DAPM_MUX("TX SMIC MUX0", SND_SOC_NOPM, 0, 0, &tx_smic0_mux),
-	SND_SOC_DAPM_MUX("TX SMIC MUX1", SND_SOC_NOPM, 0, 0, &tx_smic1_mux),
-	SND_SOC_DAPM_MUX("TX SMIC MUX2", SND_SOC_NOPM, 0, 0, &tx_smic2_mux),
-	SND_SOC_DAPM_MUX("TX SMIC MUX3", SND_SOC_NOPM, 0, 0, &tx_smic3_mux),
-	SND_SOC_DAPM_MUX("TX SMIC MUX4", SND_SOC_NOPM, 0, 0, &tx_smic4_mux),
-	SND_SOC_DAPM_MUX("TX SMIC MUX5", SND_SOC_NOPM, 0, 0, &tx_smic5_mux),
-	SND_SOC_DAPM_MUX("TX SMIC MUX6", SND_SOC_NOPM, 0, 0, &tx_smic6_mux),
-	SND_SOC_DAPM_MUX("TX SMIC MUX7", SND_SOC_NOPM, 0, 0, &tx_smic7_mux),
-
 	SND_SOC_DAPM_MUX("TX DMIC MUX0", SND_SOC_NOPM, 4, 0, &tx_dmic0_mux),
 	SND_SOC_DAPM_MUX("TX DMIC MUX1", SND_SOC_NOPM, 4, 0, &tx_dmic1_mux),
 	SND_SOC_DAPM_MUX("TX DMIC MUX2", SND_SOC_NOPM, 4, 0, &tx_dmic2_mux),
@@ -1447,18 +1401,6 @@ static const struct snd_soc_dapm_widget tx_macro_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("TX DMIC MUX6", SND_SOC_NOPM, 4, 0, &tx_dmic6_mux),
 	SND_SOC_DAPM_MUX("TX DMIC MUX7", SND_SOC_NOPM, 4, 0, &tx_dmic7_mux),
 
-	SND_SOC_DAPM_INPUT("TX SWR_ADC0"),
-	SND_SOC_DAPM_INPUT("TX SWR_ADC1"),
-	SND_SOC_DAPM_INPUT("TX SWR_ADC2"),
-	SND_SOC_DAPM_INPUT("TX SWR_ADC3"),
-	SND_SOC_DAPM_INPUT("TX SWR_DMIC0"),
-	SND_SOC_DAPM_INPUT("TX SWR_DMIC1"),
-	SND_SOC_DAPM_INPUT("TX SWR_DMIC2"),
-	SND_SOC_DAPM_INPUT("TX SWR_DMIC3"),
-	SND_SOC_DAPM_INPUT("TX SWR_DMIC4"),
-	SND_SOC_DAPM_INPUT("TX SWR_DMIC5"),
-	SND_SOC_DAPM_INPUT("TX SWR_DMIC6"),
-	SND_SOC_DAPM_INPUT("TX SWR_DMIC7"),
 	SND_SOC_DAPM_INPUT("TX DMIC0"),
 	SND_SOC_DAPM_INPUT("TX DMIC1"),
 	SND_SOC_DAPM_INPUT("TX DMIC2"),
@@ -1580,6 +1522,150 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX DMIC MUX0", "DMIC6", "TX DMIC6"},
 	{"TX DMIC MUX0", "DMIC7", "TX DMIC7"},
 
+	{"TX DEC1 MUX", "MSM_DMIC", "TX DMIC MUX1"},
+	{"TX DMIC MUX1", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX1", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX1", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX1", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX1", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX1", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX1", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX1", "DMIC7", "TX DMIC7"},
+
+	{"TX DEC2 MUX", "MSM_DMIC", "TX DMIC MUX2"},
+	{"TX DMIC MUX2", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX2", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX2", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX2", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX2", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX2", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX2", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX2", "DMIC7", "TX DMIC7"},
+
+	{"TX DEC3 MUX", "MSM_DMIC", "TX DMIC MUX3"},
+	{"TX DMIC MUX3", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX3", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX3", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX3", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX3", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX3", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX3", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX3", "DMIC7", "TX DMIC7"},
+
+	{"TX DEC4 MUX", "MSM_DMIC", "TX DMIC MUX4"},
+	{"TX DMIC MUX4", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX4", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX4", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX4", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX4", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX4", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX4", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX4", "DMIC7", "TX DMIC7"},
+
+	{"TX DEC5 MUX", "MSM_DMIC", "TX DMIC MUX5"},
+	{"TX DMIC MUX5", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX5", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX5", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX5", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX5", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX5", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX5", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX5", "DMIC7", "TX DMIC7"},
+
+	{"TX DEC6 MUX", "MSM_DMIC", "TX DMIC MUX6"},
+	{"TX DMIC MUX6", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX6", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX6", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX6", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX6", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX6", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX6", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX6", "DMIC7", "TX DMIC7"},
+
+	{"TX DEC7 MUX", "MSM_DMIC", "TX DMIC MUX7"},
+	{"TX DMIC MUX7", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX7", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX7", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX7", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX7", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX7", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX7", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX7", "DMIC7", "TX DMIC7"},
+};
+
+/* Controls and routes specific to LPASS <= v9.0.0 */
+static const char * const smic_mux_text_v9[] = {
+	"ZERO", "ADC0", "ADC1", "ADC2", "ADC3", "SWR_DMIC0",
+	"SWR_DMIC1", "SWR_DMIC2", "SWR_DMIC3", "SWR_DMIC4",
+	"SWR_DMIC5", "SWR_DMIC6", "SWR_DMIC7"
+};
+
+static SOC_ENUM_SINGLE_DECL(tx_smic0_enum_v9, CDC_TX_INP_MUX_ADC_MUX0_CFG0,
+			0, smic_mux_text_v9);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic1_enum_v9, CDC_TX_INP_MUX_ADC_MUX1_CFG0,
+			0, smic_mux_text_v9);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic2_enum_v9, CDC_TX_INP_MUX_ADC_MUX2_CFG0,
+			0, smic_mux_text_v9);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic3_enum_v9, CDC_TX_INP_MUX_ADC_MUX3_CFG0,
+			0, smic_mux_text_v9);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic4_enum_v9, CDC_TX_INP_MUX_ADC_MUX4_CFG0,
+			0, smic_mux_text_v9);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic5_enum_v9, CDC_TX_INP_MUX_ADC_MUX5_CFG0,
+			0, smic_mux_text_v9);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic6_enum_v9, CDC_TX_INP_MUX_ADC_MUX6_CFG0,
+			0, smic_mux_text_v9);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic7_enum_v9, CDC_TX_INP_MUX_ADC_MUX7_CFG0,
+			0, smic_mux_text_v9);
+
+static const struct snd_kcontrol_new tx_smic0_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic0", tx_smic0_enum_v9,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic1_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic1", tx_smic1_enum_v9,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic2_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic2", tx_smic2_enum_v9,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic3_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic3", tx_smic3_enum_v9,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic4_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic4", tx_smic4_enum_v9,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic5_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic5", tx_smic5_enum_v9,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic6_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic6", tx_smic6_enum_v9,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic7_mux_v9 = SOC_DAPM_ENUM_EXT("tx_smic7", tx_smic7_enum_v9,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+
+static const struct snd_soc_dapm_widget tx_macro_dapm_widgets_v9[] = {
+	SND_SOC_DAPM_MUX("TX SMIC MUX0", SND_SOC_NOPM, 0, 0, &tx_smic0_mux_v9),
+	SND_SOC_DAPM_MUX("TX SMIC MUX1", SND_SOC_NOPM, 0, 0, &tx_smic1_mux_v9),
+	SND_SOC_DAPM_MUX("TX SMIC MUX2", SND_SOC_NOPM, 0, 0, &tx_smic2_mux_v9),
+	SND_SOC_DAPM_MUX("TX SMIC MUX3", SND_SOC_NOPM, 0, 0, &tx_smic3_mux_v9),
+	SND_SOC_DAPM_MUX("TX SMIC MUX4", SND_SOC_NOPM, 0, 0, &tx_smic4_mux_v9),
+	SND_SOC_DAPM_MUX("TX SMIC MUX5", SND_SOC_NOPM, 0, 0, &tx_smic5_mux_v9),
+	SND_SOC_DAPM_MUX("TX SMIC MUX6", SND_SOC_NOPM, 0, 0, &tx_smic6_mux_v9),
+	SND_SOC_DAPM_MUX("TX SMIC MUX7", SND_SOC_NOPM, 0, 0, &tx_smic7_mux_v9),
+
+	SND_SOC_DAPM_INPUT("TX SWR_ADC0"),
+	SND_SOC_DAPM_INPUT("TX SWR_ADC1"),
+	SND_SOC_DAPM_INPUT("TX SWR_ADC2"),
+	SND_SOC_DAPM_INPUT("TX SWR_ADC3"),
+	SND_SOC_DAPM_INPUT("TX SWR_DMIC0"),
+	SND_SOC_DAPM_INPUT("TX SWR_DMIC1"),
+	SND_SOC_DAPM_INPUT("TX SWR_DMIC2"),
+	SND_SOC_DAPM_INPUT("TX SWR_DMIC3"),
+	SND_SOC_DAPM_INPUT("TX SWR_DMIC4"),
+	SND_SOC_DAPM_INPUT("TX SWR_DMIC5"),
+	SND_SOC_DAPM_INPUT("TX SWR_DMIC6"),
+	SND_SOC_DAPM_INPUT("TX SWR_DMIC7"),
+};
+
+static const struct snd_soc_dapm_route tx_audio_map_v9[] = {
 	{"TX DEC0 MUX", "SWR_MIC", "TX SMIC MUX0"},
 	{"TX SMIC MUX0", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX0", "ADC0", "TX SWR_ADC0"},
@@ -1595,16 +1681,6 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX0", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX0", "SWR_DMIC7", "TX SWR_DMIC7"},
 
-	{"TX DEC1 MUX", "MSM_DMIC", "TX DMIC MUX1"},
-	{"TX DMIC MUX1", "DMIC0", "TX DMIC0"},
-	{"TX DMIC MUX1", "DMIC1", "TX DMIC1"},
-	{"TX DMIC MUX1", "DMIC2", "TX DMIC2"},
-	{"TX DMIC MUX1", "DMIC3", "TX DMIC3"},
-	{"TX DMIC MUX1", "DMIC4", "TX DMIC4"},
-	{"TX DMIC MUX1", "DMIC5", "TX DMIC5"},
-	{"TX DMIC MUX1", "DMIC6", "TX DMIC6"},
-	{"TX DMIC MUX1", "DMIC7", "TX DMIC7"},
-
 	{"TX DEC1 MUX", "SWR_MIC", "TX SMIC MUX1"},
 	{"TX SMIC MUX1", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX1", "ADC0", "TX SWR_ADC0"},
@@ -1620,16 +1696,6 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX1", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX1", "SWR_DMIC7", "TX SWR_DMIC7"},
 
-	{"TX DEC2 MUX", "MSM_DMIC", "TX DMIC MUX2"},
-	{"TX DMIC MUX2", "DMIC0", "TX DMIC0"},
-	{"TX DMIC MUX2", "DMIC1", "TX DMIC1"},
-	{"TX DMIC MUX2", "DMIC2", "TX DMIC2"},
-	{"TX DMIC MUX2", "DMIC3", "TX DMIC3"},
-	{"TX DMIC MUX2", "DMIC4", "TX DMIC4"},
-	{"TX DMIC MUX2", "DMIC5", "TX DMIC5"},
-	{"TX DMIC MUX2", "DMIC6", "TX DMIC6"},
-	{"TX DMIC MUX2", "DMIC7", "TX DMIC7"},
-
 	{"TX DEC2 MUX", "SWR_MIC", "TX SMIC MUX2"},
 	{"TX SMIC MUX2", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX2", "ADC0", "TX SWR_ADC0"},
@@ -1645,16 +1711,6 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX2", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX2", "SWR_DMIC7", "TX SWR_DMIC7"},
 
-	{"TX DEC3 MUX", "MSM_DMIC", "TX DMIC MUX3"},
-	{"TX DMIC MUX3", "DMIC0", "TX DMIC0"},
-	{"TX DMIC MUX3", "DMIC1", "TX DMIC1"},
-	{"TX DMIC MUX3", "DMIC2", "TX DMIC2"},
-	{"TX DMIC MUX3", "DMIC3", "TX DMIC3"},
-	{"TX DMIC MUX3", "DMIC4", "TX DMIC4"},
-	{"TX DMIC MUX3", "DMIC5", "TX DMIC5"},
-	{"TX DMIC MUX3", "DMIC6", "TX DMIC6"},
-	{"TX DMIC MUX3", "DMIC7", "TX DMIC7"},
-
 	{"TX DEC3 MUX", "SWR_MIC", "TX SMIC MUX3"},
 	{"TX SMIC MUX3", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX3", "ADC0", "TX SWR_ADC0"},
@@ -1670,16 +1726,6 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX3", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX3", "SWR_DMIC7", "TX SWR_DMIC7"},
 
-	{"TX DEC4 MUX", "MSM_DMIC", "TX DMIC MUX4"},
-	{"TX DMIC MUX4", "DMIC0", "TX DMIC0"},
-	{"TX DMIC MUX4", "DMIC1", "TX DMIC1"},
-	{"TX DMIC MUX4", "DMIC2", "TX DMIC2"},
-	{"TX DMIC MUX4", "DMIC3", "TX DMIC3"},
-	{"TX DMIC MUX4", "DMIC4", "TX DMIC4"},
-	{"TX DMIC MUX4", "DMIC5", "TX DMIC5"},
-	{"TX DMIC MUX4", "DMIC6", "TX DMIC6"},
-	{"TX DMIC MUX4", "DMIC7", "TX DMIC7"},
-
 	{"TX DEC4 MUX", "SWR_MIC", "TX SMIC MUX4"},
 	{"TX SMIC MUX4", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX4", "ADC0", "TX SWR_ADC0"},
@@ -1695,16 +1741,6 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX4", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX4", "SWR_DMIC7", "TX SWR_DMIC7"},
 
-	{"TX DEC5 MUX", "MSM_DMIC", "TX DMIC MUX5"},
-	{"TX DMIC MUX5", "DMIC0", "TX DMIC0"},
-	{"TX DMIC MUX5", "DMIC1", "TX DMIC1"},
-	{"TX DMIC MUX5", "DMIC2", "TX DMIC2"},
-	{"TX DMIC MUX5", "DMIC3", "TX DMIC3"},
-	{"TX DMIC MUX5", "DMIC4", "TX DMIC4"},
-	{"TX DMIC MUX5", "DMIC5", "TX DMIC5"},
-	{"TX DMIC MUX5", "DMIC6", "TX DMIC6"},
-	{"TX DMIC MUX5", "DMIC7", "TX DMIC7"},
-
 	{"TX DEC5 MUX", "SWR_MIC", "TX SMIC MUX5"},
 	{"TX SMIC MUX5", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX5", "ADC0", "TX SWR_ADC0"},
@@ -1720,16 +1756,6 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX5", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX5", "SWR_DMIC7", "TX SWR_DMIC7"},
 
-	{"TX DEC6 MUX", "MSM_DMIC", "TX DMIC MUX6"},
-	{"TX DMIC MUX6", "DMIC0", "TX DMIC0"},
-	{"TX DMIC MUX6", "DMIC1", "TX DMIC1"},
-	{"TX DMIC MUX6", "DMIC2", "TX DMIC2"},
-	{"TX DMIC MUX6", "DMIC3", "TX DMIC3"},
-	{"TX DMIC MUX6", "DMIC4", "TX DMIC4"},
-	{"TX DMIC MUX6", "DMIC5", "TX DMIC5"},
-	{"TX DMIC MUX6", "DMIC6", "TX DMIC6"},
-	{"TX DMIC MUX6", "DMIC7", "TX DMIC7"},
-
 	{"TX DEC6 MUX", "SWR_MIC", "TX SMIC MUX6"},
 	{"TX SMIC MUX6", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX6", "ADC0", "TX SWR_ADC0"},
@@ -1745,16 +1771,6 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX6", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX6", "SWR_DMIC7", "TX SWR_DMIC7"},
 
-	{"TX DEC7 MUX", "MSM_DMIC", "TX DMIC MUX7"},
-	{"TX DMIC MUX7", "DMIC0", "TX DMIC0"},
-	{"TX DMIC MUX7", "DMIC1", "TX DMIC1"},
-	{"TX DMIC MUX7", "DMIC2", "TX DMIC2"},
-	{"TX DMIC MUX7", "DMIC3", "TX DMIC3"},
-	{"TX DMIC MUX7", "DMIC4", "TX DMIC4"},
-	{"TX DMIC MUX7", "DMIC5", "TX DMIC5"},
-	{"TX DMIC MUX7", "DMIC6", "TX DMIC6"},
-	{"TX DMIC MUX7", "DMIC7", "TX DMIC7"},
-
 	{"TX DEC7 MUX", "SWR_MIC", "TX SMIC MUX7"},
 	{"TX SMIC MUX7", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX7", "ADC0", "TX SWR_ADC0"},
@@ -1825,10 +1841,41 @@ static const struct snd_kcontrol_new tx_macro_snd_controls[] = {
 		       tx_macro_get_bcs, tx_macro_set_bcs),
 };
 
+static int tx_macro_component_extend(struct snd_soc_component *comp)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(comp);
+	struct tx_macro *tx = snd_soc_component_get_drvdata(comp);
+	int ret;
+
+	if (tx->data->extra_widgets_num) {
+		ret = snd_soc_dapm_new_controls(dapm, tx->data->extra_widgets,
+						tx->data->extra_widgets_num);
+		if (ret) {
+			dev_err(tx->dev, "failed to add extra widgets: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (tx->data->extra_routes_num) {
+		ret = snd_soc_dapm_add_routes(dapm, tx->data->extra_routes,
+					      tx->data->extra_routes_num);
+		if (ret) {
+			dev_err(tx->dev, "failed to add extra routes: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int tx_macro_component_probe(struct snd_soc_component *comp)
 {
 	struct tx_macro *tx = snd_soc_component_get_drvdata(comp);
-	int i;
+	int i, ret;
+
+	ret = tx_macro_component_extend(comp);
+	if (ret)
+		return ret;
 
 	snd_soc_component_init_regmap(comp, tx->regmap);
 
@@ -1958,17 +2005,16 @@ static int tx_macro_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	kernel_ulong_t flags;
 	struct tx_macro *tx;
 	void __iomem *base;
 	int ret, reg;
 
-	flags = (kernel_ulong_t)device_get_match_data(dev);
-
 	tx = devm_kzalloc(dev, sizeof(*tx), GFP_KERNEL);
 	if (!tx)
 		return -ENOMEM;
 
+	tx->data = device_get_match_data(dev);
+
 	tx->macro = devm_clk_get_optional(dev, "macro");
 	if (IS_ERR(tx->macro))
 		return dev_err_probe(dev, PTR_ERR(tx->macro), "unable to get macro clock\n");
@@ -1981,7 +2027,7 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(tx->mclk))
 		return dev_err_probe(dev, PTR_ERR(tx->mclk), "unable to get mclk clock\n");
 
-	if (flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
+	if (tx->data->flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
 		tx->npl = devm_clk_get(dev, "npl");
 		if (IS_ERR(tx->npl))
 			return dev_err_probe(dev, PTR_ERR(tx->npl), "unable to get npl clock\n");
@@ -2056,7 +2102,7 @@ static int tx_macro_probe(struct platform_device *pdev)
 
 
 	/* reset soundwire block */
-	if (flags & LPASS_MACRO_FLAG_RESET_SWR)
+	if (tx->data->flags & LPASS_MACRO_FLAG_RESET_SWR)
 		regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
 				   CDC_TX_SWR_RESET_MASK, CDC_TX_SWR_RESET_ENABLE);
 
@@ -2064,7 +2110,7 @@ static int tx_macro_probe(struct platform_device *pdev)
 			   CDC_TX_SWR_CLK_EN_MASK,
 			   CDC_TX_SWR_CLK_ENABLE);
 
-	if (flags & LPASS_MACRO_FLAG_RESET_SWR)
+	if (tx->data->flags & LPASS_MACRO_FLAG_RESET_SWR)
 		regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
 				   CDC_TX_SWR_RESET_MASK, 0x0);
 
@@ -2168,25 +2214,54 @@ static const struct dev_pm_ops tx_macro_pm_ops = {
 	SET_RUNTIME_PM_OPS(tx_macro_runtime_suspend, tx_macro_runtime_resume, NULL)
 };
 
+static const struct tx_macro_data lpass_ver_9 = {
+	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK |
+				  LPASS_MACRO_FLAG_RESET_SWR,
+	.ver			= LPASS_VER_9_0_0,
+	.extra_widgets		= tx_macro_dapm_widgets_v9,
+	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9),
+	.extra_routes		= tx_audio_map_v9,
+	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
+};
+
+static const struct tx_macro_data lpass_ver_10_sm6115 = {
+	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	.ver			= LPASS_VER_10_0_0,
+	.extra_widgets		= tx_macro_dapm_widgets_v9,
+	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9),
+	.extra_routes		= tx_audio_map_v9,
+	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
+};
+
+
+static const struct tx_macro_data lpass_ver_11 = {
+	.flags			= LPASS_MACRO_FLAG_RESET_SWR,
+	.ver			= LPASS_VER_11_0_0,
+	.extra_widgets		= tx_macro_dapm_widgets_v9,
+	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9),
+	.extra_routes		= tx_audio_map_v9,
+	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
+};
+
 static const struct of_device_id tx_macro_dt_match[] = {
 	{
 		.compatible = "qcom,sc7280-lpass-tx-macro",
-		.data = (void *)(LPASS_MACRO_FLAG_HAS_NPL_CLOCK | LPASS_MACRO_FLAG_RESET_SWR),
+		.data = &lpass_ver_9,
 	}, {
 		.compatible = "qcom,sm6115-lpass-tx-macro",
-		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+		.data = &lpass_ver_10_sm6115,
 	}, {
 		.compatible = "qcom,sm8250-lpass-tx-macro",
-		.data = (void *)(LPASS_MACRO_FLAG_HAS_NPL_CLOCK | LPASS_MACRO_FLAG_RESET_SWR),
+		.data = &lpass_ver_9,
 	}, {
 		.compatible = "qcom,sm8450-lpass-tx-macro",
-		.data = (void *)(LPASS_MACRO_FLAG_HAS_NPL_CLOCK | LPASS_MACRO_FLAG_RESET_SWR),
+		.data = &lpass_ver_9,
 	}, {
 		.compatible = "qcom,sm8550-lpass-tx-macro",
-		.data = (void *)LPASS_MACRO_FLAG_RESET_SWR,
+		.data = &lpass_ver_11,
 	}, {
 		.compatible = "qcom,sc8280xp-lpass-tx-macro",
-		.data = (void *)(LPASS_MACRO_FLAG_HAS_NPL_CLOCK | LPASS_MACRO_FLAG_RESET_SWR),
+		.data = &lpass_ver_9,
 	},
 	{ }
 };
-- 
2.34.1


