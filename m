Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A47565B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGQOCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjGQOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:01:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF5F134
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:01:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so6088788a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689602507; x=1692194507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BV38Jm5wDHTOLhHebXluIyVKDGNivQTnk9W1AT5E0s=;
        b=Wdy9JRf2ejVEhR99BIpvBLajyt04EehThxWMAK1YppBlF7pasSIK3ndqWHgEQnjiZ9
         TgXk2av1H8fMI/UVIqVUiHANM1zsD2mVbr/r2EVdDMafGlsR8zKZDqN9yNyhFIx231iD
         y7oXxm2FDxETuDQ8yuG/LfM1ru2Va5IU7izzsICR26lt47a9hZa3TrOdGe2T3uURHCv9
         eZypzINRiY4SytERfz1GYipTX/XNDfXfkwEp296pChkxJFZqE/Q4NyU0uG1Go5OJLUeV
         coEy5ESJSGJFkOHYRMlukIK3LFEqNyQU+QDRWGz+/D6ZghI0jPDZUd752QvjadX0YHdK
         CEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602507; x=1692194507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BV38Jm5wDHTOLhHebXluIyVKDGNivQTnk9W1AT5E0s=;
        b=YWfiI7NyasrIDNNsZXtc8JQl5st9T9KPs0n09qbnAyPG3QY0cAEC7deHiRHmit9XOE
         QIj5zESK7G3sVgqtjCqt0SPztvESWkLNNW5f8bJCJ5gAcU9TXk+ZEXAHHhIfft+9GzeY
         NrcVwyx0LnpfXw/APSlzVSMQRK2Sx8jl5gF1m/hpuIkHEQYYcHFC2bs3wG1hPD+6wPoK
         eLbSjd80OV2FZRl2wCAy0YRDHhXYLwE4WSpRdv7VUTqn5hcoD2iS1HKEfKx7DpvYd9az
         bB7IaPRoZMsiYgU8iY1uzOpbO3qdCd5xkdDIA+RxZYr1ZcHv7oKvoPkTjAC4jjjaowfM
         wuXw==
X-Gm-Message-State: ABy/qLbFz54cALE40sgEqdZRGiJ9LeXAzP3249j6YXNkzg/ubbICsDEw
        cL5dDnD6o0EJd0ij75yf72rhJObuWOraiGVv8MI=
X-Google-Smtp-Source: APBJJlGq9APh8AzKMBodG7DS+6oTZ6OSZfHrIaFnoYI3YF40x0dFiQXPdIw5ayiRzz1z0U+RHWluOg==
X-Received: by 2002:a05:6402:516:b0:521:6305:82e7 with SMTP id m22-20020a056402051600b00521630582e7mr9484982edv.30.1689602507180;
        Mon, 17 Jul 2023 07:01:47 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7dd54000000b005219de74217sm403649edw.43.2023.07.17.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:01:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+
Date:   Mon, 17 Jul 2023 16:01:38 +0200
Message-Id: <20230717140138.201745-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717140138.201745-1-krzysztof.kozlowski@linaro.org>
References: <20230717140138.201745-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
   SWR_INPUTn ones, while keeping everything backwards compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-macro-common.h |   1 +
 sound/soc/codecs/lpass-tx-macro.c     | 491 ++++++++++++++++++++++++--
 2 files changed, 464 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index 6376a02b373a..850b8e1d794d 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -11,6 +11,7 @@
 
 enum lpass_version {
 	LPASS_VER_9_0_0,
+	LPASS_VER_9_2_0,
 	LPASS_VER_11_0_0,
 };
 
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 0da0bbf80eee..6da6a27c2394 100644
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
@@ -1785,6 +1829,388 @@ static const struct snd_soc_dapm_route tx_audio_map_v9[] = {
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
+
+	/* Backwards compatible inputs, deprecated, use TX SWR_INPUTn */
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
+	/* Backwards compatible for: TX SMIC MUX0 */
+	{"TX SMIC MUX0", "SWR_MIC0", "TX SWR_ADC0"},
+	{"TX SMIC MUX0", "SWR_MIC1", "TX SWR_ADC1"},
+	{"TX SMIC MUX0", "SWR_MIC2", "TX SWR_ADC2"},
+	{"TX SMIC MUX0", "SWR_MIC3", "TX SWR_ADC3"},
+	{"TX SMIC MUX0", "SWR_MIC4", "TX SWR_DMIC0"},
+	{"TX SMIC MUX0", "SWR_MIC5", "TX SWR_DMIC1"},
+	{"TX SMIC MUX0", "SWR_MIC6", "TX SWR_DMIC2"},
+	{"TX SMIC MUX0", "SWR_MIC7", "TX SWR_DMIC3"},
+	{"TX SMIC MUX0", "SWR_MIC8", "TX SWR_DMIC4"},
+	{"TX SMIC MUX0", "SWR_MIC9", "TX SWR_DMIC5"},
+	{"TX SMIC MUX0", "SWR_MIC10", "TX SWR_DMIC6"},
+	{"TX SMIC MUX0", "SWR_MIC11", "TX SWR_DMIC7"},
+
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
+	/* Backwards compatible for: TX SMIC MUX1 */
+	{"TX SMIC MUX1", "SWR_MIC0", "TX SWR_ADC0"},
+	{"TX SMIC MUX1", "SWR_MIC1", "TX SWR_ADC1"},
+	{"TX SMIC MUX1", "SWR_MIC2", "TX SWR_ADC2"},
+	{"TX SMIC MUX1", "SWR_MIC3", "TX SWR_ADC3"},
+	{"TX SMIC MUX1", "SWR_MIC4", "TX SWR_DMIC0"},
+	{"TX SMIC MUX1", "SWR_MIC5", "TX SWR_DMIC1"},
+	{"TX SMIC MUX1", "SWR_MIC6", "TX SWR_DMIC2"},
+	{"TX SMIC MUX1", "SWR_MIC7", "TX SWR_DMIC3"},
+	{"TX SMIC MUX1", "SWR_MIC8", "TX SWR_DMIC4"},
+	{"TX SMIC MUX1", "SWR_MIC9", "TX SWR_DMIC5"},
+	{"TX SMIC MUX1", "SWR_MIC10", "TX SWR_DMIC6"},
+	{"TX SMIC MUX1", "SWR_MIC11", "TX SWR_DMIC7"},
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
+	/* Backwards compatible for: TX SMIC MUX2 */
+	{"TX SMIC MUX2", "SWR_MIC0", "TX SWR_ADC0"},
+	{"TX SMIC MUX2", "SWR_MIC1", "TX SWR_ADC1"},
+	{"TX SMIC MUX2", "SWR_MIC2", "TX SWR_ADC2"},
+	{"TX SMIC MUX2", "SWR_MIC3", "TX SWR_ADC3"},
+	{"TX SMIC MUX2", "SWR_MIC4", "TX SWR_DMIC0"},
+	{"TX SMIC MUX2", "SWR_MIC5", "TX SWR_DMIC1"},
+	{"TX SMIC MUX2", "SWR_MIC6", "TX SWR_DMIC2"},
+	{"TX SMIC MUX2", "SWR_MIC7", "TX SWR_DMIC3"},
+	{"TX SMIC MUX2", "SWR_MIC8", "TX SWR_DMIC4"},
+	{"TX SMIC MUX2", "SWR_MIC9", "TX SWR_DMIC5"},
+	{"TX SMIC MUX2", "SWR_MIC10", "TX SWR_DMIC6"},
+	{"TX SMIC MUX2", "SWR_MIC11", "TX SWR_DMIC7"},
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
+	/* Backwards compatible for: TX SMIC MUX3 */
+	{"TX SMIC MUX3", "SWR_MIC0", "TX SWR_ADC0"},
+	{"TX SMIC MUX3", "SWR_MIC1", "TX SWR_ADC1"},
+	{"TX SMIC MUX3", "SWR_MIC2", "TX SWR_ADC2"},
+	{"TX SMIC MUX3", "SWR_MIC3", "TX SWR_ADC3"},
+	{"TX SMIC MUX3", "SWR_MIC4", "TX SWR_DMIC0"},
+	{"TX SMIC MUX3", "SWR_MIC5", "TX SWR_DMIC1"},
+	{"TX SMIC MUX3", "SWR_MIC6", "TX SWR_DMIC2"},
+	{"TX SMIC MUX3", "SWR_MIC7", "TX SWR_DMIC3"},
+	{"TX SMIC MUX3", "SWR_MIC8", "TX SWR_DMIC4"},
+	{"TX SMIC MUX3", "SWR_MIC9", "TX SWR_DMIC5"},
+	{"TX SMIC MUX3", "SWR_MIC10", "TX SWR_DMIC6"},
+	{"TX SMIC MUX3", "SWR_MIC11", "TX SWR_DMIC7"},
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
+	/* Backwards compatible for: TX SMIC MUX4 */
+	{"TX SMIC MUX4", "SWR_MIC0", "TX SWR_ADC0"},
+	{"TX SMIC MUX4", "SWR_MIC1", "TX SWR_ADC1"},
+	{"TX SMIC MUX4", "SWR_MIC2", "TX SWR_ADC2"},
+	{"TX SMIC MUX4", "SWR_MIC3", "TX SWR_ADC3"},
+	{"TX SMIC MUX4", "SWR_MIC4", "TX SWR_DMIC0"},
+	{"TX SMIC MUX4", "SWR_MIC5", "TX SWR_DMIC1"},
+	{"TX SMIC MUX4", "SWR_MIC6", "TX SWR_DMIC2"},
+	{"TX SMIC MUX4", "SWR_MIC7", "TX SWR_DMIC3"},
+	{"TX SMIC MUX4", "SWR_MIC8", "TX SWR_DMIC4"},
+	{"TX SMIC MUX4", "SWR_MIC9", "TX SWR_DMIC5"},
+	{"TX SMIC MUX4", "SWR_MIC10", "TX SWR_DMIC6"},
+	{"TX SMIC MUX4", "SWR_MIC11", "TX SWR_DMIC7"},
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
+	/* Backwards compatible for: TX SMIC MUX5 */
+	{"TX SMIC MUX5", "SWR_MIC0", "TX SWR_ADC0"},
+	{"TX SMIC MUX5", "SWR_MIC1", "TX SWR_ADC1"},
+	{"TX SMIC MUX5", "SWR_MIC2", "TX SWR_ADC2"},
+	{"TX SMIC MUX5", "SWR_MIC3", "TX SWR_ADC3"},
+	{"TX SMIC MUX5", "SWR_MIC4", "TX SWR_DMIC0"},
+	{"TX SMIC MUX5", "SWR_MIC5", "TX SWR_DMIC1"},
+	{"TX SMIC MUX5", "SWR_MIC6", "TX SWR_DMIC2"},
+	{"TX SMIC MUX5", "SWR_MIC7", "TX SWR_DMIC3"},
+	{"TX SMIC MUX5", "SWR_MIC8", "TX SWR_DMIC4"},
+	{"TX SMIC MUX5", "SWR_MIC9", "TX SWR_DMIC5"},
+	{"TX SMIC MUX5", "SWR_MIC10", "TX SWR_DMIC6"},
+	{"TX SMIC MUX5", "SWR_MIC11", "TX SWR_DMIC7"},
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
+	/* Backwards compatible for: TX SMIC MUX6 */
+	{"TX SMIC MUX6", "SWR_MIC0", "TX SWR_ADC0"},
+	{"TX SMIC MUX6", "SWR_MIC1", "TX SWR_ADC1"},
+	{"TX SMIC MUX6", "SWR_MIC2", "TX SWR_ADC2"},
+	{"TX SMIC MUX6", "SWR_MIC3", "TX SWR_ADC3"},
+	{"TX SMIC MUX6", "SWR_MIC4", "TX SWR_DMIC0"},
+	{"TX SMIC MUX6", "SWR_MIC5", "TX SWR_DMIC1"},
+	{"TX SMIC MUX6", "SWR_MIC6", "TX SWR_DMIC2"},
+	{"TX SMIC MUX6", "SWR_MIC7", "TX SWR_DMIC3"},
+	{"TX SMIC MUX6", "SWR_MIC8", "TX SWR_DMIC4"},
+	{"TX SMIC MUX6", "SWR_MIC9", "TX SWR_DMIC5"},
+	{"TX SMIC MUX6", "SWR_MIC10", "TX SWR_DMIC6"},
+	{"TX SMIC MUX6", "SWR_MIC11", "TX SWR_DMIC7"},
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
+	/* Backwards compatible for: TX SMIC MUX7 */
+	{"TX SMIC MUX7", "SWR_MIC0", "TX SWR_ADC0"},
+	{"TX SMIC MUX7", "SWR_MIC1", "TX SWR_ADC1"},
+	{"TX SMIC MUX7", "SWR_MIC2", "TX SWR_ADC2"},
+	{"TX SMIC MUX7", "SWR_MIC3", "TX SWR_ADC3"},
+	{"TX SMIC MUX7", "SWR_MIC4", "TX SWR_DMIC0"},
+	{"TX SMIC MUX7", "SWR_MIC5", "TX SWR_DMIC1"},
+	{"TX SMIC MUX7", "SWR_MIC6", "TX SWR_DMIC2"},
+	{"TX SMIC MUX7", "SWR_MIC7", "TX SWR_DMIC3"},
+	{"TX SMIC MUX7", "SWR_MIC8", "TX SWR_DMIC4"},
+	{"TX SMIC MUX7", "SWR_MIC9", "TX SWR_DMIC5"},
+	{"TX SMIC MUX7", "SWR_MIC10", "TX SWR_DMIC6"},
+	{"TX SMIC MUX7", "SWR_MIC11", "TX SWR_DMIC7"},
+};
+
 static const struct snd_kcontrol_new tx_macro_snd_controls[] = {
 	SOC_SINGLE_S8_TLV("TX_DEC0 Volume",
 			  CDC_TX0_TX_VOL_CTL,
@@ -2210,31 +2636,40 @@ static const struct tx_macro_data lpass_ver_9 = {
 	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9),
 };
 
+static const struct tx_macro_data lpass_ver_9_2 = {
+	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	.ver			= LPASS_VER_9_2_0,
+	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
+	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),
+	.extra_routes		= tx_audio_map_v9_2,
+	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
+};
+
 static const struct tx_macro_data lpass_ver_11 = {
 	.flags			= 0,
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
 		.compatible = "qcom,sm8250-lpass-tx-macro",
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

