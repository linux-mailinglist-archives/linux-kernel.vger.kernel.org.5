Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE33175CB68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjGUPUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGUPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:19:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD156359D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:18:56 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36LDppwi011284;
        Fri, 21 Jul 2023 10:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=6htBMhHwj6gHU0mx/GgD15mWotyiSXVnHy5RczqhQbw=; b=
        gkno3kyfKSuuCzCpcQJizpooBigMV5QY1GJ30dfBl5M9KJZTK8XlPFhakVGJreqZ
        glVPAkaAzr+EaQL4nf8/tifwXur7RXebRERJYpLnXtIYVI3frwNbQqAmIyhnYzH5
        RM+UOQx3+t+s2C20t/xCzc/o/MeY/fZkeISrrdC+/xoZ707Q7wBHT/ySJac1g/FX
        ZVAc2wGz8xE4J+EeseRBEacf8NzRLRkIwNiS8NV1+NUN+q8ju1gGSz77RuNwk0A6
        pTvGQd8p8nNYQRPJyzszb2A9GwCPxxPr5QsQKqIVSkJ7Jrvr1NJm7zQ96JQpAAZj
        2ZdnGDs10e0e8Ii9uV9ScA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62y8g5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 10:18:29 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 16:18:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 21 Jul 2023 16:18:26 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DDD7D46B;
        Fri, 21 Jul 2023 15:18:25 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 02/11] ALSA: cs35l41: Poll for Power Up/Down rather than waiting a fixed delay
Date:   Fri, 21 Jul 2023 16:18:07 +0100
Message-ID: <20230721151816.2080453-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721151816.2080453-1-sbinding@opensource.cirrus.com>
References: <20230721151816.2080453-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dUUCfRjOaN0TwyC1azONr9ZeWTV34YmQ
X-Proofpoint-ORIG-GUID: dUUCfRjOaN0TwyC1azONr9ZeWTV34YmQ
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

To ensure the chip has correctly powered up or down before continuing,
the driver will now poll a register, rather than wait a fixed delay.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41-lib.c | 48 +++++++++++++++++++++++++++++++---
 sound/soc/codecs/cs35l41.c     | 10 -------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index ce3f475023756..4ec306cd2f476 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1196,7 +1196,8 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 			  int enable, struct completion *pll_lock, bool firmware_running)
 {
 	int ret;
-	unsigned int gpio1_func, pad_control, pwr_ctrl1, pwr_ctrl3, int_status;
+	unsigned int gpio1_func, pad_control, pwr_ctrl1, pwr_ctrl3, int_status, pup_pdn_mask;
+	unsigned int pwr_ctl1_val;
 	struct reg_sequence cs35l41_mdsync_down_seq[] = {
 		{CS35L41_PWR_CTRL3,		0},
 		{CS35L41_GPIO_PAD_CONTROL,	0},
@@ -1208,6 +1209,12 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 		{CS35L41_PWR_CTRL1,	0x00000001, 3000},
 	};
 
+	pup_pdn_mask = enable ? CS35L41_PUP_DONE_MASK : CS35L41_PDN_DONE_MASK;
+
+	ret = regmap_read(regmap, CS35L41_PWR_CTRL1, &pwr_ctl1_val);
+	if (ret)
+		return ret;
+
 	if ((pwr_ctl1_val & CS35L41_GLOBAL_EN_MASK) && enable) {
 		dev_dbg(dev, "Cannot set Global Enable - already set.\n");
 		return 0;
@@ -1252,6 +1259,15 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
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
@@ -1260,7 +1276,15 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 			dev_err(dev, "CS35L41_PWR_CTRL1 set failed: %d\n", ret);
 			return ret;
 		}
-		usleep_range(3000, 3100);
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
@@ -1271,7 +1295,15 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 			if (ret)
 				return ret;
 
-			usleep_range(3000, 3100);
+			ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1, int_status,
+				       int_status & CS35L41_PUP_DONE_MASK, 1000, 100000);
+			if (ret) {
+				dev_err(dev, "Failed waiting for CS35L41_PUP_DONE_MASK: %d\n", ret);
+				/* Lock the test key, it was unlocked during the multi_reg_write */
+				cs35l41_test_key_lock(dev, regmap);
+				return ret;
+			}
+			regmap_write(regmap, CS35L41_IRQ1_STATUS1, CS35L41_PUP_DONE_MASK);
 
 			if (firmware_running)
 				ret = cs35l41_set_cspl_mbox_cmd(dev, regmap,
@@ -1292,7 +1324,15 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 				return ret;
 			}
 
-			usleep_range(3000, 3100);
+			ret = regmap_read_poll_timeout(regmap, CS35L41_IRQ1_STATUS1, int_status,
+				       int_status & CS35L41_PDN_DONE_MASK, 1000, 100000);
+			if (ret) {
+				dev_err(dev, "Failed waiting for CS35L41_PDN_DONE_MASK: %d\n", ret);
+				/* Lock the test key, it was unlocked during the multi_reg_write */
+				cs35l41_test_key_lock(dev, regmap);
+				return ret;
+			}
+			regmap_write(regmap, CS35L41_IRQ1_STATUS1, CS35L41_PDN_DONE_MASK);
 
 			/* Test Key is locked here */
 			ret = regmap_multi_reg_write(regmap, cs35l41_active_to_safe_end,
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index d4e9c9d9b50a6..2b3c36f02edb0 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -491,7 +491,6 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct cs35l41_private *cs35l41 = snd_soc_component_get_drvdata(component);
-	unsigned int val;
 	int ret = 0;
 
 	switch (event) {
@@ -507,15 +506,6 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 		ret = cs35l41_global_enable(cs35l41->dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type,
 					    0, &cs35l41->pll_lock, cs35l41->dsp.cs_dsp.running);
 
-		ret = regmap_read_poll_timeout(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-					       val, val &  CS35L41_PDN_DONE_MASK,
-					       1000, 100000);
-		if (ret)
-			dev_warn(cs35l41->dev, "PDN failed: %d\n", ret);
-
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_PDN_DONE_MASK);
-
 		regmap_multi_reg_write_bypassed(cs35l41->regmap,
 						cs35l41_pdn_patch,
 						ARRAY_SIZE(cs35l41_pdn_patch));
-- 
2.34.1

