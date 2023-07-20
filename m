Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75075B019
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjGTNeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjGTNdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:33:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087982D40
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:33:08 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36K6AcqZ016432;
        Thu, 20 Jul 2023 08:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=71Ue+AeTJOkG2+Kvsu/O1eadlwmo2ik6qxqvydAx9Ng=; b=
        L8HlK93eNEWZoNq91sK7P9kU4hew5QRYzPio6LN5Uj8KJUGzXc6vJMTqLsJcMIW8
        XyU2ECO7pde3JH9pW5e92h0qRfxr8wcC2lrFlHjHGSyH0tekDur1keAlTLRVMokq
        /fb+aM9ySrAZw34Gxd0+rKA1L8TY90CcWoshTU3ZzMSKHa6FjEK6d2lsDonxhdJ0
        50UsgurgLHWdlNdAxh1hVd8t9rZ3QdXZh6iRIhHG2quIVrDBMlpW+pXE13g5zkOe
        lD4lXDrdYWCxLOENRiHAKC0aEEFKNmSr+mnzizZTETESVkeT9uNVxXgsH5rtiFHM
        z0Qj/5IiAZdXOX3iuHzMGw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gx5mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:32:10 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 14:32:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 20 Jul 2023 14:32:09 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BBC36458;
        Thu, 20 Jul 2023 13:32:08 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 01/11] ALSA: cs35l41: Use mbox command to enable speaker output for external boost
Date:   Thu, 20 Jul 2023 14:31:37 +0100
Message-ID: <20230720133147.1294337-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
References: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -kITKfyb76CisLv_UUpeods11GOy-K5D
X-Proofpoint-GUID: -kITKfyb76CisLv_UUpeods11GOy-K5D
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable the speaker output in external boost mode, 2 registers must
be set, one after another. The longer the time between the writes of
the two registers, the more likely, and more loudly a pop may occur.
To minimize this, an mbox command can be used to allow the firmware
to perform this action, minimizing any delay between write, thus
minimizing any pop or click as a result. The old method will remain
when running without firmware.

In addition, to ensure the chip has correctly powered up or down,
the driver will now poll a register, rather than wait a fixed delay.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |   5 +-
 sound/pci/hda/cs35l41_hda.c    |   9 ++-
 sound/soc/codecs/cs35l41-lib.c | 118 ++++++++++++++++++++++++++++-----
 sound/soc/codecs/cs35l41.c     |  18 ++---
 4 files changed, 115 insertions(+), 35 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 7239d943942cb..1bf757901d024 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -829,6 +829,7 @@ enum cs35l41_cspl_mbox_cmd {
 	CSPL_MBOX_CMD_STOP_PRE_REINIT = 4,
 	CSPL_MBOX_CMD_HIBERNATE = 5,
 	CSPL_MBOX_CMD_OUT_OF_HIBERNATE = 6,
+	CSPL_MBOX_CMD_SPK_OUT_ENABLE = 7,
 	CSPL_MBOX_CMD_UNKNOWN_CMD = -1,
 	CSPL_MBOX_CMD_INVALID_SEQUENCE = -2,
 };
@@ -901,7 +902,7 @@ int cs35l41_exit_hibernate(struct device *dev, struct regmap *regmap);
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg);
 bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type);
-int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable,
-			  struct completion *pll_lock);
+int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l41_boost_type b_type,
+			  int enable, struct completion *pll_lock, bool firmware_running);
 
 #endif /* __CS35L41_H */
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index ce5faa6205170..f9c97270db6f6 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -514,13 +514,15 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		mutex_lock(&cs35l41->fw_mutex);
-		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 1, NULL);
+		ret = cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1, NULL,
+					    cs35l41->firmware_running);
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLEANUP:
 		mutex_lock(&cs35l41->fw_mutex);
 		regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
-		ret = cs35l41_global_enable(reg, cs35l41->hw_cfg.bst_type, 0, NULL);
+		ret = cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0, NULL,
+					    cs35l41->firmware_running);
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
@@ -672,7 +674,8 @@ static int cs35l41_runtime_suspend(struct device *dev)
 	if (cs35l41->playback_started) {
 		regmap_multi_reg_write(cs35l41->regmap, cs35l41_hda_mute,
 				       ARRAY_SIZE(cs35l41_hda_mute));
-		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0, NULL);
+		cs35l41_global_enable(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0,
+				      NULL, cs35l41->firmware_running);
 		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
 				   CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index ac7cc492bcb05..4ec306cd2f476 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1080,28 +1080,32 @@ static const struct reg_sequence cs35l41_safe_to_reset[] = {
 	{ 0x00000040,			0x00000033 },
 };
 
-static const struct reg_sequence cs35l41_active_to_safe[] = {
+static const struct reg_sequence cs35l41_active_to_safe_start[] = {
 	{ 0x00000040,			0x00000055 },
 	{ 0x00000040,			0x000000AA },
 	{ 0x00007438,			0x00585941 },
 	{ CS35L41_PWR_CTRL1,		0x00000000 },
-	{ 0x0000742C,			0x00000009, 3000 },
+	{ 0x0000742C,			0x00000009 },
+};
+
+static const struct reg_sequence cs35l41_active_to_safe_end[] = {
 	{ 0x00007438,			0x00580941 },
 	{ 0x00000040,			0x000000CC },
 	{ 0x00000040,			0x00000033 },
 };
 
-static const struct reg_sequence cs35l41_safe_to_active[] = {
+static const struct reg_sequence cs35l41_safe_to_active_start[] = {
 	{ 0x00000040,			0x00000055 },
 	{ 0x00000040,			0x000000AA },
 	{ 0x0000742C,			0x0000000F },
 	{ 0x0000742C,			0x00000079 },
 	{ 0x00007438,			0x00585941 },
-	{ CS35L41_PWR_CTRL1,		0x00000001, 3000 }, // GLOBAL_EN = 1
+	{ CS35L41_PWR_CTRL1,		0x00000001 }, // GLOBAL_EN = 1
+};
+
+static const struct reg_sequence cs35l41_safe_to_active_en_spk[] = {
 	{ 0x0000742C,			0x000000F9 },
 	{ 0x00007438,			0x00580941 },
-	{ 0x00000040,			0x000000CC },
-	{ 0x00000040,			0x00000033 },
 };
 
 static const struct reg_sequence cs35l41_reset_to_safe[] = {
@@ -1188,11 +1192,12 @@ bool cs35l41_safe_reset(struct regmap *regmap, enum cs35l41_boost_type b_type)
 }
 EXPORT_SYMBOL_GPL(cs35l41_safe_reset);
 
-int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable,
-			  struct completion *pll_lock)
+int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l41_boost_type b_type,
+			  int enable, struct completion *pll_lock, bool firmware_running)
 {
 	int ret;
-	unsigned int gpio1_func, pad_control, pwr_ctrl1, pwr_ctrl3;
+	unsigned int gpio1_func, pad_control, pwr_ctrl1, pwr_ctrl3, int_status, pup_pdn_mask;
+	unsigned int pwr_ctl1_val;
 	struct reg_sequence cs35l41_mdsync_down_seq[] = {
 		{CS35L41_PWR_CTRL3,		0},
 		{CS35L41_GPIO_PAD_CONTROL,	0},
@@ -1204,6 +1209,20 @@ int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type,
 		{CS35L41_PWR_CTRL1,	0x00000001, 3000},
 	};
 
+	pup_pdn_mask = enable ? CS35L41_PUP_DONE_MASK : CS35L41_PDN_DONE_MASK;
+
+	ret = regmap_read(regmap, CS35L41_PWR_CTRL1, &pwr_ctl1_val);
+	if (ret)
+		return ret;
+
+	if ((pwr_ctl1_val & CS35L41_GLOBAL_EN_MASK) && enable) {
+		dev_dbg(dev, "Cannot set Global Enable - already set.\n");
+		return 0;
+	} else if (!(pwr_ctl1_val & CS35L41_GLOBAL_EN_MASK) && !enable) {
+		dev_dbg(dev, "Cannot unset Global Enable - not set.\n");
+		return 0;
+	}
+
 	switch (b_type) {
 	case CS35L41_SHD_BOOST_ACTV:
 	case CS35L41_SHD_BOOST_PASS:
@@ -1240,20 +1259,85 @@ int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type,
 			ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_up_seq,
 						     ARRAY_SIZE(cs35l41_mdsync_up_seq));
 		}
+
+		ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1,
+					int_status, int_status & pup_pdn_mask,
+					1000, 100000);
+		if (ret)
+			dev_err(dev, "Enable(%d) failed: %d\n", enable, ret);
+
+		// Clear PUP/PDN status
+		regmap_write(regmap, CS35L41_IRQ1_STATUS1, pup_pdn_mask);
 		break;
 	case CS35L41_INT_BOOST:
 		ret = regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
 					 enable << CS35L41_GLOBAL_EN_SHIFT);
-		usleep_range(3000, 3100);
+		if (ret) {
+			dev_err(dev, "CS35L41_PWR_CTRL1 set failed: %d\n", ret);
+			return ret;
+		}
+
+		ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1,
+					int_status, int_status & pup_pdn_mask,
+					1000, 100000);
+		if (ret)
+			dev_err(dev, "Enable(%d) failed: %d\n", enable, ret);
+
+		/* Clear PUP/PDN status */
+		regmap_write(regmap, CS35L41_IRQ1_STATUS1, pup_pdn_mask);
 		break;
 	case CS35L41_EXT_BOOST:
 	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
-		if (enable)
-			ret = regmap_multi_reg_write(regmap, cs35l41_safe_to_active,
-						     ARRAY_SIZE(cs35l41_safe_to_active));
-		else
-			ret = regmap_multi_reg_write(regmap, cs35l41_active_to_safe,
-						     ARRAY_SIZE(cs35l41_active_to_safe));
+		if (enable) {
+			/* Test Key is unlocked here */
+			ret = regmap_multi_reg_write(regmap, cs35l41_safe_to_active_start,
+						     ARRAY_SIZE(cs35l41_safe_to_active_start));
+			if (ret)
+				return ret;
+
+			ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1, int_status,
+				       int_status & CS35L41_PUP_DONE_MASK, 1000, 100000);
+			if (ret) {
+				dev_err(dev, "Failed waiting for CS35L41_PUP_DONE_MASK: %d\n", ret);
+				/* Lock the test key, it was unlocked during the multi_reg_write */
+				cs35l41_test_key_lock(dev, regmap);
+				return ret;
+			}
+			regmap_write(regmap, CS35L41_IRQ1_STATUS1, CS35L41_PUP_DONE_MASK);
+
+			if (firmware_running)
+				ret = cs35l41_set_cspl_mbox_cmd(dev, regmap,
+								CSPL_MBOX_CMD_SPK_OUT_ENABLE);
+			else
+				ret = regmap_multi_reg_write(regmap, cs35l41_safe_to_active_en_spk,
+							ARRAY_SIZE(cs35l41_safe_to_active_en_spk));
+
+			/* Lock the test key, it was unlocked during the multi_reg_write */
+			cs35l41_test_key_lock(dev, regmap);
+		} else {
+			/* Test Key is unlocked here */
+			ret = regmap_multi_reg_write(regmap, cs35l41_active_to_safe_start,
+						     ARRAY_SIZE(cs35l41_active_to_safe_start));
+			if (ret) {
+				/* Lock the test key, it was unlocked during the multi_reg_write */
+				cs35l41_test_key_lock(dev, regmap);
+				return ret;
+			}
+
+			ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1, int_status,
+				       int_status & CS35L41_PDN_DONE_MASK, 1000, 100000);
+			if (ret) {
+				dev_err(dev, "Failed waiting for CS35L41_PDN_DONE_MASK: %d\n", ret);
+				/* Lock the test key, it was unlocked during the multi_reg_write */
+				cs35l41_test_key_lock(dev, regmap);
+				return ret;
+			}
+			regmap_write(regmap, CS35L41_IRQ1_STATUS1, CS35L41_PDN_DONE_MASK);
+
+			/* Test Key is locked here */
+			ret = regmap_multi_reg_write(regmap, cs35l41_active_to_safe_end,
+						     ARRAY_SIZE(cs35l41_active_to_safe_end));
+		}
 		break;
 	default:
 		ret = -EINVAL;
@@ -1344,6 +1428,8 @@ static bool cs35l41_check_cspl_mbox_sts(enum cs35l41_cspl_mbox_cmd cmd,
 		return (sts == CSPL_MBOX_STS_RUNNING);
 	case CSPL_MBOX_CMD_STOP_PRE_REINIT:
 		return (sts == CSPL_MBOX_STS_RDY_FOR_REINIT);
+	case CSPL_MBOX_CMD_SPK_OUT_ENABLE:
+		return (sts == CSPL_MBOX_STS_RUNNING);
 	default:
 		return false;
 	}
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 6ac501f008eca..2b3c36f02edb0 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -491,7 +491,6 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(component);
-	unsigned int val;
 	int ret = 0;
 
 	switch (event) {
@@ -500,21 +499,12 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 						cs35l41_pup_patch,
 						ARRAY_SIZE(cs35l41_pup_patch));
 
-		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 1,
-				      &cs35l41->pll_lock);
+		ret = cs35l41_global_enable(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type,
+					    1, &cs35l41->pll_lock, cs35l41->dsp.cs_dsp.running);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		cs35l41_global_enable(cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0,
-				      &cs35l41->pll_lock);
-
-		ret = regmap_read_poll_timeout(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-					       val, val &  CS35L41_PDN_DONE_MASK,
-					       1000, 100000);
-		if (ret)
-			dev_warn(cs35l41->dev, "PDN failed: %d\n", ret);
-
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_PDN_DONE_MASK);
+		ret = cs35l41_global_enable(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type,
+					    0, &cs35l41->pll_lock, cs35l41->dsp.cs_dsp.running);
 
 		regmap_multi_reg_write_bypassed(cs35l41->regmap,
 						cs35l41_pdn_patch,
-- 
2.34.1

