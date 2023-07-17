Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496B57565B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjGQOCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGQOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:01:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1674129
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:01:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so7244548e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689602505; x=1692194505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnZxcFed6PHGd/+RG+nISlFjQMv4sQjJFBst3sXqdOQ=;
        b=W8VBWja625/j1XBb73hXgE2O9Kruu3ooyAz0Di8to+A3mbbUZxgHrYOGlUYdP/xVx9
         QrCdLHk8OvSLrLw8mVD7gW7lCyRLPh2WSTQ/BbxUYer/Dpw7TBcTcvT3nt3qCCRUhRbT
         HD27mQcc84Na34XGK83LwhG3dfGCAygB4mQMfF41mpicrcqwTcEPywW3ZqqoLd6CzCWY
         2uBggMBUTGW+MDuS/qBNXAQ3qxeTmeAkDTFjz4kDFYdC7/UTi+KAT0B/9yhrQCQO/fe5
         sgUk9Vw3pc7I7Iw0W38YeroUPDNiYiPD7J9yIKy8Qzk+ZokRPKsJtEC1nPYnUdsnyTZR
         xP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602505; x=1692194505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnZxcFed6PHGd/+RG+nISlFjQMv4sQjJFBst3sXqdOQ=;
        b=D/ker8GkixHmW7d5ak4Z3waLSpYqFgMZNg9WtzyxiwgBwyKP4vfjdZ7+p2kX/JkQQa
         /D6dI8sUMjmUitcuviaYg04JlOkfSfHPqZlG7QqTmHwqtSCAocD2FLDanI1qkqQ4Tt0P
         EOEqrcTNpGd6jI251E489pQIl/7ZaV/f2jSms3q8wP0zWd4800Zjz5LXz8uUABkh2OmG
         m4YL/+nko+4zCtipEST9vrNXsZDdGstaf+VPKpz9M2bCaBe2gbFVi5PQv0sVRQfVH0AP
         APU6aTH/K/NHaOw+UtNMOERHtVg3EXDCIvHbfYTWVw1gOEpDxeGLgEPgCOypXmn6JOtW
         uj4g==
X-Gm-Message-State: ABy/qLYQxsghZLRQputK+t+xoN+mNDSvhUek3NPwHuPlV5zsG1lUugFV
        hPC525wFF1CQdItTjlJq2bBVnA==
X-Google-Smtp-Source: APBJJlHGSKmAgyCmuSCQ3tjVIw5T9+KqrL5jkVoc3br+vvdZ8eFxFdM3QmvXmAUOxqFk+bYCy7DhsQ==
X-Received: by 2002:ac2:44cf:0:b0:4f8:5604:4b50 with SMTP id d15-20020ac244cf000000b004f856044b50mr7974245lfm.64.1689602504414;
        Mon, 17 Jul 2023 07:01:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7dd54000000b005219de74217sm403649edw.43.2023.07.17.07.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:01:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: codecs: tx-macro: split widgets per different LPASS versions
Date:   Mon, 17 Jul 2023 16:01:37 +0200
Message-Id: <20230717140138.201745-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 sound/soc/codecs/lpass-macro-common.h |   5 +
 sound/soc/codecs/lpass-tx-macro.c     | 219 +++++++++++++++++---------
 2 files changed, 147 insertions(+), 77 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index 4eb886565ea3..6376a02b373a 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -9,6 +9,11 @@
 /* NPL clock is expected */
 #define LPASS_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)
 
+enum lpass_version {
+	LPASS_VER_9_0_0,
+	LPASS_VER_11_0_0,
+};
+
 struct lpass_macro {
 	struct device *macro_pd;
 	struct device *dcodec_pd;
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index de978c3d70b7..0da0bbf80eee 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -253,8 +253,18 @@ struct hpf_work {
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
@@ -1235,53 +1245,6 @@ static const struct snd_kcontrol_new tx_dec5_mux = SOC_DAPM_ENUM("tx_dec5", tx_d
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
@@ -1427,15 +1390,6 @@ static const struct snd_soc_dapm_widget tx_macro_dapm_widgets[] = {
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
@@ -1445,18 +1399,6 @@ static const struct snd_soc_dapm_widget tx_macro_dapm_widgets[] = {
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
@@ -1577,7 +1519,81 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX DMIC MUX0", "DMIC5", "TX DMIC5"},
 	{"TX DMIC MUX0", "DMIC6", "TX DMIC6"},
 	{"TX DMIC MUX0", "DMIC7", "TX DMIC7"},
+};
 
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
@@ -1823,10 +1839,41 @@ static const struct snd_kcontrol_new tx_macro_snd_controls[] = {
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
 
@@ -1954,17 +2001,16 @@ static int tx_macro_probe(struct platform_device *pdev)
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
 		return PTR_ERR(tx->macro);
@@ -1977,7 +2023,7 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(tx->mclk))
 		return PTR_ERR(tx->mclk);
 
-	if (flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
+	if (tx->data->flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
 		tx->npl = devm_clk_get(dev, "npl");
 		if (IS_ERR(tx->npl))
 			return PTR_ERR(tx->npl);
@@ -2155,21 +2201,40 @@ static const struct dev_pm_ops tx_macro_pm_ops = {
 	SET_RUNTIME_PM_OPS(tx_macro_runtime_suspend, tx_macro_runtime_resume, NULL)
 };
 
+static const struct tx_macro_data lpass_ver_9 = {
+	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	.ver			= LPASS_VER_9_0_0,
+	.extra_widgets		= tx_macro_dapm_widgets_v9,
+	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9),
+	.extra_routes		= tx_audio_map_v9,
+	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
+};
+
+static const struct tx_macro_data lpass_ver_11 = {
+	.flags			= 0,
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
-		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+		.data = &lpass_ver_9,
 	}, {
 		.compatible = "qcom,sm8250-lpass-tx-macro",
-		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+		.data = &lpass_ver_9,
 	}, {
 		.compatible = "qcom,sm8450-lpass-tx-macro",
-		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+		.data = &lpass_ver_9,
 	}, {
 		.compatible = "qcom,sm8550-lpass-tx-macro",
+		.data = &lpass_ver_11,
 	}, {
 		.compatible = "qcom,sc8280xp-lpass-tx-macro",
-		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+		.data = &lpass_ver_9,
 	},
 	{ }
 };
-- 
2.34.1

