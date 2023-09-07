Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DFD7979D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbjIGRVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjIGRVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:21:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3410FB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:21:16 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 44CDF66072EE;
        Thu,  7 Sep 2023 18:10:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694106627;
        bh=v+KUOPMPCdqFTGL0GYSa2pPN6xNU4u2BRTjyZv9IMps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aATWsOhH7Gdi1uyd4fQM34ZPVrm5cancUJVVkfOX8yypo5C7qgV4WrjWkifK0ai+P
         k9snPO+mDf9gRMb/aJYCyEhFwdjShS6VPCL1IZ4YtsuFUQMshjsLTsBIfQRIa+BfNG
         CBK/fDPOJGtr3ssfY7kl1GKF6HoOUk3Rf28kcRnC38iRI1LjdBqz/jjtc+93ihbxQj
         4T6nYiwCNRKiPdLwkkFDntC1pMItgUTdb3IpTMDPqbxQYPphPEgVTCxMDcoB00WRNl
         AtuO5f8aR8wbfQYL++HdIj5gd8X5MC8xJAb6e0hYWsCAptKIXH+qD+BzrE02V/bXAi
         1KTo9YJ8qrhjw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 04/11] ASoC: cs35l41: Fix broken shared boost activation
Date:   Thu,  7 Sep 2023 20:10:03 +0300
Message-ID: <20230907171010.1447274-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
References: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the active/passive shared boosts requires setting SYNC_EN, but
*not* before receiving the PLL Lock signal.

Due to improper error handling, it was not obvious that waiting for the
completion operation times out and, consequently, the shared boost is
never activated.

Further investigations revealed the signal is triggered while
snd_pcm_start() is executed, right after receiving the
SNDRV_PCM_TRIGGER_START command, which happens long after the
SND_SOC_DAPM_PRE_PMU event handler is invoked as part of
snd_pcm_prepare().  That is where cs35l41_global_enable() is called
from.

Increasing the wait duration doesn't help, as it only causes an
unnecessary delay in the invocation of snd_pcm_start().  Moving the wait
and the subsequent regmap operations to the SNDRV_PCM_TRIGGER_START
callback is not a solution either, since they would be executed in an
IRQ-off atomic context.

Solve the issue by setting the SYNC_EN bit in PWR_CTRL3 register right
after receiving the PLL Lock interrupt.

Additionally, drop the unnecessary writes to PWR_CTRL1 register, part of
the original mdsync_up_seq, which would have toggled GLOBAL_EN with
unwanted consequences on PLL locking behavior.

Fixes: f5030564938b ("ALSA: cs35l41: Add shared boost feature")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 include/sound/cs35l41.h        |  4 +--
 sound/pci/hda/cs35l41_hda.c    |  4 +--
 sound/soc/codecs/cs35l41-lib.c | 61 ++++++++++++++++++++--------------
 sound/soc/codecs/cs35l41.c     | 24 ++++++++-----
 sound/soc/codecs/cs35l41.h     |  1 -
 5 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 1bf757901d02..2fe8c6b0d4cf 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -11,7 +11,6 @@
 #define __CS35L41_H
 
 #include <linux/regmap.h>
-#include <linux/completion.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
 
 #define CS35L41_FIRSTREG		0x00000000
@@ -902,7 +901,8 @@ int cs35l41_exit_hibernate(struct device *dev, struct regmap *regmap);
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg);
 bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type);
+int cs35l41_mdsync_up(struct regmap *regmap);
 int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l41_boost_type b_type,
-			  int enable, struct completion *pll_lock, bool firmware_running);
+			  int enable, bool firmware_running);
 
 #endif /* __CS35L41_H */
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index f9b77353c266..09a9c135d9b6 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -527,7 +527,7 @@ static void cs35l41_hda_play_done(struct device *dev)
 
 	dev_dbg(dev, "Play (Complete)\n");
 
-	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1, NULL,
+	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1,
 			      cs35l41->firmware_running);
 	if (cs35l41->firmware_running) {
 		regmap_multi_reg_write(reg, cs35l41_hda_unmute_dsp,
@@ -546,7 +546,7 @@ static void cs35l41_hda_pause_start(struct device *dev)
 	dev_dbg(dev, "Pause (Start)\n");
 
 	regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
-	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0, NULL,
+	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0,
 			      cs35l41->firmware_running);
 }
 
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index a6c6bb23b957..2ec5fdc875b1 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1192,8 +1192,28 @@ bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type)
 }
 EXPORT_SYMBOL_GPL(cs35l41_safe_reset);
 
+/*
+ * Enabling the CS35L41_SHD_BOOST_ACTV and CS35L41_SHD_BOOST_PASS shared boosts
+ * does also require a call to cs35l41_mdsync_up(), but not before getting the
+ * PLL Lock signal.
+ *
+ * PLL Lock seems to be triggered soon after snd_pcm_start() is executed and
+ * SNDRV_PCM_TRIGGER_START command is processed, which happens (long) after the
+ * SND_SOC_DAPM_PRE_PMU event handler is invoked as part of snd_pcm_prepare().
+ *
+ * This event handler is where cs35l41_global_enable() is normally called from,
+ * but waiting for PLL Lock here will time out. Increasing the wait duration
+ * will not help, as the only consequence of it would be to add an unnecessary
+ * delay in the invocation of snd_pcm_start().
+ *
+ * Trying to move the wait in the SNDRV_PCM_TRIGGER_START callback is not a
+ * solution either, as the trigger is executed in an IRQ-off atomic context.
+ *
+ * The current approach is to invoke cs35l41_mdsync_up() right after receiving
+ * the PLL Lock interrupt, in the IRQ handler.
+ */
 int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l41_boost_type b_type,
-			  int enable, struct completion *pll_lock, bool firmware_running)
+			  int enable, bool firmware_running)
 {
 	int ret;
 	unsigned int gpio1_func, pad_control, pwr_ctrl1, pwr_ctrl3, int_status, pup_pdn_mask;
@@ -1203,11 +1223,6 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 		{CS35L41_GPIO_PAD_CONTROL,	0},
 		{CS35L41_PWR_CTRL1,		0, 3000},
 	};
-	struct reg_sequence cs35l41_mdsync_up_seq[] = {
-		{CS35L41_PWR_CTRL3,	0},
-		{CS35L41_PWR_CTRL1,	0x00000000, 3000},
-		{CS35L41_PWR_CTRL1,	0x00000001, 3000},
-	};
 
 	pup_pdn_mask = enable ? CS35L41_PUP_DONE_MASK : CS35L41_PDN_DONE_MASK;
 
@@ -1241,26 +1256,11 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 		cs35l41_mdsync_down_seq[0].def = pwr_ctrl3;
 		cs35l41_mdsync_down_seq[1].def = pad_control;
 		cs35l41_mdsync_down_seq[2].def = pwr_ctrl1;
+
 		ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_down_seq,
 					     ARRAY_SIZE(cs35l41_mdsync_down_seq));
-		if (ret || !enable)
-			break;
-
-		if (!pll_lock)
-			return -EINVAL;
-
-		ret = wait_for_completion_timeout(pll_lock, msecs_to_jiffies(1000));
-		if (ret == 0) {
-			dev_err(dev, "Timed out waiting for pll_lock\n");
-			return -ETIMEDOUT;
-		}
-
-		regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
-		pwr_ctrl3 |= CS35L41_SYNC_EN_MASK;
-		cs35l41_mdsync_up_seq[0].def = pwr_ctrl3;
-		ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_up_seq,
-					     ARRAY_SIZE(cs35l41_mdsync_up_seq));
-		if (ret)
+		/* Activation to be completed later via cs35l41_mdsync_up() */
+		if (ret || enable)
 			return ret;
 
 		ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1,
@@ -1269,7 +1269,7 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 		if (ret)
 			dev_err(dev, "Enable(%d) failed: %d\n", enable, ret);
 
-		// Clear PUP/PDN status
+		/* Clear PUP/PDN status */
 		regmap_write(regmap, CS35L41_IRQ1_STATUS1, pup_pdn_mask);
 		break;
 	case CS35L41_INT_BOOST:
@@ -1351,6 +1351,17 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 }
 EXPORT_SYMBOL_GPL(cs35l41_global_enable);
 
+/*
+ * To be called after receiving the IRQ Lock interrupt, in order to complete
+ * any shared boost activation initiated by cs35l41_global_enable().
+ */
+int cs35l41_mdsync_up(struct regmap *regmap)
+{
+	return regmap_update_bits(regmap, CS35L41_PWR_CTRL3,
+				  CS35L41_SYNC_EN_MASK, CS35L41_SYNC_EN_MASK);
+}
+EXPORT_SYMBOL_GPL(cs35l41_mdsync_up);
+
 int cs35l41_gpio_config(struct regmap *regmap, struct cs35l41_hw_cfg *hw_cfg)
 {
 	struct cs35l41_gpio_cfg *gpio1 = &hw_cfg->gpio1;
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index fe5376b3e01b..12327b4c3d56 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -459,7 +459,19 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 
 	if (status[2] & CS35L41_PLL_LOCK) {
 		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS3, CS35L41_PLL_LOCK);
-		complete(&cs35l41->pll_lock);
+
+		if (cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_ACTV ||
+		    cs35l41->hw_cfg.bst_type == CS35L41_SHD_BOOST_PASS) {
+			ret = cs35l41_mdsync_up(cs35l41->regmap);
+			if (ret)
+				dev_err(cs35l41->dev, "MDSYNC-up failed: %d\n", ret);
+			else
+				dev_dbg(cs35l41->dev, "MDSYNC-up done\n");
+
+			dev_dbg(cs35l41->dev, "PUP-done status: %d\n",
+				!!(status[0] & CS35L41_PUP_DONE_MASK));
+		}
+
 		ret = IRQ_HANDLED;
 	}
 
@@ -500,11 +512,11 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 						ARRAY_SIZE(cs35l41_pup_patch));
 
 		ret = cs35l41_global_enable(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type,
-					    1, &cs35l41->pll_lock, cs35l41->dsp.cs_dsp.running);
+					    1, cs35l41->dsp.cs_dsp.running);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		ret = cs35l41_global_enable(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type,
-					    0, &cs35l41->pll_lock, cs35l41->dsp.cs_dsp.running);
+					    0, cs35l41->dsp.cs_dsp.running);
 
 		regmap_multi_reg_write_bypassed(cs35l41->regmap,
 						cs35l41_pdn_patch,
@@ -802,10 +814,6 @@ static const struct snd_pcm_hw_constraint_list cs35l41_constraints = {
 static int cs35l41_pcm_startup(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(dai->component);
-
-	reinit_completion(&cs35l41->pll_lock);
-
 	if (substream->runtime)
 		return snd_pcm_hw_constraint_list(substream->runtime, 0,
 						  SNDRV_PCM_HW_PARAM_RATE,
@@ -1273,8 +1281,6 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 		regmap_update_bits(cs35l41->regmap, CS35L41_IRQ1_MASK3, CS35L41_INT3_PLL_LOCK_MASK,
 				   0 << CS35L41_INT3_PLL_LOCK_SHIFT);
 
-	init_completion(&cs35l41->pll_lock);
-
 	ret = devm_request_threaded_irq(cs35l41->dev, cs35l41->irq, NULL, cs35l41_irq,
 					IRQF_ONESHOT | IRQF_SHARED | irq_pol,
 					"cs35l41", cs35l41);
diff --git a/sound/soc/codecs/cs35l41.h b/sound/soc/codecs/cs35l41.h
index 34d967d4372b..c85cbc1dd333 100644
--- a/sound/soc/codecs/cs35l41.h
+++ b/sound/soc/codecs/cs35l41.h
@@ -33,7 +33,6 @@ struct cs35l41_private {
 	int irq;
 	/* GPIO for /RST */
 	struct gpio_desc *reset_gpio;
-	struct completion pll_lock;
 };
 
 int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *hw_cfg);
-- 
2.41.0

