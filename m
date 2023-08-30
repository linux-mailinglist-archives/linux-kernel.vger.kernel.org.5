Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048378E08F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbjH3UZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbjH3UZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:25:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9043065A9;
        Wed, 30 Aug 2023 12:57:42 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37UHsJ25024471;
        Wed, 30 Aug 2023 14:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Yy99K2Cvd8A9OC7uNp5FEDGpePrWFyTtQcKsDstsj7Q=; b=
        lLLapg8FoddP2j0HDa43IoQwxVsWKEXiMvTIsiIVC97kbd8gb8e11u/fUIHuB4tw
        /hmFkol93gio/UM5rpBVd4wlpuwlScCmV5/ahopVIVFa/fkuouvnd4pa39ouiTiZ
        Ke/aJ3RtxOIw8Mk80/Uz/zDhYPEkaajeWm7HEZnUcXp7uZOotWo2TSvg9TmborKm
        Q3m2OYp58ggZj7tcPVD3ZOcoBLv34l22Te35dYhS3dQhzT638k1RFaKptpufbkm7
        tcSF/NLRkxHvWRXmMARY/xRWkwhP5WO/rTT/bewMhqc8/sgPtaJ5yRAy4dGUOgOI
        fWPR/B2FLtJyZ9jJq635vg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesydet9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 14:56:05 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 30 Aug
 2023 20:56:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 30 Aug 2023 20:56:02 +0100
Received: from vkarpovich-ThinkStation-P620.crystal.cirrus.com (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F22DE11D4;
        Wed, 30 Aug 2023 19:56:00 +0000 (UTC)
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Subject: [PATCH v2 2/4] ASoC: cs35l45: Analog PCM Volume and Amplifier Mode controls
Date:   Wed, 30 Aug 2023 14:55:34 -0500
Message-ID: <20230830195536.448884-2-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
References: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LRMFwn8VySlgQaR_x9qgtojdkgOt2LVg
X-Proofpoint-GUID: LRMFwn8VySlgQaR_x9qgtojdkgOt2LVg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds "Analog PCM Volume" control with supported values
0 = 10dB,1 = 13dB,2 = 16dB and 3 = 19dB.
The amplifier can operate either in Speaker Mode or Receiver Mode
as configured by the user. Speaker Mode has four gain options
to support maximum amplifier output amplitude for loud
speaker application. Receiver Mode has further optimized
noise performance while maintaining sufficient output to support
phone receiver application. While configured in Receiver Mode,
the analog PCM Volume control is disabled and
the analog gain is fixed to 1dB.

Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45-tables.c |   3 +
 sound/soc/codecs/cs35l45.c        | 148 ++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l45.h        |  35 ++++++-
 3 files changed, 184 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l45-tables.c b/sound/soc/codecs/cs35l45-tables.c
index e20c1bc9a687..2e77644f3b0b 100644
--- a/sound/soc/codecs/cs35l45-tables.c
+++ b/sound/soc/codecs/cs35l45-tables.c
@@ -91,6 +91,7 @@ static const struct reg_default cs35l45_defaults[] = {
 	{ CS35L45_DSP1RX7_INPUT,		0x0000003A },
 	{ CS35L45_DSP1RX8_INPUT,		0x00000028 },
 	{ CS35L45_AMP_PCM_CONTROL,		0x00100000 },
+	{ CS35L45_AMP_GAIN,			0x00002300 },
 	{ CS35L45_IRQ1_CFG,			0x00000000 },
 	{ CS35L45_IRQ1_MASK_1,			0xBFEFFFBF },
 	{ CS35L45_IRQ1_MASK_2,			0xFFFFFFFF },
@@ -156,7 +157,9 @@ static bool cs35l45_readable_reg(struct device *dev, unsigned int reg)
 	case CS35L45_DSP1RX6_INPUT:
 	case CS35L45_DSP1RX7_INPUT:
 	case CS35L45_DSP1RX8_INPUT:
+	case CS35L45_HVLV_CONFIG:
 	case CS35L45_AMP_PCM_CONTROL:
+	case CS35L45_AMP_GAIN:
 	case CS35L45_AMP_PCM_HPF_TST:
 	case CS35L45_IRQ1_CFG:
 	case CS35L45_IRQ1_STATUS:
diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index 02b1172d2647..18e656e72cb3 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -169,6 +169,142 @@ static int cs35l45_dsp_audio_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int cs35l45_activate_ctl(struct snd_soc_component *component,
+				const char *ctl_name, bool active)
+{
+	struct snd_card *card = component->card->snd_card;
+	struct snd_kcontrol *kcontrol;
+	struct snd_kcontrol_volatile *vd;
+	unsigned int index_offset;
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	if (component->name_prefix)
+		snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s %s",
+			 component->name_prefix, ctl_name);
+	else
+		snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s", ctl_name);
+
+	kcontrol = snd_soc_card_get_kcontrol(component->card, name);
+	if (!kcontrol) {
+		dev_err(component->dev, "Can't find kcontrol %s\n", name);
+		return -EINVAL;
+	}
+
+	index_offset = snd_ctl_get_ioff(kcontrol, &kcontrol->id);
+	vd = &kcontrol->vd[index_offset];
+	if (active)
+		vd->access |= SNDRV_CTL_ELEM_ACCESS_WRITE;
+	else
+		vd->access &= ~SNDRV_CTL_ELEM_ACCESS_WRITE;
+
+	snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, &kcontrol->id);
+
+	return 0;
+}
+
+static int cs35l45_amplifier_mode_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct cs35l45_private *cs35l45 =
+			snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = cs35l45->amplifier_mode;
+
+	return 0;
+}
+
+static int cs35l45_amplifier_mode_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct cs35l45_private *cs35l45 =
+			snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm =
+			snd_soc_component_get_dapm(component);
+	unsigned int amp_state;
+	int ret;
+
+	if ((ucontrol->value.integer.value[0] == cs35l45->amplifier_mode) ||
+	    (ucontrol->value.integer.value[0] > AMP_MODE_RCV))
+		return 0;
+
+	snd_soc_dapm_mutex_lock(dapm);
+
+	ret = regmap_read(cs35l45->regmap, CS35L45_BLOCK_ENABLES, &amp_state);
+	if (ret < 0) {
+		dev_err(cs35l45->dev, "Failed to read AMP state: %d\n", ret);
+		snd_soc_dapm_mutex_unlock(dapm);
+		return ret;
+	}
+
+	regmap_clear_bits(cs35l45->regmap, CS35L45_BLOCK_ENABLES,
+				  CS35L45_AMP_EN_MASK);
+	snd_soc_component_disable_pin_unlocked(component, "SPK");
+	snd_soc_dapm_sync_unlocked(dapm);
+
+	if (ucontrol->value.integer.value[0] == AMP_MODE_SPK) {
+		regmap_clear_bits(cs35l45->regmap, CS35L45_BLOCK_ENABLES,
+				  CS35L45_RCV_EN_MASK);
+
+		regmap_update_bits(cs35l45->regmap, CS35L45_BLOCK_ENABLES,
+				   CS35L45_BST_EN_MASK,
+				   CS35L45_BST_ENABLE << CS35L45_BST_EN_SHIFT);
+
+		regmap_update_bits(cs35l45->regmap, CS35L45_HVLV_CONFIG,
+				   CS35L45_HVLV_MODE_MASK,
+				   CS35L45_HVLV_OPERATION <<
+				   CS35L45_HVLV_MODE_SHIFT);
+
+		ret = cs35l45_activate_ctl(component, "Analog PCM Volume", true);
+		if (ret < 0)
+			dev_err(cs35l45->dev,
+				"Unable to deactivate ctl (%d)\n", ret);
+
+	} else  /* AMP_MODE_RCV */ {
+		regmap_set_bits(cs35l45->regmap, CS35L45_BLOCK_ENABLES,
+				CS35L45_RCV_EN_MASK);
+
+		regmap_update_bits(cs35l45->regmap, CS35L45_BLOCK_ENABLES,
+				   CS35L45_BST_EN_MASK,
+				   CS35L45_BST_DISABLE_FET_OFF <<
+				   CS35L45_BST_EN_SHIFT);
+
+		regmap_update_bits(cs35l45->regmap, CS35L45_HVLV_CONFIG,
+				   CS35L45_HVLV_MODE_MASK,
+				   CS35L45_FORCE_LV_OPERATION <<
+				   CS35L45_HVLV_MODE_SHIFT);
+
+		regmap_clear_bits(cs35l45->regmap,
+				  CS35L45_BLOCK_ENABLES2,
+				  CS35L45_AMP_DRE_EN_MASK);
+
+		regmap_update_bits(cs35l45->regmap, CS35L45_AMP_GAIN,
+				   CS35L45_AMP_GAIN_PCM_MASK,
+				   CS35L45_AMP_GAIN_PCM_13DBV <<
+				   CS35L45_AMP_GAIN_PCM_SHIFT);
+
+		ret = cs35l45_activate_ctl(component, "Analog PCM Volume", false);
+		if (ret < 0)
+			dev_err(cs35l45->dev,
+				"Unable to deactivate ctl (%d)\n", ret);
+	}
+
+	if (amp_state & CS35L45_AMP_EN_MASK)
+		regmap_set_bits(cs35l45->regmap, CS35L45_BLOCK_ENABLES,
+				CS35L45_AMP_EN_MASK);
+
+	snd_soc_component_enable_pin_unlocked(component, "SPK");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	cs35l45->amplifier_mode = ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
 static const char * const cs35l45_asp_tx_txt[] = {
 	"Zero", "ASP_RX1", "ASP_RX2",
 	"VMON", "IMON", "ERR_VOL",
@@ -432,9 +568,19 @@ static const struct snd_soc_dapm_route cs35l45_dapm_routes[] = {
 	{ "SPK", NULL, "AMP"},
 };
 
+static const char * const amplifier_mode_texts[] = {"SPK", "RCV"};
+static SOC_ENUM_SINGLE_DECL(amplifier_mode_enum, SND_SOC_NOPM, 0,
+			    amplifier_mode_texts);
+static DECLARE_TLV_DB_SCALE(amp_gain_tlv, 1000, 300, 0);
 static const DECLARE_TLV_DB_SCALE(cs35l45_dig_pcm_vol_tlv, -10225, 25, true);
 
 static const struct snd_kcontrol_new cs35l45_controls[] = {
+	SOC_ENUM_EXT("Amplifier Mode", amplifier_mode_enum,
+		     cs35l45_amplifier_mode_get, cs35l45_amplifier_mode_put),
+	SOC_SINGLE_TLV("Analog PCM Volume", CS35L45_AMP_GAIN,
+			CS35L45_AMP_GAIN_PCM_SHIFT,
+			CS35L45_AMP_GAIN_PCM_MASK >> CS35L45_AMP_GAIN_PCM_SHIFT,
+			0, amp_gain_tlv),
 	/* Ignore bit 0: it is beyond the resolution of TLV_DB_SCALE */
 	SOC_SINGLE_S_TLV("Digital PCM Volume",
 			 CS35L45_AMP_PCM_CONTROL,
@@ -1104,6 +1250,8 @@ static int cs35l45_initialize(struct cs35l45_private *cs35l45)
 	if (ret < 0)
 		return ret;
 
+	cs35l45->amplifier_mode = AMP_MODE_SPK;
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/cs35l45.h b/sound/soc/codecs/cs35l45.h
index 61135a316df3..16857321d945 100644
--- a/sound/soc/codecs/cs35l45.h
+++ b/sound/soc/codecs/cs35l45.h
@@ -61,9 +61,11 @@
 #define CS35L45_DSP1RX6_INPUT			0x00004C54
 #define CS35L45_DSP1RX7_INPUT			0x00004C58
 #define CS35L45_DSP1RX8_INPUT			0x00004C5C
+#define CS35L45_HVLV_CONFIG			0x00006400
 #define CS35L45_LDPM_CONFIG			0x00006404
 #define CS35L45_AMP_PCM_CONTROL			0x00007000
 #define CS35L45_AMP_PCM_HPF_TST			0x00007004
+#define CS35L45_AMP_GAIN			0x00007800
 #define CS35L45_IRQ1_CFG			0x0000E000
 #define CS35L45_IRQ1_STATUS			0x0000E004
 #define CS35L45_IRQ1_EINT_1			0x0000E010
@@ -167,12 +169,19 @@
 #define CS35L45_VDD_BATTMON_EN_SHIFT		8
 #define CS35L45_BST_EN_SHIFT			4
 #define CS35L45_BST_EN_MASK			GENMASK(5, 4)
+#define CS35L45_RCV_EN_SHIFT			2
+#define CS35L45_RCV_EN_MASK			BIT(2)
+#define CS35L45_AMP_EN_SHIFT			0
+#define CS35L45_AMP_EN_MASK			BIT(0)
 
-#define CS35L45_BST_DISABLE_FET_ON              0x01
+#define CS35L45_BST_DISABLE_FET_OFF		0x00
+#define CS35L45_BST_DISABLE_FET_ON		0x01
+#define CS35L45_BST_ENABLE			0x02
 
 /* BLOCK_ENABLES2 */
 #define CS35L45_ASP_EN_SHIFT			27
-
+#define CS35L45_AMP_DRE_EN_SHIFT		20
+#define CS35L45_AMP_DRE_EN_MASK		BIT(20)
 #define CS35L45_MEM_RDY_SHIFT			1
 #define CS35L45_MEM_RDY_MASK			BIT(1)
 
@@ -266,6 +275,13 @@
 #define CS35L45_ASP_WL_SHIFT			0
 #define CS35L45_ASP_WL_MASK			GENMASK(5, 0)
 
+/* HVLV_CONFIG */
+#define CS35L45_FORCE_LV_OPERATION		0x01
+#define CS35L45_FORCE_HV_OPERATION		0x02
+#define CS35L45_HVLV_OPERATION			0x03
+#define CS35L45_HVLV_MODE_SHIFT		0
+#define CS35L45_HVLV_MODE_MASK			GENMASK(1, 0)
+
 /* AMP_PCM_CONTROL */
 #define CS35L45_AMP_VOL_PCM_SHIFT		0
 #define CS35L45_AMP_VOL_PCM_WIDTH		11
@@ -275,6 +291,15 @@
 #define CS35L45_HPF_44P1			0x000108BD
 #define CS35L45_HPF_88P2			0x0001045F
 
+/* AMP_GAIN_PCM */
+#define CS35L45_AMP_GAIN_PCM_10DBV		0x00
+#define CS35L45_AMP_GAIN_PCM_13DBV		0x01
+#define CS35L45_AMP_GAIN_PCM_16DBV		0x02
+#define CS35L45_AMP_GAIN_PCM_19DBV		0x03
+
+#define CS35L45_AMP_GAIN_PCM_SHIFT		8
+#define CS35L45_AMP_GAIN_PCM_MASK		GENMASK(9, 8)
+
 /* IRQ1_EINT_4 */
 #define CS35L45_OTP_BOOT_DONE_STS_MASK		BIT(1)
 #define CS35L45_OTP_BUSY_MASK			BIT(0)
@@ -396,6 +421,11 @@ enum control_bus_type {
 	CONTROL_BUS_SPI = 1,
 };
 
+enum amp_mode {
+	AMP_MODE_SPK  = 0,
+	AMP_MODE_RCV  = 1,
+};
+
 #define CS35L45_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 			 SNDRV_PCM_FMTBIT_S24_3LE| \
 			 SNDRV_PCM_FMTBIT_S24_LE)
@@ -464,6 +494,7 @@ struct cs35l45_private {
 	bool sysclk_set;
 	u8 slot_width;
 	u8 slot_count;
+	int amplifier_mode;
 	int irq_invert;
 	int irq;
 	unsigned int i2c_addr;
-- 
2.25.1

