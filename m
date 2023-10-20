Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E17D0C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376803AbjJTJv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376739AbjJTJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:51:15 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 306DF1AE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:51:09 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1461490:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 20 Oct 2023 17:50:37 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 20 Oct
 2023 17:50:36 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 20 Oct 2023 17:50:36 +0800
From:   <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Allen Lin <allen_lin@richtek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: codecs: rtq9128: Fix TKA470B E1 version amp on sequence
Date:   Fri, 20 Oct 2023 17:50:35 +0800
Message-ID: <1697795435-5858-4-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697795435-5858-1-git-send-email-cy_huang@richtek.com>
References: <1697795435-5858-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

For E1 sample, there's the current bias issue. Some undocumented RGs
should be runtime controlled during the DAPM flow to prevent the
abnormal false alarm protection latchup.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,
  Our E1 sample is evaluated by some end customer. Alghouth it's not the
final MP version. But to be compatible with the engineering sample, this
fix can solve the amp on issue.
---
 sound/soc/codecs/rtq9128.c | 57 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rtq9128.c b/sound/soc/codecs/rtq9128.c
index 8a61a8a32db1..5d75dc63492b 100644
--- a/sound/soc/codecs/rtq9128.c
+++ b/sound/soc/codecs/rtq9128.c
@@ -63,6 +63,7 @@ struct rtq9128_data {
 	int tdm_slots;
 	int tdm_slot_width;
 	bool tdm_input_data2_select;
+	bool tka470b_e1_ver;
 };
 
 struct rtq9128_init_reg {
@@ -171,7 +172,7 @@ static bool rtq9128_is_writeable_reg(struct device *dev, unsigned int reg)
 	case 0x80 ... 0x8B:
 	case 0xA0 ... 0xAD:
 	case 0xB0 ... 0xBA:
-	case 0xC0:
+	case 0xC0 ... 0xC1:
 	case 0xD0 ... 0xDE:
 	case 0xE0 ... 0xE5:
 	case 0xF0 ... 0xF3:
@@ -283,6 +284,33 @@ static const struct snd_kcontrol_new rtq9128_snd_ctrls[] = {
 	SOC_ENUM("DVDD UV Threshold Select", rtq9128_dvdduv_select_enum),
 };
 
+static int rtq9128_int_power_event(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
+				   int event)
+{
+	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
+	struct rtq9128_data *data = snd_soc_component_get_drvdata(comp);
+	int ret;
+
+	dev_dbg(comp->dev, "%s: event %d, ver %d\n", __func__, event, data->tka470b_e1_ver);
+
+	if (!data->tka470b_e1_ver)
+		return 0;
+
+	if (event == SND_SOC_DAPM_POST_PMU) {
+		ret = snd_soc_component_write(comp, 0xB9, 0x03);
+		if (ret)
+			return ret;
+
+		return snd_soc_component_write(comp, 0xC1, 0);
+	}
+
+	ret = snd_soc_component_write(comp, 0xA1, 0x02);
+	if (ret)
+		return ret;
+
+	return snd_soc_component_write(comp, 0xA8, 0x01);
+}
+
 static int rtq9128_dac_power_event(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
 				   int event)
 {
@@ -320,6 +348,8 @@ static int rtq9128_dac_power_event(struct snd_soc_dapm_widget *w, struct snd_kco
 }
 
 static const struct snd_soc_dapm_widget rtq9128_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("PWR", SND_SOC_NOPM, 0, 0, rtq9128_int_power_event,
+			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_DAC_E("DAC1", NULL, SND_SOC_NOPM, 0, 0, rtq9128_dac_power_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_DAC_E("DAC2", NULL, SND_SOC_NOPM, 0, 0, rtq9128_dac_power_event,
@@ -339,6 +369,10 @@ static const struct snd_soc_dapm_route rtq9128_dapm_routes[] = {
 	{ "DAC2", NULL, "Playback" },
 	{ "DAC3", NULL, "Playback" },
 	{ "DAC4", NULL, "Playback" },
+	{ "DAC1", NULL, "PWR" },
+	{ "DAC2", NULL, "PWR" },
+	{ "DAC3", NULL, "PWR" },
+	{ "DAC4", NULL, "PWR" },
 	{ "OUT1", NULL, "DAC1" },
 	{ "OUT2", NULL, "DAC2" },
 	{ "OUT3", NULL, "DAC3" },
@@ -358,9 +392,7 @@ static const struct rtq9128_init_reg rtq9128_tka470b_tables[] = {
 	{ 0x70, 0x11 },
 	{ 0x75, 0x1F },
 	{ 0xB6, 0x03 },
-	{ 0xB9, 0x03 },
 	{ 0xB8, 0x03 },
-	{ 0xC1, 0xFF },
 	{ 0xF8, 0x72 },
 	{ 0x30, 0x180 },
 };
@@ -387,6 +419,7 @@ static const struct rtq9128_init_reg rtq9128_dl_tables[] = {
 
 static int rtq9128_component_probe(struct snd_soc_component *comp)
 {
+	struct rtq9128_data *data = snd_soc_component_get_drvdata(comp);
 	const struct rtq9128_init_reg *table, *curr;
 	size_t table_size;
 	unsigned int val;
@@ -398,6 +431,7 @@ static int rtq9128_component_probe(struct snd_soc_component *comp)
 
 	switch (FIELD_GET(RTQ9128_DIE_CHECK_MASK, val)) {
 	case RTQ9128_TKA470B_VAL:
+		data->tka470b_e1_ver = true;
 		table = rtq9128_tka470b_tables;
 		table_size = ARRAY_SIZE(rtq9128_tka470b_tables);
 		break;
@@ -626,12 +660,29 @@ static int rtq9128_dai_hw_params(struct snd_pcm_substream *stream, struct snd_pc
 
 static int rtq9128_dai_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
+	struct rtq9128_data *data = snd_soc_dai_get_drvdata(dai);
 	struct snd_soc_component *comp = dai->component;
 	struct device *dev = dai->dev;
 	int ret;
 
 	dev_dbg(dev, "%s: mute (%d), stream (%d)\n", __func__, mute, stream);
 
+	if (data->tka470b_e1_ver && !mute) {
+		ret = snd_soc_component_write(comp, 0xB9, 0x02);
+		if (ret)
+			return ret;
+
+		usleep_range(10000, 11000);
+
+		ret = snd_soc_component_write(comp, 0xA1, 0xF2);
+		if (ret)
+			return ret;
+
+		ret = snd_soc_component_write(comp, 0xA8, 0x00);
+		if (ret)
+			return ret;
+	}
+
 	ret = snd_soc_component_write_field(comp, RTQ9128_REG_DSP_EN, RTQ9128_MSMUTE_MASK,
 					    mute ? 1 : 0);
 	return ret < 0 ? ret : 0;
-- 
2.34.1

