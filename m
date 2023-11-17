Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5591A7EF43A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbjKQOOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjKQOOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:14:20 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C9D52;
        Fri, 17 Nov 2023 06:14:06 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AH8IefN017599;
        Fri, 17 Nov 2023 08:13:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=jRbqwH6Ge42ChxgF46Ivy2SJOZSLFeYbW7olQcYfGhk=; b=
        GhAqSG8duowMLbg9WO7saNx3IKEGLM6GQDv8t3/6G0NIaKISeFOYf53sNnxJVlVp
        Iam40mYKdRYRkXnj809eEBhv4IUl93iCnMG3uafqLDsmZcb0/p4PYWQywzqTw7lZ
        WDv+TS8mgiZuLX5DrannPQfbnOPaZrGcOBnFQLUZYii4fkfTTgwdIta8xU8pEQHD
        D6Jn7zh5+cTkkW6sceOQez5OgmL0aVeQSP2blbFDiiE9sI7FWMz6cCqVBcI78udh
        o2bQMS07ZuqezIpCrOdXVDs9OYJIwoC3aJa4Vsk4qBQEQDD+rhIPYKuDZzJ+6uTL
        NHDg3ekEadx3WZ7qzHenMg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ua7w2qj86-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:13:53 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 14:13:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 14:13:47 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EAF26357F;
        Fri, 17 Nov 2023 14:13:46 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH 4/7] ASoC: cs43130: Store device in private struct and use it more consistently
Date:   Fri, 17 Nov 2023 14:13:41 +0000
Message-ID: <20231117141344.64320-5-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ABDyWQ0mJNPqoeKyds5AXSOrH1dnR7Nu
X-Proofpoint-GUID: ABDyWQ0mJNPqoeKyds5AXSOrH1dnR7Nu
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also remove one unnecessary debug print

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 sound/soc/codecs/cs43130.c | 151 ++++++++++++++++++-------------------
 sound/soc/codecs/cs43130.h |   1 +
 2 files changed, 75 insertions(+), 77 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 62647045d8c4..447abbaa6f47 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -238,7 +238,7 @@ static int cs43130_pll_config(struct snd_soc_component *component)
 	struct cs43130_private *cs43130 = snd_soc_component_get_drvdata(component);
 	const struct cs43130_pll_params *pll_entry;
 
-	dev_dbg(component->dev, "cs43130->mclk = %u, cs43130->mclk_int = %u\n",
+	dev_dbg(cs43130->dev, "cs43130->mclk = %u, cs43130->mclk_int = %u\n",
 		cs43130->mclk, cs43130->mclk_int);
 
 	pll_entry = cs43130_get_pll_table(cs43130->mclk, cs43130->mclk_int);
@@ -303,7 +303,7 @@ static int cs43130_set_pll(struct snd_soc_component *component, int pll_id, int
 		cs43130->mclk = freq_in;
 		break;
 	default:
-		dev_err(component->dev,
+		dev_err(cs43130->dev,
 			"unsupported pll input reference clock:%d\n", freq_in);
 		return -EINVAL;
 	}
@@ -316,13 +316,13 @@ static int cs43130_set_pll(struct snd_soc_component *component, int pll_id, int
 		cs43130->mclk_int = freq_out;
 		break;
 	default:
-		dev_err(component->dev,
+		dev_err(cs43130->dev,
 			"unsupported pll output ref clock: %u\n", freq_out);
 		return -EINVAL;
 	}
 
 	ret = cs43130_pll_config(component);
-	dev_dbg(component->dev, "cs43130->pll_bypass = %d", cs43130->pll_bypass);
+	dev_dbg(cs43130->dev, "cs43130->pll_bypass = %d", cs43130->pll_bypass);
 	return ret;
 }
 
@@ -346,7 +346,7 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
 		mclk_int_decoded = CS43130_MCLK_24P5;
 		break;
 	default:
-		dev_err(component->dev, "Invalid MCLK INT freq: %u\n", cs43130->mclk_int);
+		dev_err(cs43130->dev, "Invalid MCLK INT freq: %u\n", cs43130->mclk_int);
 		return -EINVAL;
 	}
 
@@ -370,7 +370,7 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
 					   CS43130_XTAL_RDY_INT_MASK,
 					   1 << CS43130_XTAL_RDY_INT_SHIFT);
 			if (ret == 0) {
-				dev_err(component->dev, "Timeout waiting for XTAL_READY interrupt\n");
+				dev_err(cs43130->dev, "Timeout waiting for XTAL_READY interrupt\n");
 				return -ETIMEDOUT;
 			}
 		}
@@ -406,7 +406,7 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
 					   CS43130_XTAL_RDY_INT_MASK,
 					   1 << CS43130_XTAL_RDY_INT_SHIFT);
 			if (ret == 0) {
-				dev_err(component->dev, "Timeout waiting for XTAL_READY interrupt\n");
+				dev_err(cs43130->dev, "Timeout waiting for XTAL_READY interrupt\n");
 				return -ETIMEDOUT;
 			}
 		}
@@ -422,7 +422,7 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
 				   CS43130_PLL_RDY_INT_MASK,
 				   1 << CS43130_PLL_RDY_INT_SHIFT);
 		if (ret == 0) {
-			dev_err(component->dev, "Timeout waiting for PLL_READY interrupt\n");
+			dev_err(cs43130->dev, "Timeout waiting for PLL_READY interrupt\n");
 			return -ETIMEDOUT;
 		}
 
@@ -453,7 +453,7 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
 				   1 << CS43130_PDN_PLL_SHIFT);
 		break;
 	default:
-		dev_err(component->dev, "Invalid MCLK source value\n");
+		dev_err(cs43130->dev, "Invalid MCLK source value\n");
 		return -EINVAL;
 	}
 
@@ -823,7 +823,7 @@ static int cs43130_dsd_hw_params(struct snd_pcm_substream *substream,
 		dsd_speed = 1;
 		break;
 	default:
-		dev_err(component->dev, "Rate(%u) not supported\n",
+		dev_err(cs43130->dev, "Rate(%u) not supported\n",
 			params_rate(params));
 		return -EINVAL;
 	}
@@ -894,7 +894,7 @@ static int cs43130_hw_params(struct snd_pcm_substream *substream,
 			dsd_speed = 1;
 			break;
 		default:
-			dev_err(component->dev, "Rate(%u) not supported\n",
+			dev_err(cs43130->dev, "Rate(%u) not supported\n",
 				params_rate(params));
 			return -EINVAL;
 		}
@@ -911,7 +911,7 @@ static int cs43130_hw_params(struct snd_pcm_substream *substream,
 		regmap_write(cs43130->regmap, CS43130_SP_SRATE, rate_map->val);
 		break;
 	default:
-		dev_err(component->dev, "Invalid DAI (%d)\n", dai->id);
+		dev_err(cs43130->dev, "Invalid DAI (%d)\n", dai->id);
 		return -EINVAL;
 	}
 
@@ -935,21 +935,21 @@ static int cs43130_hw_params(struct snd_pcm_substream *substream,
 
 	if (!sclk) {
 		/* at this point, SCLK must be set */
-		dev_err(component->dev, "SCLK freq is not set\n");
+		dev_err(cs43130->dev, "SCLK freq is not set\n");
 		return -EINVAL;
 	}
 
 	bitwidth_sclk = (sclk / params_rate(params)) / params_channels(params);
 	if (bitwidth_sclk < bitwidth_dai) {
-		dev_err(component->dev, "Format not supported: SCLK freq is too low\n");
+		dev_err(cs43130->dev, "Format not supported: SCLK freq is too low\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(component->dev,
+	dev_dbg(cs43130->dev,
 		"sclk = %u, fs = %d, bitwidth_dai = %u\n",
 		sclk, params_rate(params), bitwidth_dai);
 
-	dev_dbg(component->dev,
+	dev_dbg(cs43130->dev,
 		"bitwidth_sclk = %u, num_ch = %u\n",
 		bitwidth_sclk, params_channels(params));
 
@@ -1208,7 +1208,7 @@ static int cs43130_dsd_event(struct snd_soc_dapm_widget *w,
 		}
 		break;
 	default:
-		dev_err(component->dev, "Invalid event = 0x%x\n", event);
+		dev_err(cs43130->dev, "Invalid event = 0x%x\n", event);
 		return -EINVAL;
 	}
 	return 0;
@@ -1265,7 +1265,7 @@ static int cs43130_pcm_event(struct snd_soc_dapm_widget *w,
 		}
 		break;
 	default:
-		dev_err(component->dev, "Invalid event = 0x%x\n", event);
+		dev_err(cs43130->dev, "Invalid event = 0x%x\n", event);
 		return -EINVAL;
 	}
 	return 0;
@@ -1341,7 +1341,7 @@ static int cs43130_dac_event(struct snd_soc_dapm_widget *w,
 		}
 		break;
 	default:
-		dev_err(component->dev, "Invalid DAC event = 0x%x\n", event);
+		dev_err(cs43130->dev, "Invalid DAC event = 0x%x\n", event);
 		return -EINVAL;
 	}
 	return 0;
@@ -1379,7 +1379,7 @@ static int cs43130_hpin_event(struct snd_soc_dapm_widget *w,
 				       ARRAY_SIZE(hpin_postpmu_seq));
 		break;
 	default:
-		dev_err(component->dev, "Invalid HPIN event = 0x%x\n", event);
+		dev_err(cs43130->dev, "Invalid HPIN event = 0x%x\n", event);
 		return -EINVAL;
 	}
 	return 0;
@@ -1498,7 +1498,7 @@ static int cs43130_pcm_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		cs43130->dais[codec_dai->id].dai_mode = SND_SOC_DAIFMT_CBM_CFM;
 		break;
 	default:
-		dev_err(component->dev, "unsupported mode\n");
+		dev_err(cs43130->dev, "unsupported mode\n");
 		return -EINVAL;
 	}
 
@@ -1535,12 +1535,12 @@ static int cs43130_pcm_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		cs43130->dais[codec_dai->id].dai_format = SND_SOC_DAIFMT_DSP_B;
 		break;
 	default:
-		dev_err(component->dev,
+		dev_err(cs43130->dev,
 			"unsupported audio format\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(component->dev, "dai_id = %d,  dai_mode = %u, dai_format = %u\n",
+	dev_dbg(cs43130->dev, "dai_id = %d,  dai_mode = %u, dai_format = %u\n",
 		codec_dai->id,
 		cs43130->dais[codec_dai->id].dai_mode,
 		cs43130->dais[codec_dai->id].dai_format);
@@ -1561,11 +1561,11 @@ static int cs43130_dsd_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		cs43130->dais[codec_dai->id].dai_mode = SND_SOC_DAIFMT_CBM_CFM;
 		break;
 	default:
-		dev_err(component->dev, "Unsupported DAI format.\n");
+		dev_err(cs43130->dev, "Unsupported DAI format.\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(component->dev, "dai_mode = 0x%x\n",
+	dev_dbg(cs43130->dev, "dai_mode = 0x%x\n",
 		cs43130->dais[codec_dai->id].dai_mode);
 
 	return 0;
@@ -1578,7 +1578,7 @@ static int cs43130_set_sysclk(struct snd_soc_dai *codec_dai,
 	struct cs43130_private *cs43130 = snd_soc_component_get_drvdata(component);
 
 	cs43130->dais[codec_dai->id].sclk = freq;
-	dev_dbg(component->dev, "dai_id = %d,  sclk = %u\n", codec_dai->id,
+	dev_dbg(cs43130->dev, "dai_id = %d,  sclk = %u\n", codec_dai->id,
 		cs43130->dais[codec_dai->id].sclk);
 
 	return 0;
@@ -1668,7 +1668,7 @@ static int cs43130_component_set_sysclk(struct snd_soc_component *component,
 {
 	struct cs43130_private *cs43130 = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(component->dev, "clk_id = %d, source = %d, freq = %d, dir = %d\n",
+	dev_dbg(cs43130->dev, "clk_id = %d, source = %d, freq = %d, dir = %d\n",
 		clk_id, source, freq, dir);
 
 	switch (freq) {
@@ -1677,14 +1677,14 @@ static int cs43130_component_set_sysclk(struct snd_soc_component *component,
 		cs43130->mclk = freq;
 		break;
 	default:
-		dev_err(component->dev, "Invalid MCLK INT freq: %u\n", freq);
+		dev_err(cs43130->dev, "Invalid MCLK INT freq: %u\n", freq);
 		return -EINVAL;
 	}
 
 	if (source == CS43130_MCLK_SRC_EXT) {
 		cs43130->pll_bypass = true;
 	} else {
-		dev_err(component->dev, "Invalid MCLK source\n");
+		dev_err(cs43130->dev, "Invalid MCLK source\n");
 		return -EINVAL;
 	}
 
@@ -1971,7 +1971,6 @@ static int cs43130_update_hpload(unsigned int msk, int ac_idx,
 	unsigned int reg;
 	u32 addr;
 	u16 impedance;
-	struct snd_soc_component *component = cs43130->component;
 
 	switch (msk) {
 	case CS43130_HPLOAD_DC_INT:
@@ -2001,7 +2000,7 @@ static int cs43130_update_hpload(unsigned int msk, int ac_idx,
 		else
 			cs43130->hpload_dc[HP_RIGHT] = impedance;
 
-		dev_dbg(component->dev, "HP DC impedance (Ch %u): %u\n", !left_ch,
+		dev_dbg(cs43130->dev, "HP DC impedance (Ch %u): %u\n", !left_ch,
 			impedance);
 	} else {
 		if (left_ch)
@@ -2009,7 +2008,7 @@ static int cs43130_update_hpload(unsigned int msk, int ac_idx,
 		else
 			cs43130->hpload_ac[ac_idx][HP_RIGHT] = impedance;
 
-		dev_dbg(component->dev, "HP AC (%u Hz) impedance (Ch %u): %u\n",
+		dev_dbg(cs43130->dev, "HP AC (%u Hz) impedance (Ch %u): %u\n",
 			cs43130->ac_freq[ac_idx], !left_ch, impedance);
 	}
 
@@ -2023,7 +2022,6 @@ static int cs43130_hpload_proc(struct cs43130_private *cs43130,
 	int ret;
 	unsigned int msk;
 	u16 ac_reg_val;
-	struct snd_soc_component *component = cs43130->component;
 
 	reinit_completion(&cs43130->hpload_evt);
 
@@ -2046,17 +2044,17 @@ static int cs43130_hpload_proc(struct cs43130_private *cs43130,
 					  msecs_to_jiffies(1000));
 	regmap_read(cs43130->regmap, CS43130_INT_MASK_4, &msk);
 	if (!ret) {
-		dev_err(component->dev, "Timeout waiting for HPLOAD interrupt\n");
+		dev_err(cs43130->dev, "Timeout waiting for HPLOAD interrupt\n");
 		return -1;
 	}
 
-	dev_dbg(component->dev, "HP load stat: %x, INT_MASK_4: %x\n",
+	dev_dbg(cs43130->dev, "HP load stat: %x, INT_MASK_4: %x\n",
 		cs43130->hpload_stat, msk);
 	if ((cs43130->hpload_stat & (CS43130_HPLOAD_NO_DC_INT |
 				     CS43130_HPLOAD_UNPLUG_INT |
 				     CS43130_HPLOAD_OOR_INT)) ||
 	    !(cs43130->hpload_stat & rslt_msk)) {
-		dev_dbg(component->dev, "HP load measure failed\n");
+		dev_dbg(cs43130->dev, "HP load measure failed\n");
 		return -1;
 	}
 
@@ -2167,9 +2165,9 @@ static void cs43130_imp_meas(struct work_struct *wk)
 		snd_soc_jack_report(&cs43130->jack, CS43130_JACK_HEADPHONE,
 				    CS43130_JACK_MASK);
 
-	dev_dbg(component->dev, "Set HP output control. DC threshold\n");
+	dev_dbg(cs43130->dev, "Set HP output control. DC threshold\n");
 	for (i = 0; i < CS43130_DC_THRESHOLD; i++)
-		dev_dbg(component->dev, "DC threshold[%d]: %u.\n", i,
+		dev_dbg(cs43130->dev, "DC threshold[%d]: %u.\n", i,
 			cs43130->dc_threshold[i]);
 
 	cs43130_set_hv(cs43130->regmap, cs43130->hpload_dc[HP_LEFT],
@@ -2203,7 +2201,6 @@ static void cs43130_imp_meas(struct work_struct *wk)
 static irqreturn_t cs43130_irq_thread(int irq, void *data)
 {
 	struct cs43130_private *cs43130 = (struct cs43130_private *)data;
-	struct snd_soc_component *component = cs43130->component;
 	unsigned int stickies[CS43130_NUM_INT];
 	unsigned int irq_occurrence = 0;
 	unsigned int masks[CS43130_NUM_INT];
@@ -2221,8 +2218,6 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 		for (j = 0; j < 8; j++)
 			irq_occurrence += (stickies[i] >> j) & 1;
 	}
-	dev_dbg(component->dev, "number of interrupts occurred (%u)\n",
-		irq_occurrence);
 
 	if (!irq_occurrence)
 		return IRQ_NONE;
@@ -2239,7 +2234,7 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 
 	if (stickies[3] & CS43130_HPLOAD_NO_DC_INT) {
 		cs43130->hpload_stat = stickies[3];
-		dev_err(component->dev,
+		dev_err(cs43130->dev,
 			"DC load has not completed before AC load (%x)\n",
 			cs43130->hpload_stat);
 		complete(&cs43130->hpload_evt);
@@ -2248,7 +2243,7 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 
 	if (stickies[3] & CS43130_HPLOAD_UNPLUG_INT) {
 		cs43130->hpload_stat = stickies[3];
-		dev_err(component->dev, "HP unplugged during measurement (%x)\n",
+		dev_err(cs43130->dev, "HP unplugged during measurement (%x)\n",
 			cs43130->hpload_stat);
 		complete(&cs43130->hpload_evt);
 		return IRQ_HANDLED;
@@ -2256,7 +2251,7 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 
 	if (stickies[3] & CS43130_HPLOAD_OOR_INT) {
 		cs43130->hpload_stat = stickies[3];
-		dev_err(component->dev, "HP load out of range (%x)\n",
+		dev_err(cs43130->dev, "HP load out of range (%x)\n",
 			cs43130->hpload_stat);
 		complete(&cs43130->hpload_evt);
 		return IRQ_HANDLED;
@@ -2264,7 +2259,7 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 
 	if (stickies[3] & CS43130_HPLOAD_AC_INT) {
 		cs43130->hpload_stat = stickies[3];
-		dev_dbg(component->dev, "HP AC load measurement done (%x)\n",
+		dev_dbg(cs43130->dev, "HP AC load measurement done (%x)\n",
 			cs43130->hpload_stat);
 		complete(&cs43130->hpload_evt);
 		return IRQ_HANDLED;
@@ -2272,7 +2267,7 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 
 	if (stickies[3] & CS43130_HPLOAD_DC_INT) {
 		cs43130->hpload_stat = stickies[3];
-		dev_dbg(component->dev, "HP DC load measurement done (%x)\n",
+		dev_dbg(cs43130->dev, "HP DC load measurement done (%x)\n",
 			cs43130->hpload_stat);
 		complete(&cs43130->hpload_evt);
 		return IRQ_HANDLED;
@@ -2280,7 +2275,7 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 
 	if (stickies[3] & CS43130_HPLOAD_ON_INT) {
 		cs43130->hpload_stat = stickies[3];
-		dev_dbg(component->dev, "HP load state machine on done (%x)\n",
+		dev_dbg(cs43130->dev, "HP load state machine on done (%x)\n",
 			cs43130->hpload_stat);
 		complete(&cs43130->hpload_evt);
 		return IRQ_HANDLED;
@@ -2288,19 +2283,19 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 
 	if (stickies[3] & CS43130_HPLOAD_OFF_INT) {
 		cs43130->hpload_stat = stickies[3];
-		dev_dbg(component->dev, "HP load state machine off done (%x)\n",
+		dev_dbg(cs43130->dev, "HP load state machine off done (%x)\n",
 			cs43130->hpload_stat);
 		complete(&cs43130->hpload_evt);
 		return IRQ_HANDLED;
 	}
 
 	if (stickies[0] & CS43130_XTAL_ERR_INT) {
-		dev_err(component->dev, "Crystal err: clock is not running\n");
+		dev_err(cs43130->dev, "Crystal err: clock is not running\n");
 		return IRQ_HANDLED;
 	}
 
 	if (stickies[0] & CS43130_HP_UNPLUG_INT) {
-		dev_dbg(component->dev, "HP unplugged\n");
+		dev_dbg(cs43130->dev, "HP unplugged\n");
 		cs43130->hpload_done = false;
 		snd_soc_jack_report(&cs43130->jack, 0, CS43130_JACK_MASK);
 		return IRQ_HANDLED;
@@ -2309,7 +2304,7 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 	if (stickies[0] & CS43130_HP_PLUG_INT) {
 		if (cs43130->dc_meas && !cs43130->hpload_done &&
 		    !work_busy(&cs43130->work)) {
-			dev_dbg(component->dev, "HP load queue work\n");
+			dev_dbg(cs43130->dev, "HP load queue work\n");
 			queue_work(cs43130->wq, &cs43130->work);
 		}
 
@@ -2341,19 +2336,19 @@ static int cs43130_probe(struct snd_soc_component *component)
 	ret = snd_soc_card_jack_new(card, "Headphone", CS43130_JACK_MASK,
 				    &cs43130->jack);
 	if (ret < 0) {
-		dev_err(component->dev, "Cannot create jack\n");
+		dev_err(cs43130->dev, "Cannot create jack\n");
 		return ret;
 	}
 
 	cs43130->hpload_done = false;
 	if (cs43130->dc_meas) {
-		ret = sysfs_create_groups(&component->dev->kobj, hpload_groups);
+		ret = sysfs_create_groups(&cs43130->dev->kobj, hpload_groups);
 		if (ret)
 			return ret;
 
 		cs43130->wq = create_singlethread_workqueue("cs43130_hp");
 		if (!cs43130->wq) {
-			sysfs_remove_groups(&component->dev->kobj, hpload_groups);
+			sysfs_remove_groups(&cs43130->dev->kobj, hpload_groups);
 			return -ENOMEM;
 		}
 		INIT_WORK(&cs43130->work, cs43130_imp_meas);
@@ -2429,7 +2424,7 @@ static int cs43130_handle_device_data(struct i2c_client *i2c_client,
 		cs43130->xtal_ibias = CS43130_XTAL_IBIAS_15UA;
 		break;
 	default:
-		dev_err(&i2c_client->dev,
+		dev_err(cs43130->dev,
 			"Invalid cirrus,xtal-ibias value: %d\n", val);
 		return -EINVAL;
 	}
@@ -2464,6 +2459,8 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 	if (!cs43130)
 		return -ENOMEM;
 
+	cs43130->dev = &client->dev;
+
 	i2c_set_clientdata(client, cs43130);
 
 	cs43130->regmap = devm_regmap_init_i2c(client, &cs43130_regmap);
@@ -2472,7 +2469,7 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	if (client->dev.of_node) {
+	if (cs43130->dev->of_node) {
 		ret = cs43130_handle_device_data(client, cs43130);
 		if (ret != 0)
 			return ret;
@@ -2480,21 +2477,21 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 	for (i = 0; i < ARRAY_SIZE(cs43130->supplies); i++)
 		cs43130->supplies[i].supply = cs43130_supply_names[i];
 
-	ret = devm_regulator_bulk_get(&client->dev,
+	ret = devm_regulator_bulk_get(cs43130->dev,
 				      ARRAY_SIZE(cs43130->supplies),
 				      cs43130->supplies);
 	if (ret != 0) {
-		dev_err(&client->dev, "Failed to request supplies: %d\n", ret);
+		dev_err(cs43130->dev, "Failed to request supplies: %d\n", ret);
 		return ret;
 	}
 	ret = regulator_bulk_enable(ARRAY_SIZE(cs43130->supplies),
 				    cs43130->supplies);
 	if (ret != 0) {
-		dev_err(&client->dev, "Failed to enable supplies: %d\n", ret);
+		dev_err(cs43130->dev, "Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
-	cs43130->reset_gpio = devm_gpiod_get_optional(&client->dev,
+	cs43130->reset_gpio = devm_gpiod_get_optional(cs43130->dev,
 						      "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs43130->reset_gpio)) {
 		ret = PTR_ERR(cs43130->reset_gpio);
@@ -2508,7 +2505,7 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 	devid = cirrus_read_device_id(cs43130->regmap, CS43130_DEVID_AB);
 	if (devid < 0) {
 		ret = devid;
-		dev_err(&client->dev, "Failed to read device ID: %d\n", ret);
+		dev_err(cs43130->dev, "Failed to read device ID: %d\n", ret);
 		goto err;
 	}
 
@@ -2519,7 +2516,7 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 	case CS43198_CHIP_ID:
 		break;
 	default:
-		dev_err(&client->dev,
+		dev_err(cs43130->dev,
 			"CS43130 Device ID %X. Expected ID %X, %X, %X or %X\n",
 			devid, CS43130_CHIP_ID, CS4399_CHIP_ID,
 			CS43131_CHIP_ID, CS43198_CHIP_ID);
@@ -2530,11 +2527,11 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 	cs43130->dev_id = devid;
 	ret = regmap_read(cs43130->regmap, CS43130_REV_ID, &reg);
 	if (ret < 0) {
-		dev_err(&client->dev, "Get Revision ID failed\n");
+		dev_err(cs43130->dev, "Get Revision ID failed\n");
 		goto err;
 	}
 
-	dev_info(&client->dev,
+	dev_info(cs43130->dev,
 		 "Cirrus Logic CS43130 (%x), Revision: %02X\n", devid,
 		 reg & 0xFF);
 
@@ -2544,21 +2541,21 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 	init_completion(&cs43130->pll_rdy);
 	init_completion(&cs43130->hpload_evt);
 
-	ret = devm_request_threaded_irq(&client->dev, client->irq,
+	ret = devm_request_threaded_irq(cs43130->dev, client->irq,
 					NULL, cs43130_irq_thread,
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
 					"cs43130", cs43130);
 	if (ret != 0) {
-		dev_err(&client->dev, "Failed to request IRQ: %d\n", ret);
+		dev_err(cs43130->dev, "Failed to request IRQ: %d\n", ret);
 		goto err;
 	}
 
 	cs43130->mclk_int_src = CS43130_MCLK_SRC_RCO;
 
-	pm_runtime_set_autosuspend_delay(&client->dev, 100);
-	pm_runtime_use_autosuspend(&client->dev);
-	pm_runtime_set_active(&client->dev);
-	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(cs43130->dev, 100);
+	pm_runtime_use_autosuspend(cs43130->dev);
+	pm_runtime_set_active(cs43130->dev);
+	pm_runtime_enable(cs43130->dev);
 
 	switch (cs43130->dev_id) {
 	case CS43130_CHIP_ID:
@@ -2594,11 +2591,11 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 		break;
 	}
 
-	ret = devm_snd_soc_register_component(&client->dev,
+	ret = devm_snd_soc_register_component(cs43130->dev,
 				     &soc_component_dev_cs43130,
 				     cs43130_dai, ARRAY_SIZE(cs43130_dai));
 	if (ret < 0) {
-		dev_err(&client->dev,
+		dev_err(cs43130->dev,
 			"snd_soc_register_component failed with ret = %d\n", ret);
 		goto err;
 	}
@@ -2636,15 +2633,15 @@ static void cs43130_i2c_remove(struct i2c_client *client)
 		cancel_work_sync(&cs43130->work);
 		flush_workqueue(cs43130->wq);
 
-		device_remove_file(&client->dev, &dev_attr_hpload_dc_l);
-		device_remove_file(&client->dev, &dev_attr_hpload_dc_r);
-		device_remove_file(&client->dev, &dev_attr_hpload_ac_l);
-		device_remove_file(&client->dev, &dev_attr_hpload_ac_r);
+		device_remove_file(cs43130->dev, &dev_attr_hpload_dc_l);
+		device_remove_file(cs43130->dev, &dev_attr_hpload_dc_r);
+		device_remove_file(cs43130->dev, &dev_attr_hpload_ac_l);
+		device_remove_file(cs43130->dev, &dev_attr_hpload_ac_r);
 	}
 
 	gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
 
-	pm_runtime_disable(&client->dev);
+	pm_runtime_disable(cs43130->dev);
 	regulator_bulk_disable(CS43130_NUM_SUPPLIES, cs43130->supplies);
 }
 
diff --git a/sound/soc/codecs/cs43130.h b/sound/soc/codecs/cs43130.h
index c7b2708aebcd..d3f595bbd3ba 100644
--- a/sound/soc/codecs/cs43130.h
+++ b/sound/soc/codecs/cs43130.h
@@ -501,6 +501,7 @@ struct cs43130_dai {
 };
 
 struct	cs43130_private {
+	struct device			*dev;
 	struct snd_soc_component	*component;
 	struct regmap			*regmap;
 	struct regulator_bulk_data	supplies[CS43130_NUM_SUPPLIES];
-- 
2.34.1

