Return-Path: <linux-kernel+bounces-38831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87CD83C6A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8334228E7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B80745D2;
	Thu, 25 Jan 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ym4D7pdE"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866E7319E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196687; cv=none; b=e4hkQs2sm4zlOzMKQSpdnwP737uC8waH55NdPIRPE8pa2t3cyuEp2efPCKqGV3VCH+YfalfD7hhd55JRRAmOwOsKLwC+2I19owVxABlFQbYcPw+JQXYCVA0Brl9ExdZVVs9IEjrO0ra9hv3R2tlkyspfXv1B9Ka+Cx/oBehAKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196687; c=relaxed/simple;
	bh=MTzuUjMu0tyGbeKOxfHoXlDa2p4GOf7g2aZCMC2uZto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwRild9pg6Adb4Dqpsssbf2QrWQA62BcyU0+mWPO3ezTpFxGH+EG9Jx8illOGywphcBTujwt0CoRdrqVeWHr5M6JWI1UE4yIZCwUwL9hS7zhFzUSNj6qbtyle39dzYzwc5eO6oOBsY0GIx/RWkFD1gUJB+5eIoOm4QrKKzC9T3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ym4D7pdE; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-598bcccca79so3825614eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706196681; x=1706801481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWJCVPWSQMn8ZP6K1tt8QTM9ICSXE83EwMQDJFzD9GU=;
        b=ym4D7pdEH2DpfpLng0V77UzxD13sOrh+v3U4hw53rfY/SbFjGLTlcBYmWdM6crXfki
         PRezHRbEdiQOJxr2Lopf+MfzTUdpGiZutruzUvM7Cc83va8dl1Z5mrj4GeIAYwAyqQgh
         eklEFW4TVSGJRV3ITp/Ayut6eQKBx+IE9oXOIx8JN5dTp7xilj4b4OVl7N5roRIgjwSt
         c7C9p59EE5nd1jF4XSLkha/KQRrAMSZE1Za33q/DxpSJg+dXEuTP5zC2X3CX7ahUs6MS
         F3d0HZSZdheW4vSwqXwkyX+R1i5vEYIV9RsTPmeEnkdDWQnhYM62RJdXlImDr7xQGacJ
         R8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706196681; x=1706801481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWJCVPWSQMn8ZP6K1tt8QTM9ICSXE83EwMQDJFzD9GU=;
        b=bDC3isO7YGozTFsPOvpAimy2B9p6lA3i/A/m2srs7i+s6PccSYQTO0l28ZwGBvJ+Z7
         yOyA4t5GDpjufFE9Q/r9ynzbzI5CJL/aX4tDLZiSLMYHX85TZzOHdcRn8gvEqLmXb0b5
         p5mc6Z4QYZ0el/MgEPIDLRoiLsdAhFZpm5BvaVyK+JEgzQW9YCUFa+Vr7VSM2oNKzg1p
         /JjeOx0V7f5/pI9i8kvz+bpMS36fQcT2PXq5vWGf4bK0ohyOPxxgSRuf2RDPHxmDky0v
         6gABIE+3hDqmGzUmQw++MDxFzU8vQbwIHAxiWct03Ous7Wan7jYYv8JdP0QFp4g7eLCx
         DD5A==
X-Gm-Message-State: AOJu0YwOecqAM5oCROlWMYXeCxsfzGcaJCOdaE27sk6e2grOecssSid5
	8o9Wnbt777ByZwCynn8FZ989ydnQHiyoLzgmXsnl3IPFEDtzoew4ZrBinMwA004=
X-Google-Smtp-Source: AGHT+IHjLHbwg3XO0+tvCZmUjHNvXIKjlHmT0SwxtS8IQ62RLxOkN4VOtcOUAzq7EKK565GxRRD7Ng==
X-Received: by 2002:a4a:e8c7:0:b0:599:e04f:7ff with SMTP id h7-20020a4ae8c7000000b00599e04f07ffmr988907ooe.0.1706196681371;
        Thu, 25 Jan 2024 07:31:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id d14-20020a4ad34e000000b00599f1741917sm63973oos.43.2024.01.25.07.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:31:21 -0800 (PST)
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
Subject: [PATCH v2 2/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+
Date: Thu, 25 Jan 2024 16:31:10 +0100
Message-Id: <20240125153110.410295-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125153110.410295-1-krzysztof.kozlowski@linaro.org>
References: <20240125153110.410295-1-krzysztof.kozlowski@linaro.org>
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
mixer settings - all of them should be updated to use correct, new
widgets.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Keep all the MSM_DMIC/TX DMIC MUX audio routes in the shared
   tx_audio_map, because it does not differ between v9 and v9.2.

2. Drop backwards compatible widgets because they create issues with
   routes in existing DTS.
---
 sound/soc/codecs/lpass-macro-common.h |   1 +
 sound/soc/codecs/lpass-tx-macro.c     | 313 +++++++++++++++++++++++---
 2 files changed, 281 insertions(+), 33 deletions(-)

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
index ecc8565ff4bb..98d85f5e831d 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -645,13 +645,18 @@ static int tx_macro_mclk_enable(struct tx_macro *tx,
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
@@ -680,7 +685,7 @@ static void tx_macro_tx_hpf_corner_freq_callback(struct work_struct *work)
 	dec_cfg_reg = CDC_TXn_TX_PATH_CFG0(hpf_work->decimator);
 	hpf_gate_reg = CDC_TXn_TX_PATH_SEC2(hpf_work->decimator);
 
-	if (is_amic_enabled(component, hpf_work->decimator)) {
+	if (is_amic_enabled(component, tx, hpf_work->decimator)) {
 		snd_soc_component_write_field(component,
 				dec_cfg_reg,
 				CDC_TXn_HPF_CUT_FREQ_MASK,
@@ -744,15 +749,60 @@ static int tx_macro_mclk_event(struct snd_soc_dapm_widget *w,
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
+					      tx->dmic_clk_div);
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
+					      tx->dmic_clk_div);
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
+	unsigned int val;
 	u16 mic_sel_reg;
-	u16 dmic_clk_reg;
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
 
 	val = ucontrol->value.enumerated.item[0];
@@ -790,21 +840,15 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
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
-						tx->dmic_clk_div);
-		}
+		else if (tx->data->ver <= LPASS_VER_9_0_0)
+			tx_macro_update_smic_sel_v9(component, widget, tx,
+						    mic_sel_reg, val);
+		else
+			tx_macro_update_smic_sel_v9_2(component, widget, tx,
+						      mic_sel_reg, val);
 	}
 
 	return snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
@@ -905,7 +949,7 @@ static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		snd_soc_component_write_field(component, tx_vol_ctl_reg,
 					     CDC_TXn_CLK_EN_MASK, 0x1);
-		if (!is_amic_enabled(component, decimator)) {
+		if (!is_amic_enabled(component, tx, decimator)) {
 			snd_soc_component_update_bits(component, hpf_gate_reg, 0x01, 0x00);
 			/* Minimum 1 clk cycle delay is required as per HW spec */
 			usleep_range(1000, 1010);
@@ -921,7 +965,7 @@ static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
 						      CDC_TXn_HPF_CUT_FREQ_MASK,
 						      CF_MIN_3DB_150HZ);
 
-		if (is_amic_enabled(component, decimator)) {
+		if (is_amic_enabled(component, tx, decimator)) {
 			hpf_delay = TX_MACRO_AMIC_HPF_DELAY_MS;
 			unmute_delay = TX_MACRO_AMIC_UNMUTE_DELAY_MS;
 		}
@@ -937,7 +981,7 @@ static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
 					      CDC_TXn_HPF_F_CHANGE_MASK |
 					      CDC_TXn_HPF_ZERO_GATE_MASK,
 					      0x02);
-			if (!is_amic_enabled(component, decimator))
+			if (!is_amic_enabled(component, tx, decimator))
 				snd_soc_component_update_bits(component, hpf_gate_reg,
 						      CDC_TXn_HPF_F_CHANGE_MASK |
 						      CDC_TXn_HPF_ZERO_GATE_MASK,
@@ -974,7 +1018,7 @@ static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
 						component, dec_cfg_reg,
 						CDC_TXn_HPF_CUT_FREQ_MASK,
 						hpf_cut_off_freq);
-				if (is_amic_enabled(component, decimator))
+				if (is_amic_enabled(component, tx, decimator))
 					snd_soc_component_update_bits(component,
 					      hpf_gate_reg,
 					      CDC_TXn_HPF_F_CHANGE_MASK |
@@ -1785,6 +1829,200 @@ static const struct snd_soc_dapm_route tx_audio_map_v9[] = {
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
@@ -2220,29 +2458,38 @@ static const struct tx_macro_data lpass_ver_9 = {
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
 		.compatible = "qcom,sc7280-lpass-tx-macro",
-		.data = &lpass_ver_9,
+		.data = &lpass_ver_9_2,
 	}, {
 		.compatible = "qcom,sm6115-lpass-tx-macro",
 		.data = &lpass_ver_10_sm6115,
@@ -2251,13 +2498,13 @@ static const struct of_device_id tx_macro_dt_match[] = {
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
-		.data = &lpass_ver_9,
+		.data = &lpass_ver_9_2,
 	},
 	{ }
 };
-- 
2.34.1


