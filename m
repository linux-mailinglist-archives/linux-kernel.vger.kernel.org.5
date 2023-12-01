Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBCA800E10
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379335AbjLAPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379323AbjLAPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:08:59 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A235010FD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:09:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so19350335e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443343; x=1702048143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRVBeXF+QSqrae9EL7nBYIMaZo7QiMUVKXfXpluBSag=;
        b=QpKfrtURd+4so+Z+CFQR5g40usyukhj3RMNxQR+jpn+Lpd+2hUr0AekaN1cf27G/Ju
         Z6DkbC5kTR/t/1WmetvQZuRaXGlUXqwaUS8Xs4jhZkkjLGSc+ss0BfypK9wVaRea1/ki
         gm+v8mzkx0CG8dkyMOsNOVaywQ25678Lt41BSSwqGZdKYTioCcEpbowtNOVovlcavo/N
         tU61NYeScT6umf7sl9RC2lqxnH3qn911KxjXEE2DyBa6olcKx0hpyhG056KXuCgdFfCm
         3olGu2J758OU/m2xMCzjls2aYSx9Hf93YJW2yi4zduW+nPVYUFTWImHyWAGiTCgUU/VU
         uXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443343; x=1702048143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRVBeXF+QSqrae9EL7nBYIMaZo7QiMUVKXfXpluBSag=;
        b=AzWQyPT1jtD/7sE1CRO16YNBJVV4pDVQOIi2+2qvmol1s1shrMsd1dyTNaNl4HSJbY
         mV2KlrHkqlPehA2+fXV+zERO0z9bcD1IvV4teYe+GcLGvCFY2hA5PkDwU+uNR/fAugZj
         TZydXjCHiYihcdKVHlaSK5urW8ab6RQtQDEMcLmsCCuY+RHgb139leDnfnK0JssFquyJ
         EVJQD1YyHi8mWs/POTbUKmFuqdfzAKXk7AddPpBtfZMKkzJou0nl583I5t8hUAjSmLcu
         9IQp/FCyeI1qTA5Urq3IvRvQJIRtvrj9ljSNHAHOOwrn0oIhf0v/93B5C+dCPGHtSdSq
         dr9Q==
X-Gm-Message-State: AOJu0YzwxbTlZBDcOQZNioj6AVU/Jkx2DZH6b5Gz9c4zwmNl35qNkMK+
        XC3U8WJSX0N2cG8DKyJYTXelRA==
X-Google-Smtp-Source: AGHT+IE/JjU2UGoFhMVAjp1SieutPPPZIidDnhANaf601mlVd1570tnh1BZkNCcoIKVa4BYkwij1Xw==
X-Received: by 2002:a05:600c:1c9f:b0:405:4daa:6e3d with SMTP id k31-20020a05600c1c9f00b004054daa6e3dmr364829wms.39.1701443343112;
        Fri, 01 Dec 2023 07:09:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b0040b5517ae31sm8569539wmb.6.2023.12.01.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:09:02 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 01 Dec 2023 16:08:56 +0100
Subject: [PATCH v2 3/5] ASoC: codec: wcd-mbhc-v2: add support when
 connected behind an USB-C audio mux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-3-94ed814b25aa@linaro.org>
References: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-0-94ed814b25aa@linaro.org>
In-Reply-To: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-0-94ed814b25aa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8596;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6/YR1yQHLHY5ZVJGZrtvXeeiCTAJu1S+VdYzYnIkom0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlafcJoqaUk8YHs9/hYDVqvKhkOvnkA080XPapVVUg
 pjqhPX2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWn3CQAKCRB33NvayMhJ0WIeD/
 9/RZtaY9HOQguM+P1b+lONkICz6tkxry0B6SPdZmTvZ8tRCqMiJFGC2bLdXEbPmGjWULqIdMGBh8Vg
 xb8e7ZyxHcVnpmb9Aq/O00UxWtc5KVrHh2WWmFam16gyD44a/gNR2hGfOxMUbIRdUCxqC2+gxTL7Lj
 8ao7Y6qDPn9ndjTMf3tl9YuP9BP1/5ZBP58GS65f3vk7wcy3pMcIA3Nk7AuEFAxZioBLRKb1Uj0GRM
 VtidvHtip6e0SDkmtHU0bbqlJGHbi3AcxcClVDzqjDwpHELQKw2of7jNsUdSHy8p4NujGw7aIoNULI
 /InsckFYujPv/9Mc260RMuhrSbX1rVS53yQ21l1aLm0s0mAMFvSzIz63BP47uNlPacT6qcLppgufde
 2TpEwAhmt0I+zi94UXz/MLsvxNWnNC5hFFTUlX5P+sXPBeKHWWcbWnKxmpPyW0wqTeB4uj7ny46NUP
 XKzjEbehyy5UKm3huxha6kT3OhSQ2R/VP8TfhdGEgfAOKRPCC5qOHGxJiIJ9x5oXKB291tFlG8pAWQ
 5M6oW5OU4Rm6fInapo3VY1ioQlC2tktpvWnFdUMvglN2dI+/NadWDZj6mHxJOqDlg19anPLRBwYgi1
 T/R69SW4R+GLh9XkW7c4l/BxyQkaNk9x91zBA1ZCrH7c2yO3i3kbBQtATbiA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the WCD codec is connected behind an USB-C audio mux,
plug/unplug events, clock control, pull-up and threshold are
different.
Add a typec_analog_mux config enabling those changes and add
two callbacks to trigger plug/unplug events from USB-C events.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 95 +++++++++++++++++++++++++++++++++++-------
 sound/soc/codecs/wcd-mbhc-v2.h |  3 ++
 2 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 5da1934527f3..0e6218ed0e5e 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -16,6 +16,7 @@
 #define HS_DETECT_PLUG_TIME_MS		(3 * 1000)
 #define MBHC_BUTTON_PRESS_THRESHOLD_MIN	250
 #define GND_MIC_SWAP_THRESHOLD		4
+#define GND_MIC_USBC_SWAP_THRESHOLD	2
 #define WCD_FAKE_REMOVAL_MIN_PERIOD_MS	100
 #define HPHL_CROSS_CONN_THRESHOLD	100
 #define HS_VREF_MIN_VAL			1400
@@ -52,12 +53,15 @@ struct wcd_mbhc {
 	struct wcd_mbhc_field *fields;
 	/* Delayed work to report long button press */
 	struct delayed_work mbhc_btn_dwork;
+	/* Work to handle plug report */
+	struct work_struct mbhc_plug_detect_work;
 	/* Work to correct accessory type */
 	struct work_struct correct_plug_swch;
 	struct mutex lock;
 	int buttons_pressed;
 	u32 hph_status; /* track headhpone status */
 	u8 current_plug;
+	unsigned int swap_thr;
 	bool is_btn_press;
 	bool in_swch_irq_handler;
 	bool hs_detect_work_stop;
@@ -506,14 +510,13 @@ static void wcd_mbhc_adc_detect_plug_type(struct wcd_mbhc *mbhc)
 	}
 }
 
-static irqreturn_t wcd_mbhc_mech_plug_detect_irq(int irq, void *data)
+static void mbhc_plug_detect_fn(struct work_struct *work)
 {
-	struct snd_soc_component *component;
+	struct wcd_mbhc *mbhc = container_of(work, struct wcd_mbhc, mbhc_plug_detect_work);
+	struct snd_soc_component *component = mbhc->component;
 	enum snd_jack_types jack_type;
-	struct wcd_mbhc *mbhc = data;
 	bool detection_type;
 
-	component = mbhc->component;
 	mutex_lock(&mbhc->lock);
 
 	mbhc->in_swch_irq_handler = true;
@@ -576,9 +579,51 @@ static irqreturn_t wcd_mbhc_mech_plug_detect_irq(int irq, void *data)
 exit:
 	mbhc->in_swch_irq_handler = false;
 	mutex_unlock(&mbhc->lock);
+}
+
+static irqreturn_t wcd_mbhc_mech_plug_detect_irq(int irq, void *data)
+{
+	struct wcd_mbhc *mbhc = data;
+
+	if (!mbhc->cfg->typec_analog_mux)
+		schedule_work(&mbhc->mbhc_plug_detect_work);
+
 	return IRQ_HANDLED;
 }
 
+int wcd_mbhc_typec_report_unplug(struct wcd_mbhc *mbhc)
+{
+
+	if (!mbhc || !mbhc->cfg->typec_analog_mux)
+		return -EINVAL;
+
+	if (mbhc->mbhc_cb->clk_setup)
+		mbhc->mbhc_cb->clk_setup(mbhc->component, false);
+
+	wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 0);
+	wcd_mbhc_write_field(mbhc, WCD_MBHC_MECH_DETECTION_TYPE, 0);
+
+	schedule_work(&mbhc->mbhc_plug_detect_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd_mbhc_typec_report_unplug);
+
+int wcd_mbhc_typec_report_plug(struct wcd_mbhc *mbhc)
+{
+	if (!mbhc || !mbhc->cfg->typec_analog_mux)
+		return -EINVAL;
+
+	if (mbhc->mbhc_cb->clk_setup)
+		mbhc->mbhc_cb->clk_setup(mbhc->component, true);
+	wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 1);
+
+	schedule_work(&mbhc->mbhc_plug_detect_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd_mbhc_typec_report_plug);
+
 static int wcd_mbhc_get_button_mask(struct wcd_mbhc *mbhc)
 {
 	int mask = 0;
@@ -725,14 +770,23 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 
 	mutex_lock(&mbhc->lock);
 
-	/* enable HS detection */
+	if (mbhc->cfg->typec_analog_mux)
+		mbhc->swap_thr = GND_MIC_USBC_SWAP_THRESHOLD;
+	else
+		mbhc->swap_thr = GND_MIC_SWAP_THRESHOLD;
+
+	/* setup HS detection */
 	if (mbhc->mbhc_cb->hph_pull_up_control_v2)
 		mbhc->mbhc_cb->hph_pull_up_control_v2(component,
-						      HS_PULLUP_I_DEFAULT);
+				mbhc->cfg->typec_analog_mux ?
+					HS_PULLUP_I_OFF : HS_PULLUP_I_DEFAULT);
 	else if (mbhc->mbhc_cb->hph_pull_up_control)
-		mbhc->mbhc_cb->hph_pull_up_control(component, I_DEFAULT);
+		mbhc->mbhc_cb->hph_pull_up_control(component,
+				mbhc->cfg->typec_analog_mux ?
+					I_OFF : I_DEFAULT);
 	else
-		wcd_mbhc_write_field(mbhc, WCD_MBHC_HS_L_DET_PULL_UP_CTRL, 3);
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_HS_L_DET_PULL_UP_CTRL,
+				mbhc->cfg->typec_analog_mux ? 0 : 3);
 
 	wcd_mbhc_write_field(mbhc, WCD_MBHC_HPHL_PLUG_TYPE, mbhc->cfg->hphl_swh);
 	wcd_mbhc_write_field(mbhc, WCD_MBHC_GND_PLUG_TYPE, mbhc->cfg->gnd_swh);
@@ -741,10 +795,18 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 		mbhc->mbhc_cb->mbhc_gnd_det_ctrl(component, true);
 	wcd_mbhc_write_field(mbhc, WCD_MBHC_HS_L_DET_PULL_UP_COMP_CTRL, 1);
 
-	wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 1);
+	/* Plug detect is triggered manually if analog goes through USBCC */
+	if (mbhc->cfg->typec_analog_mux)
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 0);
+	else
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_L_DET_EN, 1);
 
-	/* Insertion debounce set to 96ms */
-	wcd_mbhc_write_field(mbhc, WCD_MBHC_INSREM_DBNC, 6);
+	if (mbhc->cfg->typec_analog_mux)
+		/* Insertion debounce set to 48ms */
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_INSREM_DBNC, 4);
+	else
+		/* Insertion debounce set to 96ms */
+		wcd_mbhc_write_field(mbhc, WCD_MBHC_INSREM_DBNC, 6);
 
 	/* Button Debounce set to 16ms */
 	wcd_mbhc_write_field(mbhc, WCD_MBHC_BTN_DBNC, 2);
@@ -753,7 +815,8 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 	mbhc->mbhc_cb->mbhc_bias(component, true);
 	/* enable MBHC clock */
 	if (mbhc->mbhc_cb->clk_setup)
-		mbhc->mbhc_cb->clk_setup(component, true);
+		mbhc->mbhc_cb->clk_setup(component,
+				mbhc->cfg->typec_analog_mux ? false : true);
 
 	/* program HS_VREF value */
 	wcd_program_hs_vref(mbhc);
@@ -1115,7 +1178,7 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 	do {
 		cross_conn = wcd_check_cross_conn(mbhc);
 		try++;
-	} while (try < GND_MIC_SWAP_THRESHOLD);
+	} while (try < mbhc->swap_thr);
 
 	if (cross_conn > 0) {
 		plug_type = MBHC_PLUG_TYPE_GND_MIC_SWAP;
@@ -1183,7 +1246,7 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 			cross_conn = wcd_check_cross_conn(mbhc);
 			if (cross_conn > 0) { /* cross-connection */
 				pt_gnd_mic_swap_cnt++;
-				if (pt_gnd_mic_swap_cnt < GND_MIC_SWAP_THRESHOLD)
+				if (pt_gnd_mic_swap_cnt < mbhc->swap_thr)
 					continue;
 				else
 					plug_type = MBHC_PLUG_TYPE_GND_MIC_SWAP;
@@ -1194,7 +1257,7 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 			} else /* Error if (cross_conn < 0) */
 				continue;
 
-			if (pt_gnd_mic_swap_cnt == GND_MIC_SWAP_THRESHOLD) {
+			if (pt_gnd_mic_swap_cnt == mbhc->swap_thr) {
 				/* US_EU gpio present, flip switch */
 				if (mbhc->cfg->swap_gnd_mic) {
 					if (mbhc->cfg->swap_gnd_mic(component, true))
@@ -1473,6 +1536,7 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 	mutex_init(&mbhc->lock);
 
 	INIT_WORK(&mbhc->correct_plug_swch, wcd_correct_swch_plug);
+	INIT_WORK(&mbhc->mbhc_plug_detect_work, mbhc_plug_detect_fn);
 
 	ret = request_threaded_irq(mbhc->intr_ids->mbhc_sw_intr, NULL,
 					wcd_mbhc_mech_plug_detect_irq,
@@ -1562,6 +1626,7 @@ void wcd_mbhc_deinit(struct wcd_mbhc *mbhc)
 
 	mutex_lock(&mbhc->lock);
 	wcd_cancel_hs_detect_plug(mbhc,	&mbhc->correct_plug_swch);
+	cancel_work_sync(&mbhc->mbhc_plug_detect_work);
 	mutex_unlock(&mbhc->lock);
 
 	kfree(mbhc);
diff --git a/sound/soc/codecs/wcd-mbhc-v2.h b/sound/soc/codecs/wcd-mbhc-v2.h
index 006118f3e81f..df68e99c81a3 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.h
+++ b/sound/soc/codecs/wcd-mbhc-v2.h
@@ -193,6 +193,7 @@ struct wcd_mbhc_config {
 	int v_hs_max;
 	int num_btn;
 	bool mono_stero_detection;
+	bool typec_analog_mux;
 	bool (*swap_gnd_mic)(struct snd_soc_component *component, bool active);
 	bool hs_ext_micbias;
 	bool gnd_det_en;
@@ -273,6 +274,8 @@ int wcd_mbhc_start(struct wcd_mbhc *mbhc, struct wcd_mbhc_config *mbhc_cfg,
 void wcd_mbhc_stop(struct wcd_mbhc *mbhc);
 void wcd_mbhc_set_hph_type(struct wcd_mbhc *mbhc, int hph_type);
 int wcd_mbhc_get_hph_type(struct wcd_mbhc *mbhc);
+int wcd_mbhc_typec_report_plug(struct wcd_mbhc *mbhc);
+int wcd_mbhc_typec_report_unplug(struct wcd_mbhc *mbhc);
 struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 		      const struct wcd_mbhc_cb *mbhc_cb,
 		      const struct wcd_mbhc_intr *mbhc_cdc_intr_ids,

-- 
2.34.1

