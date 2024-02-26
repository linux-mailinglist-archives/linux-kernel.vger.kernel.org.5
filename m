Return-Path: <linux-kernel+bounces-81321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F986741A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541D01C2816E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F15B20A;
	Mon, 26 Feb 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+iWj3NB"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3ED5B202
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948776; cv=none; b=kHT79vxih4DeSoXU6DHJqS+cUZTObBpwX8wEtswOO5W1yY5AdgZt2kG94YdZFzZins9Lfpc2oQDAkW5glvjz3X8POGWvARxR2RTGff/phSA9qiIFXOMtMBusYte2cMSvHwe4wiFb37h/Inw2Yp20y8X6A/uiirltLfZJIcOr8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948776; c=relaxed/simple;
	bh=ROByfqFVbHKKSG6xR8eKKjUP/HkIdxJW1DhKcxv7ccc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfaR6emD81BfjS643Iiqhxl/UhHOBhVQOsX4uTneIuMNDiBRwGnRvJTe+sxvYdyQ1chNhpLaUQvw95FdvAnkuv1Eeqlpr6Z0aI2isY8flmrFPcMH3xPJa4PtHXCYSHARPdJs0mg80GydCOaVny6OVb99Z7yBaDjVfOb46CeinQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R+iWj3NB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2083896a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708948773; x=1709553573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6plcgyYrGD0vbYjawaJZNVFiusOH+x6UxvGdeR5gCE=;
        b=R+iWj3NBQUUawAENz3y2Fmn/BNnoenRx0tjLIY2wF6oSw+eM8kwki6k9ZpibdSbFef
         pQF6W+CE84PHc0wNYiew1EVcP5vbUg+SUp6IINSaGqSuEx2zF3iPrR0vQw9k/YZxZaIy
         yWnIA6flWeo9qIZzBHyfKK8GnbOo57nKu3X5aTBFqmdgsRPF0g56ysJ1TX+1Ew6UMwOU
         c+X0V2gOZqf8qSJL/Wz2EBSJfbaA1wcAfVlZJ+9mLs4AfzhQGsaiTMcXod9hU2dmXxVC
         4JMX1M19QgaMYvXeQXxIDv9rUFxsxgYCSpjm14TLfzUngdS5x14YRFHot0Zg2sNAuVHN
         ccbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948773; x=1709553573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6plcgyYrGD0vbYjawaJZNVFiusOH+x6UxvGdeR5gCE=;
        b=VHobrHC63kQShOnZ2nKUGm5FtuiuuBwN1L4xblMZNbT+/eobc3xHQBZSlhVcdN9sqt
         koPwXx1/6tDw4cTCtMZ7K1Z83OZXx8VA0KFLBLta7XfKlxE/B2J+6YLP72jTqyysl+Tg
         Aly5oCB86XWCs5hR/KTp03vY0Uyct/CmY/G9g7oLuJ4v5TKJPQQ1pH4SV6MDQxGNc7vY
         sbZO91UiC9gwB0ppjpMsibOPXxBQBKFCN8cmwKSW/m40yUAMUBbxdKbmOBzO0iV0WycW
         GQ2Xhyudr1rUXaSTYFDgf1d4iqjuxYQruSPbJYLvXtrbdDoSOORkjxZgPPlGhkmjAhZf
         /uXA==
X-Forwarded-Encrypted: i=1; AJvYcCU0qjp3TRzxiqygi7xMzxbgFuC90Dzv8CIjklPVZO/gN2DqCcPgQfOUr0lHzh5vvHAiwZN9LrSPP8MMhJCLtbJHaWRwgDdAQaMt/VsL
X-Gm-Message-State: AOJu0Yyo7Csvd5zBHF4FrAXVPW9Z4d3ooQmpbggpB20Xi+QtdFQyO3BO
	ZC25qxNvjKxIxSLbYy+2RO8qwwx2bsLuKCanD7Kc0X8B0YbO/gvT655vFNKoHgk=
X-Google-Smtp-Source: AGHT+IFILw7aVai7t/lZw5ibPieQEtjvx9+1/tUQU0xqHjGn8ZlvHlHkyjD4Gc3UtwBazf9QaBcfBg==
X-Received: by 2002:a17:906:f1c9:b0:a43:7653:6e5b with SMTP id gx9-20020a170906f1c900b00a4376536e5bmr969670ejb.26.1708948772736;
        Mon, 26 Feb 2024 03:59:32 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id tb16-20020a1709078b9000b00a42ea030a6esm2311877ejc.82.2024.02.26.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:59:32 -0800 (PST)
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
Subject: [PATCH v4 2/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+
Date: Mon, 26 Feb 2024 12:59:25 +0100
Message-Id: <20240226115925.53953-3-krzysztof.kozlowski@linaro.org>
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

Starting with Qualcomm SM8350 SoC, so Low Power Audio SubSystem (LPASS)
block version v9.2, the register responsible for TX SMIC MUXn muxes is
different.  In earlier LPASS versions this mux had bit fields for
analogue (ADCn) and digital (SWR_DMICn) MICs.  Choice of ADCn was
selecting the analogue path in CDC_TX_TOP_CSR_SWR_DMICn_CTL register.

With LPASS v9.2 and newer, the bit fields are integrated into just
SWR_MICn and there is no distinction for analogue or digital MIC in the
register.

Fix support for LPASS v9.2+:
1. Add new set of widgets and audio routes for LPASS v9.2.
2. Do not choose analogue or digital in CDC_TX_TOP_CSR_SWR_DMICn_CTL
   based on value of the mux.
3. Replace all the input widgets (TX SWR_ADCn, TX SWR_DMICn) with TX
   SWR_INPUTn ones.

The change is not backwards compatible with older DTBs and existing
mixer settings, therefore it does not change handling of older platforms
with working micrphones (SC8280xp) but only the ones with issues
(SM8450, SM8550) which need the fix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v4:
1. Do not change driver match data for SC7280, because of
   compatibility reasons. Same reasoning as in v3 for SC8280xp (see
   below).

Changes in v3:
1. Do not change driver match data for SC8280xp, because of
   compatibility reasons. Unlike on other newer platforms like SM8450
   and SM8550, microphones are working fine on SC8280xp so apparently
   the fix is not necessary on SC8280xp.

Changes in v2:
1. Keep all the MSM_DMIC/TX DMIC MUX audio routes in the shared
   tx_audio_map, because it does not differ between v9 and v9.2.

2. Drop backwards compatible widgets because they create issues with
   routes in existing DTS.
---
 sound/soc/codecs/lpass-macro-common.h |   1 +
 sound/soc/codecs/lpass-tx-macro.c     | 322 +++++++++++++++++++++++---
 2 files changed, 292 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index 18f5b8c8e822..d98718b3dc4b 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -13,6 +13,7 @@
 
 enum lpass_version {
 	LPASS_VER_9_0_0,
+	LPASS_VER_9_2_0,
 	LPASS_VER_10_0_0,
 	LPASS_VER_11_0_0,
 };
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index d6b3b6bb6923..c98b0b747a92 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -648,13 +648,18 @@ static int tx_macro_mclk_enable(struct tx_macro *tx,
 	return 0;
 }
 
-static bool is_amic_enabled(struct snd_soc_component *component, u8 decimator)
+static bool is_amic_enabled(struct snd_soc_component *component,
+			    struct tx_macro *tx, u8 decimator)
 {
 	u16 adc_mux_reg, adc_reg, adc_n;
 
 	adc_mux_reg = CDC_TX_INP_MUX_ADC_MUXn_CFG1(decimator);
 
 	if (snd_soc_component_read(component, adc_mux_reg) & SWR_MIC) {
+		if (tx->data->ver > LPASS_VER_9_0_0)
+			return true;
+
+		/* else: LPASS <= v9.0.0 */
 		adc_reg = CDC_TX_INP_MUX_ADC_MUXn_CFG0(decimator);
 		adc_n = snd_soc_component_read_field(component, adc_reg,
 					     CDC_TX_MACRO_SWR_MIC_MUX_SEL_MASK);
@@ -683,7 +688,7 @@ static void tx_macro_tx_hpf_corner_freq_callback(struct work_struct *work)
 	dec_cfg_reg = CDC_TXn_TX_PATH_CFG0(hpf_work->decimator);
 	hpf_gate_reg = CDC_TXn_TX_PATH_SEC2(hpf_work->decimator);
 
-	if (is_amic_enabled(component, hpf_work->decimator)) {
+	if (is_amic_enabled(component, tx, hpf_work->decimator)) {
 		snd_soc_component_write_field(component,
 				dec_cfg_reg,
 				CDC_TXn_HPF_CUT_FREQ_MASK,
@@ -747,15 +752,61 @@ static int tx_macro_mclk_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static void tx_macro_update_smic_sel_v9(struct snd_soc_component *component,
+					struct snd_soc_dapm_widget *widget,
+					struct tx_macro *tx, u16 mic_sel_reg,
+					unsigned int val)
+{
+	unsigned int dmic;
+	u16 dmic_clk_reg;
+
+	if (val < 5) {
+		snd_soc_component_write_field(component, mic_sel_reg,
+					      CDC_TXn_ADC_DMIC_SEL_MASK, 0);
+	} else {
+		snd_soc_component_write_field(component, mic_sel_reg,
+					      CDC_TXn_ADC_DMIC_SEL_MASK, 1);
+		dmic = TX_ADC_TO_DMIC(val);
+		dmic_clk_reg = CDC_TX_TOP_CSR_SWR_DMICn_CTL(dmic);
+		snd_soc_component_write_field(component, dmic_clk_reg,
+					      CDC_TX_SWR_DMIC_CLK_SEL_MASK,
+					      CDC_TX_SWR_MIC_CLK_DEFAULT);
+	}
+}
+
+static void tx_macro_update_smic_sel_v9_2(struct snd_soc_component *component,
+					  struct snd_soc_dapm_widget *widget,
+					  struct tx_macro *tx, u16 mic_sel_reg,
+					  unsigned int val)
+{
+	unsigned int dmic;
+	u16 dmic_clk_reg;
+
+	if (widget->shift) {
+		/* MSM DMIC */
+		snd_soc_component_write_field(component, mic_sel_reg,
+					      CDC_TXn_ADC_DMIC_SEL_MASK, 1);
+
+		dmic = TX_ADC_TO_DMIC(val);
+		dmic_clk_reg = CDC_TX_TOP_CSR_SWR_DMICn_CTL(dmic);
+		snd_soc_component_write_field(component, dmic_clk_reg,
+					      CDC_TX_SWR_DMIC_CLK_SEL_MASK,
+					      CDC_TX_SWR_MIC_CLK_DEFAULT);
+	} else {
+		snd_soc_component_write_field(component, mic_sel_reg,
+					      CDC_TXn_ADC_DMIC_SEL_MASK, 0);
+	}
+}
+
 static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *widget = snd_soc_dapm_kcontrol_widget(kcontrol);
 	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int val, dmic;
+	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
+	unsigned int val;
 	u16 mic_sel_reg;
-	u16 dmic_clk_reg;
 
 	val = ucontrol->value.enumerated.item[0];
 	if (val >= e->items)
@@ -792,21 +843,15 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
 	}
 
 	if (val != 0) {
-		if (widget->shift) { /* MSM DMIC */
+		if (widget->shift) /* MSM DMIC */
 			snd_soc_component_write_field(component, mic_sel_reg,
 						      CDC_TXn_ADC_DMIC_SEL_MASK, 1);
-		} else if (val < 5) {
-			snd_soc_component_write_field(component, mic_sel_reg,
-						      CDC_TXn_ADC_DMIC_SEL_MASK, 0);
-		} else {
-			snd_soc_component_write_field(component, mic_sel_reg,
-						      CDC_TXn_ADC_DMIC_SEL_MASK, 1);
-			dmic = TX_ADC_TO_DMIC(val);
-			dmic_clk_reg = CDC_TX_TOP_CSR_SWR_DMICn_CTL(dmic);
-			snd_soc_component_write_field(component, dmic_clk_reg,
-						CDC_TX_SWR_DMIC_CLK_SEL_MASK,
-						CDC_TX_SWR_MIC_CLK_DEFAULT);
-		}
+		else if (tx->data->ver <= LPASS_VER_9_0_0)
+			tx_macro_update_smic_sel_v9(component, widget, tx,
+						    mic_sel_reg, val);
+		else
+			tx_macro_update_smic_sel_v9_2(component, widget, tx,
+						      mic_sel_reg, val);
 	}
 
 	return snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
@@ -907,7 +952,7 @@ static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		snd_soc_component_write_field(component, tx_vol_ctl_reg,
 					     CDC_TXn_CLK_EN_MASK, 0x1);
-		if (!is_amic_enabled(component, decimator)) {
+		if (!is_amic_enabled(component, tx, decimator)) {
 			snd_soc_component_update_bits(component, hpf_gate_reg, 0x01, 0x00);
 			/* Minimum 1 clk cycle delay is required as per HW spec */
 			usleep_range(1000, 1010);
@@ -923,7 +968,7 @@ static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
 						      CDC_TXn_HPF_CUT_FREQ_MASK,
 						      CF_MIN_3DB_150HZ);
 
-		if (is_amic_enabled(component, decimator)) {
+		if (is_amic_enabled(component, tx, decimator)) {
 			hpf_delay = TX_MACRO_AMIC_HPF_DELAY_MS;
 			unmute_delay = TX_MACRO_AMIC_UNMUTE_DELAY_MS;
 		}
@@ -939,7 +984,7 @@ static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
 					      CDC_TXn_HPF_F_CHANGE_MASK |
 					      CDC_TXn_HPF_ZERO_GATE_MASK,
 					      0x02);
-			if (!is_amic_enabled(component, decimator))
+			if (!is_amic_enabled(component, tx, decimator))
 				snd_soc_component_update_bits(component, hpf_gate_reg,
 						      CDC_TXn_HPF_F_CHANGE_MASK |
 						      CDC_TXn_HPF_ZERO_GATE_MASK,
@@ -976,7 +1021,7 @@ static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
 						component, dec_cfg_reg,
 						CDC_TXn_HPF_CUT_FREQ_MASK,
 						hpf_cut_off_freq);
-				if (is_amic_enabled(component, decimator))
+				if (is_amic_enabled(component, tx, decimator))
 					snd_soc_component_update_bits(component,
 					      hpf_gate_reg,
 					      CDC_TXn_HPF_F_CHANGE_MASK |
@@ -1787,6 +1832,200 @@ static const struct snd_soc_dapm_route tx_audio_map_v9[] = {
 	{"TX SMIC MUX7", "SWR_DMIC7", "TX SWR_DMIC7"},
 };
 
+/* Controls and routes specific to LPASS >= v9.2.0 */
+static const char * const smic_mux_text_v9_2[] = {
+	"ZERO", "SWR_MIC0", "SWR_MIC1", "SWR_MIC2", "SWR_MIC3",
+	"SWR_MIC4", "SWR_MIC5", "SWR_MIC6", "SWR_MIC7",
+	"SWR_MIC8", "SWR_MIC9", "SWR_MIC10", "SWR_MIC11"
+};
+
+static SOC_ENUM_SINGLE_DECL(tx_smic0_enum_v9_2, CDC_TX_INP_MUX_ADC_MUX0_CFG0,
+			0, smic_mux_text_v9_2);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic1_enum_v9_2, CDC_TX_INP_MUX_ADC_MUX1_CFG0,
+			0, smic_mux_text_v9_2);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic2_enum_v9_2, CDC_TX_INP_MUX_ADC_MUX2_CFG0,
+			0, smic_mux_text_v9_2);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic3_enum_v9_2, CDC_TX_INP_MUX_ADC_MUX3_CFG0,
+			0, smic_mux_text_v9_2);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic4_enum_v9_2, CDC_TX_INP_MUX_ADC_MUX4_CFG0,
+			0, smic_mux_text_v9_2);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic5_enum_v9_2, CDC_TX_INP_MUX_ADC_MUX5_CFG0,
+			0, smic_mux_text_v9_2);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic6_enum_v9_2, CDC_TX_INP_MUX_ADC_MUX6_CFG0,
+			0, smic_mux_text_v9_2);
+
+static SOC_ENUM_SINGLE_DECL(tx_smic7_enum_v9_2, CDC_TX_INP_MUX_ADC_MUX7_CFG0,
+			0, smic_mux_text_v9_2);
+
+static const struct snd_kcontrol_new tx_smic0_mux_v9_2 = SOC_DAPM_ENUM_EXT("tx_smic0", tx_smic0_enum_v9_2,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic1_mux_v9_2 = SOC_DAPM_ENUM_EXT("tx_smic1", tx_smic1_enum_v9_2,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic2_mux_v9_2 = SOC_DAPM_ENUM_EXT("tx_smic2", tx_smic2_enum_v9_2,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic3_mux_v9_2 = SOC_DAPM_ENUM_EXT("tx_smic3", tx_smic3_enum_v9_2,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic4_mux_v9_2 = SOC_DAPM_ENUM_EXT("tx_smic4", tx_smic4_enum_v9_2,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic5_mux_v9_2 = SOC_DAPM_ENUM_EXT("tx_smic5", tx_smic5_enum_v9_2,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic6_mux_v9_2 = SOC_DAPM_ENUM_EXT("tx_smic6", tx_smic6_enum_v9_2,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_smic7_mux_v9_2 = SOC_DAPM_ENUM_EXT("tx_smic7", tx_smic7_enum_v9_2,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+
+static const struct snd_soc_dapm_widget tx_macro_dapm_widgets_v9_2[] = {
+	SND_SOC_DAPM_MUX("TX SMIC MUX0", SND_SOC_NOPM, 0, 0, &tx_smic0_mux_v9_2),
+	SND_SOC_DAPM_MUX("TX SMIC MUX1", SND_SOC_NOPM, 0, 0, &tx_smic1_mux_v9_2),
+	SND_SOC_DAPM_MUX("TX SMIC MUX2", SND_SOC_NOPM, 0, 0, &tx_smic2_mux_v9_2),
+	SND_SOC_DAPM_MUX("TX SMIC MUX3", SND_SOC_NOPM, 0, 0, &tx_smic3_mux_v9_2),
+	SND_SOC_DAPM_MUX("TX SMIC MUX4", SND_SOC_NOPM, 0, 0, &tx_smic4_mux_v9_2),
+	SND_SOC_DAPM_MUX("TX SMIC MUX5", SND_SOC_NOPM, 0, 0, &tx_smic5_mux_v9_2),
+	SND_SOC_DAPM_MUX("TX SMIC MUX6", SND_SOC_NOPM, 0, 0, &tx_smic6_mux_v9_2),
+	SND_SOC_DAPM_MUX("TX SMIC MUX7", SND_SOC_NOPM, 0, 0, &tx_smic7_mux_v9_2),
+
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT0"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT1"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT2"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT3"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT4"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT5"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT6"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT7"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT8"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT9"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT10"),
+	SND_SOC_DAPM_INPUT("TX SWR_INPUT11"),
+};
+
+static const struct snd_soc_dapm_route tx_audio_map_v9_2[] = {
+	{"TX DEC0 MUX", "SWR_MIC", "TX SMIC MUX0"},
+	{"TX SMIC MUX0", NULL, "TX_SWR_CLK"},
+	{"TX SMIC MUX0", "SWR_MIC0", "TX SWR_INPUT0"},
+	{"TX SMIC MUX0", "SWR_MIC1", "TX SWR_INPUT1"},
+	{"TX SMIC MUX0", "SWR_MIC2", "TX SWR_INPUT2"},
+	{"TX SMIC MUX0", "SWR_MIC3", "TX SWR_INPUT3"},
+	{"TX SMIC MUX0", "SWR_MIC4", "TX SWR_INPUT4"},
+	{"TX SMIC MUX0", "SWR_MIC5", "TX SWR_INPUT5"},
+	{"TX SMIC MUX0", "SWR_MIC6", "TX SWR_INPUT6"},
+	{"TX SMIC MUX0", "SWR_MIC7", "TX SWR_INPUT7"},
+	{"TX SMIC MUX0", "SWR_MIC8", "TX SWR_INPUT8"},
+	{"TX SMIC MUX0", "SWR_MIC9", "TX SWR_INPUT9"},
+	{"TX SMIC MUX0", "SWR_MIC10", "TX SWR_INPUT11"},
+	{"TX SMIC MUX0", "SWR_MIC11", "TX SWR_INPUT10"},
+
+	{"TX DEC1 MUX", "SWR_MIC", "TX SMIC MUX1"},
+	{"TX SMIC MUX1", NULL, "TX_SWR_CLK"},
+	{"TX SMIC MUX1", "SWR_MIC0", "TX SWR_INPUT0"},
+	{"TX SMIC MUX1", "SWR_MIC1", "TX SWR_INPUT1"},
+	{"TX SMIC MUX1", "SWR_MIC2", "TX SWR_INPUT2"},
+	{"TX SMIC MUX1", "SWR_MIC3", "TX SWR_INPUT3"},
+	{"TX SMIC MUX1", "SWR_MIC4", "TX SWR_INPUT4"},
+	{"TX SMIC MUX1", "SWR_MIC5", "TX SWR_INPUT5"},
+	{"TX SMIC MUX1", "SWR_MIC6", "TX SWR_INPUT6"},
+	{"TX SMIC MUX1", "SWR_MIC7", "TX SWR_INPUT7"},
+	{"TX SMIC MUX1", "SWR_MIC8", "TX SWR_INPUT8"},
+	{"TX SMIC MUX1", "SWR_MIC9", "TX SWR_INPUT9"},
+	{"TX SMIC MUX1", "SWR_MIC10", "TX SWR_INPUT10"},
+	{"TX SMIC MUX1", "SWR_MIC11", "TX SWR_INPUT11"},
+
+	{"TX DEC2 MUX", "SWR_MIC", "TX SMIC MUX2"},
+	{"TX SMIC MUX2", NULL, "TX_SWR_CLK"},
+	{"TX SMIC MUX2", "SWR_MIC0", "TX SWR_INPUT0"},
+	{"TX SMIC MUX2", "SWR_MIC1", "TX SWR_INPUT1"},
+	{"TX SMIC MUX2", "SWR_MIC2", "TX SWR_INPUT2"},
+	{"TX SMIC MUX2", "SWR_MIC3", "TX SWR_INPUT3"},
+	{"TX SMIC MUX2", "SWR_MIC4", "TX SWR_INPUT4"},
+	{"TX SMIC MUX2", "SWR_MIC5", "TX SWR_INPUT5"},
+	{"TX SMIC MUX2", "SWR_MIC6", "TX SWR_INPUT6"},
+	{"TX SMIC MUX2", "SWR_MIC7", "TX SWR_INPUT7"},
+	{"TX SMIC MUX2", "SWR_MIC8", "TX SWR_INPUT8"},
+	{"TX SMIC MUX2", "SWR_MIC9", "TX SWR_INPUT9"},
+	{"TX SMIC MUX2", "SWR_MIC10", "TX SWR_INPUT10"},
+	{"TX SMIC MUX2", "SWR_MIC11", "TX SWR_INPUT11"},
+
+	{"TX DEC3 MUX", "SWR_MIC", "TX SMIC MUX3"},
+	{"TX SMIC MUX3", NULL, "TX_SWR_CLK"},
+	{"TX SMIC MUX3", "SWR_MIC0", "TX SWR_INPUT0"},
+	{"TX SMIC MUX3", "SWR_MIC1", "TX SWR_INPUT1"},
+	{"TX SMIC MUX3", "SWR_MIC2", "TX SWR_INPUT2"},
+	{"TX SMIC MUX3", "SWR_MIC3", "TX SWR_INPUT3"},
+	{"TX SMIC MUX3", "SWR_MIC4", "TX SWR_INPUT4"},
+	{"TX SMIC MUX3", "SWR_MIC5", "TX SWR_INPUT5"},
+	{"TX SMIC MUX3", "SWR_MIC6", "TX SWR_INPUT6"},
+	{"TX SMIC MUX3", "SWR_MIC7", "TX SWR_INPUT7"},
+	{"TX SMIC MUX3", "SWR_MIC8", "TX SWR_INPUT8"},
+	{"TX SMIC MUX3", "SWR_MIC9", "TX SWR_INPUT9"},
+	{"TX SMIC MUX3", "SWR_MIC10", "TX SWR_INPUT10"},
+	{"TX SMIC MUX3", "SWR_MIC11", "TX SWR_INPUT11"},
+
+	{"TX DEC4 MUX", "SWR_MIC", "TX SMIC MUX4"},
+	{"TX SMIC MUX4", NULL, "TX_SWR_CLK"},
+	{"TX SMIC MUX4", "SWR_MIC0", "TX SWR_INPUT0"},
+	{"TX SMIC MUX4", "SWR_MIC1", "TX SWR_INPUT1"},
+	{"TX SMIC MUX4", "SWR_MIC2", "TX SWR_INPUT2"},
+	{"TX SMIC MUX4", "SWR_MIC3", "TX SWR_INPUT3"},
+	{"TX SMIC MUX4", "SWR_MIC4", "TX SWR_INPUT4"},
+	{"TX SMIC MUX4", "SWR_MIC5", "TX SWR_INPUT5"},
+	{"TX SMIC MUX4", "SWR_MIC6", "TX SWR_INPUT6"},
+	{"TX SMIC MUX4", "SWR_MIC7", "TX SWR_INPUT7"},
+	{"TX SMIC MUX4", "SWR_MIC8", "TX SWR_INPUT8"},
+	{"TX SMIC MUX4", "SWR_MIC9", "TX SWR_INPUT9"},
+	{"TX SMIC MUX4", "SWR_MIC10", "TX SWR_INPUT10"},
+	{"TX SMIC MUX4", "SWR_MIC11", "TX SWR_INPUT11"},
+
+	{"TX DEC5 MUX", "SWR_MIC", "TX SMIC MUX5"},
+	{"TX SMIC MUX5", NULL, "TX_SWR_CLK"},
+	{"TX SMIC MUX5", "SWR_MIC0", "TX SWR_INPUT0"},
+	{"TX SMIC MUX5", "SWR_MIC1", "TX SWR_INPUT1"},
+	{"TX SMIC MUX5", "SWR_MIC2", "TX SWR_INPUT2"},
+	{"TX SMIC MUX5", "SWR_MIC3", "TX SWR_INPUT3"},
+	{"TX SMIC MUX5", "SWR_MIC4", "TX SWR_INPUT4"},
+	{"TX SMIC MUX5", "SWR_MIC5", "TX SWR_INPUT5"},
+	{"TX SMIC MUX5", "SWR_MIC6", "TX SWR_INPUT6"},
+	{"TX SMIC MUX5", "SWR_MIC7", "TX SWR_INPUT7"},
+	{"TX SMIC MUX5", "SWR_MIC8", "TX SWR_INPUT8"},
+	{"TX SMIC MUX5", "SWR_MIC9", "TX SWR_INPUT9"},
+	{"TX SMIC MUX5", "SWR_MIC10", "TX SWR_INPUT10"},
+	{"TX SMIC MUX5", "SWR_MIC11", "TX SWR_INPUT11"},
+
+	{"TX DEC6 MUX", "SWR_MIC", "TX SMIC MUX6"},
+	{"TX SMIC MUX6", NULL, "TX_SWR_CLK"},
+	{"TX SMIC MUX6", "SWR_MIC0", "TX SWR_INPUT0"},
+	{"TX SMIC MUX6", "SWR_MIC1", "TX SWR_INPUT1"},
+	{"TX SMIC MUX6", "SWR_MIC2", "TX SWR_INPUT2"},
+	{"TX SMIC MUX6", "SWR_MIC3", "TX SWR_INPUT3"},
+	{"TX SMIC MUX6", "SWR_MIC4", "TX SWR_INPUT4"},
+	{"TX SMIC MUX6", "SWR_MIC5", "TX SWR_INPUT5"},
+	{"TX SMIC MUX6", "SWR_MIC6", "TX SWR_INPUT6"},
+	{"TX SMIC MUX6", "SWR_MIC7", "TX SWR_INPUT7"},
+	{"TX SMIC MUX6", "SWR_MIC8", "TX SWR_INPUT8"},
+	{"TX SMIC MUX6", "SWR_MIC9", "TX SWR_INPUT9"},
+	{"TX SMIC MUX6", "SWR_MIC10", "TX SWR_INPUT10"},
+	{"TX SMIC MUX6", "SWR_MIC11", "TX SWR_INPUT11"},
+
+	{"TX DEC7 MUX", "SWR_MIC", "TX SMIC MUX7"},
+	{"TX SMIC MUX7", NULL, "TX_SWR_CLK"},
+	{"TX SMIC MUX7", "SWR_MIC0", "TX SWR_INPUT0"},
+	{"TX SMIC MUX7", "SWR_MIC1", "TX SWR_INPUT1"},
+	{"TX SMIC MUX7", "SWR_MIC2", "TX SWR_INPUT2"},
+	{"TX SMIC MUX7", "SWR_MIC3", "TX SWR_INPUT3"},
+	{"TX SMIC MUX7", "SWR_MIC4", "TX SWR_INPUT4"},
+	{"TX SMIC MUX7", "SWR_MIC5", "TX SWR_INPUT5"},
+	{"TX SMIC MUX7", "SWR_MIC6", "TX SWR_INPUT6"},
+	{"TX SMIC MUX7", "SWR_MIC7", "TX SWR_INPUT7"},
+	{"TX SMIC MUX7", "SWR_MIC8", "TX SWR_INPUT8"},
+	{"TX SMIC MUX7", "SWR_MIC9", "TX SWR_INPUT9"},
+	{"TX SMIC MUX7", "SWR_MIC10", "TX SWR_INPUT10"},
+	{"TX SMIC MUX7", "SWR_MIC11", "TX SWR_INPUT11"},
+};
+
 static const struct snd_kcontrol_new tx_macro_snd_controls[] = {
 	SOC_SINGLE_S8_TLV("TX_DEC0 Volume",
 			  CDC_TX0_TX_VOL_CTL,
@@ -2224,27 +2463,42 @@ static const struct tx_macro_data lpass_ver_9 = {
 	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
 };
 
+static const struct tx_macro_data lpass_ver_9_2 = {
+	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK |
+				  LPASS_MACRO_FLAG_RESET_SWR,
+	.ver			= LPASS_VER_9_2_0,
+	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
+	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),
+	.extra_routes		= tx_audio_map_v9_2,
+	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
+};
+
 static const struct tx_macro_data lpass_ver_10_sm6115 = {
 	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
 	.ver			= LPASS_VER_10_0_0,
-	.extra_widgets		= tx_macro_dapm_widgets_v9,
-	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9),
-	.extra_routes		= tx_audio_map_v9,
-	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
+	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
+	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),
+	.extra_routes		= tx_audio_map_v9_2,
+	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
 };
 
-
 static const struct tx_macro_data lpass_ver_11 = {
 	.flags			= LPASS_MACRO_FLAG_RESET_SWR,
 	.ver			= LPASS_VER_11_0_0,
-	.extra_widgets		= tx_macro_dapm_widgets_v9,
-	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9),
-	.extra_routes		= tx_audio_map_v9,
-	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
+	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
+	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),
+	.extra_routes		= tx_audio_map_v9_2,
+	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
 };
 
 static const struct of_device_id tx_macro_dt_match[] = {
 	{
+		/*
+		 * The block is actually LPASS v9.4, but keep LPASS v9 match
+		 * data and audio widgets, due to compatibility reasons.
+		 * Microphones are working on SC7280 fine, so apparently the fix
+		 * is not necessary.
+		 */
 		.compatible = "qcom,sc7280-lpass-tx-macro",
 		.data = &lpass_ver_9,
 	}, {
@@ -2255,12 +2509,18 @@ static const struct of_device_id tx_macro_dt_match[] = {
 		.data = &lpass_ver_9,
 	}, {
 		.compatible = "qcom,sm8450-lpass-tx-macro",
-		.data = &lpass_ver_9,
+		.data = &lpass_ver_9_2,
 	}, {
 		.compatible = "qcom,sm8550-lpass-tx-macro",
 		.data = &lpass_ver_11,
 	}, {
 		.compatible = "qcom,sc8280xp-lpass-tx-macro",
+		/*
+		 * The block is actually LPASS v9.3, but keep LPASS v9 match
+		 * data and audio widgets, due to compatibility reasons.
+		 * Microphones are working on SC8280xp fine, so apparently the
+		 * fix is not necessary.
+		 */
 		.data = &lpass_ver_9,
 	},
 	{ }
-- 
2.34.1


