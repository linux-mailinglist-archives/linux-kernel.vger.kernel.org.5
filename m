Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695C475CB6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGUPUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjGUPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:19:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C8935B8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:18:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36LDppwn011284;
        Fri, 21 Jul 2023 10:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=bf5LPR1X7g9IbS0pw4I5MglPP8kBfPeDlXd9XwzFREY=; b=
        SdadVdaDArBl29qpApaVUy4TQO9AkJ3ITo5qmRq7bLXZtLDxx1Y7ai678TF3HYnc
        7z46l+NrI4bHVqfdrj4+UzTD6ROtgj6Y6AGBNHAs04QVbBZJsNq4oaAVNJGuXwxi
        /x0yIrGvMhgvKCqOblHDIG5Q6R8KvHIzS/zCcfFafQlYhGZYlTBH86D7cqd8XECk
        QucKVtzhnBzBAWlrKzzoM1w30+dAQU42opuvfpDlw5nG3NsjkFUwOqIq3HYT+RWT
        sl9IqqT+vQY2XCZHIrcysdjKqt1YOO9lZ3HxK84BFM923WOIwVYqEwhuiDz4qhzq
        Cwi2tktEI7sToZIz5cm6xA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62y8g5-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 10:18:32 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 16:18:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 21 Jul 2023 16:18:27 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EEDD4356D;
        Fri, 21 Jul 2023 15:18:26 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 06/11] ALSA: hda: cs35l41: Move Play and Pause into separate functions
Date:   Fri, 21 Jul 2023 16:18:11 +0100
Message-ID: <20230721151816.2080453-7-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721151816.2080453-1-sbinding@opensource.cirrus.com>
References: <20230721151816.2080453-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PySARjVG6RGjMYiIcFNDCftZ0Int-6XR
X-Proofpoint-ORIG-GUID: PySARjVG6RGjMYiIcFNDCftZ0Int-6XR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows play and pause to be called from multiple places,
which is necessary for system suspend and resume.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 131 ++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 52 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d4a11f7b5dbd1..f77583b46b6b0 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -483,63 +483,103 @@ static void cs35l41_irq_release(struct cs35l41_hda *cs35l41)
 	cs35l41->irq_errors = 0;
 }
 
-static void cs35l41_hda_playback_hook(struct device *dev, int action)
+static void cs35l41_hda_play_start(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 	struct regmap *reg = cs35l41->regmap;
-	int ret = 0;
+
+	dev_dbg(dev, "Play (Start)\n");
+
+	if (cs35l41->playback_started) {
+		dev_dbg(dev, "Playback already started.");
+		return;
+	}
+
+	cs35l41->playback_started = true;
+
+	if (cs35l41->firmware_running) {
+		regmap_multi_reg_write(reg, cs35l41_hda_config_dsp,
+				       ARRAY_SIZE(cs35l41_hda_config_dsp));
+		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
+				   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
+				   1 << CS35L41_VMON_EN_SHIFT | 1 << CS35L41_IMON_EN_SHIFT);
+		cs35l41_set_cspl_mbox_cmd(cs35l41->dev, reg, CSPL_MBOX_CMD_RESUME);
+	} else {
+		regmap_multi_reg_write(reg, cs35l41_hda_config, ARRAY_SIZE(cs35l41_hda_config));
+	}
+	regmap_update_bits(reg, CS35L41_PWR_CTRL2, CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
+		regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00008001);
+
+}
+
+static void cs35l41_hda_play_done(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	struct regmap *reg = cs35l41->regmap;
+
+	dev_dbg(dev, "Play (Complete)\n");
+
+	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1, NULL,
+			      cs35l41->firmware_running);
+}
+
+static void cs35l41_hda_pause_start(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	struct regmap *reg = cs35l41->regmap;
+
+	dev_dbg(dev, "Pause (Start)\n");
+
+	regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
+	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0, NULL,
+			      cs35l41->firmware_running);
+}
+
+static void cs35l41_hda_pause_done(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	struct regmap *reg = cs35l41->regmap;
+
+	dev_dbg(dev, "Pause (Complete)\n");
+
+	regmap_update_bits(reg, CS35L41_PWR_CTRL2, CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
+		regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00000001);
+	if (cs35l41->firmware_running) {
+		cs35l41_set_cspl_mbox_cmd(dev, reg, CSPL_MBOX_CMD_PAUSE);
+		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
+				   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
+				   0 << CS35L41_VMON_EN_SHIFT | 0 << CS35L41_IMON_EN_SHIFT);
+	}
+	cs35l41_irq_release(cs35l41);
+	cs35l41->playback_started = false;
+}
+
+static void cs35l41_hda_playback_hook(struct device *dev, int action)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
 		pm_runtime_get_sync(dev);
 		mutex_lock(&cs35l41->fw_mutex);
-		cs35l41->playback_started = true;
-		if (cs35l41->firmware_running) {
-			regmap_multi_reg_write(reg, cs35l41_hda_config_dsp,
-					       ARRAY_SIZE(cs35l41_hda_config_dsp));
-			regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-					   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
-					   1 << CS35L41_VMON_EN_SHIFT | 1 << CS35L41_IMON_EN_SHIFT);
-			cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap,
-						  CSPL_MBOX_CMD_RESUME);
-		} else {
-			regmap_multi_reg_write(reg, cs35l41_hda_config,
-					       ARRAY_SIZE(cs35l41_hda_config));
-		}
-		ret = regmap_update_bits(reg, CS35L41_PWR_CTRL2,
-					 CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
-		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
-			regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00008001);
+		cs35l41_hda_play_start(dev);
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		mutex_lock(&cs35l41->fw_mutex);
-		ret = cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1, NULL,
-					    cs35l41->firmware_running);
+		cs35l41_hda_play_done(dev);
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLEANUP:
 		mutex_lock(&cs35l41->fw_mutex);
-		regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
-		ret = cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0, NULL,
-					    cs35l41->firmware_running);
+		cs35l41_hda_pause_start(dev);
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
 		mutex_lock(&cs35l41->fw_mutex);
-		ret = regmap_update_bits(reg, CS35L41_PWR_CTRL2,
-					 CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
-		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
-			regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00000001);
-		if (cs35l41->firmware_running) {
-			cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap,
-						  CSPL_MBOX_CMD_PAUSE);
-			regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-					   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
-					   0 << CS35L41_VMON_EN_SHIFT | 0 << CS35L41_IMON_EN_SHIFT);
-		}
-		cs35l41_irq_release(cs35l41);
-		cs35l41->playback_started = false;
+		cs35l41_hda_pause_done(dev);
 		mutex_unlock(&cs35l41->fw_mutex);
 
 		pm_runtime_mark_last_busy(dev);
@@ -549,9 +589,6 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		dev_warn(cs35l41->dev, "Playback action not supported: %d\n", action);
 		break;
 	}
-
-	if (ret)
-		dev_err(cs35l41->dev, "Regmap access fail: %d\n", ret);
 }
 
 static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsigned int *tx_slot,
@@ -703,18 +740,8 @@ static int cs35l41_runtime_suspend(struct device *dev)
 	mutex_lock(&cs35l41->fw_mutex);
 
 	if (cs35l41->playback_started) {
-		regmap_multi_reg_write(cs35l41->regmap, cs35l41_hda_mute,
-				       ARRAY_SIZE(cs35l41_hda_mute));
-		cs35l41_global_enable(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type, 0,
-				      NULL, cs35l41->firmware_running);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
-		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
-			regmap_write(cs35l41->regmap, CS35L41_GPIO1_CTRL1, 0x00000001);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
-				   0 << CS35L41_VMON_EN_SHIFT | 0 << CS35L41_IMON_EN_SHIFT);
-		cs35l41->playback_started = false;
+		cs35l41_hda_pause_start(dev);
+		cs35l41_hda_pause_done(dev);
 	}
 
 	if (cs35l41->firmware_running) {
-- 
2.34.1

