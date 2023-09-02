Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3DC7909A9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 23:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjIBVGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 17:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjIBVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 17:06:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E73E54
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 14:06:38 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9031E66072B5;
        Sat,  2 Sep 2023 22:06:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693688797;
        bh=iekwK11XbOskpf3xmL90QbHkzIoNYgnBqbKDM8TC4do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEQCHpSriKXpgzz8SYM6UDY3NfM2gzd31oZ9qyiEvlYODl7G9ehRlcdEmACivD4/z
         gX7q/cSkv3l0z2kLsFg09pflgPAc8LvvDTmFxQWbDVh3exCESVLFYOEtUCDfCQM8w2
         SFpbRcwMTVMpVK7GQijRbYRaDIv6MDavavMI2japFEcux9BY1Bfj+q4qe4BEvHRCSy
         rj/I1d1sVmIUXPLn38tviW15zH04/1YZY5RPn4zLB7qV2jkFb+VxdcvJ8fZdTFE+dl
         TDzdFUx2eTF+tU/GwQWIfOuEbXq+5rmOc76h1QOgxFsSKAwUPkY6zyr6FQDBnZNabv
         4xF9IPb72GJ4Q==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 4/9] ASoC: cs35l41: Fix broken shared boost activation
Date:   Sun,  3 Sep 2023 00:06:16 +0300
Message-ID: <20230902210621.1184693-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
References: <20230902210621.1184693-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the active/passive shared boosts involves writing the MDSYNC UP
register sequence, which cannot be performed before receiving the PLL
lock signal.

Due to improper error handling, it was not obvious the wait operation
times out and, consequently, the shared boost gets never enabled.

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

Solve the issue by deferring the processing to a workqueue task, which
allows to correctly wait for the signal and then safely proceed with
the required regmap operations.

Fixes: f5030564938b ("ALSA: cs35l41: Add shared boost feature")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 include/sound/cs35l41.h        |  5 +-
 sound/soc/codecs/cs35l41-lib.c | 86 +++++++++++++++++++++++++---------
 sound/soc/codecs/cs35l41.c     | 38 ++++++++++++++-
 sound/soc/codecs/cs35l41.h     |  2 +
 4 files changed, 104 insertions(+), 27 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 1bf757901d02..91024411f8a1 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -11,7 +11,7 @@
 #define __CS35L41_H
 
 #include <linux/regmap.h>
-#include <linux/completion.h>
+#include <linux/workqueue.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
 
 #define CS35L41_FIRSTREG		0x00000000
@@ -902,7 +902,8 @@ int cs35l41_exit_hibernate(struct device *dev, struct regmap *regmap);
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg);
 bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type);
+int cs35l41_mdsync_up(struct regmap *regmap);
 int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l41_boost_type b_type,
-			  int enable, struct completion *pll_lock, bool firmware_running);
+			  int enable, struct work_struct *mdsync_up_work, bool firmware_running);
 
 #endif /* __CS35L41_H */
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index a6c6bb23b957..16e7f46d3853 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1192,8 +1192,56 @@ bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type)
 }
 EXPORT_SYMBOL_GPL(cs35l41_safe_reset);
 
+int cs35l41_mdsync_up(struct regmap *regmap)
+{
+	struct reg_sequence cs35l41_mdsync_up_seq[] = {
+		{CS35L41_PWR_CTRL3, 0},
+		{CS35L41_PWR_CTRL1, 0x00000000, 3000},
+		{CS35L41_PWR_CTRL1, 0x00000001, 3000},
+	};
+	unsigned int pwr_ctrl3, int_status;
+	int ret;
+
+	regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
+	pwr_ctrl3 |= CS35L41_SYNC_EN_MASK;
+	cs35l41_mdsync_up_seq[0].def = pwr_ctrl3;
+
+	ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_up_seq,
+				     ARRAY_SIZE(cs35l41_mdsync_up_seq));
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1, int_status,
+				       int_status & CS35L41_PUP_DONE_MASK,
+				       1000, 100000);
+
+	/* Clear PUP/PDN status */
+	regmap_write(regmap, CS35L41_IRQ1_STATUS1, CS35L41_PUP_DONE_MASK);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cs35l41_mdsync_up);
+
+/*
+ * NOTE: Enabling the CS35L41_SHD_BOOST_ACTV and CS35L41_SHD_BOOST_PASS shared
+ * boosts involves writing the MDSYNC UP reg sequence, which must be performed
+ * only after getting the PLL lock signal. This signal seems to be triggered
+ * soon after snd_pcm_start() is executed and SNDRV_PCM_TRIGGER_START command
+ * is processed, which happens (long) after the SND_SOC_DAPM_PRE_PMU event
+ * handler is invoked as part of snd_pcm_prepare().
+ *
+ * The event handler is where cs35l41_global_enable() should be normally called
+ * from, but waiting for the PLL lock signal here will time out. Increasing the
+ * wait duration will not help, as the only consequence of that would be to add
+ * an unnecessary delay in the invocation of snd_pcm_start().
+ *
+ * Trying to move the wait in the SNDRV_PCM_TRIGGER_START callback is not a
+ * solution either, as the trigger is executed in an IRQ-off atomic context,
+ * hence the current approach is to defer the processing to a workqueue task.
+ * This allows to properly wait for the signal and then safely write the
+ * necessary MDSYNC sequence by calling cs35l41_mdsync_up() above.
+ */
 int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l41_boost_type b_type,
-			  int enable, struct completion *pll_lock, bool firmware_running)
+			  int enable, struct work_struct *mdsync_up_work, bool firmware_running)
 {
 	int ret;
 	unsigned int gpio1_func, pad_control, pwr_ctrl1, pwr_ctrl3, int_status, pup_pdn_mask;
@@ -1203,11 +1251,6 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 		{CS35L41_GPIO_PAD_CONTROL,	0},
 		{CS35L41_PWR_CTRL1,		0, 3000},
 	};
-	struct reg_sequence cs35l41_mdsync_up_seq[] = {
-		{CS35L41_PWR_CTRL3,	0},
-		{CS35L41_PWR_CTRL1,	0x00000000, 3000},
-		{CS35L41_PWR_CTRL1,	0x00000001, 3000},
-	};
 
 	pup_pdn_mask = enable ? CS35L41_PUP_DONE_MASK : CS35L41_PDN_DONE_MASK;
 
@@ -1226,6 +1269,9 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 	switch (b_type) {
 	case CS35L41_SHD_BOOST_ACTV:
 	case CS35L41_SHD_BOOST_PASS:
+		if (mdsync_up_work)
+			cancel_work_sync(mdsync_up_work);
+
 		regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
 		regmap_read(regmap, CS35L41_GPIO_PAD_CONTROL, &pad_control);
 
@@ -1243,33 +1289,27 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 		cs35l41_mdsync_down_seq[2].def = pwr_ctrl1;
 		ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_down_seq,
 					     ARRAY_SIZE(cs35l41_mdsync_down_seq));
-		if (ret || !enable)
+		if (ret)
 			break;
 
-		if (!pll_lock)
-			return -EINVAL;
-
-		ret = wait_for_completion_timeout(pll_lock, msecs_to_jiffies(1000));
-		if (ret == 0) {
-			dev_err(dev, "Timed out waiting for pll_lock\n");
-			return -ETIMEDOUT;
+		if (enable) {
+			if (mdsync_up_work) {
+				/* Call cs35l41_mdsync_up() after receiving PLL lock signal */
+				schedule_work(mdsync_up_work);
+			} else {
+				dev_err(dev, "MDSYNC UP work not provided\n");
+				ret = -EINVAL;
+			}
+			break;
 		}
 
-		regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
-		pwr_ctrl3 |= CS35L41_SYNC_EN_MASK;
-		cs35l41_mdsync_up_seq[0].def = pwr_ctrl3;
-		ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_up_seq,
-					     ARRAY_SIZE(cs35l41_mdsync_up_seq));
-		if (ret)
-			return ret;
-
 		ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1,
 					int_status, int_status & pup_pdn_mask,
 					1000, 100000);
 		if (ret)
 			dev_err(dev, "Enable(%d) failed: %d\n", enable, ret);
 
-		// Clear PUP/PDN status
+		/* Clear PUP/PDN status */
 		regmap_write(regmap, CS35L41_IRQ1_STATUS1, pup_pdn_mask);
 		break;
 	case CS35L41_INT_BOOST:
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index fe5376b3e01b..9bf70da03972 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -500,11 +500,11 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 						ARRAY_SIZE(cs35l41_pup_patch));
 
 		ret = cs35l41_global_enable(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type,
-					    1, &cs35l41->pll_lock, cs35l41->dsp.cs_dsp.running);
+					    1, &cs35l41->mdsync_up_work, cs35l41->dsp.cs_dsp.running);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		ret = cs35l41_global_enable(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type,
-					    0, &cs35l41->pll_lock, cs35l41->dsp.cs_dsp.running);
+					    0, &cs35l41->mdsync_up_work, cs35l41->dsp.cs_dsp.running);
 
 		regmap_multi_reg_write_bypassed(cs35l41->regmap,
 						cs35l41_pdn_patch,
@@ -1155,6 +1155,36 @@ static int cs35l41_acpi_get_name(struct cs35l41_private *cs35l41)
 	return 0;
 }
 
+static void cs35l41_mdsync_up_work(struct work_struct *work)
+{
+	struct cs35l41_private *cs35l41 = container_of(work,
+						       struct cs35l41_private,
+						       mdsync_up_work);
+	int ret = wait_for_completion_timeout(&cs35l41->pll_lock,
+					      msecs_to_jiffies(100));
+	if (ret == 0) {
+		dev_err(cs35l41->dev, "Timed out waiting for pll_lock signal\n");
+		return;
+	}
+
+	dev_dbg(cs35l41->dev, "Received pll_lock signal\n");
+
+	ret = pm_runtime_resume_and_get(cs35l41->dev);
+	if (ret < 0) {
+		dev_err(cs35l41->dev,
+			"pm_runtime_resume_and_get failed in %s: %d\n",
+			__func__, ret);
+		return;
+	}
+
+	ret = cs35l41_mdsync_up(cs35l41->regmap);
+	if (ret < 0)
+		dev_err(cs35l41->dev, "MDSYNC UP failed: %d\n", ret);
+
+	pm_runtime_mark_last_busy(cs35l41->dev);
+	pm_runtime_put_autosuspend(cs35l41->dev);
+}
+
 int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *hw_cfg)
 {
 	u32 regid, reg_revid, i, mtl_revid, int_status, chipid_match;
@@ -1297,6 +1327,8 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 	if (ret < 0)
 		goto err;
 
+	INIT_WORK(&cs35l41->mdsync_up_work, cs35l41_mdsync_up_work);
+
 	pm_runtime_set_autosuspend_delay(cs35l41->dev, 3000);
 	pm_runtime_use_autosuspend(cs35l41->dev);
 	pm_runtime_mark_last_busy(cs35l41->dev);
@@ -1335,6 +1367,8 @@ EXPORT_SYMBOL_GPL(cs35l41_probe);
 
 void cs35l41_remove(struct cs35l41_private *cs35l41)
 {
+	cancel_work_sync(&cs35l41->mdsync_up_work);
+
 	pm_runtime_get_sync(cs35l41->dev);
 	pm_runtime_disable(cs35l41->dev);
 
diff --git a/sound/soc/codecs/cs35l41.h b/sound/soc/codecs/cs35l41.h
index 34d967d4372b..f9f85796a13a 100644
--- a/sound/soc/codecs/cs35l41.h
+++ b/sound/soc/codecs/cs35l41.h
@@ -13,6 +13,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/firmware.h>
+#include <linux/completion.h>
 #include <sound/core.h>
 #include <sound/cs35l41.h>
 
@@ -34,6 +35,7 @@ struct cs35l41_private {
 	/* GPIO for /RST */
 	struct gpio_desc *reset_gpio;
 	struct completion pll_lock;
+	struct work_struct mdsync_up_work;
 };
 
 int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *hw_cfg);
-- 
2.41.0

